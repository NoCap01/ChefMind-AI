import '../entities/meal_plan.dart';
import '../entities/recipe.dart';
import '../entities/pantry_item.dart';

abstract class IMealPlanService {
  /// Generate AI-powered meal plan
  Future<MealPlan> generateMealPlan(
    String userId,
    DateTime startDate,
    int durationDays,
    MealPlanPreferences preferences,
    NutritionGoals? nutritionGoals,
  );

  /// Generate meal plan from recipes
  Future<MealPlan> generateFromRecipes(
    String userId,
    DateTime startDate,
    List<Recipe> recipes,
    MealPlanPreferences preferences,
  );

  /// Optimize meal plan for nutrition
  Future<MealPlan> optimizeForNutrition(
    MealPlan mealPlan,
    NutritionGoals goals,
  );

  /// Optimize meal plan for batch cooking
  Future<MealPlan> optimizeForBatchCooking(MealPlan mealPlan);

  /// Generate batch cooking schedule
  Future<List<BatchCookingSession>> generateBatchCookingSchedule(
    MealPlan mealPlan,
    DateTime prepDate,
  );

  /// Suggest meal replacements
  Future<List<PlannedMeal>> suggestMealReplacements(
    PlannedMeal originalMeal,
    MealPlanPreferences preferences,
    NutritionGoals? nutritionGoals,
  );

  /// Calculate nutrition balance
  Future<NutritionBalance> calculateNutritionBalance(
    MealPlan mealPlan,
    NutritionGoals goals,
  );

  /// Generate shopping list from meal plan
  Future<ShoppingList> generateShoppingList(
    MealPlan mealPlan,
    List<PantryItem> pantryItems,
  );

  /// Optimize prep time schedule
  Future<PrepTimeSchedule> optimizePrepTimeSchedule(
    MealPlan mealPlan,
    DateTime targetDate,
  );

  /// Suggest leftover utilization
  Future<List<PlannedMeal>> suggestLeftoverMeals(
    List<PlannedMeal> previousMeals,
    DateTime targetDate,
  );

  /// Calculate meal plan cost
  Future<double> calculateMealPlanCost(MealPlan mealPlan);

  /// Get meal suggestions for slot
  Future<List<PlannedMeal>> getMealSuggestions(
    String userId,
    DateTime date,
    MealType mealType,
    MealPlanPreferences preferences,
    NutritionGoals? nutritionGoals,
  );

  /// Validate meal plan nutrition
  Future<NutritionValidation> validateNutrition(
    MealPlan mealPlan,
    NutritionGoals goals,
  );

  /// Generate meal prep instructions
  Future<List<MealPrepInstruction>> generateMealPrepInstructions(
    List<PlannedMeal> meals,
    DateTime prepDate,
  );

  /// Optimize for dietary restrictions
  Future<MealPlan> optimizeForDietaryRestrictions(
    MealPlan mealPlan,
    List<DietaryRestriction> restrictions,
    List<String> allergies,
  );

  /// Calculate prep time optimization
  Future<PrepTimeOptimization> calculatePrepTimeOptimization(
    List<PlannedMeal> meals,
  );

  /// Generate weekly meal plan
  Future<MealPlan> generateWeeklyMealPlan(
    String userId,
    DateTime weekStartDate,
    MealPlanPreferences preferences,
    NutritionGoals? nutritionGoals,
  );

  /// Auto-schedule meal prep sessions
  Future<List<BatchCookingSession>> autoScheduleMealPrep(
    MealPlan mealPlan,
    List<DateTime> availableDates,
  );
}

class NutritionBalance {
  final double calorieBalance; // Percentage of goal met
  final double proteinBalance;
  final double carbBalance;
  final double fatBalance;
  final double fiberBalance;
  final Map<String, double> vitaminBalance;
  final Map<String, double> mineralBalance;
  final List<NutritionDeficiency> deficiencies;
  final List<NutritionExcess> excesses;

  const NutritionBalance({
    required this.calorieBalance,
    required this.proteinBalance,
    required this.carbBalance,
    required this.fatBalance,
    required this.fiberBalance,
    required this.vitaminBalance,
    required this.mineralBalance,
    required this.deficiencies,
    required this.excesses,
  });
}

class NutritionDeficiency {
  final String nutrient;
  final double currentAmount;
  final double targetAmount;
  final double deficitPercentage;
  final List<String> suggestedFoods;

  const NutritionDeficiency({
    required this.nutrient,
    required this.currentAmount,
    required this.targetAmount,
    required this.deficitPercentage,
    required this.suggestedFoods,
  });
}

class NutritionExcess {
  final String nutrient;
  final double currentAmount;
  final double targetAmount;
  final double excessPercentage;
  final List<String> reductionSuggestions;

  const NutritionExcess({
    required this.nutrient,
    required this.currentAmount,
    required this.targetAmount,
    required this.excessPercentage,
    required this.reductionSuggestions,
  });
}

class PrepTimeSchedule {
  final DateTime targetDate;
  final List<PrepTimeSlot> timeSlots;
  final int totalPrepTimeMinutes;
  final int optimizedTimeMinutes;
  final double efficiencyGain;

  const PrepTimeSchedule({
    required this.targetDate,
    required this.timeSlots,
    required this.totalPrepTimeMinutes,
    required this.optimizedTimeMinutes,
    required this.efficiencyGain,
  });
}

class PrepTimeSlot {
  final DateTime startTime;
  final DateTime endTime;
  final List<String> mealIds;
  final List<String> tasks;
  final List<String> equipment;
  final int estimatedMinutes;

  const PrepTimeSlot({
    required this.startTime,
    required this.endTime,
    required this.mealIds,
    required this.tasks,
    required this.equipment,
    required this.estimatedMinutes,
  });
}

class NutritionValidation {
  final bool isValid;
  final double overallScore; // 0-100
  final List<NutritionIssue> issues;
  final List<NutritionRecommendation> recommendations;

  const NutritionValidation({
    required this.isValid,
    required this.overallScore,
    required this.issues,
    required this.recommendations,
  });
}

class NutritionIssue {
  final String nutrient;
  final NutritionIssueType type;
  final String description;
  final NutritionIssueSeverity severity;

  const NutritionIssue({
    required this.nutrient,
    required this.type,
    required this.description,
    required this.severity,
  });
}

enum NutritionIssueType {
  deficiency,
  excess,
  imbalance,
}

enum NutritionIssueSeverity {
  low,
  medium,
  high,
  critical,
}

class NutritionRecommendation {
  final String title;
  final String description;
  final List<String> suggestedActions;
  final List<String> suggestedFoods;
  final int priority; // 1-5, 1 being highest

  const NutritionRecommendation({
    required this.title,
    required this.description,
    required this.suggestedActions,
    required this.suggestedFoods,
    required this.priority,
  });
}

class MealPrepInstruction {
  final String id;
  final String title;
  final String description;
  final int stepNumber;
  final int estimatedMinutes;
  final List<String> ingredients;
  final List<String> equipment;
  final List<String> mealIds;
  final DateTime? scheduledTime;
  final bool canBeDoneInAdvance;
  final int advanceDays;

  const MealPrepInstruction({
    required this.id,
    required this.title,
    required this.description,
    required this.stepNumber,
    required this.estimatedMinutes,
    required this.ingredients,
    required this.equipment,
    required this.mealIds,
    this.scheduledTime,
    required this.canBeDoneInAdvance,
    required this.advanceDays,
  });
}

class PrepTimeOptimization {
  final int originalTotalMinutes;
  final int optimizedTotalMinutes;
  final int timeSavedMinutes;
  final double efficiencyGain;
  final List<PrepOptimizationSuggestion> suggestions;
  final Map<String, int> parallelTasks;

  const PrepTimeOptimization({
    required this.originalTotalMinutes,
    required this.optimizedTotalMinutes,
    required this.timeSavedMinutes,
    required this.efficiencyGain,
    required this.suggestions,
    required this.parallelTasks,
  });
}

class PrepOptimizationSuggestion {
  final String title;
  final String description;
  final int timeSavedMinutes;
  final PrepOptimizationType type;
  final List<String> affectedMeals;

  const PrepOptimizationSuggestion({
    required this.title,
    required this.description,
    required this.timeSavedMinutes,
    required this.type,
    required this.affectedMeals,
  });
}

enum PrepOptimizationType {
  batchCooking,
  parallelPrep,
  advancePrep,
  equipmentOptimization,
  ingredientGrouping,
}

class MealPlanGenerationRequest {
  final String userId;
  final DateTime startDate;
  final int durationDays;
  final MealPlanPreferences preferences;
  final NutritionGoals? nutritionGoals;
  final List<String>? excludeRecipeIds;
  final List<String>? includeRecipeIds;
  final bool optimizeForBatchCooking;
  final bool optimizeForCost;
  final bool allowLeftovers;
  final double? maxWeeklyCost;

  const MealPlanGenerationRequest({
    required this.userId,
    required this.startDate,
    required this.durationDays,
    required this.preferences,
    this.nutritionGoals,
    this.excludeRecipeIds,
    this.includeRecipeIds,
    this.optimizeForBatchCooking = false,
    this.optimizeForCost = false,
    this.allowLeftovers = true,
    this.maxWeeklyCost,
  });
}