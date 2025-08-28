import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';

import '../../domain/entities/nutrition_tracking.dart';
import '../../domain/repositories/nutrition_repository.dart';
import '../../domain/services/nutrition_service.dart';
import '../../infrastructure/repositories/firebase_nutrition_repository.dart';
import '../../infrastructure/services/nutrition_service_impl.dart';
import 'auth_provider.dart';

// Repository and service providers
final nutritionRepositoryProvider = Provider<INutritionRepository>((ref) {
  return FirebaseNutritionRepository.instance;
});

final nutritionServiceProvider = Provider<INutritionService>((ref) {
  final repository = ref.watch(nutritionRepositoryProvider);
  return NutritionServiceImpl(repository);
});

// Nutrition state providers
final nutritionStateProvider = StateNotifierProvider<NutritionStateNotifier, NutritionState>((ref) {
  final repository = ref.watch(nutritionRepositoryProvider);
  final service = ref.watch(nutritionServiceProvider);
  final userId = ref.watch(currentUserIdProvider);
  return NutritionStateNotifier(repository, service, userId);
});

// Current date provider for nutrition tracking
final currentTrackingDateProvider = StateProvider<DateTime>((ref) => DateTime.now());

// Current nutrition entry provider
final currentNutritionEntryProvider = Provider<NutritionEntry?>((ref) {
  final nutritionState = ref.watch(nutritionStateProvider);
  final currentDate = ref.watch(currentTrackingDateProvider);
  
  return nutritionState.entries.firstWhereOrNull((entry) =>
    entry.date.year == currentDate.year &&
    entry.date.month == currentDate.month &&
    entry.date.day == currentDate.day);
});

// Active nutrition goal provider
final activeNutritionGoalProvider = Provider<NutritionGoal?>((ref) {
  final nutritionState = ref.watch(nutritionStateProvider);
  return nutritionState.goals.firstWhereOrNull((goal) => goal.isActive);
});

// Daily nutrition progress provider
final dailyNutritionProgressProvider = Provider<NutritionProgress?>((ref) {
  final currentEntry = ref.watch(currentNutritionEntryProvider);
  final activeGoal = ref.watch(activeNutritionGoalProvider);
  
  if (currentEntry == null || activeGoal == null) return null;
  
  return _calculateDailyProgress(currentEntry, activeGoal.targets);
});

// Weekly nutrition summary provider
final weeklyNutritionSummaryProvider = FutureProvider.family<WeeklyNutritionSummary?, DateTime>((ref, weekStart) async {
  final repository = ref.watch(nutritionRepositoryProvider);
  final userId = ref.watch(currentUserIdProvider);
  
  if (userId == null) return null;
  
  try {
    return await repository.getWeeklyNutritionSummary(userId, weekStart);
  } catch (e) {
    return null;
  }
});

// Nutrition recommendations provider
final nutritionRecommendationsProvider = FutureProvider<List<NutritionRecommendation>>((ref) async {
  final repository = ref.watch(nutritionRepositoryProvider);
  final userId = ref.watch(currentUserIdProvider);
  
  if (userId == null) return [];
  
  try {
    return await repository.getNutritionRecommendations(userId);
  } catch (e) {
    return [];
  }
});

// Food database search provider
final foodSearchProvider = FutureProvider.family<List<FoodDatabase>, String>((ref, query) async {
  if (query.isEmpty) return [];
  
  final repository = ref.watch(nutritionRepositoryProvider);
  
  try {
    return await repository.searchFoodDatabase(query);
  } catch (e) {
    return [];
  }
});

/// Nutrition state model
class NutritionState {
  final List<NutritionEntry> entries;
  final List<NutritionGoal> goals;
  final bool isLoading;
  final String? errorMessage;
  final Map<String, NutritionEntry> entryCache;

  const NutritionState({
    this.entries = const [],
    this.goals = const [],
    this.isLoading = false,
    this.errorMessage,
    this.entryCache = const {},
  });

  NutritionState copyWith({
    List<NutritionEntry>? entries,
    List<NutritionGoal>? goals,
    bool? isLoading,
    String? errorMessage,
    Map<String, NutritionEntry>? entryCache,
  }) {
    return NutritionState(
      entries: entries ?? this.entries,
      goals: goals ?? this.goals,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      entryCache: entryCache ?? this.entryCache,
    );
  }
}

/// Nutrition state notifier
class NutritionStateNotifier extends StateNotifier<NutritionState> {
  final INutritionRepository _repository;
  final INutritionService _service;
  final String? _userId;

  NutritionStateNotifier(this._repository, this._service, this._userId) 
      : super(const NutritionState()) {
    _loadNutritionData();
  }

  Future<void> _loadNutritionData() async {
    if (_userId == null) return;

    state = state.copyWith(isLoading: true, errorMessage: null);
    
    try {
      // Load recent entries (last 30 days)
      final endDate = DateTime.now();
      final startDate = endDate.subtract(const Duration(days: 30));
      
      final entries = await _repository.getUserNutritionEntries(
        _userId!,
        startDate: startDate,
        endDate: endDate,
      );
      
      final goals = await _repository.getUserNutritionGoals(_userId!);
      
      state = state.copyWith(
        entries: entries,
        goals: goals,
        isLoading: false,
        entryCache: {for (final entry in entries) entry.id: entry},
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load nutrition data: $e',
      );
    }
  }

  /// Add food entry to a specific date
  Future<void> addFoodEntry(DateTime date, FoodEntry foodEntry) async {
    if (_userId == null) return;

    try {
      final updatedEntry = await _repository.addFoodEntry(_userId!, date, foodEntry);
      
      final updatedEntries = state.entries
          .where((entry) => entry.id != updatedEntry.id)
          .toList()
        ..add(updatedEntry);
      
      final updatedCache = {...state.entryCache, updatedEntry.id: updatedEntry};
      
      state = state.copyWith(
        entries: updatedEntries,
        entryCache: updatedCache,
      );
    } catch (e) {
      state = state.copyWith(errorMessage: 'Failed to add food entry: $e');
    }
  }

  /// Create nutrition goal
  Future<void> createNutritionGoal(NutritionGoal goal) async {
    try {
      final savedGoal = await _repository.createNutritionGoal(goal);
      
      // Deactivate other goals if this one is active
      List<NutritionGoal> updatedGoals = state.goals;
      if (savedGoal.isActive) {
        updatedGoals = state.goals.map((g) => g.copyWith(isActive: false)).toList();
      }
      
      updatedGoals.add(savedGoal);
      
      state = state.copyWith(goals: updatedGoals);
    } catch (e) {
      state = state.copyWith(errorMessage: 'Failed to create nutrition goal: $e');
    }
  }

  /// Generate nutrition goals based on user profile
  Future<void> generateNutritionGoals({
    required double weightKg,
    required double heightCm,
    required int age,
    required Gender gender,
    required ActivityLevel activityLevel,
    required GoalType goalType,
    double? targetWeightKg,
  }) async {
    if (_userId == null) return;

    state = state.copyWith(isLoading: true, errorMessage: null);
    
    try {
      final goals = await _service.calculateNutritionGoals(
        weightKg: weightKg,
        heightCm: heightCm,
        age: age,
        gender: gender,
        activityLevel: activityLevel,
        goalType: goalType,
        targetWeightKg: targetWeightKg,
      );

      final nutritionGoal = NutritionGoal(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: _userId!,
        name: goalType.displayName,
        targets: goals,
        goalType: goalType,
        startDate: DateTime.now(),
        isActive: true,
        targetWeight: targetWeightKg ?? weightKg,
        currentWeight: weightKg,
        activityLevel: activityLevel,
        gender: gender,
        age: age,
        createdAt: DateTime.now(),
      );

      await createNutritionGoal(nutritionGoal);
      
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to generate nutrition goals: $e',
      );
    }
  }

  /// Update water intake for a date
  Future<void> updateWaterIntake(DateTime date, double waterMl) async {
    if (_userId == null) return;

    try {
      final updatedEntry = await _repository.updateWaterIntake(_userId!, date, waterMl);
      await _updateEntryInState(updatedEntry);
    } catch (e) {
      state = state.copyWith(errorMessage: 'Failed to update water intake: $e');
    }
  }

  /// Update exercise calories for a date
  Future<void> updateExerciseCalories(DateTime date, double calories) async {
    if (_userId == null) return;

    try {
      final updatedEntry = await _repository.updateExerciseCalories(_userId!, date, calories);
      await _updateEntryInState(updatedEntry);
    } catch (e) {
      state = state.copyWith(errorMessage: 'Failed to update exercise calories: $e');
    }
  }

  /// Get nutrition analysis for current entry
  Future<NutritionAnalysis?> getCurrentNutritionAnalysis() async {
    final currentEntry = state.entryCache.values.firstWhereOrNull((entry) {
      final now = DateTime.now();
      return entry.date.year == now.year &&
             entry.date.month == now.month &&
             entry.date.day == now.day;
    });

    final activeGoal = state.goals.firstWhereOrNull((goal) => goal.isActive);
    
    if (currentEntry == null || activeGoal == null) return null;

    try {
      return await _service.analyzeNutritionEntry(currentEntry, activeGoal.targets);
    } catch (e) {
      state = state.copyWith(errorMessage: 'Failed to analyze nutrition: $e');
      return null;
    }
  }

  /// Refresh nutrition data
  Future<void> refresh() async {
    await _loadNutritionData();
  }

  /// Clear error message
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  /// Get nutrition progress summary
  Future<NutritionProgressSummary?> getNutritionProgress(
    DateTime startDate,
    DateTime endDate,
  ) async {
    if (_userId == null) return null;

    try {
      return await _service.trackNutritionProgress(_userId!, startDate, endDate);
    } catch (e) {
      state = state.copyWith(errorMessage: 'Failed to get nutrition progress: $e');
      return null;
    }
  }

  /// Validate dietary restrictions for foods
  Future<DietaryValidation?> validateDietaryRestrictions(
    List<FoodEntry> foods,
    List<DietaryRestriction> restrictions,
    List<String> allergies,
  ) async {
    try {
      return await _service.validateDietaryRestrictions(foods, restrictions, allergies);
    } catch (e) {
      state = state.copyWith(errorMessage: 'Failed to validate dietary restrictions: $e');
      return null;
    }
  }

  /// Analyze micronutrients for recent entries
  Future<MicronutrientAnalysis?> analyzeMicronutrients(int daysToAnalyze) async {
    try {
      final recentEntries = state.entries.take(daysToAnalyze).toList();
      return await _service.analyzeMicronutrients(recentEntries, daysToAnalyze);
    } catch (e) {
      state = state.copyWith(errorMessage: 'Failed to analyze micronutrients: $e');
      return null;
    }
  }

  /// Update nutrition goal
  Future<void> updateNutritionGoal(NutritionGoal goal) async {
    try {
      final updatedGoal = await _repository.updateNutritionGoal(goal);
      
      final updatedGoals = state.goals
          .map((g) => g.id == updatedGoal.id ? updatedGoal : g)
          .toList();
      
      state = state.copyWith(goals: updatedGoals);
    } catch (e) {
      state = state.copyWith(errorMessage: 'Failed to update nutrition goal: $e');
    }
  }

  /// Set active nutrition goal
  Future<void> setActiveNutritionGoal(String goalId) async {
    if (_userId == null) return;

    try {
      await _repository.setActiveNutritionGoal(_userId!, goalId);
      
      // Update local state
      final updatedGoals = state.goals.map((goal) {
        return goal.copyWith(isActive: goal.id == goalId);
      }).toList();
      
      state = state.copyWith(goals: updatedGoals);
    } catch (e) {
      state = state.copyWith(errorMessage: 'Failed to set active goal: $e');
    }
  }

  /// Delete nutrition goal
  Future<void> deleteNutritionGoal(String goalId) async {
    try {
      await _repository.deleteNutritionGoal(goalId);
      
      final updatedGoals = state.goals.where((goal) => goal.id != goalId).toList();
      state = state.copyWith(goals: updatedGoals);
    } catch (e) {
      state = state.copyWith(errorMessage: 'Failed to delete nutrition goal: $e');
    }
  }

  /// Update an entry in the current state
  Future<void> _updateEntryInState(NutritionEntry updatedEntry) async {
    final updatedEntries = state.entries
        .map((entry) => entry.id == updatedEntry.id ? updatedEntry : entry)
        .toList();
    final updatedCache = {...state.entryCache, updatedEntry.id: updatedEntry};
    
    state = state.copyWith(
      entries: updatedEntries,
      entryCache: updatedCache,
    );
  }
}

// Helper function to calculate daily progress
NutritionProgress _calculateDailyProgress(NutritionEntry entry, NutritionGoals goals) {
  final consumed = entry.totalNutrition;
  
  final percentageAchieved = <String, double>{
    'calories': (consumed.calories / goals.dailyCalories) * 100,
    'protein': (consumed.protein / goals.proteinGrams) * 100,
    'carbs': (consumed.carbs / goals.carbsGrams) * 100,
    'fat': (consumed.fat / goals.fatGrams) * 100,
    'fiber': (consumed.fiber / goals.fiberGrams) * 100,
    'sodium': (consumed.sodium / goals.sodiumMg) * 100,
  };

  final deficiencies = <NutritionDeficiency>[];
  final excesses = <NutritionExcess>[];

  // Check for deficiencies (less than 80% of goal)
  percentageAchieved.forEach((nutrient, percentage) {
    if (percentage < 80 && nutrient != 'sodium') {
      deficiencies.add(NutritionDeficiency(
        nutrient: nutrient,
        currentAmount: _getNutrientValue(consumed, nutrient),
        targetAmount: _getGoalValue(goals, nutrient),
        deficitPercentage: 100 - percentage,
        suggestedFoods: _getSuggestedFoods(nutrient),
      ));
    } else if (percentage > 120) {
      excesses.add(NutritionExcess(
        nutrient: nutrient,
        currentAmount: _getNutrientValue(consumed, nutrient),
        targetAmount: _getGoalValue(goals, nutrient),
        excessPercentage: percentage - 100,
        reductionSuggestions: _getReductionSuggestions(nutrient),
      ));
    }
  });

  final overallScore = NutritionCalculator.calculateNutritionScore(
    consumed: consumed,
    goals: goals,
  );

  return NutritionProgress(
    userId: entry.userId,
    date: entry.date,
    goals: goals,
    consumed: consumed,
    percentageAchieved: percentageAchieved,
    deficiencies: deficiencies,
    excesses: excesses,
    overallScore: overallScore,
    waterIntakeGoal: 2500, // Default goal
    waterIntakeActual: entry.waterIntakeMl,
  );
}

double _getNutrientValue(NutritionInfo nutrition, String nutrient) {
  switch (nutrient) {
    case 'calories': return nutrition.calories;
    case 'protein': return nutrition.protein;
    case 'carbs': return nutrition.carbs;
    case 'fat': return nutrition.fat;
    case 'fiber': return nutrition.fiber;
    case 'sodium': return nutrition.sodium;
    default: return 0;
  }
}

double _getGoalValue(NutritionGoals goals, String nutrient) {
  switch (nutrient) {
    case 'calories': return goals.dailyCalories;
    case 'protein': return goals.proteinGrams;
    case 'carbs': return goals.carbsGrams;
    case 'fat': return goals.fatGrams;
    case 'fiber': return goals.fiberGrams;
    case 'sodium': return goals.sodiumMg;
    default: return 0;
  }
}

List<String> _getSuggestedFoods(String nutrient) {
  switch (nutrient) {
    case 'protein':
      return ['chicken breast', 'eggs', 'greek yogurt', 'lentils'];
    case 'fiber':
      return ['oats', 'berries', 'broccoli', 'beans'];
    case 'fat':
      return ['avocado', 'nuts', 'olive oil', 'salmon'];
    default:
      return [];
  }
}

List<String> _getReductionSuggestions(String nutrient) {
  switch (nutrient) {
    case 'sodium':
      return ['Choose fresh foods', 'Use herbs instead of salt'];
    case 'calories':
      return ['Reduce portion sizes', 'Choose lower calorie options'];
    default:
      return ['Moderate intake'];
  }
}

// Additional nutrition tracking providers
final nutritionProgressProvider = FutureProvider.family<NutritionProgressSummary?, DateRange>((ref, dateRange) async {
  final notifier = ref.watch(nutritionStateProvider.notifier);
  return await notifier.getNutritionProgress(dateRange.start, dateRange.end);
});

final micronutrientAnalysisProvider = FutureProvider.family<MicronutrientAnalysis?, int>((ref, days) async {
  final notifier = ref.watch(nutritionStateProvider.notifier);
  return await notifier.analyzeMicronutrients(days);
});

final dietaryValidationProvider = FutureProvider.family<DietaryValidation?, DietaryValidationRequest>((ref, request) async {
  final notifier = ref.watch(nutritionStateProvider.notifier);
  return await notifier.validateDietaryRestrictions(
    request.foods,
    request.restrictions,
    request.allergies,
  );
});

final nutritionStreaksProvider = FutureProvider<NutritionStreaks?>((ref) async {
  final repository = ref.watch(nutritionRepositoryProvider);
  final userId = ref.watch(currentUserIdProvider);
  
  if (userId == null) return null;
  
  try {
    return await repository.getNutritionStreaks(userId);
  } catch (e) {
    return null;
  }
});

final nutritionInsightsProvider = FutureProvider<List<NutritionInsight>>((ref) async {
  final repository = ref.watch(nutritionRepositoryProvider);
  final userId = ref.watch(currentUserIdProvider);
  
  if (userId == null) return [];
  
  try {
    return await repository.getNutritionInsights(userId);
  } catch (e) {
    return [];
  }
});

// Helper classes
class DateRange {
  final DateTime start;
  final DateTime end;

  const DateRange({
    required this.start,
    required this.end,
  });
}

class DietaryValidationRequest {
  final List<FoodEntry> foods;
  final List<DietaryRestriction> restrictions;
  final List<String> allergies;

  const DietaryValidationRequest({
    required this.foods,
    required this.restrictions,
    required this.allergies,
  });
}