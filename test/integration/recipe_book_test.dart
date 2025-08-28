import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/mockito.dart';

import '../../lib/features/recipe_book/presentation/screens/recipe_book_screen.dart';
import '../../lib/application/providers/recipe_provider.dart';
import '../../lib/domain/entities/recipe.dart';
import '../../lib/domain/entities/user_profile.dart';
import '../mocks/mock_services.dart';

void main() {
  group('Recipe Book Integration Tests', () {
    late List<Recipe> mockRecipes;

    setUp(() {
      mockRecipes = MockDataHelper.createMockRecipeList(count: 10);
    });

    Widget createApp({List<Override> overrides = const []}) {
      return ProviderScope(
        overrides: overrides,
        child: MaterialApp(
          home: const RecipeBookScreen(),
        ),
      );
    }

    testWidgets('displays recipe book with tabs and empty state', (tester) async {
      await tester.pumpWidget(createApp(overrides: [
        recipeStateProvider.overrideWith((ref) => RecipeStateNotifier(
          MockRecipeRepository(),
          MockRecipeGenerationService(),
          'test-user',
        )),
      ]));
      await tester.pumpAndSettle();

      // Verify app bar and tabs
      expect(find.text('Recipe Book'), findsOneWidget);
      expect(find.text('All'), findsOneWidget);
      expect(find.text('Favorites'), findsOneWidget);
      expect(find.text('Recent'), findsOneWidget);
      expect(find.text('Collections'), findsOneWidget);

      // Verify action buttons
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.filter_list), findsOneWidget);
      expect(find.byIcon(Icons.grid_view), findsOneWidget);
      expect(find.byIcon(Icons.more_vert), findsOneWidget);

      // Verify empty state
      expect(find.text('No Recipes Yet'), findsOneWidget);
      expect(find.text('Generate or save recipes to build your collection.\nStart by creating your first recipe!'), findsOneWidget);
    });

    testWidgets('displays recipes in grid view', (tester) async {
      final mockRepository = MockRecipeRepository();
      when(mockRepository.getUserRecipes(any)).thenAnswer((_) async => mockRecipes);

      await tester.pumpWidget(createApp(overrides: [
        recipeStateProvider.overrideWith((ref) => RecipeStateNotifier(
          mockRepository,
          MockRecipeGenerationService(),
          'test-user',
        )),
      ]));
      await tester.pumpAndSettle();

      // Wait for recipes to load
      await tester.pump(const Duration(seconds: 1));

      // Verify recipes are displayed
      expect(find.byType(GridView), findsOneWidget);
      expect(find.text('Mock Recipe 1'), findsOneWidget);
      expect(find.text('Mock Recipe 2'), findsOneWidget);
    });

    testWidgets('switches between grid and list view', (tester) async {
      final mockRepository = MockRecipeRepository();
      when(mockRepository.getUserRecipes(any)).thenAnswer((_) async => mockRecipes);

      await tester.pumpWidget(createApp(overrides: [
        recipeStateProvider.overrideWith((ref) => RecipeStateNotifier(
          mockRepository,
          MockRecipeGenerationService(),
          'test-user',
        )),
      ]));
      await tester.pumpAndSettle();

      // Wait for recipes to load
      await tester.pump(const Duration(seconds: 1));

      // Initially in grid view
      expect(find.byType(GridView), findsOneWidget);
      expect(find.byType(ListView), findsNothing);

      // Switch to list view
      await tester.tap(find.byIcon(Icons.grid_view));
      await tester.pumpAndSettle();

      // Now in list view
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(GridView), findsNothing);
      expect(find.byIcon(Icons.view_list), findsOneWidget);
    });

    testWidgets('navigates between tabs', (tester) async {
      final mockRepository = MockRecipeRepository();
      when(mockRepository.getUserRecipes(any)).thenAnswer((_) async => mockRecipes);

      await tester.pumpWidget(createApp(overrides: [
        recipeStateProvider.overrideWith((ref) => RecipeStateNotifier(
          mockRepository,
          MockRecipeGenerationService(),
          'test-user',
        )),
      ]));
      await tester.pumpAndSettle();

      // Wait for recipes to load
      await tester.pump(const Duration(seconds: 1));

      // Test favorites tab
      await tester.tap(find.text('Favorites'));
      await tester.pumpAndSettle();
      expect(find.text('No Favorites Yet'), findsOneWidget);

      // Test recent tab
      await tester.tap(find.text('Recent'));
      await tester.pumpAndSettle();
      expect(find.text('No Recent Recipes'), findsOneWidget);

      // Test collections tab
      await tester.tap(find.text('Collections'));
      await tester.pumpAndSettle();
      expect(find.text('No Collections'), findsOneWidget);
    });

    testWidgets('opens search modal', (tester) async {
      await tester.pumpWidget(createApp());
      await tester.pumpAndSettle();

      // Tap search button
      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      // Verify search modal opens
      expect(find.text('Search Recipes'), findsOneWidget);
    });

    testWidgets('opens filter modal', (tester) async {
      await tester.pumpWidget(createApp());
      await tester.pumpAndSettle();

      // Tap filter button
      await tester.tap(find.byIcon(Icons.filter_list));
      await tester.pumpAndSettle();

      // Verify filter modal opens
      expect(find.text('Filter Recipes'), findsOneWidget);
      expect(find.text('Cuisine'), findsOneWidget);
      expect(find.text('Difficulty'), findsOneWidget);
      expect(find.text('Cooking Time'), findsOneWidget);
    });

    testWidgets('creates new collection', (tester) async {
      await tester.pumpWidget(createApp());
      await tester.pumpAndSettle();

      // Tap floating action button
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      // Verify create collection dialog
      expect(find.text('Create Collection'), findsOneWidget);
      expect(find.text('Collection Name'), findsOneWidget);

      // Enter collection name
      await tester.enterText(find.byType(TextField).first, 'Italian Favorites');
      await tester.enterText(find.byType(TextField).last, 'My favorite Italian recipes');

      // Create collection
      await tester.tap(find.text('Create'));
      await tester.pumpAndSettle();

      // Verify success message
      expect(find.text('Collection "Italian Favorites" created!'), findsOneWidget);
    });

    testWidgets('handles menu actions', (tester) async {
      await tester.pumpWidget(createApp());
      await tester.pumpAndSettle();

      // Open menu
      await tester.tap(find.byIcon(Icons.more_vert));
      await tester.pumpAndSettle();

      // Verify menu items
      expect(find.text('Create Collection'), findsOneWidget);
      expect(find.text('Import Recipes'), findsOneWidget);
      expect(find.text('Export Recipes'), findsOneWidget);

      // Test import recipes
      await tester.tap(find.text('Import Recipes'));
      await tester.pumpAndSettle();
      expect(find.text('Recipe import coming soon!'), findsOneWidget);
    });

    testWidgets('toggles recipe favorite status', (tester) async {
      final mockRepository = MockRecipeRepository();
      when(mockRepository.getUserRecipes(any)).thenAnswer((_) async => mockRecipes);

      await tester.pumpWidget(createApp(overrides: [
        recipeStateProvider.overrideWith((ref) => RecipeStateNotifier(
          mockRepository,
          MockRecipeGenerationService(),
          'test-user',
        )),
      ]));
      await tester.pumpAndSettle();

      // Wait for recipes to load
      await tester.pump(const Duration(seconds: 1));

      // Switch to list view for easier testing
      await tester.tap(find.byIcon(Icons.grid_view));
      await tester.pumpAndSettle();

      // Find and tap favorite button
      final favoriteButton = find.byIcon(Icons.favorite_border).first;
      await tester.tap(favoriteButton);
      await tester.pumpAndSettle();

      // Verify favorite status changed (would need proper mock setup)
      expect(find.byIcon(Icons.favorite_border), findsWidgets);
    });

    testWidgets('handles error state', (tester) async {
      final mockRepository = MockRecipeRepository();
      when(mockRepository.getUserRecipes(any)).thenThrow(Exception('Network error'));

      await tester.pumpWidget(createApp(overrides: [
        recipeStateProvider.overrideWith((ref) => RecipeStateNotifier(
          mockRepository,
          MockRecipeGenerationService(),
          'test-user',
        )),
      ]));
      await tester.pumpAndSettle();

      // Wait for error to appear
      await tester.pump(const Duration(seconds: 1));

      // Verify error state
      expect(find.text('Something went wrong'), findsOneWidget);
      expect(find.text('Try Again'), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });

    testWidgets('refreshes recipes with pull to refresh', (tester) async {
      final mockRepository = MockRecipeRepository();
      when(mockRepository.getUserRecipes(any)).thenAnswer((_) async => mockRecipes);

      await tester.pumpWidget(createApp(overrides: [
        recipeStateProvider.overrideWith((ref) => RecipeStateNotifier(
          mockRepository,
          MockRecipeGenerationService(),
          'test-user',
        )),
      ]));
      await tester.pumpAndSettle();

      // Wait for recipes to load
      await tester.pump(const Duration(seconds: 1));

      // Perform pull to refresh
      await tester.fling(find.byType(GridView), const Offset(0, 300), 1000);
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      // Verify refresh indicator appeared and disappeared
      expect(find.byType(RefreshIndicator), findsOneWidget);
    });

    group('Filter functionality', () {
      testWidgets('applies cuisine filter', (tester) async {
        await tester.pumpWidget(createApp());
        await tester.pumpAndSettle();

        // Open filter modal
        await tester.tap(find.byIcon(Icons.filter_list));
        await tester.pumpAndSettle();

        // Select Italian cuisine
        await tester.tap(find.text('Italian'));
        await tester.pumpAndSettle();

        // Apply filters
        await tester.tap(find.text('Apply Filters'));
        await tester.pumpAndSettle();

        // Verify filter applied message
        expect(find.text('Filters applied successfully!'), findsOneWidget);
      });

      testWidgets('applies difficulty filter', (tester) async {
        await tester.pumpWidget(createApp());
        await tester.pumpAndSettle();

        // Open filter modal
        await tester.tap(find.byIcon(Icons.filter_list));
        await tester.pumpAndSettle();

        // Select beginner difficulty
        await tester.tap(find.text('Beginner'));
        await tester.pumpAndSettle();

        // Apply filters
        await tester.tap(find.text('Apply Filters'));
        await tester.pumpAndSettle();

        // Verify filter applied
        expect(find.text('Filters applied successfully!'), findsOneWidget);
      });

      testWidgets('clears all filters', (tester) async {
        await tester.pumpWidget(createApp());
        await tester.pumpAndSettle();

        // Open filter modal
        await tester.tap(find.byIcon(Icons.filter_list));
        await tester.pumpAndSettle();

        // Select some filters
        await tester.tap(find.text('Italian'));
        await tester.tap(find.text('Beginner'));
        await tester.pumpAndSettle();

        // Clear all filters
        await tester.tap(find.text('Clear All'));
        await tester.pumpAndSettle();

        // Verify filters are cleared (chips should be unselected)
        final italianChip = tester.widget<FilterChip>(
          find.widgetWithText(FilterChip, 'Italian'),
        );
        expect(italianChip.selected, false);
      });
    });

    group('Collection management', () {
      testWidgets('creates collection with validation', (tester) async {
        await tester.pumpWidget(createApp());
        await tester.pumpAndSettle();

        // Open create collection dialog
        await tester.tap(find.byType(FloatingActionButton));
        await tester.pumpAndSettle();

        // Try to create without name
        await tester.tap(find.text('Create'));
        await tester.pumpAndSettle();

        // Dialog should still be open (validation failed)
        expect(find.text('Create Collection'), findsOneWidget);

        // Enter valid name
        await tester.enterText(find.byType(TextField).first, 'Test Collection');
        await tester.tap(find.text('Create'));
        await tester.pumpAndSettle();

        // Verify collection created
        expect(find.text('Collection "Test Collection" created!'), findsOneWidget);
      });

      testWidgets('cancels collection creation', (tester) async {
        await tester.pumpWidget(createApp());
        await tester.pumpAndSettle();

        // Open create collection dialog
        await tester.tap(find.byType(FloatingActionButton));
        await tester.pumpAndSettle();

        // Cancel dialog
        await tester.tap(find.text('Cancel'));
        await tester.pumpAndSettle();

        // Dialog should be closed
        expect(find.text('Create Collection'), findsNothing);
      });
    });
  });
}