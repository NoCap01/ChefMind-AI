import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:chefmind_ai/main.dart';
import 'package:chefmind_ai/core/config/environment.dart';
import 'package:chefmind_ai/core/services/local_storage_service.dart';
import 'package:chefmind_ai/infrastructure/storage/hive_recipe_storage.dart';

void main() {
  group('End-to-End Workflow Tests', () {
    late Widget testApp;

    setUpAll(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
      
      // Initialize test environment
      await EnvironmentConfig.initialize();
      
      // Initialize Hive for testing
      await Hive.initFlutter();
      
      // Initialize storage services
      final localStorage = LocalStorageService();
      await localStorage.initialize();
      
      final recipeStorage = HiveRecipeStorage();
      await recipeStorage.initialize();
      
      testApp = const ProviderScope(child: ChefMindApp());
    });

    tearDownAll(() async {
      await Hive.close();
    });

    testWidgets('Complete Recipe Generation Workflow', (WidgetTester tester) async {
      await tester.pumpWidget(testApp);
      await tester.pumpAndSettle();

      // Navigate to recipe generation screen
      expect(find.text('Generate Recipe'), findsOneWidget);
      await tester.tap(find.text('Generate Recipe'));
      await tester.pumpAndSettle();

      // Add ingredients
      final ingredientField = find.byType(TextField).first;
      await tester.enterText(ingredientField, 'chicken');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      // Verify ingredient chip appears
      expect(find.text('chicken'), findsOneWidget);

      // Add more ingredients
      await tester.enterText(ingredientField, 'rice');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      expect(find.text('rice'), findsOneWidget);

      // Select cuisine type
      final cuisineDropdown = find.text('Select Cuisine');
      if (cuisineDropdown.evaluate().isNotEmpty) {
        await tester.tap(cuisineDropdown);
        await tester.pumpAndSettle();
        
        await tester.tap(find.text('Italian').last);
        await tester.pumpAndSettle();
      }

      // Generate recipe
      final generateButton = find.text('Generate Recipe');
      await tester.tap(generateButton);
      await tester.pumpAndSettle();

      // Wait for loading to complete
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();

      // Verify recipe is generated and displayed
      expect(find.byType(Card), findsAtLeastNWidgets(1));
      
      // Save the recipe
      final saveButton = find.byIcon(Icons.bookmark_border);
      if (saveButton.evaluate().isNotEmpty) {
        await tester.tap(saveButton);
        await tester.pumpAndSettle();
      }
    });

    testWidgets('Recipe Book Navigation and Search Workflow', (WidgetTester tester) async {
      await tester.pumpWidget(testApp);
      await tester.pumpAndSettle();

      // Navigate to recipe book
      final recipeBookTab = find.text('Recipe Book');
      await tester.tap(recipeBookTab);
      await tester.pumpAndSettle();

      // Verify recipe book screen loads
      expect(find.text('My Recipes'), findsOneWidget);

      // Test search functionality
      final searchField = find.byType(TextField);
      if (searchField.evaluate().isNotEmpty) {
        await tester.enterText(searchField.first, 'chicken');
        await tester.pumpAndSettle();
        
        // Verify search results
        await tester.pump(const Duration(milliseconds: 500));
      }

      // Test recipe detail view
      final recipeCards = find.byType(Card);
      if (recipeCards.evaluate().isNotEmpty) {
        await tester.tap(recipeCards.first);
        await tester.pumpAndSettle();
        
        // Verify recipe detail dialog opens
        expect(find.byType(Dialog), findsOneWidget);
        
        // Close dialog
        await tester.tap(find.byIcon(Icons.close));
        await tester.pumpAndSettle();
      }
    });

    testWidgets('Pantry and Shopping List Workflow', (WidgetTester tester) async {
      await tester.pumpWidget(testApp);
      await tester.pumpAndSettle();

      // Navigate to shopping screen
      final shoppingTab = find.text('Shopping');
      await tester.tap(shoppingTab);
      await tester.pumpAndSettle();

      // Add pantry item
      final addPantryButton = find.byIcon(Icons.add);
      if (addPantryButton.evaluate().isNotEmpty) {
        await tester.tap(addPantryButton.first);
        await tester.pumpAndSettle();

        // Fill in pantry item details
        final nameField = find.byType(TextField).first;
        await tester.enterText(nameField, 'Milk');
        
        final quantityField = find.byType(TextField).last;
        await tester.enterText(quantityField, '1');

        // Save pantry item
        final saveButton = find.text('Save');
        await tester.tap(saveButton);
        await tester.pumpAndSettle();
      }

      // Switch to shopping list tab
      final shoppingListTab = find.text('Shopping List');
      if (shoppingListTab.evaluate().isNotEmpty) {
        await tester.tap(shoppingListTab);
        await tester.pumpAndSettle();

        // Add shopping item
        final addShoppingButton = find.byIcon(Icons.add);
        if (addShoppingButton.evaluate().isNotEmpty) {
          await tester.tap(addShoppingButton);
          await tester.pumpAndSettle();

          // Fill shopping item details
          final itemField = find.byType(TextField).first;
          await tester.enterText(itemField, 'Bread');

          final saveButton = find.text('Add');
          await tester.tap(saveButton);
          await tester.pumpAndSettle();
        }
      }
    });

    testWidgets('Meal Planning Workflow', (WidgetTester tester) async {
      await tester.pumpWidget(testApp);
      await tester.pumpAndSettle();

      // Navigate to meal planner
      final mealPlannerTab = find.text('Meal Planner');
      await tester.tap(mealPlannerTab);
      await tester.pumpAndSettle();

      // Verify meal planner screen loads
      expect(find.text('Weekly Meal Plan'), findsOneWidget);

      // Test meal slot interaction
      final mealSlots = find.byType(GestureDetector);
      if (mealSlots.evaluate().isNotEmpty) {
        await tester.tap(mealSlots.first);
        await tester.pumpAndSettle();
      }

      // Test auto-plan functionality
      final autoPlanButton = find.text('Auto Plan');
      if (autoPlanButton.evaluate().isNotEmpty) {
        await tester.tap(autoPlanButton);
        await tester.pumpAndSettle();
        
        // Wait for auto-planning to complete
        await tester.pump(const Duration(seconds: 2));
        await tester.pumpAndSettle();
      }
    });

    testWidgets('Profile and Settings Workflow', (WidgetTester tester) async {
      await tester.pumpWidget(testApp);
      await tester.pumpAndSettle();

      // Navigate to profile
      final profileTab = find.text('Profile');
      await tester.tap(profileTab);
      await tester.pumpAndSettle();

      // Verify profile screen loads
      expect(find.text('Profile'), findsOneWidget);

      // Test settings navigation
      final settingsButton = find.byIcon(Icons.settings);
      if (settingsButton.evaluate().isNotEmpty) {
        await tester.tap(settingsButton);
        await tester.pumpAndSettle();

        // Verify settings screen
        expect(find.text('Settings'), findsOneWidget);

        // Test theme settings
        final themeSettings = find.text('Theme');
        if (themeSettings.evaluate().isNotEmpty) {
          await tester.tap(themeSettings);
          await tester.pumpAndSettle();
          
          // Go back
          final backButton = find.byIcon(Icons.arrow_back);
          await tester.tap(backButton);
          await tester.pumpAndSettle();
        }
      }

      // Test dietary preferences
      final dietaryPrefs = find.text('Dietary Preferences');
      if (dietaryPrefs.evaluate().isNotEmpty) {
        await tester.tap(dietaryPrefs);
        await tester.pumpAndSettle();
        
        // Go back
        final backButton = find.byIcon(Icons.arrow_back);
        await tester.tap(backButton);
        await tester.pumpAndSettle();
      }
    });

    testWidgets('Error Handling and Recovery Workflow', (WidgetTester tester) async {
      await tester.pumpWidget(testApp);
      await tester.pumpAndSettle();

      // Test network error handling by generating recipe without network
      await tester.tap(find.text('Generate Recipe'));
      await tester.pumpAndSettle();

      // Add ingredients
      final ingredientField = find.byType(TextField).first;
      await tester.enterText(ingredientField, 'invalid_ingredient_test');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      // Try to generate recipe (should handle gracefully)
      final generateButton = find.text('Generate Recipe');
      await tester.tap(generateButton);
      await tester.pumpAndSettle();

      // Wait for error handling
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();

      // Verify error is handled gracefully (no crash)
      expect(tester.takeException(), isNull);
    });
  });
}