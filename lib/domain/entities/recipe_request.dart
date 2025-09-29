import '../enums/dietary_restriction.dart';
import '../enums/skill_level.dart';

/// Request object for recipe generation
class RecipeRequest {
  final List<String> ingredients;
  final String? cuisineType;
  final String? mealType;
  final int servings;
  final int? maxCookingTime;
  final SkillLevel? skillLevel;
  final List<DietaryRestriction> dietaryRestrictions;
  final List<String> allergies;
  final List<String> dislikedIngredients;
  final Map<String, dynamic>? additionalPreferences;

  const RecipeRequest({
    required this.ingredients,
    this.cuisineType,
    this.mealType,
    this.servings = 4,
    this.maxCookingTime,
    this.skillLevel,
    this.dietaryRestrictions = const [],
    this.allergies = const [],
    this.dislikedIngredients = const [],
    this.additionalPreferences,
  });

  /// Convert to JSON for API requests
  Map<String, dynamic> toJson() {
    return {
      'ingredients': ingredients,
      'cuisineType': cuisineType,
      'mealType': mealType,
      'servings': servings,
      'maxCookingTime': maxCookingTime,
      'skillLevel': skillLevel?.name,
      'dietaryRestrictions': dietaryRestrictions.map((e) => e.name).toList(),
      'allergies': allergies,
      'dislikedIngredients': dislikedIngredients,
      'additionalPreferences': additionalPreferences,
    };
  }

  /// Create from JSON
  factory RecipeRequest.fromJson(Map<String, dynamic> json) {
    return RecipeRequest(
      ingredients: List<String>.from(json['ingredients'] ?? []),
      cuisineType: json['cuisineType'],
      mealType: json['mealType'],
      servings: json['servings'] ?? 4,
      maxCookingTime: json['maxCookingTime'],
      skillLevel: json['skillLevel'] != null 
          ? SkillLevel.values.firstWhere((e) => e.name == json['skillLevel'])
          : null,
      dietaryRestrictions: (json['dietaryRestrictions'] as List<dynamic>?)
          ?.map((e) => DietaryRestriction.values.firstWhere((dr) => dr.name == e))
          .toList() ?? [],
      allergies: List<String>.from(json['allergies'] ?? []),
      dislikedIngredients: List<String>.from(json['dislikedIngredients'] ?? []),
      additionalPreferences: json['additionalPreferences'],
    );
  }

  /// Create a copy with updated values
  RecipeRequest copyWith({
    List<String>? ingredients,
    String? cuisineType,
    String? mealType,
    int? servings,
    int? maxCookingTime,
    SkillLevel? skillLevel,
    List<DietaryRestriction>? dietaryRestrictions,
    List<String>? allergies,
    List<String>? dislikedIngredients,
    Map<String, dynamic>? additionalPreferences,
  }) {
    return RecipeRequest(
      ingredients: ingredients ?? this.ingredients,
      cuisineType: cuisineType ?? this.cuisineType,
      mealType: mealType ?? this.mealType,
      servings: servings ?? this.servings,
      maxCookingTime: maxCookingTime ?? this.maxCookingTime,
      skillLevel: skillLevel ?? this.skillLevel,
      dietaryRestrictions: dietaryRestrictions ?? this.dietaryRestrictions,
      allergies: allergies ?? this.allergies,
      dislikedIngredients: dislikedIngredients ?? this.dislikedIngredients,
      additionalPreferences: additionalPreferences ?? this.additionalPreferences,
    );
  }
}