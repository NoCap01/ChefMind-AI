import 'dart:convert';
import 'dart:math';
import 'package:dio/dio.dart';
import '../core/config/environment.dart';

class RecipeGenerationService {
  static final RecipeGenerationService _instance = RecipeGenerationService._internal();
  factory RecipeGenerationService() => _instance;
  RecipeGenerationService._internal();

  late final Dio _dio;
  bool _initialized = false;

  void _initialize() {
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
    String? cuisineType,
    String? mealType,
    int servings = 4,
  }) async {
    if (!_initialized) _initialize();

    // Check if we have a valid API key
    if (!(await EnvironmentConfig.hasValidOpenAIKey)) {
      print('🤖 Using mock recipe generation - no valid API key');
      return _generateMockRecipe(ingredients, cuisineType, mealType, servings);
    }

    try {
      print('🚀 Generating recipe with OpenAI API...');
      
      final prompt = _buildPrompt(ingredients, cuisineType, mealType, servings);
      
      final response = await _dio.post('/chat/completions', data: {
        'model': 'gpt-3.5-turbo',
        'messages': [
          {
            'role': 'system',
            'content': 'You are a professional chef. Create recipes in JSON format only. Always respond with valid JSON.'
          },
          {
            'role': 'user',
            'content': prompt
          }
        ],
        'temperature': 0.7,
        'max_tokens': 1500,
      });

      final content = response.data['choices'][0]['message']['content'] as String;
      print('✅ OpenAI Response received');
      
      return _parseOpenAIResponse(content, ingredients);
      
    } catch (e) {
      print('❌ OpenAI API Error: $e');
      print('🤖 Falling back to mock recipe generation');
      return _generateMockRecipe(ingredients, cuisineType, mealType, servings);
    }
  }

  String _buildPrompt(List<String> ingredients, String? cuisineType, String? mealType, int servings) {
    final buffer = StringBuffer();
    buffer.writeln('Create a recipe using these ingredients: ${ingredients.join(", ")}');
    
    if (cuisineType != null) buffer.writeln('Cuisine: $cuisineType');
    if (mealType != null) buffer.writeln('Meal type: $mealType');
    buffer.writeln('Servings: $servings');
    
    buffer.writeln('\nRespond with ONLY a JSON object in this exact format:');
    buffer.writeln('{');
    buffer.writeln('  "title": "Recipe Name",');
    buffer.writeln('  "description": "Brief description",');
    buffer.writeln('  "cookTime": 30,');
    buffer.writeln('  "prepTime": 15,');
    buffer.writeln('  "servings": $servings,');
    buffer.writeln('  "difficulty": "Easy",');
    buffer.writeln('  "ingredients": [');
    buffer.writeln('    {"name": "ingredient", "quantity": "1", "unit": "cup"}');
    buffer.writeln('  ],');
    buffer.writeln('  "instructions": [');
    buffer.writeln('    "Step 1 instruction",');
    buffer.writeln('    "Step 2 instruction"');
    buffer.writeln('  ]');
    buffer.writeln('}');
    
    return buffer.toString();
  }

  Map<String, dynamic> _parseOpenAIResponse(String content, List<String> originalIngredients) {
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
      
      if (startIndex != -1 && lastIndex != -1) {
        jsonString = jsonString.substring(startIndex, lastIndex + 1);
      }
      
      final parsed = jsonDecode(jsonString) as Map<String, dynamic>;
      
      // Validate and fix the parsed data
      return {
        'title': parsed['title'] ?? _generateTitle(originalIngredients),
        'description': parsed['description'] ?? 'A delicious recipe made with ${originalIngredients.take(3).join(", ")}',
        'cookTime': _parseTime(parsed['cookTime']) ?? 30,
        'prepTime': _parseTime(parsed['prepTime']) ?? 15,
        'servings': parsed['servings'] ?? 4,
        'difficulty': parsed['difficulty'] ?? 'Medium',
        'ingredients': _parseIngredients(parsed['ingredients'], originalIngredients),
        'instructions': _parseInstructions(parsed['instructions']),
      };
      
    } catch (e) {
      print('❌ Failed to parse OpenAI response: $e');
      return _generateMockRecipe(originalIngredients, null, null, 4);
    }
  }

  int? _parseTime(dynamic time) {
    if (time is int) return time;
    if (time is String) {
      final match = RegExp(r'\d+').firstMatch(time);
      return match != null ? int.tryParse(match.group(0)!) : null;
    }
    return null;
  }

  List<Map<String, dynamic>> _parseIngredients(dynamic ingredients, List<String> originalIngredients) {
    if (ingredients is List) {
      return ingredients.map((item) {
        if (item is Map<String, dynamic>) {
          return {
            'name': item['name'] ?? 'Unknown ingredient',
            'quantity': item['quantity']?.toString() ?? '1',
            'unit': item['unit'] ?? 'piece',
          };
        } else if (item is String) {
          return {
            'name': item,
            'quantity': '1',
            'unit': 'piece',
          };
        }
        return {
          'name': 'Unknown ingredient',
          'quantity': '1',
          'unit': 'piece',
        };
      }).toList();
    }
    
    // Fallback: use original ingredients
    return originalIngredients.map((ingredient) => {
      'name': ingredient,
      'quantity': '1',
      'unit': 'cup',
    }).toList();
  }

  List<String> _parseInstructions(dynamic instructions) {
    if (instructions is List) {
      return instructions.map((item) => item.toString()).toList();
    }
    
    // Fallback instructions
    return [
      'Prepare all ingredients.',
      'Follow standard cooking procedures.',
      'Cook until done.',
      'Serve and enjoy!'
    ];
  }

  Map<String, dynamic> _generateMockRecipe(List<String> ingredients, String? cuisineType, String? mealType, int servings) {
    final random = Random();
    final primaryIngredient = ingredients.isNotEmpty ? ingredients.first : 'chicken';
    
    return {
      'title': _generateTitle(ingredients, cuisineType, mealType),
      'description': _generateDescription(ingredients),
      'cookTime': 20 + random.nextInt(40), // 20-60 minutes
      'prepTime': 10 + random.nextInt(20), // 10-30 minutes
      'servings': servings,
      'difficulty': _generateDifficulty(ingredients.length),
      'ingredients': _generateMockIngredients(ingredients, servings),
      'instructions': _generateMockInstructions(ingredients),
    };
  }

  String _generateTitle(List<String> ingredients, [String? cuisineType, String? mealType]) {
    final primaryIngredient = ingredients.isNotEmpty ? ingredients.first : 'Special';
    final adjectives = ['Delicious', 'Savory', 'Fresh', 'Hearty', 'Tasty', 'Amazing'];
    final dishTypes = ['Bowl', 'Stir-fry', 'Curry', 'Pasta', 'Salad', 'Soup', 'Casserole'];
    
    final adjective = adjectives[Random().nextInt(adjectives.length)];
    final dishType = dishTypes[Random().nextInt(dishTypes.length)];
    
    String prefix = '';
    if (cuisineType != null) {
      prefix = '$cuisineType ';
    } else if (mealType != null) {
      prefix = '$mealType ';
    }
    
    return '$prefix$adjective ${primaryIngredient.split(' ').map((word) => word[0].toUpperCase() + word.substring(1)).join(' ')} $dishType';
  }

  String _generateDescription(List<String> ingredients) {
    final descriptions = [
      'A delicious and nutritious meal perfect for any occasion.',
      'This flavorful dish combines fresh ingredients for a satisfying experience.',
      'A healthy and easy-to-make recipe that everyone will love.',
      'Comfort food at its finest with a modern twist.',
      'A family-friendly recipe packed with flavor.',
    ];
    
    final baseDescription = descriptions[Random().nextInt(descriptions.length)];
    final ingredientList = ingredients.take(3).join(', ');
    
    return '$baseDescription Features $ingredientList and takes just minutes to prepare.';
  }

  String _generateDifficulty(int ingredientCount) {
    if (ingredientCount <= 3) return 'Easy';
    if (ingredientCount <= 6) return 'Medium';
    return 'Hard';
  }

  List<Map<String, dynamic>> _generateMockIngredients(List<String> userIngredients, int servings) {
    final result = <Map<String, dynamic>>[];
    
    // Add user ingredients
    for (final ingredient in userIngredients) {
      result.add({
        'name': ingredient,
        'quantity': _getQuantityForIngredient(ingredient, servings),
        'unit': _getUnitForIngredient(ingredient),
      });
    }
    
    // Add common ingredients
    final commonIngredients = [
      {'name': 'olive oil', 'quantity': '2', 'unit': 'tbsp'},
      {'name': 'salt', 'quantity': '1', 'unit': 'tsp'},
      {'name': 'black pepper', 'quantity': '1/2', 'unit': 'tsp'},
      {'name': 'garlic', 'quantity': '2', 'unit': 'cloves'},
    ];
    
    for (final common in commonIngredients.take(2)) {
      if (!userIngredients.any((ingredient) => 
          ingredient.toLowerCase().contains(common['name']!.toLowerCase()))) {
        result.add(common);
      }
    }
    
    return result;
  }

  String _getQuantityForIngredient(String ingredient, int servings) {
    final baseQuantities = {
      'chicken': '1',
      'beef': '1',
      'rice': '1',
      'pasta': '8',
      'onion': '1',
      'tomato': '2',
    };
    
    for (final key in baseQuantities.keys) {
      if (ingredient.toLowerCase().contains(key)) {
        final base = double.tryParse(baseQuantities[key]!) ?? 1.0;
        final adjusted = (base * servings / 4).toStringAsFixed(base % 1 == 0 ? 0 : 1);
        return adjusted;
      }
    }
    
    return (servings / 4).toStringAsFixed(0);
  }

  String _getUnitForIngredient(String ingredient) {
    if (ingredient.toLowerCase().contains(RegExp(r'chicken|beef|pork|fish|meat'))) {
      return 'lb';
    } else if (ingredient.toLowerCase().contains(RegExp(r'rice|pasta|flour'))) {
      return 'cups';
    } else if (ingredient.toLowerCase().contains(RegExp(r'onion|tomato|potato'))) {
      return 'medium';
    } else if (ingredient.toLowerCase().contains(RegExp(r'oil|milk|water'))) {
      return 'cups';
    }
    return 'cups';
  }

  List<String> _generateMockInstructions(List<String> ingredients) {
    final instructions = <String>[];
    
    instructions.add('Prepare all ingredients by washing, chopping, and measuring as needed.');
    instructions.add('Heat oil in a large pan or skillet over medium-high heat.');
    
    if (ingredients.any((i) => i.toLowerCase().contains(RegExp(r'onion|garlic')))) {
      instructions.add('Add onions and garlic to the pan and sauté until fragrant, about 2-3 minutes.');
    }
    
    if (ingredients.any((i) => i.toLowerCase().contains(RegExp(r'chicken|beef|pork|meat')))) {
      instructions.add('Add the protein to the pan and cook until browned on all sides, about 5-8 minutes.');
    }
    
    instructions.add('Add the remaining ingredients and stir to combine well.');
    instructions.add('Reduce heat to medium-low and simmer until everything is cooked through, about 10-15 minutes.');
    instructions.add('Season with salt and pepper to taste.');
    instructions.add('Serve hot and enjoy your delicious meal!');
    
    return instructions;
  }
}