import 'package:flutter_test/flutter_test.dart';
import 'package:chefmind_ai/infrastructure/services/ingredient_parser_service.dart';
import 'package:chefmind_ai/domain/exceptions/app_exceptions.dart';

void main() {
  group('IngredientParserService', () {
    late IngredientParserService service;

    setUp(() {
      service = IngredientParserService.instance;
    });

    group('parseIngredient', () {
      test('should parse simple ingredient with quantity and unit', () {
        final ingredient = service.parseIngredient('2 cups flour');
        
        expect(ingredient.name, equals('flour'));
        expect(ingredient.quantity, equals(2.0));
        expect(ingredient.unit, equals('cup'));
        expect(ingredient.category, equals('grains'));
        expect(ingredient.isOptional, isFalse);
      });

      test('should parse ingredient with fraction', () {
        final ingredient = service.parseIngredient('1/2 cup milk');
        
        expect(ingredient.name, equals('milk'));
        expect(ingredient.quantity, equals(0.5));
        expect(ingredient.unit, equals('cup'));
        expect(ingredient.category, equals('dairy'));
      });

      test('should parse ingredient with mixed number', () {
        final ingredient = service.parseIngredient('1 1/2 cups sugar');
        
        expect(ingredient.name, equals('sugar'));
        expect(ingredient.quantity, equals(1.5));
        expect(ingredient.unit, equals('cup'));
      });

      test('should parse ingredient without explicit unit', () {
        final ingredient = service.parseIngredient('3 eggs');
        
        expect(ingredient.name, equals('eggs'));
        expect(ingredient.quantity, equals(3.0));
        expect(ingredient.unit, equals('piece'));
        expect(ingredient.category, equals('proteins'));
      });

      test('should parse ingredient with alternative units', () {
        final ingredient = service.parseIngredient('2 tbsp olive oil');
        
        expect(ingredient.name, equals('olive oil'));
        expect(ingredient.quantity, equals(2.0));
        expect(ingredient.unit, equals('tablespoon'));
        expect(ingredient.category, equals('oils'));
      });

      test('should detect optional ingredients', () {
        final ingredient = service.parseIngredient('1 tsp salt (optional)');
        
        expect(ingredient.name, contains('salt'));
        expect(ingredient.isOptional, isTrue);
      });

      test('should handle complex ingredient names', () {
        final ingredient = service.parseIngredient('1 lb ground beef, lean');
        
        expect(ingredient.name, contains('ground beef'));
        expect(ingredient.quantity, equals(1.0));
        expect(ingredient.unit, equals('pound'));
      });

      test('should throw exception for invalid input', () {
        expect(
          () => service.parseIngredient(''),
          throwsA(isA<IngredientParsingException>()),
        );
      });
    });

    group('parseIngredients', () {
      test('should parse multiple ingredients', () {
        final ingredients = service.parseIngredients([
          '2 cups flour',
          '1 cup milk',
          '3 eggs',
          '1/4 cup sugar',
        ]);
        
        expect(ingredients, hasLength(4));
        expect(ingredients[0].name, equals('flour'));
        expect(ingredients[1].name, equals('milk'));
        expect(ingredients[2].name, equals('eggs'));
        expect(ingredients[3].name, equals('sugar'));
      });

      test('should handle mixed valid and invalid ingredients', () {
        final ingredients = service.parseIngredients([
          '2 cups flour',
          '', // Invalid
          '1 cup milk',
        ]);
        
        expect(ingredients, hasLength(2));
        expect(ingredients[0].name, equals('flour'));
        expect(ingredients[1].name, equals('milk'));
      });

      test('should throw exception when all ingredients are invalid', () {
        expect(
          () => service.parseIngredients(['', '   ', 'invalid']),
          throwsA(isA<IngredientParsingException>()),
        );
      });
    });

    group('parseNaturalLanguageIngredients', () {
      test('should parse comma-separated ingredients', () {
        final ingredients = service.parseNaturalLanguageIngredients(
          '2 cups flour, 1 cup milk, 3 eggs, 1/4 cup sugar'
        );
        
        expect(ingredients, hasLength(4));
        expect(ingredients.map((i) => i.name), containsAll(['flour', 'milk', 'eggs', 'sugar']));
      });

      test('should parse newline-separated ingredients', () {
        final ingredients = service.parseNaturalLanguageIngredients('''
2 cups flour
1 cup milk
3 eggs
1/4 cup sugar
        ''');
        
        expect(ingredients, hasLength(4));
      });

      test('should parse semicolon-separated ingredients', () {
        final ingredients = service.parseNaturalLanguageIngredients(
          '2 cups flour; 1 cup milk; 3 eggs'
        );
        
        expect(ingredients, hasLength(3));
      });
    });

    group('validateIngredient', () {
      test('should validate correct ingredient', () {
        final ingredient = service.parseIngredient('2 cups flour');
        final result = service.validateIngredient(ingredient);
        
        expect(result.isValid, isTrue);
        expect(result.errors, isEmpty);
      });

      test('should detect invalid quantity', () {
        final ingredient = service.parseIngredient('2 cups flour');
        final invalidIngredient = ingredient.copyWith(quantity: 0);
        final result = service.validateIngredient(invalidIngredient);
        
        expect(result.isValid, isFalse);
        expect(result.errors, contains('Quantity must be greater than 0'));
      });

      test('should detect empty ingredient name', () {
        final ingredient = service.parseIngredient('2 cups flour');
        final invalidIngredient = ingredient.copyWith(name: '');
        final result = service.validateIngredient(invalidIngredient);
        
        expect(result.isValid, isFalse);
        expect(result.errors, contains('Ingredient name cannot be empty'));
      });

      test('should warn about unrecognized units', () {
        final ingredient = service.parseIngredient('2 cups flour');
        final unusualIngredient = ingredient.copyWith(unit: 'smidgen');
        final result = service.validateIngredient(unusualIngredient);
        
        expect(result.warnings, isNotEmpty);
        expect(result.warnings.first, contains('not commonly recognized'));
      });

      test('should warn about numbers in ingredient name', () {
        final ingredient = service.parseIngredient('2 cups flour');
        final numberedIngredient = ingredient.copyWith(name: 'flour type 00');
        final result = service.validateIngredient(numberedIngredient);
        
        expect(result.warnings, contains('Ingredient name contains numbers - consider moving to quantity'));
      });
    });

    group('getIngredientSuggestions', () {
      test('should return suggestions for partial input', () {
        final suggestions = service.getIngredientSuggestions('tom');
        
        expect(suggestions, isNotEmpty);
        expect(suggestions.any((s) => s.name.contains('tomato')), isTrue);
      });

      test('should return suggestions sorted by similarity', () {
        final suggestions = service.getIngredientSuggestions('chick');
        
        expect(suggestions, isNotEmpty);
        expect(suggestions.first.similarity, greaterThanOrEqualTo(suggestions.last.similarity));
      });

      test('should return empty list for very short input', () {
        final suggestions = service.getIngredientSuggestions('a');
        
        expect(suggestions, isEmpty);
      });

      test('should include category and common units in suggestions', () {
        final suggestions = service.getIngredientSuggestions('chicken');
        
        expect(suggestions, isNotEmpty);
        final chickenSuggestion = suggestions.firstWhere((s) => s.name == 'chicken');
        expect(chickenSuggestion.category, equals('proteins'));
        expect(chickenSuggestion.commonUnits, isNotEmpty);
      });
    });

    group('getAutoCompleteSuggestions', () {
      test('should return ingredient names for auto-complete', () {
        final suggestions = service.getAutoCompleteSuggestions('carr');
        
        expect(suggestions, isNotEmpty);
        expect(suggestions, contains('carrot'));
      });

      test('should limit number of suggestions', () {
        final suggestions = service.getAutoCompleteSuggestions('a');
        
        expect(suggestions.length, lessThanOrEqualTo(10));
      });
    });

    group('standardizeIngredientName', () {
      test('should normalize ingredient names consistently', () {
        expect(
          service.standardizeIngredientName('CHICKEN BREAST'),
          equals(service.standardizeIngredientName('chicken breast')),
        );
        
        expect(
          service.standardizeIngredientName('  Olive Oil  '),
          equals(service.standardizeIngredientName('olive oil')),
        );
      });

      test('should remove special characters', () {
        final normalized = service.standardizeIngredientName('chicken-breast!');
        expect(normalized, equals('chicken breast'));
      });
    });

    group('areIngredientsEquivalent', () {
      test('should detect equivalent ingredients', () {
        expect(
          service.areIngredientsEquivalent('chicken breast', 'Chicken Breast'),
          isTrue,
        );
        
        expect(
          service.areIngredientsEquivalent('olive oil', 'extra virgin olive oil'),
          isTrue,
        );
      });

      test('should detect different ingredients', () {
        expect(
          service.areIngredientsEquivalent('chicken', 'beef'),
          isFalse,
        );
      });
    });

    group('convertUnit', () {
      test('should convert between compatible units', () {
        final result = service.convertUnit(1, 'cup', 'tablespoon', 'milk');
        expect(result, equals(16.0));
      });

      test('should return same quantity for same units', () {
        final result = service.convertUnit(2, 'cup', 'cup', 'flour');
        expect(result, equals(2.0));
      });

      test('should return null for incompatible units', () {
        final result = service.convertUnit(1, 'cup', 'pound', 'water');
        expect(result, isNull);
      });

      test('should handle tablespoon to teaspoon conversion', () {
        final result = service.convertUnit(2, 'tablespoon', 'teaspoon', 'vanilla');
        expect(result, equals(6.0));
      });

      test('should handle pound to ounce conversion', () {
        final result = service.convertUnit(1, 'pound', 'ounce', 'beef');
        expect(result, equals(16.0));
      });
    });

    group('edge cases', () {
      test('should handle ingredients with parentheses', () {
        final ingredient = service.parseIngredient('1 cup flour (all-purpose)');
        expect(ingredient.name, contains('flour'));
        expect(ingredient.quantity, equals(1.0));
      });

      test('should handle ingredients with brand names', () {
        final ingredient = service.parseIngredient('2 tbsp Heinz ketchup');
        expect(ingredient.name, contains('ketchup'));
        expect(ingredient.category, equals('condiments'));
      });

      test('should handle very long ingredient descriptions', () {
        final longDescription = '1 cup organic, free-range, grass-fed, locally-sourced chicken breast, diced';
        final ingredient = service.parseIngredient(longDescription);
        expect(ingredient.name, contains('chicken'));
        expect(ingredient.category, equals('proteins'));
      });

      test('should handle ingredients with preparation methods', () {
        final ingredient = service.parseIngredient('2 cups carrots, diced');
        expect(ingredient.name, contains('carrots'));
        expect(ingredient.category, equals('vegetables'));
      });

      test('should handle temperature specifications', () {
        final ingredient = service.parseIngredient('1 cup warm milk');
        expect(ingredient.name, contains('milk'));
        expect(ingredient.category, equals('dairy'));
      });
    });
  });
}