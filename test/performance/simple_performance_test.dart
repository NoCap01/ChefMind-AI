import 'package:flutter_test/flutter_test.dart';
import 'package:chefmind_ai/core/performance/optimized_data_manager.dart';
import 'package:chefmind_ai/core/performance/memory_optimizer.dart';

void main() {
  group('Performance Optimizations Tests', () {
    test('OptimizedDataManager - Basic functionality', () {
      final dataManager = OptimizedDataManager<String>();

      // Test caching
      final stopwatch = Stopwatch()..start();

      for (int i = 0; i < 100; i++) {
        dataManager.cache('key_$i', 'value_$i');
      }

      stopwatch.stop();
      final cacheTime = stopwatch.elapsedMilliseconds;

      // Test retrieval
      stopwatch.reset();
      stopwatch.start();

      for (int i = 0; i < 100; i++) {
        final value = dataManager.getById('key_$i');
        expect(value, equals('value_$i'));
      }

      stopwatch.stop();
      final retrievalTime = stopwatch.elapsedMilliseconds;

      print('Cache time for 100 items: ${cacheTime}ms');
      print('Retrieval time for 100 items: ${retrievalTime}ms');

      // Should be very fast
      expect(retrievalTime, lessThan(50));

      dataManager.clearCache();
    });

    test('Search index performance', () {
      final dataManager = OptimizedDataManager<String>();

      // Cache some test data
      for (int i = 0; i < 100; i++) {
        dataManager.cache('item_$i', 'test_value_$i');
      }

      final stopwatch = Stopwatch()..start();

      // Test search (this will be empty since we don't have recipe-specific indexing)
      final results = dataManager.searchByIndex('test');

      stopwatch.stop();
      final searchTime = stopwatch.elapsedMilliseconds;

      print('Search time: ${searchTime}ms');

      // Should be very fast even if empty
      expect(searchTime, lessThan(10));

      dataManager.clearCache();
    });

    test('Memory optimizer functionality', () {
      final memoryOptimizer = MemoryOptimizer();

      // Test initial state
      final initialStats = memoryOptimizer.getMemoryStats();
      expect(initialStats['subscriptions'], equals(0));
      expect(initialStats['timers'], equals(0));

      // Test cleanup
      expect(() => memoryOptimizer.cleanup(), returnsNormally);

      final finalStats = memoryOptimizer.getMemoryStats();
      expect(finalStats['subscriptions'], equals(0));
    });

    test('Pagination controller basic functionality', () async {
      final testData = List.generate(100, (i) => 'item_$i');

      final controller = OptimizedPaginationController<String>(
        loadFunction: (offset, limit) async {
          await Future.delayed(Duration(milliseconds: 5));
          final end = (offset + limit).clamp(0, testData.length);
          return testData.sublist(offset, end);
        },
        pageSize: 20,
      );

      final stopwatch = Stopwatch()..start();

      await controller.loadInitial();

      stopwatch.stop();
      final loadTime = stopwatch.elapsedMilliseconds;

      print('Initial page load time: ${loadTime}ms');
      print('Items loaded: ${controller.items.length}');

      expect(controller.items.length, equals(20));
      expect(controller.hasMore, isTrue);
      expect(loadTime, lessThan(100));

      // Test shouldLoadMore
      expect(controller.shouldLoadMore(15), isTrue);
      expect(controller.shouldLoadMore(5), isFalse);

      controller.dispose();
    });

    test('Cache size limits and LRU eviction', () {
      final dataManager = OptimizedDataManager<String>(
        maxCacheSize: 10, // Small cache for testing
      );

      // Fill cache beyond limit
      for (int i = 0; i < 15; i++) {
        dataManager.cache('key_$i', 'value_$i');
      }

      final stats = dataManager.getCacheStats();
      print('Cache stats after overfill: $stats');

      // Should not exceed max cache size
      expect(stats['cacheSize'], lessThanOrEqualTo(10));

      // Older items should be evicted
      expect(dataManager.getById('key_0'), isNull);
      expect(dataManager.getById('key_14'), isNotNull);

      dataManager.clearCache();
    });

    test('Performance monitoring', () {
      // Test that performance classes can be instantiated
      expect(() => OptimizedDataManager<String>(), returnsNormally);
      expect(() => MemoryOptimizer(), returnsNormally);

      // Test cache statistics
      final dataManager = OptimizedDataManager<String>();
      final stats = dataManager.getCacheStats();

      expect(stats, isA<Map<String, dynamic>>());
      expect(stats.containsKey('cacheSize'), isTrue);
      expect(stats.containsKey('maxCacheSize'), isTrue);

      dataManager.clearCache();
    });
  });
}
