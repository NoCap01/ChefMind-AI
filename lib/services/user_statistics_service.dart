import '../domain/entities/user_profile.dart';
import '../domain/enums/skill_level.dart';
import '../infrastructure/storage/hive_user_profile_storage.dart';
import '../infrastructure/storage/hive_recipe_storage.dart';
import '../core/errors/app_exceptions.dart';

/// Service for managing user cooking statistics and analytics
class UserStatisticsService {
  final HiveUserProfileStorage _profileStorage;
  final HiveRecipeStorage _recipeStorage;

  UserStatisticsService({
    HiveUserProfileStorage? profileStorage,
    HiveRecipeStorage? recipeStorage,
  })  : _profileStorage = profileStorage ?? HiveUserProfileStorage(),
        _recipeStorage = recipeStorage ?? HiveRecipeStorage();

  /// Initialize the service
  Future<void> initialize() async {
    await _profileStorage.initialize();
    await _recipeStorage.initialize();
  }

  /// Get comprehensive user statistics
  Future<UserStatistics> getUserStatistics(String userId) async {
    try {
      final profile = await _profileStorage.getUserProfile(userId);
      if (profile == null) {
        throw const ServiceException('User profile not found');
      }

      final storedStats = await _profileStorage.getUserStatistics(userId);
      final recipeStats = await _recipeStorage.getRecipeStatistics();

      return UserStatistics(
        userId: userId,
        recipesGenerated: storedStats['recipesGenerated'] ?? 0,
        recipesCooked: storedStats['recipesCooked'] ?? 0,
        favoriteRecipes: profile.favoriteRecipes.length,
        totalCookingTime: storedStats['totalCookingTime'] ?? 0,
        averageCookingTime: _calculateAverageCookingTime(storedStats),
        mostCookedCuisine: storedStats['mostCookedCuisine'] ?? 'Unknown',
        cookingStreak: storedStats['cookingStreak'] ?? 0,
        longestCookingStreak: storedStats['longestCookingStreak'] ?? 0,
        achievements: List<String>.from(storedStats['achievements'] ?? []),
        skillLevelProgress: _calculateSkillProgress(profile, storedStats),
        weeklyActivity:
            Map<String, int>.from(storedStats['weeklyActivity'] ?? {}),
        monthlyActivity:
            Map<String, int>.from(storedStats['monthlyActivity'] ?? {}),
        cuisinePreferences:
            Map<String, int>.from(storedStats['cuisinePreferences'] ?? {}),
        ingredientUsage:
            Map<String, int>.from(storedStats['ingredientUsage'] ?? {}),
        lastUpdated: DateTime.now(),
      );
    } catch (e) {
      throw ServiceException('Failed to get user statistics: $e');
    }
  }

  /// Record a recipe generation event
  Future<void> recordRecipeGeneration(
    String userId, {
    String? cuisine,
    List<String>? ingredients,
  }) async {
    try {
      final stats = await _profileStorage.getUserStatistics(userId);

      stats['recipesGenerated'] = (stats['recipesGenerated'] ?? 0) + 1;
      stats['lastActivity'] = DateTime.now().toIso8601String();

      // Update cuisine preferences
      if (cuisine != null) {
        final cuisinePrefs =
            Map<String, int>.from(stats['cuisinePreferences'] ?? {});
        cuisinePrefs[cuisine] = (cuisinePrefs[cuisine] ?? 0) + 1;
        stats['cuisinePreferences'] = cuisinePrefs;
      }

      // Update ingredient usage
      if (ingredients != null) {
        final ingredientUsage =
            Map<String, int>.from(stats['ingredientUsage'] ?? {});
        for (final ingredient in ingredients) {
          ingredientUsage[ingredient] = (ingredientUsage[ingredient] ?? 0) + 1;
        }
        stats['ingredientUsage'] = ingredientUsage;
      }

      await _profileStorage.saveUserStatistics(userId, stats);
      await _checkAndUpdateAchievements(userId, stats);
    } catch (e) {
      throw ServiceException('Failed to record recipe generation: $e');
    }
  }

  /// Record a recipe cooking event
  Future<void> recordRecipeCooking(
    String userId, {
    required String recipeId,
    required int cookingTime,
    String? cuisine,
  }) async {
    try {
      final stats = await _profileStorage.getUserStatistics(userId);

      stats['recipesCooked'] = (stats['recipesCooked'] ?? 0) + 1;
      stats['totalCookingTime'] =
          (stats['totalCookingTime'] ?? 0) + cookingTime;
      stats['lastActivity'] = DateTime.now().toIso8601String();

      // Update cooking streak
      await _updateCookingStreak(userId, stats);

      // Update cuisine preferences
      if (cuisine != null) {
        final cuisinePrefs =
            Map<String, int>.from(stats['cuisinePreferences'] ?? {});
        cuisinePrefs[cuisine] = (cuisinePrefs[cuisine] ?? 0) + 1;
        stats['cuisinePreferences'] = cuisinePrefs;

        // Update most cooked cuisine
        final mostCooked =
            cuisinePrefs.entries.reduce((a, b) => a.value > b.value ? a : b);
        stats['mostCookedCuisine'] = mostCooked.key;
      }

      // Update weekly and monthly activity
      await _updateActivityTracking(stats);

      await _profileStorage.saveUserStatistics(userId, stats);
      await _checkAndUpdateAchievements(userId, stats);
    } catch (e) {
      throw ServiceException('Failed to record recipe cooking: $e');
    }
  }

  /// Get user achievements
  Future<List<Achievement>> getUserAchievements(String userId) async {
    try {
      final stats = await _profileStorage.getUserStatistics(userId);
      final achievementNames = List<String>.from(stats['achievements'] ?? []);

      return achievementNames
          .map((name) => _getAchievementByName(name))
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// Get cooking activity for a specific period
  Future<Map<String, int>> getCookingActivity(
      String userId, ActivityPeriod period) async {
    try {
      final stats = await _profileStorage.getUserStatistics(userId);

      switch (period) {
        case ActivityPeriod.weekly:
          return Map<String, int>.from(stats['weeklyActivity'] ?? {});
        case ActivityPeriod.monthly:
          return Map<String, int>.from(stats['monthlyActivity'] ?? {});
        case ActivityPeriod.yearly:
          return Map<String, int>.from(stats['yearlyActivity'] ?? {});
      }
    } catch (e) {
      return {};
    }
  }

  /// Get top cuisines by cooking frequency
  Future<List<CuisineStats>> getTopCuisines(String userId,
      {int limit = 5}) async {
    try {
      final stats = await _profileStorage.getUserStatistics(userId);
      final cuisinePrefs =
          Map<String, int>.from(stats['cuisinePreferences'] ?? {});

      final sortedCuisines = cuisinePrefs.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));

      return sortedCuisines
          .take(limit)
          .map((entry) => CuisineStats(
                cuisine: entry.key,
                count: entry.value,
                percentage: (entry.value /
                        cuisinePrefs.values.fold(0, (a, b) => a + b) *
                        100)
                    .round(),
              ))
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// Get top ingredients by usage frequency
  Future<List<IngredientStats>> getTopIngredients(String userId,
      {int limit = 10}) async {
    try {
      final stats = await _profileStorage.getUserStatistics(userId);
      final ingredientUsage =
          Map<String, int>.from(stats['ingredientUsage'] ?? {});

      final sortedIngredients = ingredientUsage.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));

      return sortedIngredients
          .take(limit)
          .map((entry) => IngredientStats(
                ingredient: entry.key,
                count: entry.value,
                percentage: (entry.value /
                        ingredientUsage.values.fold(0, (a, b) => a + b) *
                        100)
                    .round(),
              ))
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// Reset user statistics
  Future<void> resetStatistics(String userId) async {
    try {
      await _profileStorage.saveUserStatistics(userId, {});
    } catch (e) {
      throw ServiceException('Failed to reset statistics: $e');
    }
  }

  // Private helper methods

  double _calculateAverageCookingTime(Map<String, dynamic> stats) {
    final totalTime = stats['totalCookingTime'] ?? 0;
    final recipesCooked = stats['recipesCooked'] ?? 0;

    if (recipesCooked == 0) return 0.0;
    return totalTime / recipesCooked;
  }

  double _calculateSkillProgress(
      UserProfile profile, Map<String, dynamic> stats) {
    final recipesCooked = stats['recipesCooked'] ?? 0;
    final recipesGenerated = stats['recipesGenerated'] ?? 0;

    // Calculate progress based on skill level and activity
    switch (profile.skillLevel) {
      case SkillLevel.novice:
        return (recipesCooked / 10).clamp(0.0, 1.0);
      case SkillLevel.beginner:
        return (recipesCooked / 25).clamp(0.0, 1.0);
      case SkillLevel.intermediate:
        return (recipesCooked / 50).clamp(0.0, 1.0);
      case SkillLevel.advanced:
        return (recipesCooked / 100).clamp(0.0, 1.0);
      case SkillLevel.professional:
        return (recipesCooked / 200).clamp(0.0, 1.0);
    }
  }

  Future<void> _updateCookingStreak(
      String userId, Map<String, dynamic> stats) async {
    final lastActivity = stats['lastActivity'] as String?;
    final currentStreak = stats['cookingStreak'] ?? 0;
    final longestStreak = stats['longestCookingStreak'] ?? 0;

    if (lastActivity != null) {
      final lastDate = DateTime.parse(lastActivity);
      final today = DateTime.now();
      final daysDifference = today.difference(lastDate).inDays;

      if (daysDifference == 1) {
        // Consecutive day - increment streak
        stats['cookingStreak'] = currentStreak + 1;
      } else if (daysDifference > 1) {
        // Streak broken - reset to 1
        stats['cookingStreak'] = 1;
      }
      // Same day - keep current streak
    } else {
      // First cooking activity
      stats['cookingStreak'] = 1;
    }

    // Update longest streak if current is higher
    if (stats['cookingStreak'] > longestStreak) {
      stats['longestCookingStreak'] = stats['cookingStreak'];
    }
  }

  Future<void> _updateActivityTracking(Map<String, dynamic> stats) async {
    final now = DateTime.now();
    final weekKey = '${now.year}-W${_getWeekOfYear(now)}';
    final monthKey = '${now.year}-${now.month.toString().padLeft(2, '0')}';

    // Update weekly activity
    final weeklyActivity = Map<String, int>.from(stats['weeklyActivity'] ?? {});
    weeklyActivity[weekKey] = (weeklyActivity[weekKey] ?? 0) + 1;
    stats['weeklyActivity'] = weeklyActivity;

    // Update monthly activity
    final monthlyActivity =
        Map<String, int>.from(stats['monthlyActivity'] ?? {});
    monthlyActivity[monthKey] = (monthlyActivity[monthKey] ?? 0) + 1;
    stats['monthlyActivity'] = monthlyActivity;
  }

  int _getWeekOfYear(DateTime date) {
    final firstDayOfYear = DateTime(date.year, 1, 1);
    final daysSinceFirstDay = date.difference(firstDayOfYear).inDays;
    return ((daysSinceFirstDay + firstDayOfYear.weekday - 1) / 7).ceil();
  }

  Future<void> _checkAndUpdateAchievements(
      String userId, Map<String, dynamic> stats) async {
    final achievements = List<String>.from(stats['achievements'] ?? []);
    final recipesCooked = stats['recipesCooked'] ?? 0;
    final recipesGenerated = stats['recipesGenerated'] ?? 0;
    final cookingStreak = stats['cookingStreak'] ?? 0;

    // Check for new achievements
    final newAchievements = <String>[];

    // Recipe generation achievements
    if (recipesGenerated >= 1 && !achievements.contains('first_recipe')) {
      newAchievements.add('first_recipe');
    }
    if (recipesGenerated >= 10 && !achievements.contains('recipe_explorer')) {
      newAchievements.add('recipe_explorer');
    }
    if (recipesGenerated >= 50 && !achievements.contains('recipe_master')) {
      newAchievements.add('recipe_master');
    }

    // Cooking achievements
    if (recipesCooked >= 1 && !achievements.contains('first_cook')) {
      newAchievements.add('first_cook');
    }
    if (recipesCooked >= 10 && !achievements.contains('home_chef')) {
      newAchievements.add('home_chef');
    }
    if (recipesCooked >= 25 && !achievements.contains('cooking_enthusiast')) {
      newAchievements.add('cooking_enthusiast');
    }
    if (recipesCooked >= 50 && !achievements.contains('master_chef')) {
      newAchievements.add('master_chef');
    }

    // Streak achievements
    if (cookingStreak >= 7 && !achievements.contains('week_warrior')) {
      newAchievements.add('week_warrior');
    }
    if (cookingStreak >= 30 && !achievements.contains('month_master')) {
      newAchievements.add('month_master');
    }

    // Update achievements if new ones were earned
    if (newAchievements.isNotEmpty) {
      achievements.addAll(newAchievements);
      stats['achievements'] = achievements;
    }
  }

  Achievement _getAchievementByName(String name) {
    switch (name) {
      case 'first_recipe':
        return Achievement(
          id: 'first_recipe',
          name: 'First Recipe',
          description: 'Generated your first recipe',
          icon: '🍳',
          category: AchievementCategory.recipes,
          earnedAt: DateTime.now(),
        );
      case 'recipe_explorer':
        return Achievement(
          id: 'recipe_explorer',
          name: 'Recipe Explorer',
          description: 'Generated 10 recipes',
          icon: '🔍',
          category: AchievementCategory.recipes,
          earnedAt: DateTime.now(),
        );
      case 'recipe_master':
        return Achievement(
          id: 'recipe_master',
          name: 'Recipe Master',
          description: 'Generated 50 recipes',
          icon: '📚',
          category: AchievementCategory.recipes,
          earnedAt: DateTime.now(),
        );
      case 'first_cook':
        return Achievement(
          id: 'first_cook',
          name: 'First Cook',
          description: 'Cooked your first recipe',
          icon: '👨‍🍳',
          category: AchievementCategory.cooking,
          earnedAt: DateTime.now(),
        );
      case 'home_chef':
        return Achievement(
          id: 'home_chef',
          name: 'Home Chef',
          description: 'Cooked 10 recipes',
          icon: '🏠',
          category: AchievementCategory.cooking,
          earnedAt: DateTime.now(),
        );
      case 'cooking_enthusiast':
        return Achievement(
          id: 'cooking_enthusiast',
          name: 'Cooking Enthusiast',
          description: 'Cooked 25 recipes',
          icon: '❤️',
          category: AchievementCategory.cooking,
          earnedAt: DateTime.now(),
        );
      case 'master_chef':
        return Achievement(
          id: 'master_chef',
          name: 'Master Chef',
          description: 'Cooked 50 recipes',
          icon: '👑',
          category: AchievementCategory.cooking,
          earnedAt: DateTime.now(),
        );
      case 'week_warrior':
        return Achievement(
          id: 'week_warrior',
          name: 'Week Warrior',
          description: '7-day cooking streak',
          icon: '🔥',
          category: AchievementCategory.streaks,
          earnedAt: DateTime.now(),
        );
      case 'month_master':
        return Achievement(
          id: 'month_master',
          name: 'Month Master',
          description: '30-day cooking streak',
          icon: '🏆',
          category: AchievementCategory.streaks,
          earnedAt: DateTime.now(),
        );
      default:
        return Achievement(
          id: name,
          name: 'Unknown Achievement',
          description: 'Achievement description not found',
          icon: '🏅',
          category: AchievementCategory.other,
          earnedAt: DateTime.now(),
        );
    }
  }

  /// Dispose resources
  Future<void> dispose() async {
    await _profileStorage.dispose();
    await _recipeStorage.dispose();
  }
}

// Data classes for statistics

class UserStatistics {
  final String userId;
  final int recipesGenerated;
  final int recipesCooked;
  final int favoriteRecipes;
  final int totalCookingTime;
  final double averageCookingTime;
  final String mostCookedCuisine;
  final int cookingStreak;
  final int longestCookingStreak;
  final List<String> achievements;
  final double skillLevelProgress;
  final Map<String, int> weeklyActivity;
  final Map<String, int> monthlyActivity;
  final Map<String, int> cuisinePreferences;
  final Map<String, int> ingredientUsage;
  final DateTime lastUpdated;

  UserStatistics({
    required this.userId,
    required this.recipesGenerated,
    required this.recipesCooked,
    required this.favoriteRecipes,
    required this.totalCookingTime,
    required this.averageCookingTime,
    required this.mostCookedCuisine,
    required this.cookingStreak,
    required this.longestCookingStreak,
    required this.achievements,
    required this.skillLevelProgress,
    required this.weeklyActivity,
    required this.monthlyActivity,
    required this.cuisinePreferences,
    required this.ingredientUsage,
    required this.lastUpdated,
  });
}

class Achievement {
  final String id;
  final String name;
  final String description;
  final String icon;
  final AchievementCategory category;
  final DateTime earnedAt;

  Achievement({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.category,
    required this.earnedAt,
  });
}

class CuisineStats {
  final String cuisine;
  final int count;
  final int percentage;

  CuisineStats({
    required this.cuisine,
    required this.count,
    required this.percentage,
  });
}

class IngredientStats {
  final String ingredient;
  final int count;
  final int percentage;

  IngredientStats({
    required this.ingredient,
    required this.count,
    required this.percentage,
  });
}

enum ActivityPeriod { weekly, monthly, yearly }

enum AchievementCategory { recipes, cooking, streaks, other }
