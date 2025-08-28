import '../entities/user_profile.dart';
import '../entities/analytics.dart';

abstract class IUserRepository {
  // Basic user profile operations
  Future<UserProfile?> getUserProfile(String userId);
  Future<void> createUserProfile(UserProfile profile);
  Future<void> updateUserProfile(UserProfile profile);
  Future<void> deleteUserProfile(String userId);

  // User preferences and settings
  Future<void> updateUserPreferences(String userId, CookingPreferences preferences);
  Future<CookingPreferences?> getUserPreferences(String userId);
  Future<void> updateDietaryRestrictions(String userId, List<DietaryRestriction> restrictions);
  Future<void> updateAllergies(String userId, List<String> allergies);
  Future<void> updateSkillLevel(String userId, SkillLevel skillLevel);
  Future<void> updateKitchenEquipment(String userId, List<KitchenEquipment> equipment);

  // User statistics and counters
  Future<void> incrementRecipeCount(String userId);
  Future<void> incrementFavoriteCount(String userId);
  Future<void> decrementFavoriteCount(String userId);
  Future<void> updateCookingStreak(String userId, int streak);
  Future<void> recordCookingActivity(String userId, DateTime cookingDate);

  // User search and discovery
  Future<List<UserProfile>> searchUsers(String query);
  Future<List<UserProfile>> getUsersBySkillLevel(SkillLevel skillLevel);
  Future<List<UserProfile>> getUsersByCuisinePreference(String cuisine);
  Future<UserProfile?> getUserByEmail(String email);

  // User analytics and insights
  Future<UserAnalytics?> getUserAnalytics(String userId);
  Future<void> updateUserAnalytics(String userId, UserAnalytics analytics);
  Future<void> recordUserActivity(String userId, String activityType, Map<String, dynamic> data);

  // Profile image and media
  Future<void> updateProfileImage(String userId, String imageUrl);
  Future<void> deleteProfileImage(String userId);

  // Account management
  Future<void> deactivateAccount(String userId);
  Future<void> reactivateAccount(String userId);
  Future<bool> isAccountActive(String userId);
  Future<void> updateLastLoginDate(String userId);

  // Privacy and security
  Future<void> updatePrivacySettings(String userId, Map<String, dynamic> settings);
  Future<Map<String, dynamic>?> getPrivacySettings(String userId);
  Future<void> blockUser(String userId, String blockedUserId);
  Future<void> unblockUser(String userId, String blockedUserId);
  Future<List<String>> getBlockedUsers(String userId);

  // Data export and backup
  Future<Map<String, dynamic>> exportUserData(String userId);
  Future<void> importUserData(String userId, Map<String, dynamic> data);

  // Streaming data
  Stream<UserProfile?> watchUserProfile(String userId);
  Stream<UserAnalytics?> watchUserAnalytics(String userId);
}