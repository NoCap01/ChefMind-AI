import 'package:hive/hive.dart';
import '../domain/entities/recipe.dart';

// Meal plan data structure for Hive storage
@HiveType(typeId: 10)
class MealPlan extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  DateTime startDate;

  @HiveField(3)
  DateTime endDate;

  @HiveField(4)
  Map<String, Map<String, String?>> meals; // date -> mealType -> recipeId

  @HiveField(5)
  bool isActive;

  @HiveField(6)
  DateTime createdAt;

  @HiveField(7)
  DateTime updatedAt;

  MealPlan({
    required this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.meals,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MealPlan.create({
    required String name,
    required DateTime startDate,
    required DateTime endDate,
    Map<String, Map<String, String?>>? meals,
  }) {
    final now = DateTime.now();
    return MealPlan(
      id: now.millisecondsSinceEpoch.toString(),
      name: name,
      startDate: startDate,
      endDate: endDate,
      meals: meals ?? {},
      createdAt: now,
      updatedAt: now,
    );
  }

  MealPlan copyWith({
    String? id,
    String? name,
    DateTime? startDate,
    DateTime? endDate,
    Map<String, Map<String, String?>>? meals,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MealPlan(
      id: id ?? this.id,
      name: name ?? this.name,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      meals: meals ?? this.meals,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }
}

class MealPlannerService {
  static const String _boxName = 'meal_plans';
  Box<MealPlan>? _box;

  Future<void> initialize() async {
    if (!Hive.isBoxOpen(_boxName)) {
      _box = await Hive.openBox<MealPlan>(_boxName);
    } else {
      _box = Hive.box<MealPlan>(_boxName);
    }
  }

  Box<MealPlan> get _mealPlanBox {
    if (_box == null || !_box!.isOpen) {
      throw Exception(
          'Meal planner service not initialized. Call initialize() first.');
    }
    return _box!;
  }

  // Save meal plan
  Future<void> saveMealPlan(MealPlan mealPlan) async {
    await _mealPlanBox.put(mealPlan.id, mealPlan);
  }

  // Get active meal plan
  MealPlan? getActiveMealPlan() {
    return _mealPlanBox.values.where((plan) => plan.isActive).firstOrNull;
  }

  // Get all meal plans
  List<MealPlan> getAllMealPlans() {
    return _mealPlanBox.values.toList();
  }

  // Update meal plan
  Future<void> updateMealPlan(MealPlan mealPlan) async {
    mealPlan.updatedAt = DateTime.now();
    await _mealPlanBox.put(mealPlan.id, mealPlan);
  }

  // Delete meal plan
  Future<void> deleteMealPlan(String id) async {
    await _mealPlanBox.delete(id);
  }

  // Set active meal plan
  Future<void> setActiveMealPlan(String id) async {
    // Deactivate all plans
    for (final plan in _mealPlanBox.values) {
      if (plan.isActive) {
        plan.isActive = false;
        await _mealPlanBox.put(plan.id, plan);
      }
    }

    // Activate the selected plan
    final plan = _mealPlanBox.get(id);
    if (plan != null) {
      plan.isActive = true;
      await _mealPlanBox.put(id, plan);
    }
  }

  // Clear all meal plans
  Future<void> clearAll() async {
    await _mealPlanBox.clear();
  }
}
