import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';

import '../../domain/entities/recipe.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/recipe_repository.dart';
import '../../domain/services/recipe_generation_service.dart';
import '../../domain/exceptions/app_exceptions.dart';
import '../../infrastructure/repositories/firebase_recipe_repository.dart';
import '../../infrastructure/services/recipe_generation_service_impl.dart';
import 'auth_provider.dart';

// Repository and service providers
final recipeRepositoryProvider = Provider<IRecipeRepository>((ref) {
  return FirebaseRecipeRepository.instance;
});

final recipeGenerationServiceProvider = Provider<IRecipeGenerationService>((ref) {
  return RecipeGenerationServiceImpl.instance;
});

// Recipe state providers
final recipeStateProvider = StateNotifierProvider<RecipeStateNotifier, RecipeState>((ref) {
  final repository = ref.watch(recipeRepositoryProvider);
  final generationService = ref.watch(recipeGenerationServiceProvider);
  final userId = ref.watch(currentUserIdProvider);
  return RecipeStateNotifier(repository, generationService, userId);
});

// Recipe generation providers
final recipeGenerationProvider = StateNotifierProvider<RecipeGenerationNotifier, RecipeGenerationState>((ref) {
  final generationService = ref.watch(recipeGenerationServiceProvider);
  final userPreferences = ref.watch(userPreferencesProvider);
  return RecipeGenerationNotifier(generationService, userPreferences);
});

// Recipe search and filtering providers
final recipeSearchProvider = StateProvider<String>((ref) => '');
final recipeFilterProvider = StateProvider<RecipeFilter>((ref) => const RecipeFilter());
final recipeSortProvider = StateProvider<RecipeSortOption>((ref) => RecipeSortOption.dateCreated);

// Filtered and sorted recipes provider
final filteredRecipesProvider = Provider<List<Recipe>>((ref) {
  final recipes = ref.watch(recipeStateProvider).recipes;
  final searchQuery = ref.watch(recipeSearchProvider);
  final filter = ref.watch(recipeFilterProvider);
  final sortOption = ref.watch(recipeSortProvider);
  
  return _filterAndSortRecipes(recipes, searchQuery, filter, sortOption);
});

// Recipe collections providers
final favoriteRecipesProvider = Provider<List<Recipe>>((ref) {
  final recipes = ref.watch(recipeStateProvider).recipes;
  return recipes.where((recipe) => recipe.isFavorite).toList();
});

final recentRecipesProvider = Provider<List<Recipe>>((ref) {
  final recipes = ref.watch(recipeStateProvider).recipes;
  final sortedRecipes = List<Recipe>.from(recipes)
    ..sort((a, b) => b.lastViewedAt?.compareTo(a.lastViewedAt ?? DateTime(0)) ?? 0);
  return sortedRecipes.take(10).toList();
});

final topRatedRecipesProvider = Provider<List<Recipe>>((ref) {
  final recipes = ref.watch(recipeStateProvider).recipes;
  final sortedRecipes = List<Recipe>.from(recipes)
    ..sort((a, b) => b.rating.compareTo(a.rating));
  return sortedRecipes.take(20).toList();
});

// Recipe categories provider
final recipeCategoriesProvider = Provider<Map<String, List<Recipe>>>((ref) {
  final recipes = ref.watch(recipeStateProvider).recipes;
  final categories = <String, List<Recipe>>{};
  
  for (final recipe in recipes) {
    for (final tag in recipe.tags) {
      categories.putIfAbsent(tag, () => []).add(recipe);
    }
  }
  
  return categories;
});

// Individual recipe providers
final recipeByIdProvider = Provider.family<Recipe?, String>((ref, recipeId) {
  final recipes = ref.watch(recipeStateProvider).recipes;
  return recipes.firstWhereOrNull((recipe) => recipe.id == recipeId);
});

// Recipe statistics providers
final recipeStatsProvider = Provider<RecipeStats>((ref) {
  final recipes = ref.watch(recipeStateProvider).recipes;
  return RecipeStats.fromRecipes(recipes);
});

/// Recipe state model
class RecipeState {
  final List<Recipe> recipes;
  final bool isLoading;
  final String? errorMessage;
  final Map<String, Recipe> recipeCache;

  const RecipeState({
    this.recipes = const [],
    this.isLoading = false,
    this.errorMessage,
    this.recipeCache = const {},
  });

  RecipeState copyWith({
    List<Recipe>? recipes,
    bool? isLoading,
    String? errorMessage,
    Map<String, Recipe>? recipeCache,
  }) {
    return RecipeState(
      recipes: recipes ?? this.recipes,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      recipeCache: recipeCache ?? this.recipeCache,
    );
  }
}

/// Recipe state notifier
class RecipeStateNotifier extends StateNotifier<RecipeState> {
  final IRecipeRepository _repository;
  final IRecipeGenerationService _generationService;
  final String? _userId;

  RecipeStateNotifier(this._repository, this._generationService, this._userId) 
      : super(const RecipeState()) {
    _loadRecipes();
  }

  Future<void> _loadRecipes() async {
    if (_userId == null) return;

    state = state.copyWith(isLoading: true, errorMessage: null);
    
    try {
      final recipes = await _repository.getUserRecipes(_userId!);
      state = state.copyWith(
        recipes: recipes,
        isLoading: false,
        recipeCache: {for (final recipe in recipes) recipe.id: recipe},
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load recipes: $e',
      );
    }
  }

  /// Add a new recipe
  Future<void> addRecipe(Recipe recipe) async {
    if (_userId == null) return;

    try {
      final savedRecipe = await _repository.saveRecipe(recipe);
      final updatedRecipes = [...state.recipes, savedRecipe];
      final updatedCache = {...state.recipeCache, savedRecipe.id: savedRecipe};
      
      state = state.copyWith(
        recipes: updatedRecipes,
        recipeCache: updatedCache,
      );
    } catch (e) {
      state = state.copyWith(errorMessage: 'Failed to save recipe: $e');
    }
  }

  /// Update an existing recipe
  Future<void> updateRecipe(Recipe recipe) async {
    try {
      final updatedRecipe = await _repository.updateRecipe(recipe);
      final updatedRecipes = state.recipes
          .map((r) => r.id == recipe.id ? updatedRecipe : r)
          .toList();
      final updatedCache = {...state.recipeCache, updatedRecipe.id: updatedRecipe};
      
      state = state.copyWith(
        recipes: updatedRecipes,
        recipeCache: updatedCache,
      );
    } catch (e) {
      state = state.copyWith(errorMessage: 'Failed to update recipe: $e');
    }
  }

  /// Delete a recipe
  Future<void> deleteRecipe(String recipeId) async {
    try {
      await _repository.deleteRecipe(recipeId);
      final updatedRecipes = state.recipes.where((r) => r.id != recipeId).toList();
      final updatedCache = Map<String, Recipe>.from(state.recipeCache)..remove(recipeId);
      
      state = state.copyWith(
        recipes: updatedRecipes,
        recipeCache: updatedCache,
      );
    } catch (e) {
      state = state.copyWith(errorMessage: 'Failed to delete recipe: $e');
    }
  }

  /// Toggle recipe favorite status
  Future<void> toggleFavorite(String recipeId) async {
    final recipe = state.recipeCache[recipeId];
    if (recipe == null) return;

    final updatedRecipe = recipe.copyWith(isFavorite: !recipe.isFavorite);
    await updateRecipe(updatedRecipe);
  }

  /// Rate a recipe
  Future<void> rateRecipe(String recipeId, double rating) async {
    final recipe = state.recipeCache[recipeId];
    if (recipe == null) return;

    final updatedRecipe = recipe.copyWith(rating: rating);
    await updateRecipe(updatedRecipe);
  }

  /// Mark recipe as viewed
  Future<void> markAsViewed(String recipeId) async {
    final recipe = state.recipeCache[recipeId];
    if (recipe == null) return;

    final updatedRecipe = recipe.copyWith(lastViewedAt: DateTime.now());
    await updateRecipe(updatedRecipe);
  }

  /// Add recipe to collection
  Future<void> addToCollection(String recipeId, String collectionName) async {
    final recipe = state.recipeCache[recipeId];
    if (recipe == null) return;

    final collections = List<String>.from(recipe.collections ?? []);
    if (!collections.contains(collectionName)) {
      collections.add(collectionName);
      final updatedRecipe = recipe.copyWith(collections: collections);
      await updateRecipe(updatedRecipe);
    }
  }

  /// Remove recipe from collection
  Future<void> removeFromCollection(String recipeId, String collectionName) async {
    final recipe = state.recipeCache[recipeId];
    if (recipe == null) return;

    final collections = List<String>.from(recipe.collections ?? []);
    if (collections.remove(collectionName)) {
      final updatedRecipe = recipe.copyWith(collections: collections);
      await updateRecipe(updatedRecipe);
    }
  }

  /// Refresh recipes from server
  Future<void> refresh() async {
    await _loadRecipes();
  }

  /// Clear error message
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}

/// Recipe generation state model
class RecipeGenerationState {
  final bool isGenerating;
  final Recipe? generatedRecipe;
  final String? errorMessage;
  final List<String> currentIngredients;
  final RecipeGenerationRequest? currentRequest;

  const RecipeGenerationState({
    this.isGenerating = false,
    this.generatedRecipe,
    this.errorMessage,
    this.currentIngredients = const [],
    this.currentRequest,
  });

  RecipeGenerationState copyWith({
    bool? isGenerating,
    Recipe? generatedRecipe,
    String? errorMessage,
    List<String>? currentIngredients,
    RecipeGenerationRequest? currentRequest,
  }) {
    return RecipeGenerationState(
      isGenerating: isGenerating ?? this.isGenerating,
      generatedRecipe: generatedRecipe,
      errorMessage: errorMessage,
      currentIngredients: currentIngredients ?? this.currentIngredients,
      currentRequest: currentRequest ?? this.currentRequest,
    );
  }
}

/// Recipe generation notifier
class RecipeGenerationNotifier extends StateNotifier<RecipeGenerationState> {
  final IRecipeGenerationService _generationService;
  final UserPreferences? _userPreferences;

  RecipeGenerationNotifier(this._generationService, this._userPreferences) 
      : super(const RecipeGenerationState());

  /// Generate recipe from ingredients
  Future<void> generateRecipe(
    List<String> ingredients, {
    String? cuisineType,
    Duration? maxCookingTime,
    DifficultyLevel? maxDifficulty,
    int servings = 4,
  }) async {
    if (_userPreferences == null) {
      state = state.copyWith(errorMessage: 'User preferences not available');
      return;
    }

    state = state.copyWith(
      isGenerating: true,
      errorMessage: null,
      currentIngredients: ingredients,
    );

    try {
      final recipe = await _generationService.generateRecipe(
        ingredients,
        _userPreferences!,
        cuisineType: cuisineType,
        maxCookingTime: maxCookingTime,
        maxDifficulty: maxDifficulty,
        servings: servings,
      );

      state = state.copyWith(
        isGenerating: false,
        generatedRecipe: recipe,
      );
    } catch (e) {
      state = state.copyWith(
        isGenerating: false,
        errorMessage: 'Failed to generate recipe: $e',
      );
    }
  }

  /// Modify existing recipe
  Future<void> modifyRecipe(Recipe recipe, ModificationRequest request) async {
    state = state.copyWith(isGenerating: true, errorMessage: null);

    try {
      final modifiedRecipe = await _generationService.modifyRecipe(recipe, request);
      state = state.copyWith(
        isGenerating: false,
        generatedRecipe: modifiedRecipe,
      );
    } catch (e) {
      state = state.copyWith(
        isGenerating: false,
        errorMessage: 'Failed to modify recipe: $e',
      );
    }
  }

  /// Scale recipe for different servings
  Future<void> scaleRecipe(Recipe recipe, int newServings) async {
    state = state.copyWith(isGenerating: true, errorMessage: null);

    try {
      final scaledRecipe = await _generationService.scaleRecipe(recipe, newServings);
      state = state.copyWith(
        isGenerating: false,
        generatedRecipe: scaledRecipe,
      );
    } catch (e) {
      state = state.copyWith(
        isGenerating: false,
        errorMessage: 'Failed to scale recipe: $e',
      );
    }
  }

  /// Adapt recipe for dietary restrictions
  Future<void> adaptForDiet(Recipe recipe, List<DietaryRestriction> restrictions) async {
    state = state.copyWith(isGenerating: true, errorMessage: null);

    try {
      final adaptedRecipe = await _generationService.adaptRecipeForDiet(recipe, restrictions);
      state = state.copyWith(
        isGenerating: false,
        generatedRecipe: adaptedRecipe,
      );
    } catch (e) {
      state = state.copyWith(
        isGenerating: false,
        errorMessage: 'Failed to adapt recipe: $e',
      );
    }
  }

  /// Get recipe suggestions for available ingredients
  Future<void> getSuggestions(List<String> availableIngredients) async {
    if (_userPreferences == null) return;

    state = state.copyWith(isGenerating: true, errorMessage: null);

    try {
      final suggestions = await _generationService.suggestRecipesForIngredients(
        availableIngredients,
        _userPreferences!,
        maxRecipes: 5,
      );

      // For now, just take the first suggestion
      if (suggestions.isNotEmpty) {
        state = state.copyWith(
          isGenerating: false,
          generatedRecipe: suggestions.first,
        );
      } else {
        state = state.copyWith(
          isGenerating: false,
          errorMessage: 'No recipe suggestions found for these ingredients',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isGenerating: false,
        errorMessage: 'Failed to get recipe suggestions: $e',
      );
    }
  }

  /// Clear generated recipe
  void clearGeneratedRecipe() {
    state = state.copyWith(generatedRecipe: null);
  }

  /// Clear error message
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  /// Update current ingredients
  void updateIngredients(List<String> ingredients) {
    state = state.copyWith(currentIngredients: ingredients);
  }
}

/// Recipe filter model
class RecipeFilter {
  final List<String> cuisines;
  final List<DifficultyLevel> difficulties;
  final Duration? maxCookingTime;
  final Duration? maxPrepTime;
  final List<DietaryRestriction> dietaryRestrictions;
  final double? minRating;
  final List<String> tags;
  final bool? isFavorite;

  const RecipeFilter({
    this.cuisines = const [],
    this.difficulties = const [],
    this.maxCookingTime,
    this.maxPrepTime,
    this.dietaryRestrictions = const [],
    this.minRating,
    this.tags = const [],
    this.isFavorite,
  });

  RecipeFilter copyWith({
    List<String>? cuisines,
    List<DifficultyLevel>? difficulties,
    Duration? maxCookingTime,
    Duration? maxPrepTime,
    List<DietaryRestriction>? dietaryRestrictions,
    double? minRating,
    List<String>? tags,
    bool? isFavorite,
  }) {
    return RecipeFilter(
      cuisines: cuisines ?? this.cuisines,
      difficulties: difficulties ?? this.difficulties,
      maxCookingTime: maxCookingTime ?? this.maxCookingTime,
      maxPrepTime: maxPrepTime ?? this.maxPrepTime,
      dietaryRestrictions: dietaryRestrictions ?? this.dietaryRestrictions,
      minRating: minRating ?? this.minRating,
      tags: tags ?? this.tags,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

/// Recipe sort options
enum RecipeSortOption {
  dateCreated,
  dateModified,
  rating,
  cookingTime,
  prepTime,
  difficulty,
  alphabetical,
}

/// Recipe statistics model
class RecipeStats {
  final int totalRecipes;
  final int favoriteRecipes;
  final double averageRating;
  final Duration averageCookingTime;
  final Duration averagePrepTime;
  final Map<DifficultyLevel, int> difficultyDistribution;
  final Map<String, int> cuisineDistribution;
  final Map<String, int> tagDistribution;

  const RecipeStats({
    required this.totalRecipes,
    required this.favoriteRecipes,
    required this.averageRating,
    required this.averageCookingTime,
    required this.averagePrepTime,
    required this.difficultyDistribution,
    required this.cuisineDistribution,
    required this.tagDistribution,
  });

  factory RecipeStats.fromRecipes(List<Recipe> recipes) {
    if (recipes.isEmpty) {
      return const RecipeStats(
        totalRecipes: 0,
        favoriteRecipes: 0,
        averageRating: 0.0,
        averageCookingTime: Duration.zero,
        averagePrepTime: Duration.zero,
        difficultyDistribution: {},
        cuisineDistribution: {},
        tagDistribution: {},
      );
    }

    final favoriteCount = recipes.where((r) => r.isFavorite).length;
    final totalRating = recipes.fold<double>(0.0, (sum, r) => sum + r.rating);
    final averageRating = totalRating / recipes.length;
    
    final totalCookingMinutes = recipes.fold<int>(0, (sum, r) => sum + r.cookingTime.inMinutes);
    final averageCookingTime = Duration(minutes: totalCookingMinutes ~/ recipes.length);
    
    final totalPrepMinutes = recipes.fold<int>(0, (sum, r) => sum + r.prepTime.inMinutes);
    final averagePrepTime = Duration(minutes: totalPrepMinutes ~/ recipes.length);

    final difficultyDistribution = <DifficultyLevel, int>{};
    final cuisineDistribution = <String, int>{};
    final tagDistribution = <String, int>{};

    for (final recipe in recipes) {
      // Count difficulty levels
      difficultyDistribution[recipe.difficulty] = 
          (difficultyDistribution[recipe.difficulty] ?? 0) + 1;

      // Count cuisines (from tags)
      for (final tag in recipe.tags) {
        tagDistribution[tag] = (tagDistribution[tag] ?? 0) + 1;
        
        // Identify cuisine tags (this is a simple heuristic)
        if (_isCuisineTag(tag)) {
          cuisineDistribution[tag] = (cuisineDistribution[tag] ?? 0) + 1;
        }
      }
    }

    return RecipeStats(
      totalRecipes: recipes.length,
      favoriteRecipes: favoriteCount,
      averageRating: averageRating,
      averageCookingTime: averageCookingTime,
      averagePrepTime: averagePrepTime,
      difficultyDistribution: difficultyDistribution,
      cuisineDistribution: cuisineDistribution,
      tagDistribution: tagDistribution,
    );
  }

  static bool _isCuisineTag(String tag) {
    const cuisineTags = [
      'italian', 'mexican', 'chinese', 'japanese', 'indian', 'thai', 'french',
      'mediterranean', 'american', 'korean', 'vietnamese', 'greek', 'spanish',
      'middle eastern', 'african', 'caribbean', 'german', 'british', 'russian',
    ];
    return cuisineTags.contains(tag.toLowerCase());
  }
}

// Helper function for filtering and sorting recipes
List<Recipe> _filterAndSortRecipes(
  List<Recipe> recipes,
  String searchQuery,
  RecipeFilter filter,
  RecipeSortOption sortOption,
) {
  var filteredRecipes = recipes.where((recipe) {
    // Search query filter
    if (searchQuery.isNotEmpty) {
      final query = searchQuery.toLowerCase();
      final matchesTitle = recipe.title.toLowerCase().contains(query);
      final matchesDescription = recipe.description.toLowerCase().contains(query);
      final matchesIngredients = recipe.ingredients
          .any((ingredient) => ingredient.name.toLowerCase().contains(query));
      final matchesTags = recipe.tags
          .any((tag) => tag.toLowerCase().contains(query));
      
      if (!matchesTitle && !matchesDescription && !matchesIngredients && !matchesTags) {
        return false;
      }
    }

    // Cuisine filter
    if (filter.cuisines.isNotEmpty) {
      final hasMatchingCuisine = filter.cuisines
          .any((cuisine) => recipe.tags.contains(cuisine.toLowerCase()));
      if (!hasMatchingCuisine) return false;
    }

    // Difficulty filter
    if (filter.difficulties.isNotEmpty) {
      if (!filter.difficulties.contains(recipe.difficulty)) return false;
    }

    // Cooking time filter
    if (filter.maxCookingTime != null) {
      if (recipe.cookingTime > filter.maxCookingTime!) return false;
    }

    // Prep time filter
    if (filter.maxPrepTime != null) {
      if (recipe.prepTime > filter.maxPrepTime!) return false;
    }

    // Rating filter
    if (filter.minRating != null) {
      if (recipe.rating < filter.minRating!) return false;
    }

    // Favorite filter
    if (filter.isFavorite != null) {
      if (recipe.isFavorite != filter.isFavorite!) return false;
    }

    // Tags filter
    if (filter.tags.isNotEmpty) {
      final hasMatchingTag = filter.tags
          .any((tag) => recipe.tags.contains(tag.toLowerCase()));
      if (!hasMatchingTag) return false;
    }

    return true;
  }).toList();

  // Sort recipes
  switch (sortOption) {
    case RecipeSortOption.dateCreated:
      filteredRecipes.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      break;
    case RecipeSortOption.rating:
      filteredRecipes.sort((a, b) => b.rating.compareTo(a.rating));
      break;
    case RecipeSortOption.cookingTime:
      filteredRecipes.sort((a, b) => a.cookingTime.compareTo(b.cookingTime));
      break;
    case RecipeSortOption.prepTime:
      filteredRecipes.sort((a, b) => a.prepTime.compareTo(b.prepTime));
      break;
    case RecipeSortOption.difficulty:
      filteredRecipes.sort((a, b) => a.difficulty.index.compareTo(b.difficulty.index));
      break;
    case RecipeSortOption.alphabetical:
      filteredRecipes.sort((a, b) => a.title.compareTo(b.title));
      break;
    case RecipeSortOption.dateModified:
      filteredRecipes.sort((a, b) => (b.updatedAt ?? b.createdAt).compareTo(a.updatedAt ?? a.createdAt));
      break;
  }

  return filteredRecipes;
}