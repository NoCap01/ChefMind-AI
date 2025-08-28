import '../entities/recipe.dart';
import '../entities/community.dart';

abstract class IRecipeRepository {
  // Basic CRUD operations
  Future<void> saveRecipe(Recipe recipe);
  Future<Recipe?> getRecipe(String recipeId);
  Future<List<Recipe>> getUserRecipes(String userId);
  Future<void> deleteRecipe(String recipeId);
  Future<void> updateRecipe(Recipe recipe);

  // Recipe collections and organization
  Future<List<Recipe>> getRecipesByCollection(String userId, String collectionId);
  Future<void> addRecipeToCollection(String recipeId, String collectionId);
  Future<void> removeRecipeFromCollection(String recipeId, String collectionId);
  Future<List<String>> getRecipeCollections(String userId);
  Future<void> createRecipeCollection(String userId, String collectionName);

  // Favorites and ratings
  Future<void> toggleFavorite(String userId, String recipeId);
  Future<List<Recipe>> getFavoriteRecipes(String userId);
  Future<void> rateRecipe(String userId, String recipeId, double rating, String? review);
  Future<List<RecipeRating>> getRecipeRatings(String recipeId);

  // Search and filtering
  Future<List<Recipe>> searchRecipes(String query, {
    List<String>? tags,
    DifficultyLevel? maxDifficulty,
    Duration? maxCookingTime,
    List<String>? ingredients,
    List<String>? excludeIngredients,
  });
  
  Future<List<Recipe>> getRecipesByIngredients(List<String> ingredients);
  Future<List<Recipe>> getRecipesByTags(List<String> tags);
  Future<List<Recipe>> getRecipesByCuisine(String cuisine);
  Future<List<Recipe>> getRecipesByDifficulty(DifficultyLevel difficulty);

  // Recently viewed and popular
  Future<void> addToRecentlyViewed(String userId, String recipeId);
  Future<List<Recipe>> getRecentlyViewedRecipes(String userId);
  Future<List<Recipe>> getPopularRecipes({int limit = 20});
  Future<List<Recipe>> getTrendingRecipes({int limit = 20});

  // Recipe analytics
  Future<void> incrementCookCount(String recipeId);
  Future<void> recordCookingSession(String userId, String recipeId, bool success);
  Future<Map<String, dynamic>> getRecipeAnalytics(String recipeId);

  // Batch operations
  Future<List<Recipe>> getRecipesBatch(List<String> recipeIds);
  Future<void> saveRecipesBatch(List<Recipe> recipes);
  Future<void> deleteRecipesBatch(List<String> recipeIds);

  // Streaming data
  Stream<List<Recipe>> watchUserRecipes(String userId);
  Stream<Recipe?> watchRecipe(String recipeId);
  Stream<List<Recipe>> watchFavoriteRecipes(String userId);
}

abstract class ICommunityRecipeRepository {
  // Community recipe operations
  Future<void> publishRecipe(CommunityRecipe communityRecipe);
  Future<CommunityRecipe?> getCommunityRecipe(String recipeId);
  Future<List<CommunityRecipe>> getCommunityRecipes({
    int limit = 20,
    String? cursor,
    RecipeVisibility? visibility,
  });
  Future<void> updateCommunityRecipe(CommunityRecipe recipe);
  Future<void> deleteCommunityRecipe(String recipeId);

  // Social interactions
  Future<void> likeRecipe(String userId, String recipeId);
  Future<void> unlikeRecipe(String userId, String recipeId);
  Future<void> saveRecipe(String userId, String recipeId);
  Future<void> unsaveRecipe(String userId, String recipeId);
  Future<void> shareRecipe(String userId, String recipeId, String platform);

  // Comments and reviews
  Future<void> addComment(RecipeComment comment);
  Future<void> updateComment(RecipeComment comment);
  Future<void> deleteComment(String commentId);
  Future<List<RecipeComment>> getRecipeComments(String recipeId);
  Future<void> likeComment(String userId, String commentId);

  // User's community content
  Future<List<CommunityRecipe>> getUserPublishedRecipes(String userId);
  Future<List<CommunityRecipe>> getUserLikedRecipes(String userId);
  Future<List<CommunityRecipe>> getUserSavedRecipes(String userId);

  // Following and discovery
  Future<List<CommunityRecipe>> getRecipesByFollowedUsers(String userId);
  Future<List<CommunityRecipe>> getRecommendedRecipes(String userId);
  Future<List<CommunityRecipe>> getFeaturedRecipes();

  // Streaming data
  Stream<List<CommunityRecipe>> watchCommunityRecipes();
  Stream<CommunityRecipe?> watchCommunityRecipe(String recipeId);
  Stream<List<RecipeComment>> watchRecipeComments(String recipeId);
}