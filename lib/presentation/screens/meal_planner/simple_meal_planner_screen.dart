import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/common/themed_screen_wrapper.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../domain/entities/recipe.dart';
import '../../../domain/enums/meal_type.dart';
import '../../../application/providers/recipe_book_provider.dart';
import '../../../core/services/simple_persistence_service.dart';

// Simple meal plan data structure
class MealPlan {
  final String id;
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final Map<String, Map<String, Recipe?>> meals; // date -> mealType -> recipe
  final bool isActive;

  MealPlan({
    required this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.meals,
    this.isActive = true,
  });

  MealPlan copyWith({
    String? id,
    String? name,
    DateTime? startDate,
    DateTime? endDate,
    Map<String, Map<String, Recipe?>>? meals,
    bool? isActive,
  }) {
    return MealPlan(
      id: id ?? this.id,
      name: name ?? this.name,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      meals: meals ?? this.meals,
      isActive: isActive ?? this.isActive,
    );
  }
}

// Simple meal planner state
class MealPlannerState {
  final MealPlan? activePlan;
  final DateTime selectedDate;
  final bool isLoading;
  final String? error;

  MealPlannerState({
    this.activePlan,
    required this.selectedDate,
    this.isLoading = false,
    this.error,
  });

  MealPlannerState copyWith({
    MealPlan? activePlan,
    DateTime? selectedDate,
    bool? isLoading,
    String? error,
  }) {
    return MealPlannerState(
      activePlan: activePlan ?? this.activePlan,
      selectedDate: selectedDate ?? this.selectedDate,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

// Simple meal planner notifier with persistence
class MealPlannerNotifier extends StateNotifier<MealPlannerState> {
  MealPlannerNotifier()
      : super(MealPlannerState(selectedDate: DateTime.now())) {
    _loadPersistedData();
  }

  Future<void> _loadPersistedData() async {
    try {
      final data = await SimplePersistenceService.loadMealPlan();
      if (data != null) {
        final mealPlan = MealPlan(
          id: data['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
          name: data['name'] ?? 'My Meal Plan',
          startDate: DateTime.parse(
              data['startDate'] ?? DateTime.now().toIso8601String()),
          endDate: DateTime.parse(data['endDate'] ??
              DateTime.now().add(const Duration(days: 6)).toIso8601String()),
          meals: _parseMeals(data['meals'] ?? {}),
          isActive: data['isActive'] ?? true,
        );
        state = state.copyWith(activePlan: mealPlan);
      }
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> _saveData() async {
    try {
      final currentPlan = state.activePlan;
      if (currentPlan != null) {
        final data = {
          'id': currentPlan.id,
          'name': currentPlan.name,
          'startDate': currentPlan.startDate.toIso8601String(),
          'endDate': currentPlan.endDate.toIso8601String(),
          'meals': _serializeMeals(currentPlan.meals),
          'isActive': currentPlan.isActive,
        };
        await SimplePersistenceService.saveMealPlan(data);
      }
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Map<String, Map<String, Recipe?>> _parseMeals(
      Map<String, dynamic> mealsData) {
    final meals = <String, Map<String, Recipe?>>{};
    mealsData.forEach((date, mealMap) {
      meals[date] = <String, Recipe?>{};
      if (mealMap is Map<String, dynamic>) {
        mealMap.forEach((mealType, recipeData) {
          meals[date]![mealType] =
              null; // For now, we'll just store null recipes
        });
      }
    });
    return meals;
  }

  Map<String, Map<String, String?>> _serializeMeals(
      Map<String, Map<String, Recipe?>> meals) {
    final serialized = <String, Map<String, String?>>{};
    meals.forEach((date, mealMap) {
      serialized[date] = <String, String?>{};
      mealMap.forEach((mealType, recipe) {
        serialized[date]![mealType] = recipe?.id;
      });
    });
    return serialized;
  }

  void selectDate(DateTime date) {
    state = state.copyWith(selectedDate: date);
  }

  void createMealPlan(String name, DateTime startDate, DateTime endDate) {
    state = state.copyWith(isLoading: true);

    // Create empty meal plan
    final meals = <String, Map<String, Recipe?>>{};
    for (var date = startDate;
        date.isBefore(endDate.add(const Duration(days: 1)));
        date = date.add(const Duration(days: 1))) {
      final dateKey = _formatDateKey(date);
      meals[dateKey] = {
        'breakfast': null,
        'lunch': null,
        'dinner': null,
        'snack': null,
      };
    }

    final mealPlan = MealPlan(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      startDate: startDate,
      endDate: endDate,
      meals: meals,
    );

    state = state.copyWith(
      activePlan: mealPlan,
      isLoading: false,
    );

    _saveData();
  }

  void assignMealToSlot(DateTime date, String mealType, Recipe recipe) {
    final currentPlan = state.activePlan;
    if (currentPlan == null) return;

    final dateKey = _formatDateKey(date);
    final updatedMeals =
        Map<String, Map<String, Recipe?>>.from(currentPlan.meals);

    if (!updatedMeals.containsKey(dateKey)) {
      updatedMeals[dateKey] = {
        'breakfast': null,
        'lunch': null,
        'dinner': null,
        'snack': null,
      };
    }

    updatedMeals[dateKey]![mealType] = recipe;

    final updatedPlan = currentPlan.copyWith(meals: updatedMeals);
    state = state.copyWith(activePlan: updatedPlan);
    _saveData();
  }

  void removeMealFromSlot(DateTime date, String mealType) {
    final currentPlan = state.activePlan;
    if (currentPlan == null) return;

    final dateKey = _formatDateKey(date);
    final updatedMeals =
        Map<String, Map<String, Recipe?>>.from(currentPlan.meals);

    if (updatedMeals.containsKey(dateKey)) {
      updatedMeals[dateKey]![mealType] = null;
    }

    final updatedPlan = currentPlan.copyWith(meals: updatedMeals);
    state = state.copyWith(activePlan: updatedPlan);
    _saveData();
  }

  void autoGenerateMealPlan(String name, DateTime startDate, DateTime endDate,
      List<Recipe> availableRecipes) {
    state = state.copyWith(isLoading: true);

    if (availableRecipes.isEmpty) {
      state = state.copyWith(
        isLoading: false,
        error: 'No recipes available for meal planning',
      );
      return;
    }

    // Create meal plan with auto-assigned recipes
    final meals = <String, Map<String, Recipe?>>{};
    final mealTypes = ['breakfast', 'lunch', 'dinner'];
    int recipeIndex = 0;

    for (var date = startDate;
        date.isBefore(endDate.add(const Duration(days: 1)));
        date = date.add(const Duration(days: 1))) {
      final dateKey = _formatDateKey(date);
      meals[dateKey] = {};

      for (final mealType in mealTypes) {
        final recipe = availableRecipes[recipeIndex % availableRecipes.length];
        meals[dateKey]![mealType] = recipe;
        recipeIndex++;
      }

      // Add snack occasionally
      if (date.weekday % 3 == 0 && availableRecipes.length > 3) {
        meals[dateKey]!['snack'] =
            availableRecipes[recipeIndex % availableRecipes.length];
        recipeIndex++;
      } else {
        meals[dateKey]!['snack'] = null;
      }
    }

    final mealPlan = MealPlan(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      startDate: startDate,
      endDate: endDate,
      meals: meals,
    );

    state = state.copyWith(
      activePlan: mealPlan,
      isLoading: false,
      error: null,
    );

    _saveData();
  }

  String _formatDateKey(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}

// Provider
final mealPlannerProvider =
    StateNotifierProvider<MealPlannerNotifier, MealPlannerState>((ref) {
  return MealPlannerNotifier();
});

class SimpleMealPlannerScreen extends ConsumerStatefulWidget {
  const SimpleMealPlannerScreen({super.key});

  @override
  ConsumerState<SimpleMealPlannerScreen> createState() =>
      _SimpleMealPlannerScreenState();
}

class _SimpleMealPlannerScreenState
    extends ConsumerState<SimpleMealPlannerScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // Rebuild to update toggle visual state
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final mealPlannerState = ref.watch(mealPlannerProvider);

    return ThemedScreenWrapper(
      title: 'Meal Planner',
      enablePullToRefresh: true,
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Meal planner refreshed!')),
          );
        }
      },
      actions: [
        IconButton(
          icon: const Icon(Icons.auto_awesome),
          onPressed: () => _showAutoGenerateDialog(),
          tooltip: 'Auto Plan Week',
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => _showCreatePlanDialog(),
          tooltip: 'New Plan',
        ),
      ],
      child: mealPlannerState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : mealPlannerState.error != null
              ? _buildErrorView(mealPlannerState.error!, isDark)
              : Column(
                  children: [
                    // Custom toggle slider for view switching
                    Container(
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.grey.shade800.withOpacity(0.8)
                            : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isDark
                              ? Colors.grey.shade600.withOpacity(0.3)
                              : Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => _tabController.animateTo(0),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeInOut,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 16,
                                ),
                                decoration: BoxDecoration(
                                  color: _tabController.index == 0
                                      ? theme.colorScheme.primary
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: _tabController.index == 0
                                      ? [
                                          BoxShadow(
                                            color: theme.colorScheme.primary
                                                .withOpacity(0.3),
                                            blurRadius: 8,
                                            offset: const Offset(0, 2),
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.calendar_view_week,
                                      size: 20,
                                      color: _tabController.index == 0
                                          ? Colors.white
                                          : isDark
                                              ? Colors.white70
                                              : Colors.grey.shade600,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Weekly',
                                      style:
                                          theme.textTheme.bodyMedium?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: _tabController.index == 0
                                            ? Colors.white
                                            : isDark
                                                ? Colors.white70
                                                : Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => _tabController.animateTo(1),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeInOut,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 16,
                                ),
                                decoration: BoxDecoration(
                                  color: _tabController.index == 1
                                      ? theme.colorScheme.primary
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: _tabController.index == 1
                                      ? [
                                          BoxShadow(
                                            color: theme.colorScheme.primary
                                                .withOpacity(0.3),
                                            blurRadius: 8,
                                            offset: const Offset(0, 2),
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.today,
                                      size: 20,
                                      color: _tabController.index == 1
                                          ? Colors.white
                                          : isDark
                                              ? Colors.white70
                                              : Colors.grey.shade600,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Daily',
                                      style:
                                          theme.textTheme.bodyMedium?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: _tabController.index == 1
                                            ? Colors.white
                                            : isDark
                                                ? Colors.white70
                                                : Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          _buildWeeklyView(mealPlannerState, isDark),
                          _buildDailyView(mealPlannerState, isDark),
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }

  Widget _buildErrorView(String error, bool isDark) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Something went wrong',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.grey.shade800,
                  ),
            ),
            const SizedBox(height: 12),
            Text(
              error,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: isDark ? Colors.white70 : Colors.grey.shade600,
                  ),
            ),
            const SizedBox(height: 32),
            FilledButton.icon(
              onPressed: () =>
                  ref.read(mealPlannerProvider.notifier).createMealPlan(
                        'My Meal Plan',
                        DateTime.now(),
                        DateTime.now().add(const Duration(days: 6)),
                      ),
              icon: const Icon(Icons.refresh),
              label: const Text('Create New Plan'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeeklyView(MealPlannerState state, bool isDark) {
    if (state.activePlan == null) {
      return _buildEmptyState(isDark);
    }

    final plan = state.activePlan!;
    final weekStart = _getWeekStart(state.selectedDate);

    return Column(
      children: [
        _buildWeekHeader(weekStart, isDark),
        Expanded(
          child: SingleChildScrollView(
            child: _buildWeekGrid(plan, weekStart, isDark),
          ),
        ),
      ],
    );
  }

  Widget _buildDailyView(MealPlannerState state, bool isDark) {
    if (state.activePlan == null) {
      return _buildEmptyState(isDark);
    }

    final plan = state.activePlan!;
    final selectedDate = state.selectedDate;
    final dateKey = _formatDateKey(selectedDate);
    final dayMeals = plan.meals[dateKey] ?? {};

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDateSelector(isDark),
          const SizedBox(height: 24),
          _buildMealSlots(selectedDate, dayMeals, isDark),
        ],
      ),
    );
  }

  Widget _buildEmptyState(bool isDark) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.calendar_month_outlined,
                size: 64,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'No Meal Plan Created',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.grey.shade800,
                  ),
            ),
            const SizedBox(height: 12),
            Text(
              'Create a meal plan to start organizing your weekly meals and make cooking easier',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: isDark ? Colors.white70 : Colors.grey.shade600,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton.icon(
                  onPressed: () => _showCreatePlanDialog(),
                  icon: const Icon(Icons.add),
                  label: const Text('Create Plan'),
                ),
                const SizedBox(width: 16),
                FilledButton.icon(
                  onPressed: () => _showAutoGenerateDialog(),
                  icon: const Icon(Icons.auto_awesome),
                  label: const Text('Auto Generate'),
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeekHeader(DateTime weekStart, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.grey.shade800.withOpacity(0.7)
            : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Week Overview',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: isDark ? Colors.white70 : Colors.grey.shade600,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  _getWeekRangeText(weekStart),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.grey.shade800,
                      ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () => _navigateWeek(-1),
                icon: const Icon(Icons.chevron_left),
                tooltip: 'Previous week',
              ),
              TextButton(
                onPressed: () => _goToCurrentWeek(),
                child: const Text('Today'),
              ),
              IconButton(
                onPressed: () => _navigateWeek(1),
                icon: const Icon(Icons.chevron_right),
                tooltip: 'Next week',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeekGrid(MealPlan plan, DateTime weekStart, bool isDark) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Day headers
          Row(
            children: [
              const SizedBox(width: 80), // Space for meal type labels
              for (int i = 0; i < 7; i++)
                Expanded(
                  child:
                      _buildDayHeader(weekStart.add(Duration(days: i)), isDark),
                ),
            ],
          ),
          const SizedBox(height: 16),
          // Meal rows
          for (final mealType in ['breakfast', 'lunch', 'dinner', 'snack'])
            _buildMealRow(plan, weekStart, mealType, isDark),
        ],
      ),
    );
  }

  Widget _buildDayHeader(DateTime date, bool isDark) {
    final theme = Theme.of(context);
    final isToday = _isSameDay(date, DateTime.now());
    final isSelected =
        _isSameDay(date, ref.watch(mealPlannerProvider).selectedDate);

    return GestureDetector(
      onTap: () => ref.read(mealPlannerProvider.notifier).selectDate(date),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primaryContainer
              : isToday
                  ? theme.colorScheme.primary.withOpacity(0.1)
                  : null,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              _getDayName(date.weekday % 7),
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white70 : Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              date.day.toString(),
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: isToday
                    ? theme.colorScheme.primary
                    : isSelected
                        ? theme.colorScheme.onPrimaryContainer
                        : isDark
                            ? Colors.white
                            : Colors.grey.shade800,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMealRow(
      MealPlan plan, DateTime weekStart, String mealType, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          // Meal type label
          SizedBox(
            width: 80,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                color: _getMealTypeColor(mealType).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Icon(
                    _getMealTypeIcon(mealType),
                    size: 16,
                    color: _getMealTypeColor(mealType),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _getMealTypeName(mealType),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: _getMealTypeColor(mealType),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Meal slots for each day
          for (int i = 0; i < 7; i++)
            Expanded(
              child: _buildMealSlot(
                weekStart.add(Duration(days: i)),
                mealType,
                plan,
                isDark,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMealSlot(
      DateTime date, String mealType, MealPlan plan, bool isDark) {
    final dateKey = _formatDateKey(date);
    final recipe = plan.meals[dateKey]?[mealType];
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => _showRecipeSelector(date, mealType),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        padding: const EdgeInsets.all(8),
        height: 80,
        decoration: BoxDecoration(
          color: recipe != null
              ? _getMealTypeColor(mealType).withOpacity(0.1)
              : isDark
                  ? Colors.grey.shade800.withOpacity(0.5)
                  : Colors.grey.shade50,
          border: Border.all(
            color: recipe != null
                ? _getMealTypeColor(mealType)
                : isDark
                    ? Colors.grey.shade600
                    : Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (recipe != null) ...[
              Icon(
                Icons.restaurant_menu,
                size: 16,
                color: _getMealTypeColor(mealType),
              ),
              const SizedBox(height: 4),
              Text(
                recipe.title,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.grey.shade800,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ] else ...[
              Icon(
                Icons.add,
                size: 16,
                color: isDark ? Colors.white54 : Colors.grey.shade400,
              ),
              const SizedBox(height: 4),
              Text(
                'Add meal',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontSize: 10,
                  color: isDark ? Colors.white54 : Colors.grey.shade400,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDateSelector(bool isDark) {
    final selectedDate = ref.watch(mealPlannerProvider).selectedDate;

    return Card(
      color: isDark ? Colors.grey.shade800.withOpacity(0.7) : null,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selected Date',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: isDark ? Colors.white70 : Colors.grey.shade600,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatDateHeader(selectedDate),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.grey.shade800,
                        ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () => ref
                      .read(mealPlannerProvider.notifier)
                      .selectDate(
                          selectedDate.subtract(const Duration(days: 1))),
                  icon: const Icon(Icons.chevron_left),
                ),
                TextButton(
                  onPressed: () => ref
                      .read(mealPlannerProvider.notifier)
                      .selectDate(DateTime.now()),
                  child: const Text('Today'),
                ),
                IconButton(
                  onPressed: () => ref
                      .read(mealPlannerProvider.notifier)
                      .selectDate(selectedDate.add(const Duration(days: 1))),
                  icon: const Icon(Icons.chevron_right),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMealSlots(
      DateTime date, Map<String, Recipe?> dayMeals, bool isDark) {
    final mealTypes = [
      {'key': 'breakfast', 'name': 'Breakfast', 'icon': Icons.free_breakfast},
      {'key': 'lunch', 'name': 'Lunch', 'icon': Icons.lunch_dining},
      {'key': 'dinner', 'name': 'Dinner', 'icon': Icons.dinner_dining},
      {'key': 'snack', 'name': 'Snack', 'icon': Icons.cookie},
    ];

    return Column(
      children: [
        for (final mealType in mealTypes)
          _buildDailyMealSlot(
            date,
            mealType['key'] as String,
            mealType['name'] as String,
            mealType['icon'] as IconData,
            dayMeals[mealType['key'] as String],
            isDark,
          ),
      ],
    );
  }

  Widget _buildDailyMealSlot(DateTime date, String mealType, String mealName,
      IconData icon, Recipe? recipe, bool isDark) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: isDark ? Colors.grey.shade800.withOpacity(0.7) : null,
      child: InkWell(
        onTap: () => _showRecipeSelector(date, mealType),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _getMealTypeColor(mealType).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: _getMealTypeColor(mealType),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mealName,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.grey.shade800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      recipe?.title ?? 'No meal planned',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: recipe != null
                            ? (isDark ? Colors.white : Colors.grey.shade800)
                            : (isDark ? Colors.white54 : Colors.grey.shade500),
                      ),
                    ),
                    if (recipe != null) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          if (recipe.metadata.prepTime > 0) ...[
                            Icon(
                              Icons.timer_outlined,
                              size: 14,
                              color: isDark
                                  ? Colors.white70
                                  : Colors.grey.shade600,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${recipe.metadata.prepTime + recipe.metadata.cookTime} min',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: isDark
                                    ? Colors.white70
                                    : Colors.grey.shade600,
                              ),
                            ),
                          ],
                          if (recipe.metadata.servings > 0) ...[
                            const SizedBox(width: 12),
                            Icon(
                              Icons.people_outline,
                              size: 14,
                              color: isDark
                                  ? Colors.white70
                                  : Colors.grey.shade600,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${recipe.metadata.servings} servings',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: isDark
                                    ? Colors.white70
                                    : Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              if (recipe != null)
                PopupMenuButton<String>(
                  onSelected: (value) =>
                      _handleMealAction(date, mealType, value),
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'remove',
                      child: ListTile(
                        leading: Icon(Icons.delete_outline),
                        title: Text('Remove'),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                )
              else
                Icon(
                  Icons.add,
                  color: isDark ? Colors.white54 : Colors.grey.shade400,
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showRecipeSelector(DateTime date, String mealType) {
    final recipeBookState = ref.read(recipeBookProvider);

    if (recipeBookState is RecipeBookLoaded) {
      final recipes = recipeBookState.recipes;
      if (recipes.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No recipes available. Create some recipes first!'),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.7,
          maxChildSize: 0.9,
          minChildSize: 0.5,
          builder: (context, scrollController) => Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.3),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Select Recipe for ${_getMealTypeName(mealType)}',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _formatDateHeader(date),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(0.7),
                            ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: recipes.length,
                    itemBuilder: (context, index) {
                      final recipe = recipes[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: _getMealTypeColor(mealType),
                            child: Icon(
                              _getRecipeIcon(recipe.metadata.mealType),
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          title: Text(
                            recipe.title,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                recipe.description,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.timer,
                                      size: 12, color: Colors.grey[600]),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${recipe.totalTime} min',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  const SizedBox(width: 12),
                                  Icon(Icons.people,
                                      size: 12, color: Colors.grey[600]),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${recipe.metadata.servings} servings',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            ref
                                .read(mealPlannerProvider.notifier)
                                .assignMealToSlot(date, mealType, recipe);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Added "${recipe.title}" to ${_getMealTypeName(mealType)}',
                                ),
                                backgroundColor: Colors.green,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Loading recipes...')),
      );
    }
  }

  void _handleMealAction(DateTime date, String mealType, String action) {
    switch (action) {
      case 'remove':
        ref
            .read(mealPlannerProvider.notifier)
            .removeMealFromSlot(date, mealType);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Removed meal from ${_getMealTypeName(mealType)}'),
            backgroundColor: Colors.orange,
          ),
        );
        break;
    }
  }

  void _showCreatePlanDialog() {
    final nameController = TextEditingController(text: 'My Meal Plan');
    DateTime startDate = DateTime.now();
    DateTime endDate = DateTime.now().add(const Duration(days: 6));

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Create Meal Plan'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Plan Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text('Start Date'),
                subtitle: Text(_formatDateHeader(startDate)),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: startDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (date != null) {
                    setDialogState(() => startDate = date);
                  }
                },
              ),
              ListTile(
                title: const Text('End Date'),
                subtitle: Text(_formatDateHeader(endDate)),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: endDate,
                    firstDate: startDate,
                    lastDate: startDate.add(const Duration(days: 30)),
                  );
                  if (date != null) {
                    setDialogState(() => endDate = date);
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
                ref.read(mealPlannerProvider.notifier).createMealPlan(
                    nameController.text.trim(), startDate, endDate);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        'Created meal plan "${nameController.text.trim()}"'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: const Text('Create'),
            ),
          ],
        ),
      ),
    );
  }

  void _showAutoGenerateDialog() {
    final nameController = TextEditingController(text: 'Auto-Generated Plan');
    DateTime startDate = DateTime.now();
    DateTime endDate = DateTime.now().add(const Duration(days: 6));

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Auto-Generate Meal Plan'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Plan Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text('Start Date'),
                subtitle: Text(_formatDateHeader(startDate)),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: startDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (date != null) {
                    setDialogState(() => startDate = date);
                  }
                },
              ),
              ListTile(
                title: const Text('End Date'),
                subtitle: Text(_formatDateHeader(endDate)),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: endDate,
                    firstDate: startDate,
                    lastDate: startDate.add(const Duration(days: 30)),
                  );
                  if (date != null) {
                    setDialogState(() => endDate = date);
                  }
                },
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.blue, size: 16),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'This will automatically assign your saved recipes to meal slots with balanced variety.',
                        style: TextStyle(fontSize: 12, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
                _autoGeneratePlan(
                    nameController.text.trim(), startDate, endDate);
              },
              style: FilledButton.styleFrom(
                backgroundColor: Colors.purple,
              ),
              child: const Text('Generate'),
            ),
          ],
        ),
      ),
    );
  }

  void _autoGeneratePlan(String name, DateTime startDate, DateTime endDate) {
    final recipeBookState = ref.read(recipeBookProvider);

    if (recipeBookState is RecipeBookLoaded) {
      final recipes = recipeBookState.recipes;
      if (recipes.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'No recipes available for auto-generation. Create some recipes first!'),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      ref
          .read(mealPlannerProvider.notifier)
          .autoGenerateMealPlan(name, startDate, endDate, recipes);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Auto-generated meal plan "$name" with ${recipes.length} recipes!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Loading recipes...')),
      );
    }
  }

  // Helper methods
  DateTime _getWeekStart(DateTime date) {
    final weekday = date.weekday;
    return date.subtract(Duration(days: weekday % 7));
  }

  void _navigateWeek(int direction) {
    final currentDate = ref.read(mealPlannerProvider).selectedDate;
    final newDate = currentDate.add(Duration(days: 7 * direction));
    ref.read(mealPlannerProvider.notifier).selectDate(newDate);
  }

  void _goToCurrentWeek() {
    ref.read(mealPlannerProvider.notifier).selectDate(DateTime.now());
  }

  String _getWeekRangeText(DateTime weekStart) {
    final weekEnd = weekStart.add(const Duration(days: 6));
    const monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    if (weekStart.month == weekEnd.month) {
      return '${monthNames[weekStart.month - 1]} ${weekStart.day}-${weekEnd.day}, ${weekStart.year}';
    } else {
      return '${monthNames[weekStart.month - 1]} ${weekStart.day} - ${monthNames[weekEnd.month - 1]} ${weekEnd.day}, ${weekStart.year}';
    }
  }

  String _getDayName(int dayIndex) {
    const dayNames = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return dayNames[dayIndex];
  }

  String _formatDateHeader(DateTime date) {
    final now = DateTime.now();
    if (_isSameDay(date, now)) {
      return 'Today';
    } else if (_isSameDay(date, now.add(const Duration(days: 1)))) {
      return 'Tomorrow';
    } else if (_isSameDay(date, now.subtract(const Duration(days: 1)))) {
      return 'Yesterday';
    } else {
      const monthNames = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec'
      ];
      return '${monthNames[date.month - 1]} ${date.day}, ${date.year}';
    }
  }

  String _formatDateKey(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  IconData _getMealTypeIcon(String mealType) {
    switch (mealType) {
      case 'breakfast':
        return Icons.free_breakfast;
      case 'lunch':
        return Icons.lunch_dining;
      case 'dinner':
        return Icons.dinner_dining;
      case 'snack':
        return Icons.cookie;
      default:
        return Icons.restaurant_menu;
    }
  }

  Color _getMealTypeColor(String mealType) {
    switch (mealType) {
      case 'breakfast':
        return Colors.orange;
      case 'lunch':
        return Colors.green;
      case 'dinner':
        return Colors.blue;
      case 'snack':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  String _getMealTypeName(String mealType) {
    switch (mealType) {
      case 'breakfast':
        return 'Breakfast';
      case 'lunch':
        return 'Lunch';
      case 'dinner':
        return 'Dinner';
      case 'snack':
        return 'Snack';
      default:
        return mealType;
    }
  }

  IconData _getRecipeIcon(MealType? mealType) {
    return switch (mealType) {
      MealType.breakfast => Icons.free_breakfast,
      MealType.lunch => Icons.lunch_dining,
      MealType.dinner => Icons.dinner_dining,
      MealType.snack => Icons.cookie,
      MealType.dessert => Icons.cake,
      _ => Icons.restaurant,
    };
  }
}
