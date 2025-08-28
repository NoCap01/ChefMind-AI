import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../application/providers/nutrition_provider.dart';
import '../../../../domain/entities/nutrition_tracking.dart';
import '../../../../shared/widgets/loading_indicator.dart';
import '../widgets/nutrition_progress_card.dart';
import '../widgets/daily_nutrition_chart.dart';
import '../widgets/micronutrient_analysis_widget.dart';
import '../widgets/nutrition_goals_widget.dart';
import '../widgets/food_entry_widget.dart';

class NutritionTrackingScreen extends ConsumerStatefulWidget {
  const NutritionTrackingScreen({super.key});

  @override
  ConsumerState<NutritionTrackingScreen> createState() => _NutritionTrackingScreenState();
}

class _NutritionTrackingScreenState extends ConsumerState<NutritionTrackingScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final nutritionState = ref.watch(nutritionStateProvider);
    final currentDate = ref.watch(currentTrackingDateProvider);
    final currentEntry = ref.watch(currentNutritionEntryProvider);
    final activeGoal = ref.watch(activeNutritionGoalProvider);
    final dailyProgress = ref.watch(dailyNutritionProgressProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nutrition Tracking'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.today), text: 'Today'),
            Tab(icon: Icon(Icons.analytics), text: 'Progress'),
            Tab(icon: Icon(Icons.science), text: 'Analysis'),
            Tab(icon: Icon(Icons.flag), text: 'Goals'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () => _selectDate(context),
          ),
        ],
      ),
      body: nutritionState.isLoading
          ? const Center(child: LoadingIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                _buildTodayTab(currentEntry, dailyProgress, activeGoal),
                _buildProgressTab(),
                _buildAnalysisTab(),
                _buildGoalsTab(activeGoal, nutritionState.goals),
              ],
            ),
      floatingActionButton: _tabController.index == 0
          ? FloatingActionButton(
              onPressed: () => _showAddFoodDialog(context, currentDate),
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  Widget _buildTodayTab(
    NutritionEntry? currentEntry,
    NutritionProgress? dailyProgress,
    NutritionGoal? activeGoal,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date Header
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today),
                  const SizedBox(width: 8),
                  Text(
                    DateFormat('EEEE, MMMM d, y').format(ref.watch(currentTrackingDateProvider)),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Daily Progress Overview
          if (dailyProgress != null && activeGoal != null)
            NutritionProgressCard(
              progress: dailyProgress,
              goal: activeGoal,
            ),
          const SizedBox(height: 16),

          // Daily Nutrition Chart
          if (currentEntry != null)
            DailyNutritionChart(
              entry: currentEntry,
              goals: activeGoal?.targets,
            ),
          const SizedBox(height: 16),

          // Food Entries
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Food Entries',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  if (currentEntry?.foods.isEmpty ?? true)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32),
                        child: Text('No food entries for today'),
                      ),
                    )
                  else
                    ...currentEntry!.foods.map((food) => FoodEntryWidget(
                      foodEntry: food,
                      onEdit: () => _editFoodEntry(food),
                      onDelete: () => _deleteFoodEntry(food),
                    )),
                ],
              ),
            ),
          ),

          // Water Intake
          const SizedBox(height: 16),
          _buildWaterIntakeCard(currentEntry?.waterIntakeMl ?? 0),

          // Exercise Calories
          const SizedBox(height: 16),
          _buildExerciseCaloriesCard(currentEntry?.exerciseCaloriesBurned ?? 0),
        ],
      ),
    );
  }

  Widget _buildProgressTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Weekly Progress
          Consumer(
            builder: (context, ref, child) {
              final weekStart = DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));
              final weeklyProgress = ref.watch(nutritionProgressProvider(
                DateRange(start: weekStart, end: DateTime.now()),
              ));

              return weeklyProgress.when(
                data: (progress) => progress != null
                    ? _buildWeeklyProgressCard(progress)
                    : const Card(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Text('No progress data available'),
                        ),
                      ),
                loading: () => const LoadingIndicator(),
                error: (error, stack) => Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text('Error loading progress: $error'),
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 16),

          // Nutrition Streaks
          Consumer(
            builder: (context, ref, child) {
              final streaks = ref.watch(nutritionStreaksProvider);
              return streaks.when(
                data: (streakData) => streakData != null
                    ? _buildStreaksCard(streakData)
                    : const SizedBox.shrink(),
                loading: () => const LoadingIndicator(),
                error: (error, stack) => const SizedBox.shrink(),
              );
            },
          ),

          const SizedBox(height: 16),

          // Insights
          Consumer(
            builder: (context, ref, child) {
              final insights = ref.watch(nutritionInsightsProvider);
              return insights.when(
                data: (insightList) => _buildInsightsCard(insightList),
                loading: () => const LoadingIndicator(),
                error: (error, stack) => const SizedBox.shrink(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAnalysisTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Micronutrient Analysis
          Consumer(
            builder: (context, ref, child) {
              final analysis = ref.watch(micronutrientAnalysisProvider(7));
              return analysis.when(
                data: (analysisData) => analysisData != null
                    ? MicronutrientAnalysisWidget(analysis: analysisData)
                    : const Card(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Text('No micronutrient data available'),
                        ),
                      ),
                loading: () => const LoadingIndicator(),
                error: (error, stack) => Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text('Error loading analysis: $error'),
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 16),

          // Dietary Validation
          _buildDietaryValidationCard(),
        ],
      ),
    );
  }

  Widget _buildGoalsTab(NutritionGoal? activeGoal, List<NutritionGoal> allGoals) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          NutritionGoalsWidget(
            activeGoal: activeGoal,
            allGoals: allGoals,
            onCreateGoal: _createNutritionGoal,
            onUpdateGoal: _updateNutritionGoal,
            onSetActive: _setActiveGoal,
            onDeleteGoal: _deleteNutritionGoal,
          ),
        ],
      ),
    );
  }

  Widget _buildWaterIntakeCard(double currentIntake) {
    const dailyGoal = 2500.0; // ml
    final progress = (currentIntake / dailyGoal).clamp(0.0, 1.0);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.water_drop, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  'Water Intake',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                TextButton(
                  onPressed: () => _updateWaterIntake(currentIntake),
                  child: const Text('Update'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            const SizedBox(height: 8),
            Text(
              '${currentIntake.toInt()} / ${dailyGoal.toInt()} ml',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseCaloriesCard(double currentCalories) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.fitness_center, color: Colors.orange),
                const SizedBox(width: 8),
                Text(
                  'Exercise Calories',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                TextButton(
                  onPressed: () => _updateExerciseCalories(currentCalories),
                  child: const Text('Update'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '${currentCalories.toInt()} calories burned',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeeklyProgressCard(NutritionProgressSummary progress) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Weekly Progress',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Text(
              'Overall Progress: ${progress.overallProgress.toStringAsFixed(1)}%',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progress.overallProgress / 100,
              backgroundColor: Colors.grey[300],
            ),
            const SizedBox(height: 16),
            ...progress.insights.map((insight) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  const Icon(Icons.lightbulb, size: 16, color: Colors.amber),
                  const SizedBox(width: 8),
                  Expanded(child: Text(insight)),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildStreaksCard(NutritionStreaks streaks) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tracking Streaks',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStreakStat(
                    'Current Streak',
                    '${streaks.currentStreak} days',
                    Icons.local_fire_department,
                    Colors.orange,
                  ),
                ),
                Expanded(
                  child: _buildStreakStat(
                    'Longest Streak',
                    '${streaks.longestStreak} days',
                    Icons.emoji_events,
                    Colors.amber,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Consistency: ${streaks.consistencyPercentage.toStringAsFixed(1)}%',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStreakStat(String title, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 32),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildInsightsCard(List<NutritionInsight> insights) {
    if (insights.isEmpty) return const SizedBox.shrink();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nutrition Insights',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            ...insights.take(3).map((insight) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: Icon(
                  _getInsightIcon(insight.type),
                  color: _getInsightColor(insight.priority),
                ),
                title: Text(insight.title),
                subtitle: Text(insight.description),
                dense: true,
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildDietaryValidationCard() {
    final currentEntry = ref.watch(currentNutritionEntryProvider);
    if (currentEntry == null || currentEntry.foods.isEmpty) {
      return const SizedBox.shrink();
    }

    // Mock dietary restrictions for demo
    const restrictions = [DietaryRestriction.vegetarian];
    const allergies = <String>[];

    return Consumer(
      builder: (context, ref, child) {
        final validation = ref.watch(dietaryValidationProvider(
          DietaryValidationRequest(
            foods: currentEntry.foods,
            restrictions: restrictions,
            allergies: allergies,
          ),
        ));

        return validation.when(
          data: (validationData) => validationData != null
              ? Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dietary Compliance',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              validationData.isValid ? Icons.check_circle : Icons.warning,
                              color: validationData.isValid ? Colors.green : Colors.orange,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              validationData.isValid ? 'All good!' : 'Issues found',
                              style: TextStyle(
                                color: validationData.isValid ? Colors.green : Colors.orange,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            Text('${validationData.complianceScore.toStringAsFixed(0)}%'),
                          ],
                        ),
                        if (validationData.violations.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          ...validationData.violations.map((violation) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Text(
                              '• ${violation.foodName}: ${violation.reason}',
                              style: const TextStyle(color: Colors.red),
                            ),
                          )),
                        ],
                      ],
                    ),
                  ),
                )
              : const SizedBox.shrink(),
          loading: () => const LoadingIndicator(),
          error: (error, stack) => const SizedBox.shrink(),
        );
      },
    );
  }

  IconData _getInsightIcon(InsightType type) {
    switch (type) {
      case InsightType.pattern:
        return Icons.trending_up;
      case InsightType.deficiency:
        return Icons.warning;
      case InsightType.excess:
        return Icons.error;
      case InsightType.trend:
        return Icons.analytics;
      case InsightType.achievement:
        return Icons.emoji_events;
      case InsightType.warning:
        return Icons.priority_high;
    }
  }

  Color _getInsightColor(InsightPriority priority) {
    switch (priority) {
      case InsightPriority.low:
        return Colors.blue;
      case InsightPriority.medium:
        return Colors.orange;
      case InsightPriority.high:
        return Colors.red;
      case InsightPriority.critical:
        return Colors.red[900]!;
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: ref.read(currentTrackingDateProvider),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
    );

    if (date != null) {
      ref.read(currentTrackingDateProvider.notifier).state = date;
    }
  }

  void _showAddFoodDialog(BuildContext context, DateTime date) {
    // Implementation for adding food entry
    // This would show a dialog or navigate to a food search screen
  }

  void _editFoodEntry(FoodEntry food) {
    // Implementation for editing food entry
  }

  void _deleteFoodEntry(FoodEntry food) {
    // Implementation for deleting food entry
  }

  void _updateWaterIntake(double currentIntake) {
    // Implementation for updating water intake
  }

  void _updateExerciseCalories(double currentCalories) {
    // Implementation for updating exercise calories
  }

  void _createNutritionGoal() {
    // Implementation for creating nutrition goal
  }

  void _updateNutritionGoal(NutritionGoal goal) {
    // Implementation for updating nutrition goal
  }

  void _setActiveGoal(String goalId) {
    ref.read(nutritionStateProvider.notifier).setActiveNutritionGoal(goalId);
  }

  void _deleteNutritionGoal(String goalId) {
    ref.read(nutritionStateProvider.notifier).deleteNutritionGoal(goalId);
  }
}