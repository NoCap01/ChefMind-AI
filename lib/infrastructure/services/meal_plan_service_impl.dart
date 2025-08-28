import 'dart:math';

import '../../domain/entities/meal_plan.dart';
import '../../domain/entities/recipe.dart';
import '../../domain/entities/pantry_item.dart';
import '../../domain/entities/shopping_list.dart';
import '../../domain/repositories/meal_plan_repository.dart';
import '../../domain/services/meal_plan_service.dart';
import '../../domain/exceptions/app_exceptions.dart';

class MealPlanServiceImpl implements IMealPlanService {
  final IMealPlanRepository _repository;

  MealPlanServiceImpl(this._repository);

  @override
  Future<MealPlan> generateMealPlan(
    String userId,
    DateTime startDate,
    int durationDays,
    MealPlanPreferences preferences,
    NutritionGoals? nutritionGoals,
  ) async {
    try {
      final endDate = startDate.add(Duration(days: durationDays - 1));
      final days = <MealPlanDay>[];

      // Generate meals for each day
      for (int i = 0; i < durationDays; i++) {
        final currentDate = startDate.add(Duration(days: i));
        final dayMeals = await _generateMealsForDay(
          userId,
          currentDate,
          preferences,
          nutritionGoals,
        );
        
        final nutritionSummary = MealPlanUtils.calculateNutritionSummary(dayMeals, nutritionGoals);
        
        days.add(MealPlanDay(
          date: currentDate,
          meals: dayMeals,
          nutritionSummary: nutritionSummary,
          estimatedCost: MealPlanUtils.calculateDailyCost(dayMeals),
          prepTimeMinutes: MealPlanUtils.calculateDailyPrepTime(dayMeals),
        ));
      }

      final mealPlan = MealPlan(
        id: _generateId(),
        name: 'AI Generated Meal Plan',
        userId: userId,
        startDate: startDate,
        endDate: endDate,
        days: days,
        createdAt: DateTime.now(),
        nutritionGoals: nutritionGoals,
        preferences: preferences,
      );

      return await _repository.createMealPlan(mealPlan);
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServiceException('Failed to generate meal plan: $e');
    }
  }

  @override
  Future<MealPlan> generateFromRecipes(
    String userId,
    DateTime startDate,
    List<Recipe> recipes,
    MealPlanPreferences preferences,
  ) async {
    try {
      final durationDays = (recipes.length / preferences.preferredMealTypes.length).ceil();
      final endDate = startDate.add(Duration(days: durationDays - 1));
      final days = <MealPlanDay>[];

      int recipeIndex = 0;
      for (int i = 0; i < durationDays; i++) {
        final currentDate = startDate.add(Duration(days: i));
        final dayMeals = <PlannedMeal>[];

        // Assign recipes to meal types for this day
        for (final mealType in preferences.preferredMealTypes) {
          if (recipeIndex < recipes.length) {
            final recipe = recipes[recipeIndex];
            final meal = _createPlannedMealFromRecipe(recipe, mealType, currentDate);
            dayMeals.add(meal);
            recipeIndex++;
          }
        }

        final nutritionSummary = MealPlanUtils.calculateNutritionSummary(dayMeals, null);
        
        days.add(MealPlanDay(
          date: currentDate,
          meals: dayMeals,
          nutritionSummary: nutritionSummary,
          estimatedCost: MealPlanUtils.calculateDailyCost(dayMeals),
          prepTimeMinutes: MealPlanUtils.calculateDailyPrepTime(dayMeals),
        ));
      }

      final mealPlan = MealPlan(
        id: _generateId(),
        name: 'Recipe-Based Meal Plan',
        userId: userId,
        startDate: startDate,
        endDate: endDate,
        days: days,
        createdAt: DateTime.now(),
        preferences: preferences,
      );

      return await _repository.createMealPlan(mealPlan);
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServiceException('Failed to generate meal plan from recipes: $e');
    }
  }

  @override
  Future<MealPlan> optimizeForNutrition(
    MealPlan mealPlan,
    NutritionGoals goals,
  ) async {
    try {
      final optimizedDays = <MealPlanDay>[];

      for (final day in mealPlan.days) {
        final optimizedMeals = await _optimizeDayForNutrition(day.meals, goals);
        final nutritionSummary = MealPlanUtils.calculateNutritionSummary(optimizedMeals, goals);
        
        optimizedDays.add(day.copyWith(
          meals: optimizedMeals,
          nutritionSummary: nutritionSummary,
        ));
      }

      final optimizedPlan = mealPlan.copyWith(
        days: optimizedDays,
        nutritionGoals: goals,
        updatedAt: DateTime.now(),
      );

      return await _repository.updateMealPlan(optimizedPlan);
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServiceException('Failed to optimize meal plan for nutrition: $e');
    }
  }

  @override
  Future<MealPlan> optimizeForBatchCooking(MealPlan mealPlan) async {
    try {
      // Group similar recipes and ingredients for batch cooking
      final batchGroups = _identifyBatchCookingOpportunities(mealPlan);
      final optimizedDays = <MealPlanDay>[];

      for (final day in mealPlan.days) {
        // Adjust meal timing and grouping for batch cooking efficiency
        final optimizedMeals = _optimizeMealsForBatching(day.meals, batchGroups);
        
        optimizedDays.add(day.copyWith(
          meals: optimizedMeals,
          prepTimeMinutes: _calculateOptimizedPrepTime(optimizedMeals),
        ));
      }

      final optimizedPlan = mealPlan.copyWith(
        days: optimizedDays,
        updatedAt: DateTime.now(),
      );

      return await _repository.updateMealPlan(optimizedPlan);
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServiceException('Failed to optimize meal plan for batch cooking: $e');
    }
  }

  @override
  Future<List<BatchCookingSession>> generateBatchCookingSchedule(
    MealPlan mealPlan,
    DateTime prepDate,
  ) async {
    try {
      final sessions = <BatchCookingSession>[];
      final batchGroups = _identifyBatchCookingOpportunities(mealPlan);

      for (final group in batchGroups) {
        final session = BatchCookingSession(
          id: _generateId(),
          mealPlanId: mealPlan.id,
          scheduledDate: prepDate,
          recipeIds: group.recipeIds,
          ingredients: group.ingredients,
          totalPrepTimeMinutes: group.totalPrepTime,
          estimatedTimeMinutes: group.optimizedPrepTime,
          equipment: group.requiredEquipment,
          steps: _generateBatchCookingSteps(group),
        );
        
        sessions.add(session);
      }

      return sessions;
    } catch (e) {
      throw ServiceException('Failed to generate batch cooking schedule: $e');
    }
  }

  @override
  Future<NutritionBalance> calculateNutritionBalance(
    MealPlan mealPlan,
    NutritionGoals goals,
  ) async {
    try {
      double totalCalories = 0;
      double totalProtein = 0;
      double totalCarbs = 0;
      double totalFat = 0;
      double totalFiber = 0;

      // Calculate totals across all days
      for (final day in mealPlan.days) {
        if (day.nutritionSummary != null) {
          totalCalories += day.nutritionSummary!.totalCalories;
          totalProtein += day.nutritionSummary!.totalProtein;
          totalCarbs += day.nutritionSummary!.totalCarbs;
          totalFat += day.nutritionSummary!.totalFat;
          totalFiber += day.nutritionSummary!.totalFiber;
        }
      }

      final daysCount = mealPlan.days.length;
      final avgCalories = totalCalories / daysCount;
      final avgProtein = totalProtein / daysCount;
      final avgCarbs = totalCarbs / daysCount;
      final avgFat = totalFat / daysCount;
      final avgFiber = totalFiber / daysCount;

      // Calculate balance percentages
      final calorieBalance = (avgCalories / goals.dailyCalories) * 100;
      final proteinBalance = (avgProtein / goals.proteinGrams) * 100;
      final carbBalance = (avgCarbs / goals.carbsGrams) * 100;
      final fatBalance = (avgFat / goals.fatGrams) * 100;
      final fiberBalance = (avgFiber / goals.fiberGrams) * 100;

      // Identify deficiencies and excesses
      final deficiencies = <NutritionDeficiency>[];
      final excesses = <NutritionExcess>[];

      if (calorieBalance < 90) {
        deficiencies.add(NutritionDeficiency(
          nutrient: 'Calories',
          currentAmount: avgCalories,
          targetAmount: goals.dailyCalories,
          deficitPercentage: 100 - calorieBalance,
          suggestedFoods: ['nuts', 'avocado', 'olive oil'],
        ));
      } else if (calorieBalance > 110) {
        excesses.add(NutritionExcess(
          nutrient: 'Calories',
          currentAmount: avgCalories,
          targetAmount: goals.dailyCalories,
          excessPercentage: calorieBalance - 100,
          reductionSuggestions: ['reduce portion sizes', 'choose lower calorie options'],
        ));
      }

      return NutritionBalance(
        calorieBalance: calorieBalance,
        proteinBalance: proteinBalance,
        carbBalance: carbBalance,
        fatBalance: fatBalance,
        fiberBalance: fiberBalance,
        vitaminBalance: {},
        mineralBalance: {},
        deficiencies: deficiencies,
        excesses: excesses,
      );
    } catch (e) {
      throw ServiceException('Failed to calculate nutrition balance: $e');
    }
  }

  @override
  Future<ShoppingList> generateShoppingList(
    MealPlan mealPlan,
    List<PantryItem> pantryItems,
  ) async {
    try {
      final allIngredients = <String, double>{};
      
      // Collect all ingredients from meal plan
      for (final day in mealPlan.days) {
        for (final meal in day.meals) {
          for (final ingredient in meal.ingredients) {
            // Parse ingredient string to extract quantity and name
            final parsed = _parseIngredient(ingredient);
            final key = '${parsed.name}_${parsed.unit}';
            allIngredients[key] = (allIngredients[key] ?? 0) + parsed.quantity;
          }
        }
      }

      // Convert to shopping list items, excluding pantry items
      final shoppingItems = <ShoppingListItem>[];
      for (final entry in allIngredients.entries) {
        final parsed = _parseIngredientKey(entry.key);
        
        // Check if we have enough in pantry
        if (!_hasEnoughInPantry(parsed.name, entry.value, parsed.unit, pantryItems)) {
          shoppingItems.add(ShoppingListItem(
            id: _generateId(),
            name: parsed.name,
            quantity: entry.value,
            unit: parsed.unit,
            category: _getCategoryForIngredient(parsed.name),
            addedAt: DateTime.now(),
            addedBy: mealPlan.userId,
            estimatedPrice: _estimatePrice(parsed.name, entry.value),
          ));
        }
      }

      final shoppingList = ShoppingList(
        id: _generateId(),
        name: '${mealPlan.name} - Shopping List',
        userId: mealPlan.userId,
        items: shoppingItems,
        createdAt: DateTime.now(),
      );

      return shoppingList;
    } catch (e) {
      throw ServiceException('Failed to generate shopping list: $e');
    }
  }

  // Placeholder implementations for remaining methods
  @override
  Future<List<PlannedMeal>> suggestMealReplacements(
    PlannedMeal originalMeal,
    MealPlanPreferences preferences,
    NutritionGoals? nutritionGoals,
  ) async {
    throw UnimplementedError();
  }

  @override
  Future<PrepTimeSchedule> optimizePrepTimeSchedule(
    MealPlan mealPlan,
    DateTime targetDate,
  ) async {
    throw UnimplementedError();
  }

  @override
  Future<List<PlannedMeal>> suggestLeftoverMeals(
    List<PlannedMeal> previousMeals,
    DateTime targetDate,
  ) async {
    throw UnimplementedError();
  }

  @override
  Future<double> calculateMealPlanCost(MealPlan mealPlan) async {
    throw UnimplementedError();
  }

  @override
  Future<List<PlannedMeal>> getMealSuggestions(
    String userId,
    DateTime date,
    MealType mealType,
    MealPlanPreferences preferences,
    NutritionGoals? nutritionGoals,
  ) async {
    throw UnimplementedError();
  }

  @override
  Future<NutritionValidation> validateNutrition(
    MealPlan mealPlan,
    NutritionGoals goals,
  ) async {
    throw UnimplementedError();
  }

  @override
  Future<List<MealPrepInstruction>> generateMealPrepInstructions(
    List<PlannedMeal> meals,
    DateTime prepDate,
  ) async {
    throw UnimplementedError();
  }

  @override
  Future<MealPlan> optimizeForDietaryRestrictions(
    MealPlan mealPlan,
    List<DietaryRestriction> restrictions,
    List<String> allergies,
  ) async {
    throw UnimplementedError();
  }

  @override
  Future<PrepTimeOptimization> calculatePrepTimeOptimization(
    List<PlannedMeal> meals,
  ) async {
    throw UnimplementedError();
  }

  @override
  Future<MealPlan> generateWeeklyMealPlan(
    String userId,
    DateTime weekStartDate,
    MealPlanPreferences preferences,
    NutritionGoals? nutritionGoals,
  ) async {
    return await generateMealPlan(userId, weekStartDate, 7, preferences, nutritionGoals);
  }

  @override
  Future<List<BatchCookingSession>> autoScheduleMealPrep(
    MealPlan mealPlan,
    List<DateTime> availableDates,
  ) async {
    throw UnimplementedError();
  }

  // Helper methods
  String _generateId() {
    return DateTime.now().millisecondsSinceEpoch.toString() + 
           Random().nextInt(1000).toString();
  }

  Future<List<PlannedMeal>> _generateMealsForDay(
    String userId,
    DateTime date,
    MealPlanPreferences preferences,
    NutritionGoals? nutritionGoals,
  ) async {
    final meals = <PlannedMeal>[];
    
    for (final mealType in preferences.preferredMealTypes) {
      final meal = _generateMockMeal(mealType, date, preferences);
      meals.add(meal);
    }
    
    return meals;
  }

  PlannedMeal _generateMockMeal(MealType mealType, DateTime date, MealPlanPreferences preferences) {
    final mealNames = _getMealNamesForType(mealType);
    final randomName = mealNames[Random().nextInt(mealNames.length)];
    
    return PlannedMeal(
      id: _generateId(),
      mealType: mealType,
      scheduledTime: mealType.getDefaultTime(date),
      customMealName: randomName,
      servings: preferences.defaultServings,
      ingredients: _getMockIngredients(randomName),
      prepTimeMinutes: Random().nextInt(30) + 10,
      cookTimeMinutes: Random().nextInt(45) + 15,
      nutrition: _getMockNutrition(),
      estimatedCost: Random().nextDouble() * 15 + 5,
    );
  }

  List<String> _getMealNamesForType(MealType mealType) {
    switch (mealType) {
      case MealType.breakfast:
        return ['Oatmeal', 'Scrambled Eggs', 'Pancakes', 'Smoothie Bowl'];
      case MealType.lunch:
        return ['Grilled Chicken Salad', 'Sandwich', 'Soup', 'Pasta'];
      case MealType.dinner:
        return ['Salmon with Vegetables', 'Stir Fry', 'Roast Chicken', 'Tacos'];
      default:
        return ['Healthy Snack', 'Fruit', 'Nuts', 'Yogurt'];
    }
  }

  List<String> _getMockIngredients(String mealName) {
    // Return mock ingredients based on meal name
    return ['2 cups ingredient 1', '1 tbsp ingredient 2', '1 piece ingredient 3'];
  }

  NutritionInfo _getMockNutrition() {
    return NutritionInfo(
      calories: Random().nextDouble() * 400 + 200,
      protein: Random().nextDouble() * 30 + 10,
      carbs: Random().nextDouble() * 50 + 20,
      fat: Random().nextDouble() * 20 + 5,
      fiber: Random().nextDouble() * 10 + 2,
      sugar: Random().nextDouble() * 15 + 5,
      sodium: Random().nextDouble() * 800 + 200,
    );
  }

  PlannedMeal _createPlannedMealFromRecipe(Recipe recipe, MealType mealType, DateTime date) {
    return PlannedMeal(
      id: _generateId(),
      mealType: mealType,
      scheduledTime: mealType.getDefaultTime(date),
      recipeId: recipe.id,
      recipeName: recipe.title,
      servings: recipe.servings,
      ingredients: recipe.ingredients.map((ing) => '${ing.quantity} ${ing.unit} ${ing.name}').toList(),
      prepTimeMinutes: recipe.prepTime.inMinutes,
      cookTimeMinutes: recipe.cookingTime.inMinutes,
      nutrition: recipe.nutrition,
      estimatedCost: _estimateRecipeCost(recipe),
    );
  }

  double _estimateRecipeCost(Recipe recipe) {
    // Basic cost estimation
    return recipe.ingredients.length * 2.5;
  }

  Future<List<PlannedMeal>> _optimizeDayForNutrition(
    List<PlannedMeal> meals,
    NutritionGoals goals,
  ) async {
    // Placeholder optimization logic
    return meals;
  }

  List<BatchGroup> _identifyBatchCookingOpportunities(MealPlan mealPlan) {
    // Placeholder batch grouping logic
    return [];
  }

  List<PlannedMeal> _optimizeMealsForBatching(
    List<PlannedMeal> meals,
    List<BatchGroup> batchGroups,
  ) {
    // Placeholder batching optimization
    return meals;
  }

  int _calculateOptimizedPrepTime(List<PlannedMeal> meals) {
    return meals.fold(0, (sum, meal) => sum + meal.prepTimeMinutes);
  }

  List<BatchCookingStep> _generateBatchCookingSteps(BatchGroup group) {
    return [];
  }

  ParsedIngredient _parseIngredient(String ingredient) {
    // Basic ingredient parsing
    final parts = ingredient.split(' ');
    if (parts.length >= 3) {
      final quantity = double.tryParse(parts[0]) ?? 1.0;
      final unit = parts[1];
      final name = parts.sublist(2).join(' ');
      return ParsedIngredient(name: name, quantity: quantity, unit: unit);
    }
    return ParsedIngredient(name: ingredient, quantity: 1.0, unit: 'piece');
  }

  ParsedIngredient _parseIngredientKey(String key) {
    final parts = key.split('_');
    return ParsedIngredient(
      name: parts[0],
      quantity: 1.0,
      unit: parts.length > 1 ? parts[1] : 'piece',
    );
  }

  bool _hasEnoughInPantry(String name, double needed, String unit, List<PantryItem> pantryItems) {
    for (final item in pantryItems) {
      if (item.name.toLowerCase() == name.toLowerCase() && 
          item.unit == unit && 
          item.quantity >= needed) {
        return true;
      }
    }
    return false;
  }

  String _getCategoryForIngredient(String name) {
    // Basic categorization logic
    return 'produce';
  }

  double _estimatePrice(String name, double quantity) {
    return quantity * 2.0; // Basic price estimation
  }
}

class BatchGroup {
  final List<String> recipeIds;
  final List<String> ingredients;
  final int totalPrepTime;
  final int optimizedPrepTime;
  final List<String> requiredEquipment;

  BatchGroup({
    required this.recipeIds,
    required this.ingredients,
    required this.totalPrepTime,
    required this.optimizedPrepTime,
    required this.requiredEquipment,
  });
}

class ParsedIngredient {
  final String name;
  final double quantity;
  final String unit;

  ParsedIngredient({
    required this.name,
    required this.quantity,
    required this.unit,
  });
}