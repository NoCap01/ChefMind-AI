import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'performance_test_suite.dart';
import 'memory_leak_detector.dart';
import 'ui_performance_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('ChefMind Performance Tests', () {
    setUpAll(() async {
      // Initialize performance testing environment
      print('Setting up performance test environment...');
    });

    tearDownAll(() async {
      // Cleanup after tests
      print('Cleaning up performance test environment...');
    });

    group('Core Performance Tests', () {
      PerformanceTestSuite.runPerformanceTests();
    });

    group('Memory Leak Detection', () {
      MemoryLeakDetector.runMemoryTests();
    });

    group('UI Performance Tests', () {
      UIPerformanceTest.runUIPerformanceTests();
    });
  });
}