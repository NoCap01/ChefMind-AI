import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'recipe.dart';

part 'community.freezed.dart';
part 'community.g.dart';

@freezed
@HiveType(typeId: 32)
class CommunityRecipe with _$CommunityRecipe {
  const factory CommunityRecipe({
    @HiveField(0) required String id,
    @HiveField(1) required String authorId,
    @HiveField(2) required String authorName,
    @HiveField(3) String? authorImageUrl,
    @HiveField(4) required Recipe recipe,
    @HiveField(5) required DateTime publishedAt,
    @HiveField(6) required DateTime lastUpdated,
    @HiveField(7) @Default(0) int likes,
    @HiveField(8) @Default(0) int saves,
    @HiveField(9) @Default(0) int shares,
    @HiveField(10) @Default(0) int comments,
    @HiveField(11) @Default(0.0) double averageRating,
    @HiveField(12) @Default(0) int ratingCount,
    @HiveField(13) @Default([]) List<String> tags,
    @HiveField(14) @Default(RecipeVisibility.public) RecipeVisibility visibility,
    @HiveField(15) @Default(false) bool isFeatured,
    @HiveField(16) @Default(false) bool isVerified,
  }) = _CommunityRecipe;

  factory CommunityRecipe.fromJson(Map<String, dynamic> json) => _$CommunityRecipeFromJson(json);
}

@freezed
@HiveType(typeId: 33)
class RecipeComment with _$RecipeComment {
  const factory RecipeComment({
    @HiveField(0) required String id,
    @HiveField(1) required String recipeId,
    @HiveField(2) required String authorId,
    @HiveField(3) required String authorName,
    @HiveField(4) String? authorImageUrl,
    @HiveField(5) required String content,
    @HiveField(6) required DateTime createdAt,
    @HiveField(7) DateTime? updatedAt,
    @HiveField(8) @Default(0) int likes,
    @HiveField(9) String? parentCommentId,
    @HiveField(10) @Default([]) List<String> replies,
    @HiveField(11) @Default(false) bool isEdited,
    @HiveField(12) @Default([]) List<String> imageUrls,
  }) = _RecipeComment;

  factory RecipeComment.fromJson(Map<String, dynamic> json) => _$RecipeCommentFromJson(json);
}

@freezed
@HiveType(typeId: 34)
class RecipeRating with _$RecipeRating {
  const factory RecipeRating({
    @HiveField(0) required String id,
    @HiveField(1) required String recipeId,
    @HiveField(2) required String userId,
    @HiveField(3) required double rating,
    @HiveField(4) String? review,
    @HiveField(5) required DateTime createdAt,
    @HiveField(6) DateTime? updatedAt,
    @HiveField(7) @Default([]) List<String> imageUrls,
    @HiveField(8) @Default(0) int helpfulVotes,
    @HiveField(9) @Default([]) List<RatingCriteria> criteria,
  }) = _RecipeRating;

  factory RecipeRating.fromJson(Map<String, dynamic> json) => _$RecipeRatingFromJson(json);
}

@freezed
@HiveType(typeId: 35)
class RatingCriteria with _$RatingCriteria {
  const factory RatingCriteria({
    @HiveField(0) required String name,
    @HiveField(1) required double score,
    @HiveField(2) String? comment,
  }) = _RatingCriteria;

  factory RatingCriteria.fromJson(Map<String, dynamic> json) => _$RatingCriteriaFromJson(json);
}

@freezed
@HiveType(typeId: 36)
class CookingGroup with _$CookingGroup {
  const factory CookingGroup({
    @HiveField(0) required String id,
    @HiveField(1) required String name,
    @HiveField(2) required String description,
    @HiveField(3) String? imageUrl,
    @HiveField(4) required String creatorId,
    @HiveField(5) required DateTime createdAt,
    @HiveField(6) @Default([]) List<String> memberIds,
    @HiveField(7) @Default([]) List<String> adminIds,
    @HiveField(8) @Default([]) List<String> recipeIds,
    @HiveField(9) @Default([]) List<String> challengeIds,
    @HiveField(10) @Default(GroupVisibility.public) GroupVisibility visibility,
    @HiveField(11) @Default(false) bool requiresApproval,
    @HiveField(12) @Default([]) List<String> tags,
    @HiveField(13) @Default({}) Map<String, dynamic> settings,
  }) = _CookingGroup;

  factory CookingGroup.fromJson(Map<String, dynamic> json) => _$CookingGroupFromJson(json);
}

@freezed
@HiveType(typeId: 37)
class Challenge with _$Challenge {
  const factory Challenge({
    @HiveField(0) required String id,
    @HiveField(1) required String title,
    @HiveField(2) required String description,
    @HiveField(3) String? imageUrl,
    @HiveField(4) required String creatorId,
    @HiveField(5) required DateTime startDate,
    @HiveField(6) required DateTime endDate,
    @HiveField(7) required ChallengeType type,
    @HiveField(8) required Map<String, dynamic> rules,
    @HiveField(9) @Default([]) List<String> participantIds,
    @HiveField(10) @Default([]) List<ChallengeSubmission> submissions,
    @HiveField(11) @Default([]) List<ChallengePrize> prizes,
    @HiveField(12) @Default(ChallengeStatus.upcoming) ChallengeStatus status,
    @HiveField(13) @Default([]) List<String> tags,
    @HiveField(14) String? groupId,
  }) = _Challenge;

  factory Challenge.fromJson(Map<String, dynamic> json) => _$ChallengeFromJson(json);
}

@freezed
@HiveType(typeId: 38)
class ChallengeSubmission with _$ChallengeSubmission {
  const factory ChallengeSubmission({
    @HiveField(0) required String id,
    @HiveField(1) required String challengeId,
    @HiveField(2) required String userId,
    @HiveField(3) required String userName,
    @HiveField(4) String? userImageUrl,
    @HiveField(5) required String recipeId,
    @HiveField(6) required DateTime submittedAt,
    @HiveField(7) @Default([]) List<String> imageUrls,
    @HiveField(8) String? description,
    @HiveField(9) @Default(0) int votes,
    @HiveField(10) @Default(0.0) double score,
    @HiveField(11) @Default(SubmissionStatus.pending) SubmissionStatus status,
  }) = _ChallengeSubmission;

  factory ChallengeSubmission.fromJson(Map<String, dynamic> json) => _$ChallengeSubmissionFromJson(json);
}

@freezed
@HiveType(typeId: 39)
class ChallengePrize with _$ChallengePrize {
  const factory ChallengePrize({
    @HiveField(0) required String id,
    @HiveField(1) required String title,
    @HiveField(2) required String description,
    @HiveField(3) String? imageUrl,
    @HiveField(4) required PrizeType type,
    @HiveField(5) String? value,
    @HiveField(6) required int position, // 1st, 2nd, 3rd place
    @HiveField(7) String? winnerId,
  }) = _ChallengePrize;

  factory ChallengePrize.fromJson(Map<String, dynamic> json) => _$ChallengePrizeFromJson(json);
}

@freezed
@HiveType(typeId: 40)
class SocialConnection with _$SocialConnection {
  const factory SocialConnection({
    @HiveField(0) required String id,
    @HiveField(1) required String userId,
    @HiveField(2) required String connectedUserId,
    @HiveField(3) required ConnectionType type,
    @HiveField(4) required DateTime createdAt,
    @HiveField(5) @Default(ConnectionStatus.pending) ConnectionStatus status,
  }) = _SocialConnection;

  factory SocialConnection.fromJson(Map<String, dynamic> json) => _$SocialConnectionFromJson(json);
}

@HiveType(typeId: 41)
enum RecipeVisibility {
  @HiveField(0)
  public,
  @HiveField(1)
  private,
  @HiveField(2)
  friendsOnly,
  @HiveField(3)
  groupOnly,
}

@HiveType(typeId: 42)
enum GroupVisibility {
  @HiveField(0)
  public,
  @HiveField(1)
  private,
  @HiveField(2)
  inviteOnly,
}

@HiveType(typeId: 43)
enum ChallengeType {
  @HiveField(0)
  recipe,
  @HiveField(1)
  ingredient,
  @HiveField(2)
  technique,
  @HiveField(3)
  time,
  @HiveField(4)
  budget,
  @HiveField(5)
  dietary,
  @HiveField(6)
  seasonal,
}

@HiveType(typeId: 44)
enum ChallengeStatus {
  @HiveField(0)
  upcoming,
  @HiveField(1)
  active,
  @HiveField(2)
  judging,
  @HiveField(3)
  completed,
  @HiveField(4)
  cancelled,
}

@HiveType(typeId: 45)
enum SubmissionStatus {
  @HiveField(0)
  pending,
  @HiveField(1)
  approved,
  @HiveField(2)
  rejected,
  @HiveField(3)
  winner,
}

@HiveType(typeId: 46)
enum PrizeType {
  @HiveField(0)
  badge,
  @HiveField(1)
  points,
  @HiveField(2)
  gift,
  @HiveField(3)
  recognition,
  @HiveField(4)
  premium,
}

@HiveType(typeId: 47)
enum ConnectionType {
  @HiveField(0)
  follow,
  @HiveField(1)
  friend,
  @HiveField(2)
  mentor,
  @HiveField(3)
  student,
}

@HiveType(typeId: 48)
enum ConnectionStatus {
  @HiveField(0)
  pending,
  @HiveField(1)
  accepted,
  @HiveField(2)
  rejected,
  @HiveField(3)
  blocked,
}