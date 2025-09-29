

class IngredientSuggestionsService {
  static const List<String> _commonIngredients = [
    // Proteins
    'chicken breast', 'chicken thighs', 'ground beef', 'salmon', 'shrimp', 'eggs', 'tofu',
    'pork chops', 'bacon', 'turkey', 'tuna', 'cod', 'lamb', 'beef steak', 'ground turkey',
    
    // Vegetables
    'onion', 'garlic', 'tomatoes', 'bell peppers', 'carrots', 'celery', 'potatoes', 
    'broccoli', 'spinach', 'mushrooms', 'zucchini', 'cucumber', 'lettuce', 'cabbage',
    'green beans', 'corn', 'peas', 'asparagus', 'cauliflower', 'sweet potatoes',
    'red onion', 'green onions', 'leeks', 'eggplant', 'radishes', 'beets',
    
    // Fruits
    'apples', 'bananas', 'lemons', 'limes', 'oranges', 'strawberries', 'blueberries',
    'avocado', 'grapes', 'pineapple', 'mango', 'peaches', 'pears', 'cherries',
    
    // Grains & Starches
    'rice', 'pasta', 'bread', 'quinoa', 'oats', 'flour', 'noodles', 'couscous',
    'barley', 'bulgur', 'polenta', 'tortillas', 'crackers', 'cereal',
    
    // Dairy & Alternatives
    'milk', 'cheese', 'butter', 'yogurt', 'cream', 'sour cream', 'cream cheese',
    'mozzarella', 'cheddar', 'parmesan', 'feta', 'goat cheese', 'almond milk',
    'coconut milk', 'heavy cream',
    
    // Pantry Staples
    'olive oil', 'vegetable oil', 'coconut oil', 'salt', 'black pepper', 'sugar',
    'brown sugar', 'honey', 'maple syrup', 'vanilla extract', 'baking powder',
    'baking soda', 'vinegar', 'soy sauce', 'hot sauce', 'ketchup', 'mustard',
    
    // Herbs & Spices
    'basil', 'oregano', 'thyme', 'rosemary', 'parsley', 'cilantro', 'dill',
    'paprika', 'cumin', 'chili powder', 'garlic powder', 'onion powder',
    'cinnamon', 'nutmeg', 'ginger', 'turmeric', 'bay leaves', 'red pepper flakes',
    
    // Beans & Legumes
    'black beans', 'kidney beans', 'chickpeas', 'lentils', 'pinto beans',
    'navy beans', 'lima beans', 'split peas', 'cannellini beans',
    
    // Nuts & Seeds
    'almonds', 'walnuts', 'pecans', 'cashews', 'peanuts', 'sunflower seeds',
    'pumpkin seeds', 'sesame seeds', 'chia seeds', 'flax seeds',
    
    // Canned/Jarred Items
    'canned tomatoes', 'tomato paste', 'tomato sauce', 'chicken broth', 'vegetable broth',
    'beef broth', 'coconut cream', 'peanut butter', 'jam', 'pickles', 'olives',
  ];

  static const Map<String, List<String>> _categoryIngredients = {
    'proteins': [
      'chicken breast', 'chicken thighs', 'ground beef', 'salmon', 'shrimp', 'eggs', 'tofu',
      'pork chops', 'bacon', 'turkey', 'tuna', 'cod', 'lamb', 'beef steak', 'ground turkey',
    ],
    'vegetables': [
      'onion', 'garlic', 'tomatoes', 'bell peppers', 'carrots', 'celery', 'potatoes', 
      'broccoli', 'spinach', 'mushrooms', 'zucchini', 'cucumber', 'lettuce', 'cabbage',
      'green beans', 'corn', 'peas', 'asparagus', 'cauliflower', 'sweet potatoes',
    ],
    'fruits': [
      'apples', 'bananas', 'lemons', 'limes', 'oranges', 'strawberries', 'blueberries',
      'avocado', 'grapes', 'pineapple', 'mango', 'peaches', 'pears', 'cherries',
    ],
    'grains': [
      'rice', 'pasta', 'bread', 'quinoa', 'oats', 'flour', 'noodles', 'couscous',
      'barley', 'bulgur', 'polenta', 'tortillas', 'crackers', 'cereal',
    ],
    'dairy': [
      'milk', 'cheese', 'butter', 'yogurt', 'cream', 'sour cream', 'cream cheese',
      'mozzarella', 'cheddar', 'parmesan', 'feta', 'goat cheese', 'almond milk',
    ],
    'spices': [
      'basil', 'oregano', 'thyme', 'rosemary', 'parsley', 'cilantro', 'dill',
      'paprika', 'cumin', 'chili powder', 'garlic powder', 'onion powder',
      'cinnamon', 'nutmeg', 'ginger', 'turmeric', 'bay leaves', 'red pepper flakes',
    ],
  };

  /// Get ingredient suggestions based on partial input
  static List<String> getSuggestions(String query, {int limit = 10}) {
    if (query.isEmpty) return [];
    
    final lowerQuery = query.toLowerCase().trim();
    final suggestions = <String>[];
    
    // Find exact matches first
    for (final ingredient in _commonIngredients) {
      if (ingredient.toLowerCase().startsWith(lowerQuery)) {
        suggestions.add(ingredient);
      }
    }
    
    // Then find partial matches
    if (suggestions.length < limit) {
      for (final ingredient in _commonIngredients) {
        if (!suggestions.contains(ingredient) && 
            ingredient.toLowerCase().contains(lowerQuery)) {
          suggestions.add(ingredient);
        }
      }
    }
    
    return suggestions.take(limit).toList();
  }

  /// Get suggestions by category
  static List<String> getSuggestionsByCategory(String category, {int limit = 20}) {
    final categoryIngredients = _categoryIngredients[category.toLowerCase()];
    if (categoryIngredients == null) return [];
    
    return categoryIngredients.take(limit).toList();
  }

  /// Get popular ingredients for quick selection
  static List<String> getPopularIngredients({int limit = 12}) {
    return [
      'chicken breast', 'onion', 'garlic', 'tomatoes', 'rice', 'pasta',
      'olive oil', 'salt', 'black pepper', 'eggs', 'cheese', 'potatoes',
    ].take(limit).toList();
  }

  /// Validate ingredient name
  static String? validateIngredient(String ingredient, List<String> existingIngredients) {
    final trimmed = ingredient.trim();
    
    if (trimmed.isEmpty) {
      return 'Ingredient cannot be empty';
    }
    
    if (trimmed.length < 2) {
      return 'Ingredient name must be at least 2 characters';
    }
    
    if (trimmed.length > 50) {
      return 'Ingredient name must be less than 50 characters';
    }
    
    // Check for duplicates (case-insensitive)
    final lowerTrimmed = trimmed.toLowerCase();
    for (final existing in existingIngredients) {
      if (existing.toLowerCase() == lowerTrimmed) {
        return 'This ingredient is already added';
      }
    }
    
    // Check for similar ingredients to prevent near-duplicates
    for (final existing in existingIngredients) {
      final existingLower = existing.toLowerCase();
      if (existingLower.contains(lowerTrimmed) || lowerTrimmed.contains(existingLower)) {
        if ((existingLower.length - lowerTrimmed.length).abs() <= 2) {
          return 'Similar ingredient "$existing" is already added';
        }
      }
    }
    
    return null;
  }

  /// Clean and format ingredient name
  static String formatIngredient(String ingredient) {
    return ingredient.trim().toLowerCase().split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1);
    }).join(' ');
  }

  /// Get complementary ingredients based on existing ingredients
  static List<String> getComplementaryIngredients(List<String> existingIngredients, {int limit = 5}) {
    final existing = existingIngredients.map((e) => e.toLowerCase()).toSet();
    final suggestions = <String>[];
    
    // Common ingredient pairings
    final pairings = <String, List<String>>{
      'chicken': ['garlic', 'onion', 'thyme', 'lemon', 'olive oil'],
      'beef': ['onion', 'garlic', 'rosemary', 'red wine', 'mushrooms'],
      'fish': ['lemon', 'dill', 'garlic', 'olive oil', 'capers'],
      'pasta': ['garlic', 'olive oil', 'parmesan', 'basil', 'tomatoes'],
      'rice': ['onion', 'garlic', 'soy sauce', 'ginger', 'sesame oil'],
      'tomatoes': ['basil', 'garlic', 'onion', 'olive oil', 'mozzarella'],
      'potatoes': ['rosemary', 'garlic', 'butter', 'thyme', 'salt'],
    };
    
    for (final ingredient in existing) {
      for (final key in pairings.keys) {
        if (ingredient.contains(key)) {
          for (final complement in pairings[key]!) {
            if (!existing.contains(complement) && !suggestions.contains(complement)) {
              suggestions.add(complement);
            }
          }
        }
      }
    }
    
    return suggestions.take(limit).toList();
  }

  /// Get all available categories
  static List<String> getCategories() {
    return _categoryIngredients.keys.toList();
  }
}