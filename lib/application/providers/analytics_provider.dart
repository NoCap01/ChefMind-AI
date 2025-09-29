import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/user_statistics_service.dart';
import 'auth_provider.dart';

// User statistics service provider
final userStatisticsServiceProvider = Provider<UserStatisticsService>((ref) {
  return UserStatisticsService();
});

// User statistics provider
final userStatisticsProvider = FutureProvider<UserStatistics?>((ref) async {
  final authState = ref.watch(authStateProvider);
  final statisticsService = ref.watch(userStatisticsServiceProvider);
  
  if (authState is AuthStateAuthenticated) {
    try {
      await statisticsService.initialize();
      return await statisticsService.getUserStatistics(authState.user.userId);
    } catch (e) {
      return null;
    }
  }
  
  return null;
});

// User achievements provider
final userAchievementsProvider = FutureProvider<List<Achievement>>((ref) async {
  final authState = ref.watch(authStateProvider);
  final statisticsService = ref.watch(userStatisticsServiceProvider);
  
  if (authState is AuthStateAuthenticated) {
    try {
      await statisticsService.initialize();
      return await statisticsService.getUserAchievements(authState.user.userId);
    } catch (e) {
      return [];
    }
  }
  
  return [];
});

// Top cuisines provider
final topCuisinesProvider = FutureProvider<List<CuisineStats>>((ref) async {
  final authState = ref.watch(authStateProvider);
  final statisticsService = ref.watch(userStatisticsServiceProvider);
  
  if (authState is AuthStateAuthenticated) {
    try {
      await statisticsService.initialize();
      return await statisticsService.getTopCuisines(authState.user.userId);
    } catch (e) {
      return [];
    }
  }
  
  return [];
});

// Top ingredients provider
final topIngredientsProvider = FutureProvider<List<IngredientStats>>((ref) async {
  final authState = ref.watch(authStateProvider);
  final statisticsService = ref.watch(userStatisticsServiceProvider);
  
  if (authState is AuthStateAuthenticated) {
    try {
      await statisticsService.initialize();
      return await statisticsService.getTopIngredients(authState.user.userId);
    } catch (e) {
      return [];
    }
  }
  
  return [];
});

// Analytics notifier for tracking events
final analyticsNotifierProvider = StateNotifierProvider<AnalyticsNotifier, AsyncValue<void>>((ref) {
  final statisticsService = ref.watch(userStatisticsServiceProvider);
  return AnalyticsNotifier(statisticsService);
});

class AnalyticsNotifier extends StateNotifier<AsyncValue<void>> {
  final UserStatisticsService _statisticsService;

  AnalyticsNotifier(this._statisticsService) : super(const AsyncValue.data(null));

  Future<void> initialize() async {
    try {
      await _statisticsService.initialize();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  // Track recipe generation
  Future<void> trackRecipeGeneration({
    required String userId,
    required List<String> ingredients,
    String? cuisine,
    String? mealType,
  }) async {
    try {
      await _statisticsService.recordRecipeGeneration(
        userId,
        cuisine: cuisine,
        ingredients: ingredients,
      );
      
      // In a real app, this would also send data to external analytics service
      print('Recipe generated: ingredients=$ingredients, cuisine=$cuisine, mealType=$mealType');
    } catch (e) {
      print('Failed to track recipe generation: $e');
    }
  }

  // Track recipe cooking
  Future<void> trackRecipeCooking({
    required String userId,
    required String recipeId,
    required String recipeName,
    required int cookingTime,
    String? cuisine,
  }) async {
    try {
      await _statisticsService.recordRecipeCooking(
        userId,
        recipeId: recipeId,
        cookingTime: cookingTime,
        cuisine: cuisine,
      );
      
      // In a real app, this would also send data to external analytics service
      print('Recipe cooked: id=$recipeId, name=$recipeName, time=$cookingTime, cuisine=$cuisine');
    } catch (e) {
      print('Failed to track recipe cooking: $e');
    }
  }

  // Track recipe saving
  Future<void> trackRecipeSaving({
    required String userId,
    required String recipeId,
    required String recipeName,
    String? source,
  }) async {
    try {
      // In a real app, this would send data to analytics service
      print('Recipe saved: id=$recipeId, name=$recipeName, source=$source');
    } catch (e) {
      print('Failed to track recipe saving: $e');
    }
  }

  // Track user engagement
  Future<void> trackUserEngagement({
    required String action,
    required String screen,
    Map<String, dynamic>? properties,
  }) async {
    try {
      // In a real app, this would send data to analytics service
      print('User engagement: action=$action, screen=$screen, properties=$properties');
    } catch (e) {
      print('Failed to track user engagement: $e');
    }
  }

  // Track errors
  Future<void> trackError({
    required String error,
    required String context,
    Map<String, dynamic>? properties,
  }) async {
    try {
      // In a real app, this would send data to analytics service
      print('Error tracked: error=$error, context=$context, properties=$properties');
    } catch (e) {
      print('Failed to track error: $e');
    }
  }

  // Get cooking activity for a specific period
  Future<Map<String, int>> getCookingActivity(String userId, ActivityPeriod period) async {
    try {
      return await _statisticsService.getCookingActivity(userId, period);
    } catch (e) {
      return {};
    }
  }

  // Reset user statistics
  Future<void> resetStatistics(String userId) async {
    try {
      await _statisticsService.resetStatistics(userId);
      state = const AsyncValue.data(null);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

// Legacy analytics data model for backward compatibility
class AnalyticsData {
  final int totalRecipesCooked;
  final int totalCookingHours;
  final double averageRating;
  final int recipesCreated;
  final int favoriteRecipes;
  final Map<String, int> cuisinePreferences;
  final Map<String, int> cookingTimeDistribution;

  const AnalyticsData({
    required this.totalRecipesCooked,
    required this.totalCookingHours,
    required this.averageRating,
    required this.recipesCreated,
    required this.favoriteRecipes,
    required this.cuisinePreferences,
    required this.cookingTimeDistribution,
  });
}

// Legacy analytics provider for backward compatibility
final analyticsProvider = FutureProvider<AnalyticsData>((ref) async {
  final userStats = await ref.watch(userStatisticsProvider.future);
  
  if (userStats != null) {
    return AnalyticsData(
      totalRecipesCooked: userStats.recipesCooked,
      totalCookingHours: (userStats.totalCookingTime / 60).round(),
      averageRating: 4.2, // Mock value
      recipesCreated: userStats.recipesGenerated,
      favoriteRecipes: userStats.favoriteRecipes,
      cuisinePreferences: userStats.cuisinePreferences,
      cookingTimeDistribution: {
        '0-15 min': 8,
        '15-30 min': 18,
        '30-60 min': 12,
        '60+ min': 4,
      }, // Mock distribution
    );
  }
  
  // Fallback mock data
  return const AnalyticsData(
    totalRecipesCooked: 0,
    totalCookingHours: 0,
    averageRating: 0.0,
    recipesCreated: 0,
    favoriteRecipes: 0,
    cuisinePreferences: {},
    cookingTimeDistribution: {},
  );
});

// Weekly analytics provider
final weeklyAnalyticsProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final authState = ref.watch(authStateProvider);
  final analyticsNotifier = ref.watch(analyticsNotifierProvider.notifier);
  
  if (authState is AuthStateAuthenticated) {
    final weeklyActivity = await analyticsNotifier.getCookingActivity(
      authState.user.userId, 
      ActivityPeriod.weekly,
    );
    
    return {
      'recipesThisWeek': weeklyActivity.values.fold(0, (a, b) => a + b),
      'cookingTimeThisWeek': 8, // Mock value
      'newRecipesTried': 2, // Mock value
      'dailyActivity': weeklyActivity,
    };
  }
  
  return {
    'recipesThisWeek': 0,
    'cookingTimeThisWeek': 0,
    'newRecipesTried': 0,
    'dailyActivity': {},
  };
});

// Monthly analytics provider
final monthlyAnalyticsProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final authState = ref.watch(authStateProvider);
  final analyticsNotifier = ref.watch(analyticsNotifierProvider.notifier);
  
  if (authState is AuthStateAuthenticated) {
    final monthlyActivity = await analyticsNotifier.getCookingActivity(
      authState.user.userId, 
      ActivityPeriod.monthly,
    );
    
    return {
      'recipesThisMonth': monthlyActivity.values.fold(0, (a, b) => a + b),
      'cookingTimeThisMonth': 24, // Mock value
      'newRecipesTried': 6, // Mock value
      'favoriteAdded': 4, // Mock value
      'weeklyTrend': [3, 5, 4, 6], // Mock trend
    };
  }
  
  return {
    'recipesThisMonth': 0,
    'cookingTimeThisMonth': 0,
    'newRecipesTried': 0,
    'favoriteAdded': 0,
    'weeklyTrend': [],
  };
});