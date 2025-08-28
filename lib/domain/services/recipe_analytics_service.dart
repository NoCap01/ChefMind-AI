import '../entities/recipe.dart';
import '../entities/analytics.dart';
import '../entities/user_profile.dart';

abstract class IRecipeAnalyticsService {
  // Recipe rating and feedback
  Future<void> rateRecipe(String recipeId, double rating, String? feedback);
  Future<void> recordRecipeSuccess(String recipeId, bool wasSuccessful, String? notes);
  Future<void> recordCookingTime(String recipeId, Duration actualTime);
  Future<void> recordRecipeView(String recipeId);
  Future<void> recordRecipeShare(String recipeId, String platform);

  // Analytics data retrieval
  Future<RecipeAnalytics> getRecipeAnalytics(String recipeId);
  Future<UserCookingStats> getUserCookingStats(String userId);
  Future<List<Recipe>> getMostCookedRecipes(String userId, {int limit = 10});
  Future<List<Recipe>> getHighestRatedRecipes(String userId, {int limit = 10});
  Future<Map<String, int>> getCookingFrequencyByDay(String userId);
  Future<Map<String, int>> getCuisinePreferences(String userId);

  // Trend analysis
  Future<CookingTrends> getCookingTrends(String userId, Duration period);
  Future<List<String>> getRecommendedRecipes(String userId, {int limit = 5});
  Future<SkillProgressAnalytics> getSkillProgress(String userId);
  Future<NutritionTrends> getNutritionTrends(String userId, Duration period);

  // Success tracking
  Future<double> getRecipeSuccessRate(String recipeId);
  Future<double> getUserSuccessRate(String userId);
  Future<List<String>> getCommonFailureReasons(String recipeId);
  Future<Map<DifficultyLevel, double>> getSuccessRateByDifficulty(String userId);

  // Time analysis
  Future<Duration> getAverageCookingTime(String recipeId);
  Future<Duration> getUserAverageCookingTime(String userId);
  Future<Map<String, Duration>> getCookingTimeByCategory(String userId);
  Future<List<Recipe>> getQuickestRecipes(String userId, {int limit = 10});

  // Engagement metrics
  Future<int> getRecipeViewCount(String recipeId);
  Future<int> getRecipeShareCount(String recipeId);
  Future<double> getRecipeEngagementScore(String recipeId);
  Future<List<Recipe>> getTrendingRecipes({int limit = 10});
}

class RecipeAnalytics {
  final String recipeId;
  final double averageRating;
  final int totalRatings;
  final int viewCount;
  final int cookCount;
  final int shareCount;
  final double successRate;
  final Duration averageCookingTime;
  final Map<int, int> ratingDistribution;
  final List<String> commonFeedback;
  final DateTime lastCooked;
  final DateTime lastViewed;

  const RecipeAnalytics({
    required this.recipeId,
    required this.averageRating,
    required this.totalRatings,
    required this.viewCount,
    required this.cookCount,
    required this.shareCount,
    required this.successRate,
    required this.averageCookingTime,
    required this.ratingDistribution,
    required this.commonFeedback,
    required this.lastCooked,
    required this.lastViewed,
  });
}

class UserCookingStats {
  final String userId;
  final int totalRecipesCooked;
  final int totalRecipesSaved;
  final int totalRecipesShared;
  final double averageRating;
  final Duration totalCookingTime;
  final Duration averageCookingTime;
  final Map<DifficultyLevel, int> difficultyDistribution;
  final Map<String, int> cuisineDistribution;
  final int currentStreak;
  final int longestStreak;
  final DateTime lastCookingDate;
  final SkillLevel currentSkillLevel;
  final double skillProgress;

  const UserCookingStats({
    required this.userId,
    required this.totalRecipesCooked,
    required this.totalRecipesSaved,
    required this.totalRecipesShared,
    required this.averageRating,
    required this.totalCookingTime,
    required this.averageCookingTime,
    required this.difficultyDistribution,
    required this.cuisineDistribution,
    required this.currentStreak,
    required this.longestStreak,
    required this.lastCookingDate,
    required this.currentSkillLevel,
    required this.skillProgress,
  });
}

class CookingTrends {
  final Duration period;
  final int recipesCooked;
  final int newRecipesTried;
  final double averageRating;
  final Map<String, int> popularCuisines;
  final Map<DifficultyLevel, int> difficultyProgression;
  final List<String> emergingPreferences;
  final double improvementScore;

  const CookingTrends({
    required this.period,
    required this.recipesCooked,
    required this.newRecipesTried,
    required this.averageRating,
    required this.popularCuisines,
    required this.difficultyProgression,
    required this.emergingPreferences,
    required this.improvementScore,
  });
}

class SkillProgressAnalytics {
  final SkillLevel currentLevel;
  final double progressToNextLevel;
  final List<String> masteredTechniques;
  final List<String> recommendedTechniques;
  final Map<String, double> skillScores;
  final List<Achievement> recentAchievements;

  const SkillProgressAnalytics({
    required this.currentLevel,
    required this.progressToNextLevel,
    required this.masteredTechniques,
    required this.recommendedTechniques,
    required this.skillScores,
    required this.recentAchievements,
  });
}

class NutritionTrends {
  final Duration period;
  final double averageCalories;
  final double averageProtein;
  final double averageCarbs;
  final double averageFat;
  final Map<String, double> nutritionGoalProgress;
  final List<String> healthyChoices;
  final List<String> improvementSuggestions;

  const NutritionTrends({
    required this.period,
    required this.averageCalories,
    required this.averageProtein,
    required this.averageCarbs,
    required this.averageFat,
    required this.nutritionGoalProgress,
    required this.healthyChoices,
    required this.improvementSuggestions,
  });
}

class Achievement {
  final String id;
  final String title;
  final String description;
  final String iconName;
  final DateTime unlockedAt;
  final AchievementType type;

  const Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.iconName,
    required this.unlockedAt,
    required this.type,
  });
}

enum AchievementType {
  cooking,
  rating,
  sharing,
  skill,
  nutrition,
  streak,
  exploration,
}