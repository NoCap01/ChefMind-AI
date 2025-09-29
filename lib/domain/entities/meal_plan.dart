import '../enums/meal_type.dart';
import 'shopping_list.dart';

class MealPlan {
  final String id;
  final String userId;
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final List<DailyMealPlan> dailyPlans;
  final ShoppingList? shoppingList;
  final NutritionSummary? nutritionSummary;
  final PrepSchedule? prepSchedule;
  final List<String> notes;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const MealPlan({
    required this.id,
    required this.userId,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.dailyPlans,
    this.shoppingList,
    this.nutritionSummary,
    this.prepSchedule,
    this.notes = const [],
    this.isActive = false,
    required this.createdAt,
    this.updatedAt,
  });

  MealPlan copyWith({
    String? id,
    String? userId,
    String? name,
    DateTime? startDate,
    DateTime? endDate,
    List<DailyMealPlan>? dailyPlans,
    ShoppingList? shoppingList,
    NutritionSummary? nutritionSummary,
    PrepSchedule? prepSchedule,
    List<String>? notes,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MealPlan(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      dailyPlans: dailyPlans ?? this.dailyPlans,
      shoppingList: shoppingList ?? this.shoppingList,
      nutritionSummary: nutritionSummary ?? this.nutritionSummary,
      prepSchedule: prepSchedule ?? this.prepSchedule,
      notes: notes ?? this.notes,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'name': name,
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
        'dailyPlans': dailyPlans.map((d) => d.toJson()).toList(),
        'shoppingList': shoppingList?.toJson(),
        'nutritionSummary': nutritionSummary?.toJson(),
        'prepSchedule': prepSchedule?.toJson(),
        'notes': notes,
        'isActive': isActive,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };

  factory MealPlan.fromJson(Map<String, dynamic> json) => MealPlan(
        id: json['id'] ?? '',
        userId: json['userId'] ?? '',
        name: json['name'] ?? '',
        startDate: DateTime.tryParse(json['startDate'] ?? '') ?? DateTime.now(),
        endDate: DateTime.tryParse(json['endDate'] ?? '') ?? DateTime.now(),
        dailyPlans: (json['dailyPlans'] as List?)
                ?.map((d) => DailyMealPlan.fromJson(d))
                .toList() ??
            [],
        shoppingList: json['shoppingList'] != null
            ? ShoppingList.fromJson(json['shoppingList'])
            : null,
        nutritionSummary: json['nutritionSummary'] != null
            ? NutritionSummary.fromJson(json['nutritionSummary'])
            : null,
        prepSchedule: json['prepSchedule'] != null
            ? PrepSchedule.fromJson(json['prepSchedule'])
            : null,
        notes: List<String>.from(json['notes'] ?? []),
        isActive: json['isActive'] ?? false,
        createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
        updatedAt: json['updatedAt'] != null
            ? DateTime.tryParse(json['updatedAt'])
            : null,
      );
}

class DailyMealPlan {
  final DateTime date;
  final Map<MealType, PlannedMeal?> meals;
  final String? notes;
  final double plannedCalories;
  final bool isCompleted;

  const DailyMealPlan({
    required this.date,
    required this.meals,
    this.notes,
    this.plannedCalories = 0.0,
    this.isCompleted = false,
  });

  DailyMealPlan copyWith({
    DateTime? date,
    Map<MealType, PlannedMeal?>? meals,
    String? notes,
    double? plannedCalories,
    bool? isCompleted,
  }) {
    return DailyMealPlan(
      date: date ?? this.date,
      meals: meals ?? this.meals,
      notes: notes ?? this.notes,
      plannedCalories: plannedCalories ?? this.plannedCalories,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toJson() => {
        'date': date.toIso8601String(),
        'meals': meals.map((key, value) => MapEntry(key.name, value?.toJson())),
        'notes': notes,
        'plannedCalories': plannedCalories,
        'isCompleted': isCompleted,
      };

  factory DailyMealPlan.fromJson(Map<String, dynamic> json) => DailyMealPlan(
        date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
        meals: (json['meals'] as Map<String, dynamic>?)?.map(
              (key, value) => MapEntry(
                MealType.values.firstWhere((m) => m.name == key),
                value != null ? PlannedMeal.fromJson(value) : null,
              ),
            ) ??
            {},
        notes: json['notes'],
        plannedCalories: (json['plannedCalories'] ?? 0.0).toDouble(),
        isCompleted: json['isCompleted'] ?? false,
      );
}

class PlannedMeal {
  final String? recipeId;
  final String? recipeName;
  final int? servings;
  final String? notes;
  final bool isCooked;
  final DateTime? cookedAt;

  const PlannedMeal({
    this.recipeId,
    this.recipeName,
    this.servings,
    this.notes,
    this.isCooked = false,
    this.cookedAt,
  });

  PlannedMeal copyWith({
    String? recipeId,
    String? recipeName,
    int? servings,
    String? notes,
    bool? isCooked,
    DateTime? cookedAt,
  }) {
    return PlannedMeal(
      recipeId: recipeId ?? this.recipeId,
      recipeName: recipeName ?? this.recipeName,
      servings: servings ?? this.servings,
      notes: notes ?? this.notes,
      isCooked: isCooked ?? this.isCooked,
      cookedAt: cookedAt ?? this.cookedAt,
    );
  }

  Map<String, dynamic> toJson() => {
        'recipeId': recipeId,
        'recipeName': recipeName,
        'servings': servings,
        'notes': notes,
        'isCooked': isCooked,
        'cookedAt': cookedAt?.toIso8601String(),
      };

  factory PlannedMeal.fromJson(Map<String, dynamic> json) => PlannedMeal(
        recipeId: json['recipeId'],
        recipeName: json['recipeName'],
        servings: json['servings'],
        notes: json['notes'],
        isCooked: json['isCooked'] ?? false,
        cookedAt: json['cookedAt'] != null
            ? DateTime.tryParse(json['cookedAt'])
            : null,
      );
}

class NutritionSummary {
  final double totalCalories;
  final double totalProtein;
  final double totalCarbs;
  final double totalFat;
  final double totalFiber;
  final double totalSodium;
  final Map<String, double> dailyAverages;
  final Map<String, double> weeklyTotals;

  const NutritionSummary({
    required this.totalCalories,
    required this.totalProtein,
    required this.totalCarbs,
    required this.totalFat,
    required this.totalFiber,
    required this.totalSodium,
    required this.dailyAverages,
    required this.weeklyTotals,
  });

  NutritionSummary copyWith({
    double? totalCalories,
    double? totalProtein,
    double? totalCarbs,
    double? totalFat,
    double? totalFiber,
    double? totalSodium,
    Map<String, double>? dailyAverages,
    Map<String, double>? weeklyTotals,
  }) {
    return NutritionSummary(
      totalCalories: totalCalories ?? this.totalCalories,
      totalProtein: totalProtein ?? this.totalProtein,
      totalCarbs: totalCarbs ?? this.totalCarbs,
      totalFat: totalFat ?? this.totalFat,
      totalFiber: totalFiber ?? this.totalFiber,
      totalSodium: totalSodium ?? this.totalSodium,
      dailyAverages: dailyAverages ?? this.dailyAverages,
      weeklyTotals: weeklyTotals ?? this.weeklyTotals,
    );
  }

  Map<String, dynamic> toJson() => {
        'totalCalories': totalCalories,
        'totalProtein': totalProtein,
        'totalCarbs': totalCarbs,
        'totalFat': totalFat,
        'totalFiber': totalFiber,
        'totalSodium': totalSodium,
        'dailyAverages': dailyAverages,
        'weeklyTotals': weeklyTotals,
      };

  factory NutritionSummary.fromJson(Map<String, dynamic> json) =>
      NutritionSummary(
        totalCalories: (json['totalCalories'] ?? 0.0).toDouble(),
        totalProtein: (json['totalProtein'] ?? 0.0).toDouble(),
        totalCarbs: (json['totalCarbs'] ?? 0.0).toDouble(),
        totalFat: (json['totalFat'] ?? 0.0).toDouble(),
        totalFiber: (json['totalFiber'] ?? 0.0).toDouble(),
        totalSodium: (json['totalSodium'] ?? 0.0).toDouble(),
        dailyAverages: Map<String, double>.from(json['dailyAverages'] ?? {}),
        weeklyTotals: Map<String, double>.from(json['weeklyTotals'] ?? {}),
      );
}

class PrepSchedule {
  final List<PrepTask> tasks;
  final DateTime suggestedStartTime;
  final Duration totalPrepTime;

  const PrepSchedule({
    required this.tasks,
    required this.suggestedStartTime,
    required this.totalPrepTime,
  });

  PrepSchedule copyWith({
    List<PrepTask>? tasks,
    DateTime? suggestedStartTime,
    Duration? totalPrepTime,
  }) {
    return PrepSchedule(
      tasks: tasks ?? this.tasks,
      suggestedStartTime: suggestedStartTime ?? this.suggestedStartTime,
      totalPrepTime: totalPrepTime ?? this.totalPrepTime,
    );
  }

  Map<String, dynamic> toJson() => {
        'tasks': tasks.map((t) => t.toJson()).toList(),
        'suggestedStartTime': suggestedStartTime.toIso8601String(),
        'totalPrepTime': totalPrepTime.inMinutes,
      };

  factory PrepSchedule.fromJson(Map<String, dynamic> json) => PrepSchedule(
        tasks: (json['tasks'] as List?)
                ?.map((t) => PrepTask.fromJson(t))
                .toList() ??
            [],
        suggestedStartTime:
            DateTime.tryParse(json['suggestedStartTime'] ?? '') ??
                DateTime.now(),
        totalPrepTime: Duration(minutes: json['totalPrepTime'] ?? 0),
      );
}

class PrepTask {
  final String id;
  final String task;
  final Duration duration;
  final DateTime? scheduledTime;
  final bool isCompleted;
  final List<String>? ingredients;
  final String? notes;

  const PrepTask({
    required this.id,
    required this.task,
    required this.duration,
    this.scheduledTime,
    this.isCompleted = false,
    this.ingredients,
    this.notes,
  });

  PrepTask copyWith({
    String? id,
    String? task,
    Duration? duration,
    DateTime? scheduledTime,
    bool? isCompleted,
    List<String>? ingredients,
    String? notes,
  }) {
    return PrepTask(
      id: id ?? this.id,
      task: task ?? this.task,
      duration: duration ?? this.duration,
      scheduledTime: scheduledTime ?? this.scheduledTime,
      isCompleted: isCompleted ?? this.isCompleted,
      ingredients: ingredients ?? this.ingredients,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'task': task,
        'duration': duration.inMinutes,
        'scheduledTime': scheduledTime?.toIso8601String(),
        'isCompleted': isCompleted,
        'ingredients': ingredients,
        'notes': notes,
      };

  factory PrepTask.fromJson(Map<String, dynamic> json) => PrepTask(
        id: json['id'] ?? '',
        task: json['task'] ?? '',
        duration: Duration(minutes: json['duration'] ?? 0),
        scheduledTime: json['scheduledTime'] != null
            ? DateTime.tryParse(json['scheduledTime'])
            : null,
        isCompleted: json['isCompleted'] ?? false,
        ingredients: json['ingredients'] != null
            ? List<String>.from(json['ingredients'])
            : null,
        notes: json['notes'],
      );
}
