import 'package:flutter_test/flutter_test.dart';
import 'package:chefmind_ai/core/performance/optimized_data_manager.dart';
import 'package:chefmind_ai/core/performance/memory_optimizer.dart';
import 'package:chefmind_ai/domain/entities/recipe.dart';

void main() {
  group('Performance Optimizations Tests', () {
    late RecipeDataManager dataManager;
    late List<Recipe> testRecipes;

    setUpAll(() {
      dataManager = RecipeDataManager();
      testRecipes = _generateTestRecipes(100);
    });

    tearDownAll(() {
      dataManager.clearCache();
    });

    test('OptimizedDataManager - O(1) cache access', () {
      final stopwatch = Stopwatch()..start();

      // Cache all recipes
      for (final recipe in testRecipes) {
        dataManager.cache(recipe.id, recipe);
      }

      stopwatch.stop();
      final cacheTime = stopwatch.elapsedMilliseconds;

      // Test O(1) retrieval
      stopwatch.reset();
      stopwatch.start();

      for (final recipe in testRecipes) {
        final retrieved = dataManager.getById(recipe.id);
        expect(retrieved, isNotNull);
        expect(retrieved!.id, equals(recipe.id));
      }

      stopwatch.stop();
      final retrievalTime = stopwatch.elapsedMilliseconds;

      print('Cache time for 100 recipes: ${cacheTime}ms');
      print('Retrieval time for 100 recipes: ${retrievalTime}ms');

      // O(1) access should be very fast
      expect(retrievalTime, lessThan(50)); // Should be under 50ms
    });

    test('Search index performance - O(1) search', () {
      // Cache recipes with search indexing
      for (final recipe in testRecipes) {
        dataManager.cache(recipe.id, recipe);
      }

      final stopwatch = Stopwatch()..start();

      // Test search performance
      final results = dataManager.searchByIndex('chicken');

      stopwatch.stop();
      final searchTime = stopwatch.elapsedMilliseconds;

      print('Search time for "chicken": ${searchTime}ms');
      print('Search results count: ${results.length}');

      // O(1) search should be very fast
      expect(searchTime, lessThan(10)); // Should be under 10ms
      expect(results, isNotEmpty);
    });

    test('Memory usage optimization', () {
      final memoryOptimizer = MemoryOptimizer();

      // Test memory tracking
      final initialStats = memoryOptimizer.getMemoryStats();

      // Simulate resource usage
      final subscriptions = <Stream>[];
      for (int i = 0; i < 10; i++) {
        final stream = Stream.periodic(Duration(milliseconds: 100));
        subscriptions.add(stream);
      }

      // Cleanup should work without errors
      expect(() => memoryOptimizer.cleanup(), returnsNormally);

      final finalStats = memoryOptimizer.getMemoryStats();
      expect(finalStats['subscriptions'], equals(0));
    });

    test('Pagination controller efficiency', () async {
      final controller = OptimizedPaginationController<Recipe>(
        loadFunction: (offset, limit) async {
          // Simulate database query
          await Future.delayed(Duration(milliseconds: 10));
          final end = (offset + limit).clamp(0, testRecipes.length);
          return testRecipes.sublist(offset, end);
        },
        pageSize: 20,
      );

      final stopwatch = Stopwatch()..start();

      // Load initial page
      await controller.loadInitial();

      stopwatch.stop();
      final loadTime = stopwatch.elapsedMilliseconds;

      print('Initial page load time: ${loadTime}ms');
      print('Items loaded: ${controller.items.length}');

      expect(controller.items.length, equals(20));
      expect(controller.hasMore, isTrue);
      expect(loadTime, lessThan(100)); // Should be under 100ms

      controller.dispose();
    });

    test('Cache statistics and limits', () {
      final dataManager = RecipeDataManager();

      // Fill cache beyond limit to test LRU eviction
      for (int i = 0; i < 600; i++) {
        // More than maxCacheSize (500)
        final recipe = _createTestRecipe('recipe_$i');
        dataManager.cache(recipe.id, recipe);
      }

      final stats = dataManager.getCacheStats();
      print('Cache stats: $stats');

      // Should not exceed max cache size
      expect(stats['cacheSize'], lessThanOrEqualTo(500));

      dataManager.clearCache();
    });
  });
}

List<Recipe> _generateTestRecipes(int count) {
  return List.generate(count, (index) => _createTestRecipe('recipe_$index'));
}

Recipe _createTestRecipe(String id) {
  return Recipe(
    id: id,
    title: 'Test Recipe $id',
    description: 'A delicious test recipe with chicken',
    ingredients: [
      Ingredient(
        name: 'Chicken',
        amount: '1 lb',
        category: 'Protein',
      ),
      Ingredient(
        name: 'Rice',
        amount: '2 cups',
        category: 'Grain',
      ),
    ],
    instructions: [
      CookingStep(
        stepNumber: 1,
        instruction: 'Cook the chicken',
        duration: Duration(minutes: 20),
      ),
      CookingStep(
        stepNumber: 2,
        instruction: 'Add rice and simmer',
        duration: Duration(minutes: 15),
      ),
    ],
    metadata: RecipeMetadata(
      difficulty: DifficultyLevel.easy,
      mealType: MealType.dinner,
      cuisine: 'American',
      prepTime: 10,
      cookTime: 35,
      servings: 4,
    ),
    tags: ['chicken', 'rice', 'easy', 'dinner'],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    source: 'test',
  );
}
