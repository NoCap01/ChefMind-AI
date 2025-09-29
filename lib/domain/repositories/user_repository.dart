import '../entities/user_profile.dart';

abstract class UserRepository {
  Future<void> createUserProfile(UserProfile profile);
  Future<UserProfile?> getUserProfile(String userId);
  Future<void> updateUserProfile(UserProfile profile);
  Future<void> deleteUserProfile(String userId);
  Future<List<UserProfile>> searchUsers(String query);
  Future<void> followUser(String userId, String followUserId);
  Future<void> unfollowUser(String userId, String unfollowUserId);
  Future<List<String>> getFollowing(String userId);
  Future<List<String>> getFollowers(String userId);
  Stream<UserProfile?> watchUserProfile(String userId);
}
