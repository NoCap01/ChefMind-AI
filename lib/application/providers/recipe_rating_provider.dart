import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/recipe_rating.dart';
import '../../domain/repositories/recipe_rating_repository.dart';
import '../../infrastructure/repositories/firebase_recipe_rating_repository.dart';

// Repository provider
final recipeRatingRepositoryProvider = Provider<IRecipeRatingRepository>((ref) {
  return FirebaseRecipeRatingRepository.instance;
});

// Rating providers
final recipeRatingsProvider = FutureProvider.family<List<RecipeRating>, String>((ref, recipeId) async {
  final repository = ref.read(recipeRatingRepositoryProvider);
  return repository.getRecipeRatings(recipeId);
});

final userRatingsProvider = FutureProvider.family<List<RecipeRating>, String>((ref, userId) async {
  final repository = ref.read(recipeRatingRepositoryProvider);
  return repository.getUserRatings(userId);
});

final userRecipeRatingProvider = FutureProvider.family<RecipeRating?, ({String userId, String recipeId})>((ref, params) async {
  final repository = ref.read(recipeRatingRepositoryProvider);
  return repository.getUserRecipeRating(params.userId, params.recipeId);
});

// Analytics providers
final recipeAnalyticsProvider = FutureProvider.family<RecipeAnalyticsData?, String>((ref, recipeId) async {
  final repository = ref.read(recipeRatingRepositoryProvider);
  return repository.getRecipeAnalytics(recipeId);
});

final mostCookedRecipesProvider = FutureProvider.family<List<String>, String>((ref, userId) async {
  final repository = ref.read(recipeRatingRepositoryProvider);
  return repository.getMostCookedRecipes(userId);
});

final highestRatedRecipesProvider = FutureProvider.family<List<String>, String>((ref, userId) async {
  final repository = ref.read(recipeRatingRepositoryProvider);
  return repository.getHighestRatedRecipes(userId);
});

final recentlyViewedRecipesProvider = FutureProvider.family<List<String>, String>((ref, userId) async {
  final repository = ref.read(recipeRatingRepositoryProvider);
  return repository.getRecentlyViewedRecipes(userId);
});

final cookingFrequencyProvider = FutureProvider.family<Map<String, int>, String>((ref, userId) async {
  final repository = ref.read(recipeRatingRepositoryProvider);
  return repository.getCookingFrequencyByDay(userId);
});

final userSuccessRateProvider = FutureProvider.family<double, String>((ref, userId) async {
  final repository = ref.read(recipeRatingRepositoryProvider);
  return repository.getUserSuccessRate(userId);
});

final skillProgressProvider = FutureProvider.family<Map<String, double>, String>((ref, userId) async {
  final repository = ref.read(recipeRatingRepositoryProvider);
  return repository.getSkillProgressMetrics(userId);
});

// History providers
final recipeHistoryProvider = FutureProvider.family<List<RecipeHistory>, String>((ref, recipeId) async {
  final repository = ref.read(recipeRatingRepositoryProvider);
  return repository.getRecipeHistory(recipeId);
});

final userHistoryProvider = FutureProvider.family<List<RecipeHistory>, ({String userId, RecipeHistoryAction? action})>((ref, params) async {
  final repository = ref.read(recipeRatingRepositoryProvider);
  return repository.getUserHistory(params.userId, action: params.action);
});

final recentHistoryProvider = FutureProvider.family<List<RecipeHistory>, String>((ref, userId) async {
  final repository = ref.read(recipeRatingRepositoryProvider);
  return repository.getRecentHistory(userId);
});

// Cooking session providers
final activeCookingSessionProvider = FutureProvider.family<CookingSession?, ({String userId, String recipeId})>((ref, params) async {
  final repository = ref.read(recipeRatingRepositoryProvider);
  return repository.getActiveCookingSession(params.userId, params.recipeId);
});

final userCookingSessionsProvider = FutureProvider.family<List<CookingSession>, String>((ref, userId) async {
  final repository = ref.read(recipeRatingRepositoryProvider);
  return repository.getUserCookingSessions(userId);
});

// State notifier for managing rating operations
class RecipeRatingNotifier extends StateNotifier<AsyncValue<void>> {
  final IRecipeRatingRepository _repository;
  final Ref _ref;

  RecipeRatingNotifier(this._repository, this._ref) : super(const AsyncValue.data(null));

  Future<void> submitRating(RecipeRating rating) async {
    state = const AsyncValue.loading();
    
    try {
      await _repository.saveRating(rating);
      
      // Invalidate related providers to refresh data
      _ref.invalidate(recipeRatingsProvider(rating.recipeId));
      _ref.invalidate(userRatingsProvider(rating.userId));
      _ref.invalidate(userRecipeRatingProvider((userId: rating.userId, recipeId: rating.recipeId)));
      _ref.invalidate(recipeAnalyticsProvider(rating.recipeId));
      _ref.invalidate(userSuccessRateProvider(rating.userId));
      _ref.invalidate(skillProgressProvider(rating.userId));
      
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> updateRating(RecipeRating rating) async {
    state = const AsyncValue.loading();
    
    try {
      await _repository.updateRating(rating);
      
      // Invalidate related providers to refresh data
      _ref.invalidate(recipeRatingsProvider(rating.recipeId));
      _ref.invalidate(userRatingsProvider(rating.userId));
      _ref.invalidate(userRecipeRatingProvider((userId: rating.userId, recipeId: rating.recipeId)));
      _ref.invalidate(recipeAnalyticsProvider(rating.recipeId));
      _ref.invalidate(userSuccessRateProvider(rating.userId));
      _ref.invalidate(skillProgressProvider(rating.userId));
      
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> deleteRating(String ratingId, String userId, String recipeId) async {
    state = const AsyncValue.loading();
    
    try {
      await _repository.deleteRating(ratingId);
      
      // Invalidate related providers to refresh data
      _ref.invalidate(recipeRatingsProvider(recipeId));
      _ref.invalidate(userRatingsProvider(userId));
      _ref.invalidate(userRecipeRatingProvider((userId: userId, recipeId: recipeId)));
      _ref.invalidate(recipeAnalyticsProvider(recipeId));
      _ref.invalidate(userSuccessRateProvider(userId));
      _ref.invalidate(skillProgressProvider(userId));
      
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> recordHistory(RecipeHistory history) async {
    try {
      await _repository.recordHistory(history);
      
      // Invalidate related providers
      _ref.invalidate(recipeHistoryProvider(history.recipeId));
      _ref.invalidate(userHistoryProvider((userId: history.userId, action: null)));
      _ref.invalidate(recentHistoryProvider(history.userId));
      _ref.invalidate(recipeAnalyticsProvider(history.recipeId));
      
      // Invalidate specific history providers based on action
      switch (history.action) {
        case RecipeHistoryAction.viewed:
          _ref.invalidate(recentlyViewedRecipesProvider(history.userId));
          break;
        case RecipeHistoryAction.cooked:
          _ref.invalidate(mostCookedRecipesProvider(history.userId));
          _ref.invalidate(cookingFrequencyProvider(history.userId));
          break;
        default:
          break;
      }
    } catch (error) {
      // Log error but don't throw to avoid breaking the main flow
      print('Failed to record history: $error');
    }
  }

  Future<void> startCookingSession(CookingSession session) async {
    try {
      await _repository.startCookingSession(session);
      
      // Invalidate session providers
      _ref.invalidate(activeCookingSessionProvider((userId: session.userId, recipeId: session.recipeId)));
      _ref.invalidate(userCookingSessionsProvider(session.userId));
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> endCookingSession(String sessionId, String userId, String recipeId, {double? rating, bool? wasSuccessful}) async {
    try {
      await _repository.endCookingSession(sessionId, rating: rating, wasSuccessful: wasSuccessful);
      
      // Invalidate session and history providers
      _ref.invalidate(activeCookingSessionProvider((userId: userId, recipeId: recipeId)));
      _ref.invalidate(userCookingSessionsProvider(userId));
      _ref.invalidate(userHistoryProvider((userId: userId, action: RecipeHistoryAction.cooked)));
      _ref.invalidate(mostCookedRecipesProvider(userId));
      _ref.invalidate(cookingFrequencyProvider(userId));
      _ref.invalidate(recipeAnalyticsProvider(recipeId));
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

final recipeRatingNotifierProvider = StateNotifierProvider<RecipeRatingNotifier, AsyncValue<void>>((ref) {
  final repository = ref.read(recipeRatingRepositoryProvider);
  return RecipeRatingNotifier(repository, ref);
});

// Convenience methods for common operations
extension RecipeRatingProviderExtensions on WidgetRef {
  Future<void> submitRecipeRating(RecipeRating rating) {
    return read(recipeRatingNotifierProvider.notifier).submitRating(rating);
  }

  Future<void> updateRecipeRating(RecipeRating rating) {
    return read(recipeRatingNotifierProvider.notifier).updateRating(rating);
  }

  Future<void> deleteRecipeRating(String ratingId, String userId, String recipeId) {
    return read(recipeRatingNotifierProvider.notifier).deleteRating(ratingId, userId, recipeId);
  }

  Future<void> recordRecipeHistory(RecipeHistory history) {
    return read(recipeRatingNotifierProvider.notifier).recordHistory(history);
  }

  Future<void> startRecipeCookingSession(CookingSession session) {
    return read(recipeRatingNotifierProvider.notifier).startCookingSession(session);
  }

  Future<void> endRecipeCookingSession(String sessionId, String userId, String recipeId, {double? rating, bool? wasSuccessful}) {
    return read(recipeRatingNotifierProvider.notifier).endCookingSession(sessionId, userId, recipeId, rating: rating, wasSuccessful: wasSuccessful);
  }
}