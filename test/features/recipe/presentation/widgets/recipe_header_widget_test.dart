import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:chefmind_ai_app/features/recipe/presentation/widgets/recipe_header_widget.dart';
import 'package:chefmind_ai_app/domain/entities/recipe.dart';
import 'package:chefmind_ai_app/domain/entities/ingredient.dart';
import 'package:chefmind_ai_app/domain/entities/instruction.dart';

void main() {
  group('RecipeHeaderWidget', () {
    late Recipe testRecipe;

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
        imageUrl: 'https://example.com/image.jpg',
        createdAt: DateTime.now(),
      );
    });

    Widget createWidget({bool isExpanded = true}) {
      return MaterialApp(
        home: Scaffold(
          body: RecipeHeaderWidget(
            recipe: testRecipe,
            isExpanded: isExpanded,
          ),
        ),
      );
    }

    testWidgets('displays recipe title and description', (tester) async {
      await tester.pumpWidget(createWidget());

      expect(find.text('Test Recipe'), findsOneWidget);
      expect(find.text('A delicious test recipe'), findsOneWidget);
    });

    testWidgets('displays recipe metadata', (tester) async {
      await tester.pumpWidget(createWidget());

      expect(find.text('45 min'), findsOneWidget); // prep + cook time
      expect(find.text('4 servings'), findsOneWidget);
      expect(find.text('4.5'), findsOneWidget); // rating
    });

    testWidgets('displays difficulty badge', (tester) async {
      await tester.pumpWidget(createWidget());

      expect(find.text('Intermediate'), findsOneWidget);
    });

    testWidgets('shows/hides content based on isExpanded', (tester) async {
      // Test expanded state
      await tester.pumpWidget(createWidget(isExpanded: true));
      await tester.pump();

      final expandedOpacity = tester.widget<AnimatedOpacity>(
        find.byType(AnimatedOpacity),
      );
      expect(expandedOpacity.opacity, 1.0);

      // Test collapsed state
      await tester.pumpWidget(createWidget(isExpanded: false));
      await tester.pump();

      final collapsedOpacity = tester.widget<AnimatedOpacity>(
        find.byType(AnimatedOpacity),
      );
      expect(collapsedOpacity.opacity, 0.0);
    });

    testWidgets('displays placeholder when no image URL', (tester) async {
      final recipeWithoutImage = testRecipe.copyWith(imageUrl: null);
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RecipeHeaderWidget(
              recipe: recipeWithoutImage,
              isExpanded: true,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.restaurant), findsOneWidget);
    });

    testWidgets('displays different colors for different difficulty levels', (tester) async {
      final beginnerRecipe = testRecipe.copyWith(difficulty: DifficultyLevel.beginner);
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RecipeHeaderWidget(
              recipe: beginnerRecipe,
              isExpanded: true,
            ),
          ),
        ),
      );

      expect(find.text('Beginner'), findsOneWidget);
    });

    testWidgets('displays metadata chips with correct icons', (tester) async {
      await tester.pumpWidget(createWidget());

      expect(find.byIcon(Icons.schedule), findsOneWidget);
      expect(find.byIcon(Icons.people), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
    });
  });
}