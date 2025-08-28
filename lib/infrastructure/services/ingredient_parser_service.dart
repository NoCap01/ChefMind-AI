import 'dart:convert';
import 'package:collection/collection.dart';

import '../../domain/entities/recipe.dart';
import '../../domain/exceptions/app_exceptions.dart';

/// Service for parsing and validating ingredient inputs
class IngredientParserService {
  static IngredientParserService? _instance;
  static IngredientParserService get instance => _instance ??= IngredientParserService._();
  
  IngredientParserService._();

  // Common units and their variations
  static const Map<String, List<String>> _unitVariations = {
    'cup': ['cup', 'cups', 'c', 'c.'],
    'tablespoon': ['tablespoon', 'tablespoons', 'tbsp', 'tbsp.', 'tbs', 'T'],
    'teaspoon': ['teaspoon', 'teaspoons', 'tsp', 'tsp.', 't'],
    'pound': ['pound', 'pounds', 'lb', 'lbs', 'lb.', 'lbs.'],
    'ounce': ['ounce', 'ounces', 'oz', 'oz.'],
    'gram': ['gram', 'grams', 'g', 'g.'],
    'kilogram': ['kilogram', 'kilograms', 'kg', 'kg.'],
    'liter': ['liter', 'liters', 'l', 'l.', 'litre', 'litres'],
    'milliliter': ['milliliter', 'milliliters', 'ml', 'ml.', 'millilitre', 'millilitres'],
    'pint': ['pint', 'pints', 'pt', 'pt.'],
    'quart': ['quart', 'quarts', 'qt', 'qt.'],
    'gallon': ['gallon', 'gallons', 'gal', 'gal.'],
    'piece': ['piece', 'pieces', 'pc', 'pcs', 'each'],
    'clove': ['clove', 'cloves'],
    'slice': ['slice', 'slices'],
    'bunch': ['bunch', 'bunches'],
    'head': ['head', 'heads'],
    'can': ['can', 'cans'],
    'jar': ['jar', 'jars'],
    'package': ['package', 'packages', 'pkg', 'pkgs'],
    'bottle': ['bottle', 'bottles'],
    'bag': ['bag', 'bags'],
    'box': ['box', 'boxes'],
  };

  // Common ingredient categories
  static const Map<String, List<String>> _ingredientCategories = {
    'vegetables': [
      'onion', 'garlic', 'tomato', 'carrot', 'celery', 'bell pepper', 'mushroom',
      'broccoli', 'spinach', 'lettuce', 'cucumber', 'potato', 'sweet potato',
      'zucchini', 'eggplant', 'cabbage', 'cauliflower', 'asparagus', 'corn',
      'peas', 'green beans', 'brussels sprouts', 'kale', 'arugula', 'radish',
    ],
    'fruits': [
      'apple', 'banana', 'orange', 'lemon', 'lime', 'strawberry', 'blueberry',
      'raspberry', 'blackberry', 'grape', 'pineapple', 'mango', 'avocado',
      'peach', 'pear', 'cherry', 'plum', 'watermelon', 'cantaloupe', 'kiwi',
    ],
    'proteins': [
      'chicken', 'beef', 'pork', 'fish', 'salmon', 'tuna', 'shrimp', 'crab',
      'lobster', 'turkey', 'lamb', 'duck', 'eggs', 'tofu', 'tempeh', 'beans',
      'lentils', 'chickpeas', 'black beans', 'kidney beans', 'quinoa',
    ],
    'dairy': [
      'milk', 'butter', 'cheese', 'cream', 'yogurt', 'sour cream', 'cream cheese',
      'mozzarella', 'cheddar', 'parmesan', 'feta', 'goat cheese', 'ricotta',
    ],
    'grains': [
      'rice', 'pasta', 'bread', 'flour', 'oats', 'barley', 'wheat', 'quinoa',
      'couscous', 'bulgur', 'cornmeal', 'breadcrumbs', 'noodles',
    ],
    'spices': [
      'salt', 'pepper', 'paprika', 'cumin', 'oregano', 'basil', 'thyme',
      'rosemary', 'sage', 'parsley', 'cilantro', 'dill', 'chives', 'ginger',
      'turmeric', 'cinnamon', 'nutmeg', 'cloves', 'cardamom', 'bay leaves',
    ],
    'oils': [
      'olive oil', 'vegetable oil', 'canola oil', 'coconut oil', 'sesame oil',
      'avocado oil', 'sunflower oil', 'peanut oil', 'butter', 'ghee',
    ],
    'condiments': [
      'soy sauce', 'vinegar', 'balsamic vinegar', 'hot sauce', 'ketchup',
      'mustard', 'mayonnaise', 'worcestershire sauce', 'fish sauce', 'honey',
      'maple syrup', 'vanilla extract', 'lemon juice', 'lime juice',
    ],
  };

  // Fraction patterns for parsing
  static const Map<String, double> _fractionMap = {
    '1/8': 0.125,
    '1/4': 0.25,
    '1/3': 0.333,
    '1/2': 0.5,
    '2/3': 0.667,
    '3/4': 0.75,
    '7/8': 0.875,
  };

  /// Parse a single ingredient string into an Ingredient object
  Ingredient parseIngredient(String ingredientText) {
    try {
      final cleaned = _cleanIngredientText(ingredientText);
      final parts = _splitIngredientParts(cleaned);
      
      final quantity = _parseQuantity(parts['quantity'] ?? '1');
      final unit = _normalizeUnit(parts['unit'] ?? 'piece');
      final name = _normalizeIngredientName(parts['name'] ?? cleaned);
      final category = _categorizeIngredient(name);
      final isOptional = _checkIfOptional(ingredientText);
      
      return Ingredient(
        name: name,
        quantity: quantity,
        unit: unit,
        category: category,
        isOptional: isOptional,
        alternatives: _suggestAlternatives(name),
      );
    } catch (e) {
      throw IngredientParsingException('Failed to parse ingredient "$ingredientText": $e');
    }
  }

  /// Parse multiple ingredient strings
  List<Ingredient> parseIngredients(List<String> ingredientTexts) {
    final ingredients = <Ingredient>[];
    final errors = <String>[];

    for (final text in ingredientTexts) {
      try {
        ingredients.add(parseIngredient(text));
      } catch (e) {
        errors.add('Error parsing "$text": $e');
      }
    }

    if (errors.isNotEmpty && ingredients.isEmpty) {
      throw IngredientParsingException('Failed to parse any ingredients: ${errors.join(', ')}');
    }

    return ingredients;
  }

  /// Parse ingredient text from natural language input
  List<Ingredient> parseNaturalLanguageIngredients(String text) {
    // Split by common separators
    final lines = text.split(RegExp(r'[,\n;]'))
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .toList();

    return parseIngredients(lines);
  }

  /// Validate an ingredient for completeness and accuracy
  IngredientValidationResult validateIngredient(Ingredient ingredient) {
    final errors = <String>[];
    final warnings = <String>[];
    final suggestions = <String>[];

    // Check quantity
    if (ingredient.quantity <= 0) {
      errors.add('Quantity must be greater than 0');
    }

    // Check unit
    if (!_isValidUnit(ingredient.unit)) {
      warnings.add('Unit "${ingredient.unit}" is not commonly recognized');
      suggestions.add('Consider using standard units like cups, tablespoons, or grams');
    }

    // Check ingredient name
    if (ingredient.name.isEmpty) {
      errors.add('Ingredient name cannot be empty');
    } else if (ingredient.name.length < 2) {
      warnings.add('Ingredient name seems too short');
    }

    // Check for common issues
    if (_containsNumbers(ingredient.name)) {
      warnings.add('Ingredient name contains numbers - consider moving to quantity');
    }

    if (_isLikelyMisspelled(ingredient.name)) {
      final suggestion = _suggestCorrection(ingredient.name);
      if (suggestion != null) {
        suggestions.add('Did you mean "$suggestion"?');
      }
    }

    return IngredientValidationResult(
      isValid: errors.isEmpty,
      errors: errors,
      warnings: warnings,
      suggestions: suggestions,
    );
  }

  /// Get ingredient suggestions based on partial input
  List<IngredientSuggestion> getIngredientSuggestions(String partialInput) {
    final suggestions = <IngredientSuggestion>[];
    final input = partialInput.toLowerCase().trim();

    if (input.length < 2) return suggestions;

    // Search through all ingredient categories
    for (final category in _ingredientCategories.entries) {
      for (final ingredient in category.value) {
        if (ingredient.toLowerCase().contains(input)) {
          final similarity = _calculateSimilarity(input, ingredient);
          suggestions.add(IngredientSuggestion(
            name: ingredient,
            category: category.key,
            similarity: similarity,
            commonUnits: _getCommonUnitsForIngredient(ingredient),
          ));
        }
      }
    }

    // Sort by similarity and return top matches
    suggestions.sort((a, b) => b.similarity.compareTo(a.similarity));
    return suggestions.take(10).toList();
  }

  /// Get auto-complete suggestions for ingredient names
  List<String> getAutoCompleteSuggestions(String input) {
    return getIngredientSuggestions(input)
        .map((suggestion) => suggestion.name)
        .toList();
  }

  /// Standardize ingredient name for consistency
  String standardizeIngredientName(String name) {
    return _normalizeIngredientName(name);
  }

  /// Check if two ingredients are the same (accounting for variations)
  bool areIngredientsEquivalent(String ingredient1, String ingredient2) {
    final normalized1 = _normalizeIngredientName(ingredient1);
    final normalized2 = _normalizeIngredientName(ingredient2);
    
    return normalized1 == normalized2 ||
           _calculateSimilarity(normalized1, normalized2) > 0.8;
  }

  /// Convert between different units for the same ingredient
  double? convertUnit(double quantity, String fromUnit, String toUnit, String ingredientName) {
    final normalizedFrom = _normalizeUnit(fromUnit);
    final normalizedTo = _normalizeUnit(toUnit);
    
    if (normalizedFrom == normalizedTo) return quantity;
    
    // Use conversion tables based on ingredient type
    final conversionFactor = _getConversionFactor(normalizedFrom, normalizedTo, ingredientName);
    return conversionFactor != null ? quantity * conversionFactor : null;
  }

  // Private helper methods

  String _cleanIngredientText(String text) {
    return text.trim()
        .replaceAll(RegExp(r'\s+'), ' ')
        .replaceAll(RegExp(r'[^\w\s\./\-]'), '');
  }

  Map<String, String> _splitIngredientParts(String text) {
    final parts = <String, String>{};
    
    // Pattern to match quantity, unit, and ingredient name
    final pattern = RegExp(r'^(\d+(?:[./]\d+)?(?:\s+\d+/\d+)?)\s*([a-zA-Z]+)?\s+(.+)$');
    final match = pattern.firstMatch(text);
    
    if (match != null) {
      parts['quantity'] = match.group(1)?.trim() ?? '';
      parts['unit'] = match.group(2)?.trim() ?? '';
      parts['name'] = match.group(3)?.trim() ?? '';
    } else {
      // Try to extract just quantity and name
      final simplePattern = RegExp(r'^(\d+(?:[./]\d+)?)\s+(.+)$');
      final simpleMatch = simplePattern.firstMatch(text);
      
      if (simpleMatch != null) {
        parts['quantity'] = simpleMatch.group(1)?.trim() ?? '';
        parts['name'] = simpleMatch.group(2)?.trim() ?? '';
      } else {
        parts['name'] = text;
      }
    }
    
    return parts;
  }

  double _parseQuantity(String quantityText) {
    if (quantityText.isEmpty) return 1.0;
    
    // Handle fractions
    for (final fraction in _fractionMap.entries) {
      if (quantityText.contains(fraction.key)) {
        final wholePart = quantityText.replaceAll(fraction.key, '').trim();
        final wholeNumber = wholePart.isEmpty ? 0.0 : double.tryParse(wholePart) ?? 0.0;
        return wholeNumber + fraction.value;
      }
    }
    
    // Handle decimal numbers
    return double.tryParse(quantityText) ?? 1.0;
  }

  String _normalizeUnit(String unit) {
    final lowerUnit = unit.toLowerCase().trim();
    
    for (final standardUnit in _unitVariations.entries) {
      if (standardUnit.value.contains(lowerUnit)) {
        return standardUnit.key;
      }
    }
    
    return lowerUnit;
  }

  String _normalizeIngredientName(String name) {
    return name.toLowerCase()
        .trim()
        .replaceAll(RegExp(r'\s+'), ' ')
        .replaceAll(RegExp(r'[^\w\s]'), '');
  }

  String? _categorizeIngredient(String name) {
    final normalizedName = name.toLowerCase();
    
    for (final category in _ingredientCategories.entries) {
      for (final ingredient in category.value) {
        if (normalizedName.contains(ingredient) || ingredient.contains(normalizedName)) {
          return category.key;
        }
      }
    }
    
    return null;
  }

  bool _checkIfOptional(String text) {
    final optionalKeywords = ['optional', 'to taste', 'if desired', 'garnish'];
    final lowerText = text.toLowerCase();
    
    return optionalKeywords.any((keyword) => lowerText.contains(keyword));
  }

  List<String> _suggestAlternatives(String ingredientName) {
    // Simple alternative suggestions based on common substitutions
    final alternatives = <String, List<String>>{
      'butter': ['margarine', 'coconut oil', 'vegetable oil'],
      'milk': ['almond milk', 'soy milk', 'oat milk'],
      'eggs': ['flax eggs', 'chia eggs', 'applesauce'],
      'sugar': ['honey', 'maple syrup', 'stevia'],
      'flour': ['almond flour', 'coconut flour', 'oat flour'],
      'cream': ['coconut cream', 'cashew cream', 'heavy cream'],
    };
    
    final normalized = _normalizeIngredientName(ingredientName);
    return alternatives[normalized] ?? [];
  }

  bool _isValidUnit(String unit) {
    return _unitVariations.values.any((variations) => variations.contains(unit.toLowerCase()));
  }

  bool _containsNumbers(String text) {
    return RegExp(r'\d').hasMatch(text);
  }

  bool _isLikelyMisspelled(String name) {
    // Simple heuristic: check if it's close to any known ingredient
    final allIngredients = _ingredientCategories.values.expand((list) => list).toList();
    
    for (final ingredient in allIngredients) {
      final similarity = _calculateSimilarity(name.toLowerCase(), ingredient);
      if (similarity > 0.7 && similarity < 1.0) {
        return true;
      }
    }
    
    return false;
  }

  String? _suggestCorrection(String name) {
    final allIngredients = _ingredientCategories.values.expand((list) => list).toList();
    String? bestMatch;
    double bestSimilarity = 0.0;
    
    for (final ingredient in allIngredients) {
      final similarity = _calculateSimilarity(name.toLowerCase(), ingredient);
      if (similarity > bestSimilarity && similarity > 0.7) {
        bestSimilarity = similarity;
        bestMatch = ingredient;
      }
    }
    
    return bestMatch;
  }

  double _calculateSimilarity(String str1, String str2) {
    if (str1 == str2) return 1.0;
    if (str1.isEmpty || str2.isEmpty) return 0.0;
    
    // Simple Levenshtein distance-based similarity
    final longer = str1.length > str2.length ? str1 : str2;
    final shorter = str1.length > str2.length ? str2 : str1;
    
    if (longer.length == 0) return 1.0;
    
    final editDistance = _levenshteinDistance(longer, shorter);
    return (longer.length - editDistance) / longer.length;
  }

  int _levenshteinDistance(String str1, String str2) {
    final matrix = List.generate(
      str1.length + 1,
      (i) => List.generate(str2.length + 1, (j) => 0),
    );

    for (int i = 0; i <= str1.length; i++) {
      matrix[i][0] = i;
    }

    for (int j = 0; j <= str2.length; j++) {
      matrix[0][j] = j;
    }

    for (int i = 1; i <= str1.length; i++) {
      for (int j = 1; j <= str2.length; j++) {
        final cost = str1[i - 1] == str2[j - 1] ? 0 : 1;
        matrix[i][j] = [
          matrix[i - 1][j] + 1,
          matrix[i][j - 1] + 1,
          matrix[i - 1][j - 1] + cost,
        ].reduce((a, b) => a < b ? a : b);
      }
    }

    return matrix[str1.length][str2.length];
  }

  List<String> _getCommonUnitsForIngredient(String ingredient) {
    // Return common units based on ingredient type
    final category = _categorizeIngredient(ingredient);
    
    switch (category) {
      case 'vegetables':
      case 'fruits':
        return ['piece', 'cup', 'pound', 'ounce'];
      case 'proteins':
        return ['pound', 'ounce', 'piece', 'cup'];
      case 'dairy':
        return ['cup', 'tablespoon', 'ounce', 'pound'];
      case 'grains':
        return ['cup', 'pound', 'ounce', 'tablespoon'];
      case 'spices':
        return ['teaspoon', 'tablespoon', 'ounce', 'gram'];
      case 'oils':
        return ['tablespoon', 'cup', 'teaspoon', 'ounce'];
      case 'condiments':
        return ['tablespoon', 'teaspoon', 'cup', 'ounce'];
      default:
        return ['piece', 'cup', 'tablespoon', 'teaspoon'];
    }
  }

  double? _getConversionFactor(String fromUnit, String toUnit, String ingredientName) {
    // Basic conversion factors (this would be more comprehensive in a real app)
    final conversions = <String, Map<String, double>>{
      'cup': {
        'tablespoon': 16.0,
        'teaspoon': 48.0,
        'ounce': 8.0,
        'milliliter': 236.588,
      },
      'tablespoon': {
        'cup': 1.0 / 16.0,
        'teaspoon': 3.0,
        'ounce': 0.5,
        'milliliter': 14.787,
      },
      'teaspoon': {
        'cup': 1.0 / 48.0,
        'tablespoon': 1.0 / 3.0,
        'milliliter': 4.929,
      },
      'pound': {
        'ounce': 16.0,
        'gram': 453.592,
        'kilogram': 0.453592,
      },
      'ounce': {
        'pound': 1.0 / 16.0,
        'gram': 28.3495,
        'tablespoon': 2.0, // for liquids
      },
    };
    
    return conversions[fromUnit]?[toUnit];
  }
}

/// Result of ingredient validation
class IngredientValidationResult {
  final bool isValid;
  final List<String> errors;
  final List<String> warnings;
  final List<String> suggestions;

  const IngredientValidationResult({
    required this.isValid,
    required this.errors,
    required this.warnings,
    required this.suggestions,
  });
}

/// Ingredient suggestion with metadata
class IngredientSuggestion {
  final String name;
  final String category;
  final double similarity;
  final List<String> commonUnits;

  const IngredientSuggestion({
    required this.name,
    required this.category,
    required this.similarity,
    required this.commonUnits,
  });
}