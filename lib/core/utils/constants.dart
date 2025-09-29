class AppConstants {
  // App Information
  static const String appName = 'ChefMind AI';
  static const String appDescription = 'AI-Powered Recipe Generation';
  static const String appVersion = '1.0.0';

  // Animation Durations
  static const int fastAnimationDuration = 200;
  static const int normalAnimationDuration = 300;
  static const int slowAnimationDuration = 500;

  // UI Dimensions
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double borderRadius = 12.0;
  static const double smallBorderRadius = 8.0;
  static const double largeBorderRadius = 16.0;

  // Recipe Generation Limits
  static const int maxIngredientsCount = 20;
  static const int minIngredientsCount = 1;
  static const int maxRecipeTitle = 100;
  static const int maxRecipeDescription = 500;
  static const int maxInstructionLength = 200;

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 50;

  // Cache Configuration
  static const Duration cacheValidityDuration = Duration(hours: 24);
  static const int maxCacheSize = 100;

  // Recipe Rating
  static const double minRating = 1.0;
  static const double maxRating = 5.0;

  // Nutritional Goals (daily)
  static const double defaultDailyCalories = 2000;
  static const double defaultDailyProtein = 50;
  static const double defaultDailyCarbs = 250;
  static const double defaultDailyFat = 65;

  // Recipe Images
  static const String defaultRecipeImagePath = 'assets/images/default_recipe.png';
  static const String defaultUserAvatarPath = 'assets/images/default_avatar.png';

  // Supported Image Formats
  static const List<String> supportedImageFormats = ['jpg', 'jpeg', 'png', 'webp'];

  // Voice Recognition
  static const Duration voiceTimeout = Duration(seconds: 5);
  static const Duration voicePause = Duration(seconds: 2);

  // Shopping List Categories
  static const List<String> shoppingCategories = [
    'Produce',
    'Dairy',
    'Meat & Seafood',
    'Pantry',
    'Frozen',
    'Beverages',
    'Bakery',
    'Health & Beauty',
    'Other',
  ];

  // Kitchen Equipment
  static const List<String> basicKitchenEquipment = [
    'Knife',
    'Cutting Board',
    'Pots and Pans',
    'Measuring Cups',
    'Mixing Bowls',
    'Spatula',
    'Whisk',
    'Can Opener',
  ];

  // Common Cooking Times (in minutes)
  static const Map<String, int> commonCookingTimes = {
    'Rice': 20,
    'Pasta': 10,
    'Chicken Breast': 25,
    'Ground Beef': 15,
    'Vegetables': 10,
    'Eggs': 5,
  };
}

class ApiUrls {
  static const String baseUrl = 'https://api.openai.com/v1';
  static const String chatCompletions = '/chat/completions';
  static const String models = '/models';
}

class StorageKeys {
  static const String userPreferences = 'user_preferences';
  static const String cachedRecipes = 'cached_recipes';
  static const String recentSearches = 'recent_searches';
  static const String theme = 'app_theme';
  static const String onboardingCompleted = 'onboarding_completed';
}
