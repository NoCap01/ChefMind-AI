import '../entities/community.dart';
import '../entities/recipe.dart';

abstract class ICommunityService {
  // Recipe sharing and publishing
  Future<void> shareRecipe(Recipe recipe, SharingOptions options);
  Future<void> publishRecipe(CommunityRecipe recipe);
  Future<void> unpublishRecipe(String recipeId);
  Future<void> updatePublishedRecipe(CommunityRecipe recipe);
  
  // Social interactions
  Future<void> likeRecipe(String userId, String recipeId);
  Future<void> unlikeRecipe(String userId, String recipeId);
  Future<void> saveRecipe(String userId, String recipeId);
  Future<void> unsaveRecipe(String userId, String recipeId);
  Future<void> reportRecipe(String userId, String recipeId, String reason);
  
  // Comments and discussions
  Future<void> addComment(RecipeComment comment);
  Future<void> replyToComment(String parentCommentId, RecipeComment reply);
  Future<void> editComment(String commentId, String newContent);
  Future<void> deleteComment(String commentId);
  Future<void> likeComment(String userId, String commentId);
  Future<void> reportComment(String userId, String commentId, String reason);
  
  // Recipe ratings and reviews
  Future<void> rateRecipe(RecipeRating rating);
  Future<void> updateRating(RecipeRating rating);
  Future<void> deleteRating(String ratingId);
  Future<List<RecipeRating>> getRecipeRatings(String recipeId);
  Future<double> getAverageRating(String recipeId);
  
  // Community discovery
  Future<List<CommunityRecipe>> getCommunityRecipes({
    int limit = 20,
    String? cursor,
    CommunityFilter? filter,
  });
  Future<List<CommunityRecipe>> getTrendingRecipes({int limit = 20});
  Future<List<CommunityRecipe>> getFeaturedRecipes({int limit = 10});
  Future<List<CommunityRecipe>> getRecentRecipes({int limit = 20});
  
  // User following and social connections
  Future<void> followUser(String followerId, String followeeId);
  Future<void> unfollowUser(String followerId, String followeeId);
  Future<List<String>> getFollowers(String userId);
  Future<List<String>> getFollowing(String userId);
  Future<bool> isFollowing(String followerId, String followeeId);
  
  // Cooking groups
  Future<void> createCookingGroup(CookingGroup group);
  Future<void> joinGroup(String userId, String groupId);
  Future<void> leaveGroup(String userId, String groupId);
  Future<void> inviteToGroup(String groupId, List<String> userIds);
  Future<List<CookingGroup>> getUserGroups(String userId);
  Future<List<CookingGroup>> searchGroups(String query);
  
  // Challenges and competitions
  Future<void> createChallenge(Challenge challenge);
  Future<void> joinChallenge(String userId, String challengeId);
  Future<void> submitToChallenge(ChallengeSubmission submission);
  Future<void> voteOnSubmission(String userId, String submissionId);
  Future<List<Challenge>> getActiveChallenges();
  Future<List<Challenge>> getUserChallenges(String userId);
  
  // Content moderation
  Future<void> moderateContent(String contentId, ModerationAction action, String reason);
  Future<List<ContentReport>> getPendingReports();
  Future<void> resolveReport(String reportId, ModerationDecision decision);
  
  // User profiles and achievements
  Future<CommunityProfile> getCommunityProfile(String userId);
  Future<void> updateCommunityProfile(CommunityProfile profile);
  Future<List<Achievement>> getUserAchievements(String userId);
  Future<void> awardAchievement(String userId, Achievement achievement);
  
  // Recipe collections and curation
  Future<void> createRecipeCollection(RecipeCollection collection);
  Future<void> addRecipeToCollection(String collectionId, String recipeId);
  Future<void> removeRecipeFromCollection(String collectionId, String recipeId);
  Future<List<RecipeCollection>> getUserCollections(String userId);
  Future<List<RecipeCollection>> getFeaturedCollections();
  
  // Live cooking sessions
  Future<void> startLiveCookingSession(LiveCookingSession session);
  Future<void> joinLiveCookingSession(String userId, String sessionId);
  Future<void> endLiveCookingSession(String sessionId);
  Future<List<LiveCookingSession>> getActiveLiveSessions();
  
  // Notifications and activity feed
  Future<List<CommunityNotification>> getUserNotifications(String userId);
  Future<void> markNotificationAsRead(String notificationId);
  Future<List<ActivityFeedItem>> getActivityFeed(String userId);
  
  // Search and discovery
  Future<List<CommunityRecipe>> searchRecipes(CommunitySearchQuery query);
  Future<List<CookingGroup>> searchGroups(GroupSearchQuery query);
  Future<List<CommunityProfile>> searchUsers(UserSearchQuery query);
  
  // Analytics and insights
  Future<CommunityAnalytics> getCommunityAnalytics(String userId);
  Future<Map<String, dynamic>> getRecipePerformance(String recipeId);
  Future<List<String>> getTrendingIngredients();
  Future<List<String>> getTrendingCuisines();
}

class SharingOptions {
  final RecipeVisibility visibility;
  final List<String>? shareWithGroups;
  final List<String>? shareWithUsers;
  final bool allowComments;
  final bool allowRatings;
  final String? message;
  final List<String> tags;

  const SharingOptions({
    required this.visibility,
    this.shareWithGroups,
    this.shareWithUsers,
    this.allowComments = true,
    this.allowRatings = true,
    this.message,
    this.tags = const [],
  });
}

class CommunityFilter {
  final List<String>? cuisines;
  final List<DifficultyLevel>? difficulties;
  final Duration? maxCookingTime;
  final List<DietaryRestriction>? dietaryRestrictions;
  final double? minRating;
  final List<String>? tags;
  final bool? isFeatured;
  final bool? isVerified;
  final DateTime? publishedAfter;
  final DateTime? publishedBefore;

  const CommunityFilter({
    this.cuisines,
    this.difficulties,
    this.maxCookingTime,
    this.dietaryRestrictions,
    this.minRating,
    this.tags,
    this.isFeatured,
    this.isVerified,
    this.publishedAfter,
    this.publishedBefore,
  });
}

enum ModerationAction {
  approve,
  reject,
  hide,
  flag,
  remove,
  warn,
  suspend,
  ban,
}

enum ModerationDecision {
  approved,
  rejected,
  needsReview,
  escalated,
}

class ContentReport {
  final String id;
  final String contentId;
  final String reporterId;
  final String reason;
  final String description;
  final DateTime reportedAt;
  final ReportStatus status;
  final String? moderatorId;
  final DateTime? resolvedAt;

  const ContentReport({
    required this.id,
    required this.contentId,
    required this.reporterId,
    required this.reason,
    required this.description,
    required this.reportedAt,
    required this.status,
    this.moderatorId,
    this.resolvedAt,
  });
}

enum ReportStatus {
  pending,
  underReview,
  resolved,
  dismissed,
}

class CommunityProfile {
  final String userId;
  final String displayName;
  final String? bio;
  final String? profileImageUrl;
  final List<String> specialties;
  final int recipesShared;
  final int followersCount;
  final int followingCount;
  final double averageRating;
  final List<Achievement> achievements;
  final DateTime joinedAt;
  final bool isVerified;
  final bool isMentor;

  const CommunityProfile({
    required this.userId,
    required this.displayName,
    this.bio,
    this.profileImageUrl,
    this.specialties = const [],
    this.recipesShared = 0,
    this.followersCount = 0,
    this.followingCount = 0,
    this.averageRating = 0.0,
    this.achievements = const [],
    required this.joinedAt,
    this.isVerified = false,
    this.isMentor = false,
  });
}

class Achievement {
  final String id;
  final String title;
  final String description;
  final String iconUrl;
  final AchievementType type;
  final int points;
  final DateTime earnedAt;
  final Map<String, dynamic>? metadata;

  const Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.iconUrl,
    required this.type,
    required this.points,
    required this.earnedAt,
    this.metadata,
  });
}

enum AchievementType {
  recipeCount,
  socialEngagement,
  skillMastery,
  challengeWinner,
  mentor,
  consistency,
  innovation,
  community,
}