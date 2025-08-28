import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chefmind_ai/shared/widgets/recipe_card.dart';
import 'package:chefmind_ai/core/theme/app_theme.dart';

void main() {
  group('RecipeCard', () {
    testWidgets('should display recipe information correctly', (tester) async {
      const testRecipe = RecipeCard(
        id: 'test-recipe',
        title: 'Delicious Pasta',
        imageUrl: 'https://example.com/pasta.jpg',
        subtitle: 'Italian cuisine',
        cookingTime: Duration(minutes: 30),
        difficulty: 'medium',
        rating: 4.5,
        servings: 4,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: testRecipe,
          ),
        ),
      );

      // Verify recipe information is displayed
      expect(find.text('Delicious Pasta'), findsOneWidget);
      expect(find.text('Italian cuisine'), findsOneWidget);
      expect(find.text('30m'), findsOneWidget);
      expect(find.text('MEDIUM'), findsOneWidget);
      expect(find.text('4.5'), findsOneWidget);
      expect(find.text('4'), findsOneWidget);
    });

    testWidgets('should handle tap interactions', (tester) async {
      bool tapped = false;
      
      final testRecipe = RecipeCard(
        id: 'test-recipe',
        title: 'Test Recipe',
        imageUrl: 'https://example.com/test.jpg',
        onTap: () => tapped = true,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: testRecipe,
          ),
        ),
      );

      await tester.tap(find.byType(RecipeCard));
      expect(tapped, isTrue);
    });

    testWidgets('should handle favorite toggle', (tester) async {
      bool isFavorite = false;
      
      final testRecipe = RecipeCard(
        id: 'test-recipe',
        title: 'Test Recipe',
        imageUrl: 'https://example.com/test.jpg',
        isFavorite: isFavorite,
        onFavoriteToggle: () => isFavorite = !isFavorite,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: testRecipe,
          ),
        ),
      );

      // Find and tap the favorite button
      final favoriteButton = find.byIcon(Icons.favorite_border);
      expect(favoriteButton, findsOneWidget);
      
      await tester.tap(favoriteButton);
      expect(isFavorite, isTrue);
    });

    testWidgets('should display rating stars correctly', (tester) async {
      const testRecipe = RecipeCard(
        id: 'test-recipe',
        title: 'Test Recipe',
        imageUrl: 'https://example.com/test.jpg',
        rating: 3.5,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: testRecipe,
          ),
        ),
      );

      // Should have 3 full stars, 1 half star, and 1 empty star
      expect(find.byIcon(Icons.star), findsNWidgets(3));
      expect(find.byIcon(Icons.star_half), findsOneWidget);
      expect(find.byIcon(Icons.star_border), findsOneWidget);
    });

    testWidgets('should format cooking time correctly', (tester) async {
      const testRecipe1 = RecipeCard(
        id: 'test-recipe-1',
        title: 'Quick Recipe',
        imageUrl: 'https://example.com/test.jpg',
        cookingTime: Duration(minutes: 15),
      );

      const testRecipe2 = RecipeCard(
        id: 'test-recipe-2',
        title: 'Long Recipe',
        imageUrl: 'https://example.com/test.jpg',
        cookingTime: Duration(hours: 2, minutes: 30),
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: Column(
              children: [testRecipe1, testRecipe2],
            ),
          ),
        ),
      );

      expect(find.text('15m'), findsOneWidget);
      expect(find.text('2h 30m'), findsOneWidget);
    });

    testWidgets('should apply hero animation', (tester) async {
      const testRecipe = RecipeCard(
        id: 'test-recipe',
        title: 'Test Recipe',
        imageUrl: 'https://example.com/test.jpg',
        heroTag: 'custom-hero-tag',
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: testRecipe,
          ),
        ),
      );

      expect(find.byType(Hero), findsOneWidget);
      final hero = tester.widget<Hero>(find.byType(Hero));
      expect(hero.tag, equals('custom-hero-tag'));
    });

    testWidgets('should handle missing optional properties', (tester) async {
      const testRecipe = RecipeCard(
        id: 'test-recipe',
        title: 'Minimal Recipe',
        imageUrl: 'https://example.com/test.jpg',
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: testRecipe,
          ),
        ),
      );

      expect(find.text('Minimal Recipe'), findsOneWidget);
      expect(find.byIcon(Icons.favorite_border), findsNothing);
      expect(find.byIcon(Icons.star), findsNothing);
    });
  });

  group('RecipeCardCompact', () {
    testWidgets('should display compact recipe information', (tester) async {
      const testRecipe = RecipeCardCompact(
        id: 'test-recipe',
        title: 'Compact Recipe',
        imageUrl: 'https://example.com/test.jpg',
        subtitle: 'Quick meal',
        cookingTime: Duration(minutes: 20),
        difficulty: 'easy',
        rating: 4.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: testRecipe,
          ),
        ),
      );

      expect(find.text('Compact Recipe'), findsOneWidget);
      expect(find.text('Quick meal'), findsOneWidget);
      expect(find.text('20m'), findsOneWidget);
      expect(find.text('EASY'), findsOneWidget);
      expect(find.text('4.0'), findsOneWidget);
    });

    testWidgets('should handle tap interactions in compact mode', (tester) async {
      bool tapped = false;
      
      final testRecipe = RecipeCardCompact(
        id: 'test-recipe',
        title: 'Test Recipe',
        imageUrl: 'https://example.com/test.jpg',
        onTap: () => tapped = true,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: testRecipe,
          ),
        ),
      );

      await tester.tap(find.byType(RecipeCardCompact));
      expect(tapped, isTrue);
    });

    testWidgets('should display favorite button in compact mode', (tester) async {
      bool isFavorite = false;
      
      final testRecipe = RecipeCardCompact(
        id: 'test-recipe',
        title: 'Test Recipe',
        imageUrl: 'https://example.com/test.jpg',
        isFavorite: isFavorite,
        onFavoriteToggle: () => isFavorite = !isFavorite,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: testRecipe,
          ),
        ),
      );

      expect(find.byType(IconButton), findsOneWidget);
      expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    });
  });

  group('RecipeCard Accessibility', () {
    testWidgets('should be accessible', (tester) async {
      const testRecipe = RecipeCard(
        id: 'test-recipe',
        title: 'Accessible Recipe',
        imageUrl: 'https://example.com/test.jpg',
        subtitle: 'Healthy meal',
        cookingTime: Duration(minutes: 25),
        difficulty: 'medium',
        rating: 4.2,
        servings: 2,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: testRecipe,
          ),
        ),
      );

      // Verify semantic information is available
      expect(find.text('Accessible Recipe'), findsOneWidget);
      expect(find.text('Healthy meal'), findsOneWidget);
      
      // Check that interactive elements are properly sized
      final cardWidget = tester.getSize(find.byType(RecipeCard));
      expect(cardWidget.height, greaterThan(120)); // Minimum touch target
    });

    testWidgets('should support dark theme', (tester) async {
      const testRecipe = RecipeCard(
        id: 'test-recipe',
        title: 'Dark Theme Recipe',
        imageUrl: 'https://example.com/test.jpg',
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.darkTheme,
          home: Scaffold(
            body: testRecipe,
          ),
        ),
      );

      expect(find.text('Dark Theme Recipe'), findsOneWidget);
      
      // Verify the card adapts to dark theme
      final material = tester.widget<Material>(
        find.descendant(
          of: find.byType(RecipeCard),
          matching: find.byType(Material),
        ).first,
      );
      
      expect(material.color, isNotNull);
    });
  });

  group('RecipeCard Performance', () {
    testWidgets('should handle animation efficiently', (tester) async {
      const testRecipe = RecipeCard(
        id: 'test-recipe',
        title: 'Animated Recipe',
        imageUrl: 'https://example.com/test.jpg',
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: testRecipe,
          ),
        ),
      );

      // Simulate tap down and up to trigger animations
      await tester.press(find.byType(RecipeCard));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      
      await tester.pumpAndSettle();
      
      // Verify the widget is still rendered correctly after animation
      expect(find.text('Animated Recipe'), findsOneWidget);
    });

    testWidgets('should handle image loading states', (tester) async {
      const testRecipe = RecipeCard(
        id: 'test-recipe',
        title: 'Image Test Recipe',
        imageUrl: 'invalid-url',
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: testRecipe,
          ),
        ),
      );

      // Should show error widget when image fails to load
      await tester.pump();
      expect(find.byIcon(Icons.restaurant), findsOneWidget);
    });
  });
}