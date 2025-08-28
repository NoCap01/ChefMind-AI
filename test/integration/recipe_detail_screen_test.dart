import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/mockito.dart';

import 'package:chefmind_ai_app/features/recipe/presentation/screens/recipe_detail_screen.dart';
import 'package:chefmind_ai_app/domain/entities/recipe.dart';
import 'package:chefmind_ai_app/domain/entities/ingredient.dart';
import 'package:chefmind_ai_app/domain/entities/instruction.dart';
import 'package:chefmind_ai_app/domain/entities/nutrition.dart';
import 'package:chefmind_ai_app/application/providers/recipe_provider.dart';

import '../mocks/mock_services.dart';

void main() {
  group('RecipeDetailScreen Integration Tests', () {
    late Recipe testRecipe;
    late MockRecipeRepository mockRecipeRepository;

    setUp(() {
      mockRecipeRepository = MockRecipeRepository();
      
      testRecipe = Recipe(
        id: '1',
        title: 'Delicious Pasta',
        description: 'A wonderful pasta dish with fresh ingredients',
        ingredients: [
          Ingredient(
            id: '1',
            name: 'Pasta',
            quantity: 200,
            unit: 'g',
          ),
          Ingredient(
            id: '2',
            name: 'Tomato Sauce',
            quantity: 1,
            unit: 'cup',
          ),
          Ingredient(
            id: '3',
            name: 'Parmesan Cheese',
            quantity: 50,
            unit: 'g',
            isOptional: true,
          ),
        ],
        instructions: [
          Instruction(
            stepNumber: 1,
            instruction: 'Boil water in a large pot',
            duration: const Duration(minutes: 5),
            equipment: ['Large pot', 'Stove'],
          ),
          Instruction(
            stepNumber: 2,
            instruction: 'Add pasta to boiling water',
            duration: const Duration(minutes: 8),
          ),
          Instruction(
            stepNumber: 3,
            instruction: 'Heat tomato sauce in a pan',
            duration: const Duration(minutes: 3),
            equipment: ['Pan'],
          ),
          Instruction(
            stepNumber: 4,
            instruction: 'Combine pasta with sauce and serve',
          ),
        ],
        prepTime: const Duration(minutes: 10),
        cookingTime: const Duration(minutes: 20),
        servings: 4,
        difficulty: DifficultyLevel.intermediate,
        rating: 4.5,
        reviewCount: 25,
        imageUrl: 'https://example.com/pasta.jpg',
        nutrition: Nutrition(
          calories: 450,
          protein: 15.0,
          carbohydrates: 65.0,
          fat: 12.0,
          fiber: 3.0,
          sugar: 8.0,
          sodium: 800,
          cholesterol: 25,
        ),
        createdAt: DateTime.now(),
        isFavorite: false,
      );

      when(mockRecipeRepository.getRecipeById('1'))
          .thenAnswer((_) async => testRecipe);
    });

    Widget createApp() {
      return ProviderScope(
        overrides: [
          recipeRepositoryProvider.overrideWithValue(mockRecipeRepository),
        ],
        child: MaterialApp(
          home: const RecipeDetailScreen(recipeId: '1'),
        ),
      );
    }

    testWidgets('displays recipe header with all information', (tester) async {
      await tester.pumpWidget(createApp());
      await tester.pumpAndSettle();

      // Check recipe title and description
      expect(find.text('Delicious Pasta'), findsOneWidget);
      expect(find.text('A wonderful pasta dish with fresh ingredients'), findsOneWidget);
      
      // Check metadata
      expect(find.text('30 min'), findsOneWidget); // prep + cook time
      expect(find.text('4 servings'), findsOneWidget);
      expect(find.text('4.5'), findsOneWidget);
      expect(find.text('Intermediate'), findsOneWidget);
    });

    testWidgets('displays action bar with servings adjuster', (tester) async {
      await tester.pumpWidget(createApp());
      await tester.pumpAndSettle();

      expect(find.text('Servings:'), findsOneWidget);
      expect(find.text('4'), findsOneWidget);
      expect(find.text('Scale Recipe'), findsOneWidget);
      expect(find.text('Start Cooking'), findsOneWidget);
    });

    testWidgets('can adjust servings and shows scaling info', (tester) async {
      await tester.pumpWidget(createApp());
      await tester.pumpAndSettle();

      // Increase servings
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      // Should show scaling info
      expect(find.textContaining('Recipe scaled from 4 to 5 servings'), findsOneWidget);
      expect(find.textContaining('1.2x'), findsOneWidget);
    });

    testWidgets('displays ingredients tab with scaled quantities', (tester) async {
      await tester.pumpWidget(createApp());
      await tester.pumpAndSettle();

      // Increase servings to 8 (double)
      await tester.tap(find.byIcon(Icons.add));
      await tester.tap(find.byIcon(Icons.add));
      await tester.tap(find.byIcon(Icons.add));
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      // Check ingredients tab
      expect(find.text('Ingredients'), findsAtLeastNWidget(1));
      
      // Check scaled quantities (should be doubled)
      expect(find.text('Pasta'), findsOneWidget);
      expect(find.text('400 g'), findsOneWidget); // 200g * 2
      expect(find.text('Tomato Sauce'), findsOneWidget);
      expect(find.text('2 cup'), findsOneWidget); // 1 cup * 2
    });

    testWidgets('can check off ingredients', (tester) async {
      await tester.pumpWidget(createApp());
      await tester.pumpAndSettle();

      // Find and tap the first ingredient checkbox
      final checkboxes = find.byType(Checkbox);
      expect(checkboxes, findsAtLeastNWidget(1));
      
      await tester.tap(checkboxes.first);
      await tester.pumpAndSettle();

      // Progress should update
      expect(find.textContaining('1/3'), findsOneWidget);
    });

    testWidgets('displays instructions tab with step-by-step guide', (tester) async {
      await tester.pumpWidget(createApp());
      await tester.pumpAndSettle();

      // Switch to instructions tab
      await tester.tap(find.text('Instructions'));
      await tester.pumpAndSettle();

      // Check all instructions are displayed
      expect(find.text('Boil water in a large pot'), findsOneWidget);
      expect(find.text('Add pasta to boiling water'), findsOneWidget);
      expect(find.text('Heat tomato sauce in a pan'), findsOneWidget);
      expect(find.text('Combine pasta with sauce and serve'), findsOneWidget);

      // Check step numbers
      expect(find.text('1'), findsOneWidget);
      expect(find.text('2'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
      expect(find.text('4'), findsOneWidget);
    });

    testWidgets('can start timers for timed steps', (tester) async {
      await tester.pumpWidget(createApp());
      await tester.pumpAndSettle();

      // Switch to instructions tab
      await tester.tap(find.text('Instructions'));
      await tester.pumpAndSettle();

      // Find timer button for first step (5 minutes)
      expect(find.textContaining('Start 5m Timer'), findsOneWidget);
      
      // Start the timer
      await tester.tap(find.textContaining('Start 5m Timer'));
      await tester.pumpAndSettle();

      // Should show pause button
      expect(find.text('Pause'), findsOneWidget);
    });

    testWidgets('displays nutrition tab with detailed information', (tester) async {
      await tester.pumpWidget(createApp());
      await tester.pumpAndSettle();

      // Switch to nutrition tab
      await tester.tap(find.text('Nutrition'));
      await tester.pumpAndSettle();

      // Check nutrition information
      expect(find.text('Nutrition Information'), findsOneWidget);
      expect(find.textContaining('450 kcal'), findsOneWidget); // calories
      expect(find.textContaining('15.0g'), findsOneWidget); // protein
      expect(find.textContaining('65.0g'), findsOneWidget); // carbs
      expect(find.textContaining('12.0g'), findsOneWidget); // fat
    });

    testWidgets('displays reviews tab with rating system', (tester) async {
      await tester.pumpWidget(createApp());
      await tester.pumpAndSettle();

      // Switch to reviews tab
      await tester.tap(find.text('Reviews'));
      await tester.pumpAndSettle();

      // Check rating display
      expect(find.text('4.5'), findsOneWidget);
      expect(find.textContaining('Based on 25 reviews'), findsOneWidget);
      expect(find.text('Rate this Recipe'), findsOneWidget);
    });

    testWidgets('can enter cooking mode', (tester) async {
      await tester.pumpWidget(createApp());
      await tester.pumpAndSettle();

      // Tap start cooking button
      await tester.tap(find.text('Start Cooking'));
      await tester.pumpAndSettle();

      // Should enter cooking mode
      expect(find.text('Cooking Mode'), findsOneWidget);
      expect(find.text('1/4'), findsOneWidget); // step indicator
    });

    testWidgets('can navigate through cooking mode steps', (tester) async {
      await tester.pumpWidget(createApp());
      await tester.pumpAndSettle();

      // Enter cooking mode
      await tester.tap(find.text('Start Cooking'));
      await tester.pumpAndSettle();

      // Check first step
      expect(find.text('Boil water in a large pot'), findsOneWidget);
      
      // Go to next step
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();

      // Check second step
      expect(find.text('Add pasta to boiling water'), findsOneWidget);
      expect(find.text('2/4'), findsOneWidget);
    });

    testWidgets('can exit cooking mode', (tester) async {
      await tester.pumpWidget(createApp());
      await tester.pumpAndSettle();

      // Enter cooking mode
      await tester.tap(find.text('Start Cooking'));
      await tester.pumpAndSettle();

      // Exit cooking mode
      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      // Confirm exit
      await tester.tap(find.text('Exit'));
      await tester.pumpAndSettle();

      // Should be back to normal view
      expect(find.text('Cooking Mode'), findsNothing);
      expect(find.text('Start Cooking'), findsOneWidget);
    });

    testWidgets('can share recipe', (tester) async {
      await tester.pumpWidget(createApp());
      await tester.pumpAndSettle();

      // Tap share button
      await tester.tap(find.byIcon(Icons.share));
      await tester.pumpAndSettle();

      // Note: In a real test, we would verify that the share functionality was called
      // For now, we just verify the button exists and is tappable
    });

    testWidgets('can toggle favorite status', (tester) async {
      await tester.pumpWidget(createApp());
      await tester.pumpAndSettle();

      // Initially not favorite
      expect(find.byIcon(Icons.favorite_border), findsOneWidget);
      
      // Tap favorite button
      await tester.tap(find.byIcon(Icons.favorite_border));
      await tester.pumpAndSettle();

      // Should show snackbar
      expect(find.textContaining('Added to favorites'), findsOneWidget);
    });

    testWidgets('shows recipe not found when recipe does not exist', (tester) async {
      when(mockRecipeRepository.getRecipeById('nonexistent'))
          .thenAnswer((_) async => null);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            recipeRepositoryProvider.overrideWithValue(mockRecipeRepository),
          ],
          child: const MaterialApp(
            home: RecipeDetailScreen(recipeId: 'nonexistent'),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Recipe not found'), findsOneWidget);
    });
  });
}