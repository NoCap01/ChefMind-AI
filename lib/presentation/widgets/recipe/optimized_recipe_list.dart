import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/recipe.dart';
import '../../../application/providers/recipe_book_provider.dart';
import '../../../core/performance/memory_optimizer.dart';
import '../../../core/performance/state_optimization.dart';
import 'recipe_card.dart';

/// Optimized recipe list with lazy loading and memory management
class OptimizedRecipeList extends ConsumerStatefulWidget {
  final List<Recipe>? recipes;
  final bool usePagination;
  final ScrollController? scrollController;
  final void Function(Recipe)? onRecipeTap;
  final void Function(Recipe)? onFavoriteToggle;

  const OptimizedRecipeList({
    super.key,
    this.recipes,
    this.usePagination = false,
    this.scrollController,
    this.onRecipeTap,
    this.onFavoriteToggle,
  });

  @override
  ConsumerState<OptimizedRecipeList> createState() =>
      _OptimizedRecipeListState();
}

class _OptimizedRecipeListState extends ConsumerState<OptimizedRecipeList>
    with MemoryOptimizedMixin, PerformanceOptimizationMixin {
  late ScrollController _scrollController;
  final Map<int, Widget> _cachedWidgets = {};

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController ?? ScrollController();
    _scrollController.addListener(_onScroll);

    if (widget.usePagination) {
      // Initialize pagination
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(paginatedRecipeProvider.notifier).initialize();
      });
    }
  }

  void _onScroll() {
    if (!widget.usePagination) return;

    // Check if we need to load more items
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final state = ref.read(paginatedRecipeProvider);
      if (state is PaginatedRecipeLoaded &&
          state.hasMore &&
          !state.isLoadingMore) {
        ref.read(paginatedRecipeProvider.notifier).loadMore();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.usePagination) {
      return _buildPaginatedList();
    } else {
      return _buildStaticList();
    }
  }

  Widget _buildPaginatedList() {
    final state = ref.watch(paginatedRecipeProvider);

    return switch (state) {
      PaginatedRecipeInitial() => const Center(
          child: CircularProgressIndicator(),
        ),
      PaginatedRecipeLoading() => const Center(
          child: CircularProgressIndicator(),
        ),
      PaginatedRecipeLoaded(
        recipes: final recipes,
        hasMore: final hasMore,
        isLoadingMore: final isLoadingMore,
      ) =>
        _buildOptimizedListView(
          recipes: recipes,
          hasMore: hasMore,
          isLoadingMore: isLoadingMore,
        ),
      PaginatedRecipeError(message: final message) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text('Error: $message'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () =>
                    ref.read(paginatedRecipeProvider.notifier).refresh(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
    };
  }

  Widget _buildStaticList() {
    final recipes = widget.recipes ?? [];
    return _buildOptimizedListView(recipes: recipes);
  }

  Widget _buildOptimizedListView({
    required List<Recipe> recipes,
    bool hasMore = false,
    bool isLoadingMore = false,
  }) {
    if (recipes.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant_menu, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('No recipes found'),
          ],
        ),
      );
    }

    return MemoryOptimizedListView<Recipe>(
      items: recipes,
      controller: _scrollController,
      itemHeight: 200.0, // Approximate height for better performance
      itemBuilder: (context, recipe, index) {
        // Use memoization to avoid rebuilding identical cards
        return memoize(
          'recipe_card_${recipe.id}',
          () => _buildRecipeCard(recipe, index),
          [recipe.id, recipe.isFavorite, recipe.title],
        );
      },
    );
  }

  Widget _buildRecipeCard(Recipe recipe, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: RepaintBoundary(
        child: RecipeCard(
          recipe: recipe,
          onTap: () => widget.onRecipeTap?.call(recipe),
          onFavoriteToggle: () => widget.onFavoriteToggle?.call(recipe),
          // Add performance monitoring in debug mode
          key: ValueKey('recipe_${recipe.id}'),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cachedWidgets.clear();
    if (widget.scrollController == null) {
      _scrollController.dispose();
    } else {
      _scrollController.removeListener(_onScroll);
    }
    super.dispose();
  }
}

/// Optimized recipe grid for better space utilization
class OptimizedRecipeGrid extends ConsumerStatefulWidget {
  final List<Recipe> recipes;
  final int crossAxisCount;
  final double childAspectRatio;
  final void Function(Recipe)? onRecipeTap;
  final void Function(Recipe)? onFavoriteToggle;

  const OptimizedRecipeGrid({
    super.key,
    required this.recipes,
    this.crossAxisCount = 2,
    this.childAspectRatio = 0.8,
    this.onRecipeTap,
    this.onFavoriteToggle,
  });

  @override
  ConsumerState<OptimizedRecipeGrid> createState() =>
      _OptimizedRecipeGridState();
}

class _OptimizedRecipeGridState extends ConsumerState<OptimizedRecipeGrid>
    with PerformanceOptimizationMixin {
  @override
  Widget build(BuildContext context) {
    if (widget.recipes.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant_menu, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('No recipes found'),
          ],
        ),
      );
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.crossAxisCount,
        childAspectRatio: widget.childAspectRatio,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: widget.recipes.length,
      itemBuilder: (context, index) {
        final recipe = widget.recipes[index];

        // Use memoization for grid items too
        return memoize(
          'recipe_grid_${recipe.id}',
          () => RepaintBoundary(
            child: RecipeCard(
              recipe: recipe,
              onTap: () => widget.onRecipeTap?.call(recipe),
              onFavoriteToggle: () => widget.onFavoriteToggle?.call(recipe),
              isCompact: true,
              key: ValueKey('recipe_grid_${recipe.id}'),
            ),
          ),
          [recipe.id, recipe.isFavorite, recipe.title],
        );
      },
      // Performance optimizations
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: false, // We're adding them manually
      addSemanticIndexes: true,
    );
  }
}

/// Sliver version for use in CustomScrollView
class OptimizedRecipeSliverList extends ConsumerWidget {
  final List<Recipe> recipes;
  final void Function(Recipe)? onRecipeTap;
  final void Function(Recipe)? onFavoriteToggle;

  const OptimizedRecipeSliverList({
    super.key,
    required this.recipes,
    this.onRecipeTap,
    this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (recipes.isEmpty) {
      return const SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.restaurant_menu, size: 64, color: Colors.grey),
              SizedBox(height: 16),
              Text('No recipes found'),
            ],
          ),
        ),
      );
    }

    return SliverList.builder(
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        final recipe = recipes[index];

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: RepaintBoundary(
            child: RecipeCard(
              recipe: recipe,
              onTap: () => onRecipeTap?.call(recipe),
              onFavoriteToggle: () => onFavoriteToggle?.call(recipe),
              key: ValueKey('recipe_sliver_${recipe.id}'),
            ),
          ),
        );
      },
    );
  }
}
