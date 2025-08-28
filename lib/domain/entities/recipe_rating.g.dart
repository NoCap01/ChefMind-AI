// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_rating.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RecipeRatingImpl _$$RecipeRatingImplFromJson(Map<String, dynamic> json) =>
    _$RecipeRatingImpl(
      id: json['id'] as String,
      recipeId: json['recipeId'] as String,
      userId: json['userId'] as String,
      rating: (json['rating'] as num).toDouble(),
      feedback: json['feedback'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      wasSuccessful: json['wasSuccessful'] as bool? ?? false,
      actualCookingTime: json['actualCookingTime'] == null
          ? null
          : Duration(microseconds: (json['actualCookingTime'] as num).toInt()),
      notes: json['notes'] as String?,
      type: $enumDecodeNullable(_$RatingTypeEnumMap, json['type']) ??
          RatingType.general,
    );

Map<String, dynamic> _$$RecipeRatingImplToJson(_$RecipeRatingImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'recipeId': instance.recipeId,
      'userId': instance.userId,
      'rating': instance.rating,
      'feedback': instance.feedback,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'tags': instance.tags,
      'wasSuccessful': instance.wasSuccessful,
      'actualCookingTime': instance.actualCookingTime?.inMicroseconds,
      'notes': instance.notes,
      'type': _$RatingTypeEnumMap[instance.type]!,
    };

const _$RatingTypeEnumMap = {
  RatingType.general: 'general',
  RatingType.taste: 'taste',
  RatingType.difficulty: 'difficulty',
  RatingType.instructions: 'instructions',
  RatingType.presentation: 'presentation',
};
