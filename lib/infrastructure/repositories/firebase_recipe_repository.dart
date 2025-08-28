import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/recipe.dart';
import '../../domain/entities/community.dart';
import '../../domain/repositories/recipe_repository.dart';
import '../../domain/exceptions/app_exceptions.dart';
import '../services/firebase_service.dart';

class FirebaseRecipeRepository implements IRecipeRepository {
  final FirebaseService _firebaseService = FirebaseService.instance;
  
  FirebaseFirestore get _firestore => _firebaseService.firestore;
  String? get _currentUserId => _firebaseService.currentUserId;

  @override
  Future<void> saveRecipe(Recipe recipe) async {
    try {
      if (_currentUserId == null) throw const UserNotSignedInException();
      
      final docRef = _firebaseService.userCollection(_currentUserId!, 'recipes').doc(recipe.id);
      await docRef.set(recipe.toJson());
      
      // Log analytics event
      await _firebaseService.logEvent('recipe_saved', {
        'recipe_id': recipe.id,
        'difficulty': recipe.difficulty.name,
        'cooking_time': recipe.cookingTime.inMinutes,
      });
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<Recipe?> getRecipe(String recipeId) async {
    try {
      if (_currentUserId == null) throw const UserNotSignedInException();
      
      final doc = await _firebaseService.userCollection(_currentUserId!, 'recipes').doc(recipeId).get();
      
      if (doc.exists && doc.data() != null) {
        return Recipe.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<List<Recipe>> getUserRecipes(String userId) async {
    try {
      final querySnapshot = await _firebaseService.userCollection(userId, 'recipes')
          .orderBy('createdAt', descending: true)
          .get();
      
      return querySnapshot.docs
          .map((doc) => Recipe.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<void> deleteRecipe(String recipeId) async {
    try {
      if (_currentUserId == null) throw const UserNotSignedInException();
      
      await _firebaseService.userCollection(_currentUserId!, 'recipes').doc(recipeId).delete();
      
      // Log analytics event
      await _firebaseService.logEvent('recipe_deleted', {
        'recipe_id': recipeId,
      });
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<void> updateRecipe(Recipe recipe) async {
    try {
      if (_currentUserId == null) throw const UserNotSignedInException();
      
      final updatedRecipe = recipe.copyWith(
        // Update timestamp could be added to Recipe model
      );
      
      await _firebaseService.userCollection(_currentUserId!, 'recipes')
          .doc(recipe.id)
          .update(updatedRecipe.toJson());
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<List<Recipe>> getRecipesByCollection(String userId, String collectionId) async {
    try {
      // First get the collection to find recipe IDs
      final collectionDoc = await _firebaseService.userCollection(userId, 'collections')
          .doc(collectionId)
          .get();
      
      if (!collectionDoc.exists) {
        return [];
      }
      
      final recipeIds = List<String>.from(collectionDoc.data()?['recipeIds'] ?? []);
      
      if (recipeIds.isEmpty) {
        return [];
      }
      
      // Get recipes in batches (Firestore 'in' query limit is 10)
      final recipes = <Recipe>[];
      for (int i = 0; i < recipeIds.length; i += 10) {
        final batch = recipeIds.skip(i).take(10).toList();
        final querySnapshot = await _firebaseService.userCollection(userId, 'recipes')
            .where(FieldPath.documentId, whereIn: batch)
            .get();
        
        recipes.addAll(
          querySnapshot.docs.map((doc) => Recipe.fromJson(doc.data())),
        );
      }
      
      return recipes;
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<void> addRecipeToCollection(String recipeId, String collectionId) async {
    try {
      if (_currentUserId == null) throw const UserNotSignedInException();
      
      await _firebaseService.userCollection(_currentUserId!, 'collections')
          .doc(collectionId)
          .update({
        'recipeIds': FieldValue.arrayUnion([recipeId]),
        'lastUpdated': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<void> removeRecipeFromCollection(String recipeId, String collectionId) async {
    try {
      if (_currentUserId == null) throw const UserNotSignedInException();
      
      await _firebaseService.userCollection(_currentUserId!, 'collections')
          .doc(collectionId)
          .update({
        'recipeIds': FieldValue.arrayRemove([recipeId]),
        'lastUpdated': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<List<String>> getRecipeCollections(String userId) async {
    try {
      final querySnapshot = await _firebaseService.userCollection(userId, 'collections').get();
      
      return querySnapshot.docs
          .map((doc) => doc.data()['name'] as String)
          .toList();
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<void> createRecipeCollection(String userId, String collectionName) async {
    try {
      final collectionId = _firestore.collection('temp').doc().id; // Generate ID
      
      await _firebaseService.userCollection(userId, 'collections').doc(collectionId).set({
        'id': collectionId,
        'name': collectionName,
        'recipeIds': [],
        'createdAt': FieldValue.serverTimestamp(),
        'lastUpdated': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<void> toggleFavorite(String userId, String recipeId) async {
    try {
      final recipeRef = _firebaseService.userCollection(userId, 'recipes').doc(recipeId);
      
      await _firestore.runTransaction((transaction) async {
        final doc = await transaction.get(recipeRef);
        
        if (doc.exists) {
          final currentFavorite = doc.data()?['isFavorite'] ?? false;
          transaction.update(recipeRef, {'isFavorite': !currentFavorite});
        }
      });
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<List<Recipe>> getFavoriteRecipes(String userId) async {
    try {
      final querySnapshot = await _firebaseService.userCollection(userId, 'recipes')
          .where('isFavorite', isEqualTo: true)
          .orderBy('createdAt', descending: true)
          .get();
      
      return querySnapshot.docs
          .map((doc) => Recipe.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<void> rateRecipe(String userId, String recipeId, double rating, String? review) async {
    try {
      final ratingData = {
        'id': _firestore.collection('temp').doc().id,
        'recipeId': recipeId,
        'userId': userId,
        'rating': rating,
        'review': review,
        'createdAt': FieldValue.serverTimestamp(),
      };
      
      await _firestore.collection('ratings').add(ratingData);
      
      // Update recipe's average rating
      await _updateRecipeAverageRating(recipeId);
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<List<RecipeRating>> getRecipeRatings(String recipeId) async {
    try {
      final querySnapshot = await _firestore.collection('ratings')
          .where('recipeId', isEqualTo: recipeId)
          .orderBy('createdAt', descending: true)
          .get();
      
      return querySnapshot.docs
          .map((doc) => RecipeRating.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<List<Recipe>> searchRecipes(
    String query, {
    List<String>? tags,
    DifficultyLevel? maxDifficulty,
    Duration? maxCookingTime,
    List<String>? ingredients,
    List<String>? excludeIngredients,
  }) async {
    try {
      if (_currentUserId == null) throw const UserNotSignedInException();
      
      Query<Map<String, dynamic>> queryRef = _firebaseService.userCollection(_currentUserId!, 'recipes');
      
      // Apply filters
      if (tags != null && tags.isNotEmpty) {
        queryRef = queryRef.where('tags', arrayContainsAny: tags);
      }
      
      if (maxDifficulty != null) {
        queryRef = queryRef.where('difficulty', isLessThanOrEqualTo: maxDifficulty.name);
      }
      
      if (maxCookingTime != null) {
        queryRef = queryRef.where('cookingTime', isLessThanOrEqualTo: maxCookingTime.inMinutes);
      }
      
      final querySnapshot = await queryRef.get();
      
      List<Recipe> recipes = querySnapshot.docs
          .map((doc) => Recipe.fromJson(doc.data()))
          .toList();
      
      // Apply text search filter (client-side for now)
      if (query.isNotEmpty) {
        recipes = recipes.where((recipe) {
          return recipe.title.toLowerCase().contains(query.toLowerCase()) ||
                 recipe.description.toLowerCase().contains(query.toLowerCase()) ||
                 recipe.ingredients.any((ingredient) => 
                     ingredient.name.toLowerCase().contains(query.toLowerCase()));
        }).toList();
      }
      
      // Apply ingredient filters (client-side)
      if (ingredients != null && ingredients.isNotEmpty) {
        recipes = recipes.where((recipe) {
          return ingredients.every((ingredient) =>
              recipe.ingredients.any((recipeIngredient) =>
                  recipeIngredient.name.toLowerCase().contains(ingredient.toLowerCase())));
        }).toList();
      }
      
      if (excludeIngredients != null && excludeIngredients.isNotEmpty) {
        recipes = recipes.where((recipe) {
          return !excludeIngredients.any((ingredient) =>
              recipe.ingredients.any((recipeIngredient) =>
                  recipeIngredient.name.toLowerCase().contains(ingredient.toLowerCase())));
        }).toList();
      }
      
      return recipes;
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<List<Recipe>> getRecipesByIngredients(List<String> ingredients) async {
    try {
      if (_currentUserId == null) throw const UserNotSignedInException();
      
      final querySnapshot = await _firebaseService.userCollection(_currentUserId!, 'recipes').get();
      
      final recipes = querySnapshot.docs
          .map((doc) => Recipe.fromJson(doc.data()))
          .where((recipe) {
        return ingredients.any((ingredient) =>
            recipe.ingredients.any((recipeIngredient) =>
                recipeIngredient.name.toLowerCase().contains(ingredient.toLowerCase())));
      }).toList();
      
      return recipes;
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<List<Recipe>> getRecipesByTags(List<String> tags) async {
    try {
      if (_currentUserId == null) throw const UserNotSignedInException();
      
      final querySnapshot = await _firebaseService.userCollection(_currentUserId!, 'recipes')
          .where('tags', arrayContainsAny: tags)
          .get();
      
      return querySnapshot.docs
          .map((doc) => Recipe.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<List<Recipe>> getRecipesByCuisine(String cuisine) async {
    try {
      if (_currentUserId == null) throw const UserNotSignedInException();
      
      final querySnapshot = await _firebaseService.userCollection(_currentUserId!, 'recipes')
          .where('tags', arrayContains: cuisine)
          .get();
      
      return querySnapshot.docs
          .map((doc) => Recipe.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<List<Recipe>> getRecipesByDifficulty(DifficultyLevel difficulty) async {
    try {
      if (_currentUserId == null) throw const UserNotSignedInException();
      
      final querySnapshot = await _firebaseService.userCollection(_currentUserId!, 'recipes')
          .where('difficulty', isEqualTo: difficulty.name)
          .get();
      
      return querySnapshot.docs
          .map((doc) => Recipe.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<void> addToRecentlyViewed(String userId, String recipeId) async {
    try {
      await _firebaseService.userDoc(userId).update({
        'recentlyViewedRecipes': FieldValue.arrayUnion([{
          'recipeId': recipeId,
          'viewedAt': FieldValue.serverTimestamp(),
        }]),
      });
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<List<Recipe>> getRecentlyViewedRecipes(String userId) async {
    try {
      final userDoc = await _firebaseService.userDoc(userId).get();
      final recentlyViewed = List<Map<String, dynamic>>.from(
          userDoc.data()?['recentlyViewedRecipes'] ?? []);
      
      // Sort by viewedAt and get recipe IDs
      recentlyViewed.sort((a, b) => (b['viewedAt'] as Timestamp)
          .compareTo(a['viewedAt'] as Timestamp));
      
      final recipeIds = recentlyViewed
          .take(20) // Limit to 20 most recent
          .map((item) => item['recipeId'] as String)
          .toList();
      
      if (recipeIds.isEmpty) return [];
      
      return await getRecipesBatch(recipeIds);
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<List<Recipe>> getPopularRecipes({int limit = 20}) async {
    try {
      // This would typically be implemented with Cloud Functions
      // For now, return recipes sorted by rating
      final querySnapshot = await _firestore.collectionGroup('recipes')
          .orderBy('rating', descending: true)
          .limit(limit)
          .get();
      
      return querySnapshot.docs
          .map((doc) => Recipe.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<List<Recipe>> getTrendingRecipes({int limit = 20}) async {
    try {
      // This would be implemented with analytics data
      // For now, return recent recipes with high ratings
      final querySnapshot = await _firestore.collectionGroup('recipes')
          .where('rating', isGreaterThan: 4.0)
          .orderBy('rating', descending: true)
          .orderBy('createdAt', descending: true)
          .limit(limit)
          .get();
      
      return querySnapshot.docs
          .map((doc) => Recipe.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<void> incrementCookCount(String recipeId) async {
    try {
      if (_currentUserId == null) throw const UserNotSignedInException();
      
      await _firebaseService.userCollection(_currentUserId!, 'recipes')
          .doc(recipeId)
          .update({
        'cookCount': FieldValue.increment(1),
      });
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<void> recordCookingSession(String userId, String recipeId, bool success) async {
    try {
      final sessionData = {
        'id': _firestore.collection('temp').doc().id,
        'userId': userId,
        'recipeId': recipeId,
        'success': success,
        'timestamp': FieldValue.serverTimestamp(),
      };
      
      await _firebaseService.userCollection(userId, 'cookingSessions').add(sessionData);
      
      // Log analytics
      await _firebaseService.logEvent('cooking_session', {
        'recipe_id': recipeId,
        'success': success,
      });
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<Map<String, dynamic>> getRecipeAnalytics(String recipeId) async {
    try {
      // This would be implemented with aggregated data
      // For now, return basic analytics
      final sessionsSnapshot = await _firestore.collectionGroup('cookingSessions')
          .where('recipeId', isEqualTo: recipeId)
          .get();
      
      final totalSessions = sessionsSnapshot.docs.length;
      final successfulSessions = sessionsSnapshot.docs
          .where((doc) => doc.data()['success'] == true)
          .length;
      
      return {
        'totalCookingSessions': totalSessions,
        'successRate': totalSessions > 0 ? successfulSessions / totalSessions : 0.0,
        'popularityScore': totalSessions * 0.1, // Simple scoring
      };
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<List<Recipe>> getRecipesBatch(List<String> recipeIds) async {
    try {
      if (_currentUserId == null) throw const UserNotSignedInException();
      
      final recipes = <Recipe>[];
      
      // Process in batches of 10 (Firestore limit)
      for (int i = 0; i < recipeIds.length; i += 10) {
        final batch = recipeIds.skip(i).take(10).toList();
        final querySnapshot = await _firebaseService.userCollection(_currentUserId!, 'recipes')
            .where(FieldPath.documentId, whereIn: batch)
            .get();
        
        recipes.addAll(
          querySnapshot.docs.map((doc) => Recipe.fromJson(doc.data())),
        );
      }
      
      return recipes;
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<void> saveRecipesBatch(List<Recipe> recipes) async {
    try {
      if (_currentUserId == null) throw const UserNotSignedInException();
      
      final batch = _firestore.batch();
      
      for (final recipe in recipes) {
        final docRef = _firebaseService.userCollection(_currentUserId!, 'recipes').doc(recipe.id);
        batch.set(docRef, recipe.toJson());
      }
      
      await batch.commit();
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<void> deleteRecipesBatch(List<String> recipeIds) async {
    try {
      if (_currentUserId == null) throw const UserNotSignedInException();
      
      final batch = _firestore.batch();
      
      for (final recipeId in recipeIds) {
        final docRef = _firebaseService.userCollection(_currentUserId!, 'recipes').doc(recipeId);
        batch.delete(docRef);
      }
      
      await batch.commit();
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Stream<List<Recipe>> watchUserRecipes(String userId) {
    try {
      return _firebaseService.userCollection(userId, 'recipes')
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => Recipe.fromJson(doc.data()))
              .toList());
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Stream<Recipe?> watchRecipe(String recipeId) {
    try {
      if (_currentUserId == null) throw const UserNotSignedInException();
      
      return _firebaseService.userCollection(_currentUserId!, 'recipes')
          .doc(recipeId)
          .snapshots()
          .map((doc) => doc.exists && doc.data() != null 
              ? Recipe.fromJson(doc.data()!) 
              : null);
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Stream<List<Recipe>> watchFavoriteRecipes(String userId) {
    try {
      return _firebaseService.userCollection(userId, 'recipes')
          .where('isFavorite', isEqualTo: true)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => Recipe.fromJson(doc.data()))
              .toList());
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  // Helper method to update recipe average rating
  Future<void> _updateRecipeAverageRating(String recipeId) async {
    try {
      final ratingsSnapshot = await _firestore.collection('ratings')
          .where('recipeId', isEqualTo: recipeId)
          .get();
      
      if (ratingsSnapshot.docs.isNotEmpty) {
        final ratings = ratingsSnapshot.docs
            .map((doc) => doc.data()['rating'] as double)
            .toList();
        
        final averageRating = ratings.reduce((a, b) => a + b) / ratings.length;
        
        // Update all instances of this recipe
        final recipeQuery = await _firestore.collectionGroup('recipes')
            .where('id', isEqualTo: recipeId)
            .get();
        
        final batch = _firestore.batch();
        for (final doc in recipeQuery.docs) {
          batch.update(doc.reference, {'rating': averageRating});
        }
        await batch.commit();
      }
    } catch (e) {
      // Don't throw here as this is a background operation
      if (AppConfig.isDebug) {
        print('Error updating recipe rating: $e');
      }
    }
  }
}