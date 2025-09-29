import 'package:dio/dio.dart';
import '../../core/config/environment.dart';
import '../../core/errors/app_exceptions.dart';
import '../../domain/entities/user_profile.dart';
import 'dart:convert';
import 'dart:math';

class OpenAIClient {
  static final OpenAIClient _instance = OpenAIClient._internal();
  factory OpenAIClient() => _instance;
  OpenAIClient._internal();

  late final Dio _dio;
  bool _initialized = false;

  void initialize() {
    if (_initialized) return;

    _dio = Dio(BaseOptions(
      baseUrl: 'https://api.openai.com/v1',
      headers: {
        'Authorization': 'Bearer ${EnvironmentConfig.openAIApiKey}',
        'Content-Type': 'application/json',
      },
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 60),
    ));

    _initialized = true;
  }

  Future<Map<String, dynamic>> generateRecipe({
    required List<String> ingredients,
    UserProfile? userProfile,
    String? cuisineType,
    Duration? maxCookingTime,
    int? servings,
    String? mealType,
  }) async {
    if (!_initialized) initialize();

    // Check if we should use mock data or if API key is invalid
    final hasValidKey = await EnvironmentConfig.hasValidOpenAIKey;
    if (!hasValidKey) {
      print('🤖 Using mock recipe generation (API Key valid: $hasValidKey)');
      return _generateMockRecipe(
        ingredients: ingredients,
        cuisineType: cuisineType,
        servings: servings ?? 4,
        mealType: mealType,
      );
    }

    final apiKey = await EnvironmentConfig.openAIApiKey;
    print(
        '🚀 Using real OpenAI API for recipe generation with key: ${apiKey?.substring(0, 10)}...');

    try {
      final prompt = _buildRecipePrompt(
        ingredients: ingredients,
        userProfile: userProfile,
        cuisineType: cuisineType,
        maxCookingTime: maxCookingTime,
        servings: servings,
        mealType: mealType,
      );

      final response = await _dio.post('/chat/completions', data: {
        'model': 'gpt-4',
        'messages': [
          {
            'role': 'system',
            'content':
                'You are a professional chef and recipe creator. Always respond with valid JSON format.'
          },
          {'role': 'user', 'content': prompt}
        ],
        'temperature': 0.7,
        'max_tokens': 2000,
      });

      final content =
          response.data['choices'][0]['message']['content'] as String;

      try {
        return _parseJsonFromContent(content);
      } catch (e) {
        return _parseRecipeFromText(content);
      }
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  String _buildRecipePrompt({
    required List<String> ingredients,
    UserProfile? userProfile,
    String? cuisineType,
    Duration? maxCookingTime,
    int? servings,
    String? mealType,
  }) {
    final buffer = StringBuffer();
    buffer.writeln(
        'Create a detailed recipe using these main ingredients: \${ingredients.join(", ")}');

    if (cuisineType != null) {
      buffer.writeln('Cuisine style: \$cuisineType');
    }

    if (mealType != null) {
      buffer.writeln('Meal type: \$mealType');
    }

    buffer.writeln('Servings: \${servings ?? 4}');

    if (maxCookingTime != null) {
      buffer.writeln(
          'Maximum cooking time: \${maxCookingTime.inMinutes} minutes');
    }

    if (userProfile != null) {
      buffer
          .writeln('User skill level: \${userProfile.skillLevel.displayName}');
      if (userProfile.dietaryRestrictions.isNotEmpty) {
        buffer.writeln(
            'Dietary restrictions: \${userProfile.dietaryRestrictions.map((e) => e.displayName).join(", ")}');
      }
      if (userProfile.allergies.isNotEmpty) {
        buffer.writeln(
            'Allergies to avoid: \${userProfile.allergies.join(", ")}');
      }
    }

    buffer.writeln();
    buffer.writeln('Return ONLY a JSON object with these exact fields:');
    buffer.writeln('{');
    buffer.writeln('  "title": "Recipe title",');
    buffer.writeln('  "description": "Brief description",');
    buffer.writeln(
        '  "ingredients": [{"name": "ingredient", "quantity": 1.0, "unit": "cup"}],');
    buffer.writeln(
        '  "instructions": [{"step": 1, "instruction": "Step description", "duration": 5}],');
    buffer.writeln('  "prepTime": 15,');
    buffer.writeln('  "cookTime": 30,');
    buffer.writeln('  "difficulty": "medium",');
    buffer.writeln(
        '  "nutrition": {"calories": 350, "protein": 20, "carbs": 40, "fat": 15}');
    buffer.writeln('}');

    return buffer.toString();
  }

  Map<String, dynamic> _parseJsonFromContent(String content) {
    String jsonString = content;
    if (content.contains('```json')) {
      jsonString = content.split('```json')[1].split('```')[0].trim();
    } else if (content.contains('```')) {
      jsonString = content.split('```')[1].split('```')[0].trim();
    }

    return Map<String, dynamic>.from(jsonDecode(jsonString));
  }

  Map<String, dynamic> _parseRecipeFromText(String content) {
    return {
      'title': 'Generated Recipe',
      'description': 'Recipe generated from ingredients',
      'ingredients': [],
      'instructions': [],
      'prepTime': 15,
      'cookTime': 30,
      'difficulty': 'medium',
      'nutrition': {
        'calories': 350,
        'protein': 20,
        'carbs': 40,
        'fat': 15,
      }
    };
  }

  Map<String, dynamic> _generateMockRecipe({
    required List<String> ingredients,
    String? cuisineType,
    required int servings,
    String? mealType,
  }) {
    final random = Random();
    final primaryIngredient =
        ingredients.isNotEmpty ? ingredients.first : 'chicken';

    // Generate recipe title based on ingredients and cuisine
    final title =
        _generateRecipeTitle(primaryIngredient, cuisineType, mealType);

    // Generate mock ingredients list
    final mockIngredients = _generateMockIngredients(ingredients, servings);

    // Generate mock instructions
    final mockInstructions = _generateMockInstructions(ingredients);

    // Generate cooking times
    final prepTime = 10 + random.nextInt(20); // 10-30 minutes
    final cookTime = 15 + random.nextInt(45); // 15-60 minutes

    // Generate difficulty
    final difficulties = ['beginner', 'easy', 'medium', 'hard'];
    final difficulty = difficulties[random.nextInt(difficulties.length)];

    // Generate nutrition info
    final baseCalories = 200 + random.nextInt(400); // 200-600 calories
    final nutrition = {
      'calories': baseCalories,
      'protein': 15 + random.nextInt(25), // 15-40g
      'carbs': 20 + random.nextInt(40), // 20-60g
      'fat': 8 + random.nextInt(20), // 8-28g
      'fiber': 2 + random.nextInt(8), // 2-10g
      'sugar': 5 + random.nextInt(15), // 5-20g
      'sodium': 300 + random.nextInt(700), // 300-1000mg
    };

    return {
      'title': title,
      'description': _generateRecipeDescription(title, ingredients),
      'ingredients': mockIngredients,
      'instructions': mockInstructions,
      'prepTime': prepTime,
      'cookTime': cookTime,
      'difficulty': difficulty,
      'servings': servings,
      'nutrition': nutrition,
      'tags': _generateTags(cuisineType, mealType, ingredients),
      'tips': _generateTips(primaryIngredient),
    };
  }

  String _generateRecipeTitle(
      String primaryIngredient, String? cuisineType, String? mealType) {
    final cuisineAdjectives = {
      'italian': ['Italian', 'Tuscan', 'Roman'],
      'mexican': ['Mexican', 'Tex-Mex', 'Spicy'],
      'chinese': ['Chinese', 'Szechuan', 'Cantonese'],
      'indian': ['Indian', 'Curry', 'Spiced'],
      'thai': ['Thai', 'Coconut', 'Spicy Thai'],
      'french': ['French', 'Classic', 'Rustic'],
      'american': ['Classic', 'Homestyle', 'Comfort'],
    };

    final mealPrefixes = {
      'breakfast': ['Morning', 'Breakfast', 'Hearty'],
      'lunch': ['Quick', 'Light', 'Fresh'],
      'dinner': ['Savory', 'Hearty', 'Delicious'],
      'snack': ['Quick', 'Easy', 'Tasty'],
    };

    String prefix = '';
    if (cuisineType != null &&
        cuisineAdjectives.containsKey(cuisineType.toLowerCase())) {
      final adjectives = cuisineAdjectives[cuisineType.toLowerCase()]!;
      prefix = adjectives[Random().nextInt(adjectives.length)];
    } else if (mealType != null &&
        mealPrefixes.containsKey(mealType.toLowerCase())) {
      final prefixes = mealPrefixes[mealType.toLowerCase()]!;
      prefix = prefixes[Random().nextInt(prefixes.length)];
    } else {
      prefix = ['Delicious', 'Tasty', 'Savory', 'Fresh'][Random().nextInt(4)];
    }

    final capitalizedIngredient =
        primaryIngredient[0].toUpperCase() + primaryIngredient.substring(1);
    return '$prefix $capitalizedIngredient ${_getRandomDishType()}';
  }

  String _getRandomDishType() {
    final dishTypes = [
      'Stir-fry',
      'Curry',
      'Soup',
      'Salad',
      'Bowl',
      'Pasta',
      'Rice',
      'Skillet',
      'Casserole',
      'Wrap',
      'Sandwich',
      'Tacos',
      'Pizza',
      'Risotto',
      'Noodles'
    ];
    return dishTypes[Random().nextInt(dishTypes.length)];
  }

  String _generateRecipeDescription(String title, List<String> ingredients) {
    final descriptions = [
      'A delicious and easy-to-make dish perfect for any occasion.',
      'This flavorful recipe combines fresh ingredients for a satisfying meal.',
      'A healthy and nutritious option that\'s quick to prepare.',
      'Comfort food at its finest with a modern twist.',
      'A family-friendly recipe that everyone will love.',
    ];

    final ingredientList = ingredients.take(3).join(', ');
    final baseDescription = descriptions[Random().nextInt(descriptions.length)];

    return '$baseDescription Features $ingredientList and takes just minutes to prepare.';
  }

  List<Map<String, dynamic>> _generateMockIngredients(
      List<String> userIngredients, int servings) {
    final mockIngredients = <Map<String, dynamic>>[];

    // Add user ingredients with quantities
    for (final ingredient in userIngredients) {
      mockIngredients.add({
        'name': ingredient,
        'quantity': _getRandomQuantity(ingredient, servings),
        'unit': _getRandomUnit(ingredient),
        'category': _getIngredientCategory(ingredient),
      });
    }

    // Add some common complementary ingredients
    final commonIngredients = [
      {'name': 'olive oil', 'quantity': 2, 'unit': 'tbsp'},
      {'name': 'salt', 'quantity': 1, 'unit': 'tsp'},
      {'name': 'black pepper', 'quantity': 0.5, 'unit': 'tsp'},
      {'name': 'garlic', 'quantity': 2, 'unit': 'cloves'},
      {'name': 'onion', 'quantity': 1, 'unit': 'medium'},
    ];

    // Add 2-3 random common ingredients
    final random = Random();
    final additionalCount = 2 + random.nextInt(2);
    final shuffled = List.from(commonIngredients)..shuffle();

    for (int i = 0; i < additionalCount && i < shuffled.length; i++) {
      if (!userIngredients.contains(shuffled[i]['name'])) {
        mockIngredients.add({
          'name': shuffled[i]['name'],
          'quantity': shuffled[i]['quantity'],
          'unit': shuffled[i]['unit'],
          'category': _getIngredientCategory(shuffled[i]['name']),
        });
      }
    }

    return mockIngredients;
  }

  double _getRandomQuantity(String ingredient, int servings) {
    final baseQuantities = {
      'chicken': 1.0,
      'beef': 1.0,
      'pork': 1.0,
      'fish': 1.0,
      'rice': 1.0,
      'pasta': 8.0,
      'vegetables': 2.0,
      'cheese': 1.0,
    };

    double baseQty = 1.0;
    for (final key in baseQuantities.keys) {
      if (ingredient.toLowerCase().contains(key)) {
        baseQty = baseQuantities[key]!;
        break;
      }
    }

    return (baseQty * servings / 4).roundToDouble();
  }

  String _getRandomUnit(String ingredient) {
    final units = {
      'meat': ['lb', 'oz', 'pieces'],
      'vegetables': ['cups', 'pieces', 'medium', 'large'],
      'grains': ['cups', 'oz'],
      'liquids': ['cups', 'ml', 'fl oz'],
      'spices': ['tsp', 'tbsp', 'pinch'],
    };

    if (ingredient
        .toLowerCase()
        .contains(RegExp(r'chicken|beef|pork|fish|meat'))) {
      return units['meat']![Random().nextInt(units['meat']!.length)];
    } else if (ingredient
        .toLowerCase()
        .contains(RegExp(r'rice|pasta|flour|oats'))) {
      return units['grains']![Random().nextInt(units['grains']!.length)];
    } else if (ingredient
        .toLowerCase()
        .contains(RegExp(r'oil|milk|water|broth'))) {
      return units['liquids']![Random().nextInt(units['liquids']!.length)];
    } else if (ingredient
        .toLowerCase()
        .contains(RegExp(r'salt|pepper|spice|herb'))) {
      return units['spices']![Random().nextInt(units['spices']!.length)];
    } else {
      return units['vegetables']![
          Random().nextInt(units['vegetables']!.length)];
    }
  }

  String _getIngredientCategory(String ingredient) {
    if (ingredient
        .toLowerCase()
        .contains(RegExp(r'chicken|beef|pork|fish|meat'))) {
      return 'Protein';
    } else if (ingredient
        .toLowerCase()
        .contains(RegExp(r'rice|pasta|bread|flour'))) {
      return 'Grains';
    } else if (ingredient
        .toLowerCase()
        .contains(RegExp(r'tomato|onion|carrot|pepper|vegetable'))) {
      return 'Vegetables';
    } else if (ingredient
        .toLowerCase()
        .contains(RegExp(r'milk|cheese|yogurt|butter'))) {
      return 'Dairy';
    } else if (ingredient
        .toLowerCase()
        .contains(RegExp(r'salt|pepper|spice|herb|garlic'))) {
      return 'Seasonings';
    } else {
      return 'Other';
    }
  }

  List<Map<String, dynamic>> _generateMockInstructions(
      List<String> ingredients) {
    final instructions = <Map<String, dynamic>>[];

    instructions.add({
      'step': 1,
      'instruction':
          'Prepare all ingredients by washing, chopping, and measuring as needed.',
      'duration': 10,
    });

    instructions.add({
      'step': 2,
      'instruction':
          'Heat oil in a large pan or skillet over medium-high heat.',
      'duration': 2,
    });

    if (ingredients
        .any((i) => i.toLowerCase().contains(RegExp(r'onion|garlic')))) {
      instructions.add({
        'step': 3,
        'instruction':
            'Add onions and garlic to the pan and sauté until fragrant, about 2-3 minutes.',
        'duration': 3,
      });
    }

    if (ingredients.any(
        (i) => i.toLowerCase().contains(RegExp(r'chicken|beef|pork|meat')))) {
      instructions.add({
        'step': instructions.length + 1,
        'instruction':
            'Add the protein to the pan and cook until browned on all sides.',
        'duration': 8,
      });
    }

    instructions.add({
      'step': instructions.length + 1,
      'instruction': 'Add remaining ingredients and stir to combine well.',
      'duration': 2,
    });

    instructions.add({
      'step': instructions.length + 1,
      'instruction':
          'Reduce heat to medium-low and simmer until everything is cooked through.',
      'duration': 15,
    });

    instructions.add({
      'step': instructions.length + 1,
      'instruction':
          'Season with salt and pepper to taste. Serve hot and enjoy!',
      'duration': 1,
    });

    return instructions;
  }

  List<String> _generateTags(
      String? cuisineType, String? mealType, List<String> ingredients) {
    final tags = <String>[];

    if (cuisineType != null) tags.add(cuisineType);
    if (mealType != null) tags.add(mealType);

    // Add tags based on ingredients
    if (ingredients.any((i) => i.toLowerCase().contains('chicken')))
      tags.add('chicken');
    if (ingredients.any((i) => i.toLowerCase().contains('vegetable')))
      tags.add('healthy');
    if (ingredients.any((i) => i.toLowerCase().contains('rice')))
      tags.add('rice');

    // Add general tags
    tags.addAll(['easy', 'homemade', 'family-friendly']);

    return tags.take(5).toList();
  }

  List<String> _generateTips(String primaryIngredient) {
    final generalTips = [
      'Make sure to taste and adjust seasoning before serving.',
      'This recipe can be prepared ahead of time and reheated.',
      'Feel free to substitute ingredients based on your preferences.',
      'Leftovers can be stored in the refrigerator for up to 3 days.',
    ];

    final specificTips = {
      'chicken':
          'Make sure chicken is cooked to an internal temperature of 165°F.',
      'rice': 'Rinse rice before cooking for better texture.',
      'pasta': 'Cook pasta al dente for the best texture.',
      'vegetables':
          'Don\'t overcook vegetables to maintain their nutrients and crunch.',
    };

    final tips = <String>[];

    // Add specific tip if available
    for (final key in specificTips.keys) {
      if (primaryIngredient.toLowerCase().contains(key)) {
        tips.add(specificTips[key]!);
        break;
      }
    }

    // Add 1-2 general tips
    final shuffledGeneral = List<String>.from(generalTips)..shuffle();
    tips.addAll(shuffledGeneral.take(2));

    return tips;
  }

  AppException _handleDioException(DioException e) {
    switch (e.response?.statusCode) {
      case 400:
        return const ValidationException('Invalid request to OpenAI API');
      case 401:
        return const AuthenticationException('Invalid OpenAI API key');
      case 429:
        return const RateLimitException('OpenAI API rate limit exceeded');
      case 500:
        return const ServerException('OpenAI server error');
      default:
        return const NetworkException('Network error: \${e.message}');
    }
  }
}
