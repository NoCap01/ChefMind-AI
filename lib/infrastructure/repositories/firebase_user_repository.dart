import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/exceptions/app_exceptions.dart';
import '../services/firebase_service.dart';

class FirebaseUserRepository {
  final FirebaseService _firebaseService = FirebaseService.instance;
  
  FirebaseFirestore get _firestore => _firebaseService.firestore;
  
  static const String _usersCollection = 'users';

  Future<UserProfile?> getUserProfile(String userId) async {
    try {
      final doc = await _firestore
          .collection(_usersCollection)
          .doc(userId)
          .get();
      
      if (doc.exists && doc.data() != null) {
        return UserProfile.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get user profile: $e');
    }
  }

  Future<void> createUserProfile(UserProfile profile) async {
    try {
      await _firestore
          .collection(_usersCollection)
          .doc(profile.id)
          .set(profile.toJson());
    } catch (e) {
      throw Exception('Failed to create user profile: $e');
    }
  }

  Future<void> updateUserProfile(UserProfile profile) async {
    try {
      final updatedProfile = profile.copyWith(
        lastUpdated: DateTime.now(),
      );
      
      await _firestore
          .collection(_usersCollection)
          .doc(profile.id)
          .update(updatedProfile.toJson());
    } catch (e) {
      throw Exception('Failed to update user profile: $e');
    }
  }

  Future<void> deleteUserProfile(String userId) async {
    try {
      await _firestore
          .collection(_usersCollection)
          .doc(userId)
          .delete();
    } catch (e) {
      throw Exception('Failed to delete user profile: $e');
    }
  }

  Stream<UserProfile?> watchUserProfile(String userId) {
    return _firestore
        .collection(_usersCollection)
        .doc(userId)
        .snapshots()
        .map((doc) {
      if (doc.exists && doc.data() != null) {
        return UserProfile.fromJson(doc.data()!);
      }
      return null;
    });
  }

  Future<void> updateUserPreferences(String userId, CookingPreferences preferences) async {
    try {
      await _firestore
          .collection(_usersCollection)
          .doc(userId)
          .update({
        'preferences': preferences.toJson(),
        'lastUpdated': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw Exception('Failed to update user preferences: $e');
    }
  }

  Future<void> incrementRecipeCount(String userId) async {
    try {
      await _firestore
          .collection(_usersCollection)
          .doc(userId)
          .update({
        'totalRecipesCooked': FieldValue.increment(1),
        'lastUpdated': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw Exception('Failed to increment recipe count: $e');
    }
  }

  Future<void> updateFavoriteCount(String userId, int count) async {
    try {
      await _firestore
          .collection(_usersCollection)
          .doc(userId)
          .update({
        'favoriteRecipesCount': count,
        'lastUpdated': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw Exception('Failed to update favorite count: $e');
    }
  }
}