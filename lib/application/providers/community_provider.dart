import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/community_recipe.dart';
import '../../domain/entities/recipe.dart';
import '../../domain/repositories/community_repository.dart';
import '../../infrastructure/repositories/firebase_community_repository.dart';

// Repository provider
final communityRepositoryProvider = Provider<CommunityRepository>(
  (ref) => FirebaseCommunityRepository(),
);

// Current user ID provider (assuming it exists in auth_provider.dart)
final currentUserIdProvider = Provider<String?>((ref) {
  // This should reference your auth provider
  return null; // Replace with actual current user ID logic
});

// Community recipes providers
final communityRecipesProvider =
    FutureProvider<List<CommunityRecipe>>((ref) async {
  final repository = ref.watch(communityRepositoryProvider);
  return repository.getCommunityRecipes();
});

final popularRecipesProvider =
    FutureProvider<List<CommunityRecipe>>((ref) async {
  final repository = ref.watch(communityRepositoryProvider);
  return repository.getFeaturedRecipes();
});

final userSharedRecipesProvider =
    FutureProvider<List<CommunityRecipe>>((ref) async {
  final repository = ref.watch(communityRepositoryProvider);
  final userId = ref.watch(currentUserIdProvider);
  if (userId == null) return [];
  return repository.getRecipesByAuthor(userId);
});

// Community state notifier
class CommunityNotifier extends AsyncNotifier<List<CommunityRecipe>> {
  @override
  Future<List<CommunityRecipe>> build() async {
    final repository = ref.watch(communityRepositoryProvider);
    return repository.getCommunityRecipes();
  }

  Future<void> publishRecipe(Recipe recipe, String story) async {
    final repository = ref.watch(communityRepositoryProvider);
    await repository.publishRecipe(recipe, story);

    // Refresh the data
    ref.invalidateSelf();
  }

  Future<void> likeRecipe(String recipeId) async {
    final repository = ref.watch(communityRepositoryProvider);
    final userId = ref.watch(currentUserIdProvider);
    if (userId == null) return;

    await repository.likeRecipe(userId, recipeId);

    // Update state optimistically
    final currentRecipes = state.value ?? [];
    final updatedRecipes = currentRecipes.map((recipe) {
      if (recipe.recipeId == recipeId) {
        return recipe.copyWith(
          likesCount: recipe.likesCount + 1,
          isLiked: true,
        );
      }
      return recipe;
    }).toList();

    state = AsyncData(updatedRecipes);
  }

  Future<void> saveRecipe(String recipeId) async {
    final repository = ref.watch(communityRepositoryProvider);
    final userId = ref.watch(currentUserIdProvider);
    if (userId == null) return;

    await repository.saveRecipe(userId, recipeId);
  }

  Future<void> shareRecipe(String recipeId) async {
    final repository = ref.watch(communityRepositoryProvider);
    final userId = ref.watch(currentUserIdProvider);
    if (userId == null) return;

    await repository.shareRecipe(userId, recipeId);
  }

  Future<void> addComment(String recipeId, RecipeComment comment) async {
    final repository = ref.watch(communityRepositoryProvider);
    await repository.addComment(recipeId, comment);

    // Update comment count
    final currentRecipes = state.value ?? [];
    final updatedRecipes = currentRecipes.map((recipe) {
      if (recipe.recipeId == recipeId) {
        return recipe.copyWith(commentsCount: recipe.commentsCount + 1);
      }
      return recipe;
    }).toList();

    state = AsyncData(updatedRecipes);
  }

  Future<void> searchRecipes(String query) async {
    final repository = ref.watch(communityRepositoryProvider);
    final results = await repository.searchCommunityRecipes(query);
    state = AsyncData(results);
  }
}

// Community provider
final communityProvider =
    AsyncNotifierProvider<CommunityNotifier, List<CommunityRecipe>>(
  () => CommunityNotifier(),
);

// Recipe comments provider
final recipeCommentsProvider =
    FutureProvider.family<List<RecipeComment>, String>(
  (ref, recipeId) async {
    final repository = ref.watch(communityRepositoryProvider);
    return repository.getComments(recipeId);
  },
);

// Watch community recipes stream provider
final watchCommunityRecipesProvider =
    StreamProvider<List<CommunityRecipe>>((ref) {
  final repository = ref.watch(communityRepositoryProvider);
  return repository.watchCommunityRecipes();
});
