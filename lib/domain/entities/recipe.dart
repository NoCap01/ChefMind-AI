import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'recipe.freezed.dart';
part 'recipe.g.dart';

@freezed
@HiveType(typeId: 0)
class Recipe with _$Recipe {
  const factory Recipe({
    @HiveField(0) required String id,
    @HiveField(1) required String title,
    @HiveField(2) required String description,
    @HiveField(3) required List<Ingredient> ingredients,
    @HiveField(4) required List<CookingStep> instructions,
    @HiveField(5) required Duration cookingTime,
    @HiveField(6) required Duration prepTime,
    @HiveField(7) required DifficultyLevel difficulty,
    @HiveField(8) required int servings,
    @HiveField(9) required List<String> tags,
    @HiveField(10) required NutritionInfo nutrition,
    @HiveField(11) required List<String> tips,
    @HiveField(12) @Default(0.0) double rating,
    @HiveField(13) required DateTime createdAt,
    @HiveField(14) String? imageUrl,
    @HiveField(15) @Default(false) bool isFavorite,
    @HiveField(16) String? authorId,
    @HiveField(17) @Default(0) int cookCount,
    @HiveField(18) DateTime? updatedAt,
    @HiveField(19) DateTime? lastViewedAt,
    @HiveField(20) @Default([]) List<String> collections,
  }) = _Recipe;

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);
}

@freezed
@HiveType(typeId: 1)
class Ingredient with _$Ingredient {
  const factory Ingredient({
    @HiveField(0) required String name,
    @HiveField(1) required double quantity,
    @HiveField(2) required String unit,
    @HiveField(3) String? category,
    @HiveField(4) @Default(false) bool isOptional,
    @HiveField(5) @Default([]) List<String> alternatives,
  }) = _Ingredient;

  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);
}

@freezed
@HiveType(typeId: 2)
class CookingStep with _$CookingStep {
  const factory CookingStep({
    @HiveField(0) required int stepNumber,
    @HiveField(1) required String instruction,
    @HiveField(2) Duration? duration,
    @HiveField(3) String? imageUrl,
    @HiveField(4) @Default([]) List<String> tips,
    @HiveField(5) @Default([]) List<String> equipment,
  }) = _CookingStep;

  factory CookingStep.fromJson(Map<String, dynamic> json) =>
      _$CookingStepFromJson(json);
}

@freezed
@HiveType(typeId: 3)
class NutritionInfo with _$NutritionInfo {
  const factory NutritionInfo({
    @HiveField(0) required double calories,
    @HiveField(1) required double protein,
    @HiveField(2) required double carbs,
    @HiveField(3) required double fat,
    @HiveField(4) required double fiber,
    @HiveField(5) required double sugar,
    @HiveField(6) required double sodium,
    @HiveField(7) @Default({}) Map<String, double> vitamins,
    @HiveField(8) @Default({}) Map<String, double> minerals,
    @HiveField(9) @Default(0.0) double carbohydrates,
    @HiveField(10) @Default(0.0) double cholesterol,
  }) = _NutritionInfo;

  factory NutritionInfo.fromJson(Map<String, dynamic> json) =>
      _$NutritionInfoFromJson(json);
}

@freezed
class UserPreferences with _$UserPreferences {
  const factory UserPreferences({
    @Default([]) List<String> favoriteCuisines,
    @Default([]) List<DietaryRestriction> dietaryRestrictions,
    @Default([]) List<String> allergies,
    @Default(30) int maxCookingTimeMinutes,
    @Default(DifficultyLevel.intermediate) DifficultyLevel maxDifficulty,
    @Default(4) int defaultServings,
  }) = _UserPreferences;

  factory UserPreferences.fromJson(Map<String, dynamic> json) =>
      _$UserPreferencesFromJson(json);
}

// Keep existing enums and extensions...
@HiveType(typeId: 4)
enum DifficultyLevel {
  @HiveField(0)
  beginner,
  @HiveField(1)
  intermediate,
  @HiveField(2)
  advanced,
  @HiveField(3)
  expert,
}

@HiveType(typeId: 7)
enum DietaryRestriction {
  @HiveField(0)
  vegetarian,
  @HiveField(1)
  vegan,
  @HiveField(2)
  glutenFree,
  @HiveField(3)
  dairyFree,
  @HiveField(4)
  nutFree,
  @HiveField(5)
  keto,
  @HiveField(6)
  paleo,
  @HiveField(7)
  lowCarb,
  @HiveField(8)
  lowFat,
  @HiveField(9)
  lowSodium,
  @HiveField(10)
  diabetic,
  @HiveField(11)
  heartHealthy,
  @HiveField(12)
  halal,
  @HiveField(13)
  kosher,
}
