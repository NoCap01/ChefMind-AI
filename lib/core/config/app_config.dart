class AppConfig {
  static const String appName = 'ChefMind AI';
  static const String appVersion = '1.0.0';
  
  // API Configuration
  static const String openAIBaseUrl = 'https://api.openai.com/v1';
  static const String openAIModel = 'gpt-4';
  
  // Firebase Configuration
  static const String firebaseProjectId = 'chefmind-ai';
  
  // Cache Configuration
  static const Duration cacheExpiration = Duration(hours: 24);
  static const int maxCachedRecipes = 100;
  
  // UI Configuration
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);
  
  // Performance Configuration
  static const Duration apiTimeout = Duration(seconds: 30);
  static const int maxRetries = 3;
  
  // Environment-specific configurations
  static bool get isDebug {
    bool inDebugMode = false;
    assert(inDebugMode = true);
    return inDebugMode;
  }
  
  static String get environment {
    if (isDebug) return 'development';
    return 'production';
  }
}