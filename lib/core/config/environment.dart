import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../security/secure_storage.dart';

class EnvironmentConfig {
  // Initialize dotenv and secure storage
  static Future<void> initialize() async {
    try {
      await dotenv.load(fileName: ".env");
    } catch (e) {
      // .env file not found, use default values
      print('Warning: .env file not found, using default values');
    }
    
    // Initialize secure storage
    await SecureStorage.instance.initialize();
  }

  // OpenAI Configuration - now uses secure storage
  static Future<String?> get openAIApiKey async {
    // First try secure storage
    final secureKey = await ApiKeyManager.getOpenAIKey();
    if (secureKey != null) return secureKey;
    
    // Fallback to environment variables (for development)
    final envKey = dotenv.env['OPENAI_API_KEY'] ?? 
        const String.fromEnvironment('OPENAI_API_KEY', defaultValue: '');
    
    if (envKey.isNotEmpty && envKey != 'your-openai-api-key-here') {
      // Store in secure storage for future use
      await ApiKeyManager.storeOpenAIKey(envKey);
      return envKey;
    }
    
    return null;
  }

  // Hugging Face Configuration
  static Future<String?> get huggingFaceApiKey async {
    // First try secure storage
    final secureKey = await ApiKeyManager.getHuggingFaceKey();
    if (secureKey != null) return secureKey;
    
    // Fallback to environment variables
    final envKey = dotenv.env['HUGGINGFACE_API_KEY'] ?? 
        const String.fromEnvironment('HUGGINGFACE_API_KEY', defaultValue: '');
    
    if (envKey.isNotEmpty) {
      // Store in secure storage for future use
      await ApiKeyManager.storeHuggingFaceKey(envKey);
      return envKey;
    }
    
    return null;
  }
  
  // Firebase Configuration
  static String get firebaseProjectId => dotenv.env['FIREBASE_PROJECT_ID'] ?? 
      const String.fromEnvironment('FIREBASE_PROJECT_ID', defaultValue: 'your-project-id');
  
  // App Configuration
  static bool get isProduction => dotenv.env['PRODUCTION']?.toLowerCase() == 'true' ||
      const bool.fromEnvironment('PRODUCTION', defaultValue: false);
  
  static bool get enableMockData => dotenv.env['ENABLE_MOCK_DATA']?.toLowerCase() == 'true' ||
      const bool.fromEnvironment('ENABLE_MOCK_DATA', defaultValue: true);
  
  // API Endpoints
  static String get baseApiUrl => dotenv.env['BASE_API_URL'] ?? 
      const String.fromEnvironment('BASE_API_URL', defaultValue: 'https://api.chefmind.ai');
  
  // Feature Flags
  static bool get enableAIGeneration => dotenv.env['ENABLE_AI_GENERATION']?.toLowerCase() != 'false' &&
      const bool.fromEnvironment('ENABLE_AI_GENERATION', defaultValue: true);
  
  static bool get enableSocialFeatures => dotenv.env['ENABLE_SOCIAL_FEATURES']?.toLowerCase() != 'false' &&
      const bool.fromEnvironment('ENABLE_SOCIAL_FEATURES', defaultValue: true);
  
  // Validation
  static Future<bool> get hasValidOpenAIKey async {
    final key = await openAIApiKey;
    return key != null && 
           key.isNotEmpty && 
           key != 'your-openai-api-key-here' &&
           key.startsWith('sk-');
  }

  static Future<bool> get hasValidHuggingFaceKey async {
    final key = await huggingFaceApiKey;
    return key != null && 
           key.isNotEmpty && 
           key.startsWith('hf_');
  }

  // Security Configuration
  static bool get enableSecureStorage => dotenv.env['ENABLE_SECURE_STORAGE']?.toLowerCase() != 'false' &&
      const bool.fromEnvironment('ENABLE_SECURE_STORAGE', defaultValue: true);

  static bool get enableInputValidation => dotenv.env['ENABLE_INPUT_VALIDATION']?.toLowerCase() != 'false' &&
      const bool.fromEnvironment('ENABLE_INPUT_VALIDATION', defaultValue: true);

  static bool get enableDataEncryption => dotenv.env['ENABLE_DATA_ENCRYPTION']?.toLowerCase() != 'false' &&
      const bool.fromEnvironment('ENABLE_DATA_ENCRYPTION', defaultValue: true);

  // Rate limiting configuration
  static int get apiRateLimit => int.tryParse(dotenv.env['API_RATE_LIMIT'] ?? '') ??
      const int.fromEnvironment('API_RATE_LIMIT', defaultValue: 60);

  static Duration get rateLimitWindow => Duration(
    minutes: int.tryParse(dotenv.env['RATE_LIMIT_WINDOW_MINUTES'] ?? '') ??
        const int.fromEnvironment('RATE_LIMIT_WINDOW_MINUTES', defaultValue: 1),
  );
}