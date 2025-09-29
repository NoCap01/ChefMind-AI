import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/recipe.dart';
import '../../domain/entities/ingredient.dart';
import '../../domain/enums/difficulty_level.dart';
import '../../domain/enums/meal_type.dart';
import '../../domain/enums/cuisine_type.dart';
import '../../infrastructure/services/cascading_ai_service.dart';
import '../../infrastructure/services/enhanced_openai_service.dart';
import '../../infrastructure/services/hugging_face_service.dart';
import '../../infrastructure/services/enhanced_mock_service.dart';
import '../../domain/entities/recipe_request.dart';
import '../../core/errors/app_exceptions.dart';

// Recipe generation state
sealed class RecipeGenerationState {
  const RecipeGenerationState();
}

class RecipeGenerationInitial extends RecipeGenerationState {}

class RecipeGenerationLoading extends RecipeGenerationState {
  final String? message;
  const RecipeGenerationLoading([this.message]);
}

class RecipeGenerationSuccess extends RecipeGenerationState {
  final Recipe recipe;
  const RecipeGenerationSuccess(this.recipe);
}

class RecipeGenerationError extends RecipeGenerationState {
  final String message;
  const RecipeGenerationError(this.message);
}

// Recipe generation provider
final recipeGenerationProvider =
    StateNotifierProvider<RecipeGenerationNotifier, RecipeGenerationState>(
  (ref) => RecipeGenerationNotifier(),
);

class RecipeGenerationNotifier extends StateNotifier<RecipeGenerationState> {
  RecipeGenerationNotifier() : super(RecipeGenerationInitial());

  Future<void> generateRecipe({
    required List<String> ingredients,
    String? cuisineType,
    String? mealType,
    int servings = 4,
    Duration? maxCookingTime,
  }) async {
    if (ingredients.isEmpty) {
      state = const RecipeGenerationError('Please add at least one ingredient');
      return;
    }

    state = const RecipeGenerationLoading('Generating your recipe...');

    try {
      final aiService = CascadingAIService([
        EnhancedOpenAIService(),
        HuggingFaceService(),
        EnhancedMockService(),
      ]);
      final request = RecipeRequest(
        ingredients: ingredients,
        cuisineType: cuisineType,
        mealType: mealType,
        servings: servings,
        maxCookingTime: maxCookingTime?.inMinutes,
      );

      final recipe = await aiService.generateRecipe(request);
      state = RecipeGenerationSuccess(recipe);
    } on AppException catch (e) {
      state = RecipeGenerationError(e.message);
    } catch (e) {
      state = const RecipeGenerationError(
          'Failed to generate recipe. Please try again.');
    }
  }

  void clearGeneration() {
    state = RecipeGenerationInitial();
  }
}

// User recipes provider
final userRecipesProvider = FutureProvider<List<Recipe>>((ref) async {
  // This would fetch from repository
  return <Recipe>[];
});

// Favorite recipes provider
final favoriteRecipesProvider =
    StateNotifierProvider<FavoriteRecipesNotifier, Set<String>>(
  (ref) => FavoriteRecipesNotifier(),
);

class FavoriteRecipesNotifier extends StateNotifier<Set<String>> {
  FavoriteRecipesNotifier() : super(<String>{});

  void toggleFavorite(String recipeId) {
    final newState = Set<String>.from(state);
    if (newState.contains(recipeId)) {
      newState.remove(recipeId);
    } else {
      newState.add(recipeId);
    }
    state = newState;
  }

  bool isFavorite(String recipeId) {
    return state.contains(recipeId);
  }

  void addFavorite(String recipeId) {
    if (!state.contains(recipeId)) {
      state = {...state, recipeId};
    }
  }

  void removeFavorite(String recipeId) {
    if (state.contains(recipeId)) {
      final newState = Set<String>.from(state);
      newState.remove(recipeId);
      state = newState;
    }
  }

  void clearFavorites() {
    state = <String>{};
  }
}

// Recipe search provider
final recipeSearchProvider =
    StateNotifierProvider<RecipeSearchNotifier, RecipeSearchState>(
  (ref) => RecipeSearchNotifier(),
);

class RecipeSearchNotifier extends StateNotifier<RecipeSearchState> {
  RecipeSearchNotifier() : super(const RecipeSearchState.initial());

  Future<void> searchRecipes(String query) async {
    if (query.trim().isEmpty) {
      state = const RecipeSearchState.initial();
      return;
    }

    state = const RecipeSearchState.loading();

    try {
      // This would use the repository
      await Future.delayed(const Duration(seconds: 1));
      state = const RecipeSearchState.success([]);
    } catch (e) {
      state = const RecipeSearchState.error('Search failed: \$e');
    }
  }

  void clearSearch() {
    state = const RecipeSearchState.initial();
  }
}

// Recipe search state
sealed class RecipeSearchState {
  const RecipeSearchState();

  const factory RecipeSearchState.initial() = RecipeSearchInitial;
  const factory RecipeSearchState.loading() = RecipeSearchLoading;
  const factory RecipeSearchState.success(List<Recipe> recipes) =
      RecipeSearchSuccess;
  const factory RecipeSearchState.error(String message) = RecipeSearchError;
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
