import 'dart:math';
import 'dart:developer' as developer;

import 'package:uuid/uuid.dart';

import '../../domain/entities/recipe.dart';
import '../../domain/entities/recipe_request.dart';
import '../../domain/enums/difficulty_level.dart';
import '../../domain/enums/meal_type.dart';
import '../../domain/enums/dietary_restriction.dart';
import '../../domain/enums/skill_level.dart';
import '../../domain/services/ai_service_manager.dart';
import 'mock_data/cuisine_data.dart';
import 'mock_data/dietary_data.dart';
import 'mock_data/recipe_templates.dart';

/// Enhanced mock service that generates realistic recipe data
class EnhancedMockService implements AIServiceManager {
  static final EnhancedMockService _instance = EnhancedMockService._internal();
  factory EnhancedMockService() => _instance;
  EnhancedMockService._internal();

  @override
  String get serviceName => 'EnhancedMock';

  @override
  int get priority => 99; // Lowest priority (highest number)

  @override
  Future<bool> isServiceAvailable() async {
    // Mock service is always available
    return true;
  }

  @override
  Future<Recipe> generateRecipe(RecipeRequest request) async {
    developer.log('Generating recipe with Enhanced Mock service',
        name: 'EnhancedMock');

    // Simulate realistic API delay
    await Future.delayed(Duration(milliseconds: 800 + Random().nextInt(1500)));

    // Get cuisine and meal type data
    final cuisineProfile = CuisineData.getCuisine(request.cuisineType);
    final mealTemplate = request.mealType != null
        ? RecipeTemplates.getTemplate(_parseMealType(request.mealType)!)
        : null;

    // Generate recipe with comprehensive data
    final recipe =
        _generateComprehensiveRecipe(request, cuisineProfile, mealTemplate);

    developer.log(
        'Generated ${recipe.title} with ${recipe.ingredients.length} ingredients',
        name: 'EnhancedMock');

    return recipe;
  }

  Recipe _generateComprehensiveRecipe(RecipeRequest request,
      CuisineProfile? cuisineProfile, MealTemplate? mealTemplate) {
    final random = Random();
    final primaryIngredient =
        request.ingredients.isNotEmpty ? request.ingredients.first : 'chicken';

    // Generate recipe title with cuisine and meal context
    final title = _generateAdvancedRecipeTitle(
        primaryIngredient, cuisineProfile, mealTemplate, request);

    // Generate ingredients with dietary restrictions and cuisine awareness
    final ingredients =
        _generateDietaryAwareIngredients(request, cuisineProfile);

    // Generate instructions with proper techniques
    final instructions = _generateAdvancedInstructions(
        request, cuisineProfile, mealTemplate, ingredients);

    // Calculate realistic nutrition based on ingredients
    final nutrition = _generateRealisticNutrition(
        ingredients, mealTemplate, request.servings);

    return Recipe(
      id: const Uuid().v4(),
      title: title,
      description:
          _generateContextualDescription(title, request, cuisineProfile),
      ingredients: ingredients,
      instructions: instructions,
      metadata: RecipeMetadata(
        prepTime:
            mealTemplate?.getRandomPrepTime() ?? _generatePrepTime(request),
        cookTime:
            mealTemplate?.getRandomCookTime() ?? _generateCookTime(request),
        servings: request.servings,
        difficulty: _generateSkillBasedDifficulty(request),
        cuisine: request.cuisineType,
        mealType: _parseMealType(request.mealType),
        equipment: _getRequiredEquipment(request, cuisineProfile),
      ),
      nutrition: nutrition,
      tags: _generateComprehensiveTags(request, cuisineProfile),
      createdAt: DateTime.now(),
      source: serviceName.toLowerCase(),
    );
  }

  String _generateRecipeTitle(
      String primaryIngredient, String? cuisineType, String? mealType) {
    final cuisineAdjectives = {
      'italian': ['Italian', 'Tuscan', 'Roman', 'Sicilian'],
      'mexican': ['Mexican', 'Tex-Mex', 'Spicy', 'Authentic'],
      'chinese': ['Chinese', 'Szechuan', 'Cantonese', 'Asian'],
      'indian': ['Indian', 'Curry', 'Spiced', 'Tandoori'],
      'thai': ['Thai', 'Coconut', 'Spicy Thai', 'Bangkok-style'],
      'french': ['French', 'Classic', 'Rustic', 'Provence'],
      'american': ['Classic', 'Homestyle', 'Comfort', 'Southern'],
      'mediterranean': ['Mediterranean', 'Greek', 'Fresh', 'Healthy'],
      'japanese': ['Japanese', 'Teriyaki', 'Miso', 'Tokyo-style'],
    };

    final mealPrefixes = {
      'breakfast': ['Morning', 'Breakfast', 'Hearty', 'Fresh'],
      'brunch': ['Brunch', 'Weekend', 'Leisurely', 'Elegant'],
      'lunch': ['Quick', 'Light', 'Fresh', 'Midday'],
      'dinner': ['Savory', 'Hearty', 'Delicious', 'Evening'],
      'snack': ['Quick', 'Easy', 'Tasty', 'Bite-sized'],
      'dessert': ['Sweet', 'Decadent', 'Rich', 'Indulgent'],
    };

    final dishTypes = [
      'Bowl',
      'Stir-fry',
      'Curry',
      'Pasta',
      'Salad',
      'Soup',
      'Skillet',
      'Casserole',
      'Wrap',
      'Sandwich',
      'Tacos',
      'Pizza',
      'Risotto',
      'Noodles',
      'Gratin',
      'Pilaf',
      'Chowder',
      'Bisque',
      'Ragu',
      'Fricassee'
    ];

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
      prefix = [
        'Delicious',
        'Tasty',
        'Savory',
        'Fresh',
        'Gourmet'
      ][Random().nextInt(5)];
    }

    final capitalizedIngredient =
        primaryIngredient[0].toUpperCase() + primaryIngredient.substring(1);
    final dishType = dishTypes[Random().nextInt(dishTypes.length)];

    return '$prefix $capitalizedIngredient $dishType';
  }

  String _generateRecipeDescription(String title, List<String> ingredients) {
    final descriptions = [
      'A delicious and easy-to-make dish that brings together the best flavors.',
      'This flavorful recipe combines fresh ingredients for a truly satisfying meal.',
      'A healthy and nutritious option that\'s perfect for busy weeknights.',
      'Comfort food at its finest with a modern, health-conscious twist.',
      'A family-friendly recipe that will become a household favorite.',
      'Restaurant-quality flavors made simple for the home kitchen.',
      'A perfectly balanced dish that celebrates seasonal ingredients.',
      'An elegant yet approachable recipe perfect for entertaining.',
    ];

    final ingredientList = ingredients.take(3).join(', ');
    final baseDescription = descriptions[Random().nextInt(descriptions.length)];

    final endings = [
      'Features $ingredientList and takes just minutes to prepare.',
      'The combination of $ingredientList creates an unforgettable taste experience.',
      'With $ingredientList as the stars, this dish is both nutritious and delicious.',
      'Using $ingredientList, this recipe delivers maximum flavor with minimal effort.',
    ];

    final ending = endings[Random().nextInt(endings.length)];

    return '$baseDescription $ending';
  }

  List<Ingredient> _generateMockIngredients(RecipeRequest request) {
    final ingredients = <Ingredient>[];

    // Add user ingredients with realistic quantities
    for (final ingredient in request.ingredients) {
      ingredients.add(Ingredient(
        name: ingredient,
        quantity: _getRealisticQuantity(ingredient, request.servings),
        unit: _getRealisticUnit(ingredient),
        category: _categorizeIngredient(ingredient),
      ));
    }

    // Add complementary ingredients based on cuisine and meal type
    ingredients.addAll(_getComplementaryIngredients(request));

    return ingredients;
  }

  double _getRealisticQuantity(String ingredient, int servings) {
    final baseQuantities = {
      // Proteins
      'chicken': 1.5, 'beef': 1.0, 'pork': 1.0, 'fish': 1.25, 'salmon': 1.5,
      'shrimp': 1.0, 'tofu': 1.0, 'eggs': 4.0,

      // Grains & Starches
      'rice': 1.0, 'pasta': 0.75, 'quinoa': 0.75, 'bread': 4.0, 'potatoes': 2.0,

      // Vegetables
      'onion': 1.0, 'garlic': 3.0, 'tomatoes': 2.0, 'bell pepper': 1.0,
      'carrots': 2.0, 'celery': 2.0, 'mushrooms': 8.0, 'spinach': 4.0,

      // Dairy
      'cheese': 1.0, 'milk': 1.0, 'cream': 0.5, 'butter': 0.25,
    };

    for (final key in baseQuantities.keys) {
      if (ingredient.toLowerCase().contains(key)) {
        return (baseQuantities[key]! * servings / 4);
      }
    }

    return servings / 4.0;
  }

  String _getRealisticUnit(String ingredient) {
    final units = {
      // Proteins
      'chicken': 'lbs', 'beef': 'lbs', 'pork': 'lbs', 'fish': 'lbs',
      'shrimp': 'lbs', 'tofu': 'blocks', 'eggs': 'large',

      // Grains
      'rice': 'cups', 'pasta': 'lbs', 'quinoa': 'cups', 'bread': 'slices',

      // Vegetables
      'onion': 'large', 'garlic': 'cloves', 'tomatoes': 'medium',
      'bell pepper': 'large', 'carrots': 'medium', 'celery': 'stalks',
      'mushrooms': 'oz', 'spinach': 'cups', 'potatoes': 'medium',

      // Dairy & Liquids
      'cheese': 'cups', 'milk': 'cups', 'cream': 'cups', 'butter': 'sticks',
      'oil': 'tbsp', 'vinegar': 'tbsp',

      // Seasonings
      'salt': 'tsp', 'pepper': 'tsp', 'herbs': 'tsp', 'spices': 'tsp',
    };

    for (final key in units.keys) {
      if (ingredient.toLowerCase().contains(key)) {
        return units[key]!;
      }
    }

    return 'cups';
  }

  String _categorizeIngredient(String ingredient) {
    final categories = {
      'protein': [
        'chicken',
        'beef',
        'pork',
        'fish',
        'salmon',
        'shrimp',
        'tofu',
        'eggs'
      ],
      'grains': ['rice', 'pasta', 'quinoa', 'bread', 'flour', 'oats'],
      'vegetables': [
        'onion',
        'garlic',
        'tomato',
        'pepper',
        'carrot',
        'celery',
        'spinach',
        'mushroom'
      ],
      'dairy': ['cheese', 'milk', 'cream', 'butter', 'yogurt'],
      'seasonings': ['salt', 'pepper', 'herbs', 'spices', 'basil', 'oregano'],
      'oils': ['oil', 'olive oil', 'butter'],
    };

    for (final category in categories.keys) {
      if (categories[category]!
          .any((item) => ingredient.toLowerCase().contains(item))) {
        return category;
      }
    }

    return 'other';
  }

  List<Ingredient> _getComplementaryIngredients(RecipeRequest request) {
    final complementary = <Ingredient>[];

    // Always add basic seasonings
    complementary.addAll([
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

    // Add cuisine-specific ingredients
    if (request.cuisineType != null) {
      complementary
          .addAll(_getCuisineSpecificIngredients(request.cuisineType!));
    }

    // Add aromatics if not already present
    if (!request.ingredients.any((i) => i.toLowerCase().contains('onion'))) {
      complementary.add(const Ingredient(
          name: 'yellow onion',
          quantity: 1,
          unit: 'medium',
          category: 'vegetables'));
    }

    if (!request.ingredients.any((i) => i.toLowerCase().contains('garlic'))) {
      complementary.add(const Ingredient(
          name: 'garlic', quantity: 3, unit: 'cloves', category: 'vegetables'));
    }

    return complementary.take(6).toList();
  }

  List<Ingredient> _getCuisineSpecificIngredients(String cuisine) {
    final cuisineIngredients = {
      'italian': [
        const Ingredient(
            name: 'fresh basil',
            quantity: 0.25,
            unit: 'cup',
            category: 'seasonings'),
        const Ingredient(
            name: 'parmesan cheese',
            quantity: 0.5,
            unit: 'cup',
            category: 'dairy'),
      ],
      'mexican': [
        const Ingredient(
            name: 'cumin', quantity: 1, unit: 'tsp', category: 'seasonings'),
        const Ingredient(
            name: 'lime', quantity: 1, unit: 'medium', category: 'vegetables'),
      ],
      'asian': [
        const Ingredient(
            name: 'soy sauce',
            quantity: 2,
            unit: 'tbsp',
            category: 'seasonings'),
        const Ingredient(
            name: 'ginger', quantity: 1, unit: 'tbsp', category: 'seasonings'),
      ],
      'indian': [
        const Ingredient(
            name: 'garam masala',
            quantity: 1,
            unit: 'tsp',
            category: 'seasonings'),
        const Ingredient(
            name: 'turmeric',
            quantity: 0.5,
            unit: 'tsp',
            category: 'seasonings'),
      ],
    };

    return cuisineIngredients[cuisine.toLowerCase()] ?? [];
  }

  List<CookingStep> _generateMockInstructions(RecipeRequest request) {
    final instructions = <CookingStep>[];
    int stepNumber = 1;

    // Prep step
    instructions.add(CookingStep(
      stepNumber: stepNumber++,
      instruction:
          'Prepare all ingredients by washing, chopping, and measuring as needed. ${_getSpecificPrepInstructions(request)}',
      duration: _generatePrepTime(request),
    ));

    // Cooking steps based on ingredients and cuisine
    instructions.addAll(_generateCookingSteps(request, stepNumber));

    return instructions;
  }

  String _getSpecificPrepInstructions(RecipeRequest request) {
    final instructions = <String>[];

    if (request.ingredients.any((i) => i.toLowerCase().contains('onion'))) {
      instructions.add('Dice the onions finely.');
    }
    if (request.ingredients.any((i) => i.toLowerCase().contains('garlic'))) {
      instructions.add('Mince the garlic.');
    }
    if (request.ingredients.any((i) => i.toLowerCase().contains('tomato'))) {
      instructions.add('Chop the tomatoes into bite-sized pieces.');
    }

    return instructions.join(' ');
  }

  List<CookingStep> _generateCookingSteps(
      RecipeRequest request, int startingStep) {
    final steps = <CookingStep>[];
    int stepNumber = startingStep;

    // Heat oil/pan
    steps.add(CookingStep(
      stepNumber: stepNumber++,
      instruction:
          'Heat olive oil in a large ${_getRecommendedCookware(request)} over medium-high heat.',
      duration: 2,
    ));

    // Aromatics
    if (request.ingredients.any(
        (i) => ['onion', 'garlic'].any((a) => i.toLowerCase().contains(a)))) {
      steps.add(CookingStep(
        stepNumber: stepNumber++,
        instruction:
            'Add onions and garlic to the pan. Sauté until fragrant and translucent, about 3-4 minutes.',
        duration: 4,
      ));
    }

    // Main protein
    if (request.ingredients.any((i) => ['chicken', 'beef', 'pork', 'fish']
        .any((p) => i.toLowerCase().contains(p)))) {
      steps.add(CookingStep(
        stepNumber: stepNumber++,
        instruction:
            'Add the protein to the pan and cook until browned on all sides and cooked through.',
        duration: _getProteinCookingTime(request),
      ));
    }

    // Vegetables
    if (request.ingredients.any((i) => [
          'tomato',
          'pepper',
          'carrot',
          'mushroom'
        ].any((v) => i.toLowerCase().contains(v)))) {
      steps.add(CookingStep(
        stepNumber: stepNumber++,
        instruction:
            'Add the vegetables and cook until tender, stirring occasionally.',
        duration: 8,
      ));
    }

    // Seasonings and final cooking
    steps.add(CookingStep(
      stepNumber: stepNumber++,
      instruction:
          'Season with salt, pepper, and any additional spices. ${_getFinalCookingInstruction(request)}',
      duration: _getFinalCookingTime(request),
    ));

    // Serving
    steps.add(CookingStep(
      stepNumber: stepNumber++,
      instruction:
          'Remove from heat and let rest for 2-3 minutes. Serve hot and enjoy!',
      duration: 3,
    ));

    return steps;
  }

  String _getRecommendedCookware(RecipeRequest request) {
    if (request.mealType?.toLowerCase() == 'soup') return 'pot';
    if (request.cuisineType?.toLowerCase() == 'asian')
      return 'wok or large skillet';
    if (request.ingredients.any((i) => i.toLowerCase().contains('pasta')))
      return 'large pot';
    return 'skillet or saucepan';
  }

  int _getProteinCookingTime(RecipeRequest request) {
    if (request.ingredients.any((i) => i.toLowerCase().contains('chicken')))
      return 12;
    if (request.ingredients.any((i) => i.toLowerCase().contains('beef')))
      return 10;
    if (request.ingredients.any((i) => i.toLowerCase().contains('fish')))
      return 6;
    return 8;
  }

  String _getFinalCookingInstruction(RecipeRequest request) {
    if (request.mealType?.toLowerCase() == 'soup') {
      return 'Add broth and simmer until flavors meld together.';
    } else if (request.cuisineType?.toLowerCase() == 'italian') {
      return 'Toss everything together and finish with fresh herbs.';
    } else if (request.ingredients
        .any((i) => i.toLowerCase().contains('rice'))) {
      return 'Add cooked rice and stir to combine.';
    }
    return 'Stir everything together and cook until heated through.';
  }

  int _getFinalCookingTime(RecipeRequest request) {
    if (request.mealType?.toLowerCase() == 'soup') return 15;
    if (request.ingredients.any((i) => i.toLowerCase().contains('rice')))
      return 5;
    return 3;
  }

  int _generatePrepTime(RecipeRequest request) {
    const baseTime = 10;
    final ingredientTime = request.ingredients.length * 2;
    final complexityTime =
        request.skillLevel == null ? 0 : request.skillLevel!.index * 2;

    return baseTime + ingredientTime + complexityTime;
  }

  int _generateCookTime(RecipeRequest request) {
    if (request.maxCookingTime != null) {
      return max(10, request.maxCookingTime! - _generatePrepTime(request));
    }

    // Estimate based on meal type and ingredients
    if (request.mealType?.toLowerCase() == 'soup') return 25;
    if (request.ingredients.any((i) => i.toLowerCase().contains('beef')))
      return 30;
    if (request.ingredients.any((i) => i.toLowerCase().contains('chicken')))
      return 20;
    if (request.mealType?.toLowerCase() == 'breakfast') return 10;

    return 15;
  }

  DifficultyLevel _generateDifficulty(RecipeRequest request) {
    int complexity = 0;

    // Base on ingredient count
    complexity += request.ingredients.length;

    // Cuisine complexity
    if (request.cuisineType != null) {
      final complexCuisines = ['french', 'indian', 'thai'];
      if (complexCuisines.contains(request.cuisineType!.toLowerCase())) {
        complexity += 3;
      }
    }

    // Skill level
    if (request.skillLevel != null) {
      complexity += request.skillLevel!.index;
    }

    if (complexity <= 5) return DifficultyLevel.easy;
    if (complexity <= 10) return DifficultyLevel.medium;
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

    // Base calories on meal type and ingredients
    int baseCalories = 300;
    if (request.mealType?.toLowerCase() == 'breakfast') baseCalories = 250;
    if (request.mealType?.toLowerCase() == 'snack') baseCalories = 150;
    if (request.mealType?.toLowerCase() == 'dinner') baseCalories = 400;

    // Adjust for protein content
    if (request.ingredients.any((i) =>
        ['chicken', 'beef', 'fish'].any((p) => i.toLowerCase().contains(p)))) {
      baseCalories += 100;
    }

    final calories = baseCalories + random.nextInt(200);

    return NutritionInfo(
      calories: calories,
      protein: (calories * 0.15 / 4)
          .round()
          .toDouble(), // 15% of calories from protein
      carbs: (calories * 0.45 / 4).round().toDouble(), // 45% from carbs
      fat: (calories * 0.30 / 9).round().toDouble(), // 30% from fat
      fiber: 3 + random.nextInt(8).toDouble(),
      sugar: 5 + random.nextInt(15).toDouble(),
      sodium: 400 + random.nextInt(600),
    );
  }

  String _generateAdvancedRecipeTitle(
      String primaryIngredient,
      CuisineProfile? cuisineProfile,
      MealTemplate? mealTemplate,
      RecipeRequest request) {
    final random = Random();

    // Use cuisine-specific dish types if available
    String dishType;
    if (cuisineProfile != null && random.nextBool()) {
      dishType = cuisineProfile
          .dishTypes[random.nextInt(cuisineProfile.dishTypes.length)];
    } else if (mealTemplate != null) {
      dishType = mealTemplate.getRandomDishType();
    } else {
      dishType = ['bowl', 'dish', 'recipe', 'delight'][random.nextInt(4)];
    }

    // Generate descriptive adjectives
    final adjectives = _getContextualAdjectives(cuisineProfile, request);
    final adjective = adjectives[random.nextInt(adjectives.length)];

    final capitalizedIngredient =
        primaryIngredient[0].toUpperCase() + primaryIngredient.substring(1);

    // Create varied title formats
    final titleFormats = [
      '$adjective $capitalizedIngredient $dishType',
      '${cuisineProfile?.name ?? 'Homestyle'} $capitalizedIngredient $dishType',
      '$capitalizedIngredient $dishType with ${_getSecondaryIngredient(request)}',
      '$adjective $dishType with $capitalizedIngredient',
    ];

    return titleFormats[random.nextInt(titleFormats.length)];
  }

  List<String> _getContextualAdjectives(
      CuisineProfile? cuisineProfile, RecipeRequest request) {
    final adjectives = <String>[];

    // Cuisine-specific adjectives
    if (cuisineProfile != null) {
      switch (cuisineProfile.name.toLowerCase()) {
        case 'italian':
          adjectives.addAll(
              ['Rustic', 'Classic', 'Authentic', 'Traditional', 'Hearty']);
          break;
        case 'mexican':
          adjectives.addAll(['Spicy', 'Zesty', 'Vibrant', 'Bold', 'Fiesta']);
          break;
        case 'asian':
          adjectives.addAll(
              ['Savory', 'Umami-Rich', 'Balanced', 'Fresh', 'Aromatic']);
          break;
        case 'indian':
          adjectives
              .addAll(['Spiced', 'Fragrant', 'Rich', 'Exotic', 'Warming']);
          break;
        case 'thai':
          adjectives.addAll(
              ['Sweet & Sour', 'Coconut', 'Lemongrass', 'Spicy', 'Fresh']);
          break;
        case 'french':
          adjectives.addAll(
              ['Elegant', 'Classic', 'Refined', 'Bistro-Style', 'Gourmet']);
          break;
        default:
          adjectives.addAll(['Delicious', 'Flavorful', 'Satisfying']);
      }
    }

    // Dietary restriction adjectives
    for (final restriction in request.dietaryRestrictions) {
      switch (restriction) {
        case DietaryRestriction.vegan:
          adjectives.addAll(['Plant-Based', 'Vegan', 'Wholesome']);
          break;
        case DietaryRestriction.keto:
          adjectives.addAll(['Keto-Friendly', 'Low-Carb', 'High-Fat']);
          break;
        case DietaryRestriction.glutenFree:
          adjectives.addAll(['Gluten-Free', 'Wheat-Free']);
          break;
        case DietaryRestriction.paleo:
          adjectives.addAll(['Paleo', 'Primal', 'Whole30']);
          break;
        default:
          break;
      }
    }

    // Default adjectives
    if (adjectives.isEmpty) {
      adjectives.addAll(
          ['Delicious', 'Tasty', 'Savory', 'Fresh', 'Homemade', 'Comfort']);
    }

    return adjectives;
  }

  String _getSecondaryIngredient(RecipeRequest request) {
    if (request.ingredients.length > 1) {
      return request.ingredients[1].toLowerCase();
    }
    return 'herbs';
  }

  List<Ingredient> _generateDietaryAwareIngredients(
      RecipeRequest request, CuisineProfile? cuisineProfile) {
    final ingredients = <Ingredient>[];

    // Process user ingredients with dietary substitutions
    for (final userIngredient in request.ingredients) {
      if (DietaryData.isIngredientAllowed(
          request.dietaryRestrictions, userIngredient)) {
        ingredients.add(
            _createIngredientWithQuantity(userIngredient, request.servings));
      } else {
        // Find suitable substitutions
        final substitutions = DietaryData.getSubstitutions(
            request.dietaryRestrictions, userIngredient);
        for (final substitution in substitutions.take(1)) {
          ingredients.add(
              _createIngredientWithQuantity(substitution, request.servings));
        }
      }
    }

    // Add cuisine-specific ingredients
    if (cuisineProfile != null) {
      final cuisineIngredients =
          _selectCuisineIngredients(cuisineProfile, request);
      ingredients.addAll(cuisineIngredients);
    }

    // Add dietary-specific ingredients
    final dietaryIngredients = _selectDietaryIngredients(request);
    ingredients.addAll(dietaryIngredients);

    // Add basic seasonings and aromatics
    ingredients.addAll(_getBasicSeasonings(cuisineProfile));

    return ingredients.take(12).toList(); // Limit to reasonable number
  }

  Ingredient _createIngredientWithQuantity(String name, int servings) {
    return Ingredient(
      name: name,
      quantity: _getRealisticQuantity(name, servings),
      unit: _getRealisticUnit(name),
      category: _categorizeIngredient(name),
    );
  }

  List<Ingredient> _selectCuisineIngredients(
      CuisineProfile cuisineProfile, RecipeRequest request) {
    final random = Random();
    final selected = <Ingredient>[];

    // Select 2-4 cuisine-specific ingredients
    final shuffled = List<String>.from(cuisineProfile.commonIngredients)
      ..shuffle(random);

    for (final ingredient in shuffled.take(3)) {
      if (DietaryData.isIngredientAllowed(
          request.dietaryRestrictions, ingredient)) {
        selected
            .add(_createIngredientWithQuantity(ingredient, request.servings));
      }
    }

    return selected;
  }

  List<Ingredient> _selectDietaryIngredients(RecipeRequest request) {
    final ingredients = <Ingredient>[];

    for (final restriction in request.dietaryRestrictions) {
      final profile = DietaryData.getProfile(restriction);
      if (profile != null) {
        // Add a protein source appropriate for the dietary restriction
        final proteins = profile.allowedProteins;
        if (proteins.isNotEmpty &&
            !request.ingredients.any((i) => proteins
                .any((p) => i.toLowerCase().contains(p.toLowerCase())))) {
          final protein = proteins[Random().nextInt(proteins.length)];
          ingredients
              .add(_createIngredientWithQuantity(protein, request.servings));
          break; // Only add one protein
        }
      }
    }

    return ingredients;
  }

  List<Ingredient> _getBasicSeasonings(CuisineProfile? cuisineProfile) {
    final seasonings = <Ingredient>[];

    if (cuisineProfile != null && cuisineProfile.spices.isNotEmpty) {
      // Add 1-2 cuisine-specific spices
      final random = Random();
      final selectedSpices = cuisineProfile.spices.take(2);
      for (final spice in selectedSpices) {
        seasonings.add(Ingredient(
          name: spice,
          quantity: random.nextDouble() * 1.5 + 0.5, // 0.5-2.0
          unit: 'tsp',
          category: 'seasonings',
        ));
      }
    } else {
      // Default seasonings
      seasonings.addAll([
        const Ingredient(
            name: 'salt', quantity: 1, unit: 'tsp', category: 'seasonings'),
        const Ingredient(
            name: 'black pepper',
            quantity: 0.5,
            unit: 'tsp',
            category: 'seasonings'),
      ]);
    }

    return seasonings;
  }

  List<CookingStep> _generateAdvancedInstructions(
      RecipeRequest request,
      CuisineProfile? cuisineProfile,
      MealTemplate? mealTemplate,
      List<Ingredient> ingredients) {
    final instructions = <CookingStep>[];
    int stepNumber = 1;

    // Prep step with specific instructions
    instructions.add(CookingStep(
      stepNumber: stepNumber++,
      instruction: _generatePrepInstructions(ingredients, cuisineProfile),
      duration: _calculatePrepTime(ingredients),
      tips:
          'Having everything prepared before cooking makes the process much smoother.',
    ));

    // Cooking steps based on cuisine and meal type
    instructions.addAll(_generateCuisineSpecificSteps(
        request, cuisineProfile, mealTemplate, ingredients, stepNumber));

    return instructions;
  }

  String _generatePrepInstructions(
      List<Ingredient> ingredients, CuisineProfile? cuisineProfile) {
    final prepTasks = <String>[];

    // Ingredient-specific prep
    for (final ingredient in ingredients) {
      final prep = _getIngredientPrepInstruction(ingredient.name);
      if (prep.isNotEmpty) {
        prepTasks.add(prep);
      }
    }

    // Cuisine-specific prep
    if (cuisineProfile != null) {
      prepTasks.add(_getCuisineSpecificPrep(cuisineProfile));
    }

    final baseInstruction =
        'Prepare all ingredients: ${prepTasks.take(4).join(', ')}.';
    return '$baseInstruction Measure all spices and have them ready.';
  }

  String _getIngredientPrepInstruction(String ingredient) {
    final lowerIngredient = ingredient.toLowerCase();

    if (lowerIngredient.contains('onion')) return 'dice the onions';
    if (lowerIngredient.contains('garlic')) return 'mince the garlic';
    if (lowerIngredient.contains('tomato')) return 'chop the tomatoes';
    if (lowerIngredient.contains('pepper')) return 'slice the peppers';
    if (lowerIngredient.contains('carrot')) return 'slice the carrots';
    if (lowerIngredient.contains('mushroom')) return 'slice the mushrooms';
    if (lowerIngredient.contains('herb')) return 'chop the fresh herbs';

    return '';
  }

  String _getCuisineSpecificPrep(CuisineProfile cuisineProfile) {
    switch (cuisineProfile.name.toLowerCase()) {
      case 'asian':
        return 'prepare aromatics (ginger, garlic, green onions)';
      case 'indian':
        return 'toast and grind whole spices if using';
      case 'mexican':
        return 'char peppers if desired for extra flavor';
      case 'italian':
        return 'grate fresh cheese and prepare herbs';
      default:
        return 'organize ingredients by cooking order';
    }
  }

  int _calculatePrepTime(List<Ingredient> ingredients) {
    // Base time + time per ingredient
    return 5 + (ingredients.length * 2);
  }

  List<CookingStep> _generateCuisineSpecificSteps(
      RecipeRequest request,
      CuisineProfile? cuisineProfile,
      MealTemplate? mealTemplate,
      List<Ingredient> ingredients,
      int startingStep) {
    final steps = <CookingStep>[];
    int stepNumber = startingStep;

    if (cuisineProfile != null) {
      steps.addAll(_getCuisineSteps(cuisineProfile, ingredients, stepNumber));
    } else {
      steps.addAll(_getGenericCookingSteps(ingredients, stepNumber));
    }

    return steps;
  }

  List<CookingStep> _getCuisineSteps(CuisineProfile cuisineProfile,
      List<Ingredient> ingredients, int startingStep) {
    final steps = <CookingStep>[];
    int stepNumber = startingStep;

    switch (cuisineProfile.name.toLowerCase()) {
      case 'asian':
        steps.addAll(_getAsianCookingSteps(ingredients, stepNumber));
        break;
      case 'italian':
        steps.addAll(_getItalianCookingSteps(ingredients, stepNumber));
        break;
      case 'mexican':
        steps.addAll(_getMexicanCookingSteps(ingredients, stepNumber));
        break;
      case 'indian':
        steps.addAll(_getIndianCookingSteps(ingredients, stepNumber));
        break;
      default:
        steps.addAll(_getGenericCookingSteps(ingredients, stepNumber));
    }

    return steps;
  }

  List<CookingStep> _getAsianCookingSteps(
      List<Ingredient> ingredients, int startingStep) {
    int stepNumber = startingStep;
    return [
      CookingStep(
        stepNumber: stepNumber++,
        instruction:
            'Heat oil in a wok or large skillet over high heat until shimmering.',
        duration: 2,
        technique: 'high-heat cooking',
        tips: 'The wok should be very hot for proper stir-frying.',
      ),
      CookingStep(
        stepNumber: stepNumber++,
        instruction:
            'Add aromatics (garlic, ginger) and stir-fry for 30 seconds until fragrant.',
        duration: 1,
        technique: 'aromatics',
      ),
      CookingStep(
        stepNumber: stepNumber++,
        instruction:
            'Add protein and stir-fry until cooked through, about 3-5 minutes.',
        duration: 4,
        technique: 'stir-frying',
      ),
      CookingStep(
        stepNumber: stepNumber++,
        instruction:
            'Add vegetables and continue stir-frying until tender-crisp.',
        duration: 3,
        technique: 'stir-frying',
      ),
      CookingStep(
        stepNumber: stepNumber++,
        instruction:
            'Add sauce ingredients and toss everything together. Serve immediately.',
        duration: 2,
        tips: 'Serve immediately while hot for best texture.',
      ),
    ];
  }

  List<CookingStep> _getItalianCookingSteps(
      List<Ingredient> ingredients, int startingStep) {
    int stepNumber = startingStep;
    return [
      CookingStep(
        stepNumber: stepNumber++,
        instruction: 'Heat olive oil in a large pan over medium heat.',
        duration: 2,
        technique: 'sautéing',
      ),
      CookingStep(
        stepNumber: stepNumber++,
        instruction:
            'Add garlic and cook until fragrant, about 1 minute. Don\'t let it brown.',
        duration: 1,
        tips: 'Garlic should be golden, not brown, to avoid bitterness.',
      ),
      CookingStep(
        stepNumber: stepNumber++,
        instruction:
            'Add tomatoes and herbs. Simmer gently to develop flavors.',
        duration: 10,
        technique: 'simmering',
      ),
      CookingStep(
        stepNumber: stepNumber++,
        instruction:
            'Season with salt, pepper, and finish with fresh herbs and cheese.',
        duration: 2,
        tips: 'Fresh herbs added at the end provide the best flavor.',
      ),
    ];
  }

  List<CookingStep> _getMexicanCookingSteps(
      List<Ingredient> ingredients, int startingStep) {
    int stepNumber = startingStep;
    return [
      CookingStep(
        stepNumber: stepNumber++,
        instruction: 'Heat oil in a large skillet over medium-high heat.',
        duration: 2,
      ),
      CookingStep(
        stepNumber: stepNumber++,
        instruction:
            'Add onions and cook until softened and lightly caramelized.',
        duration: 5,
        technique: 'caramelizing',
      ),
      CookingStep(
        stepNumber: stepNumber++,
        instruction:
            'Add spices (cumin, chili powder) and cook for 30 seconds until fragrant.',
        duration: 1,
        technique: 'blooming spices',
        tips:
            'Toasting spices releases their essential oils and deepens flavor.',
      ),
      CookingStep(
        stepNumber: stepNumber++,
        instruction:
            'Add remaining ingredients and simmer until flavors meld together.',
        duration: 8,
        technique: 'simmering',
      ),
      CookingStep(
        stepNumber: stepNumber++,
        instruction:
            'Finish with fresh lime juice and cilantro. Taste and adjust seasoning.',
        duration: 1,
        tips:
            'Lime juice brightens all the flavors - add it just before serving.',
      ),
    ];
  }

  List<CookingStep> _getIndianCookingSteps(
      List<Ingredient> ingredients, int startingStep) {
    int stepNumber = startingStep;
    return [
      CookingStep(
        stepNumber: stepNumber++,
        instruction: 'Heat oil in a heavy-bottomed pot over medium heat.',
        duration: 2,
      ),
      CookingStep(
        stepNumber: stepNumber++,
        instruction:
            'Add whole spices and let them sizzle for 30 seconds until fragrant.',
        duration: 1,
        technique: 'tempering',
        tips: 'This technique is called "tadka" and builds the flavor base.',
      ),
      CookingStep(
        stepNumber: stepNumber++,
        instruction:
            'Add onions and cook until golden brown, about 8-10 minutes.',
        duration: 9,
        technique: 'browning',
      ),
      CookingStep(
        stepNumber: stepNumber++,
        instruction:
            'Add ginger-garlic paste and ground spices. Cook for 1-2 minutes.',
        duration: 2,
        technique: 'spice cooking',
      ),
      CookingStep(
        stepNumber: stepNumber++,
        instruction:
            'Add tomatoes and cook until they break down and form a thick base.',
        duration: 8,
        technique: 'masala base',
      ),
      CookingStep(
        stepNumber: stepNumber++,
        instruction:
            'Add main ingredients and simmer until tender. Garnish with fresh cilantro.',
        duration: 15,
        technique: 'slow cooking',
      ),
    ];
  }

  List<CookingStep> _getGenericCookingSteps(
      List<Ingredient> ingredients, int startingStep) {
    int stepNumber = startingStep;
    return [
      CookingStep(
        stepNumber: stepNumber++,
        instruction: 'Heat oil in a large pan over medium heat.',
        duration: 2,
      ),
      CookingStep(
        stepNumber: stepNumber++,
        instruction:
            'Add aromatics and cook until fragrant, about 2-3 minutes.',
        duration: 3,
      ),
      CookingStep(
        stepNumber: stepNumber++,
        instruction:
            'Add main ingredients and cook according to their requirements.',
        duration: 10,
      ),
      CookingStep(
        stepNumber: stepNumber++,
        instruction: 'Season to taste and serve hot.',
        duration: 1,
      ),
    ];
  }

  NutritionInfo _generateRealisticNutrition(
      List<Ingredient> ingredients, MealTemplate? mealTemplate, int servings) {
    // Calculate nutrition based on actual ingredients
    int totalCalories = 0;
    double totalProtein = 0;
    double totalCarbs = 0;
    double totalFat = 0;
    double totalFiber = 0;
    double totalSugar = 0;
    int totalSodium = 0;

    for (final ingredient in ingredients) {
      final nutrition = _getIngredientNutrition(ingredient);
      totalCalories += nutrition['calories']!.round();
      totalProtein += nutrition['protein']!;
      totalCarbs += nutrition['carbs']!;
      totalFat += nutrition['fat']!;
      totalFiber += nutrition['fiber']!;
      totalSugar += nutrition['sugar']!;
      totalSodium += nutrition['sodium']!.round();
    }

    // Adjust for servings
    return NutritionInfo(
      calories: (totalCalories / servings).round(),
      protein: totalProtein / servings,
      carbs: totalCarbs / servings,
      fat: totalFat / servings,
      fiber: totalFiber / servings,
      sugar: totalSugar / servings,
      sodium: (totalSodium / servings).round(),
    );
  }

  Map<String, double> _getIngredientNutrition(Ingredient ingredient) {
    final name = ingredient.name.toLowerCase();
    final quantity = ingredient.quantity;

    // Simplified nutrition calculation based on ingredient type
    if (name.contains('chicken') || name.contains('turkey')) {
      return {
        'calories': quantity * 50,
        'protein': quantity * 8,
        'carbs': 0,
        'fat': quantity * 2,
        'fiber': 0,
        'sugar': 0,
        'sodium': quantity * 30,
      };
    } else if (name.contains('beef') || name.contains('pork')) {
      return {
        'calories': quantity * 70,
        'protein': quantity * 7,
        'carbs': 0,
        'fat': quantity * 5,
        'fiber': 0,
        'sugar': 0,
        'sodium': quantity * 25,
      };
    } else if (name.contains('fish') || name.contains('salmon')) {
      return {
        'calories': quantity * 45,
        'protein': quantity * 9,
        'carbs': 0,
        'fat': quantity * 2,
        'fiber': 0,
        'sugar': 0,
        'sodium': quantity * 20,
      };
    } else if (name.contains('rice') || name.contains('pasta')) {
      return {
        'calories': quantity * 130,
        'protein': quantity * 3,
        'carbs': quantity * 28,
        'fat': quantity * 0.5,
        'fiber': quantity * 1,
        'sugar': quantity * 0.5,
        'sodium': quantity * 2,
      };
    } else if (name.contains('oil') || name.contains('butter')) {
      return {
        'calories': quantity * 120,
        'protein': 0,
        'carbs': 0,
        'fat': quantity * 14,
        'fiber': 0,
        'sugar': 0,
        'sodium': quantity * 2,
      };
    } else {
      // Default for vegetables and other ingredients
      return {
        'calories': quantity * 10,
        'protein': quantity * 1,
        'carbs': quantity * 2,
        'fat': quantity * 0.1,
        'fiber': quantity * 0.5,
        'sugar': quantity * 1,
        'sodium': quantity * 5,
      };
    }
  }

  String _generateContextualDescription(
      String title, RecipeRequest request, CuisineProfile? cuisineProfile) {
    final descriptions = <String>[];

    // Cuisine-specific descriptions
    if (cuisineProfile != null) {
      descriptions.addAll(_getCuisineDescriptions(cuisineProfile));
    }

    // Dietary restriction descriptions
    if (request.dietaryRestrictions.isNotEmpty) {
      descriptions.addAll(_getDietaryDescriptions(request.dietaryRestrictions));
    }

    // Default descriptions
    descriptions.addAll([
      'A delicious and satisfying dish that brings together the best flavors.',
      'This recipe combines fresh ingredients for a truly memorable meal.',
      'Perfect for busy weeknights when you want something special.',
      'A family-friendly recipe that will become a household favorite.',
    ]);

    final baseDescription = descriptions[Random().nextInt(descriptions.length)];
    final ingredientHighlight = request.ingredients.take(2).join(' and ');

    return '$baseDescription Features $ingredientHighlight and takes just minutes to prepare.';
  }

  List<String> _getCuisineDescriptions(CuisineProfile cuisineProfile) {
    switch (cuisineProfile.name.toLowerCase()) {
      case 'italian':
        return [
          'An authentic Italian dish that celebrates the simplicity of fresh ingredients.',
          'This rustic recipe brings the flavors of Italy to your kitchen.',
          'A classic preparation that showcases traditional Italian cooking techniques.',
        ];
      case 'mexican':
        return [
          'A vibrant Mexican-inspired dish bursting with bold flavors and spices.',
          'This zesty recipe brings the warmth and comfort of Mexican cuisine home.',
          'A colorful and satisfying dish that celebrates authentic Mexican flavors.',
        ];
      case 'asian':
        return [
          'A balanced Asian dish that harmonizes sweet, salty, and umami flavors.',
          'This aromatic recipe showcases the art of Asian cooking techniques.',
          'A fresh and flavorful dish inspired by traditional Asian cuisine.',
        ];
      case 'indian':
        return [
          'A fragrant Indian dish rich with warming spices and complex flavors.',
          'This aromatic recipe brings the exotic tastes of India to your table.',
          'A deeply satisfying dish that showcases the beauty of Indian spice blending.',
        ];
      default:
        return [];
    }
  }

  List<String> _getDietaryDescriptions(List<DietaryRestriction> restrictions) {
    final descriptions = <String>[];

    for (final restriction in restrictions) {
      switch (restriction) {
        case DietaryRestriction.vegan:
          descriptions.add(
              'A completely plant-based dish that\'s both nutritious and delicious.');
          break;
        case DietaryRestriction.glutenFree:
          descriptions.add(
              'A gluten-free recipe that doesn\'t compromise on flavor or texture.');
          break;
        case DietaryRestriction.keto:
          descriptions.add(
              'A keto-friendly dish that\'s high in healthy fats and low in carbs.');
          break;
        case DietaryRestriction.paleo:
          descriptions.add(
              'A paleo-compliant recipe using only whole, unprocessed ingredients.');
          break;
        default:
          break;
      }
    }

    return descriptions;
  }

  DifficultyLevel _generateSkillBasedDifficulty(RecipeRequest request) {
    if (request.skillLevel != null) {
      switch (request.skillLevel!) {
        case SkillLevel.novice:
        case SkillLevel.beginner:
          return DifficultyLevel.easy;
        case SkillLevel.intermediate:
          return DifficultyLevel.medium;
        case SkillLevel.advanced:
        case SkillLevel.professional:
          return DifficultyLevel.hard;
      }
    }

    // Default difficulty based on other factors
    int complexity = request.ingredients.length;
    if (request.cuisineType != null) {
      final complexCuisines = ['french', 'indian', 'thai'];
      if (complexCuisines.contains(request.cuisineType!.toLowerCase())) {
        complexity += 2;
      }
    }

    if (complexity <= 4) return DifficultyLevel.easy;
    if (complexity <= 8) return DifficultyLevel.medium;
    return DifficultyLevel.hard;
  }

  List<String>? _getRequiredEquipment(
      RecipeRequest request, CuisineProfile? cuisineProfile) {
    final equipment = <String>[];

    // Basic equipment
    equipment.addAll(['knife', 'cutting board', 'measuring cups']);

    // Cuisine-specific equipment
    if (cuisineProfile != null) {
      equipment.addAll(cuisineProfile.equipment.take(2));
    }

    // Skill-based equipment
    if (request.skillLevel != null) {
      equipment.addAll(RecipeTemplates.getEquipmentForDifficulty(
              _generateSkillBasedDifficulty(request))
          .take(2));
    }

    return equipment.take(6).toSet().toList();
  }

  List<String> _generateComprehensiveTags(
      RecipeRequest request, CuisineProfile? cuisineProfile) {
    final tags = <String>[];

    // Cuisine and meal type
    if (request.cuisineType != null)
      tags.add(request.cuisineType!.toLowerCase());
    if (request.mealType != null) tags.add(request.mealType!.toLowerCase());

    // Dietary restrictions
    for (final restriction in request.dietaryRestrictions) {
      tags.add(restriction.name
          .toLowerCase()
          .replaceAll(RegExp(r'([A-Z])'), '-\$1')
          .toLowerCase());
    }

    // Ingredient-based tags
    for (final ingredient in request.ingredients.take(3)) {
      tags.add(ingredient.toLowerCase().replaceAll(' ', '-'));
    }

    // Difficulty and time-based tags
    final difficulty = _generateSkillBasedDifficulty(request);
    tags.add(difficulty.name);

    if (request.maxCookingTime != null && request.maxCookingTime! <= 30) {
      tags.add('quick');
    }

    // General descriptive tags
    final generalTags = [
      'homemade',
      'family-friendly',
      'comfort-food',
      'healthy'
    ];
    tags.addAll(generalTags.take(2));

    return tags.take(10).toSet().toList();
  }

  List<String> _generateTags(RecipeRequest request) {
    // This method is kept for backward compatibility but now calls the comprehensive version
    return _generateComprehensiveTags(
        request, CuisineData.getCuisine(request.cuisineType));
  }
}
