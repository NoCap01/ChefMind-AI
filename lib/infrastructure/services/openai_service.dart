import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:retry/retry.dart';

import '../../core/config/app_config.dart';
import '../../domain/entities/recipe.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/entities/analytics.dart';
import '../../domain/exceptions/app_exceptions.dart';
import '../../domain/services/recipe_generation_service.dart';
import 'openai_prompts.dart';
import 'openai_parsers.dart';

class OpenAIService implements IRecipeGenerationService {
  static OpenAIService? _instance;
  static OpenAIService get instance => _instance ??= OpenAIService._();

  OpenAIService._();

  late final Dio _dio;
  static const String _baseUrl = 'https://api.openai.com/v1';
  static const String _model = 'gpt-4';
  static const int _maxTokens = 2000;
  static const double _temperature = 0.7;

  void initialize({required String apiKey}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 60),
      ),
    );

    // Add interceptors for logging and error handling
    if (AppConfig.isDebug) {
      _dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          logPrint: (obj) => print(obj),
        ),
      );
    }

    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) {
          final appException = _handleDioError(error);
          handler.reject(
            DioException(
              requestOptions: error.requestOptions,
              error: appException,
            ),
          );
        },
      ),
    );
  }

  @override
  Future<Recipe> generateRecipe(
    List<String> ingredients,
    UserPreferences preferences, {
    String? cuisineType,
    Duration? maxCookingTime,
    DifficultyLevel? maxDifficulty,
    int servings = 4,
    List<String>? excludeIngredients,
  }) async {
    try {
      final prompt = OpenAIPrompts.buildRecipeGenerationPrompt(
        ingredients: ingredients,
        preferences: preferences,
        cuisineType: cuisineType,
        maxCookingTime: maxCookingTime,
        maxDifficulty: maxDifficulty,
        servings: servings,
        excludeIngredients: excludeIngredients,
      );

      final response = await _makeOpenAIRequest(prompt);
      return OpenAIParsers.parseRecipeResponse(response);
    } catch (e) {
      if (e is AppException) rethrow;
      throw RecipeGenerationException('Failed to generate recipe: $e');
    }
  }

  @override
  Future<Recipe> modifyRecipe(
    Recipe recipe,
    ModificationRequest request,
  ) async {
    try {
      final prompt = OpenAIPrompts.buildRecipeModificationPrompt(
        recipe,
        request,
      );
      final response = await _makeOpenAIRequest(prompt);
      return OpenAIParsers.parseRecipeResponse(response);
    } catch (e) {
      if (e is AppException) rethrow;
      throw RecipeGenerationException('Failed to modify recipe: $e');
    }
  }

  @override
  Future<Recipe> adaptRecipeForDiet(
    Recipe recipe,
    List<DietaryRestriction> restrictions,
  ) async {
    try {
      final prompt = OpenAIPrompts.buildDietaryAdaptationPrompt(
        recipe,
        restrictions,
      );
      final response = await _makeOpenAIRequest(prompt);
      return OpenAIParsers.parseRecipeResponse(response);
    } catch (e) {
      if (e is AppException) rethrow;
      throw RecipeGenerationException('Failed to adapt recipe for diet: $e');
    }
  }

  @override
  Future<Recipe> scaleRecipe(Recipe recipe, int newServings) async {
    try {
      final prompt = OpenAIPrompts.buildRecipeScalingPrompt(
        recipe,
        newServings,
      );
      final response = await _makeOpenAIRequest(prompt);
      return OpenAIParsers.parseRecipeResponse(response);
    } catch (e) {
      if (e is AppException) rethrow;
      throw RecipeGenerationException('Failed to scale recipe: $e');
    }
  }

  @override
  Future<Recipe> substituteIngredients(
    Recipe recipe,
    Map<String, String> substitutions,
  ) async {
    try {
      final prompt = _buildIngredientSubstitutionPrompt(recipe, substitutions);
      final response = await _makeOpenAIRequest(prompt);
      return OpenAIParsers.parseRecipeResponse(response);
    } catch (e) {
      if (e is AppException) rethrow;
      throw RecipeGenerationException('Failed to substitute ingredients: $e');
    }
  }

  @override
  Future<List<Recipe>> generateMealPlan(
    MealPlanGenerationRequest request,
  ) async {
    try {
      final prompt = OpenAIPrompts.buildMealPlanPrompt(request);
      final response = await _makeOpenAIRequest(prompt);
      return OpenAIParsers.parseMealPlanResponse(response);
    } catch (e) {
      if (e is AppException) rethrow;
      throw RecipeGenerationException('Failed to generate meal plan: $e');
    }
  }

  @override
  Future<Recipe> generateRecipeForMealType(
    MealType mealType,
    UserPreferences preferences,
    NutritionGoals? nutritionGoals,
  ) async {
    try {
      final prompt = _buildMealTypePrompt(
        mealType,
        preferences,
        nutritionGoals,
      );
      final response = await _makeOpenAIRequest(prompt);
      return OpenAIParsers.parseRecipeResponse(response);
    } catch (e) {
      if (e is AppException) rethrow;
      throw RecipeGenerationException(
        'Failed to generate recipe for meal type: $e',
      );
    }
  }

  @override
  Future<List<Recipe>> suggestRecipesForIngredients(
    List<String> availableIngredients,
    UserPreferences preferences, {
    int maxRecipes = 10,
  }) async {
    try {
      final prompt = _buildIngredientSuggestionPrompt(
        availableIngredients,
        preferences,
        maxRecipes,
      );
      final response = await _makeOpenAIRequest(prompt);
      return OpenAIParsers.parseMultipleRecipesResponse(response);
    } catch (e) {
      if (e is AppException) rethrow;
      throw RecipeGenerationException('Failed to suggest recipes: $e');
    }
  }

  @override
  Future<List<String>> suggestIngredientSubstitutions(
    String ingredient,
    String recipeContext,
    List<DietaryRestriction> restrictions,
  ) async {
    try {
      final prompt = _buildSubstitutionSuggestionPrompt(
        ingredient,
        recipeContext,
        restrictions,
      );
      final response = await _makeOpenAIRequest(prompt);
      return OpenAIParsers.parseSubstitutionResponse(response);
    } catch (e) {
      if (e is AppException) rethrow;
      throw RecipeGenerationException('Failed to suggest substitutions: $e');
    }
  }

  @override
  Future<Recipe> optimizeRecipeForTime(Recipe recipe) async {
    final request = ModificationRequest(
      type: ModificationType.reduceCookingTime,
      parameters: {'targetReduction': 0.3}, // Reduce by 30%
      reason: 'Optimize for faster cooking',
    );
    return modifyRecipe(recipe, request);
  }

  @override
  Future<Recipe> optimizeRecipeForCost(Recipe recipe) async {
    try {
      final prompt = _buildCostOptimizationPrompt(recipe);
      final response = await _makeOpenAIRequest(prompt);
      return OpenAIParsers.parseRecipeResponse(response);
    } catch (e) {
      if (e is AppException) rethrow;
      throw RecipeGenerationException('Failed to optimize recipe for cost: $e');
    }
  }

  @override
  Future<Recipe> optimizeRecipeForNutrition(
    Recipe recipe,
    NutritionGoals goals,
  ) async {
    try {
      final prompt = _buildNutritionOptimizationPrompt(recipe, goals);
      final response = await _makeOpenAIRequest(prompt);
      return OpenAIParsers.parseRecipeResponse(response);
    } catch (e) {
      if (e is AppException) rethrow;
      throw RecipeGenerationException(
        'Failed to optimize recipe for nutrition: $e',
      );
    }
  }

  @override
  Future<Recipe> simplifyRecipe(
    Recipe recipe,
    SkillLevel targetSkillLevel,
  ) async {
    final request = ModificationRequest(
      type: ModificationType.simplifyInstructions,
      parameters: {'targetSkillLevel': targetSkillLevel.name},
      reason: 'Simplify for ${targetSkillLevel.displayName} level',
    );
    return modifyRecipe(recipe, request);
  }

  @override
  Future<List<String>> generateRecipeTips(Recipe recipe) async {
    try {
      final prompt = OpenAIPrompts.buildRecipeTipsPrompt(recipe);
      final response = await _makeOpenAIRequest(prompt);
      return OpenAIParsers.parseTipsResponse(response);
    } catch (e) {
      if (e is AppException) rethrow;
      throw RecipeGenerationException('Failed to generate recipe tips: $e');
    }
  }

  @override
  Future<List<String>> generateRecipeVariations(Recipe recipe) async {
    try {
      final prompt = _buildVariationsPrompt(recipe);
      final response = await _makeOpenAIRequest(prompt);
      return OpenAIParsers.parseVariationsResponse(response);
    } catch (e) {
      if (e is AppException) rethrow;
      throw RecipeGenerationException(
        'Failed to generate recipe variations: $e',
      );
    }
  }

  @override
  Future<NutritionInfo> calculateNutrition(Recipe recipe) async {
    try {
      final prompt = OpenAIPrompts.buildNutritionCalculationPrompt(recipe);
      final response = await _makeOpenAIRequest(prompt);
      return OpenAIParsers.parseNutritionResponse(response);
    } catch (e) {
      if (e is AppException) rethrow;
      throw RecipeGenerationException('Failed to calculate nutrition: $e');
    }
  }

  @override
  Future<double> estimateRecipeCost(Recipe recipe) async {
    try {
      final prompt = _buildCostEstimationPrompt(recipe);
      final response = await _makeOpenAIRequest(prompt);
      return OpenAIParsers.parseCostResponse(response);
    } catch (e) {
      if (e is AppException) rethrow;
      throw RecipeGenerationException('Failed to estimate recipe cost: $e');
    }
  }

  @override
  Future<String> generateCookingInstructions(
    Recipe recipe,
    List<KitchenEquipment> availableEquipment,
  ) async {
    try {
      final prompt = _buildCookingInstructionsPrompt(
        recipe,
        availableEquipment,
      );
      final response = await _makeOpenAIRequest(prompt);
      return OpenAIParsers.parseInstructionsResponse(response);
    } catch (e) {
      if (e is AppException) rethrow;
      throw RecipeGenerationException(
        'Failed to generate cooking instructions: $e',
      );
    }
  }

  @override
  Future<List<String>> generateTroubleshootingTips(
    Recipe recipe,
    String issue,
  ) async {
    try {
      final prompt = _buildTroubleshootingPrompt(recipe, issue);
      final response = await _makeOpenAIRequest(prompt);
      return OpenAIParsers.parseTipsResponse(response);
    } catch (e) {
      if (e is AppException) rethrow;
      throw RecipeGenerationException(
        'Failed to generate troubleshooting tips: $e',
      );
    }
  }

  @override
  Future<String> explainCookingTechnique(String technique) async {
    try {
      final prompt = _buildTechniqueExplanationPrompt(technique);
      final response = await _makeOpenAIRequest(prompt);
      return OpenAIParsers.parseExplanationResponse(response);
    } catch (e) {
      if (e is AppException) rethrow;
      throw RecipeGenerationException(
        'Failed to explain cooking technique: $e',
      );
    }
  }

  @override
  Future<void> recordRecipePreference(
    String userId,
    String recipeId,
    double rating,
    List<String> feedback,
  ) async {
    // This would typically be stored in a database for future personalization
    if (AppConfig.isDebug) {
      print(
        'Recording preference: User $userId rated recipe $recipeId: $rating',
      );
      print('Feedback: ${feedback.join(", ")}');
    }
  }

  @override
  Future<Recipe> personalizeRecipe(
    Recipe recipe,
    String userId,
    UserAnalytics analytics,
  ) async {
    try {
      final prompt = _buildPersonalizationPrompt(recipe, analytics);
      final response = await _makeOpenAIRequest(prompt);
      return OpenAIParsers.parseRecipeResponse(response);
    } catch (e) {
      if (e is AppException) rethrow;
      throw RecipeGenerationException('Failed to personalize recipe: $e');
    }
  }

  @override
  Future<List<Recipe>> generateMultipleRecipes(
    List<RecipeGenerationRequest> requests,
  ) async {
    try {
      final recipes = <Recipe>[];

      // Process requests in batches to avoid rate limits
      for (var i = 0; i < requests.length; i += 3) {
        final batch = requests.skip(i).take(3).toList();
        final batchResults = await Future.wait(
          batch.map(
            (request) => generateRecipe(
              request.ingredients,
              request.preferences,
              cuisineType: request.cuisineType,
              maxCookingTime: request.maxCookingTime,
              maxDifficulty: request.maxDifficulty,
              servings: request.servings,
            ),
          ),
        );
        recipes.addAll(batchResults);

        // Add delay between batches to respect rate limits
        if (i + 3 < requests.length) {
          await Future.delayed(const Duration(seconds: 1));
        }
      }

      return recipes;
    } catch (e) {
      if (e is AppException) rethrow;
      throw RecipeGenerationException(
        'Failed to generate multiple recipes: $e',
      );
    }
  }

  @override
  Future<RecipeValidationResult> validateRecipe(Recipe recipe) async {
    try {
      final prompt = _buildValidationPrompt(recipe);
      final response = await _makeOpenAIRequest(prompt);
      return OpenAIParsers.parseValidationResponse(response);
    } catch (e) {
      if (e is AppException) rethrow;
      throw RecipeGenerationException('Failed to validate recipe: $e');
    }
  }

  @override
  Future<double> calculateRecipeComplexity(Recipe recipe) async {
    try {
      final prompt = _buildComplexityPrompt(recipe);
      final response = await _makeOpenAIRequest(prompt);
      return OpenAIParsers.parseComplexityResponse(response);
    } catch (e) {
      if (e is AppException) rethrow;
      throw RecipeGenerationException(
        'Failed to calculate recipe complexity: $e',
      );
    }
  }

  @override
  Future<List<String>> identifyPotentialIssues(Recipe recipe) async {
    try {
      final prompt = _buildIssueIdentificationPrompt(recipe);
      final response = await _makeOpenAIRequest(prompt);
      return OpenAIParsers.parseIssuesResponse(response);
    } catch (e) {
      if (e is AppException) rethrow;
      throw RecipeGenerationException(
        'Failed to identify potential issues: $e',
      );
    }
  }

  // Private helper methods for making API requests
  Future<String> _makeOpenAIRequest(String prompt) async {
    return await retry(
      () async {
        final response = await _dio.post(
          '/chat/completions',
          data: {
            'model': _model,
            'messages': [
              {'role': 'system', 'content': _getSystemPrompt()},
              {'role': 'user', 'content': prompt},
            ],
            'max_tokens': _maxTokens,
            'temperature': _temperature,
            'response_format': {'type': 'json_object'},
          },
        );

        final content =
            response.data['choices'][0]['message']['content'] as String;
        return content;
      },
      retryIf: (e) => e is DioException && _shouldRetry(e),
      maxAttempts: 3,
      delayFactor: const Duration(seconds: 2), // Fixed: was 'delay'
    );
  }

  bool _shouldRetry(DioException error) {
    if (error.response?.statusCode == 429) return true; // Rate limit
    if (error.response?.statusCode == 500) return true; // Server error
    if (error.response?.statusCode == 502) return true; // Bad gateway
    if (error.response?.statusCode == 503) return true; // Service unavailable
    if (error.type == DioExceptionType.connectionTimeout) return true;
    if (error.type == DioExceptionType.receiveTimeout) return true;
    return false;
  }

  AppException _handleDioError(DioException error) {
    if (error.response != null) {
      final statusCode = error.response!.statusCode!;
      final message =
          error.response!.data?['error']?['message'] ?? 'Unknown error';

      switch (statusCode) {
        case 401:
          return const AuthenticationException('Invalid OpenAI API key');
        case 429:
          return const RateLimitException();
        case 400:
          return RecipeGenerationException('Invalid request: $message');
        case 500:
        case 502:
        case 503:
          return const ServerException(
            'OpenAI service temporarily unavailable',
          );
        default:
          return RecipeGenerationException('API error ($statusCode): $message');
      }
    } else {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
          return const TimeoutException('Request timed out');
        case DioExceptionType.connectionError:
          return const NetworkException('Connection failed');
        default:
          return RecipeGenerationException('Network error: ${error.message}');
      }
    }
  }

  String _getSystemPrompt() {
    return '''
You are ChefMind AI, an expert culinary assistant that generates detailed, practical recipes. 
You have extensive knowledge of cooking techniques, ingredient combinations, nutritional information, and dietary restrictions.

Always respond with valid JSON in the specified format. Be creative but practical, ensuring recipes are achievable for home cooks.
Consider food safety, proper cooking techniques, and nutritional balance in all recommendations.

For recipe generation, always include:
- Clear, step-by-step instructions
- Accurate ingredient measurements
- Realistic cooking and prep times
- Appropriate difficulty level
- Nutritional information estimates
- Helpful cooking tips
- Possible variations or substitutions

Adapt recipes based on:
- Available ingredients
- Dietary restrictions and allergies
- Cooking skill level
- Time constraints
- Kitchen equipment available
- Nutritional goals
- Cultural preferences
''';
  }

  // Private helper methods (removed duplicates and fixed issues)
  String _buildIngredientSubstitutionPrompt(
    Recipe recipe,
    Map<String, String> substitutions,
  ) {
    final buffer = StringBuffer();
    buffer.writeln('Substitute ingredients in this recipe:');
    buffer.writeln('Recipe: ${recipe.title}');
    buffer.writeln('Substitutions:');
    substitutions.forEach((old, newIngredient) {
      buffer.writeln('- Replace $old with $newIngredient');
    });
    buffer.writeln(
      'Maintain the original flavor profile and cooking method as much as possible.',
    );
    return buffer.toString();
  }

  String _buildMealTypePrompt(
    MealType mealType,
    UserPreferences preferences,
    NutritionGoals? nutritionGoals,
  ) {
    final buffer = StringBuffer();
    buffer.writeln(
      'Generate a ${mealType.name} recipe with these requirements:',
    );
    if (nutritionGoals != null) {
      buffer.writeln(
        'Target calories: ${(nutritionGoals.dailyCalories / 3).round()}',
      );
    }
    buffer.writeln(
      'User preferences: ${preferences.favoriteCuisines.join(", ")}',
    );
    return buffer.toString();
  }

  String _buildIngredientSuggestionPrompt(
    List<String> availableIngredients,
    UserPreferences preferences,
    int maxRecipes,
  ) {
    final buffer = StringBuffer();
    buffer.writeln(
      'Suggest $maxRecipes recipes using these available ingredients:',
    );
    buffer.writeln('Available: ${availableIngredients.join(', ')}');
    buffer.writeln(
      'User preferences: ${preferences.favoriteCuisines.join(', ')}',
    );
    return buffer.toString();
  }

  String _buildSubstitutionSuggestionPrompt(
    String ingredient,
    String recipeContext,
    List<DietaryRestriction> restrictions,
  ) {
    final buffer = StringBuffer();
    buffer.writeln(
      'Suggest substitutions for $ingredient in this context: $recipeContext',
    );
    buffer.writeln(
      'Dietary restrictions: ${restrictions.map((r) => r.displayName).join(', ')}',
    );
    return buffer.toString();
  }

  String _buildCostOptimizationPrompt(Recipe recipe) {
    return 'Optimize this recipe for cost while maintaining flavor: ${recipe.title}';
  }

  String _buildNutritionOptimizationPrompt(
    Recipe recipe,
    NutritionGoals goals,
  ) {
    return 'Optimize this recipe to meet nutrition goals: ${recipe.title}. Target: ${goals.dailyCalories} calories, ${goals.dailyProtein}g protein';
  }

  String _buildVariationsPrompt(Recipe recipe) {
    return 'Generate 3-5 variations of this recipe: ${recipe.title}';
  }

  String _buildCostEstimationPrompt(Recipe recipe) {
    return 'Estimate the cost to make this recipe: ${recipe.title}';
  }

  String _buildCookingInstructionsPrompt(
    Recipe recipe,
    List<KitchenEquipment> availableEquipment,
  ) {
    return 'Generate cooking instructions for ${recipe.title} using available equipment: ${availableEquipment.map((e) => e.name).join(", ")}';
  }

  String _buildTroubleshootingPrompt(Recipe recipe, String issue) {
    return 'Provide troubleshooting tips for this issue with ${recipe.title}: $issue';
  }

  String _buildTechniqueExplanationPrompt(String technique) {
    return 'Explain the cooking technique: $technique';
  }

  String _buildPersonalizationPrompt(Recipe recipe, UserAnalytics analytics) {
    return 'Personalize this recipe based on user analytics: ${recipe.title}';
  }

  String _buildValidationPrompt(Recipe recipe) {
    return 'Validate this recipe for accuracy and safety: ${recipe.title}';
  }

  String _buildComplexityPrompt(Recipe recipe) {
    return 'Calculate complexity score (0-1) for this recipe: ${recipe.title}';
  }

  String _buildIssueIdentificationPrompt(Recipe recipe) {
    return 'Identify potential issues with this recipe: ${recipe.title}';
  }
}
