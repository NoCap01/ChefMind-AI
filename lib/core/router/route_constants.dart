/// Route constants for the ChefMind AI application
/// 
/// This file contains all route paths and names used throughout the app
/// for consistent navigation and deep linking support.
class RouteConstants {
  // Private constructor to prevent instantiation
  RouteConstants._();

  // Auth Routes
  static const String authPath = '/auth';
  static const String authName = 'auth';

  // Main Tab Routes
  static const String homePath = '/';
  static const String homeName = 'home';
  
  static const String recipeBookPath = '/recipe-book';
  static const String recipeBookName = 'recipe-book';
  
  static const String shoppingPath = '/shopping';
  static const String shoppingName = 'shopping';
  
  static const String mealPlannerPath = '/meal-planner';
  static const String mealPlannerName = 'meal-planner';
  
  static const String profilePath = '/profile';
  static const String profileName = 'profile';

  // Recipe Routes
  static const String recipeDetailPath = '/recipe/:id';
  static const String recipeDetailName = 'recipe-detail';
  
  static const String recipeSharePath = '/recipe/:id/share';
  static const String recipeShareName = 'recipe-share';

  // Search Routes
  static const String searchPath = '/search';
  static const String searchName = 'search';
  
  static const String advancedSearchPath = '/search/advanced';
  static const String advancedSearchName = 'advanced-search';

  // Shopping Routes
  static const String pantryPath = '/shopping/pantry';
  static const String pantryName = 'pantry';
  
  static const String shoppingListPath = '/shopping/list/:id';
  static const String shoppingListName = 'shopping-list';

  // Meal Planning Routes
  static const String mealPlanPath = '/meal-planner/plan/:id';
  static const String mealPlanName = 'meal-plan';
  
  static const String nutritionTrackerPath = '/meal-planner/nutrition';
  static const String nutritionTrackerName = 'nutrition-tracker';

  // Profile Routes
  static const String settingsPath = '/profile/settings';
  static const String settingsName = 'settings';
  
  static const String preferencesPath = '/profile/preferences';
  static const String preferencesName = 'preferences';
  
  static const String achievementsPath = '/profile/achievements';
  static const String achievementsName = 'achievements';

  // Community Routes
  static const String communityPath = '/community';
  static const String communityName = 'community';
  
  static const String groupPath = '/community/group/:id';
  static const String groupName = 'community-group';

  // Kitchen Tools Routes
  static const String kitchenToolsPath = '/tools';
  static const String kitchenToolsName = 'kitchen-tools';
  
  static const String timersPath = '/tools/timers';
  static const String timersName = 'timers';
  
  static const String converterPath = '/tools/converter';
  static const String converterName = 'converter';

  // Learning Routes
  static const String tutorialsPath = '/learn';
  static const String tutorialsName = 'tutorials';
  
  static const String tutorialPath = '/learn/tutorial/:id';
  static const String tutorialName = 'tutorial';

  // Error Routes
  static const String notFoundPath = '/404';
  static const String notFoundName = 'not-found';
  
  static const String errorPath = '/error';
  static const String errorName = 'error';

  /// Helper method to build recipe detail path with ID
  static String buildRecipeDetailPath(String recipeId) {
    return '/recipe/$recipeId';
  }

  /// Helper method to build recipe share path with ID
  static String buildRecipeSharePath(String recipeId) {
    return '/recipe/$recipeId/share';
  }

  /// Helper method to build shopping list path with ID
  static String buildShoppingListPath(String listId) {
    return '/shopping/list/$listId';
  }

  /// Helper method to build meal plan path with ID
  static String buildMealPlanPath(String planId) {
    return '/meal-planner/plan/$planId';
  }

  /// Helper method to build community group path with ID
  static String buildGroupPath(String groupId) {
    return '/community/group/$groupId';
  }

  /// Helper method to build tutorial path with ID
  static String buildTutorialPath(String tutorialId) {
    return '/learn/tutorial/$tutorialId';
  }

  /// List of routes that require authentication
  static const List<String> authenticatedRoutes = [
    homePath,
    recipeBookPath,
    shoppingPath,
    mealPlannerPath,
    profilePath,
    searchPath,
    advancedSearchPath,
    pantryPath,
    nutritionTrackerPath,
    settingsPath,
    preferencesPath,
    achievementsPath,
    communityPath,
    kitchenToolsPath,
    timersPath,
    converterPath,
    tutorialsPath,
  ];

  /// List of routes that are accessible without authentication
  static const List<String> publicRoutes = [
    authPath,
    notFoundPath,
    errorPath,
  ];

  /// Check if a route requires authentication
  static bool requiresAuth(String path) {
    // Check exact matches first
    if (authenticatedRoutes.contains(path)) return true;
    
    // Check pattern matches for dynamic routes
    if (path.startsWith('/recipe/') && path != authPath) return true;
    if (path.startsWith('/shopping/list/')) return true;
    if (path.startsWith('/meal-planner/plan/')) return true;
    if (path.startsWith('/community/group/')) return true;
    if (path.startsWith('/learn/tutorial/')) return true;
    
    return false;
  }

  /// Check if a route is public (doesn't require authentication)
  static bool isPublicRoute(String path) {
    return publicRoutes.contains(path) || !requiresAuth(path);
  }
}