// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'community.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CommunityRecipe _$CommunityRecipeFromJson(Map<String, dynamic> json) {
  return _CommunityRecipe.fromJson(json);
}

/// @nodoc
mixin _$CommunityRecipe {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get authorId => throw _privateConstructorUsedError;
  @HiveField(2)
  String get authorName => throw _privateConstructorUsedError;
  @HiveField(3)
  String? get authorImageUrl => throw _privateConstructorUsedError;
  @HiveField(4)
  Recipe get recipe => throw _privateConstructorUsedError;
  @HiveField(5)
  DateTime get publishedAt => throw _privateConstructorUsedError;
  @HiveField(6)
  DateTime get lastUpdated => throw _privateConstructorUsedError;
  @HiveField(7)
  int get likes => throw _privateConstructorUsedError;
  @HiveField(8)
  int get saves => throw _privateConstructorUsedError;
  @HiveField(9)
  int get shares => throw _privateConstructorUsedError;
  @HiveField(10)
  int get comments => throw _privateConstructorUsedError;
  @HiveField(11)
  double get averageRating => throw _privateConstructorUsedError;
  @HiveField(12)
  int get ratingCount => throw _privateConstructorUsedError;
  @HiveField(13)
  List<String> get tags => throw _privateConstructorUsedError;
  @HiveField(14)
  RecipeVisibility get visibility => throw _privateConstructorUsedError;
  @HiveField(15)
  bool get isFeatured => throw _privateConstructorUsedError;
  @HiveField(16)
  bool get isVerified => throw _privateConstructorUsedError;

  /// Serializes this CommunityRecipe to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CommunityRecipe
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommunityRecipeCopyWith<CommunityRecipe> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommunityRecipeCopyWith<$Res> {
  factory $CommunityRecipeCopyWith(
          CommunityRecipe value, $Res Function(CommunityRecipe) then) =
      _$CommunityRecipeCopyWithImpl<$Res, CommunityRecipe>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String authorId,
      @HiveField(2) String authorName,
      @HiveField(3) String? authorImageUrl,
      @HiveField(4) Recipe recipe,
      @HiveField(5) DateTime publishedAt,
      @HiveField(6) DateTime lastUpdated,
      @HiveField(7) int likes,
      @HiveField(8) int saves,
      @HiveField(9) int shares,
      @HiveField(10) int comments,
      @HiveField(11) double averageRating,
      @HiveField(12) int ratingCount,
      @HiveField(13) List<String> tags,
      @HiveField(14) RecipeVisibility visibility,
      @HiveField(15) bool isFeatured,
      @HiveField(16) bool isVerified});

  $RecipeCopyWith<$Res> get recipe;
}

/// @nodoc
class _$CommunityRecipeCopyWithImpl<$Res, $Val extends CommunityRecipe>
    implements $CommunityRecipeCopyWith<$Res> {
  _$CommunityRecipeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CommunityRecipe
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? authorId = null,
    Object? authorName = null,
    Object? authorImageUrl = freezed,
    Object? recipe = null,
    Object? publishedAt = null,
    Object? lastUpdated = null,
    Object? likes = null,
    Object? saves = null,
    Object? shares = null,
    Object? comments = null,
    Object? averageRating = null,
    Object? ratingCount = null,
    Object? tags = null,
    Object? visibility = null,
    Object? isFeatured = null,
    Object? isVerified = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      authorId: null == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      authorName: null == authorName
          ? _value.authorName
          : authorName // ignore: cast_nullable_to_non_nullable
              as String,
      authorImageUrl: freezed == authorImageUrl
          ? _value.authorImageUrl
          : authorImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      recipe: null == recipe
          ? _value.recipe
          : recipe // ignore: cast_nullable_to_non_nullable
              as Recipe,
      publishedAt: null == publishedAt
          ? _value.publishedAt
          : publishedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      likes: null == likes
          ? _value.likes
          : likes // ignore: cast_nullable_to_non_nullable
              as int,
      saves: null == saves
          ? _value.saves
          : saves // ignore: cast_nullable_to_non_nullable
              as int,
      shares: null == shares
          ? _value.shares
          : shares // ignore: cast_nullable_to_non_nullable
              as int,
      comments: null == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as int,
      averageRating: null == averageRating
          ? _value.averageRating
          : averageRating // ignore: cast_nullable_to_non_nullable
              as double,
      ratingCount: null == ratingCount
          ? _value.ratingCount
          : ratingCount // ignore: cast_nullable_to_non_nullable
              as int,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      visibility: null == visibility
          ? _value.visibility
          : visibility // ignore: cast_nullable_to_non_nullable
              as RecipeVisibility,
      isFeatured: null == isFeatured
          ? _value.isFeatured
          : isFeatured // ignore: cast_nullable_to_non_nullable
              as bool,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of CommunityRecipe
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RecipeCopyWith<$Res> get recipe {
    return $RecipeCopyWith<$Res>(_value.recipe, (value) {
      return _then(_value.copyWith(recipe: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CommunityRecipeImplCopyWith<$Res>
    implements $CommunityRecipeCopyWith<$Res> {
  factory _$$CommunityRecipeImplCopyWith(_$CommunityRecipeImpl value,
          $Res Function(_$CommunityRecipeImpl) then) =
      __$$CommunityRecipeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String authorId,
      @HiveField(2) String authorName,
      @HiveField(3) String? authorImageUrl,
      @HiveField(4) Recipe recipe,
      @HiveField(5) DateTime publishedAt,
      @HiveField(6) DateTime lastUpdated,
      @HiveField(7) int likes,
      @HiveField(8) int saves,
      @HiveField(9) int shares,
      @HiveField(10) int comments,
      @HiveField(11) double averageRating,
      @HiveField(12) int ratingCount,
      @HiveField(13) List<String> tags,
      @HiveField(14) RecipeVisibility visibility,
      @HiveField(15) bool isFeatured,
      @HiveField(16) bool isVerified});

  @override
  $RecipeCopyWith<$Res> get recipe;
}

/// @nodoc
class __$$CommunityRecipeImplCopyWithImpl<$Res>
    extends _$CommunityRecipeCopyWithImpl<$Res, _$CommunityRecipeImpl>
    implements _$$CommunityRecipeImplCopyWith<$Res> {
  __$$CommunityRecipeImplCopyWithImpl(
      _$CommunityRecipeImpl _value, $Res Function(_$CommunityRecipeImpl) _then)
      : super(_value, _then);

  /// Create a copy of CommunityRecipe
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? authorId = null,
    Object? authorName = null,
    Object? authorImageUrl = freezed,
    Object? recipe = null,
    Object? publishedAt = null,
    Object? lastUpdated = null,
    Object? likes = null,
    Object? saves = null,
    Object? shares = null,
    Object? comments = null,
    Object? averageRating = null,
    Object? ratingCount = null,
    Object? tags = null,
    Object? visibility = null,
    Object? isFeatured = null,
    Object? isVerified = null,
  }) {
    return _then(_$CommunityRecipeImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      authorId: null == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      authorName: null == authorName
          ? _value.authorName
          : authorName // ignore: cast_nullable_to_non_nullable
              as String,
      authorImageUrl: freezed == authorImageUrl
          ? _value.authorImageUrl
          : authorImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      recipe: null == recipe
          ? _value.recipe
          : recipe // ignore: cast_nullable_to_non_nullable
              as Recipe,
      publishedAt: null == publishedAt
          ? _value.publishedAt
          : publishedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      likes: null == likes
          ? _value.likes
          : likes // ignore: cast_nullable_to_non_nullable
              as int,
      saves: null == saves
          ? _value.saves
          : saves // ignore: cast_nullable_to_non_nullable
              as int,
      shares: null == shares
          ? _value.shares
          : shares // ignore: cast_nullable_to_non_nullable
              as int,
      comments: null == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as int,
      averageRating: null == averageRating
          ? _value.averageRating
          : averageRating // ignore: cast_nullable_to_non_nullable
              as double,
      ratingCount: null == ratingCount
          ? _value.ratingCount
          : ratingCount // ignore: cast_nullable_to_non_nullable
              as int,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      visibility: null == visibility
          ? _value.visibility
          : visibility // ignore: cast_nullable_to_non_nullable
              as RecipeVisibility,
      isFeatured: null == isFeatured
          ? _value.isFeatured
          : isFeatured // ignore: cast_nullable_to_non_nullable
              as bool,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CommunityRecipeImpl implements _CommunityRecipe {
  const _$CommunityRecipeImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.authorId,
      @HiveField(2) required this.authorName,
      @HiveField(3) this.authorImageUrl,
      @HiveField(4) required this.recipe,
      @HiveField(5) required this.publishedAt,
      @HiveField(6) required this.lastUpdated,
      @HiveField(7) this.likes = 0,
      @HiveField(8) this.saves = 0,
      @HiveField(9) this.shares = 0,
      @HiveField(10) this.comments = 0,
      @HiveField(11) this.averageRating = 0.0,
      @HiveField(12) this.ratingCount = 0,
      @HiveField(13) final List<String> tags = const [],
      @HiveField(14) this.visibility = RecipeVisibility.public,
      @HiveField(15) this.isFeatured = false,
      @HiveField(16) this.isVerified = false})
      : _tags = tags;

  factory _$CommunityRecipeImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommunityRecipeImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String authorId;
  @override
  @HiveField(2)
  final String authorName;
  @override
  @HiveField(3)
  final String? authorImageUrl;
  @override
  @HiveField(4)
  final Recipe recipe;
  @override
  @HiveField(5)
  final DateTime publishedAt;
  @override
  @HiveField(6)
  final DateTime lastUpdated;
  @override
  @JsonKey()
  @HiveField(7)
  final int likes;
  @override
  @JsonKey()
  @HiveField(8)
  final int saves;
  @override
  @JsonKey()
  @HiveField(9)
  final int shares;
  @override
  @JsonKey()
  @HiveField(10)
  final int comments;
  @override
  @JsonKey()
  @HiveField(11)
  final double averageRating;
  @override
  @JsonKey()
  @HiveField(12)
  final int ratingCount;
  final List<String> _tags;
  @override
  @JsonKey()
  @HiveField(13)
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  @JsonKey()
  @HiveField(14)
  final RecipeVisibility visibility;
  @override
  @JsonKey()
  @HiveField(15)
  final bool isFeatured;
  @override
  @JsonKey()
  @HiveField(16)
  final bool isVerified;

  @override
  String toString() {
    return 'CommunityRecipe(id: $id, authorId: $authorId, authorName: $authorName, authorImageUrl: $authorImageUrl, recipe: $recipe, publishedAt: $publishedAt, lastUpdated: $lastUpdated, likes: $likes, saves: $saves, shares: $shares, comments: $comments, averageRating: $averageRating, ratingCount: $ratingCount, tags: $tags, visibility: $visibility, isFeatured: $isFeatured, isVerified: $isVerified)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommunityRecipeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.authorName, authorName) ||
                other.authorName == authorName) &&
            (identical(other.authorImageUrl, authorImageUrl) ||
                other.authorImageUrl == authorImageUrl) &&
            (identical(other.recipe, recipe) || other.recipe == recipe) &&
            (identical(other.publishedAt, publishedAt) ||
                other.publishedAt == publishedAt) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated) &&
            (identical(other.likes, likes) || other.likes == likes) &&
            (identical(other.saves, saves) || other.saves == saves) &&
            (identical(other.shares, shares) || other.shares == shares) &&
            (identical(other.comments, comments) ||
                other.comments == comments) &&
            (identical(other.averageRating, averageRating) ||
                other.averageRating == averageRating) &&
            (identical(other.ratingCount, ratingCount) ||
                other.ratingCount == ratingCount) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.visibility, visibility) ||
                other.visibility == visibility) &&
            (identical(other.isFeatured, isFeatured) ||
                other.isFeatured == isFeatured) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      authorId,
      authorName,
      authorImageUrl,
      recipe,
      publishedAt,
      lastUpdated,
      likes,
      saves,
      shares,
      comments,
      averageRating,
      ratingCount,
      const DeepCollectionEquality().hash(_tags),
      visibility,
      isFeatured,
      isVerified);

  /// Create a copy of CommunityRecipe
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommunityRecipeImplCopyWith<_$CommunityRecipeImpl> get copyWith =>
      __$$CommunityRecipeImplCopyWithImpl<_$CommunityRecipeImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CommunityRecipeImplToJson(
      this,
    );
  }
}

abstract class _CommunityRecipe implements CommunityRecipe {
  const factory _CommunityRecipe(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String authorId,
      @HiveField(2) required final String authorName,
      @HiveField(3) final String? authorImageUrl,
      @HiveField(4) required final Recipe recipe,
      @HiveField(5) required final DateTime publishedAt,
      @HiveField(6) required final DateTime lastUpdated,
      @HiveField(7) final int likes,
      @HiveField(8) final int saves,
      @HiveField(9) final int shares,
      @HiveField(10) final int comments,
      @HiveField(11) final double averageRating,
      @HiveField(12) final int ratingCount,
      @HiveField(13) final List<String> tags,
      @HiveField(14) final RecipeVisibility visibility,
      @HiveField(15) final bool isFeatured,
      @HiveField(16) final bool isVerified}) = _$CommunityRecipeImpl;

  factory _CommunityRecipe.fromJson(Map<String, dynamic> json) =
      _$CommunityRecipeImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get authorId;
  @override
  @HiveField(2)
  String get authorName;
  @override
  @HiveField(3)
  String? get authorImageUrl;
  @override
  @HiveField(4)
  Recipe get recipe;
  @override
  @HiveField(5)
  DateTime get publishedAt;
  @override
  @HiveField(6)
  DateTime get lastUpdated;
  @override
  @HiveField(7)
  int get likes;
  @override
  @HiveField(8)
  int get saves;
  @override
  @HiveField(9)
  int get shares;
  @override
  @HiveField(10)
  int get comments;
  @override
  @HiveField(11)
  double get averageRating;
  @override
  @HiveField(12)
  int get ratingCount;
  @override
  @HiveField(13)
  List<String> get tags;
  @override
  @HiveField(14)
  RecipeVisibility get visibility;
  @override
  @HiveField(15)
  bool get isFeatured;
  @override
  @HiveField(16)
  bool get isVerified;

  /// Create a copy of CommunityRecipe
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommunityRecipeImplCopyWith<_$CommunityRecipeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RecipeComment _$RecipeCommentFromJson(Map<String, dynamic> json) {
  return _RecipeComment.fromJson(json);
}

/// @nodoc
mixin _$RecipeComment {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get recipeId => throw _privateConstructorUsedError;
  @HiveField(2)
  String get authorId => throw _privateConstructorUsedError;
  @HiveField(3)
  String get authorName => throw _privateConstructorUsedError;
  @HiveField(4)
  String? get authorImageUrl => throw _privateConstructorUsedError;
  @HiveField(5)
  String get content => throw _privateConstructorUsedError;
  @HiveField(6)
  DateTime get createdAt => throw _privateConstructorUsedError;
  @HiveField(7)
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @HiveField(8)
  int get likes => throw _privateConstructorUsedError;
  @HiveField(9)
  String? get parentCommentId => throw _privateConstructorUsedError;
  @HiveField(10)
  List<String> get replies => throw _privateConstructorUsedError;
  @HiveField(11)
  bool get isEdited => throw _privateConstructorUsedError;
  @HiveField(12)
  List<String> get imageUrls => throw _privateConstructorUsedError;

  /// Serializes this RecipeComment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RecipeComment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecipeCommentCopyWith<RecipeComment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecipeCommentCopyWith<$Res> {
  factory $RecipeCommentCopyWith(
          RecipeComment value, $Res Function(RecipeComment) then) =
      _$RecipeCommentCopyWithImpl<$Res, RecipeComment>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String recipeId,
      @HiveField(2) String authorId,
      @HiveField(3) String authorName,
      @HiveField(4) String? authorImageUrl,
      @HiveField(5) String content,
      @HiveField(6) DateTime createdAt,
      @HiveField(7) DateTime? updatedAt,
      @HiveField(8) int likes,
      @HiveField(9) String? parentCommentId,
      @HiveField(10) List<String> replies,
      @HiveField(11) bool isEdited,
      @HiveField(12) List<String> imageUrls});
}

/// @nodoc
class _$RecipeCommentCopyWithImpl<$Res, $Val extends RecipeComment>
    implements $RecipeCommentCopyWith<$Res> {
  _$RecipeCommentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecipeComment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? recipeId = null,
    Object? authorId = null,
    Object? authorName = null,
    Object? authorImageUrl = freezed,
    Object? content = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? likes = null,
    Object? parentCommentId = freezed,
    Object? replies = null,
    Object? isEdited = null,
    Object? imageUrls = null,
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
      authorId: null == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      authorName: null == authorName
          ? _value.authorName
          : authorName // ignore: cast_nullable_to_non_nullable
              as String,
      authorImageUrl: freezed == authorImageUrl
          ? _value.authorImageUrl
          : authorImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      likes: null == likes
          ? _value.likes
          : likes // ignore: cast_nullable_to_non_nullable
              as int,
      parentCommentId: freezed == parentCommentId
          ? _value.parentCommentId
          : parentCommentId // ignore: cast_nullable_to_non_nullable
              as String?,
      replies: null == replies
          ? _value.replies
          : replies // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isEdited: null == isEdited
          ? _value.isEdited
          : isEdited // ignore: cast_nullable_to_non_nullable
              as bool,
      imageUrls: null == imageUrls
          ? _value.imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecipeCommentImplCopyWith<$Res>
    implements $RecipeCommentCopyWith<$Res> {
  factory _$$RecipeCommentImplCopyWith(
          _$RecipeCommentImpl value, $Res Function(_$RecipeCommentImpl) then) =
      __$$RecipeCommentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String recipeId,
      @HiveField(2) String authorId,
      @HiveField(3) String authorName,
      @HiveField(4) String? authorImageUrl,
      @HiveField(5) String content,
      @HiveField(6) DateTime createdAt,
      @HiveField(7) DateTime? updatedAt,
      @HiveField(8) int likes,
      @HiveField(9) String? parentCommentId,
      @HiveField(10) List<String> replies,
      @HiveField(11) bool isEdited,
      @HiveField(12) List<String> imageUrls});
}

/// @nodoc
class __$$RecipeCommentImplCopyWithImpl<$Res>
    extends _$RecipeCommentCopyWithImpl<$Res, _$RecipeCommentImpl>
    implements _$$RecipeCommentImplCopyWith<$Res> {
  __$$RecipeCommentImplCopyWithImpl(
      _$RecipeCommentImpl _value, $Res Function(_$RecipeCommentImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecipeComment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? recipeId = null,
    Object? authorId = null,
    Object? authorName = null,
    Object? authorImageUrl = freezed,
    Object? content = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? likes = null,
    Object? parentCommentId = freezed,
    Object? replies = null,
    Object? isEdited = null,
    Object? imageUrls = null,
  }) {
    return _then(_$RecipeCommentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      recipeId: null == recipeId
          ? _value.recipeId
          : recipeId // ignore: cast_nullable_to_non_nullable
              as String,
      authorId: null == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      authorName: null == authorName
          ? _value.authorName
          : authorName // ignore: cast_nullable_to_non_nullable
              as String,
      authorImageUrl: freezed == authorImageUrl
          ? _value.authorImageUrl
          : authorImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      likes: null == likes
          ? _value.likes
          : likes // ignore: cast_nullable_to_non_nullable
              as int,
      parentCommentId: freezed == parentCommentId
          ? _value.parentCommentId
          : parentCommentId // ignore: cast_nullable_to_non_nullable
              as String?,
      replies: null == replies
          ? _value._replies
          : replies // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isEdited: null == isEdited
          ? _value.isEdited
          : isEdited // ignore: cast_nullable_to_non_nullable
              as bool,
      imageUrls: null == imageUrls
          ? _value._imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RecipeCommentImpl implements _RecipeComment {
  const _$RecipeCommentImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.recipeId,
      @HiveField(2) required this.authorId,
      @HiveField(3) required this.authorName,
      @HiveField(4) this.authorImageUrl,
      @HiveField(5) required this.content,
      @HiveField(6) required this.createdAt,
      @HiveField(7) this.updatedAt,
      @HiveField(8) this.likes = 0,
      @HiveField(9) this.parentCommentId,
      @HiveField(10) final List<String> replies = const [],
      @HiveField(11) this.isEdited = false,
      @HiveField(12) final List<String> imageUrls = const []})
      : _replies = replies,
        _imageUrls = imageUrls;

  factory _$RecipeCommentImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecipeCommentImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String recipeId;
  @override
  @HiveField(2)
  final String authorId;
  @override
  @HiveField(3)
  final String authorName;
  @override
  @HiveField(4)
  final String? authorImageUrl;
  @override
  @HiveField(5)
  final String content;
  @override
  @HiveField(6)
  final DateTime createdAt;
  @override
  @HiveField(7)
  final DateTime? updatedAt;
  @override
  @JsonKey()
  @HiveField(8)
  final int likes;
  @override
  @HiveField(9)
  final String? parentCommentId;
  final List<String> _replies;
  @override
  @JsonKey()
  @HiveField(10)
  List<String> get replies {
    if (_replies is EqualUnmodifiableListView) return _replies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_replies);
  }

  @override
  @JsonKey()
  @HiveField(11)
  final bool isEdited;
  final List<String> _imageUrls;
  @override
  @JsonKey()
  @HiveField(12)
  List<String> get imageUrls {
    if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imageUrls);
  }

  @override
  String toString() {
    return 'RecipeComment(id: $id, recipeId: $recipeId, authorId: $authorId, authorName: $authorName, authorImageUrl: $authorImageUrl, content: $content, createdAt: $createdAt, updatedAt: $updatedAt, likes: $likes, parentCommentId: $parentCommentId, replies: $replies, isEdited: $isEdited, imageUrls: $imageUrls)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecipeCommentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.recipeId, recipeId) ||
                other.recipeId == recipeId) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.authorName, authorName) ||
                other.authorName == authorName) &&
            (identical(other.authorImageUrl, authorImageUrl) ||
                other.authorImageUrl == authorImageUrl) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.likes, likes) || other.likes == likes) &&
            (identical(other.parentCommentId, parentCommentId) ||
                other.parentCommentId == parentCommentId) &&
            const DeepCollectionEquality().equals(other._replies, _replies) &&
            (identical(other.isEdited, isEdited) ||
                other.isEdited == isEdited) &&
            const DeepCollectionEquality()
                .equals(other._imageUrls, _imageUrls));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      recipeId,
      authorId,
      authorName,
      authorImageUrl,
      content,
      createdAt,
      updatedAt,
      likes,
      parentCommentId,
      const DeepCollectionEquality().hash(_replies),
      isEdited,
      const DeepCollectionEquality().hash(_imageUrls));

  /// Create a copy of RecipeComment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecipeCommentImplCopyWith<_$RecipeCommentImpl> get copyWith =>
      __$$RecipeCommentImplCopyWithImpl<_$RecipeCommentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecipeCommentImplToJson(
      this,
    );
  }
}

abstract class _RecipeComment implements RecipeComment {
  const factory _RecipeComment(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String recipeId,
      @HiveField(2) required final String authorId,
      @HiveField(3) required final String authorName,
      @HiveField(4) final String? authorImageUrl,
      @HiveField(5) required final String content,
      @HiveField(6) required final DateTime createdAt,
      @HiveField(7) final DateTime? updatedAt,
      @HiveField(8) final int likes,
      @HiveField(9) final String? parentCommentId,
      @HiveField(10) final List<String> replies,
      @HiveField(11) final bool isEdited,
      @HiveField(12) final List<String> imageUrls}) = _$RecipeCommentImpl;

  factory _RecipeComment.fromJson(Map<String, dynamic> json) =
      _$RecipeCommentImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get recipeId;
  @override
  @HiveField(2)
  String get authorId;
  @override
  @HiveField(3)
  String get authorName;
  @override
  @HiveField(4)
  String? get authorImageUrl;
  @override
  @HiveField(5)
  String get content;
  @override
  @HiveField(6)
  DateTime get createdAt;
  @override
  @HiveField(7)
  DateTime? get updatedAt;
  @override
  @HiveField(8)
  int get likes;
  @override
  @HiveField(9)
  String? get parentCommentId;
  @override
  @HiveField(10)
  List<String> get replies;
  @override
  @HiveField(11)
  bool get isEdited;
  @override
  @HiveField(12)
  List<String> get imageUrls;

  /// Create a copy of RecipeComment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecipeCommentImplCopyWith<_$RecipeCommentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

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
  String? get review => throw _privateConstructorUsedError;
  @HiveField(5)
  DateTime get createdAt => throw _privateConstructorUsedError;
  @HiveField(6)
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @HiveField(7)
  List<String> get imageUrls => throw _privateConstructorUsedError;
  @HiveField(8)
  int get helpfulVotes => throw _privateConstructorUsedError;
  @HiveField(9)
  List<RatingCriteria> get criteria => throw _privateConstructorUsedError;

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
      @HiveField(4) String? review,
      @HiveField(5) DateTime createdAt,
      @HiveField(6) DateTime? updatedAt,
      @HiveField(7) List<String> imageUrls,
      @HiveField(8) int helpfulVotes,
      @HiveField(9) List<RatingCriteria> criteria});
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
    Object? review = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? imageUrls = null,
    Object? helpfulVotes = null,
    Object? criteria = null,
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
      review: freezed == review
          ? _value.review
          : review // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      imageUrls: null == imageUrls
          ? _value.imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      helpfulVotes: null == helpfulVotes
          ? _value.helpfulVotes
          : helpfulVotes // ignore: cast_nullable_to_non_nullable
              as int,
      criteria: null == criteria
          ? _value.criteria
          : criteria // ignore: cast_nullable_to_non_nullable
              as List<RatingCriteria>,
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
      @HiveField(4) String? review,
      @HiveField(5) DateTime createdAt,
      @HiveField(6) DateTime? updatedAt,
      @HiveField(7) List<String> imageUrls,
      @HiveField(8) int helpfulVotes,
      @HiveField(9) List<RatingCriteria> criteria});
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
    Object? review = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? imageUrls = null,
    Object? helpfulVotes = null,
    Object? criteria = null,
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
      review: freezed == review
          ? _value.review
          : review // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      imageUrls: null == imageUrls
          ? _value._imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      helpfulVotes: null == helpfulVotes
          ? _value.helpfulVotes
          : helpfulVotes // ignore: cast_nullable_to_non_nullable
              as int,
      criteria: null == criteria
          ? _value._criteria
          : criteria // ignore: cast_nullable_to_non_nullable
              as List<RatingCriteria>,
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
      @HiveField(4) this.review,
      @HiveField(5) required this.createdAt,
      @HiveField(6) this.updatedAt,
      @HiveField(7) final List<String> imageUrls = const [],
      @HiveField(8) this.helpfulVotes = 0,
      @HiveField(9) final List<RatingCriteria> criteria = const []})
      : _imageUrls = imageUrls,
        _criteria = criteria;

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
  final String? review;
  @override
  @HiveField(5)
  final DateTime createdAt;
  @override
  @HiveField(6)
  final DateTime? updatedAt;
  final List<String> _imageUrls;
  @override
  @JsonKey()
  @HiveField(7)
  List<String> get imageUrls {
    if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imageUrls);
  }

  @override
  @JsonKey()
  @HiveField(8)
  final int helpfulVotes;
  final List<RatingCriteria> _criteria;
  @override
  @JsonKey()
  @HiveField(9)
  List<RatingCriteria> get criteria {
    if (_criteria is EqualUnmodifiableListView) return _criteria;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_criteria);
  }

  @override
  String toString() {
    return 'RecipeRating(id: $id, recipeId: $recipeId, userId: $userId, rating: $rating, review: $review, createdAt: $createdAt, updatedAt: $updatedAt, imageUrls: $imageUrls, helpfulVotes: $helpfulVotes, criteria: $criteria)';
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
            (identical(other.review, review) || other.review == review) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality()
                .equals(other._imageUrls, _imageUrls) &&
            (identical(other.helpfulVotes, helpfulVotes) ||
                other.helpfulVotes == helpfulVotes) &&
            const DeepCollectionEquality().equals(other._criteria, _criteria));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      recipeId,
      userId,
      rating,
      review,
      createdAt,
      updatedAt,
      const DeepCollectionEquality().hash(_imageUrls),
      helpfulVotes,
      const DeepCollectionEquality().hash(_criteria));

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
      @HiveField(4) final String? review,
      @HiveField(5) required final DateTime createdAt,
      @HiveField(6) final DateTime? updatedAt,
      @HiveField(7) final List<String> imageUrls,
      @HiveField(8) final int helpfulVotes,
      @HiveField(9) final List<RatingCriteria> criteria}) = _$RecipeRatingImpl;

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
  String? get review;
  @override
  @HiveField(5)
  DateTime get createdAt;
  @override
  @HiveField(6)
  DateTime? get updatedAt;
  @override
  @HiveField(7)
  List<String> get imageUrls;
  @override
  @HiveField(8)
  int get helpfulVotes;
  @override
  @HiveField(9)
  List<RatingCriteria> get criteria;

  /// Create a copy of RecipeRating
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecipeRatingImplCopyWith<_$RecipeRatingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RatingCriteria _$RatingCriteriaFromJson(Map<String, dynamic> json) {
  return _RatingCriteria.fromJson(json);
}

/// @nodoc
mixin _$RatingCriteria {
  @HiveField(0)
  String get name => throw _privateConstructorUsedError;
  @HiveField(1)
  double get score => throw _privateConstructorUsedError;
  @HiveField(2)
  String? get comment => throw _privateConstructorUsedError;

  /// Serializes this RatingCriteria to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RatingCriteria
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RatingCriteriaCopyWith<RatingCriteria> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RatingCriteriaCopyWith<$Res> {
  factory $RatingCriteriaCopyWith(
          RatingCriteria value, $Res Function(RatingCriteria) then) =
      _$RatingCriteriaCopyWithImpl<$Res, RatingCriteria>;
  @useResult
  $Res call(
      {@HiveField(0) String name,
      @HiveField(1) double score,
      @HiveField(2) String? comment});
}

/// @nodoc
class _$RatingCriteriaCopyWithImpl<$Res, $Val extends RatingCriteria>
    implements $RatingCriteriaCopyWith<$Res> {
  _$RatingCriteriaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RatingCriteria
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? score = null,
    Object? comment = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as double,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RatingCriteriaImplCopyWith<$Res>
    implements $RatingCriteriaCopyWith<$Res> {
  factory _$$RatingCriteriaImplCopyWith(_$RatingCriteriaImpl value,
          $Res Function(_$RatingCriteriaImpl) then) =
      __$$RatingCriteriaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String name,
      @HiveField(1) double score,
      @HiveField(2) String? comment});
}

/// @nodoc
class __$$RatingCriteriaImplCopyWithImpl<$Res>
    extends _$RatingCriteriaCopyWithImpl<$Res, _$RatingCriteriaImpl>
    implements _$$RatingCriteriaImplCopyWith<$Res> {
  __$$RatingCriteriaImplCopyWithImpl(
      _$RatingCriteriaImpl _value, $Res Function(_$RatingCriteriaImpl) _then)
      : super(_value, _then);

  /// Create a copy of RatingCriteria
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? score = null,
    Object? comment = freezed,
  }) {
    return _then(_$RatingCriteriaImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as double,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RatingCriteriaImpl implements _RatingCriteria {
  const _$RatingCriteriaImpl(
      {@HiveField(0) required this.name,
      @HiveField(1) required this.score,
      @HiveField(2) this.comment});

  factory _$RatingCriteriaImpl.fromJson(Map<String, dynamic> json) =>
      _$$RatingCriteriaImplFromJson(json);

  @override
  @HiveField(0)
  final String name;
  @override
  @HiveField(1)
  final double score;
  @override
  @HiveField(2)
  final String? comment;

  @override
  String toString() {
    return 'RatingCriteria(name: $name, score: $score, comment: $comment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RatingCriteriaImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.comment, comment) || other.comment == comment));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, score, comment);

  /// Create a copy of RatingCriteria
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RatingCriteriaImplCopyWith<_$RatingCriteriaImpl> get copyWith =>
      __$$RatingCriteriaImplCopyWithImpl<_$RatingCriteriaImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RatingCriteriaImplToJson(
      this,
    );
  }
}

abstract class _RatingCriteria implements RatingCriteria {
  const factory _RatingCriteria(
      {@HiveField(0) required final String name,
      @HiveField(1) required final double score,
      @HiveField(2) final String? comment}) = _$RatingCriteriaImpl;

  factory _RatingCriteria.fromJson(Map<String, dynamic> json) =
      _$RatingCriteriaImpl.fromJson;

  @override
  @HiveField(0)
  String get name;
  @override
  @HiveField(1)
  double get score;
  @override
  @HiveField(2)
  String? get comment;

  /// Create a copy of RatingCriteria
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RatingCriteriaImplCopyWith<_$RatingCriteriaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CookingGroup _$CookingGroupFromJson(Map<String, dynamic> json) {
  return _CookingGroup.fromJson(json);
}

/// @nodoc
mixin _$CookingGroup {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get name => throw _privateConstructorUsedError;
  @HiveField(2)
  String get description => throw _privateConstructorUsedError;
  @HiveField(3)
  String? get imageUrl => throw _privateConstructorUsedError;
  @HiveField(4)
  String get creatorId => throw _privateConstructorUsedError;
  @HiveField(5)
  DateTime get createdAt => throw _privateConstructorUsedError;
  @HiveField(6)
  List<String> get memberIds => throw _privateConstructorUsedError;
  @HiveField(7)
  List<String> get adminIds => throw _privateConstructorUsedError;
  @HiveField(8)
  List<String> get recipeIds => throw _privateConstructorUsedError;
  @HiveField(9)
  List<String> get challengeIds => throw _privateConstructorUsedError;
  @HiveField(10)
  GroupVisibility get visibility => throw _privateConstructorUsedError;
  @HiveField(11)
  bool get requiresApproval => throw _privateConstructorUsedError;
  @HiveField(12)
  List<String> get tags => throw _privateConstructorUsedError;
  @HiveField(13)
  Map<String, dynamic> get settings => throw _privateConstructorUsedError;

  /// Serializes this CookingGroup to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CookingGroup
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CookingGroupCopyWith<CookingGroup> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CookingGroupCopyWith<$Res> {
  factory $CookingGroupCopyWith(
          CookingGroup value, $Res Function(CookingGroup) then) =
      _$CookingGroupCopyWithImpl<$Res, CookingGroup>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String name,
      @HiveField(2) String description,
      @HiveField(3) String? imageUrl,
      @HiveField(4) String creatorId,
      @HiveField(5) DateTime createdAt,
      @HiveField(6) List<String> memberIds,
      @HiveField(7) List<String> adminIds,
      @HiveField(8) List<String> recipeIds,
      @HiveField(9) List<String> challengeIds,
      @HiveField(10) GroupVisibility visibility,
      @HiveField(11) bool requiresApproval,
      @HiveField(12) List<String> tags,
      @HiveField(13) Map<String, dynamic> settings});
}

/// @nodoc
class _$CookingGroupCopyWithImpl<$Res, $Val extends CookingGroup>
    implements $CookingGroupCopyWith<$Res> {
  _$CookingGroupCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CookingGroup
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? imageUrl = freezed,
    Object? creatorId = null,
    Object? createdAt = null,
    Object? memberIds = null,
    Object? adminIds = null,
    Object? recipeIds = null,
    Object? challengeIds = null,
    Object? visibility = null,
    Object? requiresApproval = null,
    Object? tags = null,
    Object? settings = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      creatorId: null == creatorId
          ? _value.creatorId
          : creatorId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      memberIds: null == memberIds
          ? _value.memberIds
          : memberIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      adminIds: null == adminIds
          ? _value.adminIds
          : adminIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      recipeIds: null == recipeIds
          ? _value.recipeIds
          : recipeIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      challengeIds: null == challengeIds
          ? _value.challengeIds
          : challengeIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      visibility: null == visibility
          ? _value.visibility
          : visibility // ignore: cast_nullable_to_non_nullable
              as GroupVisibility,
      requiresApproval: null == requiresApproval
          ? _value.requiresApproval
          : requiresApproval // ignore: cast_nullable_to_non_nullable
              as bool,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      settings: null == settings
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CookingGroupImplCopyWith<$Res>
    implements $CookingGroupCopyWith<$Res> {
  factory _$$CookingGroupImplCopyWith(
          _$CookingGroupImpl value, $Res Function(_$CookingGroupImpl) then) =
      __$$CookingGroupImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String name,
      @HiveField(2) String description,
      @HiveField(3) String? imageUrl,
      @HiveField(4) String creatorId,
      @HiveField(5) DateTime createdAt,
      @HiveField(6) List<String> memberIds,
      @HiveField(7) List<String> adminIds,
      @HiveField(8) List<String> recipeIds,
      @HiveField(9) List<String> challengeIds,
      @HiveField(10) GroupVisibility visibility,
      @HiveField(11) bool requiresApproval,
      @HiveField(12) List<String> tags,
      @HiveField(13) Map<String, dynamic> settings});
}

/// @nodoc
class __$$CookingGroupImplCopyWithImpl<$Res>
    extends _$CookingGroupCopyWithImpl<$Res, _$CookingGroupImpl>
    implements _$$CookingGroupImplCopyWith<$Res> {
  __$$CookingGroupImplCopyWithImpl(
      _$CookingGroupImpl _value, $Res Function(_$CookingGroupImpl) _then)
      : super(_value, _then);

  /// Create a copy of CookingGroup
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? imageUrl = freezed,
    Object? creatorId = null,
    Object? createdAt = null,
    Object? memberIds = null,
    Object? adminIds = null,
    Object? recipeIds = null,
    Object? challengeIds = null,
    Object? visibility = null,
    Object? requiresApproval = null,
    Object? tags = null,
    Object? settings = null,
  }) {
    return _then(_$CookingGroupImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      creatorId: null == creatorId
          ? _value.creatorId
          : creatorId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      memberIds: null == memberIds
          ? _value._memberIds
          : memberIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      adminIds: null == adminIds
          ? _value._adminIds
          : adminIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      recipeIds: null == recipeIds
          ? _value._recipeIds
          : recipeIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      challengeIds: null == challengeIds
          ? _value._challengeIds
          : challengeIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      visibility: null == visibility
          ? _value.visibility
          : visibility // ignore: cast_nullable_to_non_nullable
              as GroupVisibility,
      requiresApproval: null == requiresApproval
          ? _value.requiresApproval
          : requiresApproval // ignore: cast_nullable_to_non_nullable
              as bool,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      settings: null == settings
          ? _value._settings
          : settings // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CookingGroupImpl implements _CookingGroup {
  const _$CookingGroupImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.name,
      @HiveField(2) required this.description,
      @HiveField(3) this.imageUrl,
      @HiveField(4) required this.creatorId,
      @HiveField(5) required this.createdAt,
      @HiveField(6) final List<String> memberIds = const [],
      @HiveField(7) final List<String> adminIds = const [],
      @HiveField(8) final List<String> recipeIds = const [],
      @HiveField(9) final List<String> challengeIds = const [],
      @HiveField(10) this.visibility = GroupVisibility.public,
      @HiveField(11) this.requiresApproval = false,
      @HiveField(12) final List<String> tags = const [],
      @HiveField(13) final Map<String, dynamic> settings = const {}})
      : _memberIds = memberIds,
        _adminIds = adminIds,
        _recipeIds = recipeIds,
        _challengeIds = challengeIds,
        _tags = tags,
        _settings = settings;

  factory _$CookingGroupImpl.fromJson(Map<String, dynamic> json) =>
      _$$CookingGroupImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String name;
  @override
  @HiveField(2)
  final String description;
  @override
  @HiveField(3)
  final String? imageUrl;
  @override
  @HiveField(4)
  final String creatorId;
  @override
  @HiveField(5)
  final DateTime createdAt;
  final List<String> _memberIds;
  @override
  @JsonKey()
  @HiveField(6)
  List<String> get memberIds {
    if (_memberIds is EqualUnmodifiableListView) return _memberIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_memberIds);
  }

  final List<String> _adminIds;
  @override
  @JsonKey()
  @HiveField(7)
  List<String> get adminIds {
    if (_adminIds is EqualUnmodifiableListView) return _adminIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_adminIds);
  }

  final List<String> _recipeIds;
  @override
  @JsonKey()
  @HiveField(8)
  List<String> get recipeIds {
    if (_recipeIds is EqualUnmodifiableListView) return _recipeIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recipeIds);
  }

  final List<String> _challengeIds;
  @override
  @JsonKey()
  @HiveField(9)
  List<String> get challengeIds {
    if (_challengeIds is EqualUnmodifiableListView) return _challengeIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_challengeIds);
  }

  @override
  @JsonKey()
  @HiveField(10)
  final GroupVisibility visibility;
  @override
  @JsonKey()
  @HiveField(11)
  final bool requiresApproval;
  final List<String> _tags;
  @override
  @JsonKey()
  @HiveField(12)
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  final Map<String, dynamic> _settings;
  @override
  @JsonKey()
  @HiveField(13)
  Map<String, dynamic> get settings {
    if (_settings is EqualUnmodifiableMapView) return _settings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_settings);
  }

  @override
  String toString() {
    return 'CookingGroup(id: $id, name: $name, description: $description, imageUrl: $imageUrl, creatorId: $creatorId, createdAt: $createdAt, memberIds: $memberIds, adminIds: $adminIds, recipeIds: $recipeIds, challengeIds: $challengeIds, visibility: $visibility, requiresApproval: $requiresApproval, tags: $tags, settings: $settings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CookingGroupImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.creatorId, creatorId) ||
                other.creatorId == creatorId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality()
                .equals(other._memberIds, _memberIds) &&
            const DeepCollectionEquality().equals(other._adminIds, _adminIds) &&
            const DeepCollectionEquality()
                .equals(other._recipeIds, _recipeIds) &&
            const DeepCollectionEquality()
                .equals(other._challengeIds, _challengeIds) &&
            (identical(other.visibility, visibility) ||
                other.visibility == visibility) &&
            (identical(other.requiresApproval, requiresApproval) ||
                other.requiresApproval == requiresApproval) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            const DeepCollectionEquality().equals(other._settings, _settings));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      imageUrl,
      creatorId,
      createdAt,
      const DeepCollectionEquality().hash(_memberIds),
      const DeepCollectionEquality().hash(_adminIds),
      const DeepCollectionEquality().hash(_recipeIds),
      const DeepCollectionEquality().hash(_challengeIds),
      visibility,
      requiresApproval,
      const DeepCollectionEquality().hash(_tags),
      const DeepCollectionEquality().hash(_settings));

  /// Create a copy of CookingGroup
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CookingGroupImplCopyWith<_$CookingGroupImpl> get copyWith =>
      __$$CookingGroupImplCopyWithImpl<_$CookingGroupImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CookingGroupImplToJson(
      this,
    );
  }
}

abstract class _CookingGroup implements CookingGroup {
  const factory _CookingGroup(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String name,
      @HiveField(2) required final String description,
      @HiveField(3) final String? imageUrl,
      @HiveField(4) required final String creatorId,
      @HiveField(5) required final DateTime createdAt,
      @HiveField(6) final List<String> memberIds,
      @HiveField(7) final List<String> adminIds,
      @HiveField(8) final List<String> recipeIds,
      @HiveField(9) final List<String> challengeIds,
      @HiveField(10) final GroupVisibility visibility,
      @HiveField(11) final bool requiresApproval,
      @HiveField(12) final List<String> tags,
      @HiveField(13) final Map<String, dynamic> settings}) = _$CookingGroupImpl;

  factory _CookingGroup.fromJson(Map<String, dynamic> json) =
      _$CookingGroupImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get name;
  @override
  @HiveField(2)
  String get description;
  @override
  @HiveField(3)
  String? get imageUrl;
  @override
  @HiveField(4)
  String get creatorId;
  @override
  @HiveField(5)
  DateTime get createdAt;
  @override
  @HiveField(6)
  List<String> get memberIds;
  @override
  @HiveField(7)
  List<String> get adminIds;
  @override
  @HiveField(8)
  List<String> get recipeIds;
  @override
  @HiveField(9)
  List<String> get challengeIds;
  @override
  @HiveField(10)
  GroupVisibility get visibility;
  @override
  @HiveField(11)
  bool get requiresApproval;
  @override
  @HiveField(12)
  List<String> get tags;
  @override
  @HiveField(13)
  Map<String, dynamic> get settings;

  /// Create a copy of CookingGroup
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CookingGroupImplCopyWith<_$CookingGroupImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Challenge _$ChallengeFromJson(Map<String, dynamic> json) {
  return _Challenge.fromJson(json);
}

/// @nodoc
mixin _$Challenge {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get title => throw _privateConstructorUsedError;
  @HiveField(2)
  String get description => throw _privateConstructorUsedError;
  @HiveField(3)
  String? get imageUrl => throw _privateConstructorUsedError;
  @HiveField(4)
  String get creatorId => throw _privateConstructorUsedError;
  @HiveField(5)
  DateTime get startDate => throw _privateConstructorUsedError;
  @HiveField(6)
  DateTime get endDate => throw _privateConstructorUsedError;
  @HiveField(7)
  ChallengeType get type => throw _privateConstructorUsedError;
  @HiveField(8)
  Map<String, dynamic> get rules => throw _privateConstructorUsedError;
  @HiveField(9)
  List<String> get participantIds => throw _privateConstructorUsedError;
  @HiveField(10)
  List<ChallengeSubmission> get submissions =>
      throw _privateConstructorUsedError;
  @HiveField(11)
  List<ChallengePrize> get prizes => throw _privateConstructorUsedError;
  @HiveField(12)
  ChallengeStatus get status => throw _privateConstructorUsedError;
  @HiveField(13)
  List<String> get tags => throw _privateConstructorUsedError;
  @HiveField(14)
  String? get groupId => throw _privateConstructorUsedError;

  /// Serializes this Challenge to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Challenge
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChallengeCopyWith<Challenge> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChallengeCopyWith<$Res> {
  factory $ChallengeCopyWith(Challenge value, $Res Function(Challenge) then) =
      _$ChallengeCopyWithImpl<$Res, Challenge>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String title,
      @HiveField(2) String description,
      @HiveField(3) String? imageUrl,
      @HiveField(4) String creatorId,
      @HiveField(5) DateTime startDate,
      @HiveField(6) DateTime endDate,
      @HiveField(7) ChallengeType type,
      @HiveField(8) Map<String, dynamic> rules,
      @HiveField(9) List<String> participantIds,
      @HiveField(10) List<ChallengeSubmission> submissions,
      @HiveField(11) List<ChallengePrize> prizes,
      @HiveField(12) ChallengeStatus status,
      @HiveField(13) List<String> tags,
      @HiveField(14) String? groupId});
}

/// @nodoc
class _$ChallengeCopyWithImpl<$Res, $Val extends Challenge>
    implements $ChallengeCopyWith<$Res> {
  _$ChallengeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Challenge
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? imageUrl = freezed,
    Object? creatorId = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? type = null,
    Object? rules = null,
    Object? participantIds = null,
    Object? submissions = null,
    Object? prizes = null,
    Object? status = null,
    Object? tags = null,
    Object? groupId = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      creatorId: null == creatorId
          ? _value.creatorId
          : creatorId // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ChallengeType,
      rules: null == rules
          ? _value.rules
          : rules // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      participantIds: null == participantIds
          ? _value.participantIds
          : participantIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      submissions: null == submissions
          ? _value.submissions
          : submissions // ignore: cast_nullable_to_non_nullable
              as List<ChallengeSubmission>,
      prizes: null == prizes
          ? _value.prizes
          : prizes // ignore: cast_nullable_to_non_nullable
              as List<ChallengePrize>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ChallengeStatus,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      groupId: freezed == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChallengeImplCopyWith<$Res>
    implements $ChallengeCopyWith<$Res> {
  factory _$$ChallengeImplCopyWith(
          _$ChallengeImpl value, $Res Function(_$ChallengeImpl) then) =
      __$$ChallengeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String title,
      @HiveField(2) String description,
      @HiveField(3) String? imageUrl,
      @HiveField(4) String creatorId,
      @HiveField(5) DateTime startDate,
      @HiveField(6) DateTime endDate,
      @HiveField(7) ChallengeType type,
      @HiveField(8) Map<String, dynamic> rules,
      @HiveField(9) List<String> participantIds,
      @HiveField(10) List<ChallengeSubmission> submissions,
      @HiveField(11) List<ChallengePrize> prizes,
      @HiveField(12) ChallengeStatus status,
      @HiveField(13) List<String> tags,
      @HiveField(14) String? groupId});
}

/// @nodoc
class __$$ChallengeImplCopyWithImpl<$Res>
    extends _$ChallengeCopyWithImpl<$Res, _$ChallengeImpl>
    implements _$$ChallengeImplCopyWith<$Res> {
  __$$ChallengeImplCopyWithImpl(
      _$ChallengeImpl _value, $Res Function(_$ChallengeImpl) _then)
      : super(_value, _then);

  /// Create a copy of Challenge
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? imageUrl = freezed,
    Object? creatorId = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? type = null,
    Object? rules = null,
    Object? participantIds = null,
    Object? submissions = null,
    Object? prizes = null,
    Object? status = null,
    Object? tags = null,
    Object? groupId = freezed,
  }) {
    return _then(_$ChallengeImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      creatorId: null == creatorId
          ? _value.creatorId
          : creatorId // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ChallengeType,
      rules: null == rules
          ? _value._rules
          : rules // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      participantIds: null == participantIds
          ? _value._participantIds
          : participantIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      submissions: null == submissions
          ? _value._submissions
          : submissions // ignore: cast_nullable_to_non_nullable
              as List<ChallengeSubmission>,
      prizes: null == prizes
          ? _value._prizes
          : prizes // ignore: cast_nullable_to_non_nullable
              as List<ChallengePrize>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ChallengeStatus,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      groupId: freezed == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChallengeImpl implements _Challenge {
  const _$ChallengeImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.title,
      @HiveField(2) required this.description,
      @HiveField(3) this.imageUrl,
      @HiveField(4) required this.creatorId,
      @HiveField(5) required this.startDate,
      @HiveField(6) required this.endDate,
      @HiveField(7) required this.type,
      @HiveField(8) required final Map<String, dynamic> rules,
      @HiveField(9) final List<String> participantIds = const [],
      @HiveField(10) final List<ChallengeSubmission> submissions = const [],
      @HiveField(11) final List<ChallengePrize> prizes = const [],
      @HiveField(12) this.status = ChallengeStatus.upcoming,
      @HiveField(13) final List<String> tags = const [],
      @HiveField(14) this.groupId})
      : _rules = rules,
        _participantIds = participantIds,
        _submissions = submissions,
        _prizes = prizes,
        _tags = tags;

  factory _$ChallengeImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChallengeImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String title;
  @override
  @HiveField(2)
  final String description;
  @override
  @HiveField(3)
  final String? imageUrl;
  @override
  @HiveField(4)
  final String creatorId;
  @override
  @HiveField(5)
  final DateTime startDate;
  @override
  @HiveField(6)
  final DateTime endDate;
  @override
  @HiveField(7)
  final ChallengeType type;
  final Map<String, dynamic> _rules;
  @override
  @HiveField(8)
  Map<String, dynamic> get rules {
    if (_rules is EqualUnmodifiableMapView) return _rules;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_rules);
  }

  final List<String> _participantIds;
  @override
  @JsonKey()
  @HiveField(9)
  List<String> get participantIds {
    if (_participantIds is EqualUnmodifiableListView) return _participantIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_participantIds);
  }

  final List<ChallengeSubmission> _submissions;
  @override
  @JsonKey()
  @HiveField(10)
  List<ChallengeSubmission> get submissions {
    if (_submissions is EqualUnmodifiableListView) return _submissions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_submissions);
  }

  final List<ChallengePrize> _prizes;
  @override
  @JsonKey()
  @HiveField(11)
  List<ChallengePrize> get prizes {
    if (_prizes is EqualUnmodifiableListView) return _prizes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_prizes);
  }

  @override
  @JsonKey()
  @HiveField(12)
  final ChallengeStatus status;
  final List<String> _tags;
  @override
  @JsonKey()
  @HiveField(13)
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  @HiveField(14)
  final String? groupId;

  @override
  String toString() {
    return 'Challenge(id: $id, title: $title, description: $description, imageUrl: $imageUrl, creatorId: $creatorId, startDate: $startDate, endDate: $endDate, type: $type, rules: $rules, participantIds: $participantIds, submissions: $submissions, prizes: $prizes, status: $status, tags: $tags, groupId: $groupId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChallengeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.creatorId, creatorId) ||
                other.creatorId == creatorId) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._rules, _rules) &&
            const DeepCollectionEquality()
                .equals(other._participantIds, _participantIds) &&
            const DeepCollectionEquality()
                .equals(other._submissions, _submissions) &&
            const DeepCollectionEquality().equals(other._prizes, _prizes) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.groupId, groupId) || other.groupId == groupId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      imageUrl,
      creatorId,
      startDate,
      endDate,
      type,
      const DeepCollectionEquality().hash(_rules),
      const DeepCollectionEquality().hash(_participantIds),
      const DeepCollectionEquality().hash(_submissions),
      const DeepCollectionEquality().hash(_prizes),
      status,
      const DeepCollectionEquality().hash(_tags),
      groupId);

  /// Create a copy of Challenge
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChallengeImplCopyWith<_$ChallengeImpl> get copyWith =>
      __$$ChallengeImplCopyWithImpl<_$ChallengeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChallengeImplToJson(
      this,
    );
  }
}

abstract class _Challenge implements Challenge {
  const factory _Challenge(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String title,
      @HiveField(2) required final String description,
      @HiveField(3) final String? imageUrl,
      @HiveField(4) required final String creatorId,
      @HiveField(5) required final DateTime startDate,
      @HiveField(6) required final DateTime endDate,
      @HiveField(7) required final ChallengeType type,
      @HiveField(8) required final Map<String, dynamic> rules,
      @HiveField(9) final List<String> participantIds,
      @HiveField(10) final List<ChallengeSubmission> submissions,
      @HiveField(11) final List<ChallengePrize> prizes,
      @HiveField(12) final ChallengeStatus status,
      @HiveField(13) final List<String> tags,
      @HiveField(14) final String? groupId}) = _$ChallengeImpl;

  factory _Challenge.fromJson(Map<String, dynamic> json) =
      _$ChallengeImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get title;
  @override
  @HiveField(2)
  String get description;
  @override
  @HiveField(3)
  String? get imageUrl;
  @override
  @HiveField(4)
  String get creatorId;
  @override
  @HiveField(5)
  DateTime get startDate;
  @override
  @HiveField(6)
  DateTime get endDate;
  @override
  @HiveField(7)
  ChallengeType get type;
  @override
  @HiveField(8)
  Map<String, dynamic> get rules;
  @override
  @HiveField(9)
  List<String> get participantIds;
  @override
  @HiveField(10)
  List<ChallengeSubmission> get submissions;
  @override
  @HiveField(11)
  List<ChallengePrize> get prizes;
  @override
  @HiveField(12)
  ChallengeStatus get status;
  @override
  @HiveField(13)
  List<String> get tags;
  @override
  @HiveField(14)
  String? get groupId;

  /// Create a copy of Challenge
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChallengeImplCopyWith<_$ChallengeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChallengeSubmission _$ChallengeSubmissionFromJson(Map<String, dynamic> json) {
  return _ChallengeSubmission.fromJson(json);
}

/// @nodoc
mixin _$ChallengeSubmission {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get challengeId => throw _privateConstructorUsedError;
  @HiveField(2)
  String get userId => throw _privateConstructorUsedError;
  @HiveField(3)
  String get userName => throw _privateConstructorUsedError;
  @HiveField(4)
  String? get userImageUrl => throw _privateConstructorUsedError;
  @HiveField(5)
  String get recipeId => throw _privateConstructorUsedError;
  @HiveField(6)
  DateTime get submittedAt => throw _privateConstructorUsedError;
  @HiveField(7)
  List<String> get imageUrls => throw _privateConstructorUsedError;
  @HiveField(8)
  String? get description => throw _privateConstructorUsedError;
  @HiveField(9)
  int get votes => throw _privateConstructorUsedError;
  @HiveField(10)
  double get score => throw _privateConstructorUsedError;
  @HiveField(11)
  SubmissionStatus get status => throw _privateConstructorUsedError;

  /// Serializes this ChallengeSubmission to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChallengeSubmission
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChallengeSubmissionCopyWith<ChallengeSubmission> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChallengeSubmissionCopyWith<$Res> {
  factory $ChallengeSubmissionCopyWith(
          ChallengeSubmission value, $Res Function(ChallengeSubmission) then) =
      _$ChallengeSubmissionCopyWithImpl<$Res, ChallengeSubmission>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String challengeId,
      @HiveField(2) String userId,
      @HiveField(3) String userName,
      @HiveField(4) String? userImageUrl,
      @HiveField(5) String recipeId,
      @HiveField(6) DateTime submittedAt,
      @HiveField(7) List<String> imageUrls,
      @HiveField(8) String? description,
      @HiveField(9) int votes,
      @HiveField(10) double score,
      @HiveField(11) SubmissionStatus status});
}

/// @nodoc
class _$ChallengeSubmissionCopyWithImpl<$Res, $Val extends ChallengeSubmission>
    implements $ChallengeSubmissionCopyWith<$Res> {
  _$ChallengeSubmissionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChallengeSubmission
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? challengeId = null,
    Object? userId = null,
    Object? userName = null,
    Object? userImageUrl = freezed,
    Object? recipeId = null,
    Object? submittedAt = null,
    Object? imageUrls = null,
    Object? description = freezed,
    Object? votes = null,
    Object? score = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      challengeId: null == challengeId
          ? _value.challengeId
          : challengeId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      userImageUrl: freezed == userImageUrl
          ? _value.userImageUrl
          : userImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      recipeId: null == recipeId
          ? _value.recipeId
          : recipeId // ignore: cast_nullable_to_non_nullable
              as String,
      submittedAt: null == submittedAt
          ? _value.submittedAt
          : submittedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      imageUrls: null == imageUrls
          ? _value.imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      votes: null == votes
          ? _value.votes
          : votes // ignore: cast_nullable_to_non_nullable
              as int,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SubmissionStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChallengeSubmissionImplCopyWith<$Res>
    implements $ChallengeSubmissionCopyWith<$Res> {
  factory _$$ChallengeSubmissionImplCopyWith(_$ChallengeSubmissionImpl value,
          $Res Function(_$ChallengeSubmissionImpl) then) =
      __$$ChallengeSubmissionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String challengeId,
      @HiveField(2) String userId,
      @HiveField(3) String userName,
      @HiveField(4) String? userImageUrl,
      @HiveField(5) String recipeId,
      @HiveField(6) DateTime submittedAt,
      @HiveField(7) List<String> imageUrls,
      @HiveField(8) String? description,
      @HiveField(9) int votes,
      @HiveField(10) double score,
      @HiveField(11) SubmissionStatus status});
}

/// @nodoc
class __$$ChallengeSubmissionImplCopyWithImpl<$Res>
    extends _$ChallengeSubmissionCopyWithImpl<$Res, _$ChallengeSubmissionImpl>
    implements _$$ChallengeSubmissionImplCopyWith<$Res> {
  __$$ChallengeSubmissionImplCopyWithImpl(_$ChallengeSubmissionImpl _value,
      $Res Function(_$ChallengeSubmissionImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChallengeSubmission
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? challengeId = null,
    Object? userId = null,
    Object? userName = null,
    Object? userImageUrl = freezed,
    Object? recipeId = null,
    Object? submittedAt = null,
    Object? imageUrls = null,
    Object? description = freezed,
    Object? votes = null,
    Object? score = null,
    Object? status = null,
  }) {
    return _then(_$ChallengeSubmissionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      challengeId: null == challengeId
          ? _value.challengeId
          : challengeId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      userImageUrl: freezed == userImageUrl
          ? _value.userImageUrl
          : userImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      recipeId: null == recipeId
          ? _value.recipeId
          : recipeId // ignore: cast_nullable_to_non_nullable
              as String,
      submittedAt: null == submittedAt
          ? _value.submittedAt
          : submittedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      imageUrls: null == imageUrls
          ? _value._imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      votes: null == votes
          ? _value.votes
          : votes // ignore: cast_nullable_to_non_nullable
              as int,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SubmissionStatus,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChallengeSubmissionImpl implements _ChallengeSubmission {
  const _$ChallengeSubmissionImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.challengeId,
      @HiveField(2) required this.userId,
      @HiveField(3) required this.userName,
      @HiveField(4) this.userImageUrl,
      @HiveField(5) required this.recipeId,
      @HiveField(6) required this.submittedAt,
      @HiveField(7) final List<String> imageUrls = const [],
      @HiveField(8) this.description,
      @HiveField(9) this.votes = 0,
      @HiveField(10) this.score = 0.0,
      @HiveField(11) this.status = SubmissionStatus.pending})
      : _imageUrls = imageUrls;

  factory _$ChallengeSubmissionImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChallengeSubmissionImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String challengeId;
  @override
  @HiveField(2)
  final String userId;
  @override
  @HiveField(3)
  final String userName;
  @override
  @HiveField(4)
  final String? userImageUrl;
  @override
  @HiveField(5)
  final String recipeId;
  @override
  @HiveField(6)
  final DateTime submittedAt;
  final List<String> _imageUrls;
  @override
  @JsonKey()
  @HiveField(7)
  List<String> get imageUrls {
    if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imageUrls);
  }

  @override
  @HiveField(8)
  final String? description;
  @override
  @JsonKey()
  @HiveField(9)
  final int votes;
  @override
  @JsonKey()
  @HiveField(10)
  final double score;
  @override
  @JsonKey()
  @HiveField(11)
  final SubmissionStatus status;

  @override
  String toString() {
    return 'ChallengeSubmission(id: $id, challengeId: $challengeId, userId: $userId, userName: $userName, userImageUrl: $userImageUrl, recipeId: $recipeId, submittedAt: $submittedAt, imageUrls: $imageUrls, description: $description, votes: $votes, score: $score, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChallengeSubmissionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.challengeId, challengeId) ||
                other.challengeId == challengeId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.userImageUrl, userImageUrl) ||
                other.userImageUrl == userImageUrl) &&
            (identical(other.recipeId, recipeId) ||
                other.recipeId == recipeId) &&
            (identical(other.submittedAt, submittedAt) ||
                other.submittedAt == submittedAt) &&
            const DeepCollectionEquality()
                .equals(other._imageUrls, _imageUrls) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.votes, votes) || other.votes == votes) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      challengeId,
      userId,
      userName,
      userImageUrl,
      recipeId,
      submittedAt,
      const DeepCollectionEquality().hash(_imageUrls),
      description,
      votes,
      score,
      status);

  /// Create a copy of ChallengeSubmission
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChallengeSubmissionImplCopyWith<_$ChallengeSubmissionImpl> get copyWith =>
      __$$ChallengeSubmissionImplCopyWithImpl<_$ChallengeSubmissionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChallengeSubmissionImplToJson(
      this,
    );
  }
}

abstract class _ChallengeSubmission implements ChallengeSubmission {
  const factory _ChallengeSubmission(
          {@HiveField(0) required final String id,
          @HiveField(1) required final String challengeId,
          @HiveField(2) required final String userId,
          @HiveField(3) required final String userName,
          @HiveField(4) final String? userImageUrl,
          @HiveField(5) required final String recipeId,
          @HiveField(6) required final DateTime submittedAt,
          @HiveField(7) final List<String> imageUrls,
          @HiveField(8) final String? description,
          @HiveField(9) final int votes,
          @HiveField(10) final double score,
          @HiveField(11) final SubmissionStatus status}) =
      _$ChallengeSubmissionImpl;

  factory _ChallengeSubmission.fromJson(Map<String, dynamic> json) =
      _$ChallengeSubmissionImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get challengeId;
  @override
  @HiveField(2)
  String get userId;
  @override
  @HiveField(3)
  String get userName;
  @override
  @HiveField(4)
  String? get userImageUrl;
  @override
  @HiveField(5)
  String get recipeId;
  @override
  @HiveField(6)
  DateTime get submittedAt;
  @override
  @HiveField(7)
  List<String> get imageUrls;
  @override
  @HiveField(8)
  String? get description;
  @override
  @HiveField(9)
  int get votes;
  @override
  @HiveField(10)
  double get score;
  @override
  @HiveField(11)
  SubmissionStatus get status;

  /// Create a copy of ChallengeSubmission
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChallengeSubmissionImplCopyWith<_$ChallengeSubmissionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChallengePrize _$ChallengePrizeFromJson(Map<String, dynamic> json) {
  return _ChallengePrize.fromJson(json);
}

/// @nodoc
mixin _$ChallengePrize {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get title => throw _privateConstructorUsedError;
  @HiveField(2)
  String get description => throw _privateConstructorUsedError;
  @HiveField(3)
  String? get imageUrl => throw _privateConstructorUsedError;
  @HiveField(4)
  PrizeType get type => throw _privateConstructorUsedError;
  @HiveField(5)
  String? get value => throw _privateConstructorUsedError;
  @HiveField(6)
  int get position => throw _privateConstructorUsedError; // 1st, 2nd, 3rd place
  @HiveField(7)
  String? get winnerId => throw _privateConstructorUsedError;

  /// Serializes this ChallengePrize to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChallengePrize
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChallengePrizeCopyWith<ChallengePrize> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChallengePrizeCopyWith<$Res> {
  factory $ChallengePrizeCopyWith(
          ChallengePrize value, $Res Function(ChallengePrize) then) =
      _$ChallengePrizeCopyWithImpl<$Res, ChallengePrize>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String title,
      @HiveField(2) String description,
      @HiveField(3) String? imageUrl,
      @HiveField(4) PrizeType type,
      @HiveField(5) String? value,
      @HiveField(6) int position,
      @HiveField(7) String? winnerId});
}

/// @nodoc
class _$ChallengePrizeCopyWithImpl<$Res, $Val extends ChallengePrize>
    implements $ChallengePrizeCopyWith<$Res> {
  _$ChallengePrizeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChallengePrize
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? imageUrl = freezed,
    Object? type = null,
    Object? value = freezed,
    Object? position = null,
    Object? winnerId = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PrizeType,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
      winnerId: freezed == winnerId
          ? _value.winnerId
          : winnerId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChallengePrizeImplCopyWith<$Res>
    implements $ChallengePrizeCopyWith<$Res> {
  factory _$$ChallengePrizeImplCopyWith(_$ChallengePrizeImpl value,
          $Res Function(_$ChallengePrizeImpl) then) =
      __$$ChallengePrizeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String title,
      @HiveField(2) String description,
      @HiveField(3) String? imageUrl,
      @HiveField(4) PrizeType type,
      @HiveField(5) String? value,
      @HiveField(6) int position,
      @HiveField(7) String? winnerId});
}

/// @nodoc
class __$$ChallengePrizeImplCopyWithImpl<$Res>
    extends _$ChallengePrizeCopyWithImpl<$Res, _$ChallengePrizeImpl>
    implements _$$ChallengePrizeImplCopyWith<$Res> {
  __$$ChallengePrizeImplCopyWithImpl(
      _$ChallengePrizeImpl _value, $Res Function(_$ChallengePrizeImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChallengePrize
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? imageUrl = freezed,
    Object? type = null,
    Object? value = freezed,
    Object? position = null,
    Object? winnerId = freezed,
  }) {
    return _then(_$ChallengePrizeImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PrizeType,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
      winnerId: freezed == winnerId
          ? _value.winnerId
          : winnerId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChallengePrizeImpl implements _ChallengePrize {
  const _$ChallengePrizeImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.title,
      @HiveField(2) required this.description,
      @HiveField(3) this.imageUrl,
      @HiveField(4) required this.type,
      @HiveField(5) this.value,
      @HiveField(6) required this.position,
      @HiveField(7) this.winnerId});

  factory _$ChallengePrizeImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChallengePrizeImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String title;
  @override
  @HiveField(2)
  final String description;
  @override
  @HiveField(3)
  final String? imageUrl;
  @override
  @HiveField(4)
  final PrizeType type;
  @override
  @HiveField(5)
  final String? value;
  @override
  @HiveField(6)
  final int position;
// 1st, 2nd, 3rd place
  @override
  @HiveField(7)
  final String? winnerId;

  @override
  String toString() {
    return 'ChallengePrize(id: $id, title: $title, description: $description, imageUrl: $imageUrl, type: $type, value: $value, position: $position, winnerId: $winnerId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChallengePrizeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.winnerId, winnerId) ||
                other.winnerId == winnerId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, description, imageUrl,
      type, value, position, winnerId);

  /// Create a copy of ChallengePrize
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChallengePrizeImplCopyWith<_$ChallengePrizeImpl> get copyWith =>
      __$$ChallengePrizeImplCopyWithImpl<_$ChallengePrizeImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChallengePrizeImplToJson(
      this,
    );
  }
}

abstract class _ChallengePrize implements ChallengePrize {
  const factory _ChallengePrize(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String title,
      @HiveField(2) required final String description,
      @HiveField(3) final String? imageUrl,
      @HiveField(4) required final PrizeType type,
      @HiveField(5) final String? value,
      @HiveField(6) required final int position,
      @HiveField(7) final String? winnerId}) = _$ChallengePrizeImpl;

  factory _ChallengePrize.fromJson(Map<String, dynamic> json) =
      _$ChallengePrizeImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get title;
  @override
  @HiveField(2)
  String get description;
  @override
  @HiveField(3)
  String? get imageUrl;
  @override
  @HiveField(4)
  PrizeType get type;
  @override
  @HiveField(5)
  String? get value;
  @override
  @HiveField(6)
  int get position; // 1st, 2nd, 3rd place
  @override
  @HiveField(7)
  String? get winnerId;

  /// Create a copy of ChallengePrize
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChallengePrizeImplCopyWith<_$ChallengePrizeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SocialConnection _$SocialConnectionFromJson(Map<String, dynamic> json) {
  return _SocialConnection.fromJson(json);
}

/// @nodoc
mixin _$SocialConnection {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get userId => throw _privateConstructorUsedError;
  @HiveField(2)
  String get connectedUserId => throw _privateConstructorUsedError;
  @HiveField(3)
  ConnectionType get type => throw _privateConstructorUsedError;
  @HiveField(4)
  DateTime get createdAt => throw _privateConstructorUsedError;
  @HiveField(5)
  ConnectionStatus get status => throw _privateConstructorUsedError;

  /// Serializes this SocialConnection to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SocialConnection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SocialConnectionCopyWith<SocialConnection> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SocialConnectionCopyWith<$Res> {
  factory $SocialConnectionCopyWith(
          SocialConnection value, $Res Function(SocialConnection) then) =
      _$SocialConnectionCopyWithImpl<$Res, SocialConnection>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String userId,
      @HiveField(2) String connectedUserId,
      @HiveField(3) ConnectionType type,
      @HiveField(4) DateTime createdAt,
      @HiveField(5) ConnectionStatus status});
}

/// @nodoc
class _$SocialConnectionCopyWithImpl<$Res, $Val extends SocialConnection>
    implements $SocialConnectionCopyWith<$Res> {
  _$SocialConnectionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SocialConnection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? connectedUserId = null,
    Object? type = null,
    Object? createdAt = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      connectedUserId: null == connectedUserId
          ? _value.connectedUserId
          : connectedUserId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ConnectionType,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ConnectionStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SocialConnectionImplCopyWith<$Res>
    implements $SocialConnectionCopyWith<$Res> {
  factory _$$SocialConnectionImplCopyWith(_$SocialConnectionImpl value,
          $Res Function(_$SocialConnectionImpl) then) =
      __$$SocialConnectionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String userId,
      @HiveField(2) String connectedUserId,
      @HiveField(3) ConnectionType type,
      @HiveField(4) DateTime createdAt,
      @HiveField(5) ConnectionStatus status});
}

/// @nodoc
class __$$SocialConnectionImplCopyWithImpl<$Res>
    extends _$SocialConnectionCopyWithImpl<$Res, _$SocialConnectionImpl>
    implements _$$SocialConnectionImplCopyWith<$Res> {
  __$$SocialConnectionImplCopyWithImpl(_$SocialConnectionImpl _value,
      $Res Function(_$SocialConnectionImpl) _then)
      : super(_value, _then);

  /// Create a copy of SocialConnection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? connectedUserId = null,
    Object? type = null,
    Object? createdAt = null,
    Object? status = null,
  }) {
    return _then(_$SocialConnectionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      connectedUserId: null == connectedUserId
          ? _value.connectedUserId
          : connectedUserId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ConnectionType,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ConnectionStatus,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SocialConnectionImpl implements _SocialConnection {
  const _$SocialConnectionImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.userId,
      @HiveField(2) required this.connectedUserId,
      @HiveField(3) required this.type,
      @HiveField(4) required this.createdAt,
      @HiveField(5) this.status = ConnectionStatus.pending});

  factory _$SocialConnectionImpl.fromJson(Map<String, dynamic> json) =>
      _$$SocialConnectionImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String userId;
  @override
  @HiveField(2)
  final String connectedUserId;
  @override
  @HiveField(3)
  final ConnectionType type;
  @override
  @HiveField(4)
  final DateTime createdAt;
  @override
  @JsonKey()
  @HiveField(5)
  final ConnectionStatus status;

  @override
  String toString() {
    return 'SocialConnection(id: $id, userId: $userId, connectedUserId: $connectedUserId, type: $type, createdAt: $createdAt, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SocialConnectionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.connectedUserId, connectedUserId) ||
                other.connectedUserId == connectedUserId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, userId, connectedUserId, type, createdAt, status);

  /// Create a copy of SocialConnection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SocialConnectionImplCopyWith<_$SocialConnectionImpl> get copyWith =>
      __$$SocialConnectionImplCopyWithImpl<_$SocialConnectionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SocialConnectionImplToJson(
      this,
    );
  }
}

abstract class _SocialConnection implements SocialConnection {
  const factory _SocialConnection(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String userId,
      @HiveField(2) required final String connectedUserId,
      @HiveField(3) required final ConnectionType type,
      @HiveField(4) required final DateTime createdAt,
      @HiveField(5) final ConnectionStatus status}) = _$SocialConnectionImpl;

  factory _SocialConnection.fromJson(Map<String, dynamic> json) =
      _$SocialConnectionImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get userId;
  @override
  @HiveField(2)
  String get connectedUserId;
  @override
  @HiveField(3)
  ConnectionType get type;
  @override
  @HiveField(4)
  DateTime get createdAt;
  @override
  @HiveField(5)
  ConnectionStatus get status;

  /// Create a copy of SocialConnection
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SocialConnectionImplCopyWith<_$SocialConnectionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
