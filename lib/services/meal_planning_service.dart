import '../domain/entities/meal_plan.dart';
import '../domain/entities/recipe.dart';
import '../domain/enums/meal_type.dart';
import '../services/recipe_storage_service.dart';
import '../services/shopping_list_service.dart';
import '../domain/entities/shopping_list.dart';

class MealPlanningService {
  final RecipeStorageService _recipeStorageService;
  final ShoppingListService _shoppingListService;

  MealPlanningService(this._recipeStorageService, this._shoppingListService);

  /// Create a new meal plan for a date range
  Future<MealPlan> createMealPlan({
    required String userId,
    required String name,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final dailyPlans = <DailyMealPlan>[];
    
    // Create empty daily plans for each day in the range
    for (var date = startDate; 
         date.isBefore(endDate.add(const Duration(days: 1))); 
         date = date.add(const Duration(days: 1))) {
      dailyPlans.add(DailyMealPlan(
        date: date,
        meals: {
          for (final mealType in MealType.values) mealType: null,
        },
        notes: '',
        plannedCalories: 0.0,
        isCompleted: false,
      ));
    }

    return MealPlan(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: userId,
      name: name,
      startDate: startDate,
      endDate: endDate,
      dailyPlans: dailyPlans,
      notes: [],
      isActive: true,
      createdAt: DateTime.now(),
    );
  }

  /// Add a recipe to a specific meal slot
  Future<MealPlan> assignMealToSlot({
    required MealPlan mealPlan,
    required DateTime date,
    required MealType mealType,
    required String recipeId,
    int servings = 1,
    String? notes,
  }) async {
    final recipe = await _recipeStorageService.getRecipeById(recipeId);
    if (recipe == null) {
      throw Exception('Recipe not found');
    }

    final updatedDailyPlans = mealPlan.dailyPlans.map((dailyPlan) {
      if (_isSameDay(dailyPlan.date, date)) {
        final plannedMeal = PlannedMeal(
          recipeId: recipeId,
          recipeName: recipe.title,
          servings: servings,
          notes: notes,
          isCooked: false,
        );

        final updatedMeals = Map<MealType, PlannedMeal?>.from(dailyPlan.meals);
        updatedMeals[mealType] = plannedMeal;

        return dailyPlan.copyWith(
          meals: updatedMeals,
          plannedCalories: _calculateDailyCalories(updatedMeals),
        );
      }
      return dailyPlan;
    }).toList();

    return mealPlan.copyWith(
      dailyPlans: updatedDailyPlans,
      updatedAt: DateTime.now(),
    );
  }

  /// Remove a meal from a specific slot
  Future<MealPlan> removeMealFromSlot({
    required MealPlan mealPlan,
    required DateTime date,
    required MealType mealType,
  }) async {
    final updatedDailyPlans = mealPlan.dailyPlans.map((dailyPlan) {
      if (_isSameDay(dailyPlan.date, date)) {
        final updatedMeals = Map<MealType, PlannedMeal?>.from(dailyPlan.meals);
        updatedMeals[mealType] = null;

        return dailyPlan.copyWith(
          meals: updatedMeals,
          plannedCalories: _calculateDailyCalories(updatedMeals),
        );
      }
      return dailyPlan;
    }).toList();

    return mealPlan.copyWith(
      dailyPlans: updatedDailyPlans,
      updatedAt: DateTime.now(),
    );
  }

  /// Mark a meal as cooked
  Future<MealPlan> markMealAsCooked({
    required MealPlan mealPlan,
    required DateTime date,
    required MealType mealType,
    required bool isCooked,
  }) async {
    final updatedDailyPlans = mealPlan.dailyPlans.map((dailyPlan) {
      if (_isSameDay(dailyPlan.date, date)) {
        final currentMeal = dailyPlan.meals[mealType];
        if (currentMeal != null) {
          final updatedMeals = Map<MealType, PlannedMeal?>.from(dailyPlan.meals);
          updatedMeals[mealType] = currentMeal.copyWith(
            isCooked: isCooked,
            cookedAt: isCooked ? DateTime.now() : null,
          );

          return dailyPlan.copyWith(
            meals: updatedMeals,
            isCompleted: _isDayCompleted(updatedMeals),
          );
        }
      }
      return dailyPlan;
    }).toList();

    return mealPlan.copyWith(
      dailyPlans: updatedDailyPlans,
      updatedAt: DateTime.now(),
    );
  }

  /// Generate shopping list from meal plan
  Future<ShoppingList> generateShoppingListFromMealPlan({
    required MealPlan mealPlan,
    String? listName,
  }) async {
    final ingredients = <String, ShoppingItem>{};
    
    for (final dailyPlan in mealPlan.dailyPlans) {
      for (final meal in dailyPlan.meals.values) {
        if (meal?.recipeId != null) {
          final recipe = await _recipeStorageService.getRecipeById(meal!.recipeId!);
          if (recipe != null) {
            for (final ingredient in recipe.ingredients) {
              final key = '${ingredient.name}_${ingredient.unit}';
              if (ingredients.containsKey(key)) {
                final existing = ingredients[key]!;
                ingredients[key] = existing.copyWith(
                  quantity: existing.quantity + (ingredient.quantity * meal.servings!),
                );
              } else {
                ingredients[key] = ShoppingItem(
                  id: DateTime.now().millisecondsSinceEpoch.toString() + key,
                  name: ingredient.name,
                  category: ingredient.category ?? 'Other',
                  quantity: ingredient.quantity * meal.servings!,
                  unit: ingredient.unit,
                  addedAt: DateTime.now(),
                );
              }
            }
          }
        }
      }
    }

    return ShoppingList(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: listName ?? '${mealPlan.name} Shopping List',
      userId: mealPlan.userId,
      items: ingredients.values.toList(),
      createdAt: DateTime.now(),
    );
  }

  /// Get daily meal plan for a specific date
  DailyMealPlan? getDailyMealPlan(MealPlan mealPlan, DateTime date) {
    return mealPlan.dailyPlans.firstWhere(
      (dailyPlan) => _isSameDay(dailyPlan.date, date),
      orElse: () => DailyMealPlan(
        date: date,
        meals: {for (final mealType in MealType.values) mealType: null},
        notes: '',
        plannedCalories: 0.0,
        isCompleted: false,
      ),
    );
  }

  /// Calculate nutrition summary for the meal plan
  Future<NutritionSummary> calculateNutritionSummary(MealPlan mealPlan) async {
    double totalCalories = 0;
    double totalProtein = 0;
    double totalCarbs = 0;
    double totalFat = 0;
    double totalFiber = 0;
    double totalSodium = 0;

    final dailyCalories = <String, double>{};
    final dailyProtein = <String, double>{};
    final dailyCarbs = <String, double>{};
    final dailyFat = <String, double>{};
    
    for (final dailyPlan in mealPlan.dailyPlans) {
      double dayCalories = 0;
      double dayProtein = 0;
      double dayCarbs = 0;
      double dayFat = 0;
      double dayFiber = 0;
      double daySodium = 0;
      
      for (final meal in dailyPlan.meals.values) {
        if (meal?.recipeId != null) {
          final recipe = await _recipeStorageService.getRecipeById(meal!.recipeId!);
          if (recipe != null) {
            // Calculate nutrition based on recipe and servings
            final nutrition = _calculateRecipeNutrition(recipe, meal.servings ?? 1);
            
            dayCalories += nutrition['calories'] ?? 0;
            dayProtein += nutrition['protein'] ?? 0;
            dayCarbs += nutrition['carbs'] ?? 0;
            dayFat += nutrition['fat'] ?? 0;
            dayFiber += nutrition['fiber'] ?? 0;
            daySodium += nutrition['sodium'] ?? 0;
          }
        }
      }
      
      totalCalories += dayCalories;
      totalProtein += dayProtein;
      totalCarbs += dayCarbs;
      totalFat += dayFat;
      totalFiber += dayFiber;
      totalSodium += daySodium;
      
      final dateKey = dailyPlan.date.toIso8601String();
      dailyCalories[dateKey] = dayCalories;
      dailyProtein[dateKey] = dayProtein;
      dailyCarbs[dateKey] = dayCarbs;
      dailyFat[dateKey] = dayFat;
    }

    final days = mealPlan.dailyPlans.length;
    return NutritionSummary(
      totalCalories: totalCalories,
      totalProtein: totalProtein,
      totalCarbs: totalCarbs,
      totalFat: totalFat,
      totalFiber: totalFiber,
      totalSodium: totalSodium,
      dailyAverages: {
        'calories': days > 0 ? totalCalories / days : 0,
        'protein': days > 0 ? totalProtein / days : 0,
        'carbs': days > 0 ? totalCarbs / days : 0,
        'fat': days > 0 ? totalFat / days : 0,
        'fiber': days > 0 ? totalFiber / days : 0,
        'sodium': days > 0 ? totalSodium / days : 0,
      },
      weeklyTotals: {
        'calories': totalCalories,
        'protein': totalProtein,
        'carbs': totalCarbs,
        'fat': totalFat,
        'fiber': totalFiber,
        'sodium': totalSodium,
        ...dailyCalories.map((key, value) => MapEntry('day_calories_$key', value)),
        ...dailyProtein.map((key, value) => MapEntry('day_protein_$key', value)),
        ...dailyCarbs.map((key, value) => MapEntry('day_carbs_$key', value)),
        ...dailyFat.map((key, value) => MapEntry('day_fat_$key', value)),
      },
    );
  }

  /// Calculate nutrition for a recipe based on ingredients
  Map<String, double> _calculateRecipeNutrition(Recipe recipe, int servings) {
    // Enhanced nutrition calculation based on ingredients
    // In a real app, this would use a nutrition database
    
    double calories = 0;
    double protein = 0;
    double carbs = 0;
    double fat = 0;
    double fiber = 0;
    double sodium = 0;

    for (final ingredient in recipe.ingredients) {
      final nutrition = _getIngredientNutrition(ingredient.name, ingredient.quantity);
      calories += nutrition['calories'] ?? 0;
      protein += nutrition['protein'] ?? 0;
      carbs += nutrition['carbs'] ?? 0;
      fat += nutrition['fat'] ?? 0;
      fiber += nutrition['fiber'] ?? 0;
      sodium += nutrition['sodium'] ?? 0;
    }

    // Adjust for servings
    return {
      'calories': (calories / recipe.metadata.servings) * servings,
      'protein': (protein / recipe.metadata.servings) * servings,
      'carbs': (carbs / recipe.metadata.servings) * servings,
      'fat': (fat / recipe.metadata.servings) * servings,
      'fiber': (fiber / recipe.metadata.servings) * servings,
      'sodium': (sodium / recipe.metadata.servings) * servings,
    };
  }

  /// Get estimated nutrition for an ingredient
  Map<String, double> _getIngredientNutrition(String ingredientName, double quantity) {
    // Simplified nutrition database - in a real app, this would be comprehensive
    final name = ingredientName.toLowerCase();
    
    // Base nutrition per 100g/100ml
    Map<String, double> baseNutrition = {};
    
    if (name.contains('chicken')) {
      baseNutrition = {'calories': 165, 'protein': 31, 'carbs': 0, 'fat': 3.6, 'fiber': 0, 'sodium': 74};
    } else if (name.contains('beef')) {
      baseNutrition = {'calories': 250, 'protein': 26, 'carbs': 0, 'fat': 15, 'fiber': 0, 'sodium': 72};
    } else if (name.contains('fish') || name.contains('salmon')) {
      baseNutrition = {'calories': 208, 'protein': 25, 'carbs': 0, 'fat': 12, 'fiber': 0, 'sodium': 59};
    } else if (name.contains('rice')) {
      baseNutrition = {'calories': 130, 'protein': 2.7, 'carbs': 28, 'fat': 0.3, 'fiber': 0.4, 'sodium': 5};
    } else if (name.contains('pasta')) {
      baseNutrition = {'calories': 131, 'protein': 5, 'carbs': 25, 'fat': 1.1, 'fiber': 1.8, 'sodium': 6};
    } else if (name.contains('bread')) {
      baseNutrition = {'calories': 265, 'protein': 9, 'carbs': 49, 'fat': 3.2, 'fiber': 2.7, 'sodium': 491};
    } else if (name.contains('egg')) {
      baseNutrition = {'calories': 155, 'protein': 13, 'carbs': 1.1, 'fat': 11, 'fiber': 0, 'sodium': 124};
    } else if (name.contains('milk')) {
      baseNutrition = {'calories': 42, 'protein': 3.4, 'carbs': 5, 'fat': 1, 'fiber': 0, 'sodium': 44};
    } else if (name.contains('cheese')) {
      baseNutrition = {'calories': 113, 'protein': 7, 'carbs': 1, 'fat': 9, 'fiber': 0, 'sodium': 215};
    } else if (name.contains('tomato')) {
      baseNutrition = {'calories': 18, 'protein': 0.9, 'carbs': 3.9, 'fat': 0.2, 'fiber': 1.2, 'sodium': 5};
    } else if (name.contains('onion')) {
      baseNutrition = {'calories': 40, 'protein': 1.1, 'carbs': 9.3, 'fat': 0.1, 'fiber': 1.7, 'sodium': 4};
    } else if (name.contains('carrot')) {
      baseNutrition = {'calories': 41, 'protein': 0.9, 'carbs': 9.6, 'fat': 0.2, 'fiber': 2.8, 'sodium': 69};
    } else if (name.contains('potato')) {
      baseNutrition = {'calories': 77, 'protein': 2, 'carbs': 17, 'fat': 0.1, 'fiber': 2.2, 'sodium': 6};
    } else if (name.contains('oil') || name.contains('butter')) {
      baseNutrition = {'calories': 884, 'protein': 0, 'carbs': 0, 'fat': 100, 'fiber': 0, 'sodium': 2};
    } else if (name.contains('sugar')) {
      baseNutrition = {'calories': 387, 'protein': 0, 'carbs': 100, 'fat': 0, 'fiber': 0, 'sodium': 0};
    } else if (name.contains('flour')) {
      baseNutrition = {'calories': 364, 'protein': 10, 'carbs': 76, 'fat': 1, 'fiber': 2.7, 'sodium': 2};
    } else {
      // Default values for unknown ingredients
      baseNutrition = {'calories': 50, 'protein': 2, 'carbs': 8, 'fat': 1, 'fiber': 1, 'sodium': 10};
    }

    // Scale by quantity (assuming quantity is in appropriate units)
    final scaleFactor = quantity / 100; // Assuming base nutrition is per 100g
    return baseNutrition.map((key, value) => MapEntry(key, value * scaleFactor));
  }

  /// Generate meal plan suggestions based on nutrition goals
  Future<List<String>> generateMealSuggestions({
    required MealType mealType,
    required Map<String, dynamic> nutritionGoals,
    List<String>? excludeRecipeIds,
  }) async {
    final availableRecipes = await _recipeStorageService.getSavedRecipes();
    
    final filteredRecipes = availableRecipes.where((recipe) {
      // Filter by meal type
      if (recipe.metadata.mealType != null && recipe.metadata.mealType != mealType) return false;
      
      // Exclude specified recipes
      if (excludeRecipeIds?.contains(recipe.id) == true) return false;
      
      return true;
    }).toList();

    // Score recipes based on nutrition goals
    final scoredRecipes = <MapEntry<Recipe, double>>[];
    
    for (final recipe in filteredRecipes) {
      final nutrition = _calculateRecipeNutrition(recipe, 1);
      final score = _scoreRecipeForNutrition(nutrition, nutritionGoals, mealType);
      scoredRecipes.add(MapEntry(recipe, score));
    }

    // Sort by score (highest first)
    scoredRecipes.sort((a, b) => b.value.compareTo(a.value));

    // Return top suggestions
    return scoredRecipes.take(5).map((entry) => entry.key.id).toList();
  }

  /// Score a recipe based on how well it matches nutrition goals
  double _scoreRecipeForNutrition(
    Map<String, double> nutrition,
    Map<String, dynamic> goals,
    MealType mealType,
  ) {
    double score = 0;

    final targetCalories = goals['calories'] ?? _getDefaultCaloriesForMealType(mealType);
    final targetProtein = goals['protein'] ?? _getDefaultProteinForMealType(mealType);
    
    // Score based on calorie proximity
    final caloriesDiff = (nutrition['calories']! - targetCalories).abs();
    score += (100 - (caloriesDiff / targetCalories * 100)).clamp(0, 100);
    
    // Score based on protein content
    final proteinScore = (nutrition['protein']! / targetProtein * 100).clamp(0, 100);
    score += proteinScore;
    
    // Bonus for fiber content
    score += (nutrition['fiber']! * 5).clamp(0, 20);
    
    // Penalty for excessive sodium
    if (nutrition['sodium']! > 800) {
      score -= 20;
    }

    return score / 3; // Average the scores
  }

  double _getDefaultCaloriesForMealType(MealType mealType) {
    switch (mealType) {
      case MealType.breakfast:
        return 350;
      case MealType.brunch:
        return 400;
      case MealType.lunch:
        return 450;
      case MealType.dinner:
        return 500;
      case MealType.snack:
        return 150;
      case MealType.dessert:
        return 200;
      case MealType.appetizer:
        return 100;
      case MealType.side:
        return 150;
      case MealType.drink:
        return 50;
    }
  }

  double _getDefaultProteinForMealType(MealType mealType) {
    switch (mealType) {
      case MealType.breakfast:
        return 15;
      case MealType.brunch:
        return 20;
      case MealType.lunch:
        return 25;
      case MealType.dinner:
        return 30;
      case MealType.snack:
        return 5;
      case MealType.dessert:
        return 3;
      case MealType.appetizer:
        return 8;
      case MealType.side:
        return 5;
      case MealType.drink:
        return 2;
    }
  }

  /// Auto-generate meal plan with balanced nutrition
  Future<MealPlan> autoGenerateMealPlan({
    required String userId,
    required String name,
    required DateTime startDate,
    required DateTime endDate,
    List<String>? preferredRecipeIds,
    Map<String, dynamic>? nutritionGoals,
  }) async {
    final availableRecipes = await _recipeStorageService.getSavedRecipes();
    if (availableRecipes.isEmpty) {
      throw Exception('No recipes available for meal planning');
    }

    final mealPlan = await createMealPlan(
      userId: userId,
      name: name,
      startDate: startDate,
      endDate: endDate,
    );

    var updatedMealPlan = mealPlan;

    // Enhanced auto-assignment logic with nutrition balancing
    final usedRecipes = <String, int>{}; // Track recipe usage to ensure variety
    
    for (var date = startDate; 
         date.isBefore(endDate.add(const Duration(days: 1))); 
         date = date.add(const Duration(days: 1))) {
      
      // Assign breakfast - prefer lighter, energizing meals
      final breakfastRecipes = _filterRecipesForMealType(
        availableRecipes, 
        MealType.breakfast,
        usedRecipes,
        preferredRecipeIds,
      );
      if (breakfastRecipes.isNotEmpty) {
        final recipe = _selectBalancedRecipe(breakfastRecipes, nutritionGoals, 'breakfast');
        updatedMealPlan = await assignMealToSlot(
          mealPlan: updatedMealPlan,
          date: date,
          mealType: MealType.breakfast,
          recipeId: recipe.id,
          servings: 1,
        );
        usedRecipes[recipe.id] = (usedRecipes[recipe.id] ?? 0) + 1;
      }

      // Assign lunch - balanced meal with protein and vegetables
      final lunchRecipes = _filterRecipesForMealType(
        availableRecipes, 
        MealType.lunch,
        usedRecipes,
        preferredRecipeIds,
      );
      if (lunchRecipes.isNotEmpty) {
        final recipe = _selectBalancedRecipe(lunchRecipes, nutritionGoals, 'lunch');
        updatedMealPlan = await assignMealToSlot(
          mealPlan: updatedMealPlan,
          date: date,
          mealType: MealType.lunch,
          recipeId: recipe.id,
          servings: 1,
        );
        usedRecipes[recipe.id] = (usedRecipes[recipe.id] ?? 0) + 1;
      }

      // Assign dinner - hearty, satisfying meal
      final dinnerRecipes = _filterRecipesForMealType(
        availableRecipes, 
        MealType.dinner,
        usedRecipes,
        preferredRecipeIds,
      );
      if (dinnerRecipes.isNotEmpty) {
        final recipe = _selectBalancedRecipe(dinnerRecipes, nutritionGoals, 'dinner');
        updatedMealPlan = await assignMealToSlot(
          mealPlan: updatedMealPlan,
          date: date,
          mealType: MealType.dinner,
          recipeId: recipe.id,
          servings: 1,
        );
        usedRecipes[recipe.id] = (usedRecipes[recipe.id] ?? 0) + 1;
      }

      // Optionally assign snacks on some days
      if (date.weekday % 3 == 0) { // Every third day
        final snackRecipes = _filterRecipesForMealType(
          availableRecipes, 
          MealType.snack,
          usedRecipes,
          preferredRecipeIds,
        );
        if (snackRecipes.isNotEmpty) {
          final recipe = _selectBalancedRecipe(snackRecipes, nutritionGoals, 'snack');
          updatedMealPlan = await assignMealToSlot(
            mealPlan: updatedMealPlan,
            date: date,
            mealType: MealType.snack,
            recipeId: recipe.id,
            servings: 1,
          );
          usedRecipes[recipe.id] = (usedRecipes[recipe.id] ?? 0) + 1;
        }
      }
    }

    return updatedMealPlan;
  }

  /// Filter recipes for a specific meal type with variety consideration
  List<Recipe> _filterRecipesForMealType(
    List<Recipe> availableRecipes,
    MealType mealType,
    Map<String, int> usedRecipes,
    List<String>? preferredRecipeIds,
  ) {
    var filtered = availableRecipes.where((recipe) {
      // Match meal type or allow flexible assignment
      final matchesMealType = recipe.metadata.mealType == mealType || recipe.metadata.mealType == null;
      
      // Prefer less used recipes for variety
      final usageCount = usedRecipes[recipe.id] ?? 0;
      final isNotOverused = usageCount < 2; // Don't use same recipe more than twice
      
      return matchesMealType && isNotOverused;
    }).toList();

    // If we have preferred recipes, prioritize them
    if (preferredRecipeIds != null && preferredRecipeIds.isNotEmpty) {
      final preferred = filtered.where((r) => preferredRecipeIds.contains(r.id)).toList();
      final others = filtered.where((r) => !preferredRecipeIds.contains(r.id)).toList();
      filtered = [...preferred, ...others];
    }

    // Sort by usage count (less used first) for variety
    filtered.sort((a, b) {
      final aUsage = usedRecipes[a.id] ?? 0;
      final bUsage = usedRecipes[b.id] ?? 0;
      return aUsage.compareTo(bUsage);
    });

    return filtered;
  }

  /// Select a recipe based on nutritional balance goals
  Recipe _selectBalancedRecipe(
    List<Recipe> recipes,
    Map<String, dynamic>? nutritionGoals,
    String mealContext,
  ) {
    if (recipes.isEmpty) throw Exception('No recipes available for selection');
    
    // If no nutrition goals specified, use simple rotation
    if (nutritionGoals == null) {
      return recipes.first;
    }

    // Enhanced selection logic based on nutrition goals
    // For now, using simple heuristics - in a real app, this would use actual nutrition data
    
    switch (mealContext) {
      case 'breakfast':
        // Prefer recipes with moderate calories and good protein
        return recipes.firstWhere(
          (r) => r.ingredients.any((i) => 
            i.name.toLowerCase().contains('egg') || 
            i.name.toLowerCase().contains('oat') ||
            i.name.toLowerCase().contains('yogurt')
          ),
          orElse: () => recipes.first,
        );
      
      case 'lunch':
        // Prefer balanced meals with vegetables and protein
        return recipes.firstWhere(
          (r) => r.ingredients.any((i) => 
            i.name.toLowerCase().contains('chicken') || 
            i.name.toLowerCase().contains('fish') ||
            i.name.toLowerCase().contains('bean')
          ),
          orElse: () => recipes.first,
        );
      
      case 'dinner':
        // Prefer hearty meals with good protein and complex carbs
        return recipes.firstWhere(
          (r) => r.ingredients.length >= 5, // More complex recipes
          orElse: () => recipes.first,
        );
      
      case 'snack':
        // Prefer lighter options
        return recipes.firstWhere(
          (r) => r.ingredients.length <= 3, // Simpler recipes
          orElse: () => recipes.first,
        );
      
      default:
        return recipes.first;
    }
  }

  // Helper methods
  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  double _calculateDailyCalories(Map<MealType, PlannedMeal?> meals) {
    // In a real implementation, this would fetch actual recipe calories
    // For now, using estimated values
    double totalCalories = 0;
    for (final meal in meals.values) {
      if (meal != null) {
        totalCalories += 400.0 * meal.servings!; // Estimated 400 calories per serving
      }
    }
    return totalCalories;
  }

  bool _isDayCompleted(Map<MealType, PlannedMeal?> meals) {
    final plannedMeals = meals.values.where((meal) => meal != null).toList();
    if (plannedMeals.isEmpty) return false;
    return plannedMeals.every((meal) => meal!.isCooked);
  }
}