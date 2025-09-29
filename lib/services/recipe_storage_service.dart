import '../domain/entities/recipe.dart';
import '../domain/enums/difficulty_level.dart';
import '../domain/enums/meal_type.dart';
import '../infrastructure/storage/hive_recipe_storage.dart';
import '../core/performance/optimized_data_manager.dart';
import '../core/performance/memory_optimizer.dart';

/// Enhanced recipe storage service using Hive for better performance and reliability
class RecipeStorageService {
  static final RecipeStorageService _instance =
      RecipeStorageService._internal();
  factory RecipeStorageService() => _instance;
  RecipeStorageService._internal();

  final HiveRecipeStorage _storage = HiveRecipeStorage();
  final RecipeDataManager _dataManager = RecipeDataManager();
  final MemoryOptimizer _memoryOptimizer = MemoryOptimizer();

  // Pagination controller for efficient data loading
  OptimizedPaginationController<Recipe>? _paginationController;

  /// Save a recipe to local storage
  Future<bool> saveRecipe(Recipe recipe) async {
    try {
      return await _storage.saveRecipe(recipe);
    } catch (e) {
      print('Error saving recipe: $e');
      return false;
    }
  }

  /// Get all saved recipes with pagination for better performance
  Future<List<Recipe>> getSavedRecipes({int? limit, int? offset}) async {
    try {
      await _storage.initialize(); // Ensure storage is initialized

      // Use pagination if specified
      if (limit != null && offset != null) {
        return await _storage.getPaginatedRecipes(offset, limit);
      }

      // Check cache first
      final cacheKey = 'all_recipes';
      final cached = _dataManager.getPaginatedData(cacheKey, 0, 1000);
      if (cached != null) {
        return cached.cast<Recipe>();
      }

      final recipes = await _storage.getAllRecipes();

      // Cache the results
      _dataManager.cachePaginatedData(cacheKey, 0, 1000, recipes);

      return recipes;
    } catch (e) {
      print('Error loading saved recipes: $e');
      return [];
    }
  }

  /// Get paginated recipes for efficient loading
  Future<List<Recipe>> getPaginatedRecipes(int offset, int limit) async {
    try {
      await _storage.initialize();
      return await _storage.getPaginatedRecipes(offset, limit);
    } catch (e) {
      print('Error loading paginated recipes: $e');
      return [];
    }
  }

  /// Get pagination controller for efficient list management
  OptimizedPaginationController<Recipe> getPaginationController() {
    _paginationController ??= OptimizedPaginationController<Recipe>(
      loadFunction: (offset, limit) => getPaginatedRecipes(offset, limit),
      pageSize: 20,
    );
    return _paginationController!;
  }

  /// Delete a recipe by ID
  Future<bool> deleteRecipe(String recipeId) async {
    try {
      return await _storage.deleteRecipe(recipeId);
    } catch (e) {
      print('Error deleting recipe: $e');
      return false;
    }
  }

  /// Get a recipe by ID with caching for O(1) access
  Future<Recipe?> getRecipeById(String recipeId) async {
    try {
      // Check cache first for O(1) access
      final cached = _dataManager.getById(recipeId);
      if (cached != null) {
        return cached;
      }

      // Load from storage and cache
      final recipe = await _storage.getRecipeById(recipeId);
      if (recipe != null) {
        _dataManager.cache(recipeId, recipe);
      }

      return recipe;
    } catch (e) {
      return null;
    }
  }

  /// Check if a recipe is saved
  Future<bool> isRecipeSaved(String recipeId) async {
    try {
      return await _storage.recipeExists(recipeId);
    } catch (e) {
      return false;
    }
  }

  /// Search recipes by title or ingredients with optimized indexing
  Future<List<Recipe>> searchRecipes(String query) async {
    try {
      if (query.trim().isEmpty) {
        return await getSavedRecipes();
      }

      // Use optimized search index for O(1) lookups
      final matchingIds = _dataManager.searchByIndex(query);
      if (matchingIds.isNotEmpty) {
        final results = <Recipe>[];
        for (final id in matchingIds) {
          final recipe = _dataManager.getById(id);
          if (recipe != null) {
            results.add(recipe);
          }
        }
        if (results.isNotEmpty) {
          return results;
        }
      }

      // Fallback to storage search and update cache
      final results = await _storage.searchRecipes(query);

      // Update cache with search results
      for (final recipe in results) {
        _dataManager.cache(recipe.id, recipe);
      }

      return results;
    } catch (e) {
      print('Error searching recipes: $e');
      return [];
    }
  }

  /// Add recipe to favorites
  Future<bool> addFavorite(String recipeId) async {
    try {
      return await _storage.addToFavorites(recipeId);
    } catch (e) {
      print('Error adding favorite: $e');
      return false;
    }
  }

  /// Remove recipe from favorites
  Future<bool> removeFavorite(String recipeId) async {
    try {
      return await _storage.removeFromFavorites(recipeId);
    } catch (e) {
      print('Error removing favorite: $e');
      return false;
    }
  }

  /// Toggle favorite status
  Future<bool> toggleFavorite(String recipeId) async {
    try {
      return await _storage.toggleFavorite(recipeId);
    } catch (e) {
      print('Error toggling favorite: $e');
      return false;
    }
  }

  /// Check if recipe is favorite
  Future<bool> isFavoriteRecipe(String recipeId) async {
    try {
      return await _storage.isRecipeFavorite(recipeId);
    } catch (e) {
      return false;
    }
  }

  /// Get all favorite recipe IDs
  Future<List<String>> getFavoriteRecipeIds() async {
    try {
      await _storage.initialize(); // Ensure storage is initialized
      return await _storage.getFavoriteRecipeIds();
    } catch (e) {
      print('Error loading favorites: $e');
      return [];
    }
  }

  /// Get all favorite recipes
  Future<List<Recipe>> getFavoriteRecipes() async {
    try {
      await _storage.initialize(); // Ensure storage is initialized
      return await _storage.getFavoriteRecipes();
    } catch (e) {
      print('Error loading favorite recipes: $e');
      return [];
    }
  }

  /// Get recipes by difficulty level
  Future<List<Recipe>> getRecipesByDifficulty(
      DifficultyLevel difficulty) async {
    try {
      return await _storage.filterRecipes(difficulty: difficulty);
    } catch (e) {
      print('Error filtering recipes by difficulty: $e');
      return [];
    }
  }

  /// Get recipes by cooking time range
  Future<List<Recipe>> getRecipesByTimeRange(
      int minMinutes, int maxMinutes) async {
    try {
      return await _storage.filterRecipes(
        maxPrepTime: maxMinutes,
        maxCookTime: maxMinutes,
      );
    } catch (e) {
      print('Error filtering recipes by time: $e');
      return [];
    }
  }

  /// Get recipes by tags
  Future<List<Recipe>> getRecipesByTags(List<String> tags) async {
    try {
      return await _storage.filterRecipes(tags: tags);
    } catch (e) {
      print('Error filtering recipes by tags: $e');
      return [];
    }
  }

  /// Clear all saved recipes
  Future<bool> clearAllRecipes() async {
    try {
      return await _storage.clearAllData();
    } catch (e) {
      print('Error clearing recipes: $e');
      return false;
    }
  }

  /// Get recipe statistics
  Future<Map<String, dynamic>> getRecipeStatistics() async {
    try {
      await _storage.initialize(); // Ensure storage is initialized
      return await _storage.getRecipeStatistics();
    } catch (e) {
      print('Error getting recipe statistics: $e');
      return {
        'totalRecipes': 0,
        'favoriteRecipes': 0,
        'averageCookingTime': 0,
        'mostCommonDifficulty': 'None',
        'totalIngredients': 0,
        'mostCommonCuisine': 'None',
        'recipesByDifficulty': <String, int>{},
        'recipesByCuisine': <String, int>{},
      };
    }
  }

  /// Filter recipes by multiple criteria
  Future<List<Recipe>> filterRecipes({
    DifficultyLevel? difficulty,
    MealType? mealType,
    String? cuisine,
    List<String>? tags,
    int? maxPrepTime,
    int? maxCookTime,
    bool? isFavorite,
  }) async {
    try {
      return await _storage.filterRecipes(
        difficulty: difficulty,
        mealType: mealType,
        cuisine: cuisine,
        tags: tags,
        maxPrepTime: maxPrepTime,
        maxCookTime: maxCookTime,
        isFavorite: isFavorite,
      );
    } catch (e) {
      print('Error filtering recipes: $e');
      return [];
    }
  }

  /// Get all available tags
  Future<List<String>> getAllTags() async {
    try {
      return await _storage.getAllTags();
    } catch (e) {
      print('Error getting tags: $e');
      return [];
    }
  }

  /// Get recipes by category
  Future<List<Recipe>> getRecipesByCategory(String category) async {
    try {
      return await _storage.getRecipesByCategory(category);
    } catch (e) {
      print('Error getting recipes by category: $e');
      return [];
    }
  }

  /// Export recipes to JSON
  Future<List<Map<String, dynamic>>> exportRecipes() async {
    try {
      return await _storage.exportRecipes();
    } catch (e) {
      print('Error exporting recipes: $e');
      return [];
    }
  }

  /// Import recipes from JSON
  Future<int> importRecipes(List<Map<String, dynamic>> recipesJson) async {
    try {
      return await _storage.importRecipes(recipesJson);
    } catch (e) {
      print('Error importing recipes: $e');
      return 0;
    }
  }

  /// Get storage information
  Map<String, dynamic> getStorageInfo() {
    try {
      return _storage.getStorageInfo();
    } catch (e) {
      print('Error getting storage info: $e');
      return {};
    }
  }
}
