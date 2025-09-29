import '../../domain/entities/recipe.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/enums/difficulty_level.dart';
import '../../infrastructure/services/openai_client.dart';
import '../../core/errors/app_exceptions.dart';

class GenerateRecipeUseCase {
  final OpenAIClient _openAIClient;

  const GenerateRecipeUseCase(this._openAIClient);

  Future<Recipe> execute({
    required List<String> ingredients,
    UserProfile? userProfile,
    String? cuisineType,
    Duration? maxCookingTime,
    int? servings,
    String? mealType,
  }) async {
    if (ingredients.isEmpty) {
      throw const ValidationException('At least one ingredient is required');
    }

    try {
      final response = await _openAIClient.generateRecipe(
        ingredients: ingredients,
        userProfile: userProfile,
        cuisineType: cuisineType,
        maxCookingTime: maxCookingTime,
        servings: servings,
        mealType: mealType,
      );

      return _parseRecipeFromResponse(response, ingredients, servings);
    } catch (e) {
      if (e is AppException) {
        rethrow;
      }
      throw ServerException('Failed to generate recipe: $e');
    }
  }

  Recipe _parseRecipeFromResponse(
    Map<String, dynamic> response,
    List<String> inputIngredients,
    int? servings,
  ) {
    try {
      final id = DateTime.now().millisecondsSinceEpoch.toString();

      return Recipe(
        id: id,
        title: response['title'] ?? 'Generated Recipe',
        description: response['description'] ??
            'AI-generated recipe based on available ingredients',
        ingredients: _parseIngredients(response['ingredients']),
        instructions: _parseInstructions(response['instructions']),
        metadata: RecipeMetadata(
          cookTime: response['cookTime'] ?? 30,
          prepTime: response['prepTime'] ?? 15,
          difficulty: _parseDifficulty(response['difficulty']),
          servings: servings ?? response['servings'] ?? 4,
        ),
        tags: _parseTags(response['tags'], inputIngredients),
        nutrition: _parseNutrition(response['nutrition']),
        createdAt: DateTime.now(),
        source: 'ai_generated',
      );
    } catch (e) {
      throw ValidationException('Failed to parse recipe data: $e');
    }
  }

  List<Ingredient> _parseIngredients(dynamic ingredientsData) {
    if (ingredientsData is! List) return [];

    return ingredientsData.asMap().entries.map<Ingredient>((entry) {
      final index = entry.key;
      final item = entry.value;

      if (item is String) {
        return Ingredient(
          name: item,
          quantity: 1.0,
          unit: 'piece',
        );
      }

      if (item is Map<String, dynamic>) {
        return Ingredient(
          name: item['name'] ?? 'Unknown ingredient',
          quantity: (item['quantity'] as num?)?.toDouble() ?? 1.0,
          unit: item['unit'] ?? 'piece',
          category: _categorizeIngredient(item['name'] ?? ''),
          isOptional: item['optional'] == true,
          notes: item['notes'],
        );
      }

      return Ingredient(
        name: 'Ingredient ${index + 1}',
        quantity: 1.0,
        unit: 'piece',
      );
    }).toList();
  }

  List<CookingStep> _parseInstructions(dynamic instructionsData) {
    if (instructionsData is! List) return [];

    return instructionsData.asMap().entries.map<CookingStep>((entry) {
      final index = entry.key;
      final item = entry.value;

      if (item is String) {
        return CookingStep(
          stepNumber: index + 1,
          instruction: item,
        );
      }

      if (item is Map<String, dynamic>) {
        return CookingStep(
          stepNumber: item['step'] ?? index + 1,
          instruction: item['instruction'] ?? '',
          duration: item['duration'] as int?,
          technique: item['technique']?.toString(),
          tips: item['tips']?.toString(),
        );
      }

      return CookingStep(
        stepNumber: index + 1,
        instruction: item.toString(),
      );
    }).toList();
  }

  DifficultyLevel _parseDifficulty(dynamic difficulty) {
    if (difficulty is! String) return DifficultyLevel.medium;

    switch (difficulty.toLowerCase()) {
      case 'beginner':
      case 'very easy':
        return DifficultyLevel.beginner;
      case 'easy':
        return DifficultyLevel.easy;
      case 'medium':
      case 'moderate':
        return DifficultyLevel.medium;
      case 'hard':
      case 'difficult':
        return DifficultyLevel.hard;
      case 'expert':
      case 'very hard':
        return DifficultyLevel.expert;
      default:
        return DifficultyLevel.medium;
    }
  }

  List<String> _parseTags(dynamic tagsData, List<String> inputIngredients) {
    final tags = <String>[];

    if (tagsData is List) {
      tags.addAll(tagsData.map((tag) => tag.toString()));
    }

    tags.add('ai-generated');

    for (final ingredient in inputIngredients) {
      final lowerIngredient = ingredient.toLowerCase();
      if (lowerIngredient.contains('chicken') ||
          lowerIngredient.contains('beef') ||
          lowerIngredient.contains('pork') ||
          lowerIngredient.contains('fish')) {
        if (!tags.contains('protein')) tags.add('protein');
      }
      if (lowerIngredient.contains('pasta') ||
          lowerIngredient.contains('rice') ||
          lowerIngredient.contains('bread')) {
        if (!tags.contains('carbs')) tags.add('carbs');
      }
      if (lowerIngredient.contains('tomato') ||
          lowerIngredient.contains('onion') ||
          lowerIngredient.contains('carrot')) {
        if (!tags.contains('vegetables')) tags.add('vegetables');
      }
    }

    return tags;
  }

  NutritionInfo _parseNutrition(dynamic nutritionData) {
    if (nutritionData is! Map<String, dynamic>) {
      return const NutritionInfo(
        calories: 350,
        protein: 20,
        carbs: 40,
        fat: 15,
        fiber: 5,
        sugar: 8,
        sodium: 600,
      );
    }

    return NutritionInfo(
      calories: (nutritionData['calories'] as num?)?.toInt() ?? 350,
      protein: (nutritionData['protein'] as num?)?.toDouble() ?? 20,
      carbs: (nutritionData['carbs'] as num?)?.toDouble() ??
          (nutritionData['carbohydrates'] as num?)?.toDouble() ??
          40,
      fat: (nutritionData['fat'] as num?)?.toDouble() ?? 15,
      fiber: (nutritionData['fiber'] as num?)?.toDouble() ?? 5,
      sugar: (nutritionData['sugar'] as num?)?.toDouble() ?? 8,
      sodium: (nutritionData['sodium'] as num?)?.toInt() ?? 600,
    );
  }

  List<String> _parseTips(dynamic tipsData) {
    if (tipsData is! List) return [];
    return tipsData.map((tip) => tip.toString()).toList();
  }

  String _categorizeIngredient(String ingredient) {
    final lowerIngredient = ingredient.toLowerCase();

    if (lowerIngredient.contains('chicken') ||
        lowerIngredient.contains('beef') ||
        lowerIngredient.contains('pork') ||
        lowerIngredient.contains('fish') ||
        lowerIngredient.contains('turkey') ||
        lowerIngredient.contains('lamb')) {
      return 'Meat & Seafood';
    }

    if (lowerIngredient.contains('milk') ||
        lowerIngredient.contains('cheese') ||
        lowerIngredient.contains('yogurt') ||
        lowerIngredient.contains('butter') ||
        lowerIngredient.contains('cream') ||
        lowerIngredient.contains('egg')) {
      return 'Dairy & Eggs';
    }

    if (lowerIngredient.contains('tomato') ||
        lowerIngredient.contains('onion') ||
        lowerIngredient.contains('carrot') ||
        lowerIngredient.contains('pepper') ||
        lowerIngredient.contains('lettuce') ||
        lowerIngredient.contains('spinach')) {
      return 'Vegetables';
    }

    if (lowerIngredient.contains('apple') ||
        lowerIngredient.contains('banana') ||
        lowerIngredient.contains('orange') ||
        lowerIngredient.contains('berry') ||
        lowerIngredient.contains('grape') ||
        lowerIngredient.contains('lemon')) {
      return 'Fruits';
    }

    if (lowerIngredient.contains('flour') ||
        lowerIngredient.contains('sugar') ||
        lowerIngredient.contains('salt') ||
        lowerIngredient.contains('oil') ||
        lowerIngredient.contains('vinegar') ||
        lowerIngredient.contains('spice')) {
      return 'Pantry Staples';
    }

    return 'Other';
  }
}
