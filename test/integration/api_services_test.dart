import 'package:flutter_test/flutter_test.dart';
import 'package:chefmind_ai/infrastructure/services/enhanced_openai_service.dart';
import 'package:chefmind_ai/infrastructure/services/hugging_face_service.dart';
import 'package:chefmind_ai/infrastructure/services/cascading_ai_service.dart';
import 'package:chefmind_ai/infrastructure/services/enhanced_mock_service.dart';
import 'package:chefmind_ai/domain/entities/recipe_request.dart';
import 'package:chefmind_ai/domain/enums/dietary_restriction.dart';

void main() {
  group('API Services Integration Tests', () {
    group('CascadingAIService Integration', () {
      test('should fallback through services correctly', () async {
        // Create a cascading service with mock as fallback
        final mockService = EnhancedMockService();
        final cascadingService = CascadingAIService([mockService]);

        const request = RecipeRequest(
          ingredients: ['chicken', 'rice', 'vegetables'],
          cuisineType: 'italian',
          servings: 4,
        );

        final recipe = await cascadingService.generateRecipe(request);

        expect(recipe.id, isNotEmpty);
        expect(recipe.title, isNotEmpty);
        expect(recipe.ingredients, isNotEmpty);
        expect(recipe.instructions, isNotEmpty);
        expect(recipe.source, 'enhancedmock');
        expect(recipe.metadata.cuisine, 'italian');
      });

      test('should handle service availability checking', () async {
        final mockService = EnhancedMockService();
        final cascadingService = CascadingAIService([mockService]);

        final isAvailable = await cascadingService.isServiceAvailable();
        expect(isAvailable, isTrue);
      });

      test('should work with multiple dietary restrictions', () async {
        final mockService = EnhancedMockService();
        final cascadingService = CascadingAIService([mockService]);

        const request = RecipeRequest(
          ingredients: ['chicken', 'milk', 'wheat'],
          dietaryRestrictions: [
            DietaryRestriction.vegan,
            DietaryRestriction.glutenFree,
          ],
          servings: 4,
        );

        final recipe = await cascadingService.generateRecipe(request);

        expect(recipe.tags, contains('vegan'));
        expect(recipe.tags, contains('gluten-free'));

        final ingredientNames =
            recipe.ingredients.map((i) => i.name.toLowerCase()).join(' ');
        expect(ingredientNames, isNot(contains('chicken')));
        expect(ingredientNames, isNot(contains('milk')));
        expect(ingredientNames, isNot(contains('wheat')));
      });
    });

    group('Service Response Validation', () {
      test('should validate recipe structure from mock service', () async {
        final service = EnhancedMockService();
        const request = RecipeRequest(
          ingredients: ['chicken', 'vegetables'],
          servings: 4,
        );

        final recipe = await service.generateRecipe(request);

        // Validate required fields
        expect(recipe.id, isNotEmpty);
        expect(recipe.title, isNotEmpty);
        expect(recipe.description, isNotEmpty);
        expect(recipe.ingredients, isNotEmpty);
        expect(recipe.instructions, isNotEmpty);
        expect(recipe.metadata, isNotNull);
        expect(recipe.tags, isNotEmpty);
        expect(recipe.createdAt, isNotNull);
        expect(recipe.source, isNotEmpty);

        // Validate metadata
        expect(recipe.metadata.prepTime, greaterThan(0));
        expect(recipe.metadata.cookTime, greaterThan(0));
        expect(recipe.metadata.servings, 4);
        expect(recipe.metadata.difficulty, isNotNull);

        // Validate ingredients
        for (final ingredient in recipe.ingredients) {
          expect(ingredient.name, isNotEmpty);
          expect(ingredient.quantity, greaterThan(0));
          expect(ingredient.unit, isNotEmpty);
        }

        // Validate instructions
        for (int i = 0; i < recipe.instructions.length; i++) {
          final step = recipe.instructions[i];
          expect(step.stepNumber, i + 1);
          expect(step.instruction, isNotEmpty);
        }

        // Validate nutrition if present
        if (recipe.nutrition != null) {
          expect(recipe.nutrition!.calories, greaterThan(0));
          expect(recipe.nutrition!.protein, greaterThanOrEqualTo(0));
          expect(recipe.nutrition!.carbs, greaterThanOrEqualTo(0));
          expect(recipe.nutrition!.fat, greaterThanOrEqualTo(0));
        }
      });

      test('should handle various cuisine types consistently', () async {
        final service = EnhancedMockService();
        final cuisines = ['italian', 'mexican', 'asian', 'indian', 'french'];

        for (final cuisine in cuisines) {
          final request = RecipeRequest(
            ingredients: ['chicken', 'vegetables'],
            cuisineType: cuisine,
            servings: 4,
          );

          final recipe = await service.generateRecipe(request);

          expect(recipe.metadata.cuisine, cuisine);
          expect(recipe.tags, contains(cuisine));
          expect(
              recipe.title.toLowerCase(),
              anyOf([
                contains(cuisine),
                contains('chicken'),
              ]));
        }
      });

      test('should handle various meal types consistently', () async {
        final service = EnhancedMockService();
        final mealTypes = ['breakfast', 'lunch', 'dinner', 'snack', 'dessert'];

        for (final mealType in mealTypes) {
          final request = RecipeRequest(
            ingredients: ['eggs', 'flour'],
            mealType: mealType,
            servings: 4,
          );

          final recipe = await service.generateRecipe(request);

          expect(recipe.tags, contains(mealType));
          if (recipe.metadata.mealType != null) {
            expect(recipe.metadata.mealType!.name, mealType);
          }
        }
      });
    });

    group('Error Handling Integration', () {
      test('should handle network timeouts gracefully', () async {
        // This test would normally test actual network timeouts
        // For now, we'll test that the mock service doesn't throw unexpected errors
        final service = EnhancedMockService();
        const request = RecipeRequest(
          ingredients: ['chicken'],
          servings: 4,
        );

        expect(() => service.generateRecipe(request), returnsNormally);
      });

      test('should handle malformed requests gracefully', () async {
        final service = EnhancedMockService();

        // Test with empty ingredients
        const emptyRequest = RecipeRequest(
          ingredients: [],
          servings: 4,
        );

        final recipe = await service.generateRecipe(emptyRequest);
        expect(
            recipe.ingredients, isNotEmpty); // Should add default ingredients

        // Test with zero servings
        const zeroServingsRequest = RecipeRequest(
          ingredients: ['chicken'],
          servings: 0,
        );

        expect(
            () => service.generateRecipe(zeroServingsRequest), returnsNormally);
      });
    });

    group('Performance Tests', () {
      test('should generate recipe within reasonable time', () async {
        final service = EnhancedMockService();
        const request = RecipeRequest(
          ingredients: ['chicken', 'rice', 'vegetables'],
          servings: 4,
        );

        final stopwatch = Stopwatch()..start();
        await service.generateRecipe(request);
        stopwatch.stop();

        // Should complete within 5 seconds (including simulated delay)
        expect(stopwatch.elapsedMilliseconds, lessThan(5000));
      });

      test('should handle multiple concurrent requests', () async {
        final service = EnhancedMockService();
        final requests = List.generate(
            5,
            (index) => RecipeRequest(
                  ingredients: ['ingredient$index'],
                  servings: 4,
                ));

        final futures =
            requests.map((request) => service.generateRecipe(request));
        final recipes = await Future.wait(futures);

        expect(recipes.length, 5);
        for (final recipe in recipes) {
          expect(recipe.id, isNotEmpty);
          expect(recipe.title, isNotEmpty);
        }
      });
    });

    group('Data Consistency Tests', () {
      test('should generate consistent results for same input', () async {
        final service = EnhancedMockService();
        const request = RecipeRequest(
          ingredients: ['chicken', 'rice'],
          cuisineType: 'italian',
          servings: 4,
        );

        final recipe1 = await service.generateRecipe(request);
        final recipe2 = await service.generateRecipe(request);

        // While content may vary, structure should be consistent
        expect(recipe1.metadata.servings, recipe2.metadata.servings);
        expect(recipe1.metadata.cuisine, recipe2.metadata.cuisine);
        expect(recipe1.source, recipe2.source);
        expect(
            recipe1.tags.contains('italian'), recipe2.tags.contains('italian'));
      });

      test('should scale ingredients proportionally', () async {
        final service = EnhancedMockService();
        const baseRequest = RecipeRequest(
          ingredients: ['chicken', 'rice'],
          servings: 4,
        );

        const doubleRequest = RecipeRequest(
          ingredients: ['chicken', 'rice'],
          servings: 8,
        );

        final baseRecipe = await service.generateRecipe(baseRequest);
        final doubleRecipe = await service.generateRecipe(doubleRequest);

        // Find common ingredients and check scaling
        for (final baseIngredient in baseRecipe.ingredients) {
          final doubleIngredient = doubleRecipe.ingredients
              .where((i) =>
                  i.name.toLowerCase() == baseIngredient.name.toLowerCase())
              .firstOrNull;

          if (doubleIngredient != null) {
            // Double servings should have roughly double the quantity
            final ratio = doubleIngredient.quantity / baseIngredient.quantity;
            expect(ratio, inInclusiveRange(1.5, 2.5)); // Allow some variance
          }
        }
      });
    });
  });
}
