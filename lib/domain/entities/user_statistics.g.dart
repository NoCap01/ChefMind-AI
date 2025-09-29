// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_statistics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserStatisticsImpl _$$UserStatisticsImplFromJson(Map<String, dynamic> json) =>
    _$UserStatisticsImpl(
      userId: json['userId'] as String,
      recipesGenerated: (json['recipesGenerated'] as num).toInt(),
      recipesCooked: (json['recipesCooked'] as num).toInt(),
      favoriteRecipes: (json['favoriteRecipes'] as num).toInt(),
      cuisinePreferences:
          Map<String, int>.from(json['cuisinePreferences'] as Map),
      ingredientUsage: Map<String, int>.from(json['ingredientUsage'] as Map),
      cookingMethods: Map<String, int>.from(json['cookingMethods'] as Map),
      averageRating: (json['averageRating'] as num).toDouble(),
      totalCookingTime: (json['totalCookingTime'] as num).toInt(),
      lastActivity: DateTime.parse(json['lastActivity'] as String),
      achievements: json['achievements'] as Map<String, dynamic>? ?? const {},
      streakDays: (json['streakDays'] as num?)?.toInt() ?? 0,
      totalCaloriesCooked: (json['totalCaloriesCooked'] as num?)?.toInt() ?? 0,
      nutritionStats: (json['nutritionStats'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toInt()),
          ) ??
          const {},
    );

Map<String, dynamic> _$$UserStatisticsImplToJson(
        _$UserStatisticsImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'recipesGenerated': instance.recipesGenerated,
      'recipesCooked': instance.recipesCooked,
      'favoriteRecipes': instance.favoriteRecipes,
      'cuisinePreferences': instance.cuisinePreferences,
      'ingredientUsage': instance.ingredientUsage,
      'cookingMethods': instance.cookingMethods,
      'averageRating': instance.averageRating,
      'totalCookingTime': instance.totalCookingTime,
      'lastActivity': instance.lastActivity.toIso8601String(),
      'achievements': instance.achievements,
      'streakDays': instance.streakDays,
      'totalCaloriesCooked': instance.totalCaloriesCooked,
      'nutritionStats': instance.nutritionStats,
    };

_$CookingAchievementImpl _$$CookingAchievementImplFromJson(
        Map<String, dynamic> json) =>
    _$CookingAchievementImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      iconPath: json['iconPath'] as String,
      unlockedAt: DateTime.parse(json['unlockedAt'] as String),
      isUnlocked: json['isUnlocked'] as bool? ?? false,
    );

Map<String, dynamic> _$$CookingAchievementImplToJson(
        _$CookingAchievementImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'iconPath': instance.iconPath,
      'unlockedAt': instance.unlockedAt.toIso8601String(),
      'isUnlocked': instance.isUnlocked,
    };
