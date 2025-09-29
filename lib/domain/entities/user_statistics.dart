import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_statistics.freezed.dart';
part 'user_statistics.g.dart';

@freezed
class UserStatistics with _$UserStatistics {
  const factory UserStatistics({
    required String userId,
    required int recipesGenerated,
    required int recipesCooked,
    required int favoriteRecipes,
    required Map<String, int> cuisinePreferences,
    required Map<String, int> ingredientUsage,
    required Map<String, int> cookingMethods,
    required double averageRating,
    required int totalCookingTime,
    required DateTime lastActivity,
    @Default({}) Map<String, dynamic> achievements,
    @Default(0) int streakDays,
    @Default(0) int totalCaloriesCooked,
    @Default({}) Map<String, int> nutritionStats,
  }) = _UserStatistics;

  factory UserStatistics.fromJson(Map<String, dynamic> json) =>
      _$UserStatisticsFromJson(json);
}

@freezed
class CookingAchievement with _$CookingAchievement {
  const factory CookingAchievement({
    required String id,
    required String title,
    required String description,
    required String iconPath,
    required DateTime unlockedAt,
    @Default(false) bool isUnlocked,
  }) = _CookingAchievement;

  factory CookingAchievement.fromJson(Map<String, dynamic> json) =>
      _$CookingAchievementFromJson(json);
}