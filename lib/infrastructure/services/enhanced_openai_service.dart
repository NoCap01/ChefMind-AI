import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';

import '../../core/config/environment.dart';
import '../../core/security/secure_storage.dart';
import '../../core/security/input_validator.dart';
import '../../domain/entities/recipe.dart';
import '../../domain/entities/recipe_request.dart';
import '../../domain/enums/difficulty_level.dart';
import '../../domain/enums/meal_type.dart';
import '../../domain/services/ai_service_manager.dart';

/// Enhanced OpenAI service with retry logic and proper error handling
class EnhancedOpenAIService implements AIServiceManager {
  static final EnhancedOpenAIService _instance = EnhancedOpenAIService._internal();
  factory EnhancedOpenAIService() => _instance;
  EnhancedOpenAIService._internal();

  late final Dio _dio;
  bool _initialized = false;
  
  // Retry configuration
  static const int _maxRetries = 3;
  static const Duration _baseDelay = Duration(seconds: 1);
  static const Duration _maxDelay = Duration(seconds: 30);
  static const Duration _requestTimeout = Duration(seconds: 60);

  @override
  String get serviceName => 'OpenAI';

  @override
  int get priority => 1; // High priority (lower number = higher priority)

  Future<void> _initialize() async {
    if (_initialized) return;

    // Get API key securely
    final apiKey = await ApiKeyManager.getOpenAIKey();
    if (apiKey == null) {
      throw Exception('OpenAI API key not found in secure storage');
    }

    _dio = Dio(BaseOptions(
      baseUrl: 'https://api.openai.com/v1',
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      connectTimeout: _requestTimeout,
      receiveTimeout: _requestTimeout,
      sendTimeout: _requestTimeout,
    ));

    // Add interceptor for logging
    _dio.interceptors.add(LogInterceptor(
      requestBody: false, // Don't log request body for privacy
      responseBody: false, // Don't log response body for privacy
      logPrint: (obj) => developer.log(obj.toString(), name: 'OpenAI-HTTP'),
    ));

    _initialized = true;
  }

  @override
  Future<bool> isServiceAvailable() async {
    if (!_initialized) await _initialize();
    
    // Check if we have a valid API key
    if (!await EnvironmentConfig.hasValidOpenAIKey) {
      developer.log('OpenAI API key is invalid or missing', name: 'OpenAI');
      return false;
    }

    try {
      // Make a simple request to check service availability
      final response = await _dio.get('/models', options: Options(
        receiveTimeout: const Duration(seconds: 10),
      ));
      
      return response.statusCode == 200;
    } catch (e) {
      developer.log('OpenAI service availability check failed: $e', name: 'OpenAI');
      return false;
    }
  }

  @override
  Future<Recipe> generateRecipe(RecipeRequest request) async {
    if (!_initialized) await _initialize();

    // Validate input request
    _validateRecipeRequest(request);

    if (!await EnvironmentConfig.hasValidOpenAIKey) {
      throw AIServiceException(
        'OpenAI API key is invalid or missing',
        serviceName: serviceName,
      );
    }

    return await _executeWithRetry(() => _generateRecipeInternal(request));
  }

  Future<Recipe> _generateRecipeInternal(RecipeRequest request) async {
    try {
      developer.log('Generating recipe with OpenAI API', name: 'OpenAI');
      
      final prompt = _buildPrompt(request);
      
      final response = await _dio.post('/chat/completions', data: {
        'model': 'gpt-3.5-turbo',
        'messages': [
          {
            'role': 'system',
            'content': 'You are a professional chef and recipe creator. Always respond with valid JSON format only. Do not include any text outside the JSON object.'
          },
          {
            'role': 'user',
            'content': prompt
          }
        ],
        'temperature': 0.7,
        'max_tokens': 2000,
        'top_p': 1.0,
        'frequency_penalty': 0.0,
        'presence_penalty': 0.0,
      });

      final content = response.data['choices'][0]['message']['content'] as String;
      developer.log('OpenAI response received successfully', name: 'OpenAI');
      
      return _parseOpenAIResponse(content, request);
      
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      developer.log('Unexpected error in OpenAI service: $e', name: 'OpenAI');
      throw AIServiceException(
        'Unexpected error during recipe generation: $e',
        serviceName: serviceName,
        originalException: e is Exception ? e : Exception(e.toString()),
      );
    }
  }

  /// Validate recipe request input
  void _validateRecipeRequest(RecipeRequest request) {
    // Validate ingredients
    if (request.ingredients.isEmpty) {
      throw AIServiceException('At least one ingredient is required', serviceName: serviceName);
    }

    for (final ingredient in request.ingredients) {
      final validation = InputValidator.validateIngredient(ingredient);
      if (!validation.isValid) {
        throw AIServiceException('Invalid ingredient: ${validation.errorMessage}', serviceName: serviceName);
      }
    }

    // Validate cuisine type if provided
    if (request.cuisineType != null) {
      final sanitized = InputValidator.sanitizeInput(request.cuisineType!);
      if (sanitized != request.cuisineType) {
        throw AIServiceException('Invalid cuisine type', serviceName: serviceName);
      }
    }

    // Rate limiting check
    if (InputValidator.isRateLimited('openai_recipe_generation', 10, const Duration(minutes: 1))) {
      throw AIServiceException('Rate limit exceeded. Please try again later.', serviceName: serviceName);
    }
  }

  String _buildPrompt(RecipeRequest request) {
    final buffer = StringBuffer();
    
    // Sanitize ingredients before using them
    final sanitizedIngredients = request.ingredients
        .map((ingredient) => InputValidator.sanitizeInput(ingredient))
        .toList();
    
    buffer.writeln('Create a detailed recipe using these main ingredients: ${sanitizedIngredients.join(", ")}');
    
    if (request.cuisineType != null) {
      final sanitizedCuisine = InputValidator.sanitizeInput(request.cuisineType!);
      buffer.writeln('Cuisine style: $sanitizedCuisine');
    }
    
    if (request.mealType != null) {
      buffer.writeln('Meal type: ${request.mealType}');
    }
    
    buffer.writeln('Servings: ${request.servings}');
    
    if (request.maxCookingTime != null) {
      buffer.writeln('Maximum total cooking time: ${request.maxCookingTime} minutes');
    }
    
    if (request.skillLevel != null) {
      buffer.writeln('Cooking skill level: ${request.skillLevel!.displayName}');
    }
    
    if (request.dietaryRestrictions.isNotEmpty) {
      buffer.writeln('Dietary restrictions: ${request.dietaryRestrictions.map((e) => e.displayName).join(", ")}');
    }
    
    if (request.allergies.isNotEmpty) {
      buffer.writeln('Allergies to avoid: ${request.allergies.join(", ")}');
    }
    
    if (request.dislikedIngredients.isNotEmpty) {
      buffer.writeln('Ingredients to avoid: ${request.dislikedIngredients.join(", ")}');
    }

    buffer.writeln();
    buffer.writeln('Respond with ONLY a JSON object in this exact format:');
    buffer.writeln('{');
    buffer.writeln('  "title": "Recipe Name",');
    buffer.writeln('  "description": "Brief appetizing description",');
    buffer.writeln('  "prepTime": 15,');
    buffer.writeln('  "cookTime": 30,');
    buffer.writeln('  "servings": ${request.servings},');
    buffer.writeln('  "difficulty": "medium",');
    buffer.writeln('  "cuisine": "cuisine type",');
    buffer.writeln('  "mealType": "meal type",');
    buffer.writeln('  "ingredients": [');
    buffer.writeln('    {"name": "ingredient name", "quantity": 1.5, "unit": "cups", "category": "protein"}');
    buffer.writeln('  ],');
    buffer.writeln('  "instructions": [');
    buffer.writeln('    {"stepNumber": 1, "instruction": "Detailed step instruction", "duration": 5}');
    buffer.writeln('  ],');
    buffer.writeln('  "nutrition": {');
    buffer.writeln('    "calories": 350, "protein": 25, "carbs": 40, "fat": 15, "fiber": 5, "sugar": 8, "sodium": 600');
    buffer.writeln('  },');
    buffer.writeln('  "tags": ["tag1", "tag2"],');
    buffer.writeln('  "tips": ["helpful tip 1", "helpful tip 2"]');
    buffer.writeln('}');
    
    return buffer.toString();
  }

  Recipe _parseOpenAIResponse(String content, RecipeRequest request) {
    try {
      // Clean the response to extract JSON
      String jsonString = content.trim();
      
      // Remove markdown code blocks if present
      if (jsonString.contains('```json')) {
        jsonString = jsonString.split('```json')[1].split('```')[0].trim();
      } else if (jsonString.contains('```')) {
        jsonString = jsonString.split('```')[1].split('```')[0].trim();
      }
      
      // Find JSON object boundaries
      final startIndex = jsonString.indexOf('{');
      final lastIndex = jsonString.lastIndexOf('}');
      
      if (startIndex == -1 || lastIndex == -1) {
        throw const FormatException('No valid JSON object found in response');
      }
      
      jsonString = jsonString.substring(startIndex, lastIndex + 1);
      
      final parsed = jsonDecode(jsonString) as Map<String, dynamic>;
      
      // Create recipe from parsed JSON
      return Recipe(
        id: const Uuid().v4(),
        title: parsed['title'] ?? 'Generated Recipe',
        description: parsed['description'] ?? 'A delicious recipe created just for you.',
        ingredients: _parseIngredients(parsed['ingredients']),
        instructions: _parseInstructions(parsed['instructions']),
        metadata: RecipeMetadata(
          prepTime: _parseTime(parsed['prepTime']) ?? 15,
          cookTime: _parseTime(parsed['cookTime']) ?? 30,
          servings: parsed['servings'] ?? request.servings,
          difficulty: _parseDifficulty(parsed['difficulty']),
          cuisine: parsed['cuisine'] ?? request.cuisineType,
          mealType: _parseMealType(parsed['mealType'] ?? request.mealType),
        ),
        nutrition: _parseNutrition(parsed['nutrition']),
        tags: _parseTags(parsed['tags']),
        createdAt: DateTime.now(),
        source: serviceName.toLowerCase(),
      );
      
    } catch (e) {
      developer.log('Failed to parse OpenAI response: $e', name: 'OpenAI');
      throw AIServiceException(
        'Failed to parse recipe from OpenAI response: $e',
        serviceName: serviceName,
        originalException: e is Exception ? e : Exception(e.toString()),
      );
    }
  }

  List<Ingredient> _parseIngredients(dynamic ingredients) {
    if (ingredients is! List) return [];
    
    return ingredients.map<Ingredient>((item) {
      if (item is Map<String, dynamic>) {
        return Ingredient(
          name: item['name'] ?? 'Unknown ingredient',
          quantity: (item['quantity'] ?? 1).toDouble(),
          unit: item['unit'] ?? 'piece',
          category: item['category'],
        );
      }
      return Ingredient(
        name: item.toString(),
        quantity: 1,
        unit: 'piece',
      );
    }).toList();
  }

  List<CookingStep> _parseInstructions(dynamic instructions) {
    if (instructions is! List) return [];
    
    return instructions.asMap().entries.map<CookingStep>((entry) {
      final index = entry.key;
      final item = entry.value;
      
      if (item is Map<String, dynamic>) {
        return CookingStep(
          stepNumber: item['stepNumber'] ?? (index + 1),
          instruction: item['instruction'] ?? 'Follow cooking procedure.',
          duration: item['duration'],
        );
      }
      
      return CookingStep(
        stepNumber: index + 1,
        instruction: item.toString(),
      );
    }).toList();
  }

  int? _parseTime(dynamic time) {
    if (time is int) return time;
    if (time is String) {
      final match = RegExp(r'\d+').firstMatch(time);
      return match != null ? int.tryParse(match.group(0)!) : null;
    }
    return null;
  }

  DifficultyLevel _parseDifficulty(dynamic difficulty) {
    if (difficulty is String) {
      return DifficultyLevel.values.firstWhere(
        (e) => e.name.toLowerCase() == difficulty.toLowerCase(),
        orElse: () => DifficultyLevel.medium,
      );
    }
    return DifficultyLevel.medium;
  }

  MealType? _parseMealType(dynamic mealType) {
    if (mealType is String) {
      return MealType.values.firstWhere(
        (e) => e.name.toLowerCase() == mealType.toLowerCase(),
        orElse: () => MealType.dinner,
      );
    }
    return null;
  }

  NutritionInfo? _parseNutrition(dynamic nutrition) {
    if (nutrition is! Map<String, dynamic>) return null;
    
    return NutritionInfo(
      calories: nutrition['calories'] ?? 0,
      protein: (nutrition['protein'] ?? 0).toDouble(),
      carbs: (nutrition['carbs'] ?? 0).toDouble(),
      fat: (nutrition['fat'] ?? 0).toDouble(),
      fiber: (nutrition['fiber'] ?? 0).toDouble(),
      sugar: (nutrition['sugar'] ?? 0).toDouble(),
      sodium: nutrition['sodium'] ?? 0,
    );
  }

  List<String> _parseTags(dynamic tags) {
    if (tags is List) {
      return tags.map((tag) => tag.toString()).toList();
    }
    return [];
  }

  Future<T> _executeWithRetry<T>(Future<T> Function() operation) async {
    int attempt = 0;
    Duration delay = _baseDelay;

    while (attempt < _maxRetries) {
      try {
        return await operation();
      } on AIServiceException catch (e) {
        // Check if this is a retryable error
        if (!_isRetryableError(e) || attempt == _maxRetries - 1) {
          rethrow;
        }
        
        developer.log(
          'Retryable error on attempt ${attempt + 1}: ${e.message}',
          name: 'OpenAI',
        );
      } catch (e) {
        if (attempt == _maxRetries - 1) {
          rethrow;
        }
        
        developer.log(
          'Unexpected error on attempt ${attempt + 1}: $e',
          name: 'OpenAI',
        );
      }

      attempt++;
      
      // Exponential backoff with jitter
      final jitter = Duration(milliseconds: Random().nextInt(1000));
      final totalDelay = Duration(
        milliseconds: min(
          delay.inMilliseconds + jitter.inMilliseconds,
          _maxDelay.inMilliseconds,
        ),
      );
      
      developer.log(
        'Retrying in ${totalDelay.inMilliseconds}ms (attempt $attempt/$_maxRetries)',
        name: 'OpenAI',
      );
      
      await Future.delayed(totalDelay);
      delay = Duration(milliseconds: delay.inMilliseconds * 2);
    }

    throw AIServiceException(
      'Max retries exceeded',
      serviceName: serviceName,
    );
  }

  bool _isRetryableError(AIServiceException e) {
    // Retry on rate limiting, server errors, and network issues
    return e.message.contains('429') || // Rate limit
           e.message.contains('500') || // Server error
           e.message.contains('502') || // Bad gateway
           e.message.contains('503') || // Service unavailable
           e.message.contains('504') || // Gateway timeout
           e.message.toLowerCase().contains('network') ||
           e.message.toLowerCase().contains('timeout');
  }

  AIServiceException _handleDioException(DioException e) {
    switch (e.response?.statusCode) {
      case 400:
        return AIServiceException(
          'Invalid request to OpenAI API: ${e.response?.data}',
          serviceName: serviceName,
          originalException: e,
        );
      case 401:
        return AIServiceException(
          'Invalid OpenAI API key or authentication failed',
          serviceName: serviceName,
          originalException: e,
        );
      case 429:
        return AIServiceException(
          'OpenAI API rate limit exceeded. Please try again later.',
          serviceName: serviceName,
          originalException: e,
        );
      case 500:
      case 502:
      case 503:
      case 504:
        return AIServiceException(
          'OpenAI server error (${e.response?.statusCode}). Please try again later.',
          serviceName: serviceName,
          originalException: e,
        );
      default:
        return AIServiceException(
          'Network error: ${e.message}',
          serviceName: serviceName,
          originalException: e,
        );
    }
  }
}