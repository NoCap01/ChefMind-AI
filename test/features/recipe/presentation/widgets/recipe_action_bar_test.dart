import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:chefmind_ai_app/features/recipe/presentation/widgets/recipe_action_bar.dart';
import 'package:chefmind_ai_app/domain/entities/recipe.dart';
import 'package:chefmind_ai_app/domain/entities/ingredient.dart';
import 'package:chefmind_ai_app/domain/entities/instruction.dart';

void main() {
  group('RecipeActionBar', () {
    late Recipe testRecipe;
    int currentServings = 4;
    bool cookingStarted = false;

    setUp(() {
      testRecipe = Recipe(
        id: '1',
        title: 'Test Recipe',
        description: 'A delicious test recipe',
        ingredients: [
          Ingredient(
            id: '1',
            name: 'Test Ingredient',
            quantity: 1.0,
            unit: 'cup',
          ),
        ],
        instructions: [
          Instruction(
            stepNumber: 1,
            instruction: 'Test instruction',
          ),
        ],
        prepTime: const Duration(minutes: 15),
        cookingTime: const Duration(minutes: 30),
        servings: 4,
        difficulty: DifficultyLevel.intermediate,
        rating: 4.5,
        createdAt: DateTime.now(),
      );
      currentServings = 4;
      cookingStarted = false;
    });

    Widget createWidget() {
      return MaterialApp(
        home: Scaffold(
          body: RecipeActionBar(
            recipe: testRecipe,
            servings: currentServings,
            onServingsChanged: (newServings) {
              currentServings = newServings;
            },
            onStartCooking: () {
              cookingStarted = true;
            },
          ),
        ),
      );
    }

    testWidgets('displays servings adjuster', (tester) async {
      await tester.pumpWidget(createWidget());

      expect(find.text('Servings:'), findsOneWidget);
      expect(find.text('4'), findsOneWidget);
      expect(find.byIcon(Icons.remove), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('can increase servings', (tester) async {
      await tester.pumpWidget(createWidget());

      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      expect(currentServings, 5);
    });

    testWidgets('can decrease servings', (tester) async {
      currentServings = 5;
      await tester.pumpWidget(createWidget());

      await tester.tap(find.byIcon(Icons.remove));
      await tester.pump();

      expect(currentServings, 4);
    });

    testWidgets('cannot decrease servings below 1', (tester) async {
      currentServings = 1;
      await tester.pumpWidget(createWidget());

      final removeButton = find.byIcon(Icons.remove);
      expect(tester.widget<IconButton>(removeButton).onPressed, isNull);
    });

    testWidgets('cannot increase servings above 20', (tester) async {
      currentServings = 20;
      await tester.pumpWidget(createWidget());

      final addButton = find.byIcon(Icons.add);
      expect(tester.widget<IconButton>(addButton).onPressed, isNull);
    });

    testWidgets('displays action buttons', (tester) async {
      await tester.pumpWidget(createWidget());

      expect(find.text('Scale Recipe'), findsOneWidget);
      expect(find.text('Start Cooking'), findsOneWidget);
      expect(find.byIcon(Icons.calculate), findsOneWidget);
      expect(find.byIcon(Icons.play_arrow), findsOneWidget);
    });

    testWidgets('can start cooking', (tester) async {
      await tester.pumpWidget(createWidget());

      await tester.tap(find.text('Start Cooking'));
      await tester.pump();

      expect(cookingStarted, isTrue);
    });

    testWidgets('shows scaling info when servings differ from original', (tester) async {
      currentServings = 8;
      await tester.pumpWidget(createWidget());

      expect(find.textContaining('Recipe scaled from 4 to 8 servings'), findsOneWidget);
      expect(find.textContaining('2.0x'), findsOneWidget);
    });

    testWidgets('does not show scaling info when servings match original', (tester) async {
      currentServings = 4;
      await tester.pumpWidget(createWidget());

      expect(find.textContaining('Recipe scaled'), findsNothing);
    });

    testWidgets('shows scaling dialog when scale recipe button is tapped', (tester) async {
      currentServings = 6;
      await tester.pumpWidget(createWidget());

      await tester.tap(find.text('Scale Recipe'));
      await tester.pumpAndSettle();

      expect(find.text('Recipe Scaling'), findsOneWidget);
      expect(find.textContaining('scaled from 4 to 6 servings'), findsOneWidget);
      expect(find.textContaining('Scaling factor: 1.50x'), findsOneWidget);
    });

    testWidgets('displays scaling warning in dialog', (tester) async {
      currentServings = 12;
      await tester.pumpWidget(createWidget());

      await tester.tap(find.text('Scale Recipe'));
      await tester.pumpAndSettle();

      expect(find.textContaining('Cooking times may need adjustment'), findsOneWidget);
    });

    testWidgets('can close scaling dialog', (tester) async {
      currentServings = 6;
      await tester.pumpWidget(createWidget());

      await tester.tap(find.text('Scale Recipe'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Got it'));
      await tester.pumpAndSettle();

      expect(find.text('Recipe Scaling'), findsNothing);
    });
  });
}