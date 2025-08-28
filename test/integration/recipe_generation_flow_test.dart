import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/mockito.dart';

import '../../lib/features/home/presentation/screens/home_screen.dart';
import '../../lib/application/providers/recipe_provider.dart';
import '../../lib/domain/entities/recipe.dart';
import '../../lib/domain/entities/user_profile.dart';
import '../../lib/domain/services/recipe_generation_service.dart';
import '../mocks/mock_services.dart';

void main() {
  group('Recipe Generation Flow Integration Tests', () {
    late MockRecipeGenerationService mockRecipeGenerationService;
    late MockUserPreferences mockUserPreferences;

    setUp(() {
      mockRecipeGenerationService = MockRecipeGenerationService();
      mockUserPreferences = MockUserPreferences();
    });

    Widget createApp() {
      return ProviderScope(
        overrides: [
          recipeGenerationServiceProvider.overrideWithValue(mockRecipeGenerationService),
          userPreferencesProvider.overrideWithValue(mockUserPreferences),
        ],
        child: MaterialApp(
          home: const HomeScreen(),
        ),
      );
    }

    testWidgets('complete recipe generation workflow', (tester) async {
      // Setup mock responses
      final mockRecipe = Recipe(
        id: 'test-recipe-1',
        title: 'Chicken Fried Rice',
        description: 'A delicious and easy chicken fried rice recipe',
        ingredients: [
          const Ingredient(name: 'Chicken', quantity: 1, unit: 'lb'),
          const Ingredient(name: 'Rice', quantity: 2, unit: 'cups'),
          const Ingredient(name: 'Eggs', quantity: 2, unit: 'pieces'),
        ],
        instructions: [
          const CookingStep(stepNumber: 1, instruction: 'Cook rice according to package instructions'),
          const CookingStep(stepNumber: 2, instruction: 'Cook chicken in a large pan'),
          const CookingStep(stepNumber: 3, instruction: 'Add rice and eggs, stir fry until combined'),
        ],
        cookingTime: const Duration(minutes: 20),
        prepTime: const Duration(minutes: 10),
        difficulty: DifficultyLevel.intermediate,
        servings: 4,
        tags: ['asian', 'main-course', 'chicken'],
        nutrition: const NutritionInfo(
          calories: 450,
          protein: 35,
          carbs: 45,
          fat: 12,
          fiber: 2,
          sugar: 3,
          sodium: 800,
        ),
        tips: ['Use day-old rice for best results'],
        rating: 0.0,
        createdAt: DateTime.now(),
      );

      when(mockRecipeGenerationService.generateRecipe(
        any,
        any,
        cuisineType: anyNamed('cuisineType'),
        maxCookingTime: anyNamed('maxCookingTime'),
        maxDifficulty: anyNamed('maxDifficulty'),
        servings: anyNamed('servings'),
        excludeIngredients: anyNamed('excludeIngredients'),
      )).thenAnswer((_) async => mockRecipe);

      await tester.pumpWidget(createApp());
      await tester.pumpAndSettle();

      // Verify home screen is displayed
      expect(find.text('ChefMind AI'), findsOneWidget);
      expect(find.text('Add Ingredients'), findsOneWidget);

      // Step 1: Add ingredients using the ingredient input
      await tester.enterText(find.byType(TextField), 'chicken');
      await tester.pump();
      await tester.tap(find.byIcon(Icons.add_circle));
      await tester.pump();

      await tester.enterText(find.byType(TextField), 'rice');
      await tester.pump();
      await tester.tap(find.byIcon(Icons.add_circle));
      await tester.pump();

      await tester.enterText(find.byType(TextField), 'eggs');
      await tester.pump();
      await tester.tap(find.byIcon(Icons.add_circle));
      await tester.pump();

      // Verify ingredients are added
      expect(find.text('Chicken'), findsOneWidget);
      expect(find.text('Rice'), findsOneWidget);
      expect(find.text('Eggs'), findsOneWidget);

      // Step 2: Generate recipe
      final generateButton = find.text('Generate Recipe');
      expect(generateButton, findsOneWidget);
      
      await tester.tap(generateButton);
      await tester.pump();

      // Verify loading state
      expect(find.text('Generating...'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Wait for recipe generation to complete
      await tester.pumpAndSettle();

      // Verify recipe generation service was called
      verify(mockRecipeGenerationService.generateRecipe(
        ['Chicken', 'Rice', 'Eggs'],
        mockUserPreferences,
        servings: 4,
      )).called(1);

      // Step 3: Verify recipe is displayed
      expect(find.text('Chicken Fried Rice'), findsOneWidget);
      expect(find.text('A delicious and easy chicken fried rice recipe'), findsOneWidget);
      expect(find.text('Recipe generated successfully!'), findsOneWidget);

      // Verify recipe tabs are present
      expect(find.text('Ingredients'), findsOneWidget);
      expect(find.text('Instructions'), findsOneWidget);
      expect(find.text('Details'), findsOneWidget);

      // Step 4: Test ingredients tab
      await tester.tap(find.text('Ingredients'));
      await tester.pumpAndSettle();

      expect(find.text('Chicken'), findsAtLeastNWidgets(1));
      expect(find.text('1 lb'), findsOneWidget);
      expect(find.text('Rice'), findsAtLeastNWidgets(1));
      expect(find.text('2 cups'), findsOneWidget);

      // Step 5: Test instructions tab
      await tester.tap(find.text('Instructions'));
      await tester.pumpAndSettle();

      expect(find.text('Cook rice according to package instructions'), findsOneWidget);
      expect(find.text('Cook chicken in a large pan'), findsOneWidget);
      expect(find.text('Add rice and eggs, stir fry until combined'), findsOneWidget);

      // Step 6: Test details tab
      await tester.tap(find.text('Details'));
      await tester.pumpAndSettle();

      expect(find.text('Nutrition Information'), findsOneWidget);
      expect(find.text('450'), findsOneWidget); // Calories
      expect(find.text('35'), findsOneWidget); // Protein

      // Step 7: Test recipe actions
      await tester.tap(find.text('Save Recipe'));
      await tester.pumpAndSettle();

      // Verify save confirmation
      expect(find.text('Recipe saved to your collection!'), findsOneWidget);

      // Test rating functionality
      await tester.tap(find.text('Rate'));
      await tester.pumpAndSettle();

      expect(find.text('Rate this Recipe'), findsOneWidget);
      expect(find.text('How would you rate this recipe?'), findsOneWidget);

      // Rate the recipe with 4 stars
      final stars = find.byIcon(Icons.star_border);
      await tester.tap(stars.at(3)); // 4th star (0-indexed)
      await tester.pump();

      await tester.tap(find.text('Rate'));
      await tester.pumpAndSettle();

      expect(find.text('Recipe rated 4.0 stars!'), findsOneWidget);
    });

    testWidgets('recipe generation error handling', (tester) async {
      // Setup mock to throw an error
      when(mockRecipeGenerationService.generateRecipe(
        any,
        any,
        cuisineType: anyNamed('cuisineType'),
        maxCookingTime: anyNamed('maxCookingTime'),
        maxDifficulty: anyNamed('maxDifficulty'),
        servings: anyNamed('servings'),
        excludeIngredients: anyNamed('excludeIngredients'),
      )).thenThrow(Exception('API Error'));

      await tester.pumpWidget(createApp());
      await tester.pumpAndSettle();

      // Add ingredients
      await tester.enterText(find.byType(TextField), 'chicken');
      await tester.pump();
      await tester.tap(find.byIcon(Icons.add_circle));
      await tester.pump();

      // Try to generate recipe
      await tester.tap(find.text('Generate Recipe'));
      await tester.pump();

      // Wait for error to appear
      await tester.pumpAndSettle();

      // Verify error is displayed
      expect(find.text('Recipe Generation Failed'), findsOneWidget);
      expect(find.text('Failed to generate recipe: Exception: API Error'), findsOneWidget);
      expect(find.text('Try Again'), findsOneWidget);

      // Test retry functionality
      await tester.tap(find.text('Try Again'));
      await tester.pump();

      // Verify error is cleared
      expect(find.text('Recipe Generation Failed'), findsNothing);
    });

    testWidgets('empty ingredients validation', (tester) async {
      await tester.pumpWidget(createApp());
      await tester.pumpAndSettle();

      // Try to generate recipe without ingredients
      final generateButton = find.text('Generate Recipe');
      expect(tester.widget<ElevatedButton>(generateButton.first).onPressed, isNull);

      // Verify button is disabled
      await tester.tap(generateButton);
      await tester.pump();

      // Verify no API call was made
      verifyNever(mockRecipeGenerationService.generateRecipe(
        any,
        any,
        cuisineType: anyNamed('cuisineType'),
        maxCookingTime: anyNamed('maxCookingTime'),
        maxDifficulty: anyNamed('maxDifficulty'),
        servings: anyNamed('servings'),
        excludeIngredients: anyNamed('excludeIngredients'),
      ));
    });

    testWidgets('ingredient management workflow', (tester) async {
      await tester.pumpWidget(createApp());
      await tester.pumpAndSettle();

      // Add ingredient via text input
      await tester.enterText(find.byType(TextField), 'chicken');
      await tester.pump();
      await tester.tap(find.byIcon(Icons.add_circle));
      await tester.pump();

      expect(find.text('Chicken'), findsOneWidget);

      // Add ingredient via quick suggestions
      await tester.tap(find.text('Rice'));
      await tester.pump();

      expect(find.text('Rice'), findsAtLeastNWidgets(1));

      // Remove ingredient
      final chipDeleteIcon = find.descendant(
        of: find.byType(Chip).first,
        matching: find.byIcon(Icons.close),
      );
      
      await tester.tap(chipDeleteIcon);
      await tester.pump();

      // Verify ingredient is removed (should only find it in quick suggestions now)
      expect(find.text('Chicken'), findsOneWidget); // Only in quick suggestions
    });

    testWidgets('recipe sharing workflow', (tester) async {
      // Setup mock recipe
      final mockRecipe = Recipe(
        id: 'test-recipe-1',
        title: 'Test Recipe',
        description: 'A test recipe',
        ingredients: [const Ingredient(name: 'Test', quantity: 1, unit: 'cup')],
        instructions: [const CookingStep(stepNumber: 1, instruction: 'Test instruction')],
        cookingTime: const Duration(minutes: 30),
        prepTime: const Duration(minutes: 10),
        difficulty: DifficultyLevel.beginner,
        servings: 2,
        tags: ['test'],
        nutrition: const NutritionInfo(calories: 100, protein: 5, carbs: 10, fat: 2, fiber: 1, sugar: 1, sodium: 200),
        tips: [],
        rating: 0.0,
        createdAt: DateTime.now(),
      );

      when(mockRecipeGenerationService.generateRecipe(
        any,
        any,
        cuisineType: anyNamed('cuisineType'),
        maxCookingTime: anyNamed('maxCookingTime'),
        maxDifficulty: anyNamed('maxDifficulty'),
        servings: anyNamed('servings'),
        excludeIngredients: anyNamed('excludeIngredients'),
      )).thenAnswer((_) async => mockRecipe);

      await tester.pumpWidget(createApp());
      await tester.pumpAndSettle();

      // Generate a recipe first
      await tester.enterText(find.byType(TextField), 'test');
      await tester.pump();
      await tester.tap(find.byIcon(Icons.add_circle));
      await tester.pump();

      await tester.tap(find.text('Generate Recipe'));
      await tester.pumpAndSettle();

      // Test share functionality
      await tester.tap(find.text('Share'));
      await tester.pumpAndSettle();

      expect(find.text('Recipe sharing coming soon!'), findsOneWidget);
    });

    testWidgets('recipe display tabs navigation', (tester) async {
      // Setup mock recipe with comprehensive data
      final mockRecipe = Recipe(
        id: 'test-recipe-1',
        title: 'Comprehensive Test Recipe',
        description: 'A recipe with all features',
        ingredients: [
          const Ingredient(name: 'Ingredient 1', quantity: 1, unit: 'cup'),
          const Ingredient(name: 'Ingredient 2', quantity: 2, unit: 'tbsp', isOptional: true),
        ],
        instructions: [
          const CookingStep(stepNumber: 1, instruction: 'First step', duration: Duration(minutes: 5)),
          const CookingStep(stepNumber: 2, instruction: 'Second step'),
        ],
        cookingTime: const Duration(minutes: 25),
        prepTime: const Duration(minutes: 15),
        difficulty: DifficultyLevel.advanced,
        servings: 6,
        tags: ['test', 'comprehensive'],
        nutrition: const NutritionInfo(
          calories: 350,
          protein: 20,
          carbs: 30,
          fat: 15,
          fiber: 5,
          sugar: 8,
          sodium: 600,
        ),
        tips: ['Tip 1', 'Tip 2'],
        rating: 4.5,
        createdAt: DateTime.now(),
      );

      when(mockRecipeGenerationService.generateRecipe(
        any,
        any,
        cuisineType: anyNamed('cuisineType'),
        maxCookingTime: anyNamed('maxCookingTime'),
        maxDifficulty: anyNamed('maxDifficulty'),
        servings: anyNamed('servings'),
        excludeIngredients: anyNamed('excludeIngredients'),
      )).thenAnswer((_) async => mockRecipe);

      await tester.pumpWidget(createApp());
      await tester.pumpAndSettle();

      // Generate recipe
      await tester.enterText(find.byType(TextField), 'test');
      await tester.pump();
      await tester.tap(find.byIcon(Icons.add_circle));
      await tester.pump();

      await tester.tap(find.text('Generate Recipe'));
      await tester.pumpAndSettle();

      // Test ingredients tab
      await tester.tap(find.text('Ingredients'));
      await tester.pumpAndSettle();

      expect(find.text('Ingredient 1'), findsOneWidget);
      expect(find.text('1 cup'), findsOneWidget);
      expect(find.text('Optional'), findsOneWidget);

      // Test instructions tab
      await tester.tap(find.text('Instructions'));
      await tester.pumpAndSettle();

      expect(find.text('First step'), findsOneWidget);
      expect(find.text('5 min'), findsOneWidget);
      expect(find.text('Second step'), findsOneWidget);

      // Test details tab
      await tester.tap(find.text('Details'));
      await tester.pumpAndSettle();

      expect(find.text('Nutrition Information'), findsOneWidget);
      expect(find.text('350'), findsOneWidget); // Calories
      expect(find.text('Tags'), findsOneWidget);
      expect(find.text('test'), findsOneWidget);
      expect(find.text('Tips & Tricks'), findsOneWidget);
      expect(find.text('Tip 1'), findsOneWidget);
    });
  });
}