import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'recipe.dart';
import 'user_profile.dart'; // Import for SkillLevel

part 'meal_plan.freezed.dart';
part 'meal_plan.g.dart';

@freezed
@HiveType(typeId: 80)
class MealPlan with _$MealPlan {
  const factory MealPlan({
    @HiveField(0) required String id,
    @HiveField(1) required String name,
    @HiveField(2) required String userId,
    @HiveField(3) required DateTime startDate,
    @HiveField(4) required DateTime endDate,
    @HiveField(5) required List<MealPlanDay> days,
    @HiveField(6) required DateTime createdAt,
    @HiveField(7) DateTime? updatedAt,
    @HiveField(8) String? description,
    @HiveField(9) @Default([]) List<String> tags,
    @HiveField(10) @Default(false) bool isTemplate,
    @HiveField(11) @Default(false) bool isShared,
    @HiveField(12) @Default([]) List<String> sharedWith,
    @HiveField(13) NutritionGoals? nutritionGoals,
    @HiveField(14) MealPlanPreferences? preferences,
    @HiveField(15) Map<String, dynamic>? metadata,
  }) = _MealPlan;

  factory MealPlan.fromJson(Map<String, dynamic> json) =>
      _$MealPlanFromJson(json);
}

@freezed
@HiveType(typeId: 81)
class MealPlanDay with _$MealPlanDay {
  const factory MealPlanDay({
    @HiveField(0) required DateTime date,
    @HiveField(1) required List<PlannedMeal> meals,
    @HiveField(2) @Default([]) List<String> notes,
    @HiveField(3) NutritionSummary? nutritionSummary,
    @HiveField(4) @Default(0.0) double estimatedCost,
    @HiveField(5) @Default(0) int prepTimeMinutes,
    @HiveField(6) @Default(false) bool isCompleted,
  }) = _MealPlanDay;

  factory MealPlanDay.fromJson(Map<String, dynamic> json) =>
      _$MealPlanDayFromJson(json);
}

@freezed
@HiveType(typeId: 82)
class PlannedMeal with _$PlannedMeal {
  const factory PlannedMeal({
    @HiveField(0) required String id,
    @HiveField(1) required MealType mealType,
    @HiveField(2) required DateTime scheduledTime,
    @HiveField(3) String? recipeId,
    @HiveField(4) String? recipeName,
    @HiveField(5) String? customMealName,
    @HiveField(6) @Default(4) int servings,
    @HiveField(7) @Default([]) List<String> ingredients,
    @HiveField(8) @Default(0) int prepTimeMinutes,
    @HiveField(9) @Default(0) int cookTimeMinutes,
    @HiveField(10) NutritionInfo? nutrition,
    @HiveField(11) @Default(0.0) double estimatedCost,
    @HiveField(12) @Default(false) bool isPrepared,
    @HiveField(13) @Default(false) bool isLeftover,
    @HiveField(14) String? leftoverFromMealId,
    @HiveField(15) DateTime? prepStartTime,
    @HiveField(16) DateTime? actualPrepTime,
    @HiveField(17) @Default([]) List<String> notes,
    @HiveField(18) @Default([]) List<String> tags,
    @HiveField(19) String? imageUrl,
  }) = _PlannedMeal;

  factory PlannedMeal.fromJson(Map<String, dynamic> json) =>
      _$PlannedMealFromJson(json);
}

@freezed
@HiveType(typeId: 83)
class MealPlanPreferences with _$MealPlanPreferences {
  const factory MealPlanPreferences({
    @HiveField(0) @Default([]) List<MealType> preferredMealTypes,
    @HiveField(1) @Default(4) int defaultServings,
    @HiveField(2) @Default(30) int maxPrepTimeMinutes,
    @HiveField(3) @Default(60) int maxCookTimeMinutes,
    @HiveField(4) @Default([]) List<String> preferredCuisines,
    @HiveField(5) @Default([]) List<String> dislikedIngredients,
    @HiveField(6) @Default([]) List<DietaryRestriction> dietaryRestrictions,
    @HiveField(7) @Default([]) List<String> allergies,
    @HiveField(8) @Default(false) bool allowLeftovers,
    @HiveField(9) @Default(2) int maxLeftoverDays,
    @HiveField(10) @Default(false) bool batchCookingPreferred,
    @HiveField(11) @Default([]) List<String> kitchenEquipment,
    @HiveField(12) SkillLevel? skillLevel, // Now properly imported
    @HiveField(13) @Default(100.0) double weeklyBudget,
  }) = _MealPlanPreferences;

  factory MealPlanPreferences.fromJson(Map<String, dynamic> json) =>
      _$MealPlanPreferencesFromJson(json);
}

@freezed
@HiveType(typeId: 84)
class NutritionSummary with _$NutritionSummary {
  const factory NutritionSummary({
    @HiveField(0) required double totalCalories,
    @HiveField(1) required double totalProtein,
    @HiveField(2) required double totalCarbs,
    @HiveField(3) required double totalFat,
    @HiveField(4) required double totalFiber,
    @HiveField(5) required double totalSodium,
    @HiveField(6) required double totalSugar,
    @HiveField(7) required Map<MealType, NutritionInfo> mealBreakdown,
    @HiveField(8) NutritionGoals? goals,
  }) = _NutritionSummary;

  factory NutritionSummary.fromJson(Map<String, dynamic> json) =>
      _$NutritionSummaryFromJson(json);
}

@freezed
@HiveType(typeId: 85)
class MealPlanTemplate with _$MealPlanTemplate {
  const factory MealPlanTemplate({
    @HiveField(0) required String id,
    @HiveField(1) required String name,
    @HiveField(2) required String description,
    @HiveField(3) required int durationDays,
    @HiveField(4) required List<MealPlanDay> templateDays,
    @HiveField(5) required String createdBy,
    @HiveField(6) required DateTime createdAt,
    @HiveField(7) @Default([]) List<String> tags,
    @HiveField(8) @Default(false) bool isPublic,
    @HiveField(9) @Default(0) int usageCount,
    @HiveField(10) @Default(0.0) double rating,
    @HiveField(11) NutritionGoals? targetNutrition,
    @HiveField(12) @Default(0.0) double estimatedWeeklyCost,
    @HiveField(13) @Default([]) List<String> requiredEquipment,
    @HiveField(14) SkillLevel? requiredSkillLevel, // Now properly imported
  }) = _MealPlanTemplate;

  factory MealPlanTemplate.fromJson(Map<String, dynamic> json) =>
      _$MealPlanTemplateFromJson(json);
}

// Remove the utility classes to avoid generated JSON errors - move to separate utility files
