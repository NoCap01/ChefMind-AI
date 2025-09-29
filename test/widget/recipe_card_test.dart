import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chefmind_ai/presentation/widgets/recipe/recipe_card.dart';
import 'package:chefmind_ai/domain/entities/recipe.dart';
import 'package:chefmind_ai/domain/enums/difficulty_level.dart';
import 'package:chefmind_ai/domain/enums/meal_type.dart';

void main() {
  group('RecipeCard Widget Tests', () {
    late Recipe testRecipe;
    late Map<String, dynamic> testRecipeData;

    setUp(() {
      testRecipe = Recipe(
        id: 'test-id',
        title: 'Test Recipe',
        description: 'A delicious test recipe',
        ingredients: [
          const Ingredient(
              name: 'chicken', quantity: 1, unit: 'lb', category: 'protein'),
          const Ingredient(
              name: 'rice', quantity: 2, unit: 'cups', category: 'grains'),
        ],
        instructions: [
          const CookingStep(stepNumber: 1, instruction: 'Cook the chicken'),
          const CookingStep(stepNumber: 2, instruction: 'Prepare the rice'),
        ],
        metadata: const RecipeMetadata(
          prepTime: 15,
          cookTime: 30,
          servings: 4,
          difficulty: DifficultyLevel.medium,
          cuisine: 'italian',
          mealType: MealType.dinner,
        ),
        tags: ['italian', 'dinner'],
        createdAt: DateTime.now(),
        source: 'test',
      );
      testRecipeData = testRecipe.toJson();
    });

    testWidgets('should display recipe title', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RecipeCard(recipe: testRecipeData),
          ),
        ),
      );

      expect(find.text('Test Recipe'), findsOneWidget);
    });

    testWidgets('should display recipe description',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RecipeCard(recipe: testRecipeData),
          ),
        ),
      );

      expect(find.text('A delicious test recipe'), findsOneWidget);
    });

    testWidgets('should display cooking time', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RecipeCard(recipe: testRecipeData),
          ),
        ),
      );

      // Should display total time (prep + cook = 45 minutes)
      expect(find.textContaining('45'), findsOneWidget);
    });

    testWidgets('should display difficulty level', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RecipeCard(recipe: testRecipeData),
          ),
        ),
      );

      expect(find.textContaining('Medium'), findsOneWidget);
    });

    testWidgets('should handle tap events', (WidgetTester tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RecipeCard(
              recipe: testRecipeData,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(RecipeCard));
      expect(tapped, isTrue);
    });

    testWidgets('should display favorite button', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RecipeCard(
              recipe: testRecipeData,
              onFavorite: () {},
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    });

    testWidgets('should show filled favorite icon when isFavorite is true',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RecipeCard(
              recipe: testRecipeData,
              onFavorite: () {},
              isFavorite: true,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.favorite), findsOneWidget);
    });
  });
}
