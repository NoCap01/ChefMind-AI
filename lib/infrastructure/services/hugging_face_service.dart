import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';

import '../../core/config/environment.dart';
import '../../domain/entities/recipe.dart';
import '../../domain/entities/recipe_request.dart';
import '../../domain/enums/difficulty_level.dart';
import '../../domain/enums/meal_type.dart';
import '../../domain/services/ai_service_manager.dart';

/// Hugging Face AI service for recipe generation
class HuggingFaceService implements AIServiceManager {
  static final HuggingFaceService _instance = HuggingFaceService._internal();
  factory HuggingFaceService() => _instance;
  HuggingFaceService._internal();

  late final Dio _dio;
  bool _initialized = false;

  // Configuration
  static const String _baseUrl = 'https://api-inference.huggingface.co';
  static const String _model =
      'microsoft/DialoGPT-large'; // Can be changed to other models
  static const Duration _requestTimeout = Duration(seconds: 90);
  static const int _maxRetries = 2;

  @override
  String get serviceName => 'HuggingFace';

  @override
  int get priority => 2; // Lower priority than OpenAI

  void _initialize() {
    if (_initialized) return;

    final apiKey = _getHuggingFaceApiKey();

    _dio = Dio(BaseOptions(
      baseUrl: _baseUrl,
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
      requestBody: false,
      responseBody: false,
      logPrint: (obj) =>
          developer.log(obj.toString(), name: 'HuggingFace-HTTP'),
    ));

    _initialized = true;
  }

  String _getHuggingFaceApiKey() {
    // Try to get from environment, fallback to a demo key or empty string
    const key =
        String.fromEnvironment('HUGGING_FACE_API_KEY', defaultValue: '');
    if (key.isNotEmpty) return key;

    // For demo purposes, we'll use the inference API without auth (limited)
    // In production, you should always use a proper API key
    return '';
  }

  @override
  Future<bool> isServiceAvailable() async {
    if (!_initialized) _initialize();

    try {
      // Test with a simple text generation request
      final response = await _dio.post(
        '/models/gpt2',
        data: {
          'inputs': 'Recipe for',
          'parameters': {
            'max_length': 10,
            'temperature': 0.7,
          }
        },
        options: Options(
          receiveTimeout: const Duration(seconds: 10),
        ),
      );

      return response.statusCode == 200;
    } catch (e) {
      developer.log('HuggingFace service availability check failed: $e',
          name: 'HuggingFace');
      return false;
    }
  }

  @override
  Future<Recipe> generateRecipe(RecipeRequest request) async {
    if (!_initialized) _initialize();

    return await _executeWithRetry(() => _generateRecipeInternal(request));
  }

  Future<Recipe> _generateRecipeInternal(RecipeRequest request) async {
    try {
      developer.log('Generating recipe with HuggingFace API',
          name: 'HuggingFace');

      final prompt = _buildPrompt(request);

      // Use a text generation model
      final response = await _dio.post(
        '/models/gpt2',
        data: {
          'inputs': prompt,
          'parameters': {
            'max_length': 500,
            'temperature': 0.8,
            'top_p': 0.9,
            'do_sample': true,
            'return_full_text': false,
          }
        },
      );

      if (response.data is List && (response.data as List).isNotEmpty) {
        final generatedText = response.data[0]['generated_text'] as String;
        developer.log('HuggingFace response received successfully',
            name: 'HuggingFace');

        return _parseHuggingFaceResponse(generatedText, request);
      } else {
        throw AIServiceException(
          'Invalid response format from HuggingFace',
          serviceName: serviceName,
        );
      }
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      developer.log('Unexpected error in HuggingFace service: $e',
          name: 'HuggingFace');
      throw AIServiceException(
        'Unexpected error during recipe generation: $e',
        serviceName: serviceName,
        originalException: e is Exception ? e : Exception(e.toString()),
      );
    }
  }

  String _buildPrompt(RecipeRequest request) {
    final buffer = StringBuffer();

    buffer.writeln('Recipe: ${_generateRecipeTitle(request)}');
    buffer.writeln();
    buffer.writeln('Ingredients:');

    // Add user ingredients
    for (final ingredient in request.ingredients) {
      buffer.writeln('- $ingredient');
    }

    // Add some common ingredients
    buffer.writeln('- salt and pepper to taste');
    buffer.writeln('- olive oil');

    buffer.writeln();
    buffer.writeln('Instructions:');
    buffer.writeln(
        '1. Prepare all ingredients by washing and chopping as needed.');
    buffer.writeln('2.');

    return buffer.toString();
  }

  String _generateRecipeTitle(RecipeRequest request) {
    final primaryIngredient =
        request.ingredients.isNotEmpty ? request.ingredients.first : 'Special';

    final adjectives = ['Delicious', 'Savory', 'Fresh', 'Hearty', 'Tasty'];
    final dishTypes = ['Bowl', 'Stir-fry', 'Curry', 'Pasta', 'Salad', 'Soup'];

    final adjective = adjectives[Random().nextInt(adjectives.length)];
    final dishType = dishTypes[Random().nextInt(dishTypes.length)];

    String prefix = '';
    if (request.cuisineType != null) {
      prefix = '${request.cuisineType} ';
    } else if (request.mealType != null) {
      prefix = '${request.mealType} ';
    }

    final capitalizedIngredient =
        primaryIngredient[0].toUpperCase() + primaryIngredient.substring(1);

    return '$prefix$adjective $capitalizedIngredient $dishType';
  }

  Recipe _parseHuggingFaceResponse(
      String generatedText, RecipeRequest request) {
    try {
      // Since HuggingFace doesn't return structured JSON like OpenAI,
      // we need to parse the generated text and structure it ourselves

      final lines = generatedText
          .split('\n')
          .where((line) => line.trim().isNotEmpty)
          .toList();

      // Extract title (first line or generate one)
      String title =
          lines.isNotEmpty ? lines.first.trim() : _generateRecipeTitle(request);
      if (title.toLowerCase().startsWith('recipe:')) {
        title = title.substring(7).trim();
      }

      // Generate structured recipe from the text
      return Recipe(
        id: const Uuid().v4(),
        title: title,
        description: _generateDescription(request),
        ingredients: _generateIngredientsFromRequest(request),
        instructions: _parseInstructionsFromText(generatedText, request),
        metadata: RecipeMetadata(
          prepTime: _estimatePrepTime(request),
          cookTime: _estimateCookTime(request),
          servings: request.servings,
          difficulty: _estimateDifficulty(request),
          cuisine: request.cuisineType,
          mealType: _parseMealType(request.mealType),
        ),
        nutrition: _generateNutritionInfo(request),
        tags: _generateTags(request),
        createdAt: DateTime.now(),
        source: serviceName.toLowerCase(),
      );
    } catch (e) {
      developer.log('Failed to parse HuggingFace response: $e',
          name: 'HuggingFace');
      throw AIServiceException(
        'Failed to parse recipe from HuggingFace response: $e',
        serviceName: serviceName,
        originalException: e is Exception ? e : Exception(e.toString()),
      );
    }
  }

  String _generateDescription(RecipeRequest request) {
    final descriptions = [
      'A delicious and easy-to-make dish perfect for any occasion.',
      'This flavorful recipe combines fresh ingredients for a satisfying meal.',
      'A healthy and nutritious option that\'s quick to prepare.',
      'Comfort food at its finest with a modern twist.',
      'A family-friendly recipe that everyone will love.',
    ];

    final baseDescription = descriptions[Random().nextInt(descriptions.length)];
    final ingredientList = request.ingredients.take(3).join(', ');

    return '$baseDescription Features $ingredientList and is perfect for ${request.mealType ?? 'any meal'}.';
  }

  List<Ingredient> _generateIngredientsFromRequest(RecipeRequest request) {
    final ingredients = <Ingredient>[];

    // Add user ingredients with estimated quantities
    for (final ingredient in request.ingredients) {
      ingredients.add(Ingredient(
        name: ingredient,
        quantity: _estimateQuantity(ingredient, request.servings),
        unit: _estimateUnit(ingredient),
        category: _categorizeIngredient(ingredient),
      ));
    }

    // Add common ingredients
    ingredients.addAll([
      const Ingredient(
          name: 'olive oil', quantity: 2, unit: 'tbsp', category: 'oils'),
      const Ingredient(
          name: 'salt', quantity: 1, unit: 'tsp', category: 'seasonings'),
      const Ingredient(
          name: 'black pepper',
          quantity: 0.5,
          unit: 'tsp',
          category: 'seasonings'),
    ]);

    return ingredients;
  }

  List<CookingStep> _parseInstructionsFromText(
      String text, RecipeRequest request) {
    final instructions = <CookingStep>[];

    // Try to extract instructions from the generated text
    final lines = text.split('\n');
    int stepNumber = 1;

    for (final line in lines) {
      final trimmed = line.trim();
      if (trimmed.isEmpty) continue;

      // Look for numbered instructions
      final match = RegExp(r'^\d+\.?\s*(.+)').firstMatch(trimmed);
      if (match != null) {
        instructions.add(CookingStep(
          stepNumber: stepNumber++,
          instruction: match.group(1)!.trim(),
          duration: _estimateStepDuration(match.group(1)!),
        ));
      }
    }

    // If no instructions found, generate basic ones
    if (instructions.isEmpty) {
      instructions.addAll(_generateBasicInstructions(request));
    }

    return instructions;
  }

  List<CookingStep> _generateBasicInstructions(RecipeRequest request) {
    return [
      const CookingStep(
        stepNumber: 1,
        instruction:
            'Prepare all ingredients by washing, chopping, and measuring as needed.',
        duration: 10,
      ),
      const CookingStep(
        stepNumber: 2,
        instruction:
            'Heat oil in a large pan or skillet over medium-high heat.',
        duration: 2,
      ),
      CookingStep(
        stepNumber: 3,
        instruction:
            'Add ${request.ingredients.join(', ')} to the pan and cook according to recipe requirements.',
        duration: 15,
      ),
      const CookingStep(
        stepNumber: 4,
        instruction: 'Season with salt and pepper to taste.',
        duration: 1,
      ),
      const CookingStep(
        stepNumber: 5,
        instruction: 'Serve hot and enjoy!',
        duration: 1,
      ),
    ];
  }

  double _estimateQuantity(String ingredient, int servings) {
    final baseQuantities = {
      'chicken': 1.0,
      'beef': 1.0,
      'rice': 1.0,
      'pasta': 8.0,
      'onion': 1.0,
      'tomato': 2.0,
    };

    for (final key in baseQuantities.keys) {
      if (ingredient.toLowerCase().contains(key)) {
        return (baseQuantities[key]! * servings / 4);
      }
    }

    return servings / 4.0;
  }

  String _estimateUnit(String ingredient) {
    if (ingredient
        .toLowerCase()
        .contains(RegExp(r'chicken|beef|pork|fish|meat'))) {
      return 'lb';
    } else if (ingredient.toLowerCase().contains(RegExp(r'rice|pasta|flour'))) {
      return 'cups';
    } else if (ingredient
        .toLowerCase()
        .contains(RegExp(r'onion|tomato|potato'))) {
      return 'medium';
    } else if (ingredient.toLowerCase().contains(RegExp(r'oil|milk|water'))) {
      return 'cups';
    }
    return 'cups';
  }

  String _categorizeIngredient(String ingredient) {
    if (ingredient
        .toLowerCase()
        .contains(RegExp(r'chicken|beef|pork|fish|meat'))) {
      return 'protein';
    } else if (ingredient
        .toLowerCase()
        .contains(RegExp(r'rice|pasta|bread|flour'))) {
      return 'grains';
    } else if (ingredient
        .toLowerCase()
        .contains(RegExp(r'tomato|onion|carrot|pepper'))) {
      return 'vegetables';
    } else if (ingredient
        .toLowerCase()
        .contains(RegExp(r'milk|cheese|yogurt|butter'))) {
      return 'dairy';
    }
    return 'other';
  }

  int _estimatePrepTime(RecipeRequest request) {
    const baseTime = 10;
    final ingredientTime = request.ingredients.length * 2;
    return baseTime + ingredientTime;
  }

  int _estimateCookTime(RecipeRequest request) {
    if (request.maxCookingTime != null) {
      return request.maxCookingTime! - _estimatePrepTime(request);
    }

    // Estimate based on ingredients
    if (request.ingredients.any((i) => i.toLowerCase().contains('meat'))) {
      return 25;
    } else if (request.ingredients
        .any((i) => i.toLowerCase().contains('rice'))) {
      return 20;
    }

    return 15;
  }

  DifficultyLevel _estimateDifficulty(RecipeRequest request) {
    final ingredientCount = request.ingredients.length;

    if (ingredientCount <= 3) return DifficultyLevel.easy;
    if (ingredientCount <= 6) return DifficultyLevel.medium;
    return DifficultyLevel.hard;
  }

  MealType? _parseMealType(String? mealType) {
    if (mealType == null) return null;

    return MealType.values.firstWhere(
      (e) => e.name.toLowerCase() == mealType.toLowerCase(),
      orElse: () => MealType.dinner,
    );
  }

  NutritionInfo _generateNutritionInfo(RecipeRequest request) {
    final random = Random();
    final baseCalories = 200 + random.nextInt(400);

    return NutritionInfo(
      calories: baseCalories,
      protein: 15 + random.nextInt(25).toDouble(),
      carbs: 20 + random.nextInt(40).toDouble(),
      fat: 8 + random.nextInt(20).toDouble(),
      fiber: 2 + random.nextInt(8).toDouble(),
      sugar: 5 + random.nextInt(15).toDouble(),
      sodium: 300 + random.nextInt(700),
    );
  }

  List<String> _generateTags(RecipeRequest request) {
    final tags = <String>[];

    if (request.cuisineType != null)
      tags.add(request.cuisineType!.toLowerCase());
    if (request.mealType != null) tags.add(request.mealType!.toLowerCase());

    // Add tags based on ingredients
    for (final ingredient in request.ingredients.take(3)) {
      tags.add(ingredient.toLowerCase());
    }

    tags.addAll(['easy', 'homemade', 'family-friendly']);

    return tags.take(6).toList();
  }

  int? _estimateStepDuration(String instruction) {
    final lower = instruction.toLowerCase();

    if (lower.contains('prep') ||
        lower.contains('chop') ||
        lower.contains('wash')) {
      return 5;
    } else if (lower.contains('cook') ||
        lower.contains('fry') ||
        lower.contains('sauté')) {
      return 10;
    } else if (lower.contains('simmer') || lower.contains('bake')) {
      return 20;
    } else if (lower.contains('boil')) {
      return 15;
    }

    return null;
  }

  Future<T> _executeWithRetry<T>(Future<T> Function() operation) async {
    int attempt = 0;

    while (attempt < _maxRetries) {
      try {
        return await operation();
      } catch (e) {
        if (attempt == _maxRetries - 1) {
          rethrow;
        }

        developer.log(
          'Error on attempt ${attempt + 1}: $e',
          name: 'HuggingFace',
        );

        attempt++;
        await Future.delayed(Duration(seconds: attempt * 2));
      }
    }

    throw AIServiceException(
      'Max retries exceeded',
      serviceName: serviceName,
    );
  }

  AIServiceException _handleDioException(DioException e) {
    switch (e.response?.statusCode) {
      case 400:
        return AIServiceException(
          'Invalid request to HuggingFace API: ${e.response?.data}',
          serviceName: serviceName,
          originalException: e,
        );
      case 401:
        return AIServiceException(
          'Invalid HuggingFace API key or authentication failed',
          serviceName: serviceName,
          originalException: e,
        );
      case 429:
        return AIServiceException(
          'HuggingFace API rate limit exceeded. Please try again later.',
          serviceName: serviceName,
          originalException: e,
        );
      case 503:
        return AIServiceException(
          'HuggingFace model is loading. Please try again in a few moments.',
          serviceName: serviceName,
          originalException: e,
        );
      default:
        return AIServiceException(
          'HuggingFace API error: ${e.message}',
          serviceName: serviceName,
          originalException: e,
        );
    }
  }
}
