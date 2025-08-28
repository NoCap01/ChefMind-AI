// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommunityRecipeImpl _$$CommunityRecipeImplFromJson(
        Map<String, dynamic> json) =>
    _$CommunityRecipeImpl(
      id: json['id'] as String,
      authorId: json['authorId'] as String,
      authorName: json['authorName'] as String,
      authorImageUrl: json['authorImageUrl'] as String?,
      recipe: Recipe.fromJson(json['recipe'] as Map<String, dynamic>),
      publishedAt: DateTime.parse(json['publishedAt'] as String),
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
      likes: (json['likes'] as num?)?.toInt() ?? 0,
      saves: (json['saves'] as num?)?.toInt() ?? 0,
      shares: (json['shares'] as num?)?.toInt() ?? 0,
      comments: (json['comments'] as num?)?.toInt() ?? 0,
      averageRating: (json['averageRating'] as num?)?.toDouble() ?? 0.0,
      ratingCount: (json['ratingCount'] as num?)?.toInt() ?? 0,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      visibility:
          $enumDecodeNullable(_$RecipeVisibilityEnumMap, json['visibility']) ??
              RecipeVisibility.public,
      isFeatured: json['isFeatured'] as bool? ?? false,
      isVerified: json['isVerified'] as bool? ?? false,
    );

Map<String, dynamic> _$$CommunityRecipeImplToJson(
        _$CommunityRecipeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'authorId': instance.authorId,
      'authorName': instance.authorName,
      'authorImageUrl': instance.authorImageUrl,
      'recipe': instance.recipe,
      'publishedAt': instance.publishedAt.toIso8601String(),
      'lastUpdated': instance.lastUpdated.toIso8601String(),
      'likes': instance.likes,
      'saves': instance.saves,
      'shares': instance.shares,
      'comments': instance.comments,
      'averageRating': instance.averageRating,
      'ratingCount': instance.ratingCount,
      'tags': instance.tags,
      'visibility': _$RecipeVisibilityEnumMap[instance.visibility]!,
      'isFeatured': instance.isFeatured,
      'isVerified': instance.isVerified,
    };

const _$RecipeVisibilityEnumMap = {
  RecipeVisibility.public: 'public',
  RecipeVisibility.private: 'private',
  RecipeVisibility.friendsOnly: 'friendsOnly',
  RecipeVisibility.groupOnly: 'groupOnly',
};

_$RecipeCommentImpl _$$RecipeCommentImplFromJson(Map<String, dynamic> json) =>
    _$RecipeCommentImpl(
      id: json['id'] as String,
      recipeId: json['recipeId'] as String,
      authorId: json['authorId'] as String,
      authorName: json['authorName'] as String,
      authorImageUrl: json['authorImageUrl'] as String?,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      likes: (json['likes'] as num?)?.toInt() ?? 0,
      parentCommentId: json['parentCommentId'] as String?,
      replies: (json['replies'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      isEdited: json['isEdited'] as bool? ?? false,
      imageUrls: (json['imageUrls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$RecipeCommentImplToJson(_$RecipeCommentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'recipeId': instance.recipeId,
      'authorId': instance.authorId,
      'authorName': instance.authorName,
      'authorImageUrl': instance.authorImageUrl,
      'content': instance.content,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'likes': instance.likes,
      'parentCommentId': instance.parentCommentId,
      'replies': instance.replies,
      'isEdited': instance.isEdited,
      'imageUrls': instance.imageUrls,
    };

_$RecipeRatingImpl _$$RecipeRatingImplFromJson(Map<String, dynamic> json) =>
    _$RecipeRatingImpl(
      id: json['id'] as String,
      recipeId: json['recipeId'] as String,
      userId: json['userId'] as String,
      rating: (json['rating'] as num).toDouble(),
      review: json['review'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      imageUrls: (json['imageUrls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      helpfulVotes: (json['helpfulVotes'] as num?)?.toInt() ?? 0,
      criteria: (json['criteria'] as List<dynamic>?)
              ?.map((e) => RatingCriteria.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$RecipeRatingImplToJson(_$RecipeRatingImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'recipeId': instance.recipeId,
      'userId': instance.userId,
      'rating': instance.rating,
      'review': instance.review,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'imageUrls': instance.imageUrls,
      'helpfulVotes': instance.helpfulVotes,
      'criteria': instance.criteria,
    };

_$RatingCriteriaImpl _$$RatingCriteriaImplFromJson(Map<String, dynamic> json) =>
    _$RatingCriteriaImpl(
      name: json['name'] as String,
      score: (json['score'] as num).toDouble(),
      comment: json['comment'] as String?,
    );

Map<String, dynamic> _$$RatingCriteriaImplToJson(
        _$RatingCriteriaImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'score': instance.score,
      'comment': instance.comment,
    };

_$CookingGroupImpl _$$CookingGroupImplFromJson(Map<String, dynamic> json) =>
    _$CookingGroupImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String?,
      creatorId: json['creatorId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      memberIds: (json['memberIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      adminIds: (json['adminIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      recipeIds: (json['recipeIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      challengeIds: (json['challengeIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      visibility:
          $enumDecodeNullable(_$GroupVisibilityEnumMap, json['visibility']) ??
              GroupVisibility.public,
      requiresApproval: json['requiresApproval'] as bool? ?? false,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      settings: json['settings'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$CookingGroupImplToJson(_$CookingGroupImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'creatorId': instance.creatorId,
      'createdAt': instance.createdAt.toIso8601String(),
      'memberIds': instance.memberIds,
      'adminIds': instance.adminIds,
      'recipeIds': instance.recipeIds,
      'challengeIds': instance.challengeIds,
      'visibility': _$GroupVisibilityEnumMap[instance.visibility]!,
      'requiresApproval': instance.requiresApproval,
      'tags': instance.tags,
      'settings': instance.settings,
    };

const _$GroupVisibilityEnumMap = {
  GroupVisibility.public: 'public',
  GroupVisibility.private: 'private',
  GroupVisibility.inviteOnly: 'inviteOnly',
};

_$ChallengeImpl _$$ChallengeImplFromJson(Map<String, dynamic> json) =>
    _$ChallengeImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String?,
      creatorId: json['creatorId'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      type: $enumDecode(_$ChallengeTypeEnumMap, json['type']),
      rules: json['rules'] as Map<String, dynamic>,
      participantIds: (json['participantIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      submissions: (json['submissions'] as List<dynamic>?)
              ?.map((e) =>
                  ChallengeSubmission.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      prizes: (json['prizes'] as List<dynamic>?)
              ?.map((e) => ChallengePrize.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      status: $enumDecodeNullable(_$ChallengeStatusEnumMap, json['status']) ??
          ChallengeStatus.upcoming,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      groupId: json['groupId'] as String?,
    );

Map<String, dynamic> _$$ChallengeImplToJson(_$ChallengeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'creatorId': instance.creatorId,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'type': _$ChallengeTypeEnumMap[instance.type]!,
      'rules': instance.rules,
      'participantIds': instance.participantIds,
      'submissions': instance.submissions,
      'prizes': instance.prizes,
      'status': _$ChallengeStatusEnumMap[instance.status]!,
      'tags': instance.tags,
      'groupId': instance.groupId,
    };

const _$ChallengeTypeEnumMap = {
  ChallengeType.recipe: 'recipe',
  ChallengeType.ingredient: 'ingredient',
  ChallengeType.technique: 'technique',
  ChallengeType.time: 'time',
  ChallengeType.budget: 'budget',
  ChallengeType.dietary: 'dietary',
  ChallengeType.seasonal: 'seasonal',
};

const _$ChallengeStatusEnumMap = {
  ChallengeStatus.upcoming: 'upcoming',
  ChallengeStatus.active: 'active',
  ChallengeStatus.judging: 'judging',
  ChallengeStatus.completed: 'completed',
  ChallengeStatus.cancelled: 'cancelled',
};

_$ChallengeSubmissionImpl _$$ChallengeSubmissionImplFromJson(
        Map<String, dynamic> json) =>
    _$ChallengeSubmissionImpl(
      id: json['id'] as String,
      challengeId: json['challengeId'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      userImageUrl: json['userImageUrl'] as String?,
      recipeId: json['recipeId'] as String,
      submittedAt: DateTime.parse(json['submittedAt'] as String),
      imageUrls: (json['imageUrls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      description: json['description'] as String?,
      votes: (json['votes'] as num?)?.toInt() ?? 0,
      score: (json['score'] as num?)?.toDouble() ?? 0.0,
      status: $enumDecodeNullable(_$SubmissionStatusEnumMap, json['status']) ??
          SubmissionStatus.pending,
    );

Map<String, dynamic> _$$ChallengeSubmissionImplToJson(
        _$ChallengeSubmissionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'challengeId': instance.challengeId,
      'userId': instance.userId,
      'userName': instance.userName,
      'userImageUrl': instance.userImageUrl,
      'recipeId': instance.recipeId,
      'submittedAt': instance.submittedAt.toIso8601String(),
      'imageUrls': instance.imageUrls,
      'description': instance.description,
      'votes': instance.votes,
      'score': instance.score,
      'status': _$SubmissionStatusEnumMap[instance.status]!,
    };

const _$SubmissionStatusEnumMap = {
  SubmissionStatus.pending: 'pending',
  SubmissionStatus.approved: 'approved',
  SubmissionStatus.rejected: 'rejected',
  SubmissionStatus.winner: 'winner',
};

_$ChallengePrizeImpl _$$ChallengePrizeImplFromJson(Map<String, dynamic> json) =>
    _$ChallengePrizeImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String?,
      type: $enumDecode(_$PrizeTypeEnumMap, json['type']),
      value: json['value'] as String?,
      position: (json['position'] as num).toInt(),
      winnerId: json['winnerId'] as String?,
    );

Map<String, dynamic> _$$ChallengePrizeImplToJson(
        _$ChallengePrizeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'type': _$PrizeTypeEnumMap[instance.type]!,
      'value': instance.value,
      'position': instance.position,
      'winnerId': instance.winnerId,
    };

const _$PrizeTypeEnumMap = {
  PrizeType.badge: 'badge',
  PrizeType.points: 'points',
  PrizeType.gift: 'gift',
  PrizeType.recognition: 'recognition',
  PrizeType.premium: 'premium',
};

_$SocialConnectionImpl _$$SocialConnectionImplFromJson(
        Map<String, dynamic> json) =>
    _$SocialConnectionImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      connectedUserId: json['connectedUserId'] as String,
      type: $enumDecode(_$ConnectionTypeEnumMap, json['type']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      status: $enumDecodeNullable(_$ConnectionStatusEnumMap, json['status']) ??
          ConnectionStatus.pending,
    );

Map<String, dynamic> _$$SocialConnectionImplToJson(
        _$SocialConnectionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'connectedUserId': instance.connectedUserId,
      'type': _$ConnectionTypeEnumMap[instance.type]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'status': _$ConnectionStatusEnumMap[instance.status]!,
    };

const _$ConnectionTypeEnumMap = {
  ConnectionType.follow: 'follow',
  ConnectionType.friend: 'friend',
  ConnectionType.mentor: 'mentor',
  ConnectionType.student: 'student',
};

const _$ConnectionStatusEnumMap = {
  ConnectionStatus.pending: 'pending',
  ConnectionStatus.accepted: 'accepted',
  ConnectionStatus.rejected: 'rejected',
  ConnectionStatus.blocked: 'blocked',
};
