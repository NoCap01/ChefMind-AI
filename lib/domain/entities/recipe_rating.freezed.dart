// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipe_rating.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RecipeRating _$RecipeRatingFromJson(Map<String, dynamic> json) {
  return _RecipeRating.fromJson(json);
}

/// @nodoc
mixin _$RecipeRating {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get recipeId => throw _privateConstructorUsedError;
  @HiveField(2)
  String get userId => throw _privateConstructorUsedError;
  @HiveField(3)
  double get rating => throw _privateConstructorUsedError;
  @HiveField(4)
  String? get feedback => throw _privateConstructorUsedError;
  @HiveField(5)
  DateTime get createdAt => throw _privateConstructorUsedError;
  @HiveField(6)
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @HiveField(7)
  List<String> get tags => throw _privateConstructorUsedError;
  @HiveField(8)
  bool get wasSuccessful => throw _privateConstructorUsedError;
  @HiveField(9)
  Duration? get actualCookingTime => throw _privateConstructorUsedError;
  @HiveField(10)
  String? get notes => throw _privateConstructorUsedError;
  @HiveField(11)
  RatingType get type => throw _privateConstructorUsedError;

  /// Serializes this RecipeRating to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RecipeRating
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecipeRatingCopyWith<RecipeRating> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecipeRatingCopyWith<$Res> {
  factory $RecipeRatingCopyWith(
          RecipeRating value, $Res Function(RecipeRating) then) =
      _$RecipeRatingCopyWithImpl<$Res, RecipeRating>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String recipeId,
      @HiveField(2) String userId,
      @HiveField(3) double rating,
      @HiveField(4) String? feedback,
      @HiveField(5) DateTime createdAt,
      @HiveField(6) DateTime? updatedAt,
      @HiveField(7) List<String> tags,
      @HiveField(8) bool wasSuccessful,
      @HiveField(9) Duration? actualCookingTime,
      @HiveField(10) String? notes,
      @HiveField(11) RatingType type});
}

/// @nodoc
class _$RecipeRatingCopyWithImpl<$Res, $Val extends RecipeRating>
    implements $RecipeRatingCopyWith<$Res> {
  _$RecipeRatingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecipeRating
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? recipeId = null,
    Object? userId = null,
    Object? rating = null,
    Object? feedback = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? tags = null,
    Object? wasSuccessful = null,
    Object? actualCookingTime = freezed,
    Object? notes = freezed,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      recipeId: null == recipeId
          ? _value.recipeId
          : recipeId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      feedback: freezed == feedback
          ? _value.feedback
          : feedback // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      wasSuccessful: null == wasSuccessful
          ? _value.wasSuccessful
          : wasSuccessful // ignore: cast_nullable_to_non_nullable
              as bool,
      actualCookingTime: freezed == actualCookingTime
          ? _value.actualCookingTime
          : actualCookingTime // ignore: cast_nullable_to_non_nullable
              as Duration?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as RatingType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecipeRatingImplCopyWith<$Res>
    implements $RecipeRatingCopyWith<$Res> {
  factory _$$RecipeRatingImplCopyWith(
          _$RecipeRatingImpl value, $Res Function(_$RecipeRatingImpl) then) =
      __$$RecipeRatingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String recipeId,
      @HiveField(2) String userId,
      @HiveField(3) double rating,
      @HiveField(4) String? feedback,
      @HiveField(5) DateTime createdAt,
      @HiveField(6) DateTime? updatedAt,
      @HiveField(7) List<String> tags,
      @HiveField(8) bool wasSuccessful,
      @HiveField(9) Duration? actualCookingTime,
      @HiveField(10) String? notes,
      @HiveField(11) RatingType type});
}

/// @nodoc
class __$$RecipeRatingImplCopyWithImpl<$Res>
    extends _$RecipeRatingCopyWithImpl<$Res, _$RecipeRatingImpl>
    implements _$$RecipeRatingImplCopyWith<$Res> {
  __$$RecipeRatingImplCopyWithImpl(
      _$RecipeRatingImpl _value, $Res Function(_$RecipeRatingImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecipeRating
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? recipeId = null,
    Object? userId = null,
    Object? rating = null,
    Object? feedback = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? tags = null,
    Object? wasSuccessful = null,
    Object? actualCookingTime = freezed,
    Object? notes = freezed,
    Object? type = null,
  }) {
    return _then(_$RecipeRatingImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      recipeId: null == recipeId
          ? _value.recipeId
          : recipeId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      feedback: freezed == feedback
          ? _value.feedback
          : feedback // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      wasSuccessful: null == wasSuccessful
          ? _value.wasSuccessful
          : wasSuccessful // ignore: cast_nullable_to_non_nullable
              as bool,
      actualCookingTime: freezed == actualCookingTime
          ? _value.actualCookingTime
          : actualCookingTime // ignore: cast_nullable_to_non_nullable
              as Duration?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as RatingType,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RecipeRatingImpl implements _RecipeRating {
  const _$RecipeRatingImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.recipeId,
      @HiveField(2) required this.userId,
      @HiveField(3) required this.rating,
      @HiveField(4) this.feedback,
      @HiveField(5) required this.createdAt,
      @HiveField(6) this.updatedAt,
      @HiveField(7) final List<String> tags = const [],
      @HiveField(8) this.wasSuccessful = false,
      @HiveField(9) this.actualCookingTime,
      @HiveField(10) this.notes,
      @HiveField(11) this.type = RatingType.general})
      : _tags = tags;

  factory _$RecipeRatingImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecipeRatingImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String recipeId;
  @override
  @HiveField(2)
  final String userId;
  @override
  @HiveField(3)
  final double rating;
  @override
  @HiveField(4)
  final String? feedback;
  @override
  @HiveField(5)
  final DateTime createdAt;
  @override
  @HiveField(6)
  final DateTime? updatedAt;
  final List<String> _tags;
  @override
  @JsonKey()
  @HiveField(7)
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  @JsonKey()
  @HiveField(8)
  final bool wasSuccessful;
  @override
  @HiveField(9)
  final Duration? actualCookingTime;
  @override
  @HiveField(10)
  final String? notes;
  @override
  @JsonKey()
  @HiveField(11)
  final RatingType type;

  @override
  String toString() {
    return 'RecipeRating(id: $id, recipeId: $recipeId, userId: $userId, rating: $rating, feedback: $feedback, createdAt: $createdAt, updatedAt: $updatedAt, tags: $tags, wasSuccessful: $wasSuccessful, actualCookingTime: $actualCookingTime, notes: $notes, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecipeRatingImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.recipeId, recipeId) ||
                other.recipeId == recipeId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.feedback, feedback) ||
                other.feedback == feedback) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.wasSuccessful, wasSuccessful) ||
                other.wasSuccessful == wasSuccessful) &&
            (identical(other.actualCookingTime, actualCookingTime) ||
                other.actualCookingTime == actualCookingTime) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      recipeId,
      userId,
      rating,
      feedback,
      createdAt,
      updatedAt,
      const DeepCollectionEquality().hash(_tags),
      wasSuccessful,
      actualCookingTime,
      notes,
      type);

  /// Create a copy of RecipeRating
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecipeRatingImplCopyWith<_$RecipeRatingImpl> get copyWith =>
      __$$RecipeRatingImplCopyWithImpl<_$RecipeRatingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecipeRatingImplToJson(
      this,
    );
  }
}

abstract class _RecipeRating implements RecipeRating {
  const factory _RecipeRating(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String recipeId,
      @HiveField(2) required final String userId,
      @HiveField(3) required final double rating,
      @HiveField(4) final String? feedback,
      @HiveField(5) required final DateTime createdAt,
      @HiveField(6) final DateTime? updatedAt,
      @HiveField(7) final List<String> tags,
      @HiveField(8) final bool wasSuccessful,
      @HiveField(9) final Duration? actualCookingTime,
      @HiveField(10) final String? notes,
      @HiveField(11) final RatingType type}) = _$RecipeRatingImpl;

  factory _RecipeRating.fromJson(Map<String, dynamic> json) =
      _$RecipeRatingImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get recipeId;
  @override
  @HiveField(2)
  String get userId;
  @override
  @HiveField(3)
  double get rating;
  @override
  @HiveField(4)
  String? get feedback;
  @override
  @HiveField(5)
  DateTime get createdAt;
  @override
  @HiveField(6)
  DateTime? get updatedAt;
  @override
  @HiveField(7)
  List<String> get tags;
  @override
  @HiveField(8)
  bool get wasSuccessful;
  @override
  @HiveField(9)
  Duration? get actualCookingTime;
  @override
  @HiveField(10)
  String? get notes;
  @override
  @HiveField(11)
  RatingType get type;

  /// Create a copy of RecipeRating
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecipeRatingImplCopyWith<_$RecipeRatingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
