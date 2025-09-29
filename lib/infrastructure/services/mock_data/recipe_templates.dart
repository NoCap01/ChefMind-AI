import 'dart:math';
import '../../../domain/enums/meal_type.dart';
import '../../../domain/enums/difficulty_level.dart';

/// Recipe templates for different meal types and cooking styles
class RecipeTemplates {
  static const Map<MealType, MealTemplate> templates = {
    MealType.breakfast: MealTemplate(
      name: 'Breakfast',
      baseCalories: 300,
      prepTimeRange: [5, 15],
      cookTimeRange: [5, 20],
      commonTechniques: [
        'scrambling',
        'frying',
        'toasting',
        'mixing',
        'blending'
      ],
      dishTypes: [
        'scrambled eggs',
        'pancakes',
        'oatmeal',
        'smoothie bowl',
        'avocado toast',
        'breakfast burrito',
        'french toast',
        'omelet'
      ],
      nutritionProfile: {
        'protein': 0.20, // 20% of calories
        'carbs': 0.50, // 50% of calories
        'fat': 0.30, // 30% of calories
      },
      commonIngredients: [
        'eggs',
        'milk',
        'bread',
        'butter',
        'fruit',
        'oats',
        'yogurt',
        'honey',
        'nuts',
        'seeds'
      ],
    ),
    MealType.lunch: MealTemplate(
      name: 'Lunch',
      baseCalories: 400,
      prepTimeRange: [10, 20],
      cookTimeRange: [10, 30],
      commonTechniques: [
        'sautéing',
        'grilling',
        'assembling',
        'tossing',
        'roasting'
      ],
      dishTypes: [
        'salad',
        'sandwich',
        'wrap',
        'soup',
        'grain bowl',
        'stir-fry',
        'pasta salad',
        'quinoa bowl'
      ],
      nutritionProfile: {
        'protein': 0.25,
        'carbs': 0.45,
        'fat': 0.30,
      },
      commonIngredients: [
        'greens',
        'vegetables',
        'protein',
        'grains',
        'dressing',
        'herbs',
        'nuts',
        'cheese'
      ],
    ),
    MealType.dinner: MealTemplate(
      name: 'Dinner',
      baseCalories: 500,
      prepTimeRange: [15, 30],
      cookTimeRange: [20, 60],
      commonTechniques: [
        'roasting',
        'braising',
        'sautéing',
        'grilling',
        'simmering',
        'baking',
        'steaming'
      ],
      dishTypes: [
        'roasted chicken',
        'pasta dish',
        'curry',
        'stir-fry',
        'casserole',
        'grilled fish',
        'stew',
        'risotto'
      ],
      nutritionProfile: {
        'protein': 0.30,
        'carbs': 0.40,
        'fat': 0.30,
      },
      commonIngredients: [
        'protein',
        'vegetables',
        'starch',
        'sauce',
        'herbs',
        'spices',
        'oil',
        'aromatics'
      ],
    ),
    MealType.snack: MealTemplate(
      name: 'Snack',
      baseCalories: 200,
      prepTimeRange: [2, 10],
      cookTimeRange: [0, 15],
      commonTechniques: [
        'mixing',
        'assembling',
        'toasting',
        'blending',
        'chopping'
      ],
      dishTypes: [
        'trail mix',
        'energy balls',
        'fruit salad',
        'veggie chips',
        'hummus and veggies',
        'smoothie',
        'nuts and seeds'
      ],
      nutritionProfile: {
        'protein': 0.15,
        'carbs': 0.55,
        'fat': 0.30,
      },
      commonIngredients: [
        'nuts',
        'seeds',
        'fruit',
        'vegetables',
        'yogurt',
        'cheese',
        'crackers',
        'dips'
      ],
    ),
    MealType.dessert: MealTemplate(
      name: 'Dessert',
      baseCalories: 250,
      prepTimeRange: [10, 30],
      cookTimeRange: [0, 45],
      commonTechniques: [
        'mixing',
        'baking',
        'whipping',
        'melting',
        'chilling',
        'layering',
        'decorating'
      ],
      dishTypes: [
        'cookies',
        'cake',
        'pudding',
        'fruit tart',
        'ice cream',
        'chocolate mousse',
        'fruit crumble',
        'cheesecake'
      ],
      nutritionProfile: {
        'protein': 0.08,
        'carbs': 0.60,
        'fat': 0.32,
      },
      commonIngredients: [
        'flour',
        'sugar',
        'butter',
        'eggs',
        'vanilla',
        'chocolate',
        'fruit',
        'cream',
        'nuts'
      ],
    ),
  };

  static MealTemplate? getTemplate(MealType mealType) {
    return templates[mealType];
  }

  static List<String> getSkillBasedTechniques(DifficultyLevel difficulty) {
    switch (difficulty) {
      case DifficultyLevel.beginner:
        return ['mixing', 'chopping', 'boiling', 'assembling', 'tossing'];
      case DifficultyLevel.easy:
        return [
          'mixing',
          'chopping',
          'sautéing',
          'boiling',
          'baking',
          'grilling',
          'assembling',
          'tossing'
        ];
      case DifficultyLevel.medium:
        return [
          'braising',
          'roasting',
          'steaming',
          'marinating',
          'reducing',
          'tempering',
          'blanching',
          'pan-searing'
        ];
      case DifficultyLevel.hard:
        return [
          'confit',
          'sous vide',
          'flambéing',
          'emulsifying',
          'clarifying',
          'molecular techniques',
          'advanced knife work',
          'sauce making'
        ];
      case DifficultyLevel.expert:
        return [
          'advanced confit',
          'molecular gastronomy',
          'precision cooking',
          'complex sauce work',
          'professional plating',
          'fermentation'
        ];
    }
  }

  static List<String> getEquipmentForDifficulty(DifficultyLevel difficulty) {
    switch (difficulty) {
      case DifficultyLevel.beginner:
        return ['basic pot', 'knife', 'cutting board', 'measuring cups'];
      case DifficultyLevel.easy:
        return [
          'basic pots and pans',
          'knife',
          'cutting board',
          'measuring cups',
          'mixing bowls',
          'wooden spoon'
        ];
      case DifficultyLevel.medium:
        return [
          'cast iron skillet',
          'roasting pan',
          'whisk',
          'tongs',
          'thermometer',
          'strainer',
          'grater'
        ];
      case DifficultyLevel.hard:
        return [
          'stand mixer',
          'food processor',
          'immersion blender',
          'mandoline',
          'specialty pans',
          'precision scales'
        ];
      case DifficultyLevel.expert:
        return [
          'professional equipment',
          'sous vide machine',
          'precision scales',
          'specialized tools',
          'commercial-grade appliances'
        ];
    }
  }

  static Map<String, String> getCookingTips(DifficultyLevel difficulty) {
    switch (difficulty) {
      case DifficultyLevel.beginner:
        return {
          'basics': 'Read the entire recipe before starting',
          'safety': 'Keep knives sharp and cutting board stable',
          'simple': 'Start with simple techniques and build confidence',
          'help': 'Don\'t hesitate to ask for help or look up techniques',
        };
      case DifficultyLevel.easy:
        return {
          'prep': 'Prepare all ingredients before starting to cook',
          'heat': 'Use medium heat for most cooking to avoid burning',
          'seasoning': 'Taste as you go and adjust seasoning',
          'timing': 'Set timers to avoid overcooking',
        };
      case DifficultyLevel.medium:
        return {
          'mise en place': 'Have everything measured and ready before cooking',
          'temperature': 'Use a thermometer for accurate cooking temperatures',
          'resting': 'Let proteins rest after cooking for better texture',
          'layering': 'Build flavors in layers throughout the cooking process',
        };
      case DifficultyLevel.hard:
        return {
          'technique':
              'Master fundamental techniques before attempting complex dishes',
          'timing': 'Coordinate multiple cooking processes for perfect timing',
          'precision': 'Measure ingredients precisely for consistent results',
          'patience':
              'Don\'t rush complex techniques - they take time to master',
        };
      case DifficultyLevel.expert:
        return {
          'perfection': 'Strive for perfection in every detail',
          'innovation':
              'Experiment with new techniques and flavor combinations',
          'presentation': 'Focus on professional-level presentation',
          'consistency': 'Achieve consistent results through precise execution',
        };
    }
  }
}

class MealTemplate {
  final String name;
  final int baseCalories;
  final List<int> prepTimeRange; // [min, max] in minutes
  final List<int> cookTimeRange; // [min, max] in minutes
  final List<String> commonTechniques;
  final List<String> dishTypes;
  final Map<String, double> nutritionProfile; // percentage of calories
  final List<String> commonIngredients;

  const MealTemplate({
    required this.name,
    required this.baseCalories,
    required this.prepTimeRange,
    required this.cookTimeRange,
    required this.commonTechniques,
    required this.dishTypes,
    required this.nutritionProfile,
    required this.commonIngredients,
  });

  int getRandomPrepTime() {
    final random = Random();
    return prepTimeRange[0] +
        random.nextInt(prepTimeRange[1] - prepTimeRange[0] + 1);
  }

  int getRandomCookTime() {
    final random = Random();
    return cookTimeRange[0] +
        random.nextInt(cookTimeRange[1] - cookTimeRange[0] + 1);
  }

  String getRandomDishType() {
    final random = Random();
    return dishTypes[random.nextInt(dishTypes.length)];
  }

  String getRandomTechnique() {
    final random = Random();
    return commonTechniques[random.nextInt(commonTechniques.length)];
  }
}
