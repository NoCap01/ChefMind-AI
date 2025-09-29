import '../entities/recipe.dart';
import '../entities/user_profile.dart';

abstract class RecipeGenerationService {
  Future<Recipe> generateRecipe({
    required List<String> ingredients,
    UserProfile? userProfile,
    String? cuisineType,
    Duration? maxCookingTime,
    int? servings,
    String? mealType,
  });

  Future<Recipe> modifyRecipe({
    required Recipe recipe,
    String? modification,
    List<String>? additionalIngredients,
    List<String>? excludeIngredients,
  });

  Future<List<Recipe>> generateMealPlan({
    required UserProfile userProfile,
    required int days,
    List<String>? availableIngredients,
  });

  Future<List<String>> suggestIngredients(String partialInput);

  Future<Recipe> improveRecipe({
    required Recipe recipe,
    required UserProfile userProfile,
    String? feedback,
  });
}
