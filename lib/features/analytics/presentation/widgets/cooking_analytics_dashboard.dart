import 'package:flutter/material.dart';
import '../../../../domain/entities/analytics.dart';
import '../../../../domain/services/recipe_analytics_service.dart';
import '../../../../shared/widgets/star_rating.dart';

class CookingAnalyticsDashboard extends StatefulWidget {
  final String userId;

  const CookingAnalyticsDashboard({
    super.key,
    required this.userId,
  });

  @override
  State<CookingAnalyticsDashboard> createState() => _CookingAnalyticsDashboardState();
}

class _CookingAnalyticsDashboardState extends State<CookingAnalyticsDashboard> {
  UserCookingStats? _cookingStats;
  CookingTrends? _cookingTrends;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadAnalytics();
  }

  Future<void> _loadAnalytics() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      // TODO: Get analytics service from dependency injection
      // final analyticsService = GetIt.instance<IRecipeAnalyticsService>();
      
      // For now, create mock data
      await Future.delayed(const Duration(milliseconds: 500));
      
      setState(() {
        _cookingStats = const UserCookingStats(
          userId: 'user123',
          totalRecipesCooked: 47,
          totalRecipesSaved: 23,
          totalRecipesShared: 8,
          averageRating: 4.2,
          totalCookingTime: Duration(hours: 32, minutes: 15),
          averageCookingTime: Duration(minutes: 41),
          difficultyDistribution: {
            DifficultyLevel.beginner: 15,
            DifficultyLevel.intermediate: 25,
            DifficultyLevel.advanced: 7,
          },
          cuisineDistribution: {
            'Italian': 12,
            'Asian': 10,
            'Mexican': 8,
            'American': 7,
            'Mediterranean': 5,
            'Indian': 5,
          },
          currentStreak: 5,
          longestStreak: 12,
          lastCookingDate: DateTime.now().subtract(const Duration(days: 1)),
          currentSkillLevel: SkillLevel.intermediate,
          skillProgress: 0.68,
        );

        _cookingTrends = const CookingTrends(
          period: Duration(days: 30),
          recipesCooked: 12,
          newRecipesTried: 8,
          averageRating: 4.3,
          popularCuisines: {
            'Italian': 4,
            'Asian': 3,
            'Mexican': 2,
            'Mediterranean': 2,
            'American': 1,
          },
          difficultyProgression: {
            DifficultyLevel.beginner: 2,
            DifficultyLevel.intermediate: 7,
            DifficultyLevel.advanced: 3,
          },
          emergingPreferences: ['Vegetarian', 'Quick meals', 'One-pot dishes'],
          improvementScore: 0.15,
        );
        
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Failed to load analytics',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              _error!,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _loadAnalytics,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadAnalytics,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOverviewSection(),
            const SizedBox(height: 24),
            _buildStreakSection(),
            const SizedBox(height: 24),
            _buildSkillProgressSection(),
            const SizedBox(height: 24),
            _buildCuisinePreferencesSection(),
            const SizedBox(height: 24),
            _buildRecentTrendsSection(),
            const SizedBox(height: 24),
            _buildDifficultyProgressionSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewSection() {
    final theme = Theme.of(context);
    final stats = _cookingStats!;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.analytics,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Cooking Overview',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Recipes Cooked',
                    stats.totalRecipesCooked.toString(),
                    Icons.restaurant,
                    theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    'Recipes Saved',
                    stats.totalRecipesSaved.toString(),
                    Icons.bookmark,
                    theme.colorScheme.secondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Average Rating',
                    stats.averageRating.toStringAsFixed(1),
                    Icons.star,
                    Colors.amber,
                    trailing: CompactStarRating(
                      rating: stats.averageRating,
                      size: 16,
                      showRatingText: false,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    'Total Time',
                    '${stats.totalCookingTime.inHours}h ${stats.totalCookingTime.inMinutes % 60}m',
                    Icons.timer,
                    theme.colorScheme.tertiary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String label,
    String value,
    IconData icon,
    Color color, {
    Widget? trailing,
  }) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: color,
              ),
              const Spacer(),
              if (trailing != null) trailing,
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStreakSection() {
    final theme = Theme.of(context);
    final stats = _cookingStats!;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.local_fire_department,
                  color: Colors.orange,
                ),
                const SizedBox(width: 8),
                Text(
                  'Cooking Streak',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${stats.currentStreak}',
                        style: theme.textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      Text(
                        'Current Streak',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 60,
                  width: 1,
                  color: theme.colorScheme.outline.withOpacity(0.3),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${stats.longestStreak}',
                        style: theme.textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      Text(
                        'Best Streak',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: stats.currentStreak / stats.longestStreak,
              backgroundColor: theme.colorScheme.outline.withOpacity(0.2),
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
            ),
            const SizedBox(height: 8),
            Text(
              'Keep cooking to beat your record!',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillProgressSection() {
    final theme = Theme.of(context);
    final stats = _cookingStats!;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.trending_up,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Skill Progress',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        stats.currentSkillLevel.displayName,
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Current Level',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                CircularProgressIndicator(
                  value: stats.skillProgress,
                  strokeWidth: 8,
                  backgroundColor: theme.colorScheme.outline.withOpacity(0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
                ),
              ],
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: stats.skillProgress,
              backgroundColor: theme.colorScheme.outline.withOpacity(0.2),
              valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
            ),
            const SizedBox(height: 8),
            Text(
              '${(stats.skillProgress * 100).round()}% to next level',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCuisinePreferencesSection() {
    final theme = Theme.of(context);
    final stats = _cookingStats!;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.public,
                  color: theme.colorScheme.secondary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Cuisine Preferences',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ...stats.cuisineDistribution.entries.take(5).map((entry) {
              final percentage = entry.value / stats.totalRecipesCooked;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          entry.key,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '${entry.value} recipes',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    LinearProgressIndicator(
                      value: percentage,
                      backgroundColor: theme.colorScheme.outline.withOpacity(0.2),
                      valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.secondary),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentTrendsSection() {
    final theme = Theme.of(context);
    final trends = _cookingTrends!;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.timeline,
                  color: theme.colorScheme.tertiary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Recent Trends (30 days)',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildTrendCard(
                    'Recipes Cooked',
                    trends.recipesCooked.toString(),
                    Icons.restaurant,
                    theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildTrendCard(
                    'New Recipes',
                    trends.newRecipesTried.toString(),
                    Icons.new_releases,
                    theme.colorScheme.secondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (trends.emergingPreferences.isNotEmpty) ...[
              Text(
                'Emerging Preferences',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: trends.emergingPreferences.map((preference) {
                  return Chip(
                    label: Text(preference),
                    backgroundColor: theme.colorScheme.primaryContainer,
                    labelStyle: TextStyle(
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTrendCard(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 24,
            color: color,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDifficultyProgressionSection() {
    final theme = Theme.of(context);
    final trends = _cookingTrends!;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.bar_chart,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Difficulty Progression',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ...trends.difficultyProgression.entries.map((entry) {
              final total = trends.difficultyProgression.values.fold<int>(0, (sum, count) => sum + count);
              final percentage = total > 0 ? entry.value / total : 0.0;
              
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          entry.key.displayName,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '${entry.value} recipes',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    LinearProgressIndicator(
                      value: percentage,
                      backgroundColor: theme.colorScheme.outline.withOpacity(0.2),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        _getDifficultyColor(entry.key, theme),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Color _getDifficultyColor(DifficultyLevel difficulty, ThemeData theme) {
    switch (difficulty) {
      case DifficultyLevel.beginner:
        return Colors.green;
      case DifficultyLevel.intermediate:
        return Colors.orange;
      case DifficultyLevel.advanced:
        return Colors.red;
      case DifficultyLevel.expert:
        return Colors.purple;
    }
  }
}