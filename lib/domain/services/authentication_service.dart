import '../entities/user_profile.dart';

abstract class AuthenticationService {
  Future<UserProfile?> signInWithGoogle();
  Future<UserProfile?> signInWithEmail(String email, String password);
  Future<UserProfile?> createAccountWithEmail(
    String email, 
    String password, 
    String displayName,
  );
  Future<void> signOut();
  Future<void> resetPassword(String email);
  Future<UserProfile?> getCurrentUser();
  Stream<UserProfile?> get authStateChanges;
  Future<bool> isSignedIn();
  Future<void> updateProfile(UserProfile profile);
  Future<void> deleteAccount();
}
