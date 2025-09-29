import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/meal_plan.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/entities/shopping_list.dart';
import '../../domain/enums/meal_type.dart';
import '../../domain/enums/skill_level.dart';
import '../../domain/repositories/meal_plan_repository.dart';
import '../../infrastructure/repositories/firebase_meal_plan_repository.dart';
import '../../services/meal_planning_service.dart';
import '../../services/recipe_storage_service.dart';
import '../../services/shopping_list_service.dart';
import '../../services/pantry_service.dart';

// Service providers
final recipeStorageServiceProvider = Provider<RecipeStorageService>((ref) {
  return RecipeStorageService();
});

final pantryServiceProvider = Provider<PantryService>((ref) {
  return PantryService();
});

final shoppingListServiceProvider = Provider<ShoppingListService>((ref) {
  final pantryService = ref.watch(pantryServiceProvider);
  return ShoppingListService(pantryService);
});

// Repository provider
final mealPlanRepositoryProvider = Provider<MealPlanRepository>(
  (ref) => FirebaseMealPlanRepository(),
);

// Current user provider (mock for now)
final currentUserProvider = Provider<UserProfile?>((ref) {
  return UserProfile(
    userId: 'mock_user_id',
    email: 'user@example.com',
    displayName: 'Mock User',
    skillLevel: SkillLevel.intermediate,
    dietaryRestrictions: [],
    allergies: [],
    favoriteIngredients: [],
    dislikedIngredients: [],
    kitchenEquipment: [],
    preferences: const CookingPreferences(),
    nutritionalGoals: const NutritionalGoals(),
    createdAt: DateTime.now(),
  );
});

// Meal planning service provider
final mealPlanningServiceProvider = Provider<MealPlanningService>((ref) {
  final recipeStorageService = ref.watch(recipeStorageServiceProvider);
  final shoppingListService = ref.watch(shoppingListServiceProvider);
  return MealPlanningService(recipeStorageService, shoppingListService);
});

// Meal plans provider
final mealPlansProvider = FutureProvider<List<MealPlan>>((ref) async {
  final repository = ref.watch(mealPlanRepositoryProvider);
  final user = ref.watch(currentUserProvider);
  if (user == null) return [];
  return repository.getUserMealPlans(user.userId);
});

// Active meal plan provider
final activeMealPlanProvider = FutureProvider<MealPlan?>((ref) async {
  final repository = ref.watch(mealPlanRepositoryProvider);
  final user = ref.watch(currentUserProvider);
  if (user == null) return null;
  final plans = await repository.getUserMealPlans(user.userId);
  return plans.where((plan) => plan.isActive).isNotEmpty
      ? plans.firstWhere((plan) => plan.isActive)
      : (plans.isNotEmpty ? plans.first : null);
});

// Selected date provider for calendar
final selectedDateProvider = StateProvider<DateTime>((ref) => DateTime.now());

// Daily meal plan provider for selected date
final dailyMealPlanProvider = Provider<DailyMealPlan?>((ref) {
  final activeMealPlan = ref.watch(activeMealPlanProvider);
  final selectedDate = ref.watch(selectedDateProvider);

  return activeMealPlan.when(
    data: (mealPlan) {
      if (mealPlan == null) return null;
      final mealPlanningService = ref.watch(mealPlanningServiceProvider);
      return mealPlanningService.getDailyMealPlan(mealPlan, selectedDate);
    },
    loading: () => null,
    error: (_, __) => null,
  );
});

// Meal planner state notifier
class MealPlannerNotifier extends AsyncNotifier<MealPlan?> {
  @override
  Future<MealPlan?> build() async {
    final repository = ref.watch(mealPlanRepositoryProvider);
    final user = ref.watch(currentUserProvider);
    if (user == null) return null;
    final plans = await repository.getUserMealPlans(user.userId);
    return plans.where((plan) => plan.isActive).isNotEmpty
        ? plans.firstWhere((plan) => plan.isActive)
        : (plans.isNotEmpty ? plans.first : null);
  }

  Future<void> createMealPlan({
    required String name,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final user = ref.read(currentUserProvider);
    if (user == null) throw Exception('User not found');

    state = const AsyncLoading();

    try {
      final mealPlanningService = ref.read(mealPlanningServiceProvider);
      final mealPlan = await mealPlanningService.createMealPlan(
        userId: user.userId,
        name: name,
        startDate: startDate,
        endDate: endDate,
      );

      final repository = ref.read(mealPlanRepositoryProvider);
      await repository.saveMealPlan(mealPlan);

      state = AsyncData(mealPlan);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> assignMealToSlot({
    required DateTime date,
    required MealType mealType,
    required String recipeId,
    int servings = 1,
    String? notes,
  }) async {
    final currentMealPlan = state.value;
    if (currentMealPlan == null) return;

    state = const AsyncLoading();

    try {
      final mealPlanningService = ref.read(mealPlanningServiceProvider);
      final updatedMealPlan = await mealPlanningService.assignMealToSlot(
        mealPlan: currentMealPlan,
        date: date,
        mealType: mealType,
        recipeId: recipeId,
        servings: servings,
        notes: notes,
      );

      final repository = ref.read(mealPlanRepositoryProvider);
      await repository.updateMealPlan(updatedMealPlan);

      state = AsyncData(updatedMealPlan);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> removeMealFromSlot({
    required DateTime date,
    required MealType mealType,
  }) async {
    final currentMealPlan = state.value;
    if (currentMealPlan == null) return;

    state = const AsyncLoading();

    try {
      final mealPlanningService = ref.read(mealPlanningServiceProvider);
      final updatedMealPlan = await mealPlanningService.removeMealFromSlot(
        mealPlan: currentMealPlan,
        date: date,
        mealType: mealType,
      );

      final repository = ref.read(mealPlanRepositoryProvider);
      await repository.updateMealPlan(updatedMealPlan);

      state = AsyncData(updatedMealPlan);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> markMealAsCooked({
    required DateTime date,
    required MealType mealType,
    required bool isCooked,
  }) async {
    final currentMealPlan = state.value;
    if (currentMealPlan == null) return;

    state = const AsyncLoading();

    try {
      final mealPlanningService = ref.read(mealPlanningServiceProvider);
      final updatedMealPlan = await mealPlanningService.markMealAsCooked(
        mealPlan: currentMealPlan,
        date: date,
        mealType: mealType,
        isCooked: isCooked,
      );

      final repository = ref.read(mealPlanRepositoryProvider);
      await repository.updateMealPlan(updatedMealPlan);

      state = AsyncData(updatedMealPlan);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> autoGenerateMealPlan({
    required String name,
    required DateTime startDate,
    required DateTime endDate,
    List<String>? preferredRecipeIds,
    Map<String, dynamic>? nutritionGoals,
  }) async {
    final user = ref.read(currentUserProvider);
    if (user == null) throw Exception('User not found');

    state = const AsyncLoading();

    try {
      final mealPlanningService = ref.read(mealPlanningServiceProvider);
      final mealPlan = await mealPlanningService.autoGenerateMealPlan(
        userId: user.userId,
        name: name,
        startDate: startDate,
        endDate: endDate,
        preferredRecipeIds: preferredRecipeIds,
        nutritionGoals: nutritionGoals,
      );

      final repository = ref.read(mealPlanRepositoryProvider);
      await repository.saveMealPlan(mealPlan);

      state = AsyncData(mealPlan);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<ShoppingList> generateShoppingList({String? listName}) async {
    final currentMealPlan = state.value;
    if (currentMealPlan == null) throw Exception('No active meal plan');

    final mealPlanningService = ref.read(mealPlanningServiceProvider);
    return await mealPlanningService.generateShoppingListFromMealPlan(
      mealPlan: currentMealPlan,
      listName: listName,
    );
  }

  Future<void> deleteMealPlan(String planId) async {
    final repository = ref.read(mealPlanRepositoryProvider);
    await repository.deleteMealPlan(planId);
    ref.invalidateSelf();
  }
}

// Meal planner provider
final mealPlannerProvider =
    AsyncNotifierProvider<MealPlannerNotifier, MealPlan?>(
  () => MealPlannerNotifier(),
);

// Watch user meal plans stream provider
final watchUserMealPlansProvider = StreamProvider<List<MealPlan>>((ref) {
  final repository = ref.watch(mealPlanRepositoryProvider);
  final user = ref.watch(currentUserProvider);
  if (user == null) return Stream.value([]);
  return repository.watchUserMealPlans(user.userId);
});

// Get specific meal plan provider
final getMealPlanProvider =
    FutureProvider.family<MealPlan?, String>((ref, planId) async {
  final repository = ref.watch(mealPlanRepositoryProvider);
  return repository.getMealPlan(planId);
});

// Nutrition summary provider
final nutritionSummaryProvider = FutureProvider<NutritionSummary?>((ref) async {
  final activeMealPlan = await ref.watch(activeMealPlanProvider.future);

  if (activeMealPlan == null) return null;

  final mealPlanningService = ref.watch(mealPlanningServiceProvider);
  return await mealPlanningService.calculateNutritionSummary(activeMealPlan);
});
