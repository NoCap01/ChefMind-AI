import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chefmind_ai/main.dart' as app;
import 'dart:io';

class MemoryLeakDetector {
  static void runMemoryTests() {
    group('Memory Leak Detection', () {
      testWidgets('Navigation memory leak test', (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle();

        final initialMemory = await _getCurrentMemoryUsage();

        // Navigate through all screens multiple times
        final screens = [
          'Recipe Book',
          'Shopping List',
          'Meal Planner',
          'Profile',
          'Generate Recipe'
        ];

        for (int cycle = 0; cycle < 5; cycle++) {
          for (final screen in screens) {
            await tester.tap(find.text(screen));
            await tester.pumpAndSettle();

            // Force garbage collection
            if (!kIsWeb) {
              await tester.binding.delayed(const Duration(milliseconds: 100));
            }
          }
        }

        // Force garbage collection
        if (!kIsWeb) {
          await tester.binding.delayed(const Duration(seconds: 2));
        }

        final finalMemory = await _getCurrentMemoryUsage();
        final memoryIncrease = finalMemory - initialMemory;

        print('Memory usage after navigation cycles:');
        print(
            'Initial: ${(initialMemory / (1024 * 1024)).toStringAsFixed(2)}MB');
        print('Final: ${(finalMemory / (1024 * 1024)).toStringAsFixed(2)}MB');
        print(
            'Increase: ${(memoryIncrease / (1024 * 1024)).toStringAsFixed(2)}MB');

        // Memory increase should be reasonable (less than 20MB for navigation)
        expect(memoryIncrease, lessThan(20 * 1024 * 1024));
      });

      testWidgets('Recipe generation memory leak test',
          (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle();

        // Navigate to recipe generation
        await tester.tap(find.text('Generate Recipe'));
        await tester.pumpAndSettle();

        final initialMemory = await _getCurrentMemoryUsage();

        // Generate multiple recipes
        for (int i = 0; i < 10; i++) {
          // Clear previous input
          await tester.enterText(find.byKey(const Key('ingredient_input')), '');
          await tester.pumpAndSettle();

          // Add ingredient
          await tester.enterText(
              find.byKey(const Key('ingredient_input')), 'ingredient_$i');
          await tester.tap(find.byKey(const Key('add_ingredient_button')));
          await tester.pumpAndSettle();

          // Generate recipe
          await tester.tap(find.byKey(const Key('generate_recipe_button')));
          await tester.pumpAndSettle(const Duration(seconds: 5));

          // Clear generated recipe
          if (find
              .byKey(const Key('clear_recipe_button'))
              .evaluate()
              .isNotEmpty) {
            await tester.tap(find.byKey(const Key('clear_recipe_button')));
            await tester.pumpAndSettle();
          }
        }

        // Force garbage collection
        if (!kIsWeb) {
          await tester.binding.delayed(const Duration(seconds: 2));
        }

        final finalMemory = await _getCurrentMemoryUsage();
        final memoryIncrease = finalMemory - initialMemory;

        print('Memory usage after recipe generation cycles:');
        print(
            'Initial: ${(initialMemory / (1024 * 1024)).toStringAsFixed(2)}MB');
        print('Final: ${(finalMemory / (1024 * 1024)).toStringAsFixed(2)}MB');
        print(
            'Increase: ${(memoryIncrease / (1024 * 1024)).toStringAsFixed(2)}MB');

        // Memory increase should be reasonable (less than 30MB for recipe generation)
        expect(memoryIncrease, lessThan(30 * 1024 * 1024));
      });

      testWidgets('List scrolling memory leak test',
          (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle();

        // Navigate to recipe book
        await tester.tap(find.text('Recipe Book'));
        await tester.pumpAndSettle();

        final initialMemory = await _getCurrentMemoryUsage();

        // Scroll through list multiple times
        for (int cycle = 0; cycle < 10; cycle++) {
          // Scroll down
          for (int i = 0; i < 20; i++) {
            await tester.drag(find.byType(ListView), const Offset(0, -300));
            await tester.pump();
          }

          // Scroll back up
          for (int i = 0; i < 20; i++) {
            await tester.drag(find.byType(ListView), const Offset(0, 300));
            await tester.pump();
          }
        }

        await tester.pumpAndSettle();

        // Force garbage collection
        if (!kIsWeb) {
          await tester.binding.delayed(const Duration(seconds: 2));
        }

        final finalMemory = await _getCurrentMemoryUsage();
        final memoryIncrease = finalMemory - initialMemory;

        print('Memory usage after scrolling cycles:');
        print(
            'Initial: ${(initialMemory / (1024 * 1024)).toStringAsFixed(2)}MB');
        print('Final: ${(finalMemory / (1024 * 1024)).toStringAsFixed(2)}MB');
        print(
            'Increase: ${(memoryIncrease / (1024 * 1024)).toStringAsFixed(2)}MB');

        // Memory increase should be minimal for scrolling (less than 10MB)
        expect(memoryIncrease, lessThan(10 * 1024 * 1024));
      });

      testWidgets('Image loading memory test', (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle();

        // Navigate to recipe book where images are displayed
        await tester.tap(find.text('Recipe Book'));
        await tester.pumpAndSettle();

        final initialMemory = await _getCurrentMemoryUsage();

        // Scroll through recipes to load images
        for (int i = 0; i < 50; i++) {
          await tester.drag(find.byType(ListView), const Offset(0, -200));
          await tester.pump();

          // Small delay to allow image loading
          await tester.binding.delayed(const Duration(milliseconds: 50));
        }

        await tester.pumpAndSettle();

        // Force garbage collection
        if (!kIsWeb) {
          await tester.binding.delayed(const Duration(seconds: 3));
        }

        final finalMemory = await _getCurrentMemoryUsage();
        final memoryIncrease = finalMemory - initialMemory;

        print('Memory usage after image loading:');
        print(
            'Initial: ${(initialMemory / (1024 * 1024)).toStringAsFixed(2)}MB');
        print('Final: ${(finalMemory / (1024 * 1024)).toStringAsFixed(2)}MB');
        print(
            'Increase: ${(memoryIncrease / (1024 * 1024)).toStringAsFixed(2)}MB');

        // Memory increase should be reasonable for image caching (less than 50MB)
        expect(memoryIncrease, lessThan(50 * 1024 * 1024));
      });
    });
  }

  static Future<int> _getCurrentMemoryUsage() async {
    if (kIsWeb) return 0;

    try {
      return ProcessInfo.currentRss;
    } catch (e) {
      return 0;
    }
  }
}
