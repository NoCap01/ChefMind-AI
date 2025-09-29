import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/user_repository.dart';
import '../../domain/enums/skill_level.dart';
import '../models/user_model.dart';
import '../../core/config/api_constants.dart';
import '../../core/errors/app_exceptions.dart';

class FirebaseUserRepository implements UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> createUserProfile(UserProfile profile) async {
    try {
      final model = UserModel.fromDomain(profile);
      await _firestore
          .collection(ApiConstants.usersCollection)
          .doc(profile.userId) // Changed from profile.id
          .set(model.toJson());
    } catch (e) {
      throw const DatabaseException('Failed to create user profile');
    }
  }

  @override
  Future<UserProfile?> getUserProfile(String userId) async {
    try {
      final doc = await _firestore
          .collection(ApiConstants.usersCollection)
          .doc(userId)
          .get();

      if (doc.exists && doc.data() != null) {
        final model = UserModel.fromJson(doc.data()!);
        return _modelToDomain(model);
      }
      return null;
    } catch (e) {
      throw const DatabaseException('Failed to get user profile');
    }
  }

  @override
  Future<void> updateUserProfile(UserProfile profile) async {
    try {
      final model = UserModel.fromDomain(profile);
      await _firestore
          .collection(ApiConstants.usersCollection)
          .doc(profile.userId) // Changed from profile.id
          .update(model.toJson());
    } catch (e) {
      throw const DatabaseException('Failed to update user profile');
    }
  }

  @override
  Future<void> deleteUserProfile(String userId) async {
    try {
      await _firestore
          .collection(ApiConstants.usersCollection)
          .doc(userId)
          .delete();
    } catch (e) {
      throw const DatabaseException('Failed to delete user profile');
    }
  }

  @override
  Future<List<UserProfile>> searchUsers(String query) async {
    try {
      final querySnapshot = await _firestore
          .collection(ApiConstants.usersCollection)
          .where('displayName', isGreaterThanOrEqualTo: query)
          .where('displayName', isLessThanOrEqualTo: '$query\uf8ff')
          .limit(20)
          .get();

      return querySnapshot.docs.map((doc) {
        final model = UserModel.fromJson(doc.data());
        return _modelToDomain(model);
      }).toList();
    } catch (e) {
      throw const DatabaseException('Failed to search users');
    }
  }

  @override
  Future<void> followUser(String userId, String followUserId) async {
    try {
      final batch = _firestore.batch();

      final userRef =
          _firestore.collection(ApiConstants.usersCollection).doc(userId);
      batch.update(userRef, {
        'following': FieldValue.arrayUnion([followUserId])
      });

      final followUserRef =
          _firestore.collection(ApiConstants.usersCollection).doc(followUserId);
      batch.update(followUserRef, {
        'followers': FieldValue.arrayUnion([userId])
      });

      await batch.commit();
    } catch (e) {
      throw const DatabaseException('Failed to follow user');
    }
  }

  @override
  Future<void> unfollowUser(String userId, String unfollowUserId) async {
    try {
      final batch = _firestore.batch();

      final userRef =
          _firestore.collection(ApiConstants.usersCollection).doc(userId);
      batch.update(userRef, {
        'following': FieldValue.arrayRemove([unfollowUserId])
      });

      final unfollowUserRef = _firestore
          .collection(ApiConstants.usersCollection)
          .doc(unfollowUserId);
      batch.update(unfollowUserRef, {
        'followers': FieldValue.arrayRemove([userId])
      });

      await batch.commit();
    } catch (e) {
      throw const DatabaseException('Failed to unfollow user');
    }
  }

  @override
  Future<List<String>> getFollowing(String userId) async {
    try {
      final doc = await _firestore
          .collection(ApiConstants.usersCollection)
          .doc(userId)
          .get();

      if (doc.exists && doc.data() != null) {
        return List<String>.from(doc.data()!['following'] ?? []);
      }
      return [];
    } catch (e) {
      throw const DatabaseException('Failed to get following');
    }
  }

  @override
  Future<List<String>> getFollowers(String userId) async {
    try {
      final doc = await _firestore
          .collection(ApiConstants.usersCollection)
          .doc(userId)
          .get();

      if (doc.exists && doc.data() != null) {
        return List<String>.from(doc.data()!['followers'] ?? []);
      }
      return [];
    } catch (e) {
      throw const DatabaseException('Failed to get followers');
    }
  }

  @override
  Stream<UserProfile?> watchUserProfile(String userId) {
    return _firestore
        .collection(ApiConstants.usersCollection)
        .doc(userId)
        .snapshots()
        .map((doc) {
      if (doc.exists && doc.data() != null) {
        final model = UserModel.fromJson(doc.data()!);
        return _modelToDomain(model);
      }
      return null;
    });
  }

  UserProfile _modelToDomain(UserModel model) {
    return UserProfile(
      userId: model.id,
      email: model.email,
      displayName: model.displayName,
      photoUrl: model.photoUrl,
      skillLevel: SkillLevel.beginner, // Default or parse from model.skillLevel
      dietaryRestrictions: [], // Default or parse from model
      allergies: model.allergies,
      favoriteIngredients: model.favoriteIngredients,
      dislikedIngredients: model.dislikedIngredients,
      kitchenEquipment: model.kitchenEquipment,
      preferences: const CookingPreferences(
        maxCookingTime: 30,
        defaultServings: 4,
        preferQuickMeals: true,
        preferBatchCooking: false,
        preferOnePotMeals: false,
        commonSpices: ['salt', 'pepper'],
        spiceToleranceLevel: 5,
      ),
      nutritionalGoals: const NutritionalGoals(
        trackCalories: false,
        trackMacros: false,
        trackMicros: false,
      ),
      favoriteRecipes: model.favoriteRecipes,
      savedCollections: model.savedCollections,
      createdAt: model.createdAt,
      lastActiveAt: model.lastActiveAt,
      isEmailVerified: model.isEmailVerified,
      isPremiumUser: model.isPremiumUser,
    );
  }
}
