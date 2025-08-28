import '../entities/meal_plan.dart';

abstract class IMealPlanRepository {
  /// Get all meal plans for a user
  Future<List<MealPlan>> getUserMealPlans(String userId);

  /// Get a specific meal plan by ID
  Future<MealPlan?> getMealPlanById(String mealPlanId);

  /// Create a new meal plan
  Future<MealPlan> createMealPlan(MealPlan mealPlan);

  /// Update an existing meal plan
  Future<MealPlan> updateMealPlan(MealPlan mealPlan);

  /// Delete a meal plan
  Future<void> deleteMealPlan(String mealPlanId);

  /// Add meal to meal plan
  Future<MealPlan> addMealToPlan(String mealPlanId, DateTime date, PlannedMeal meal);

  /// Update meal in meal plan
  Future<MealPlan> updateMealInPlan(String mealPlanId, DateTime date, PlannedMeal meal);

  /// Remove meal from meal plan
  Future<MealPlan> removeMealFromPlan(String mealPlanId, DateTime date, String mealId);

  /// Mark meal as completed
  Future<MealPlan> markMealCompleted(String mealPlanId, DateTime date, String mealId);

  /// Mark meal as prepared
  Future<MealPlan> markMealPrepared(String mealPlanId, DateTime date, String mealId);

  /// Get meal plans by date range
  Future<List<MealPlan>> getMealPlansByDateRange(String userId, DateTime startDate, DateTime endDate);

  /// Get active meal plans
  Future<List<MealPlan>> getActiveMealPlans(String userId);

  /// Get shared meal plans
  Future<List<MealPlan>> getSharedMealPlans(String userId);

  /// Share meal plan with users
  Future<MealPlan> shareMealPlan(String mealPlanId, List<String> userIds);

  /// Unshare meal plan
  Future<MealPlan> unshareMealPlan(String mealPlanId, List<String> userIds);

  /// Get meal plan templates
  Future<List<MealPlanTemplate>> getMealPlanTemplates();

  /// Create meal plan from template
  Future<MealPlan> createFromTemplate(String templateId, String userId, DateTime startDate);

  /// Save meal plan as template
  Future<MealPlanTemplate> saveAsTemplate(String mealPlanId, String templateName, String description);

  /// Get meal plan statistics
  Future<MealPlanStats> getMealPlanStats(String mealPlanId);

  /// Search meal plans
  Future<List<MealPlan>> searchMealPlans(String userId, String query);

  /// Get recent meal plans
  Future<List<MealPlan>> getRecentMealPlans(String userId, {int limit = 10});

  /// Duplicate meal plan
  Future<MealPlan> duplicateMealPlan(String mealPlanId, DateTime newStartDate);

  /// Archive meal plan
  Future<void> archiveMealPlan(String mealPlanId);

  /// Get archived meal plans
  Future<List<MealPlan>> getArchivedMealPlans(String userId);

  /// Restore archived meal plan
  Future<MealPlan> restoreMealPlan(String mealPlanId);

  /// Get batch cooking sessions
  Future<List<BatchCookingSession>> getBatchCookingSessions(String mealPlanId);

  /// Create batch cooking session
  Future<BatchCookingSession> createBatchCookingSession(BatchCookingSession session);

  /// Update batch cooking session
  Future<BatchCookingSession> updateBatchCookingSession(BatchCookingSession session);

  /// Get nutrition summary for date range
  Future<NutritionSummary> getNutritionSummary(String mealPlanId, DateTime startDate, DateTime endDate);

  /// Get meal plan preferences
  Future<MealPlanPreferences?> getMealPlanPreferences(String userId);

  /// Update meal plan preferences
  Future<MealPlanPreferences> updateMealPlanPreferences(String userId, MealPlanPreferences preferences);

  /// Get meal suggestions for date and meal type
  Future<List<PlannedMeal>> getMealSuggestions(String userId, DateTime date, MealType mealType);

  /// Track meal preparation time
  Future<void> trackMealPrepTime(String mealPlanId, String mealId, Duration actualTime);

  /// Get meal prep analytics
  Future<MealPrepAnalytics> getMealPrepAnalytics(String userId, {DateTime? since});
}

class MealPrepAnalytics {
  final double averagePrepTime;
  final double averageCookTime;
  final Map<String, double> recipeEfficiency;
  final Map<MealType, double> mealTypePrep;
  final int totalMealsPrepped;
  final int batchCookingSessions;
  final double timeVariance;
  final List<String> mostEfficientRecipes;
  final List<String> timeConsumingRecipes;

  const MealPrepAnalytics({
    required this.averagePrepTime,
    required this.averageCookTime,
    required this.recipeEfficiency,
    required this.mealTypePrep,
    required this.totalMealsPrepped,
    required this.batchCookingSessions,
    required this.timeVariance,
    required this.mostEfficientRecipes,
    required this.timeConsumingRecipes,
  });

  factory MealPrepAnalytics.fromJson(Map<String, dynamic> json) {
    return MealPrepAnalytics(
      averagePrepTime: (json['averagePrepTime'] as num).toDouble(),
      averageCookTime: (json['averageCookTime'] as num).toDouble(),
      recipeEfficiency: Map<String, double>.from(json['recipeEfficiency'] as Map),
      mealTypePrep: Map<String, double>.from(
        (json['mealTypePrep'] as Map).map(
          (key, value) => MapEntry(key as String, (value as num).toDouble()),
        ),
      ),
      totalMealsPrepped: json['totalMealsPrepped'] as int,
      batchCookingSessions: json['batchCookingSessions'] as int,
      timeVariance: (json['timeVariance'] as num).toDouble(),
      mostEfficientRecipes: List<String>.from(json['mostEfficientRecipes'] as List),
      timeConsumingRecipes: List<String>.from(json['timeConsumingRecipes'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'averagePrepTime': averagePrepTime,
      'averageCookTime': averageCookTime,
      'recipeEfficiency': recipeEfficiency,
      'mealTypePrep': mealTypePrep,
      'totalMealsPrepped': totalMealsPrepped,
      'batchCookingSessions': batchCookingSessions,
      'timeVariance': timeVariance,
      'mostEfficientRecipes': mostEfficientRecipes,
      'timeConsumingRecipes': timeConsumingRecipes,
    };
  }
}