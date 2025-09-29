import '../../domain/entities/meal_plan.dart';
import '../../domain/enums/meal_type.dart';
import '../../domain/repositories/meal_plan_repository.dart';
import '../../core/errors/app_exceptions.dart';

class PlanMealsUseCase {
  final MealPlanRepository _mealPlanRepository;

  const PlanMealsUseCase(this._mealPlanRepository);

  Future<MealPlan> createMealPlan({
    required String userId,
    required String name,
    required DateTime startDate,
    required DateTime endDate,
    List<String>? notes,
  }) async {
    if (name.trim().isEmpty) {
      throw const ValidationException('Meal plan name cannot be empty');
    }

    if (endDate.isBefore(startDate)) {
      throw const ValidationException('End date must be after start date');
    }

    if (startDate.difference(DateTime.now()).inDays > 365) {
      throw const ValidationException(
          'Cannot create meal plans more than a year in advance');
    }

    try {
      final mealPlan = MealPlan(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: userId,
        name: name.trim(),
        startDate: startDate,
        endDate: endDate,
        dailyPlans: _generateDailyPlans(startDate, endDate),
        notes: notes ?? [],
        isActive: false,
        createdAt: DateTime.now(),
      );

      await _mealPlanRepository.saveMealPlan(mealPlan);
      return mealPlan;
    } catch (e) {
      if (e is AppException) {
        rethrow;
      }
      throw const DatabaseException('Failed to create meal plan');
    }
  }

  List<DailyMealPlan> _generateDailyPlans(
      DateTime startDate, DateTime endDate) {
    final dailyPlans = <DailyMealPlan>[];
    var currentDate = startDate;

    while (currentDate.isBefore(endDate) || _isSameDay(currentDate, endDate)) {
      dailyPlans.add(DailyMealPlan(
        date: currentDate,
        meals: {
          MealType.breakfast: null,
          MealType.lunch: null,
          MealType.dinner: null,
          MealType.snack: null,
          MealType.appetizer: null,
          MealType.dessert: null,
        },
        notes: '',
      ));
      currentDate = currentDate.add(const Duration(days: 1));
    }

    return dailyPlans;
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}
