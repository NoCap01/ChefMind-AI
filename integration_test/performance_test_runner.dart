import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import '../test/performance/performance_test_suite.dart';
import '../test/performance/memory_leak_detector.dart';
import '../test/performance/ui_performance_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('ChefMind Performance Tests', () {
    setUpAll(() async {
      print('🚀 Setting up performance test environment...');
    });

    tearDownAll(() async {
      print('🧹 Cleaning up performance test environment...');
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