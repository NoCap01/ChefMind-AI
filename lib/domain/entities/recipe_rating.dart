import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'recipe.dart';

part 'recipe_rating.freezed.dart';
part 'recipe_rating.g.dart';

@freezed
@HiveType(typeId: 70)
class RecipeRating with _$RecipeRating {
  const factory RecipeRating({
    @HiveField(0) required String id,
    @HiveField(1) required String recipeId,
    @HiveField(2) required String userId,
    @HiveField(3) required double rating,
    @HiveField(4) String? feedback,
    @HiveField(5) required DateTime createdAt,
    @HiveField(6) DateTime? updatedAt,
    @HiveField(7) @Default([]) List<String> tags,
    @HiveField(8) @Default(false) bool wasSuccessful,
    @HiveField(9) Duration? actualCookingTime,
    @HiveField(10) String? notes,
    @HiveField(11) @Default(RatingType.general) RatingType type,
  }) = _RecipeRating;

  factory RecipeRating.fromJson(Map<String, dynamic> json) =>
      _$RecipeRatingFromJson(json);
}

@HiveType(typeId: 74)
enum RatingType {
  @HiveField(0)
  general,
  @HiveField(1)
  taste,
  @HiveField(2)
  difficulty,
  @HiveField(3)
  instructions,
  @HiveField(4)
  presentation,
}

extension RatingTypeExtension on RatingType {
  String get displayName {
    switch (this) {
      case RatingType.general:
        return 'Overall';
      case RatingType.taste:
        return 'Taste';
      case RatingType.difficulty:
        return 'Difficulty';
      case RatingType.instructions:
        return 'Instructions';
      case RatingType.presentation:
        return 'Presentation';
    }
  }
}
