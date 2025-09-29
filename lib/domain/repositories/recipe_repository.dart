import '../entities/recipe.dart';

abstract class RecipeRepository {
  Future<void> saveRecipe(Recipe recipe);
  Future<Recipe?> getRecipe(String recipeId);
  Future<List<Recipe>> getUserRecipes(String userId);
  Future<List<Recipe>> searchRecipes(String query);
  Future<void> deleteRecipe(String recipeId);
  Future<void> updateRecipe(Recipe recipe);
  Future<List<Recipe>> getRecipesByIngredients(List<String> ingredients);
  Future<List<Recipe>> getFavoriteRecipes(String userId);
  Future<void> toggleFavorite(String userId, String recipeId);
  Future<void> rateRecipe(String recipeId, double rating);
  Stream<List<Recipe>> watchUserRecipes(String userId);
}
