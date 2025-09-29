import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/recipe.dart';
import '../../domain/repositories/recipe_repository.dart';
import '../models/recipe_model.dart';
import '../../core/config/api_constants.dart';
import '../../core/errors/app_exceptions.dart';

class FirebaseRecipeRepository implements RecipeRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> saveRecipe(Recipe recipe) async {
    try {
      final model = RecipeModel.fromDomain(recipe);
      await _firestore
          .collection(ApiConstants.recipesCollection)
          .doc(recipe.id)
          .set(model.toJson());
    } catch (e) {
      throw const DatabaseException('Failed to save recipe');
    }
  }

  @override
  Future<Recipe?> getRecipe(String recipeId) async {
    try {
      final doc = await _firestore
          .collection(ApiConstants.recipesCollection)
          .doc(recipeId)
          .get();

      if (doc.exists && doc.data() != null) {
        final model = RecipeModel.fromJson(doc.data()!);
        return _modelToDomain(model);
      }
      return null;
    } catch (e) {
      throw const DatabaseException('Failed to get recipe');
    }
  }

  @override
  Future<List<Recipe>> getUserRecipes(String userId) async {
    try {
      final query = await _firestore
          .collection(ApiConstants.recipesCollection)
          .where('authorId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      return query.docs.map((doc) {
        final model = RecipeModel.fromJson(doc.data());
        return _modelToDomain(model);
      }).toList();
    } catch (e) {
      throw const DatabaseException('Failed to get user recipes');
    }
  }

  @override
  Future<List<Recipe>> searchRecipes(String searchQuery) async {
    try {
      final query = await _firestore
          .collection(ApiConstants.recipesCollection)
          .where('isPublic', isEqualTo: true)
          .where('title', isGreaterThanOrEqualTo: searchQuery)
          .where('title', isLessThanOrEqualTo: '$searchQuery\uf8ff')
          .limit(20)
          .get();

      return query.docs.map((doc) {
        final model = RecipeModel.fromJson(doc.data());
        return _modelToDomain(model);
      }).toList();
    } catch (e) {
      throw const DatabaseException('Failed to search recipes');
    }
  }

  @override
  Future<void> deleteRecipe(String recipeId) async {
    try {
      await _firestore
          .collection(ApiConstants.recipesCollection)
          .doc(recipeId)
          .delete();
    } catch (e) {
      throw const DatabaseException('Failed to delete recipe');
    }
  }

  @override
  Future<void> updateRecipe(Recipe recipe) async {
    try {
      final model = RecipeModel.fromDomain(recipe);
      await _firestore
          .collection(ApiConstants.recipesCollection)
          .doc(recipe.id)
          .update(model.toJson());
    } catch (e) {
      throw const DatabaseException('Failed to update recipe');
    }
  }

  // Simplified placeholder implementations
  @override
  Future<List<Recipe>> getRecipesByIngredients(List<String> ingredients) async {
    return []; // Placeholder
  }

  @override
  Future<List<Recipe>> getFavoriteRecipes(String userId) async {
    return []; // Placeholder
  }

  @override
  Future<void> toggleFavorite(String userId, String recipeId) async {
    // Placeholder
  }

  @override
  Future<void> rateRecipe(String recipeId, double rating) async {
    // Placeholder
  }

  @override
  Stream<List<Recipe>> watchUserRecipes(String userId) {
    return const Stream.empty(); // Placeholder
  }

  Recipe _modelToDomain(RecipeModel model) {
    throw UnimplementedError('Model to domain conversion not implemented');
  }
}
