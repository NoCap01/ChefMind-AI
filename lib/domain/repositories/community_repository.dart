import '../entities/community_recipe.dart';
import '../entities/recipe.dart';

abstract class CommunityRepository {
  Future<void> publishRecipe(Recipe recipe, String story);
  Future<List<CommunityRecipe>> getCommunityRecipes({
    int limit = 20,
    String? lastRecipeId,
  });
  Future<List<CommunityRecipe>> searchCommunityRecipes(String query);
  Future<void> likeRecipe(String userId, String recipeId);
  Future<void> saveRecipe(String userId, String recipeId);
  Future<void> shareRecipe(String userId, String recipeId);
  Future<void> addComment(String recipeId, RecipeComment comment);
  Future<List<RecipeComment>> getComments(String recipeId);
  Future<List<CommunityRecipe>> getFeaturedRecipes();
  Future<List<CommunityRecipe>> getRecipesByAuthor(String authorId);
  Stream<List<CommunityRecipe>> watchCommunityRecipes();
}
