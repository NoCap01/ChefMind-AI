import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/services/authentication_service.dart';
import '../../domain/enums/skill_level.dart';
import '../../core/errors/app_exceptions.dart';

class FirebaseAuthService implements AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Stream<UserProfile?> get authStateChanges {
    return _firebaseAuth.authStateChanges().asyncMap((firebaseUser) async {
      if (firebaseUser == null) return null;
      return _mapFirebaseUserToUserProfile(firebaseUser);
    });
  }

  @override
  Future<UserProfile?> getCurrentUser() async {
    final firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser == null) return null;
    return _mapFirebaseUserToUserProfile(firebaseUser);
  }

  @override
  Future<bool> isSignedIn() async => _firebaseAuth.currentUser != null;

  @override
  Future<UserProfile?> signInWithEmail(String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) return null;
      return _mapFirebaseUserToUserProfile(credential.user!);
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseAuthException(e);
    } catch (e) {
      throw AuthenticationException('Sign in failed: $e');
    }
  }

  @override
  Future<UserProfile?> signInWithGoogle() async {
    // Placeholder implementation - remove Google Sign In dependency
    throw const AuthenticationException('Google Sign In not implemented');
  }

  @override
  Future<UserProfile?> createAccountWithEmail(
      String email, String password, String displayName) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) return null;

      await credential.user!.updateDisplayName(displayName);
      await credential.user!.reload();

      final updatedUser = _firebaseAuth.currentUser;
      if (updatedUser == null) return null;

      return _mapFirebaseUserToUserProfile(updatedUser);
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseAuthException(e);
    } catch (e) {
      throw AuthenticationException('Account creation failed: $e');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw AuthenticationException('Sign out failed: $e');
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseAuthException(e);
    } catch (e) {
      throw AuthenticationException('Password reset failed: $e');
    }
  }

  @override
  Future<void> updateProfile(UserProfile profile) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        throw const AuthenticationException('No user signed in');
      }

      if (profile.displayName != null) {
        await user.updateDisplayName(profile.displayName);
      }

      if (profile.photoUrl != null) {
        await user.updatePhotoURL(profile.photoUrl);
      }

      await user.reload();
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseAuthException(e);
    } catch (e) {
      throw AuthenticationException('Profile update failed: $e');
    }
  }

  @override
  Future<void> deleteAccount() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        throw const AuthenticationException('No user signed in');
      }

      await user.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        throw const AuthenticationException(
            'Please sign in again to delete your account');
      }
      throw _mapFirebaseAuthException(e);
    } catch (e) {
      throw AuthenticationException('Account deletion failed: $e');
    }
  }

  UserProfile _mapFirebaseUserToUserProfile(User firebaseUser) {
    return UserProfile(
      userId: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      displayName: firebaseUser.displayName,
      photoUrl: firebaseUser.photoURL,
      skillLevel: SkillLevel.beginner,
      dietaryRestrictions: [],
      allergies: [],
      favoriteIngredients: [],
      dislikedIngredients: [],
      kitchenEquipment: [],
      preferences: const CookingPreferences(
        maxCookingTime: 30,
        defaultServings: 4,
        preferQuickMeals: true,
        preferBatchCooking: false,
        preferOnePotMeals: false,
        commonSpices: ['salt', 'pepper', 'garlic powder'],
        spiceToleranceLevel: 5,
      ),
      nutritionalGoals: const NutritionalGoals(
        trackCalories: false,
        trackMacros: false,
        trackMicros: false,
      ),
      favoriteRecipes: [],
      savedCollections: [],
      createdAt: firebaseUser.metadata.creationTime ?? DateTime.now(),
      lastActiveAt: DateTime.now(),
      isEmailVerified: firebaseUser.emailVerified,
      isPremiumUser: false,
    );
  }

  AuthenticationException _mapFirebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return const AuthenticationException('No user found with this email');
      case 'wrong-password':
        return const AuthenticationException('Incorrect password');
      case 'email-already-in-use':
        return const AuthenticationException(
            'An account already exists with this email');
      case 'weak-password':
        return const AuthenticationException('Password is too weak');
      case 'invalid-email':
        return const AuthenticationException('Invalid email address');
      default:
        return AuthenticationException(e.message ?? 'Authentication failed');
    }
  }
}
