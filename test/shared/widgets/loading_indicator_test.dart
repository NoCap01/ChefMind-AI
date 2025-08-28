import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chefmind_ai/shared/widgets/loading_indicator.dart';
import 'package:chefmind_ai/core/theme/app_theme.dart';

void main() {
  group('LoadingIndicator', () {
    testWidgets('should display loading indicator with message', (tester) async {
      const testIndicator = LoadingIndicator(
        message: 'Loading recipes...',
        type: LoadingType.searching,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: testIndicator,
          ),
        ),
      );

      expect(find.text('Loading recipes...'), findsOneWidget);
    });

    testWidgets('should display default message for each type', (tester) async {
      const cookingIndicator = LoadingIndicator(
        type: LoadingType.cooking,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: cookingIndicator,
          ),
        ),
      );

      expect(find.text('Cooking up something delicious...'), findsOneWidget);
    });

    testWidgets('should handle different sizes', (tester) async {
      const smallIndicator = LoadingIndicator(
        size: LoadingSize.small,
        showMessage: false,
      );

      const largeIndicator = LoadingIndicator(
        size: LoadingSize.large,
        showMessage: false,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: Column(
              children: [smallIndicator, largeIndicator],
            ),
          ),
        ),
      );

      // Both indicators should be present
      expect(find.byType(LoadingIndicator), findsNWidgets(2));
    });

    testWidgets('should hide message when showMessage is false', (tester) async {
      const testIndicator = LoadingIndicator(
        message: 'This should not appear',
        showMessage: false,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: testIndicator,
          ),
        ),
      );

      expect(find.text('This should not appear'), findsNothing);
    });

    testWidgets('should apply custom background color', (tester) async {
      const testIndicator = LoadingIndicator(
        backgroundColor: Colors.red,
        showMessage: false,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: testIndicator,
          ),
        ),
      );

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(LoadingIndicator),
          matching: find.byType(Container),
        ).first,
      );

      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, equals(Colors.red));
    });

    testWidgets('should handle all loading types', (tester) async {
      for (final type in LoadingType.values) {
        final indicator = LoadingIndicator(
          type: type,
          showMessage: false,
        );

        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.lightTheme,
            home: Scaffold(
              body: indicator,
            ),
          ),
        );

        expect(find.byType(LoadingIndicator), findsOneWidget);
      }
    });

    testWidgets('should animate properly', (tester) async {
      const testIndicator = LoadingIndicator(
        type: LoadingType.cooking,
        showMessage: false,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: testIndicator,
          ),
        ),
      );

      // Let animations run
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pump(const Duration(milliseconds: 1000));

      expect(find.byType(LoadingIndicator), findsOneWidget);
    });
  });

  group('LoadingOverlay', () {
    testWidgets('should show overlay when loading', (tester) async {
      const testOverlay = LoadingOverlay(
        isLoading: true,
        message: 'Processing...',
        child: Text('Content'),
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: testOverlay,
          ),
        ),
      );

      expect(find.text('Content'), findsOneWidget);
      expect(find.text('Processing...'), findsOneWidget);
      expect(find.byType(LoadingIndicator), findsOneWidget);
    });

    testWidgets('should hide overlay when not loading', (tester) async {
      const testOverlay = LoadingOverlay(
        isLoading: false,
        message: 'Processing...',
        child: Text('Content'),
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: testOverlay,
          ),
        ),
      );

      expect(find.text('Content'), findsOneWidget);
      expect(find.text('Processing...'), findsNothing);
      expect(find.byType(LoadingIndicator), findsNothing);
    });

    testWidgets('should apply custom background color', (tester) async {
      const testOverlay = LoadingOverlay(
        isLoading: true,
        backgroundColor: Colors.blue,
        child: Text('Content'),
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: testOverlay,
          ),
        ),
      );

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(LoadingOverlay),
          matching: find.byType(Container),
        ).first,
      );

      expect(container.color, equals(Colors.blue));
    });
  });

  group('ButtonLoadingIndicator', () {
    testWidgets('should display button loading indicator', (tester) async {
      const testIndicator = ButtonLoadingIndicator(
        color: Colors.white,
        size: 20.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: testIndicator,
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      
      final indicator = tester.widget<CircularProgressIndicator>(
        find.byType(CircularProgressIndicator),
      );
      expect(indicator.color, equals(Colors.white));
    });

    testWidgets('should use default color from theme', (tester) async {
      const testIndicator = ButtonLoadingIndicator();

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: testIndicator,
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });

  group('SkeletonLoader', () {
    testWidgets('should display skeleton with correct dimensions', (tester) async {
      const testSkeleton = SkeletonLoader(
        width: 200,
        height: 100,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: testSkeleton,
          ),
        ),
      );

      final container = tester.widget<Container>(
        find.byType(Container),
      );

      expect(container.constraints?.maxWidth, equals(200));
      expect(container.constraints?.maxHeight, equals(100));
    });

    testWidgets('should animate skeleton shimmer', (tester) async {
      const testSkeleton = SkeletonLoader(
        width: 100,
        height: 50,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: testSkeleton,
          ),
        ),
      );

      // Let animation run
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pump(const Duration(milliseconds: 1000));

      expect(find.byType(SkeletonLoader), findsOneWidget);
    });

    testWidgets('should apply custom border radius', (tester) async {
      const testSkeleton = SkeletonLoader(
        width: 100,
        height: 50,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: testSkeleton,
          ),
        ),
      );

      expect(find.byType(SkeletonLoader), findsOneWidget);
    });
  });

  group('RecipeCardSkeleton', () {
    testWidgets('should display recipe card skeleton', (tester) async {
      const testSkeleton = RecipeCardSkeleton();

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: testSkeleton,
          ),
        ),
      );

      expect(find.byType(RecipeCardSkeleton), findsOneWidget);
      expect(find.byType(SkeletonLoader), findsNWidgets(4)); // Image, title, subtitle, meta
    });

    testWidgets('should have correct dimensions', (tester) async {
      const testSkeleton = RecipeCardSkeleton();

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: testSkeleton,
          ),
        ),
      );

      final container = tester.widget<Container>(
        find.byType(Container).first,
      );

      expect(container.constraints?.maxWidth, equals(200)); // DesignTokens.recipeCardWidth
      expect(container.constraints?.maxHeight, equals(280)); // DesignTokens.recipeCardHeight
    });
  });

  group('IngredientListSkeleton', () {
    testWidgets('should display ingredient list skeleton', (tester) async {
      const testSkeleton = IngredientListSkeleton(itemCount: 3);

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: testSkeleton,
          ),
        ),
      );

      expect(find.byType(IngredientListSkeleton), findsOneWidget);
      expect(find.byType(SkeletonLoader), findsNWidgets(9)); // 3 items × 3 skeletons each
    });

    testWidgets('should handle different item counts', (tester) async {
      const testSkeleton = IngredientListSkeleton(itemCount: 5);

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: testSkeleton,
          ),
        ),
      );

      expect(find.byType(SkeletonLoader), findsNWidgets(15)); // 5 items × 3 skeletons each
    });
  });

  group('Loading Components Accessibility', () {
    testWidgets('should be accessible in light theme', (tester) async {
      const testIndicator = LoadingIndicator(
        message: 'Accessible loading...',
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: testIndicator,
          ),
        ),
      );

      expect(find.text('Accessible loading...'), findsOneWidget);
    });

    testWidgets('should be accessible in dark theme', (tester) async {
      const testIndicator = LoadingIndicator(
        message: 'Dark theme loading...',
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.darkTheme,
          home: Scaffold(
            body: testIndicator,
          ),
        ),
      );

      expect(find.text('Dark theme loading...'), findsOneWidget);
    });

    testWidgets('should handle screen reader announcements', (tester) async {
      const testOverlay = LoadingOverlay(
        isLoading: true,
        message: 'Loading content for screen reader',
        child: Text('Main content'),
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: testOverlay,
          ),
        ),
      );

      expect(find.text('Loading content for screen reader'), findsOneWidget);
      expect(find.text('Main content'), findsOneWidget);
    });
  });

  group('Loading Components Performance', () {
    testWidgets('should handle rapid state changes', (tester) async {
      bool isLoading = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return LoadingOverlay(
                  isLoading: isLoading,
                  child: ElevatedButton(
                    onPressed: () => setState(() => isLoading = !isLoading),
                    child: const Text('Toggle Loading'),
                  ),
                );
              },
            ),
          ),
        ),
      );

      // Rapidly toggle loading state
      for (int i = 0; i < 5; i++) {
        await tester.tap(find.text('Toggle Loading'));
        await tester.pump(const Duration(milliseconds: 50));
      }

      await tester.pumpAndSettle();
      expect(find.text('Toggle Loading'), findsOneWidget);
    });

    testWidgets('should dispose animations properly', (tester) async {
      const testIndicator = LoadingIndicator(
        type: LoadingType.cooking,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: testIndicator,
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

    testWidgets('should handle multiple skeleton loaders efficiently', (tester) async {
      final skeletons = List.generate(
        10,
        (index) => SkeletonLoader(
          width: 100,
          height: 20,
          key: ValueKey('skeleton_$index'),
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: Column(children: skeletons),
          ),
        ),
      );

      expect(find.byType(SkeletonLoader), findsNWidgets(10));

      // Let animations run
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pumpAndSettle();

      expect(find.byType(SkeletonLoader), findsNWidgets(10));
    });
  });
}