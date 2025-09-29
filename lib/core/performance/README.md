# Performance Optimization Guide

## Quick Start

### 1. Replace Standard Lists with Optimized Versions

#### Before:
```dart
ListView.builder(
  itemCount: recipes.length,
  itemBuilder: (context, index) => RecipeCard(recipe: recipes[index]),
)
```

#### After:
```dart
OptimizedRecipeList(
  recipes: recipes,
  usePagination: true, // For large lists
  onRecipeTap: (recipe) => navigateToRecipe(recipe),
)
```

### 2. Add Memory Management to Stateful Widgets

#### Before:
```dart
class MyScreen extends StatefulWidget {
  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  final _controller = TextEditingController();
  StreamSubscription? _subscription;
  
  @override
  void dispose() {
    _controller.dispose();
    _subscription?.cancel();
    super.dispose();
  }
}
```

#### After:
```dart
class MyScreen extends StatefulWidget {
  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> 
    with MemoryOptimizedMixin, PerformanceOptimizationMixin {
  final _controller = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    // Automatic cleanup registration
    final subscription = someStream.listen((data) {});
    addSubscription(subscription);
  }
  
  // No need for manual dispose - handled automatically
}
```

### 3. Optimize Search with Debouncing

#### Before:
```dart
TextField(
  onChanged: (query) {
    performSearch(query); // Called on every keystroke
  },
)
```

#### After:
```dart
TextField(
  onChanged: (query) {
    debounce('search', const Duration(milliseconds: 300), () {
      performSearch(query); // Called only after user stops typing
    });
  },
)
```

### 4. Use Memoization for Expensive Computations

#### Before:
```dart
@override
Widget build(BuildContext context) {
  final expensiveData = computeExpensiveData(); // Computed every build
  return ExpensiveWidget(data: expensiveData);
}
```

#### After:
```dart
@override
Widget build(BuildContext context) {
  final expensiveData = memoize(
    'expensive_computation',
    () => computeExpensiveData(),
    [dependency1, dependency2], // Only recompute if these change
  );
  return ExpensiveWidget(data: expensiveData);
}
```

## Component Usage

### OptimizedDataManager
```dart
// Create specialized data manager
final recipeManager = RecipeDataManager();

// Cache data for O(1) access
recipeManager.cache(recipe.id, recipe);

// Fast retrieval
final recipe = recipeManager.getById(recipeId); // O(1)

// Efficient search
final results = recipeManager.searchByIndex(query); // O(1)
```

### OptimizedPaginationController
```dart
// Create pagination controller
final controller = OptimizedPaginationController<Recipe>(
  loadFunction: (offset, limit) => loadRecipes(offset, limit),
  pageSize: 20,
);

// Load initial data
await controller.loadInitial();

// Load more data
await controller.loadMore();

// Check if should load more
if (controller.shouldLoadMore(currentIndex)) {
  controller.loadMore();
}
```

### MemoryOptimizedListView
```dart
MemoryOptimizedListView<Recipe>(
  items: recipes,
  itemHeight: 200.0, // Fixed height for better performance
  visibleItemsBuffer: 5, // Items to keep in memory outside viewport
  itemBuilder: (context, recipe, index) {
    return RecipeCard(recipe: recipe);
  },
  onItemVisible: (index) {
    // Called when item becomes visible
    preloadRelatedData(recipes[index]);
  },
)
```

## Performance Monitoring

### Enable Monitoring
```dart
void main() {
  // Enable performance monitoring
  PerformanceMonitor().startMonitoring();
  MemoryMonitor.startMonitoring();
  
  runApp(MyApp());
}
```

### Measure Operations
```dart
// Measure async operations
final result = await PerformanceMonitor().measureAsync(
  'recipe_generation',
  () => generateRecipe(ingredients),
);

// Measure sync operations
final result = PerformanceMonitor().measureSync(
  'data_processing',
  () => processData(rawData),
);
```

### Get Performance Reports
```dart
// Get detailed performance summary
final summary = PerformanceMonitor().getPerformanceSummary();
print('Recipe generation average: ${summary['recipe_generation']['average']}ms');

// Get memory statistics
final memoryStats = MemoryMonitor.getMemoryStats();
print('Current memory: ${memoryStats['currentMB']} MB');
```

## Common Patterns

### 1. Optimized Screen Template
```dart
class OptimizedScreen extends StatefulWidget {
  @override
  State<OptimizedScreen> createState() => _OptimizedScreenState();
}

class _OptimizedScreenState extends State<OptimizedScreen>
    with MemoryOptimizedMixin, PerformanceOptimizationMixin {
  
  final _searchController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }
  
  void _onSearchChanged() {
    debounce('search', const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          // Update search results
        });
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: memoize('screen_body', () {
        return Column(
          children: [
            TextField(controller: _searchController),
            Expanded(
              child: OptimizedRecipeList(
                usePagination: true,
                onRecipeTap: _onRecipeTap,
              ),
            ),
          ],
        );
      }, [/* dependencies */]),
    );
  }
  
  void _onRecipeTap(Recipe recipe) {
    // Handle recipe tap
  }
}
```

### 2. Optimized Provider
```dart
final optimizedRecipeProvider = StateNotifierProvider<
    OptimizedRecipeNotifier, 
    OptimizedRecipeState
>((ref) => OptimizedRecipeNotifier());

class OptimizedRecipeNotifier extends StateNotifier<OptimizedRecipeState> {
  OptimizedRecipeNotifier() : super(const OptimizedRecipeInitial());
  
  final _dataManager = RecipeDataManager();
  final _paginationController = OptimizedPaginationController<Recipe>(
    loadFunction: _loadRecipes,
    pageSize: 20,
  );
  
  Future<List<Recipe>> _loadRecipes(int offset, int limit) async {
    // Load recipes with pagination
    return await recipeService.getPaginatedRecipes(offset, limit);
  }
  
  Future<void> loadInitial() async {
    state = const OptimizedRecipeLoading();
    try {
      await _paginationController.loadInitial();
      state = OptimizedRecipeLoaded(_paginationController.items);
    } catch (e) {
      state = OptimizedRecipeError(e.toString());
    }
  }
  
  @override
  void dispose() {
    _paginationController.dispose();
    _dataManager.clearCache();
    super.dispose();
  }
}
```

## Migration Checklist

- [ ] Replace `ListView.builder` with `OptimizedRecipeList`
- [ ] Add `MemoryOptimizedMixin` to stateful widgets
- [ ] Implement debounced search inputs
- [ ] Use memoization for expensive computations
- [ ] Add `RepaintBoundary` to complex widgets
- [ ] Use `ValueKey` for list items
- [ ] Enable performance monitoring
- [ ] Replace linear searches with indexed lookups
- [ ] Implement pagination for large data sets
- [ ] Add proper resource disposal

## Performance Targets

- **App startup**: < 2 seconds
- **List loading**: < 500ms
- **Search response**: < 100ms
- **Memory usage**: < 150MB stable
- **Frame drops**: < 5% during scrolling
- **Cache hit rate**: > 80%