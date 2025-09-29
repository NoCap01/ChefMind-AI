import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/recipe.dart';
import '../../domain/enums/difficulty_level.dart';
import '../../domain/enums/meal_type.dart';
import '../../services/recipe_storage_service.dart';
import '../../core/performance/optimized_data_manager.dart';
import '../../core/performance/state_optimization.dart';

// Recipe book state
sealed class RecipeBookState {
  const RecipeBookState();
}

class RecipeBookInitial extends RecipeBookState {
  const RecipeBookInitial();
}

class RecipeBookLoading extends RecipeBookState {
  const RecipeBookLoading();
}

class RecipeBookLoaded extends RecipeBookState {
  final List<Recipe> recipes;
  final List<Recipe> favoriteRecipes;
  final List<String> availableTags;
  final Map<String, dynamic> statistics;

  const RecipeBookLoaded({
    required this.recipes,
    required this.favoriteRecipes,
    required this.availableTags,
    required this.statistics,
  });

  RecipeBookLoaded copyWith({
    List<Recipe>? recipes,
    List<Recipe>? favoriteRecipes,
    List<String>? availableTags,
    Map<String, dynamic>? statistics,
  }) {
    return RecipeBookLoaded(
      recipes: recipes ?? this.recipes,
      favoriteRecipes: favoriteRecipes ?? this.favoriteRecipes,
      availableTags: availableTags ?? this.availableTags,
      statistics: statistics ?? this.statistics,
    );
  }
}

class RecipeBookError extends RecipeBookState {
  final String message;
  const RecipeBookError(this.message);
}

// Recipe book provider with optimized state management
final recipeBookProvider =
    StateNotifierProvider<RecipeBookNotifier, RecipeBookState>(
  (ref) => RecipeBookNotifier(),
);

// Paginated recipe provider for efficient loading
final paginatedRecipeProvider =
    StateNotifierProvider<PaginatedRecipeNotifier, PaginatedRecipeState>(
  (ref) => PaginatedRecipeNotifier(),
);

class RecipeBookNotifier extends StateNotifier<RecipeBookState> {
  RecipeBookNotifier() : super(const RecipeBookInitial()) {
    loadRecipes();
  }

  final RecipeStorageService _storageService = RecipeStorageService();
  final RecipeDataManager _dataManager = RecipeDataManager();

  /// Load all recipes and related data
  Future<void> loadRecipes() async {
    state = const RecipeBookLoading();

    try {
      // Initialize storage first - this is handled internally by the service

      final recipes = await _storageService.getSavedRecipes();
      final favoriteRecipes = await _storageService.getFavoriteRecipes();
      final availableTags = await _storageService.getAllTags();

      // Update recipes with favorite status
      final favoriteIds = await _storageService.getFavoriteRecipeIds();
      final updatedRecipes = recipes.map((recipe) {
        return recipe.copyWith(isFavorite: favoriteIds.contains(recipe.id));
      }).toList();

      final updatedFavoriteRecipes = favoriteRecipes.map((recipe) {
        return recipe.copyWith(isFavorite: true);
      }).toList();

      final statistics = await _storageService.getRecipeStatistics();

      state = RecipeBookLoaded(
        recipes: updatedRecipes,
        favoriteRecipes: updatedFavoriteRecipes,
        availableTags: availableTags,
        statistics: statistics,
      );
    } catch (e) {
      state = RecipeBookError('Failed to load recipes: $e');
    }
  }

  /// Refresh all data
  Future<void> refresh() async {
    await loadRecipes();
  }

  /// Save a new recipe
  Future<bool> saveRecipe(Recipe recipe) async {
    try {
      final success = await _storageService.saveRecipe(recipe);
      if (success) {
        await loadRecipes(); // Refresh the state
      }
      return success;
    } catch (e) {
      state = RecipeBookError('Failed to save recipe: $e');
      return false;
    }
  }

  /// Delete a recipe
  Future<bool> deleteRecipe(String recipeId) async {
    try {
      final success = await _storageService.deleteRecipe(recipeId);
      if (success) {
        await loadRecipes(); // Refresh the state
      }
      return success;
    } catch (e) {
      state = RecipeBookError('Failed to delete recipe: $e');
      return false;
    }
  }

  /// Toggle favorite status
  Future<bool> toggleFavorite(String recipeId) async {
    try {
      final success = await _storageService.toggleFavorite(recipeId);
      if (success) {
        // Update the current state immediately for better UX
        if (state is RecipeBookLoaded) {
          final currentState = state as RecipeBookLoaded;
          final updatedRecipes = currentState.recipes.map((recipe) {
            if (recipe.id == recipeId) {
              return recipe.copyWith(isFavorite: !recipe.isFavorite);
            }
            return recipe;
          }).toList();

          final favoriteRecipes =
              updatedRecipes.where((recipe) => recipe.isFavorite).toList();

          // Update statistics
          final updatedStats =
              Map<String, dynamic>.from(currentState.statistics);
          updatedStats['favoriteRecipes'] = favoriteRecipes.length;

          state = currentState.copyWith(
            recipes: updatedRecipes,
            favoriteRecipes: favoriteRecipes,
            statistics: updatedStats,
          );
        }
      }
      return success;
    } catch (e) {
      state = RecipeBookError('Failed to toggle favorite: $e');
      return false;
    }
  }

  /// Get recipe by ID
  Future<Recipe?> getRecipeById(String recipeId) async {
    try {
      return await _storageService.getRecipeById(recipeId);
    } catch (e) {
      return null;
    }
  }
}

// Recipe search provider
final recipeSearchProvider =
    StateNotifierProvider<RecipeSearchNotifier, RecipeSearchState>(
  (ref) => RecipeSearchNotifier(),
);

class RecipeSearchNotifier extends StateNotifier<RecipeSearchState> {
  RecipeSearchNotifier() : super(const RecipeSearchInitial());

  final RecipeStorageService _storageService = RecipeStorageService();

  /// Search recipes by query
  Future<void> searchRecipes(String query) async {
    if (query.trim().isEmpty) {
      state = const RecipeSearchInitial();
      return;
    }

    state = const RecipeSearchLoading();

    try {
      final results = await _storageService.searchRecipes(query);
      state = RecipeSearchSuccess(results);
    } catch (e) {
      state = RecipeSearchError('Search failed: $e');
    }
  }

  /// Filter recipes by criteria
  Future<void> filterRecipes({
    DifficultyLevel? difficulty,
    MealType? mealType,
    String? cuisine,
    List<String>? tags,
    int? maxPrepTime,
    int? maxCookTime,
    bool? isFavorite,
  }) async {
    state = const RecipeSearchLoading();

    try {
      final results = await _storageService.filterRecipes(
        difficulty: difficulty,
        mealType: mealType,
        cuisine: cuisine,
        tags: tags,
        maxPrepTime: maxPrepTime,
        maxCookTime: maxCookTime,
        isFavorite: isFavorite,
      );
      state = RecipeSearchSuccess(results);
    } catch (e) {
      state = RecipeSearchError('Filter failed: $e');
    }
  }

  /// Clear search results
  void clearSearch() {
    state = const RecipeSearchInitial();
  }
}

// Recipe search state classes
sealed class RecipeSearchState {
  const RecipeSearchState();
}

class RecipeSearchInitial extends RecipeSearchState {
  const RecipeSearchInitial();
}

class RecipeSearchLoading extends RecipeSearchState {
  const RecipeSearchLoading();
}

class RecipeSearchSuccess extends RecipeSearchState {
  final List<Recipe> recipes;
  const RecipeSearchSuccess(this.recipes);
}

class RecipeSearchError extends RecipeSearchState {
  final String message;
  const RecipeSearchError(this.message);
}

// Recipe filter provider for advanced filtering
final recipeFilterProvider =
    StateNotifierProvider<RecipeFilterNotifier, RecipeFilterState>(
  (ref) => RecipeFilterNotifier(),
);

class RecipeFilterNotifier extends StateNotifier<RecipeFilterState> {
  RecipeFilterNotifier() : super(const RecipeFilterState());

  void updateDifficulty(DifficultyLevel? difficulty) {
    state = state.copyWith(difficulty: difficulty);
  }

  void updateMealType(MealType? mealType) {
    state = state.copyWith(mealType: mealType);
  }

  void updateCuisine(String? cuisine) {
    state = state.copyWith(cuisine: cuisine);
  }

  void updateTags(List<String> tags) {
    state = state.copyWith(tags: tags);
  }

  void updateMaxPrepTime(int? maxPrepTime) {
    state = state.copyWith(maxPrepTime: maxPrepTime);
  }

  void updateMaxCookTime(int? maxCookTime) {
    state = state.copyWith(maxCookTime: maxCookTime);
  }

  void updateFavoriteOnly(bool favoriteOnly) {
    state = state.copyWith(favoriteOnly: favoriteOnly);
  }

  void clearFilters() {
    state = const RecipeFilterState();
  }

  bool get hasActiveFilters {
    return state.difficulty != null ||
        state.mealType != null ||
        state.cuisine != null ||
        state.tags.isNotEmpty ||
        state.maxPrepTime != null ||
        state.maxCookTime != null ||
        state.favoriteOnly;
  }
}

// Recipe filter state
class RecipeFilterState {
  final DifficultyLevel? difficulty;
  final MealType? mealType;
  final String? cuisine;
  final List<String> tags;
  final int? maxPrepTime;
  final int? maxCookTime;
  final bool favoriteOnly;

  const RecipeFilterState({
    this.difficulty,
    this.mealType,
    this.cuisine,
    this.tags = const [],
    this.maxPrepTime,
    this.maxCookTime,
    this.favoriteOnly = false,
  });

  RecipeFilterState copyWith({
    DifficultyLevel? difficulty,
    MealType? mealType,
    String? cuisine,
    List<String>? tags,
    int? maxPrepTime,
    int? maxCookTime,
    bool? favoriteOnly,
  }) {
    return RecipeFilterState(
      difficulty: difficulty ?? this.difficulty,
      mealType: mealType ?? this.mealType,
      cuisine: cuisine ?? this.cuisine,
      tags: tags ?? this.tags,
      maxPrepTime: maxPrepTime ?? this.maxPrepTime,
      maxCookTime: maxCookTime ?? this.maxCookTime,
      favoriteOnly: favoriteOnly ?? this.favoriteOnly,
    );
  }
}

// Individual recipe provider for recipe details
final recipeDetailProvider =
    FutureProvider.family<Recipe?, String>((ref, recipeId) async {
  final storageService = RecipeStorageService();
  return await storageService.getRecipeById(recipeId);
});

// Recipe statistics provider
final recipeStatisticsProvider =
    FutureProvider<Map<String, dynamic>>((ref) async {
  final storageService = RecipeStorageService();
  return await storageService.getRecipeStatistics();
});

// Available tags provider
final availableTagsProvider = FutureProvider<List<String>>((ref) async {
  final storageService = RecipeStorageService();
  return await storageService.getAllTags();
});

// Paginated recipe state classes
sealed class PaginatedRecipeState {
  const PaginatedRecipeState();
}

class PaginatedRecipeInitial extends PaginatedRecipeState {
  const PaginatedRecipeInitial();
}

class PaginatedRecipeLoading extends PaginatedRecipeState {
  const PaginatedRecipeLoading();
}

class PaginatedRecipeLoaded extends PaginatedRecipeState {
  final List<Recipe> recipes;
  final bool hasMore;
  final int currentPage;
  final bool isLoadingMore;

  const PaginatedRecipeLoaded({
    required this.recipes,
    required this.hasMore,
    required this.currentPage,
    this.isLoadingMore = false,
  });

  PaginatedRecipeLoaded copyWith({
    List<Recipe>? recipes,
    bool? hasMore,
    int? currentPage,
    bool? isLoadingMore,
  }) {
    return PaginatedRecipeLoaded(
      recipes: recipes ?? this.recipes,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

class PaginatedRecipeError extends PaginatedRecipeState {
  final String message;
  const PaginatedRecipeError(this.message);
}

// Paginated recipe notifier for efficient loading
class PaginatedRecipeNotifier extends StateNotifier<PaginatedRecipeState> {
  PaginatedRecipeNotifier() : super(const PaginatedRecipeInitial());

  final RecipeStorageService _storageService = RecipeStorageService();
  OptimizedPaginationController<Recipe>? _controller;

  /// Initialize pagination controller
  void initialize() {
    _controller = _storageService.getPaginationController();
    loadInitial();
  }

  /// Load initial page
  Future<void> loadInitial() async {
    if (_controller == null) {
      initialize();
      return;
    }

    state = const PaginatedRecipeLoading();

    try {
      await _controller!.loadInitial();

      state = PaginatedRecipeLoaded(
        recipes: _controller!.items,
        hasMore: _controller!.hasMore,
        currentPage: 0,
      );
    } catch (e) {
      state = PaginatedRecipeError('Failed to load recipes: $e');
    }
  }

  /// Load more recipes
  Future<void> loadMore() async {
    if (_controller == null || state is! PaginatedRecipeLoaded) return;

    final currentState = state as PaginatedRecipeLoaded;
    if (!currentState.hasMore || currentState.isLoadingMore) return;

    state = currentState.copyWith(isLoadingMore: true);

    try {
      await _controller!.loadMore();

      state = PaginatedRecipeLoaded(
        recipes: _controller!.items,
        hasMore: _controller!.hasMore,
        currentPage: currentState.currentPage + 1,
        isLoadingMore: false,
      );
    } catch (e) {
      state = PaginatedRecipeError('Failed to load more recipes: $e');
    }
  }

  /// Refresh all data
  Future<void> refresh() async {
    if (_controller == null) {
      initialize();
      return;
    }

    try {
      await _controller!.refresh();

      state = PaginatedRecipeLoaded(
        recipes: _controller!.items,
        hasMore: _controller!.hasMore,
        currentPage: 0,
      );
    } catch (e) {
      state = PaginatedRecipeError('Failed to refresh recipes: $e');
    }
  }

  /// Check if should load more based on scroll position
  void checkLoadMore(int currentIndex) {
    if (_controller?.shouldLoadMore(currentIndex) == true) {
      loadMore();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
