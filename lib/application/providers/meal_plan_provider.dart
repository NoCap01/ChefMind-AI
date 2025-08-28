import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';

import '../../domain/entities/recipe.dart';
import '../../domain/entities/meal_plan.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/meal_plan_repository.dart';
import '../../domain/services/recipe_generation_service.dart';
import '../../domain/exceptions/app_exceptions.dart';
import '../../infrastructure/repositories/firebase_meal_plan_repository.dart';
import 'auth_provider.dart';
import 'recipe_provider.dart';

// Repository provider
final mealPlanRepositoryProvider = Provider<IMealPlanRepository>((ref) {
  return FirebaseMealPlanRepository.instance;
});

// Meal plan state provider
final mealPlanStateProvider = StateNotifierProvider<MealPlanStateNotifier, MealPlanState>((ref) {
  final repository = ref.watch(mealPlanRepositoryProvider);
  final generationService = ref.watch(recipeGenerationServiceProvider);
  final userId = ref.watch(currentUserIdProvider);
  final userPreferences = ref.watch(userPreferencesProvider);
  return MealPlanStateNotifier(repository, generationService, userId, userPreferences);
});

// Meal plan generation provider
final mealPlanGenerationProvider = StateNotifierProvider<MealPlanGenerationNotifier, MealPlanGenerationState>((ref) {
  final generationService = ref.watch(recipeGenerationServiceProvider);
  final userPreferences = ref.watch(userPreferencesProvider);
  final nutritionGoals = ref.watch(userNutritionGoalsProvider);
  return MealPlanGenerationNotifier(generationService, userPreferences, nutritionGoals);
});

// Current week meal plan provider
final currentWeekMealPlanProvider = Provider<MealPlan?>((ref) {
  final mealPlans = ref.watch(mealPlanStateProvider).mealPlans;
  final now = DateTime.now();
  final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
  
  return mealPlans.firstWhereOrNull((plan) {
    final planStart = plan.startDate;
    final planEnd = plan.endDate;
    return planStart.isBefore(startOfWeek.add(const Duration(days: 7))) &&
           planEnd.isAfter(startOfWeek);
  });
});

// Today's meals provider
final todaysMealsProvider = Provider<List<PlannedMeal>>((ref) {
  final currentPlan = ref.watch(currentWeekMealPlanProvider);
  if (currentPlan == null) return [];
  
  final today = DateTime.now();
  return currentPlan.meals.where((meal) {
    return meal.date.year == today.year &&
           meal.date.month == today.month &&
           meal.date.day == today.day;
  }).toList();
});

// Upcoming meals provider (next 3 days)
final upcomingMealsProvider = Provider<List<PlannedMeal>>((ref) {
  final currentPlan = ref.watch(currentWeekMealPlanProvider);
  if (currentPlan == null) return [];
  
  final now = DateTime.now();
  final threeDaysFromNow = now.add(const Duration(days: 3));
  
  return currentPlan.meals.where((meal) {
    return meal.date.isAfter(now) && meal.date.isBefore(threeDaysFromNow);
  }).toList()
    ..sort((a, b) => a.date.compareTo(b.date));
});

// Weekly nutrition summary provider
final weeklyNutritionProvider = Provider<WeeklyNutritionSummary?>((ref) {
  final currentPlan = ref.watch(currentWeekMealPlanProvider);
  if (currentPlan == null) return null;
  
  return WeeklyNutritionSummary.fromMealPlan(currentPlan);
});

// Shopping list provider
final shoppingListProvider = Provider<List<ShoppingListItem>>((ref) {
  final currentPlan = ref.watch(currentWeekMealPlanProvider);
  if (currentPlan == null) return [];
  
  return _generateShoppingList(currentPlan);
});

// Meal plan calendar provider (for calendar view)
final mealPlanCalendarProvider = Provider<Map<DateTime, List<PlannedMeal>>>((ref) {
  final currentPlan = ref.watch(currentWeekMealPlanProvider);
  if (currentPlan == null) return {};
  
  final calendar = <DateTime, List<PlannedMeal>>{};
  
  for (final meal in currentPlan.meals) {
    final dateKey = DateTime(meal.date.year, meal.date.month, meal.date.day);
    calendar.putIfAbsent(dateKey, () => []).add(meal);
  }
  
  return calendar;
});

/// Meal plan state model
class MealPlanState {
  final List<MealPlan> mealPlans;
  final bool isLoading;
  final String? errorMessage;
  final Map<String, MealPlan> mealPlanCache;

  const MealPlanState({
    this.mealPlans = const [],
    this.isLoading = false,
    this.errorMessage,
    this.mealPlanCache = const {},
  });

  MealPlanState copyWith({
    List<MealPlan>? mealPlans,
    bool? isLoading,
    String? errorMessage,
    Map<String, MealPlan>? mealPlanCache,
  }) {
    return MealPlanState(
      mealPlans: mealPlans ?? this.mealPlans,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      mealPlanCache: mealPlanCache ?? this.mealPlanCache,
    );
  }
}

/// Meal plan state notifier
class MealPlanStateNotifier extends StateNotifier<MealPlanState> {
  final IMealPlanRepository _repository;
  final IRecipeGenerationService _generationService;
  final String? _userId;
  final UserPreferences? _userPreferences;

  MealPlanStateNotifier(
    this._repository,
    this._generationService,
    this._userId,
    this._userPreferences,
  ) : super(const MealPlanState()) {
    _loadMealPlans();
  }

  Future<void> _loadMealPlans() async {
    if (_userId == null) return;

    state = state.copyWith(isLoading: true, errorMessage: null);
    
    try {
      final mealPlans = await _repository.getUserMealPlans(_userId!);
      state = state.copyWith(
        mealPlans: mealPlans,
        isLoading: false,
        mealPlanCache: {for (final plan in mealPlans) plan.id: plan},
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load meal plans: $e',
      );
    }
  }

  /// Create a new meal plan
  Future<void> createMealPlan(MealPlan mealPlan) async {
    if (_userId == null) return;

    try {
      final savedPlan = await _repository.saveMealPlan(mealPlan);
      final updatedPlans = [...state.mealPlans, savedPlan];
      final updatedCache = {...state.mealPlanCache, savedPlan.id: savedPlan};
      
      state = state.copyWith(
        mealPlans: updatedPlans,
        mealPlanCache: updatedCache,
      );
    } catch (e) {
      state = state.copyWith(errorMessage: 'Failed to create meal plan: $e');
    }
  }

  /// Update an existing meal plan
  Future<void> updateMealPlan(MealPlan mealPlan) async {
    try {
      final updatedPlan = await _repository.updateMealPlan(mealPlan);
      final updatedPlans = state.mealPlans
          .map((p) => p.id == mealPlan.id ? updatedPlan : p)
          .toList();
      final updatedCache = {...state.mealPlanCache, updatedPlan.id: updatedPlan};
      
      state = state.copyWith(
        mealPlans: updatedPlans,
        mealPlanCache: updatedCache,
      );
    } catch (e) {
      state = state.copyWith(errorMessage: 'Failed to update meal plan: $e');
    }
  }

  /// Delete a meal plan
  Future<void> deleteMealPlan(String mealPlanId) async {
    try {
      await _repository.deleteMealPlan(mealPlanId);
      final updatedPlans = state.mealPlans.where((p) => p.id != mealPlanId).toList();
      final updatedCache = Map<String, MealPlan>.from(state.mealPlanCache)..remove(mealPlanId);
      
      state = state.copyWith(
        mealPlans: updatedPlans,
        mealPlanCache: updatedCache,
      );
    } catch (e) {
      state = state.copyWith(errorMessage: 'Failed to delete meal plan: $e');
    }
  }

  /// Add a meal to a specific date and meal type
  Future<void> addMealToPlan(String mealPlanId, PlannedMeal meal) async {
    final mealPlan = state.mealPlanCache[mealPlanId];
    if (mealPlan == null) return;

    final updatedMeals = [...mealPlan.meals, meal];
    final updatedPlan = mealPlan.copyWith(meals: updatedMeals);
    
    await updateMealPlan(updatedPlan);
  }

  /// Remove a meal from a plan
  Future<void> removeMealFromPlan(String mealPlanId, String mealId) async {
    final mealPlan = state.mealPlanCache[mealPlanId];
    if (mealPlan == null) return;

    final updatedMeals = mealPlan.meals.where((m) => m.id != mealId).toList();
    final updatedPlan = mealPlan.copyWith(meals: updatedMeals);
    
    await updateMealPlan(updatedPlan);
  }

  /// Replace a meal in a plan
  Future<void> replaceMealInPlan(String mealPlanId, String mealId, Recipe newRecipe) async {
    final mealPlan = state.mealPlanCache[mealPlanId];
    if (mealPlan == null) return;

    final updatedMeals = mealPlan.meals.map((meal) {
      if (meal.id == mealId) {
        return meal.copyWith(recipe: newRecipe);
      }
      return meal;
    }).toList();
    
    final updatedPlan = mealPlan.copyWith(meals: updatedMeals);
    await updateMealPlan(updatedPlan);
  }

  /// Mark a meal as prepared
  Future<void> markMealAsPrepared(String mealPlanId, String mealId) async {
    final mealPlan = state.mealPlanCache[mealPlanId];
    if (mealPlan == null) return;

    final updatedMeals = mealPlan.meals.map((meal) {
      if (meal.id == mealId) {
        return meal.copyWith(isPrepared: true);
      }
      return meal;
    }).toList();
    
    final updatedPlan = mealPlan.copyWith(meals: updatedMeals);
    await updateMealPlan(updatedPlan);
  }

  /// Refresh meal plans from server
  Future<void> refresh() async {
    await _loadMealPlans();
  }

  /// Clear error message
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}

/// Meal plan generation state model
class MealPlanGenerationState {
  final bool isGenerating;
  final MealPlan? generatedPlan;
  final String? errorMessage;
  final MealPlanGenerationRequest? currentRequest;

  const MealPlanGenerationState({
    this.isGenerating = false,
    this.generatedPlan,
    this.errorMessage,
    this.currentRequest,
  });

  MealPlanGenerationState copyWith({
    bool? isGenerating,
    MealPlan? generatedPlan,
    String? errorMessage,
    MealPlanGenerationRequest? currentRequest,
  }) {
    return MealPlanGenerationState(
      isGenerating: isGenerating ?? this.isGenerating,
      generatedPlan: generatedPlan,
      errorMessage: errorMessage,
      currentRequest: currentRequest ?? this.currentRequest,
    );
  }
}

/// Meal plan generation notifier
class MealPlanGenerationNotifier extends StateNotifier<MealPlanGenerationState> {
  final IRecipeGenerationService _generationService;
  final UserPreferences? _userPreferences;
  final NutritionGoals? _nutritionGoals;

  MealPlanGenerationNotifier(
    this._generationService,
    this._userPreferences,
    this._nutritionGoals,
  ) : super(const MealPlanGenerationState());

  /// Generate a meal plan
  Future<void> generateMealPlan(MealPlanGenerationRequest request) async {
    if (_userPreferences == null) {
      state = state.copyWith(errorMessage: 'User preferences not available');
      return;
    }

    state = state.copyWith(
      isGenerating: true,
      errorMessage: null,
      currentRequest: request,
    );

    try {
      final recipes = await _generationService.generateMealPlan(request);
      final mealPlan = _createMealPlanFromRecipes(recipes, request);
      
      state = state.copyWith(
        isGenerating: false,
        generatedPlan: mealPlan,
      );
    } catch (e) {
      state = state.copyWith(
        isGenerating: false,
        errorMessage: 'Failed to generate meal plan: $e',
      );
    }
  }

  /// Generate a quick meal plan for the week
  Future<void> generateWeeklyMealPlan({
    List<MealType>? mealTypes,
    List<String>? availableIngredients,
    double? budgetLimit,
  }) async {
    final startDate = DateTime.now();
    final endDate = startDate.add(const Duration(days: 7));
    
    final request = MealPlanGenerationRequest(
      startDate: startDate,
      endDate: endDate,
      mealTypes: mealTypes ?? [MealType.breakfast, MealType.lunch, MealType.dinner],
      preferences: _userPreferences!,
      nutritionGoals: _nutritionGoals,
      availableIngredients: availableIngredients ?? [],
      budgetLimit: budgetLimit,
      numberOfDays: 7,
    );

    await generateMealPlan(request);
  }

  /// Generate meal suggestions for a specific meal type and date
  Future<void> generateMealSuggestions(DateTime date, MealType mealType) async {
    if (_userPreferences == null) return;

    state = state.copyWith(isGenerating: true, errorMessage: null);

    try {
      final recipe = await _generationService.generateRecipeForMealType(
        mealType,
        _userPreferences!,
        _nutritionGoals,
      );

      // Create a simple meal plan with just this meal
      final meal = PlannedMeal(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        recipe: recipe,
        date: date,
        mealType: mealType,
        servings: recipe.servings,
        isPrepared: false,
      );

      final mealPlan = MealPlan(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: 'temp',
        title: '${mealType.displayName} Suggestion',
        startDate: date,
        endDate: date,
        meals: [meal],
        createdAt: DateTime.now(),
      );

      state = state.copyWith(
        isGenerating: false,
        generatedPlan: mealPlan,
      );
    } catch (e) {
      state = state.copyWith(
        isGenerating: false,
        errorMessage: 'Failed to generate meal suggestions: $e',
      );
    }
  }

  /// Clear generated meal plan
  void clearGeneratedPlan() {
    state = state.copyWith(generatedPlan: null);
  }

  /// Clear error message
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  MealPlan _createMealPlanFromRecipes(List<Recipe> recipes, MealPlanGenerationRequest request) {
    final meals = <PlannedMeal>[];
    var recipeIndex = 0;

    for (var day = 0; day < request.numberOfDays; day++) {
      final date = request.startDate.add(Duration(days: day));
      
      for (final mealType in request.mealTypes) {
        if (recipeIndex < recipes.length) {
          final meal = PlannedMeal(
            id: '${date.millisecondsSinceEpoch}_${mealType.name}',
            recipe: recipes[recipeIndex],
            date: date,
            mealType: mealType,
            servings: recipes[recipeIndex].servings,
            isPrepared: false,
          );
          meals.add(meal);
          recipeIndex++;
        }
      }
    }

    return MealPlan(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: 'temp', // Will be set when saved
      title: 'Generated Meal Plan',
      startDate: request.startDate,
      endDate: request.endDate,
      meals: meals,
      createdAt: DateTime.now(),
    );
  }
}

/// Weekly nutrition summary model
class WeeklyNutritionSummary {
  final double totalCalories;
  final double totalProtein;
  final double totalCarbs;
  final double totalFat;
  final double totalFiber;
  final double averageDailyCalories;
  final Map<String, double> dailyCalories;
  final Map<String, NutritionInfo> dailyNutrition;

  const WeeklyNutritionSummary({
    required this.totalCalories,
    required this.totalProtein,
    required this.totalCarbs,
    required this.totalFat,
    required this.totalFiber,
    required this.averageDailyCalories,
    required this.dailyCalories,
    required this.dailyNutrition,
  });

  factory WeeklyNutritionSummary.fromMealPlan(MealPlan mealPlan) {
    final dailyNutrition = <String, NutritionInfo>{};
    final dailyCalories = <String, double>{};
    
    // Group meals by date
    final mealsByDate = <DateTime, List<PlannedMeal>>{};
    for (final meal in mealPlan.meals) {
      final dateKey = DateTime(meal.date.year, meal.date.month, meal.date.day);
      mealsByDate.putIfAbsent(dateKey, () => []).add(meal);
    }

    // Calculate nutrition for each day
    for (final entry in mealsByDate.entries) {
      final date = entry.key;
      final meals = entry.value;
      final dateString = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
      
      var dayCalories = 0.0;
      var dayProtein = 0.0;
      var dayCarbs = 0.0;
      var dayFat = 0.0;
      var dayFiber = 0.0;
      
      for (final meal in meals) {
        final nutrition = meal.recipe.nutrition;
        final servingRatio = meal.servings / meal.recipe.servings;
        
        dayCalories += nutrition.calories * servingRatio;
        dayProtein += nutrition.protein * servingRatio;
        dayCarbs += nutrition.carbs * servingRatio;
        dayFat += nutrition.fat * servingRatio;
        dayFiber += nutrition.fiber * servingRatio;
      }
      
      dailyCalories[dateString] = dayCalories;
      dailyNutrition[dateString] = NutritionInfo(
        calories: dayCalories,
        protein: dayProtein,
        carbs: dayCarbs,
        fat: dayFat,
        fiber: dayFiber,
        sugar: 0, // Would need to calculate from individual meals
        sodium: 0, // Would need to calculate from individual meals
        vitamins: {},
        minerals: {},
      );
    }

    final totalCalories = dailyCalories.values.fold(0.0, (sum, cal) => sum + cal);
    final averageDailyCalories = dailyCalories.isNotEmpty ? totalCalories / dailyCalories.length : 0.0;
    
    final totalProtein = dailyNutrition.values.fold(0.0, (sum, nutrition) => sum + nutrition.protein);
    final totalCarbs = dailyNutrition.values.fold(0.0, (sum, nutrition) => sum + nutrition.carbs);
    final totalFat = dailyNutrition.values.fold(0.0, (sum, nutrition) => sum + nutrition.fat);
    final totalFiber = dailyNutrition.values.fold(0.0, (sum, nutrition) => sum + nutrition.fiber);

    return WeeklyNutritionSummary(
      totalCalories: totalCalories,
      totalProtein: totalProtein,
      totalCarbs: totalCarbs,
      totalFat: totalFat,
      totalFiber: totalFiber,
      averageDailyCalories: averageDailyCalories,
      dailyCalories: dailyCalories,
      dailyNutrition: dailyNutrition,
    );
  }
}

/// Shopping list item model
class ShoppingListItem {
  final String name;
  final double quantity;
  final String unit;
  final String category;
  final bool isChecked;
  final List<String> usedInRecipes;

  const ShoppingListItem({
    required this.name,
    required this.quantity,
    required this.unit,
    required this.category,
    this.isChecked = false,
    this.usedInRecipes = const [],
  });

  ShoppingListItem copyWith({
    String? name,
    double? quantity,
    String? unit,
    String? category,
    bool? isChecked,
    List<String>? usedInRecipes,
  }) {
    return ShoppingListItem(
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      category: category ?? this.category,
      isChecked: isChecked ?? this.isChecked,
      usedInRecipes: usedInRecipes ?? this.usedInRecipes,
    );
  }
}

// Helper function to generate shopping list from meal plan
List<ShoppingListItem> _generateShoppingList(MealPlan mealPlan) {
  final ingredientMap = <String, ShoppingListItem>{};
  
  for (final meal in mealPlan.meals) {
    final servingRatio = meal.servings / meal.recipe.servings;
    
    for (final ingredient in meal.recipe.ingredients) {
      final key = '${ingredient.name}_${ingredient.unit}';
      final adjustedQuantity = ingredient.quantity * servingRatio;
      
      if (ingredientMap.containsKey(key)) {
        final existing = ingredientMap[key]!;
        final newUsedInRecipes = [...existing.usedInRecipes, meal.recipe.title];
        ingredientMap[key] = existing.copyWith(
          quantity: existing.quantity + adjustedQuantity,
          usedInRecipes: newUsedInRecipes,
        );
      } else {
        ingredientMap[key] = ShoppingListItem(
          name: ingredient.name,
          quantity: adjustedQuantity,
          unit: ingredient.unit,
          category: ingredient.category ?? 'Other',
          usedInRecipes: [meal.recipe.title],
        );
      }
    }
  }
  
  final shoppingList = ingredientMap.values.toList();
  
  // Sort by category, then by name
  shoppingList.sort((a, b) {
    final categoryComparison = a.category.compareTo(b.category);
    if (categoryComparison != 0) return categoryComparison;
    return a.name.compareTo(b.name);
  });
  
  return shoppingList;
}