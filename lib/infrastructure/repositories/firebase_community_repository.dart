import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/community_recipe.dart';
import '../../domain/entities/recipe.dart';
import '../../domain/repositories/community_repository.dart';
import '../../core/config/api_constants.dart';
import '../../core/errors/app_exceptions.dart';

class FirebaseCommunityRepository implements CommunityRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> publishRecipe(Recipe recipe, String userId) async {
    try {
      await _firestore
          .collection(ApiConstants.communityRecipesCollection)
          .doc(recipe.id)
          .set({
        'recipeId': recipe.id,
        'userId': userId,
        'title': recipe.title,
        'description': recipe.description,
        'publishedAt': FieldValue.serverTimestamp(),
        'isPublic': true,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw const DatabaseException('Failed to publish recipe');
    }
  }

  @override
  Future<List<CommunityRecipe>> getCommunityRecipes({
    String? lastRecipeId,
    int limit = 20,
  }) async {
    try {
      Query query = _firestore
          .collection(ApiConstants.communityRecipesCollection)
          .where('isPublic', isEqualTo: true)
          .orderBy('createdAt', descending: true);

      if (lastRecipeId != null) {
        final lastDoc = await _firestore
            .collection(ApiConstants.communityRecipesCollection)
            .doc(lastRecipeId)
            .get();
        if (lastDoc.exists) {
          query = query.startAfterDocument(lastDoc);
        }
      }

      final querySnapshot = await query.limit(limit).get();
      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        if (data == null) {
          throw const DatabaseException('Document data is null');
        }
        return CommunityRecipe.fromJson(data as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      throw const DatabaseException('Failed to get community recipes');
    }
  }

  @override
  Future<List<CommunityRecipe>> searchCommunityRecipes(String query) async {
    try {
      final querySnapshot = await _firestore
          .collection(ApiConstants.communityRecipesCollection)
          .where('isPublic', isEqualTo: true)
          .where('title', isGreaterThanOrEqualTo: query)
          .where('title', isLessThanOrEqualTo: '$query\uf8ff')
          .limit(20)
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        return CommunityRecipe.fromJson(data);
      }).toList();
    } catch (e) {
      throw const DatabaseException('Failed to search community recipes');
    }
  }

  @override
  Future<void> shareRecipe(String userId, String recipeId) async {
    try {
      await _firestore
          .collection(ApiConstants.communityRecipesCollection)
          .doc(recipeId)
          .set({
        'userId': userId,
        'recipeId': recipeId,
        'sharedAt': FieldValue.serverTimestamp(),
        'isPublic': true,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw const DatabaseException('Failed to share recipe');
    }
  }

  @override
  Future<void> likeRecipe(String userId, String recipeId) async {
    try {
      final batch = _firestore.batch();

      final userLikeRef = _firestore
          .collection(ApiConstants.usersCollection)
          .doc(userId)
          .collection('liked_recipes')
          .doc(recipeId);

      batch.set(userLikeRef, {
        'recipeId': recipeId,
        'likedAt': FieldValue.serverTimestamp(),
      });

      final recipeRef = _firestore
          .collection(ApiConstants.communityRecipesCollection)
          .doc(recipeId);

      batch.update(recipeRef, {
        'likesCount': FieldValue.increment(1),
        'likes': FieldValue.arrayUnion([userId]),
      });

      await batch.commit();
    } catch (e) {
      throw const DatabaseException('Failed to like recipe');
    }
  }

  @override
  Future<void> addComment(String recipeId, RecipeComment comment) async {
    try {
      await _firestore
          .collection(ApiConstants.communityRecipesCollection)
          .doc(recipeId)
          .collection('comments')
          .doc(comment.commentId)
          .set(comment.toJson());
    } catch (e) {
      throw const DatabaseException('Failed to add comment');
    }
  }

  @override
  Future<List<RecipeComment>> getComments(String recipeId) async {
    try {
      final querySnapshot = await _firestore
          .collection(ApiConstants.communityRecipesCollection)
          .doc(recipeId)
          .collection('comments')
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        data['commentId'] = doc.id; // Use document ID if commentId is missing
        return RecipeComment.fromJson(data);
      }).toList();
    } catch (e) {
      throw const DatabaseException('Failed to get comments');
    }
  }

  @override
  Stream<List<CommunityRecipe>> watchCommunityRecipes({int limit = 20}) {
    return _firestore
        .collection(ApiConstants.communityRecipesCollection)
        .where('isPublic', isEqualTo: true)
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return CommunityRecipe.fromJson(data);
      }).toList();
    });
  }

  // Placeholder implementations
  @override
  Future<List<CommunityRecipe>> getFeaturedRecipes({int limit = 10}) async {
    throw UnimplementedError('Get featured recipes not implemented yet');
  }

  @override
  Future<List<CommunityRecipe>> getRecipesByAuthor(String authorId) async {
    throw UnimplementedError('Get recipes by author not implemented yet');
  }

  @override
  Future<void> saveRecipe(String userId, String recipeId) async {
    throw UnimplementedError('Save recipe not implemented yet');
  }

  Future<void> updateRecipeVisibility(String recipeId, bool isPublic) async {
    throw UnimplementedError('Update recipe visibility not implemented yet');
  }
}
