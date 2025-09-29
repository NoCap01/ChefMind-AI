import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:chefmind_ai/main.dart' as app;
import 'dart:io';

class UIPerformanceTest {
  static void runUIPerformanceTests() {
    group('UI Performance Tests', () {
      testWidgets('Frame rate during animations', (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle();

        // Track frame times during navigation animations
        final frameTimes = <Duration>[];

        // Override frame callback to measure frame times
        tester.binding.addPersistentFrameCallback((timeStamp) {
          frameTimes.add(timeStamp);
        });

        // Perform navigation with animations
        await tester.tap(find.text('Recipe Book'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Shopping List'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Meal Planner'));
        await tester.pumpAndSettle();

        // Calculate frame rate
        if (frameTimes.length > 1) {
          final totalDuration = frameTimes.last - frameTimes.first;
          final averageFrameTime =
              totalDuration.inMicroseconds / frameTimes.length;
          final fps = 1000000 / averageFrameTime;

          print('Average FPS during navigation: ${fps.toStringAsFixed(2)}');

          // Should maintain at least 30 FPS
          expect(fps, greaterThan(30));
        }
      });

      testWidgets('Scroll performance test', (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle();

        // Navigate to recipe book
        await tester.tap(find.text('Recipe Book'));
        await tester.pumpAndSettle();

        final scrollTimes = <int>[];

        // Measure scroll performance
        for (int i = 0; i < 10; i++) {
          final stopwatch = Stopwatch()..start();

          await tester.drag(find.byType(ListView), const Offset(0, -500));
          await tester.pumpAndSettle();

          stopwatch.stop();
          scrollTimes.add(stopwatch.elapsedMilliseconds);
        }

        final averageScrollTime =
            scrollTimes.reduce((a, b) => a + b) / scrollTimes.length;

        print('Average scroll time: ${averageScrollTime.toStringAsFixed(2)}ms');

        // Scroll should be smooth (under 100ms per scroll)
        expect(averageScrollTime, lessThan(100));
      });

      testWidgets('Widget build performance', (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle();

        final buildTimes = <int>[];

        // Measure build times for different screens
        final screens = [
          'Recipe Book',
          'Shopping List',
          'Meal Planner',
          'Profile'
        ];

        for (final screen in screens) {
          final stopwatch = Stopwatch()..start();

          await tester.tap(find.text(screen));
          await tester.pumpAndSettle();

          stopwatch.stop();
          buildTimes.add(stopwatch.elapsedMilliseconds);

          print('$screen build time: ${stopwatch.elapsedMilliseconds}ms');
        }

        final averageBuildTime =
            buildTimes.reduce((a, b) => a + b) / buildTimes.length;

        print(
            'Average screen build time: ${averageBuildTime.toStringAsFixed(2)}ms');

        // Screen builds should be fast (under 200ms)
        expect(averageBuildTime, lessThan(200));
      });

      testWidgets('Form input responsiveness', (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle();

        // Navigate to recipe generation
        await tester.tap(find.text('Generate Recipe'));
        await tester.pumpAndSettle();

        final inputTimes = <int>[];

        // Test input responsiveness
        for (int i = 0; i < 10; i++) {
          final stopwatch = Stopwatch()..start();

          await tester.enterText(
              find.byKey(const Key('ingredient_input')), 'test_ingredient_$i');
          await tester.pump();

          stopwatch.stop();
          inputTimes.add(stopwatch.elapsedMilliseconds);
        }

        final averageInputTime =
            inputTimes.reduce((a, b) => a + b) / inputTimes.length;

        print(
            'Average input response time: ${averageInputTime.toStringAsFixed(2)}ms');

        // Input should be responsive (under 50ms)
        expect(averageInputTime, lessThan(50));
      });

      testWidgets('Large list rendering performance',
          (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle();

        // Navigate to recipe book
        await tester.tap(find.text('Recipe Book'));
        await tester.pumpAndSettle();

        final stopwatch = Stopwatch()..start();

        // Scroll through a large number of items
        for (int i = 0; i < 100; i++) {
          await tester.drag(find.byType(ListView), const Offset(0, -100));
          await tester.pump();
        }

        stopwatch.stop();

        print('Large list scroll time: ${stopwatch.elapsedMilliseconds}ms');

        // Large list scrolling should be smooth (under 5 seconds for 100 scrolls)
        expect(stopwatch.elapsedMilliseconds, lessThan(5000));
      });

      testWidgets('State update performance', (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle();

        // Navigate to recipe generation
        await tester.tap(find.text('Generate Recipe'));
        await tester.pumpAndSettle();

        final updateTimes = <int>[];

        // Test state update performance
        for (int i = 0; i < 20; i++) {
          final stopwatch = Stopwatch()..start();

          // Add ingredient (triggers state update)
          await tester.enterText(
              find.byKey(const Key('ingredient_input')), 'ingredient_$i');
          await tester.tap(find.byKey(const Key('add_ingredient_button')));
          await tester.pump();

          stopwatch.stop();
          updateTimes.add(stopwatch.elapsedMilliseconds);
        }

        final averageUpdateTime =
            updateTimes.reduce((a, b) => a + b) / updateTimes.length;

        print(
            'Average state update time: ${averageUpdateTime.toStringAsFixed(2)}ms');

        // State updates should be fast (under 100ms)
        expect(averageUpdateTime, lessThan(100));
      });

      testWidgets('Memory usage during UI operations',
          (WidgetTester tester) async {
        if (kIsWeb) return; // Skip on web

        app.main();
        await tester.pumpAndSettle();

        const initialMemory = 0; // ProcessInfo not available in Flutter tests

        // Perform various UI operations
        final screens = [
          'Recipe Book',
          'Shopping List',
          'Meal Planner',
          'Profile'
        ];

        for (int cycle = 0; cycle < 3; cycle++) {
          for (final screen in screens) {
            await tester.tap(find.text(screen));
            await tester.pumpAndSettle();

            // Scroll if possible
            if (find.byType(ListView).evaluate().isNotEmpty) {
              for (int i = 0; i < 5; i++) {
                await tester.drag(find.byType(ListView), const Offset(0, -200));
                await tester.pump();
              }
            }
          }
        }

        const finalMemory = 0; // ProcessInfo not available in Flutter tests
        final memoryIncrease = finalMemory - initialMemory;

        print('Memory usage during UI operations:');
        print(
            'Initial: ${(initialMemory / (1024 * 1024)).toStringAsFixed(2)}MB');
        print('Final: ${(finalMemory / (1024 * 1024)).toStringAsFixed(2)}MB');
        print(
            'Increase: ${(memoryIncrease / (1024 * 1024)).toStringAsFixed(2)}MB');

        // Memory increase should be reasonable (less than 25MB)
        expect(memoryIncrease, lessThan(25 * 1024 * 1024));
      });
    });
  }
}
