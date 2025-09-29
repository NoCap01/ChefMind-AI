class AppConfig {
  static const String appName = 'ChefMind AI';
  static const String appVersion = '1.0.0';

  // API Configuration
  static const String openAIBaseUrl = 'https://api.openai.com/v1';
  static const String openAIModel = 'gpt-4';

  // Firebase Configuration
  static const String firebaseProjectId = 'chefmind-ai';

  // Cache Configuration
  static const Duration cacheTimeout = Duration(minutes: 30);
  static const int maxCachedRecipes = 100;

  // API Limits
  static const int maxIngredientsPerRecipe = 20;
  static const int maxRecipeGenerationsPerDay = 50;

  // UI Configuration
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const double borderRadius = 12.0;
  static const double defaultPadding = 16.0;
}
