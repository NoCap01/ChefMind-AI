import 'package:flutter_test/flutter_test.dart';
import 'package:chefmind_ai/infrastructure/services/enhanced_mock_service.dart';
import 'package:chefmind_ai/domain/entities/recipe_request.dart';
import 'package:chefmind_ai/domain/enums/dietary_restriction.dart';
import 'package:chefmind_ai/domain/enums/skill_level.dart';

void main() {
  group('EnhancedMockService', () {
    late EnhancedMockService service;

    setUp(() {
      service = EnhancedMockService();
    });

    test('should be available', () async {
      final isAvailable = await service.isServiceAvailable();
      expect(isAvailable, isTrue);
    });

    test('should have correct service name', () {
      expect(service.serviceName, 'EnhancedMock');
    });

    test('should have lowest priority', () {
      expect(service.priority, 99);
    });

    group('Recipe Generation', () {
      test('should generate recipe with basic ingredients', () async {
        const request = RecipeRequest(
          ingredients: ['chicken', 'rice', 'vegetables'],
          servings: 4,
        );

        final recipe = await service.generateRecipe(request);

        expect(recipe.id, isNotEmpty);
        expect(recipe.title, isNotEmpty);
        expect(recipe.description, isNotEmpty);
        expect(recipe.ingredients, isNotEmpty);
        expect(recipe.instructions, isNotEmpty);
        expect(recipe.source, 'enhancedmock');
        expect(recipe.metadata.servings, 4);
      });

      test('should generate recipe with cuisine type', () async {
        const request = RecipeRequest(
          ingredients: ['chicken', 'tomatoes'],
          cuisineType: 'italian',
          servings: 2,
        );

        final recipe = await service.generateRecipe(request);

        expect(recipe.title.toLowerCase(), contains('italian'));
        expect(recipe.metadata.cuisine, 'italian');
        expect(recipe.tags, contains('italian'));

        // Should contain Italian-specific ingredients
        final ingredientNames =
            recipe.ingredients.map((i) => i.name.toLowerCase()).join(' ');
        expect(
            ingredientNames,
            anyOf([
              contains('basil'),
              contains('oregano'),
              contains('parmesan'),
              contains('olive oil'),
            ]));
      });

      test('should generate recipe with meal type', () async {
        const request = RecipeRequest(
          ingredients: ['eggs', 'bread'],
          mealType: 'breakfast',
          servings: 2,
        );

        final recipe = await service.generateRecipe(request);

        expect(recipe.tags, contains('breakfast'));
        expect(recipe.metadata.mealType?.name, 'breakfast');
        expect(recipe.metadata.prepTime,
            lessThan(20)); // Breakfast should be quick
      });

      test('should respect dietary restrictions - vegetarian', () async {
        const request = RecipeRequest(
          ingredients: ['chicken', 'vegetables'],
          dietaryRestrictions: [DietaryRestriction.vegetarian],
          servings: 4,
        );

        final recipe = await service.generateRecipe(request);

        final ingredientNames =
            recipe.ingredients.map((i) => i.name.toLowerCase()).join(' ');

        // Should not contain meat
        expect(ingredientNames, isNot(contains('chicken')));
        expect(ingredientNames, isNot(contains('beef')));
        expect(ingredientNames, isNot(contains('pork')));

        // Should contain vegetarian protein alternatives
        expect(
            ingredientNames,
            anyOf([
              contains('tofu'),
              contains('tempeh'),
              contains('beans'),
              contains('lentils'),
            ]));

        expect(recipe.tags, contains('vegetarian'));
      });

      test('should respect dietary restrictions - vegan', () async {
        const request = RecipeRequest(
          ingredients: ['chicken', 'milk', 'cheese'],
          dietaryRestrictions: [DietaryRestriction.vegan],
          servings: 4,
        );

        final recipe = await service.generateRecipe(request);

        final ingredientNames =
            recipe.ingredients.map((i) => i.name.toLowerCase()).join(' ');

        // Should not contain animal products
        expect(ingredientNames, isNot(contains('chicken')));
        expect(ingredientNames, isNot(contains('milk')));
        expect(ingredientNames, isNot(contains('cheese')));
        expect(ingredientNames, isNot(contains('butter')));
        expect(ingredientNames, isNot(contains('eggs')));

        expect(recipe.tags, contains('vegan'));
      });

      test('should respect dietary restrictions - gluten free', () async {
        const request = RecipeRequest(
          ingredients: ['wheat flour', 'bread', 'pasta'],
          dietaryRestrictions: [DietaryRestriction.glutenFree],
          servings: 4,
        );

        final recipe = await service.generateRecipe(request);

        final ingredientNames =
            recipe.ingredients.map((i) => i.name.toLowerCase()).join(' ');

        // Should not contain gluten
        expect(ingredientNames, isNot(contains('wheat flour')));
        expect(ingredientNames, isNot(contains('bread')));
        expect(ingredientNames, isNot(contains('pasta')));

        expect(recipe.tags, contains('gluten-free'));
      });

      test('should adjust difficulty based on skill level', () async {
        const noviceRequest = RecipeRequest(
          ingredients: ['chicken', 'rice'],
          skillLevel: SkillLevel.novice,
          servings: 4,
        );

        const advancedRequest = RecipeRequest(
          ingredients: ['chicken', 'rice'],
          skillLevel: SkillLevel.advanced,
          servings: 4,
        );

        final noviceRecipe = await service.generateRecipe(noviceRequest);
        final advancedRecipe = await service.generateRecipe(advancedRequest);

        expect(noviceRecipe.metadata.difficulty.index,
            lessThanOrEqualTo(advancedRecipe.metadata.difficulty.index));
      });

      test('should generate realistic nutrition information', () async {
        const request = RecipeRequest(
          ingredients: ['chicken', 'rice', 'vegetables'],
          servings: 4,
        );

        final recipe = await service.generateRecipe(request);

        expect(recipe.nutrition, isNotNull);
        expect(recipe.nutrition!.calories, greaterThan(0));
        expect(recipe.nutrition!.protein, greaterThan(0));
        expect(recipe.nutrition!.carbs, greaterThan(0));
        expect(recipe.nutrition!.fat, greaterThan(0));

        // Reasonable calorie range for a meal
        expect(recipe.nutrition!.calories, inInclusiveRange(200, 800));
      });

      test('should generate cooking instructions with proper steps', () async {
        const request = RecipeRequest(
          ingredients: ['chicken', 'onions', 'garlic'],
          cuisineType: 'italian',
          servings: 4,
        );

        final recipe = await service.generateRecipe(request);

        expect(recipe.instructions, isNotEmpty);
        expect(recipe.instructions.length, greaterThanOrEqualTo(3));

        // Steps should be numbered sequentially
        for (int i = 0; i < recipe.instructions.length; i++) {
          expect(recipe.instructions[i].stepNumber, i + 1);
        }

        // First step should be prep
        expect(recipe.instructions.first.instruction.toLowerCase(),
            contains('prepare'));

        // Should have cooking durations
        final totalDuration = recipe.instructions
            .where((step) => step.duration != null)
            .map((step) => step.duration!)
            .fold(0, (sum, duration) => sum + duration);
        expect(totalDuration, greaterThan(0));
      });

      test('should generate cuisine-specific cooking techniques', () async {
        const asianRequest = RecipeRequest(
          ingredients: ['chicken', 'vegetables'],
          cuisineType: 'asian',
          servings: 4,
        );

        final recipe = await service.generateRecipe(asianRequest);

        final instructionText = recipe.instructions
            .map((step) => step.instruction.toLowerCase())
            .join(' ');

        expect(
            instructionText,
            anyOf([
              contains('wok'),
              contains('stir-fry'),
              contains('high heat'),
            ]));
      });

      test('should include equipment recommendations', () async {
        const request = RecipeRequest(
          ingredients: ['chicken', 'vegetables'],
          cuisineType: 'asian',
          skillLevel: SkillLevel.intermediate,
          servings: 4,
        );

        final recipe = await service.generateRecipe(request);

        expect(recipe.metadata.equipment, isNotNull);
        expect(recipe.metadata.equipment!, isNotEmpty);
        expect(recipe.metadata.equipment!, contains('knife'));
      });

      test('should generate appropriate tags', () async {
        const request = RecipeRequest(
          ingredients: ['chicken', 'rice'],
          cuisineType: 'asian',
          mealType: 'dinner',
          dietaryRestrictions: [DietaryRestriction.glutenFree],
          servings: 4,
        );

        final recipe = await service.generateRecipe(request);

        expect(recipe.tags, contains('asian'));
        expect(recipe.tags, contains('dinner'));
        expect(recipe.tags, contains('gluten-free'));
        expect(recipe.tags, contains('chicken'));
        expect(recipe.tags, contains('rice'));
      });

      test('should handle multiple dietary restrictions', () async {
        const request = RecipeRequest(
          ingredients: ['chicken', 'milk', 'wheat'],
          dietaryRestrictions: [
            DietaryRestriction.vegan,
            DietaryRestriction.glutenFree,
          ],
          servings: 4,
        );

        final recipe = await service.generateRecipe(request);

        final ingredientNames =
            recipe.ingredients.map((i) => i.name.toLowerCase()).join(' ');

        // Should respect both restrictions
        expect(ingredientNames, isNot(contains('chicken')));
        expect(ingredientNames, isNot(contains('milk')));
        expect(ingredientNames, isNot(contains('wheat')));

        expect(recipe.tags, contains('vegan'));
        expect(recipe.tags, contains('gluten-free'));
      });
    });

    group('Edge Cases', () {
      test('should handle empty ingredients list', () async {
        const request = RecipeRequest(
          ingredients: [],
          servings: 4,
        );

        final recipe = await service.generateRecipe(request);

        expect(
            recipe.ingredients, isNotEmpty); // Should add default ingredients
        expect(recipe.title, isNotEmpty);
        expect(recipe.instructions, isNotEmpty);
      });

      test('should handle single ingredient', () async {
        const request = RecipeRequest(
          ingredients: ['chicken'],
          servings: 1,
        );

        final recipe = await service.generateRecipe(request);

        expect(recipe.ingredients, isNotEmpty);
        expect(recipe.metadata.servings, 1);
        expect(recipe.title.toLowerCase(), contains('chicken'));
      });

      test('should handle large serving size', () async {
        const request = RecipeRequest(
          ingredients: ['chicken', 'rice'],
          servings: 12,
        );

        final recipe = await service.generateRecipe(request);

        expect(recipe.metadata.servings, 12);

        // Quantities should scale appropriately
        final chickenIngredient = recipe.ingredients
            .firstWhere((i) => i.name.toLowerCase().contains('chicken'));
        expect(
            chickenIngredient.quantity, greaterThan(2)); // Should be scaled up
      });
    });
  });
}
