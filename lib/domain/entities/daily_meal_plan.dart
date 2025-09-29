import '../enums/meal_type.dart';
import 'planned_meal.dart';

class DailyMealPlan {
  final DateTime date;
  final Map<MealType, PlannedMeal?> meals;
  final String notes;
  final double? plannedCalories;

  const DailyMealPlan({
    required this.date,
    required this.meals,
    required this.notes,
    this.plannedCalories,
  });

  DailyMealPlan copyWith({
    DateTime? date,
    Map<MealType, PlannedMeal?>? meals,
    String? notes,
    double? plannedCalories,
  }) {
    return DailyMealPlan(
      date: date ?? this.date,
      meals: meals ?? this.meals,
      notes: notes ?? this.notes,
      plannedCalories: plannedCalories ?? this.plannedCalories,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'meals': meals.map((key, value) => MapEntry(key.name, value?.toJson())),
      'notes': notes,
      'plannedCalories': plannedCalories,
    };
  }

  factory DailyMealPlan.fromJson(Map<String, dynamic> json) {
    final mealsData = json['meals'] as Map<String, dynamic>? ?? {};
    final meals = <MealType, PlannedMeal?>{};

    for (final mealType in MealType.values) {
      final mealData = mealsData[mealType.name];
      meals[mealType] =
          mealData != null ? PlannedMeal.fromJson(mealData) : null;
    }

    return DailyMealPlan(
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      meals: meals,
      notes: json['notes'] ?? '',
      plannedCalories: json['plannedCalories']?.toDouble(),
    );
  }
}
