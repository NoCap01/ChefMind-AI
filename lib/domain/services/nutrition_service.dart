import '../entities/ingredient.dart' as ingredient;
import '../entities/recipe.dart' as recipe;
import '../entities/meal_plan.dart';

abstract class NutritionService {
  Future<recipe.NutritionInfo> calculateRecipeNutrition(recipe.Recipe recipe);
  Future<ingredient.NutritionInfo> calculateIngredientNutrition(ingredient.Ingredient ingredient);
  Future<NutritionSummary> calculateMealPlanNutrition(MealPlan mealPlan);
  Future<bool> meetsNutritionalGoals(
    recipe.NutritionInfo nutrition, 
    Map<String, double> goals,
  );
  Future<List<String>> getNutritionalInsights(
    List<recipe.Recipe> recentRecipes,
  );
  Future<recipe.Recipe> optimizeRecipeForNutrition(
    recipe.Recipe recipe, 
    Map<String, double> targets,
  );
}
