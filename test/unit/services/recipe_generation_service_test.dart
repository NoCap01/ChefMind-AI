import 'package:flutter_test/flutter_test.dart';
import 'package:chefmind_ai/services/recipe_generation_service.dart';
import 'package:chefmind_ai/domain/entities/recipe_request.dart';
import 'package:chefmind_ai/domain/enums/dietary_restriction.dart';
import 'package:chefmind_ai/domain/enums/skill_level.dart';

void main() {
  group('RecipeGenerationService', () {
    late RecipeGenerationService service;

    setUp(() {
      service = RecipeGenerationService();
    });

    test('should generate recipe with basic request', () async {
      const request = RecipeRequest(
        ingredients: ['chicken', 'rice', 'vegetables'],
        servings: 4,
      );

      final recipeData = await service.generateRecipe(
        ingredients: request.ingredients,
        cuisineType: request.cuisineType,
        mealType: request.mealType,
        servings: request.servings,
      );

      expect(recipeData['id'], isNotEmpty);
      expect(recipeData['title'], isNotEmpty);
      expect(recipeData['description'], isNotEmpty);
      expect(recipeData['ingredients'], isNotEmpty);
      expect(recipeData['instructions'], isNotEmpty);
      expect(recipeData['metadata'], isNotNull);
    });

    test('should handle cuisine preferences', () async {
      const request = RecipeRequest(
        ingredients: ['chicken', 'tomatoes'],
        cuisineType: 'italian',
        servings: 2,
      );

      final recipeData = await service.generateRecipe(
        ingredients: request.ingredients,
        cuisineType: request.cuisineType,
        mealType: request.mealType,
        servings: request.servings,
      );

      expect(recipeData['metadata']['cuisine'], 'italian');
      expect(recipeData['tags'], contains('italian'));
    });

    test('should handle meal type preferences', () async {
      const request = RecipeRequest(
        ingredients: ['eggs', 'bread'],
        mealType: 'breakfast',
        servings: 2,
      );

      final recipeData = await service.generateRecipe(
        ingredients: request.ingredients,
        cuisineType: request.cuisineType,
        mealType: request.mealType,
        servings: request.servings,
      );

      expect(recipeData['metadata']['mealType'], 'breakfast');
      expect(recipeData['tags'], contains('breakfast'));
    });

    test('should respect dietary restrictions', () async {
      const request = RecipeRequest(
        ingredients: ['chicken', 'milk'],
        dietaryRestrictions: [DietaryRestriction.vegan],
        servings: 4,
      );

      final recipeData = await service.generateRecipe(
        ingredients: request.ingredients,
        cuisineType: request.cuisineType,
        mealType: request.mealType,
        servings: request.servings,
      );

      expect(recipeData['tags'], contains('vegan'));

      // Should not contain animal products
      final ingredientNames = (recipeData['ingredients'] as List)
          .map((i) => i['name'].toString().toLowerCase())
          .join(' ');
      expect(ingredientNames, isNot(contains('chicken')));
      expect(ingredientNames, isNot(contains('milk')));
    });

    test('should handle skill level preferences', () async {
      const beginnerRequest = RecipeRequest(
        ingredients: ['pasta', 'tomatoes'],
        skillLevel: SkillLevel.beginner,
        servings: 4,
      );

      const advancedRequest = RecipeRequest(
        ingredients: ['pasta', 'tomatoes'],
        skillLevel: SkillLevel.advanced,
        servings: 4,
      );

      final beginnerRecipeData = await service.generateRecipe(
        ingredients: beginnerRequest.ingredients,
        cuisineType: beginnerRequest.cuisineType,
        mealType: beginnerRequest.mealType,
        servings: beginnerRequest.servings,
      );
      final advancedRecipeData = await service.generateRecipe(
        ingredients: advancedRequest.ingredients,
        cuisineType: advancedRequest.cuisineType,
        mealType: advancedRequest.mealType,
        servings: advancedRequest.servings,
      );

      // Beginner recipes should be easier
      expect(beginnerRecipeData['metadata']['difficulty'], equals('easy'));
    });

    test('should handle cooking time constraints', () async {
      const request = RecipeRequest(
        ingredients: ['chicken', 'vegetables'],
        maxCookingTime: 30,
        servings: 4,
      );

      final recipeData = await service.generateRecipe(
        ingredients: request.ingredients,
        cuisineType: request.cuisineType,
        mealType: request.mealType,
        servings: request.servings,
      );

      final totalTime = recipeData['metadata']['prepTime'] +
          recipeData['metadata']['cookTime'];
      expect(totalTime, lessThanOrEqualTo(30));
    });

    test('should handle allergies', () async {
      const request = RecipeRequest(
        ingredients: ['chicken', 'peanuts', 'milk'],
        allergies: ['peanuts', 'dairy'],
        servings: 4,
      );

      final recipeData = await service.generateRecipe(
        ingredients: request.ingredients,
        cuisineType: request.cuisineType,
        mealType: request.mealType,
        servings: request.servings,
      );

      final ingredientNames = (recipeData['ingredients'] as List)
          .map((i) => i['name'].toString().toLowerCase())
          .join(' ');
      expect(ingredientNames, isNot(contains('peanuts')));
      expect(ingredientNames, isNot(contains('milk')));
    });

    test('should handle disliked ingredients', () async {
      const request = RecipeRequest(
        ingredients: ['chicken', 'mushrooms', 'onions'],
        dislikedIngredients: ['mushrooms'],
        servings: 4,
      );

      final recipeData = await service.generateRecipe(
        ingredients: request.ingredients,
        cuisineType: request.cuisineType,
        mealType: request.mealType,
        servings: request.servings,
      );

      final ingredientNames = (recipeData['ingredients'] as List)
          .map((i) => i['name'].toString().toLowerCase())
          .join(' ');
      expect(ingredientNames, isNot(contains('mushrooms')));
    });

    test('should generate valid nutrition information', () async {
      const request = RecipeRequest(
        ingredients: ['chicken', 'rice', 'vegetables'],
        servings: 4,
      );

      final recipeData = await service.generateRecipe(
        ingredients: request.ingredients,
        cuisineType: request.cuisineType,
        mealType: request.mealType,
        servings: request.servings,
      );

      expect(recipeData['nutrition'], isNotNull);
      expect(recipeData['nutrition']['calories'], greaterThan(0));
      expect(recipeData['nutrition']['protein'], greaterThan(0));
      expect(recipeData['nutrition']['carbs'], greaterThan(0));
      expect(recipeData['nutrition']['fat'], greaterThan(0));
    });

    test('should generate proper cooking instructions', () async {
      const request = RecipeRequest(
        ingredients: ['chicken', 'onions', 'garlic'],
        servings: 4,
      );

      final recipeData = await service.generateRecipe(
        ingredients: request.ingredients,
        cuisineType: request.cuisineType,
        mealType: request.mealType,
        servings: request.servings,
      );

      expect(recipeData['instructions'], isNotEmpty);
      expect(
          (recipeData['instructions'] as List).length, greaterThanOrEqualTo(3));

      // Steps should be numbered properly
      final instructions = recipeData['instructions'] as List;
      for (int i = 0; i < instructions.length; i++) {
        expect(instructions[i]['stepNumber'], i + 1);
        expect(instructions[i]['instruction'], isNotEmpty);
      }
    });

    test('should handle empty ingredients gracefully', () async {
      const request = RecipeRequest(
        ingredients: [],
        servings: 4,
      );

      final recipeData = await service.generateRecipe(
        ingredients: request.ingredients,
        cuisineType: request.cuisineType,
        mealType: request.mealType,
        servings: request.servings,
      );

      expect(recipeData['ingredients'],
          isNotEmpty); // Should add default ingredients
      expect(recipeData['instructions'], isNotEmpty);
    });

    test('should scale ingredients for different serving sizes', () async {
      const smallRequest = RecipeRequest(
        ingredients: ['chicken', 'rice'],
        servings: 2,
      );

      const largeRequest = RecipeRequest(
        ingredients: ['chicken', 'rice'],
        servings: 8,
      );

      final smallRecipeData = await service.generateRecipe(
        ingredients: smallRequest.ingredients,
        cuisineType: smallRequest.cuisineType,
        mealType: smallRequest.mealType,
        servings: smallRequest.servings,
      );
      final largeRecipeData = await service.generateRecipe(
        ingredients: largeRequest.ingredients,
        cuisineType: largeRequest.cuisineType,
        mealType: largeRequest.mealType,
        servings: largeRequest.servings,
      );

      // Find chicken ingredient in both recipes
      final smallIngredients = smallRecipeData['ingredients'] as List;
      final largeIngredients = largeRecipeData['ingredients'] as List;
      final smallChicken = smallIngredients.firstWhere(
          (i) => i['name'].toString().toLowerCase().contains('chicken'));
      final largeChicken = largeIngredients.firstWhere(
          (i) => i['name'].toString().toLowerCase().contains('chicken'));

      // Large recipe should have more chicken
      expect(largeChicken['quantity'], greaterThan(smallChicken['quantity']));
    });
  });
}
