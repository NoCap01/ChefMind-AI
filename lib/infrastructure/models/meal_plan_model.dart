import '../../domain/entities/meal_plan.dart';

class MealPlanModel {
  final String id;
  final String userId;
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final List<Map<String, dynamic>> dailyPlans;
  final List<String> notes;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const MealPlanModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.dailyPlans,
    this.notes = const [],
    this.isActive = false,
    required this.createdAt,
    this.updatedAt,
  });

  factory MealPlanModel.fromJson(Map<String, dynamic> json) {
    return MealPlanModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      name: json['name'] ?? '',
      startDate:
          DateTime.parse(json['startDate'] ?? DateTime.now().toIso8601String()),
      endDate:
          DateTime.parse(json['endDate'] ?? DateTime.now().toIso8601String()),
      dailyPlans: List<Map<String, dynamic>>.from(json['dailyPlans'] ?? []),
      notes: List<String>.from(json['notes'] ?? []),
      isActive: json['isActive'] ?? false,
      createdAt:
          DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'dailyPlans': dailyPlans,
      'notes': notes,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory MealPlanModel.fromDomain(MealPlan mealPlan) {
    return MealPlanModel(
      id: mealPlan.id,
      userId: mealPlan.userId,
      name: mealPlan.name,
      startDate: mealPlan.startDate,
      endDate: mealPlan.endDate,
      dailyPlans: mealPlan.dailyPlans
          .map((plan) => {
                'date': plan.date.toIso8601String(),
                'meals': plan.meals.entries
                    .map((entry) => {
                          'mealType': entry.key.toString(),
                          'recipeId': entry.value?.recipeId ?? '',
                          'servings': entry.value?.servings ?? 1,
                          'isCooked': entry.value?.isCooked ?? false,
                          'notes': entry.value?.notes ?? '',
                        })
                    .toList(),
                'notes': plan.notes ?? '',
              })
          .toList(),
      notes: mealPlan.notes,
      isActive: mealPlan.isActive,
      createdAt: mealPlan.createdAt,
      updatedAt: mealPlan.updatedAt,
    );
  }

  MealPlan toDomain() {
    return MealPlan(
      id: id,
      userId: userId,
      name: name,
      startDate: startDate,
      endDate: endDate,
      dailyPlans: dailyPlans.map((json) {
        return DailyMealPlan(
          date: DateTime.parse(json['date']),
          meals: {}, // Initialize empty meals map - can be populated later
          notes: json['notes'] ?? '',
        );
      }).toList(),
      notes: notes,
      isActive: isActive,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
