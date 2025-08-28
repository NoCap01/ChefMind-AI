import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chefmind_ai/shared/widgets/ingredient_chip.dart';
import 'package:chefmind_ai/core/theme/app_theme.dart';

void main() {
  group('IngredientChip', () {
    testWidgets('should display ingredient information correctly', (tester) async {
      const testChip = IngredientChip(
        label: 'Tomatoes',
        quantity: '2',
        unit: 'cups',
        category: 'vegetable',
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: testChip,
          ),
        ),
      );

      expect(find.text('Tomatoes'), findsOneWidget);
      expect(find.text('2cups'), findsOneWidget);
    });

    testWidgets('should handle selection state changes', (tester) async {
      bool isSelected = false;
      
      final testChip = IngredientChip(
        label: 'Onions',
        isSelected: isSelected,
        onTap: () => isSelected = !isSelected,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return IngredientChip(
                  label: 'Onions',
                  isSelected: isSelected,
                  onTap: () => setState(() => isSelected = !isSelected),
                );
              },
            ),
          ),
        ),
      );

      // Initially not selected
      expect(find.byIcon(Icons.check_circle), findsNothing);

      // Tap to select
      await tester.tap(find.byType(IngredientChip));
      await tester.pumpAndSettle();

      // Should show checkmark when selected
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
    });

    testWidgets('should display category colors correctly', (tester) async {
      const proteinChip = IngredientChip(
        label: 'Chicken',
        category: 'protein',
      );

      const vegetableChip = IngredientChip(
        label: 'Carrots',
        category: 'vegetable',
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: Column(
              children: [proteinChip, vegetableChip],
            ),
          ),
        ),
      );

      expect(find.text('Chicken'), findsOneWidget);
      expect(find.text('Carrots'), findsOneWidget);
    });

    testWidgets('should handle unavailable state', (tester) async {
      const testChip = IngredientChip(
        label: 'Rare Spice',
        isAvailable: false,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: testChip,
          ),
        ),
      );

      // Find the chip widget
      final chipWidget = tester.widget<Opacity>(
        find.descendant(
          of: find.byType(IngredientChip),
          matching: find.byType(Opacity),
        ),
      );

      expect(chipWidget.opacity, equals(0.6));
    });

    testWidgets('should handle long press interactions', (tester) async {
      bool longPressed = false;
      
      final testChip = IngredientChip(
        label: 'Test Ingredient',
        onLongPress: () => longPressed = true,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: testChip,
          ),
        ),
      );

      await tester.longPress(find.byType(IngredientChip));
      expect(longPressed, isTrue);
    });

    testWidgets('should display custom icon', (tester) async {
      const testChip = IngredientChip(
        label: 'Special Ingredient',
        icon: Icons.star,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: testChip,
          ),
        ),
      );

      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('should display trailing widget', (tester) async {
      const testChip = IngredientChip(
        label: 'Ingredient with trailing',
        trailing: Icon(Icons.info),
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: testChip,
          ),
        ),
      );

      expect(find.byIcon(Icons.info), findsOneWidget);
    });

    testWidgets('should handle animation states', (tester) async {
      const testChip = IngredientChip(
        label: 'Animated Ingredient',
        isSelected: true,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: testChip,
          ),
        ),
      );

      // Allow animations to complete
      await tester.pumpAndSettle();

      expect(find.text('Animated Ingredient'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
    });
  });

  group('ShoppingIngredientChip', () {
    testWidgets('should display shopping chip correctly', (tester) async {
      bool isChecked = false;
      
      final shoppingChip = ShoppingIngredientChip(
        label: 'Milk',
        quantity: '1',
        unit: 'liter',
        category: 'dairy',
        isChecked: isChecked,
        onToggle: (value) => isChecked = value,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return ShoppingIngredientChip(
                  label: 'Milk',
                  quantity: '1',
                  unit: 'liter',
                  category: 'dairy',
                  isChecked: isChecked,
                  onToggle: (value) => setState(() => isChecked = value),
                );
              },
            ),
          ),
        ),
      );

      expect(find.text('Milk'), findsOneWidget);
      expect(find.byIcon(Icons.shopping_cart_outlined), findsOneWidget);

      // Tap to check
      await tester.tap(find.byType(ShoppingIngredientChip));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.shopping_cart), findsOneWidget);
    });
  });

  group('RecipeIngredientChip', () {
    testWidgets('should display recipe ingredient correctly', (tester) async {
      const recipeChip = RecipeIngredientChip(
        label: 'Flour',
        quantity: '2',
        unit: 'cups',
        category: 'grain',
        isOptional: true,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: recipeChip,
          ),
        ),
      );

      expect(find.text('Flour'), findsOneWidget);
      expect(find.text('optional'), findsOneWidget);
    });

    testWidgets('should handle unavailable ingredients', (tester) async {
      const recipeChip = RecipeIngredientChip(
        label: 'Exotic Spice',
        isAvailable: false,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: recipeChip,
          ),
        ),
      );

      expect(find.text('Exotic Spice'), findsOneWidget);
    });
  });

  group('CategoryFilterChip', () {
    testWidgets('should display category filter correctly', (tester) async {
      const filterChip = CategoryFilterChip(
        label: 'Vegetables',
        category: 'vegetable',
        count: 5,
        isSelected: true,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: filterChip,
          ),
        ),
      );

      expect(find.text('Vegetables'), findsOneWidget);
      expect(find.text('5'), findsOneWidget);
    });

    testWidgets('should handle filter selection', (tester) async {
      bool isSelected = false;
      
      final filterChip = CategoryFilterChip(
        label: 'Proteins',
        category: 'protein',
        isSelected: isSelected,
        onTap: () => isSelected = !isSelected,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return CategoryFilterChip(
                  label: 'Proteins',
                  category: 'protein',
                  isSelected: isSelected,
                  onTap: () => setState(() => isSelected = !isSelected),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(CategoryFilterChip));
      await tester.pumpAndSettle();

      expect(find.text('Proteins'), findsOneWidget);
    });
  });

  group('IngredientChip Accessibility', () {
    testWidgets('should be accessible', (tester) async {
      const testChip = IngredientChip(
        label: 'Accessible Ingredient',
        quantity: '1',
        unit: 'cup',
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: testChip,
          ),
        ),
      );

      expect(find.text('Accessible Ingredient'), findsOneWidget);
      
      // Check minimum touch target size
      final chipSize = tester.getSize(find.byType(IngredientChip));
      expect(chipSize.height, greaterThanOrEqualTo(32)); // Minimum height from design tokens
    });

    testWidgets('should support dark theme', (tester) async {
      const testChip = IngredientChip(
        label: 'Dark Theme Ingredient',
        isSelected: true,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.darkTheme,
          home: Scaffold(
            body: testChip,
          ),
        ),
      );

      expect(find.text('Dark Theme Ingredient'), findsOneWidget);
    });

    testWidgets('should handle text overflow', (tester) async {
      const testChip = IngredientChip(
        label: 'This is a very long ingredient name that should be truncated',
        quantity: '1000',
        unit: 'tablespoons',
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: SizedBox(
              width: 200, // Constrain width to force overflow
              child: testChip,
            ),
          ),
        ),
      );

      // Should not throw overflow errors
      expect(tester.takeException(), isNull);
    });
  });

  group('IngredientChip Performance', () {
    testWidgets('should handle rapid state changes', (tester) async {
      bool isSelected = false;
      
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return IngredientChip(
                  label: 'Performance Test',
                  isSelected: isSelected,
                  onTap: () => setState(() => isSelected = !isSelected),
                );
              },
            ),
          ),
        ),
      );

      // Rapidly toggle selection
      for (int i = 0; i < 5; i++) {
        await tester.tap(find.byType(IngredientChip));
        await tester.pump(const Duration(milliseconds: 50));
      }

      await tester.pumpAndSettle();
      expect(find.text('Performance Test'), findsOneWidget);
    });

    testWidgets('should dispose animations properly', (tester) async {
      const testChip = IngredientChip(
        label: 'Disposal Test',
        isSelected: true,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: testChip,
          ),
        ),
      );

      // Remove the widget
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: const Scaffold(
            body: SizedBox(),
          ),
        ),
      );

      // Should not throw any disposal errors
      expect(tester.takeException(), isNull);
    });
  });
}