import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:chefmind_ai/main.dart' as app;
import 'dart:io';
import 'dart:convert';

class PerformanceTestSuite {
  static final IntegrationTestWidgetsFlutterBinding binding =
      IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  static Future<void> runPerformanceTests() async {
    group('Performance Tests', () {
      testWidgets('App startup performance', (WidgetTester tester) async {
        final stopwatch = Stopwatch()..start();
        
        app.main();
        await tester.pumpAndSettle();
        
        stopwatch.stop();
        final startupTime = stopwatch.elapsedMilliseconds;
        
        // App should start within 3 seconds
        expect(startupTime, lessThan(3000));
        
        print('App startup time: ${startupTime}ms');
        await _recordMetric('startup_time', startupTime);
      });

      testWidgets('Recipe generation performance', (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle();
        
        // Navigate to recipe generation
        await tester.tap(find.text('Generate Recipe'));
        await tester.pumpAndSettle();
        
        final stopwatch = Stopwatch()..start();
        
        // Add ingredients and generate recipe
        await tester.enterText(find.byKey(const Key('ingredient_input')), 'chicken');
        await tester.tap(find.byKey(const Key('add_ingredient_button')));
        await tester.pumpAndSettle();
        
        await tester.tap(find.byKey(const Key('generate_recipe_button')));
        await tester.pumpAndSettle(const Duration(seconds: 10));
        
        stopwatch.stop();
        final generationTime = stopwatch.elapsedMilliseconds;
        
        // Recipe generation should complete within 10 seconds
        expect(generationTime, lessThan(10000));
        
        print('Recipe generation time: ${generationTime}ms');
        await _recordMetric('recipe_generation_time', generationTime);
      });

      testWidgets('Memory usage during recipe browsing', (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle();
        
        final initialMemory = await _getCurrentMemoryUsage();
        
        // Navigate to recipe book and scroll through recipes
        await tester.tap(find.text('Recipe Book'));
        await tester.pumpAndSettle();
        
        // Simulate scrolling through many recipes
        for (int i = 0; i < 10; i++) {
          await tester.drag(find.byType(ListView), const Offset(0, -300));
          await tester.pumpAndSettle();
        }
        
        final finalMemory = await _getCurrentMemoryUsage();
        final memoryIncrease = finalMemory - initialMemory;
        
        // Memory increase should be reasonable (less than 50MB)
        expect(memoryIncrease, lessThan(50 * 1024 * 1024));
        
        print('Memory increase during browsing: ${memoryIncrease / (1024 * 1024)}MB');
        await _recordMetric('memory_increase_browsing', memoryIncrease);
      });

      testWidgets('UI responsiveness test', (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle();
        
        final responseTimes = <int>[];
        
        // Test navigation responsiveness
        final screens = ['Recipe Book', 'Shopping List', 'Meal Planner', 'Profile'];
        
        for (final screen in screens) {
          final stopwatch = Stopwatch()..start();
          
          await tester.tap(find.text(screen));
          await tester.pumpAndSettle();
          
          stopwatch.stop();
          responseTimes.add(stopwatch.elapsedMilliseconds);
        }
        
        final averageResponseTime = responseTimes.reduce((a, b) => a + b) / responseTimes.length;
        
        // Average navigation should be under 500ms
        expect(averageResponseTime, lessThan(500));
        
        print('Average navigation response time: ${averageResponseTime}ms');
        await _recordMetric('average_navigation_time', averageResponseTime.round());
      });

      testWidgets('Large dataset performance', (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle();
        
        // Navigate to recipe book
        await tester.tap(find.text('Recipe Book'));
        await tester.pumpAndSettle();
        
        final stopwatch = Stopwatch()..start();
        
        // Simulate loading large number of recipes
        // This would trigger lazy loading mechanisms
        await tester.drag(find.byType(ListView), const Offset(0, -5000));
        await tester.pumpAndSettle();
        
        stopwatch.stop();
        final scrollTime = stopwatch.elapsedMilliseconds;
        
        // Large dataset scrolling should be smooth (under 2 seconds)
        expect(scrollTime, lessThan(2000));
        
        print('Large dataset scroll time: ${scrollTime}ms');
        await _recordMetric('large_dataset_scroll_time', scrollTime);
      });
    });
  }

  static Future<int> _getCurrentMemoryUsage() async {
    if (kIsWeb) return 0;
    
    try {
      final info = ProcessInfo.currentRss;
      return info;
    } catch (e) {
      return 0;
    }
  }

  static Future<void> _recordMetric(String metricName, num value) async {
    final metrics = {
      'timestamp': DateTime.now().toIso8601String(),
      'metric': metricName,
      'value': value,
      'platform': Platform.operatingSystem,
    };
    
    final file = File('test_results/performance_metrics.json');
    await file.parent.create(recursive: true);
    
    List<Map<String, dynamic>> allMetrics = [];
    if (await file.exists()) {
      final content = await file.readAsString();
      if (content.isNotEmpty) {
        allMetrics = List<Map<String, dynamic>>.from(json.decode(content));
      }
    }
    
    allMetrics.add(metrics);
    await file.writeAsString(json.encode(allMetrics));
  }
}