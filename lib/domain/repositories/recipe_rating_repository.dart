import '../entities/recipe_rating.dart';

abstract class IRecipeRatingRepository {
  // Rating operations
  Future<void> saveRating(RecipeRating rating);
  Future<RecipeRating?> getRating(String ratingId);
  Future<List<RecipeRating>> getRecipeRatings(String recipeId);
  Future<List<RecipeRating>> getUserRatings(String userId);
  Future<RecipeRating?> getUserRecipeRating(String userId, String recipeId);
  Future<void> updateRating(RecipeRating rating);
  Future<void> deleteRating(String ratingId);

  // History operations
  Future<void> recordHistory(RecipeHistory history);
  Future<List<RecipeHistory>> getRecipeHistory(String recipeId);
  Future<List<RecipeHistory>> getUserHistory(String userId, {RecipeHistoryAction? action});
  Future<List<RecipeHistory>> getRecentHistory(String userId, {int limit = 20});

  // Cooking session operations
  Future<void> startCookingSession(CookingSession session);
  Future<void> updateCookingSession(CookingSession session);
  Future<void> endCookingSession(String sessionId, {double? rating, bool? wasSuccessful});
  Future<CookingSession?> getCookingSession(String sessionId);
  Future<List<CookingSession>> getUserCookingSessions(String userId);
  Future<CookingSession?> getActiveCookingSession(String userId, String recipeId);

  // Analytics operations
  Future<void> updateRecipeAnalytics(String recipeId, RecipeAnalyticsData analytics);
  Future<RecipeAnalyticsData?> getRecipeAnalytics(String recipeId);
  Future<Map<String, RecipeAnalyticsData>> getBulkRecipeAnalytics(List<String> recipeIds);

  // Aggregation queries
  Future<double> getAverageRating(String recipeId);
  Future<Map<int, int>> getRatingDistribution(String recipeId);
  Future<int> getRecipeViewCount(String recipeId);
  Future<int> getRecipeCookCount(String recipeId);
  Future<List<String>> getMostCookedRecipes(String userId, {int limit = 10});
  Future<List<String>> getHighestRatedRecipes(String userId, {int limit = 10});
  Future<List<String>> getRecentlyViewedRecipes(String userId, {int limit = 10});
  Future<Map<String, int>> getCookingFrequencyByDay(String userId);
  Future<Map<String, int>> getCookingFrequencyByMonth(String userId);

  // Success tracking
  Future<double> getRecipeSuccessRate(String recipeId);
  Future<double> getUserSuccessRate(String userId);
  Future<List<String>> getCommonFailureReasons(String recipeId);
  Future<Duration> getAverageCookingTime(String recipeId);
  Future<Duration> getUserAverageCookingTime(String userId);

  // Trend analysis
  Future<Map<String, double>> getRatingTrends(String recipeId, Duration period);
  Future<Map<String, int>> getCookingTrends(String userId, Duration period);
  Future<List<String>> getPopularRecipeTags(String userId);
  Future<Map<String, double>> getSkillProgressMetrics(String userId);
}