import '../entities/recipe.dart';
import '../entities/user_profile.dart';

abstract class IRecipeGenerationService {
  // Basic recipe generation
  Future<Recipe> generateRecipe(
    List<String> ingredients,
    UserPreferences preferences, {
    String? cuisineType,
    Duration? maxCookingTime,
    DifficultyLevel? maxDifficulty,
    int servings = 4,
    List<String>? excludeIngredients,
  });

  // Recipe modification and adaptation
  Future<Recipe> modifyRecipe(
    Recipe recipe,
    ModificationRequest request,
  );

  Future<Recipe> adaptRecipeForDiet(
    Recipe recipe,
    List<DietaryRestriction> restrictions,
  );

  Future<Recipe> scaleRecipe(
    Recipe recipe,
    int newServings,
  );

  Future<Recipe> substituteIngredients(
    Recipe recipe,
    Map<String, String> substitutions,
  );

  // Meal plan generation
  Future<List<Recipe>> generateMealPlan(
    MealPlanGenerationRequest request,
  );

  Future<Recipe> generateRecipeForMealType(
    MealType mealType,
    UserPreferences preferences,
    NutritionGoals? nutritionGoals,
  );

  // Ingredient-based suggestions
  Future<List<Recipe>> suggestRecipesForIngredients(
    List<String> availableIngredients,
    UserPreferences preferences, {
    int maxRecipes = 10,
  });

  Future<List<String>> suggestIngredientSubstitutions(
    String ingredient,
    String recipeContext,
    List<DietaryRestriction> restrictions,
  );

  // Recipe optimization
  Future<Recipe> optimizeRecipeForTime(Recipe recipe);
  Future<Recipe> optimizeRecipeForCost(Recipe recipe);
  Future<Recipe> optimizeRecipeForNutrition(Recipe recipe, NutritionGoals goals);
  Future<Recipe> simplifyRecipe(Recipe recipe, SkillLevel targetSkillLevel);

  // Recipe analysis and enhancement
  Future<List<String>> generateRecipeTips(Recipe recipe);
  Future<List<String>> generateRecipeVariations(Recipe recipe);
  Future<NutritionInfo> calculateNutrition(Recipe recipe);
  Future<double> estimateRecipeCost(Recipe recipe);

  // Cooking assistance
  Future<String> generateCookingInstructions(
    Recipe recipe,
    List<KitchenEquipment> availableEquipment,
  );

  Future<List<String>> generateTroubleshootingTips(
    Recipe recipe,
    String issue,
  );

  Future<String> explainCookingTechnique(String technique);

  // Personalization and learning
  Future<void> recordRecipePreference(
    String userId,
    String recipeId,
    double rating,
    List<String> feedback,
  );

  Future<Recipe> personalizeRecipe(
    Recipe recipe,
    String userId,
    UserAnalytics analytics,
  );

  // Batch operations
  Future<List<Recipe>> generateMultipleRecipes(
    List<RecipeGenerationRequest> requests,
  );

  // Recipe validation and quality
  Future<RecipeValidationResult> validateRecipe(Recipe recipe);
  Future<double> calculateRecipeComplexity(Recipe recipe);
  Future<List<String>> identifyPotentialIssues(Recipe recipe);
}

class ModificationRequest {
  final ModificationType type;
  final Map<String, dynamic> parameters;
  final String? reason;

  const ModificationRequest({
    required this.type,
    required this.parameters,
    this.reason,
  });
}

enum ModificationType {
  reduceCookingTime,
  increaseProtein,
  reduceSodium,
  makeVegetarian,
  makeVegan,
  makeGlutenFree,
  reduceCalories,
  increaseServings,
  simplifyInstructions,
  addSpice,
  reduceSpice,
  substituteIngredient,
}

class MealPlanGenerationRequest {
  final String userId;
  final int numberOfDays;
  final List<MealType> mealTypes;
  final UserPreferences preferences;
  final NutritionGoals? nutritionGoals;
  final List<String> availableIngredients;
  final double? budgetLimit;
  final Duration? maxPrepTimePerMeal;

  const MealPlanGenerationRequest({
    required this.userId,
    required this.numberOfDays,
    required this.mealTypes,
    required this.preferences,
    this.nutritionGoals,
    this.availableIngredients = const [],
    this.budgetLimit,
    this.maxPrepTimePerMeal,
  });
}

class RecipeGenerationRequest {
  final List<String> ingredients;
  final UserPreferences preferences;
  final String? cuisineType;
  final Duration? maxCookingTime;
  final DifficultyLevel? maxDifficulty;
  final int servings;
  final MealType? mealType;

  const RecipeGenerationRequest({
    required this.ingredients,
    required this.preferences,
    this.cuisineType,
    this.maxCookingTime,
    this.maxDifficulty,
    this.servings = 4,
    this.mealType,
  });
}

enum MealType {
  breakfast,
  lunch,
  dinner,
  snack,
  dessert,
  appetizer,
  beverage,
}

class RecipeValidationResult {
  final bool isValid;
  final List<String> errors;
  final List<String> warnings;
  final List<String> suggestions;
  final double qualityScore;

  const RecipeValidationResult({
    required this.isValid,
    required this.errors,
    required this.warnings,
    required this.suggestions,
    required this.qualityScore,
  });
}