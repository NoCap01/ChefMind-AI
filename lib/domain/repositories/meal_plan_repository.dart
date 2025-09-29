import '../entities/meal_plan.dart';

abstract class MealPlanRepository {
  Future<void> saveMealPlan(MealPlan mealPlan);
  Future<MealPlan?> getMealPlan(String planId);
  Future<List<MealPlan>> getUserMealPlans(String userId);
  Future<void> updateMealPlan(MealPlan mealPlan);
  Future<void> deleteMealPlan(String planId);
  Future<MealPlan> generateMealPlan(String userId, DateTime startDate, int days);
  Future<void> markMealAsCooked(String planId, DateTime date, String mealType);
  Stream<List<MealPlan>> watchUserMealPlans(String userId);
}
