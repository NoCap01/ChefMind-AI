import 'package:hive_flutter/hive_flutter.dart';
import '../../domain/entities/recipe.dart';
import '../../domain/entities/pantry_item.dart';
import '../../domain/entities/shopping_list_item.dart';
import '../../domain/enums/difficulty_level.dart';
import '../../domain/enums/meal_type.dart';
import '../../core/errors/app_exceptions.dart';
import 'hive_adapters.dart';

/// Hive-based recipe storage service with proper error handling and data validation
class HiveRecipeStorage {
  static const String _recipesBoxName = 'recipes';
  static const String _favoritesBoxName = 'favorites';
  static const String _categoriesBoxName = 'recipe_categories';
  static const String _tagsBoxName = 'recipe_tags';
  static const String _metadataBoxName = 'metadata';

  static final HiveRecipeStorage _instance = HiveRecipeStorage._internal();
  factory HiveRecipeStorage() => _instance;
  HiveRecipeStorage._internal();

  Box<Recipe>? _recipesBox;
  Box<List<String>>? _favoritesBox;
  Box<Map<String, dynamic>>? _categoriesBox;
  Box<dynamic>? _metadataBox;
  Box<List<String>>? _tagsBox;

  bool _initialized = false;

  /// Initialize Hive storage with adapters and boxes
  Future<void> initialize() async {
    if (_initialized) return;

    try {
      // Register adapters if not already registered
      if (!Hive.isAdapterRegistered(recipeTypeId)) {
        Hive.registerAdapter(RecipeAdapter());
      }
      if (!Hive.isAdapterRegistered(ingredientTypeId)) {
        Hive.registerAdapter(IngredientAdapter());
      }
      if (!Hive.isAdapterRegistered(cookingStepTypeId)) {
        Hive.registerAdapter(CookingStepAdapter());
      }
      if (!Hive.isAdapterRegistered(recipeMetadataTypeId)) {
        Hive.registerAdapter(RecipeMetadataAdapter());
      }
      if (!Hive.isAdapterRegistered(nutritionInfoTypeId)) {
        Hive.registerAdapter(NutritionInfoAdapter());
      }
      if (!Hive.isAdapterRegistered(difficultyLevelTypeId)) {
        Hive.registerAdapter(DifficultyLevelAdapter());
      }
      if (!Hive.isAdapterRegistered(mealTypeTypeId)) {
        Hive.registerAdapter(MealTypeAdapter());
      }
      if (!Hive.isAdapterRegistered(8)) {
        Hive.registerAdapter(PantryItemAdapter());
      }
      if (!Hive.isAdapterRegistered(9)) {
        Hive.registerAdapter(ShoppingListItemAdapter());
      }

      // Open boxes
      _recipesBox = await Hive.openBox<Recipe>(_recipesBoxName);
      _favoritesBox = await Hive.openBox<List<String>>(_favoritesBoxName);
      _categoriesBox =
          await Hive.openBox<Map<String, dynamic>>(_categoriesBoxName);
      _metadataBox = await Hive.openBox<dynamic>(_metadataBoxName);
      _tagsBox = await Hive.openBox<List<String>>(_tagsBoxName);

      _initialized = true;

      // Perform data migration if needed
      await _performDataMigration();
    } catch (e) {
      throw StorageException('Failed to initialize recipe storage: $e');
    }
  }

  /// Perform data migration from older versions
  Future<void> _performDataMigration() async {
    try {
      // Check if migration is needed by looking for version key
      final currentVersion =
          (_metadataBox!.get('_storage_version') as int?) ?? 1;
      const latestVersion = 2;

      if (currentVersion < latestVersion) {
        await _migrateToVersion2();
        await _metadataBox!.put('_storage_version', latestVersion);
      }
    } catch (e) {
      // Log migration error but don't fail initialization
      print('Migration warning: $e');
    }
  }

  /// Migrate to version 2 - add missing fields to existing recipes
  Future<void> _migrateToVersion2() async {
    final recipes =
        _recipesBox!.values.whereType<Recipe>().cast<Recipe>().toList();

    for (final recipe in recipes) {
      // Update recipes that might be missing new fields
      final updatedRecipe = recipe.copyWith(
        updatedAt: recipe.updatedAt ?? recipe.createdAt,
        timesCooked: recipe.timesCooked ?? 0,
      );

      if (updatedRecipe != recipe) {
        await _recipesBox!.put(recipe.id, updatedRecipe);
      }
    }
  }

  void _ensureInitialized() {
    if (!_initialized) {
      throw const StorageException('HiveRecipeStorage not initialized');
    }
  }

  /// Validate recipe data before storage
  bool _validateRecipe(Recipe recipe) {
    if (recipe.id.isEmpty) return false;
    if (recipe.title.trim().isEmpty) return false;
    if (recipe.ingredients.isEmpty) return false;
    if (recipe.instructions.isEmpty) return false;
    return true;
  }

  /// Save a recipe to storage
  Future<bool> saveRecipe(Recipe recipe) async {
    _ensureInitialized();

    if (!_validateRecipe(recipe)) {
      throw const ValidationException('Invalid recipe data');
    }

    try {
      // Update the updatedAt timestamp
      final updatedRecipe = recipe.copyWith(
        updatedAt: DateTime.now(),
      );

      await _recipesBox!.put(recipe.id, updatedRecipe);

      // Update tags index
      await _updateTagsIndex(recipe.tags);

      return true;
    } catch (e) {
      throw StorageException('Failed to save recipe: $e');
    }
  }

  /// Get all saved recipes
  Future<List<Recipe>> getAllRecipes() async {
    _ensureInitialized();

    try {
      return _recipesBox!.values.whereType<Recipe>().cast<Recipe>().toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } catch (e) {
      throw StorageException('Failed to load recipes: $e');
    }
  }

  /// Get paginated recipes for efficient loading
  Future<List<Recipe>> getPaginatedRecipes(int offset, int limit) async {
    _ensureInitialized();

    try {
      final allRecipes = _recipesBox!.values
          .whereType<Recipe>()
          .cast<Recipe>()
          .toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

      final endIndex = (offset + limit).clamp(0, allRecipes.length);
      if (offset >= allRecipes.length) {
        return [];
      }

      return allRecipes.sublist(offset, endIndex);
    } catch (e) {
      throw StorageException('Failed to load paginated recipes: $e');
    }
  }

  /// Get a recipe by ID
  Future<Recipe?> getRecipeById(String recipeId) async {
    _ensureInitialized();

    try {
      return _recipesBox!.get(recipeId);
    } catch (e) {
      throw StorageException('Failed to get recipe: $e');
    }
  }

  /// Delete a recipe by ID
  Future<bool> deleteRecipe(String recipeId) async {
    _ensureInitialized();

    try {
      await _recipesBox!.delete(recipeId);
      await _removeFavoriteById(recipeId);
      return true;
    } catch (e) {
      throw StorageException('Failed to delete recipe: $e');
    }
  }

  /// Check if a recipe exists
  Future<bool> recipeExists(String recipeId) async {
    _ensureInitialized();
    return _recipesBox!.containsKey(recipeId);
  }

  /// Search recipes by query
  Future<List<Recipe>> searchRecipes(String query) async {
    _ensureInitialized();

    if (query.trim().isEmpty) {
      return getAllRecipes();
    }

    try {
      final allRecipes = await getAllRecipes();
      final lowerQuery = query.toLowerCase();

      return allRecipes.where((recipe) {
        // Search in title
        if (recipe.title.toLowerCase().contains(lowerQuery)) return true;

        // Search in description
        if (recipe.description.toLowerCase().contains(lowerQuery)) return true;

        // Search in ingredients
        if (recipe.ingredients.any((ingredient) =>
            ingredient.name.toLowerCase().contains(lowerQuery))) {
          return true;
        }

        // Search in tags
        if (recipe.tags.any((tag) => tag.toLowerCase().contains(lowerQuery))) {
          return true;
        }

        // Search in cuisine
        if (recipe.metadata.cuisine?.toLowerCase().contains(lowerQuery) == true)
          return true;

        return false;
      }).toList();
    } catch (e) {
      throw StorageException('Failed to search recipes: $e');
    }
  }

  /// Filter recipes by criteria
  Future<List<Recipe>> filterRecipes({
    DifficultyLevel? difficulty,
    MealType? mealType,
    String? cuisine,
    List<String>? tags,
    int? maxPrepTime,
    int? maxCookTime,
    bool? isFavorite,
  }) async {
    _ensureInitialized();

    try {
      final allRecipes = await getAllRecipes();
      final favoriteIds = await getFavoriteRecipeIds();

      return allRecipes.where((recipe) {
        // Filter by difficulty
        if (difficulty != null && recipe.metadata.difficulty != difficulty) {
          return false;
        }

        // Filter by meal type
        if (mealType != null && recipe.metadata.mealType != mealType) {
          return false;
        }

        // Filter by cuisine
        if (cuisine != null &&
            recipe.metadata.cuisine?.toLowerCase() != cuisine.toLowerCase()) {
          return false;
        }

        // Filter by tags
        if (tags != null && tags.isNotEmpty) {
          if (!tags.any((tag) => recipe.tags.contains(tag))) {
            return false;
          }
        }

        // Filter by prep time
        if (maxPrepTime != null && recipe.metadata.prepTime > maxPrepTime) {
          return false;
        }

        // Filter by cook time
        if (maxCookTime != null && recipe.metadata.cookTime > maxCookTime) {
          return false;
        }

        // Filter by favorite status
        if (isFavorite != null) {
          final isRecipeFavorite = favoriteIds.contains(recipe.id);
          if (isFavorite != isRecipeFavorite) {
            return false;
          }
        }

        return true;
      }).toList();
    } catch (e) {
      throw StorageException('Failed to filter recipes: $e');
    }
  }

  /// Add recipe to favorites
  Future<bool> addToFavorites(String recipeId) async {
    _ensureInitialized();

    try {
      final favorites = await getFavoriteRecipeIds();
      if (!favorites.contains(recipeId)) {
        favorites.add(recipeId);
        await _favoritesBox!.put('favorites', favorites);
      }
      return true;
    } catch (e) {
      throw StorageException('Failed to add to favorites: $e');
    }
  }

  /// Remove recipe from favorites
  Future<bool> removeFromFavorites(String recipeId) async {
    _ensureInitialized();

    try {
      await _removeFavoriteById(recipeId);
      return true;
    } catch (e) {
      throw StorageException('Failed to remove from favorites: $e');
    }
  }

  /// Toggle favorite status
  Future<bool> toggleFavorite(String recipeId) async {
    final isFavorite = await isRecipeFavorite(recipeId);

    if (isFavorite) {
      return await removeFromFavorites(recipeId);
    } else {
      return await addToFavorites(recipeId);
    }
  }

  /// Check if recipe is favorite
  Future<bool> isRecipeFavorite(String recipeId) async {
    final favorites = await getFavoriteRecipeIds();
    return favorites.contains(recipeId);
  }

  /// Get favorite recipe IDs
  Future<List<String>> getFavoriteRecipeIds() async {
    _ensureInitialized();

    try {
      return _favoritesBox!.get('favorites', defaultValue: <String>[]) ??
          <String>[];
    } catch (e) {
      return <String>[];
    }
  }

  /// Get favorite recipes
  Future<List<Recipe>> getFavoriteRecipes() async {
    _ensureInitialized();

    try {
      final favoriteIds = await getFavoriteRecipeIds();
      final allRecipes = await getAllRecipes();

      return allRecipes
          .where((recipe) => favoriteIds.contains(recipe.id))
          .toList();
    } catch (e) {
      throw StorageException('Failed to get favorite recipes: $e');
    }
  }

  /// Remove favorite by ID (internal helper)
  Future<void> _removeFavoriteById(String recipeId) async {
    final favorites = await getFavoriteRecipeIds();
    favorites.remove(recipeId);
    await _favoritesBox!.put('favorites', favorites);
  }

  /// Update tags index for search optimization
  Future<void> _updateTagsIndex(List<String> recipeTags) async {
    try {
      final allTags =
          _tagsBox!.get('all_tags', defaultValue: <String>[]) ?? <String>[];

      for (final tag in recipeTags) {
        if (!allTags.contains(tag)) {
          allTags.add(tag);
        }
      }

      await _tagsBox!.put('all_tags', allTags);
    } catch (e) {
      // Non-critical error, just log it
      print('Failed to update tags index: $e');
    }
  }

  /// Get all available tags
  Future<List<String>> getAllTags() async {
    _ensureInitialized();

    try {
      return _tagsBox!.get('all_tags', defaultValue: <String>[]) ?? <String>[];
    } catch (e) {
      return <String>[];
    }
  }

  /// Get recipes by category
  Future<List<Recipe>> getRecipesByCategory(String category) async {
    return filterRecipes(tags: [category]);
  }

  /// Get recipe statistics
  Future<Map<String, dynamic>> getRecipeStatistics() async {
    _ensureInitialized();

    try {
      final allRecipes = await getAllRecipes();
      final favoriteIds = await getFavoriteRecipeIds();

      if (allRecipes.isEmpty) {
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

      final totalCookingTime = allRecipes.fold<int>(
        0,
        (sum, recipe) => sum + recipe.totalTime,
      );

      final difficultyCount = <String, int>{};
      final cuisineCount = <String, int>{};
      int totalIngredients = 0;

      for (final recipe in allRecipes) {
        final difficulty = recipe.metadata.difficulty.name;
        difficultyCount[difficulty] = (difficultyCount[difficulty] ?? 0) + 1;

        final cuisine = recipe.metadata.cuisine ?? 'Unknown';
        cuisineCount[cuisine] = (cuisineCount[cuisine] ?? 0) + 1;

        totalIngredients += recipe.ingredients.length;
      }

      final mostCommonDifficulty = difficultyCount.entries.isNotEmpty
          ? difficultyCount.entries
              .reduce((a, b) => a.value > b.value ? a : b)
              .key
          : 'None';

      final mostCommonCuisine = cuisineCount.entries.isNotEmpty
          ? cuisineCount.entries.reduce((a, b) => a.value > b.value ? a : b).key
          : 'None';

      return {
        'totalRecipes': allRecipes.length,
        'favoriteRecipes': favoriteIds.length,
        'averageCookingTime': (totalCookingTime / allRecipes.length).round(),
        'mostCommonDifficulty': mostCommonDifficulty,
        'totalIngredients': totalIngredients,
        'mostCommonCuisine': mostCommonCuisine,
        'recipesByDifficulty': difficultyCount,
        'recipesByCuisine': cuisineCount,
      };
    } catch (e) {
      throw StorageException('Failed to get recipe statistics: $e');
    }
  }

  /// Clear all recipes and related data
  Future<bool> clearAllData() async {
    _ensureInitialized();

    try {
      await _recipesBox!.clear();
      await _favoritesBox!.clear();
      await _categoriesBox!.clear();
      await _tagsBox!.clear();
      return true;
    } catch (e) {
      throw StorageException('Failed to clear all data: $e');
    }
  }

  /// Export recipes to JSON format
  Future<List<Map<String, dynamic>>> exportRecipes() async {
    _ensureInitialized();

    try {
      final allRecipes = await getAllRecipes();
      return allRecipes.map((recipe) => recipe.toJson()).toList();
    } catch (e) {
      throw StorageException('Failed to export recipes: $e');
    }
  }

  /// Import recipes from JSON format
  Future<int> importRecipes(List<Map<String, dynamic>> recipesJson) async {
    _ensureInitialized();

    int importedCount = 0;

    try {
      for (final recipeJson in recipesJson) {
        try {
          final recipe = Recipe.fromJson(recipeJson);
          if (_validateRecipe(recipe)) {
            await saveRecipe(recipe);
            importedCount++;
          }
        } catch (e) {
          // Skip invalid recipes but continue importing others
          print('Skipped invalid recipe during import: $e');
        }
      }

      return importedCount;
    } catch (e) {
      throw StorageException('Failed to import recipes: $e');
    }
  }

  /// Get storage info
  Map<String, dynamic> getStorageInfo() {
    _ensureInitialized();

    return {
      'recipesCount': _recipesBox!.length,
      'favoritesCount': _favoritesBox!.length,
      'categoriesCount': _categoriesBox!.length,
      'tagsCount': _tagsBox!.length,
      'isInitialized': _initialized,
    };
  }

  /// Close all boxes and cleanup
  Future<void> dispose() async {
    if (_initialized) {
      await _recipesBox?.close();
      await _favoritesBox?.close();
      await _categoriesBox?.close();
      await _tagsBox?.close();
      _initialized = false;
    }
  }
}
