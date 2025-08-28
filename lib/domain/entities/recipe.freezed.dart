// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipe.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Recipe _$RecipeFromJson(Map<String, dynamic> json) {
  return _Recipe.fromJson(json);
}

/// @nodoc
mixin _$Recipe {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get title => throw _privateConstructorUsedError;
  @HiveField(2)
  String get description => throw _privateConstructorUsedError;
  @HiveField(3)
  List<Ingredient> get ingredients => throw _privateConstructorUsedError;
  @HiveField(4)
  List<CookingStep> get instructions => throw _privateConstructorUsedError;
  @HiveField(5)
  Duration get cookingTime => throw _privateConstructorUsedError;
  @HiveField(6)
  Duration get prepTime => throw _privateConstructorUsedError;
  @HiveField(7)
  DifficultyLevel get difficulty => throw _privateConstructorUsedError;
  @HiveField(8)
  int get servings => throw _privateConstructorUsedError;
  @HiveField(9)
  List<String> get tags => throw _privateConstructorUsedError;
  @HiveField(10)
  NutritionInfo get nutrition => throw _privateConstructorUsedError;
  @HiveField(11)
  List<String> get tips => throw _privateConstructorUsedError;
  @HiveField(12)
  double get rating => throw _privateConstructorUsedError;
  @HiveField(13)
  DateTime get createdAt => throw _privateConstructorUsedError;
  @HiveField(14)
  String? get imageUrl => throw _privateConstructorUsedError;
  @HiveField(15)
  bool get isFavorite => throw _privateConstructorUsedError;
  @HiveField(16)
  String? get authorId => throw _privateConstructorUsedError;
  @HiveField(17)
  int get cookCount => throw _privateConstructorUsedError;
  @HiveField(18)
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @HiveField(19)
  DateTime? get lastViewedAt => throw _privateConstructorUsedError;
  @HiveField(20)
  List<String> get collections => throw _privateConstructorUsedError;

  /// Serializes this Recipe to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Recipe
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecipeCopyWith<Recipe> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecipeCopyWith<$Res> {
  factory $RecipeCopyWith(Recipe value, $Res Function(Recipe) then) =
      _$RecipeCopyWithImpl<$Res, Recipe>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String title,
      @HiveField(2) String description,
      @HiveField(3) List<Ingredient> ingredients,
      @HiveField(4) List<CookingStep> instructions,
      @HiveField(5) Duration cookingTime,
      @HiveField(6) Duration prepTime,
      @HiveField(7) DifficultyLevel difficulty,
      @HiveField(8) int servings,
      @HiveField(9) List<String> tags,
      @HiveField(10) NutritionInfo nutrition,
      @HiveField(11) List<String> tips,
      @HiveField(12) double rating,
      @HiveField(13) DateTime createdAt,
      @HiveField(14) String? imageUrl,
      @HiveField(15) bool isFavorite,
      @HiveField(16) String? authorId,
      @HiveField(17) int cookCount,
      @HiveField(18) DateTime? updatedAt,
      @HiveField(19) DateTime? lastViewedAt,
      @HiveField(20) List<String> collections});

  $NutritionInfoCopyWith<$Res> get nutrition;
}

/// @nodoc
class _$RecipeCopyWithImpl<$Res, $Val extends Recipe>
    implements $RecipeCopyWith<$Res> {
  _$RecipeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Recipe
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? ingredients = null,
    Object? instructions = null,
    Object? cookingTime = null,
    Object? prepTime = null,
    Object? difficulty = null,
    Object? servings = null,
    Object? tags = null,
    Object? nutrition = null,
    Object? tips = null,
    Object? rating = null,
    Object? createdAt = null,
    Object? imageUrl = freezed,
    Object? isFavorite = null,
    Object? authorId = freezed,
    Object? cookCount = null,
    Object? updatedAt = freezed,
    Object? lastViewedAt = freezed,
    Object? collections = null,
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
      ingredients: null == ingredients
          ? _value.ingredients
          : ingredients // ignore: cast_nullable_to_non_nullable
              as List<Ingredient>,
      instructions: null == instructions
          ? _value.instructions
          : instructions // ignore: cast_nullable_to_non_nullable
              as List<CookingStep>,
      cookingTime: null == cookingTime
          ? _value.cookingTime
          : cookingTime // ignore: cast_nullable_to_non_nullable
              as Duration,
      prepTime: null == prepTime
          ? _value.prepTime
          : prepTime // ignore: cast_nullable_to_non_nullable
              as Duration,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as DifficultyLevel,
      servings: null == servings
          ? _value.servings
          : servings // ignore: cast_nullable_to_non_nullable
              as int,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      nutrition: null == nutrition
          ? _value.nutrition
          : nutrition // ignore: cast_nullable_to_non_nullable
              as NutritionInfo,
      tips: null == tips
          ? _value.tips
          : tips // ignore: cast_nullable_to_non_nullable
              as List<String>,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      authorId: freezed == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String?,
      cookCount: null == cookCount
          ? _value.cookCount
          : cookCount // ignore: cast_nullable_to_non_nullable
              as int,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastViewedAt: freezed == lastViewedAt
          ? _value.lastViewedAt
          : lastViewedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      collections: null == collections
          ? _value.collections
          : collections // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }

  /// Create a copy of Recipe
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NutritionInfoCopyWith<$Res> get nutrition {
    return $NutritionInfoCopyWith<$Res>(_value.nutrition, (value) {
      return _then(_value.copyWith(nutrition: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RecipeImplCopyWith<$Res> implements $RecipeCopyWith<$Res> {
  factory _$$RecipeImplCopyWith(
          _$RecipeImpl value, $Res Function(_$RecipeImpl) then) =
      __$$RecipeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String title,
      @HiveField(2) String description,
      @HiveField(3) List<Ingredient> ingredients,
      @HiveField(4) List<CookingStep> instructions,
      @HiveField(5) Duration cookingTime,
      @HiveField(6) Duration prepTime,
      @HiveField(7) DifficultyLevel difficulty,
      @HiveField(8) int servings,
      @HiveField(9) List<String> tags,
      @HiveField(10) NutritionInfo nutrition,
      @HiveField(11) List<String> tips,
      @HiveField(12) double rating,
      @HiveField(13) DateTime createdAt,
      @HiveField(14) String? imageUrl,
      @HiveField(15) bool isFavorite,
      @HiveField(16) String? authorId,
      @HiveField(17) int cookCount,
      @HiveField(18) DateTime? updatedAt,
      @HiveField(19) DateTime? lastViewedAt,
      @HiveField(20) List<String> collections});

  @override
  $NutritionInfoCopyWith<$Res> get nutrition;
}

/// @nodoc
class __$$RecipeImplCopyWithImpl<$Res>
    extends _$RecipeCopyWithImpl<$Res, _$RecipeImpl>
    implements _$$RecipeImplCopyWith<$Res> {
  __$$RecipeImplCopyWithImpl(
      _$RecipeImpl _value, $Res Function(_$RecipeImpl) _then)
      : super(_value, _then);

  /// Create a copy of Recipe
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? ingredients = null,
    Object? instructions = null,
    Object? cookingTime = null,
    Object? prepTime = null,
    Object? difficulty = null,
    Object? servings = null,
    Object? tags = null,
    Object? nutrition = null,
    Object? tips = null,
    Object? rating = null,
    Object? createdAt = null,
    Object? imageUrl = freezed,
    Object? isFavorite = null,
    Object? authorId = freezed,
    Object? cookCount = null,
    Object? updatedAt = freezed,
    Object? lastViewedAt = freezed,
    Object? collections = null,
  }) {
    return _then(_$RecipeImpl(
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
      ingredients: null == ingredients
          ? _value._ingredients
          : ingredients // ignore: cast_nullable_to_non_nullable
              as List<Ingredient>,
      instructions: null == instructions
          ? _value._instructions
          : instructions // ignore: cast_nullable_to_non_nullable
              as List<CookingStep>,
      cookingTime: null == cookingTime
          ? _value.cookingTime
          : cookingTime // ignore: cast_nullable_to_non_nullable
              as Duration,
      prepTime: null == prepTime
          ? _value.prepTime
          : prepTime // ignore: cast_nullable_to_non_nullable
              as Duration,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as DifficultyLevel,
      servings: null == servings
          ? _value.servings
          : servings // ignore: cast_nullable_to_non_nullable
              as int,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      nutrition: null == nutrition
          ? _value.nutrition
          : nutrition // ignore: cast_nullable_to_non_nullable
              as NutritionInfo,
      tips: null == tips
          ? _value._tips
          : tips // ignore: cast_nullable_to_non_nullable
              as List<String>,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      authorId: freezed == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String?,
      cookCount: null == cookCount
          ? _value.cookCount
          : cookCount // ignore: cast_nullable_to_non_nullable
              as int,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastViewedAt: freezed == lastViewedAt
          ? _value.lastViewedAt
          : lastViewedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      collections: null == collections
          ? _value._collections
          : collections // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RecipeImpl implements _Recipe {
  const _$RecipeImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.title,
      @HiveField(2) required this.description,
      @HiveField(3) required final List<Ingredient> ingredients,
      @HiveField(4) required final List<CookingStep> instructions,
      @HiveField(5) required this.cookingTime,
      @HiveField(6) required this.prepTime,
      @HiveField(7) required this.difficulty,
      @HiveField(8) required this.servings,
      @HiveField(9) required final List<String> tags,
      @HiveField(10) required this.nutrition,
      @HiveField(11) required final List<String> tips,
      @HiveField(12) this.rating = 0.0,
      @HiveField(13) required this.createdAt,
      @HiveField(14) this.imageUrl,
      @HiveField(15) this.isFavorite = false,
      @HiveField(16) this.authorId,
      @HiveField(17) this.cookCount = 0,
      @HiveField(18) this.updatedAt,
      @HiveField(19) this.lastViewedAt,
      @HiveField(20) final List<String> collections = const []})
      : _ingredients = ingredients,
        _instructions = instructions,
        _tags = tags,
        _tips = tips,
        _collections = collections;

  factory _$RecipeImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecipeImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String title;
  @override
  @HiveField(2)
  final String description;
  final List<Ingredient> _ingredients;
  @override
  @HiveField(3)
  List<Ingredient> get ingredients {
    if (_ingredients is EqualUnmodifiableListView) return _ingredients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ingredients);
  }

  final List<CookingStep> _instructions;
  @override
  @HiveField(4)
  List<CookingStep> get instructions {
    if (_instructions is EqualUnmodifiableListView) return _instructions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_instructions);
  }

  @override
  @HiveField(5)
  final Duration cookingTime;
  @override
  @HiveField(6)
  final Duration prepTime;
  @override
  @HiveField(7)
  final DifficultyLevel difficulty;
  @override
  @HiveField(8)
  final int servings;
  final List<String> _tags;
  @override
  @HiveField(9)
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  @HiveField(10)
  final NutritionInfo nutrition;
  final List<String> _tips;
  @override
  @HiveField(11)
  List<String> get tips {
    if (_tips is EqualUnmodifiableListView) return _tips;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tips);
  }

  @override
  @JsonKey()
  @HiveField(12)
  final double rating;
  @override
  @HiveField(13)
  final DateTime createdAt;
  @override
  @HiveField(14)
  final String? imageUrl;
  @override
  @JsonKey()
  @HiveField(15)
  final bool isFavorite;
  @override
  @HiveField(16)
  final String? authorId;
  @override
  @JsonKey()
  @HiveField(17)
  final int cookCount;
  @override
  @HiveField(18)
  final DateTime? updatedAt;
  @override
  @HiveField(19)
  final DateTime? lastViewedAt;
  final List<String> _collections;
  @override
  @JsonKey()
  @HiveField(20)
  List<String> get collections {
    if (_collections is EqualUnmodifiableListView) return _collections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_collections);
  }

  @override
  String toString() {
    return 'Recipe(id: $id, title: $title, description: $description, ingredients: $ingredients, instructions: $instructions, cookingTime: $cookingTime, prepTime: $prepTime, difficulty: $difficulty, servings: $servings, tags: $tags, nutrition: $nutrition, tips: $tips, rating: $rating, createdAt: $createdAt, imageUrl: $imageUrl, isFavorite: $isFavorite, authorId: $authorId, cookCount: $cookCount, updatedAt: $updatedAt, lastViewedAt: $lastViewedAt, collections: $collections)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecipeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._ingredients, _ingredients) &&
            const DeepCollectionEquality()
                .equals(other._instructions, _instructions) &&
            (identical(other.cookingTime, cookingTime) ||
                other.cookingTime == cookingTime) &&
            (identical(other.prepTime, prepTime) ||
                other.prepTime == prepTime) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.servings, servings) ||
                other.servings == servings) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.nutrition, nutrition) ||
                other.nutrition == nutrition) &&
            const DeepCollectionEquality().equals(other._tips, _tips) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.cookCount, cookCount) ||
                other.cookCount == cookCount) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.lastViewedAt, lastViewedAt) ||
                other.lastViewedAt == lastViewedAt) &&
            const DeepCollectionEquality()
                .equals(other._collections, _collections));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        title,
        description,
        const DeepCollectionEquality().hash(_ingredients),
        const DeepCollectionEquality().hash(_instructions),
        cookingTime,
        prepTime,
        difficulty,
        servings,
        const DeepCollectionEquality().hash(_tags),
        nutrition,
        const DeepCollectionEquality().hash(_tips),
        rating,
        createdAt,
        imageUrl,
        isFavorite,
        authorId,
        cookCount,
        updatedAt,
        lastViewedAt,
        const DeepCollectionEquality().hash(_collections)
      ]);

  /// Create a copy of Recipe
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecipeImplCopyWith<_$RecipeImpl> get copyWith =>
      __$$RecipeImplCopyWithImpl<_$RecipeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecipeImplToJson(
      this,
    );
  }
}

abstract class _Recipe implements Recipe {
  const factory _Recipe(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String title,
      @HiveField(2) required final String description,
      @HiveField(3) required final List<Ingredient> ingredients,
      @HiveField(4) required final List<CookingStep> instructions,
      @HiveField(5) required final Duration cookingTime,
      @HiveField(6) required final Duration prepTime,
      @HiveField(7) required final DifficultyLevel difficulty,
      @HiveField(8) required final int servings,
      @HiveField(9) required final List<String> tags,
      @HiveField(10) required final NutritionInfo nutrition,
      @HiveField(11) required final List<String> tips,
      @HiveField(12) final double rating,
      @HiveField(13) required final DateTime createdAt,
      @HiveField(14) final String? imageUrl,
      @HiveField(15) final bool isFavorite,
      @HiveField(16) final String? authorId,
      @HiveField(17) final int cookCount,
      @HiveField(18) final DateTime? updatedAt,
      @HiveField(19) final DateTime? lastViewedAt,
      @HiveField(20) final List<String> collections}) = _$RecipeImpl;

  factory _Recipe.fromJson(Map<String, dynamic> json) = _$RecipeImpl.fromJson;

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
  List<Ingredient> get ingredients;
  @override
  @HiveField(4)
  List<CookingStep> get instructions;
  @override
  @HiveField(5)
  Duration get cookingTime;
  @override
  @HiveField(6)
  Duration get prepTime;
  @override
  @HiveField(7)
  DifficultyLevel get difficulty;
  @override
  @HiveField(8)
  int get servings;
  @override
  @HiveField(9)
  List<String> get tags;
  @override
  @HiveField(10)
  NutritionInfo get nutrition;
  @override
  @HiveField(11)
  List<String> get tips;
  @override
  @HiveField(12)
  double get rating;
  @override
  @HiveField(13)
  DateTime get createdAt;
  @override
  @HiveField(14)
  String? get imageUrl;
  @override
  @HiveField(15)
  bool get isFavorite;
  @override
  @HiveField(16)
  String? get authorId;
  @override
  @HiveField(17)
  int get cookCount;
  @override
  @HiveField(18)
  DateTime? get updatedAt;
  @override
  @HiveField(19)
  DateTime? get lastViewedAt;
  @override
  @HiveField(20)
  List<String> get collections;

  /// Create a copy of Recipe
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecipeImplCopyWith<_$RecipeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Ingredient _$IngredientFromJson(Map<String, dynamic> json) {
  return _Ingredient.fromJson(json);
}

/// @nodoc
mixin _$Ingredient {
  @HiveField(0)
  String get name => throw _privateConstructorUsedError;
  @HiveField(1)
  double get quantity => throw _privateConstructorUsedError;
  @HiveField(2)
  String get unit => throw _privateConstructorUsedError;
  @HiveField(3)
  String? get category => throw _privateConstructorUsedError;
  @HiveField(4)
  bool get isOptional => throw _privateConstructorUsedError;
  @HiveField(5)
  List<String> get alternatives => throw _privateConstructorUsedError;

  /// Serializes this Ingredient to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Ingredient
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IngredientCopyWith<Ingredient> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IngredientCopyWith<$Res> {
  factory $IngredientCopyWith(
          Ingredient value, $Res Function(Ingredient) then) =
      _$IngredientCopyWithImpl<$Res, Ingredient>;
  @useResult
  $Res call(
      {@HiveField(0) String name,
      @HiveField(1) double quantity,
      @HiveField(2) String unit,
      @HiveField(3) String? category,
      @HiveField(4) bool isOptional,
      @HiveField(5) List<String> alternatives});
}

/// @nodoc
class _$IngredientCopyWithImpl<$Res, $Val extends Ingredient>
    implements $IngredientCopyWith<$Res> {
  _$IngredientCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Ingredient
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? quantity = null,
    Object? unit = null,
    Object? category = freezed,
    Object? isOptional = null,
    Object? alternatives = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      isOptional: null == isOptional
          ? _value.isOptional
          : isOptional // ignore: cast_nullable_to_non_nullable
              as bool,
      alternatives: null == alternatives
          ? _value.alternatives
          : alternatives // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IngredientImplCopyWith<$Res>
    implements $IngredientCopyWith<$Res> {
  factory _$$IngredientImplCopyWith(
          _$IngredientImpl value, $Res Function(_$IngredientImpl) then) =
      __$$IngredientImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String name,
      @HiveField(1) double quantity,
      @HiveField(2) String unit,
      @HiveField(3) String? category,
      @HiveField(4) bool isOptional,
      @HiveField(5) List<String> alternatives});
}

/// @nodoc
class __$$IngredientImplCopyWithImpl<$Res>
    extends _$IngredientCopyWithImpl<$Res, _$IngredientImpl>
    implements _$$IngredientImplCopyWith<$Res> {
  __$$IngredientImplCopyWithImpl(
      _$IngredientImpl _value, $Res Function(_$IngredientImpl) _then)
      : super(_value, _then);

  /// Create a copy of Ingredient
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? quantity = null,
    Object? unit = null,
    Object? category = freezed,
    Object? isOptional = null,
    Object? alternatives = null,
  }) {
    return _then(_$IngredientImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      isOptional: null == isOptional
          ? _value.isOptional
          : isOptional // ignore: cast_nullable_to_non_nullable
              as bool,
      alternatives: null == alternatives
          ? _value._alternatives
          : alternatives // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IngredientImpl implements _Ingredient {
  const _$IngredientImpl(
      {@HiveField(0) required this.name,
      @HiveField(1) required this.quantity,
      @HiveField(2) required this.unit,
      @HiveField(3) this.category,
      @HiveField(4) this.isOptional = false,
      @HiveField(5) final List<String> alternatives = const []})
      : _alternatives = alternatives;

  factory _$IngredientImpl.fromJson(Map<String, dynamic> json) =>
      _$$IngredientImplFromJson(json);

  @override
  @HiveField(0)
  final String name;
  @override
  @HiveField(1)
  final double quantity;
  @override
  @HiveField(2)
  final String unit;
  @override
  @HiveField(3)
  final String? category;
  @override
  @JsonKey()
  @HiveField(4)
  final bool isOptional;
  final List<String> _alternatives;
  @override
  @JsonKey()
  @HiveField(5)
  List<String> get alternatives {
    if (_alternatives is EqualUnmodifiableListView) return _alternatives;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_alternatives);
  }

  @override
  String toString() {
    return 'Ingredient(name: $name, quantity: $quantity, unit: $unit, category: $category, isOptional: $isOptional, alternatives: $alternatives)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IngredientImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.isOptional, isOptional) ||
                other.isOptional == isOptional) &&
            const DeepCollectionEquality()
                .equals(other._alternatives, _alternatives));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, quantity, unit, category,
      isOptional, const DeepCollectionEquality().hash(_alternatives));

  /// Create a copy of Ingredient
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IngredientImplCopyWith<_$IngredientImpl> get copyWith =>
      __$$IngredientImplCopyWithImpl<_$IngredientImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IngredientImplToJson(
      this,
    );
  }
}

abstract class _Ingredient implements Ingredient {
  const factory _Ingredient(
      {@HiveField(0) required final String name,
      @HiveField(1) required final double quantity,
      @HiveField(2) required final String unit,
      @HiveField(3) final String? category,
      @HiveField(4) final bool isOptional,
      @HiveField(5) final List<String> alternatives}) = _$IngredientImpl;

  factory _Ingredient.fromJson(Map<String, dynamic> json) =
      _$IngredientImpl.fromJson;

  @override
  @HiveField(0)
  String get name;
  @override
  @HiveField(1)
  double get quantity;
  @override
  @HiveField(2)
  String get unit;
  @override
  @HiveField(3)
  String? get category;
  @override
  @HiveField(4)
  bool get isOptional;
  @override
  @HiveField(5)
  List<String> get alternatives;

  /// Create a copy of Ingredient
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IngredientImplCopyWith<_$IngredientImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CookingStep _$CookingStepFromJson(Map<String, dynamic> json) {
  return _CookingStep.fromJson(json);
}

/// @nodoc
mixin _$CookingStep {
  @HiveField(0)
  int get stepNumber => throw _privateConstructorUsedError;
  @HiveField(1)
  String get instruction => throw _privateConstructorUsedError;
  @HiveField(2)
  Duration? get duration => throw _privateConstructorUsedError;
  @HiveField(3)
  String? get imageUrl => throw _privateConstructorUsedError;
  @HiveField(4)
  List<String> get tips => throw _privateConstructorUsedError;
  @HiveField(5)
  List<String> get equipment => throw _privateConstructorUsedError;

  /// Serializes this CookingStep to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CookingStep
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CookingStepCopyWith<CookingStep> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CookingStepCopyWith<$Res> {
  factory $CookingStepCopyWith(
          CookingStep value, $Res Function(CookingStep) then) =
      _$CookingStepCopyWithImpl<$Res, CookingStep>;
  @useResult
  $Res call(
      {@HiveField(0) int stepNumber,
      @HiveField(1) String instruction,
      @HiveField(2) Duration? duration,
      @HiveField(3) String? imageUrl,
      @HiveField(4) List<String> tips,
      @HiveField(5) List<String> equipment});
}

/// @nodoc
class _$CookingStepCopyWithImpl<$Res, $Val extends CookingStep>
    implements $CookingStepCopyWith<$Res> {
  _$CookingStepCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CookingStep
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stepNumber = null,
    Object? instruction = null,
    Object? duration = freezed,
    Object? imageUrl = freezed,
    Object? tips = null,
    Object? equipment = null,
  }) {
    return _then(_value.copyWith(
      stepNumber: null == stepNumber
          ? _value.stepNumber
          : stepNumber // ignore: cast_nullable_to_non_nullable
              as int,
      instruction: null == instruction
          ? _value.instruction
          : instruction // ignore: cast_nullable_to_non_nullable
              as String,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      tips: null == tips
          ? _value.tips
          : tips // ignore: cast_nullable_to_non_nullable
              as List<String>,
      equipment: null == equipment
          ? _value.equipment
          : equipment // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CookingStepImplCopyWith<$Res>
    implements $CookingStepCopyWith<$Res> {
  factory _$$CookingStepImplCopyWith(
          _$CookingStepImpl value, $Res Function(_$CookingStepImpl) then) =
      __$$CookingStepImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) int stepNumber,
      @HiveField(1) String instruction,
      @HiveField(2) Duration? duration,
      @HiveField(3) String? imageUrl,
      @HiveField(4) List<String> tips,
      @HiveField(5) List<String> equipment});
}

/// @nodoc
class __$$CookingStepImplCopyWithImpl<$Res>
    extends _$CookingStepCopyWithImpl<$Res, _$CookingStepImpl>
    implements _$$CookingStepImplCopyWith<$Res> {
  __$$CookingStepImplCopyWithImpl(
      _$CookingStepImpl _value, $Res Function(_$CookingStepImpl) _then)
      : super(_value, _then);

  /// Create a copy of CookingStep
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stepNumber = null,
    Object? instruction = null,
    Object? duration = freezed,
    Object? imageUrl = freezed,
    Object? tips = null,
    Object? equipment = null,
  }) {
    return _then(_$CookingStepImpl(
      stepNumber: null == stepNumber
          ? _value.stepNumber
          : stepNumber // ignore: cast_nullable_to_non_nullable
              as int,
      instruction: null == instruction
          ? _value.instruction
          : instruction // ignore: cast_nullable_to_non_nullable
              as String,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      tips: null == tips
          ? _value._tips
          : tips // ignore: cast_nullable_to_non_nullable
              as List<String>,
      equipment: null == equipment
          ? _value._equipment
          : equipment // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CookingStepImpl implements _CookingStep {
  const _$CookingStepImpl(
      {@HiveField(0) required this.stepNumber,
      @HiveField(1) required this.instruction,
      @HiveField(2) this.duration,
      @HiveField(3) this.imageUrl,
      @HiveField(4) final List<String> tips = const [],
      @HiveField(5) final List<String> equipment = const []})
      : _tips = tips,
        _equipment = equipment;

  factory _$CookingStepImpl.fromJson(Map<String, dynamic> json) =>
      _$$CookingStepImplFromJson(json);

  @override
  @HiveField(0)
  final int stepNumber;
  @override
  @HiveField(1)
  final String instruction;
  @override
  @HiveField(2)
  final Duration? duration;
  @override
  @HiveField(3)
  final String? imageUrl;
  final List<String> _tips;
  @override
  @JsonKey()
  @HiveField(4)
  List<String> get tips {
    if (_tips is EqualUnmodifiableListView) return _tips;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tips);
  }

  final List<String> _equipment;
  @override
  @JsonKey()
  @HiveField(5)
  List<String> get equipment {
    if (_equipment is EqualUnmodifiableListView) return _equipment;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_equipment);
  }

  @override
  String toString() {
    return 'CookingStep(stepNumber: $stepNumber, instruction: $instruction, duration: $duration, imageUrl: $imageUrl, tips: $tips, equipment: $equipment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CookingStepImpl &&
            (identical(other.stepNumber, stepNumber) ||
                other.stepNumber == stepNumber) &&
            (identical(other.instruction, instruction) ||
                other.instruction == instruction) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality().equals(other._tips, _tips) &&
            const DeepCollectionEquality()
                .equals(other._equipment, _equipment));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      stepNumber,
      instruction,
      duration,
      imageUrl,
      const DeepCollectionEquality().hash(_tips),
      const DeepCollectionEquality().hash(_equipment));

  /// Create a copy of CookingStep
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CookingStepImplCopyWith<_$CookingStepImpl> get copyWith =>
      __$$CookingStepImplCopyWithImpl<_$CookingStepImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CookingStepImplToJson(
      this,
    );
  }
}

abstract class _CookingStep implements CookingStep {
  const factory _CookingStep(
      {@HiveField(0) required final int stepNumber,
      @HiveField(1) required final String instruction,
      @HiveField(2) final Duration? duration,
      @HiveField(3) final String? imageUrl,
      @HiveField(4) final List<String> tips,
      @HiveField(5) final List<String> equipment}) = _$CookingStepImpl;

  factory _CookingStep.fromJson(Map<String, dynamic> json) =
      _$CookingStepImpl.fromJson;

  @override
  @HiveField(0)
  int get stepNumber;
  @override
  @HiveField(1)
  String get instruction;
  @override
  @HiveField(2)
  Duration? get duration;
  @override
  @HiveField(3)
  String? get imageUrl;
  @override
  @HiveField(4)
  List<String> get tips;
  @override
  @HiveField(5)
  List<String> get equipment;

  /// Create a copy of CookingStep
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CookingStepImplCopyWith<_$CookingStepImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NutritionInfo _$NutritionInfoFromJson(Map<String, dynamic> json) {
  return _NutritionInfo.fromJson(json);
}

/// @nodoc
mixin _$NutritionInfo {
  @HiveField(0)
  double get calories => throw _privateConstructorUsedError;
  @HiveField(1)
  double get protein => throw _privateConstructorUsedError;
  @HiveField(2)
  double get carbs => throw _privateConstructorUsedError;
  @HiveField(3)
  double get fat => throw _privateConstructorUsedError;
  @HiveField(4)
  double get fiber => throw _privateConstructorUsedError;
  @HiveField(5)
  double get sugar => throw _privateConstructorUsedError;
  @HiveField(6)
  double get sodium => throw _privateConstructorUsedError;
  @HiveField(7)
  Map<String, double> get vitamins => throw _privateConstructorUsedError;
  @HiveField(8)
  Map<String, double> get minerals => throw _privateConstructorUsedError;
  @HiveField(9)
  double get carbohydrates => throw _privateConstructorUsedError;
  @HiveField(10)
  double get cholesterol => throw _privateConstructorUsedError;

  /// Serializes this NutritionInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NutritionInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NutritionInfoCopyWith<NutritionInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NutritionInfoCopyWith<$Res> {
  factory $NutritionInfoCopyWith(
          NutritionInfo value, $Res Function(NutritionInfo) then) =
      _$NutritionInfoCopyWithImpl<$Res, NutritionInfo>;
  @useResult
  $Res call(
      {@HiveField(0) double calories,
      @HiveField(1) double protein,
      @HiveField(2) double carbs,
      @HiveField(3) double fat,
      @HiveField(4) double fiber,
      @HiveField(5) double sugar,
      @HiveField(6) double sodium,
      @HiveField(7) Map<String, double> vitamins,
      @HiveField(8) Map<String, double> minerals,
      @HiveField(9) double carbohydrates,
      @HiveField(10) double cholesterol});
}

/// @nodoc
class _$NutritionInfoCopyWithImpl<$Res, $Val extends NutritionInfo>
    implements $NutritionInfoCopyWith<$Res> {
  _$NutritionInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NutritionInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? calories = null,
    Object? protein = null,
    Object? carbs = null,
    Object? fat = null,
    Object? fiber = null,
    Object? sugar = null,
    Object? sodium = null,
    Object? vitamins = null,
    Object? minerals = null,
    Object? carbohydrates = null,
    Object? cholesterol = null,
  }) {
    return _then(_value.copyWith(
      calories: null == calories
          ? _value.calories
          : calories // ignore: cast_nullable_to_non_nullable
              as double,
      protein: null == protein
          ? _value.protein
          : protein // ignore: cast_nullable_to_non_nullable
              as double,
      carbs: null == carbs
          ? _value.carbs
          : carbs // ignore: cast_nullable_to_non_nullable
              as double,
      fat: null == fat
          ? _value.fat
          : fat // ignore: cast_nullable_to_non_nullable
              as double,
      fiber: null == fiber
          ? _value.fiber
          : fiber // ignore: cast_nullable_to_non_nullable
              as double,
      sugar: null == sugar
          ? _value.sugar
          : sugar // ignore: cast_nullable_to_non_nullable
              as double,
      sodium: null == sodium
          ? _value.sodium
          : sodium // ignore: cast_nullable_to_non_nullable
              as double,
      vitamins: null == vitamins
          ? _value.vitamins
          : vitamins // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      minerals: null == minerals
          ? _value.minerals
          : minerals // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      carbohydrates: null == carbohydrates
          ? _value.carbohydrates
          : carbohydrates // ignore: cast_nullable_to_non_nullable
              as double,
      cholesterol: null == cholesterol
          ? _value.cholesterol
          : cholesterol // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NutritionInfoImplCopyWith<$Res>
    implements $NutritionInfoCopyWith<$Res> {
  factory _$$NutritionInfoImplCopyWith(
          _$NutritionInfoImpl value, $Res Function(_$NutritionInfoImpl) then) =
      __$$NutritionInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) double calories,
      @HiveField(1) double protein,
      @HiveField(2) double carbs,
      @HiveField(3) double fat,
      @HiveField(4) double fiber,
      @HiveField(5) double sugar,
      @HiveField(6) double sodium,
      @HiveField(7) Map<String, double> vitamins,
      @HiveField(8) Map<String, double> minerals,
      @HiveField(9) double carbohydrates,
      @HiveField(10) double cholesterol});
}

/// @nodoc
class __$$NutritionInfoImplCopyWithImpl<$Res>
    extends _$NutritionInfoCopyWithImpl<$Res, _$NutritionInfoImpl>
    implements _$$NutritionInfoImplCopyWith<$Res> {
  __$$NutritionInfoImplCopyWithImpl(
      _$NutritionInfoImpl _value, $Res Function(_$NutritionInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of NutritionInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? calories = null,
    Object? protein = null,
    Object? carbs = null,
    Object? fat = null,
    Object? fiber = null,
    Object? sugar = null,
    Object? sodium = null,
    Object? vitamins = null,
    Object? minerals = null,
    Object? carbohydrates = null,
    Object? cholesterol = null,
  }) {
    return _then(_$NutritionInfoImpl(
      calories: null == calories
          ? _value.calories
          : calories // ignore: cast_nullable_to_non_nullable
              as double,
      protein: null == protein
          ? _value.protein
          : protein // ignore: cast_nullable_to_non_nullable
              as double,
      carbs: null == carbs
          ? _value.carbs
          : carbs // ignore: cast_nullable_to_non_nullable
              as double,
      fat: null == fat
          ? _value.fat
          : fat // ignore: cast_nullable_to_non_nullable
              as double,
      fiber: null == fiber
          ? _value.fiber
          : fiber // ignore: cast_nullable_to_non_nullable
              as double,
      sugar: null == sugar
          ? _value.sugar
          : sugar // ignore: cast_nullable_to_non_nullable
              as double,
      sodium: null == sodium
          ? _value.sodium
          : sodium // ignore: cast_nullable_to_non_nullable
              as double,
      vitamins: null == vitamins
          ? _value._vitamins
          : vitamins // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      minerals: null == minerals
          ? _value._minerals
          : minerals // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      carbohydrates: null == carbohydrates
          ? _value.carbohydrates
          : carbohydrates // ignore: cast_nullable_to_non_nullable
              as double,
      cholesterol: null == cholesterol
          ? _value.cholesterol
          : cholesterol // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NutritionInfoImpl implements _NutritionInfo {
  const _$NutritionInfoImpl(
      {@HiveField(0) required this.calories,
      @HiveField(1) required this.protein,
      @HiveField(2) required this.carbs,
      @HiveField(3) required this.fat,
      @HiveField(4) required this.fiber,
      @HiveField(5) required this.sugar,
      @HiveField(6) required this.sodium,
      @HiveField(7) final Map<String, double> vitamins = const {},
      @HiveField(8) final Map<String, double> minerals = const {},
      @HiveField(9) this.carbohydrates = 0.0,
      @HiveField(10) this.cholesterol = 0.0})
      : _vitamins = vitamins,
        _minerals = minerals;

  factory _$NutritionInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$NutritionInfoImplFromJson(json);

  @override
  @HiveField(0)
  final double calories;
  @override
  @HiveField(1)
  final double protein;
  @override
  @HiveField(2)
  final double carbs;
  @override
  @HiveField(3)
  final double fat;
  @override
  @HiveField(4)
  final double fiber;
  @override
  @HiveField(5)
  final double sugar;
  @override
  @HiveField(6)
  final double sodium;
  final Map<String, double> _vitamins;
  @override
  @JsonKey()
  @HiveField(7)
  Map<String, double> get vitamins {
    if (_vitamins is EqualUnmodifiableMapView) return _vitamins;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_vitamins);
  }

  final Map<String, double> _minerals;
  @override
  @JsonKey()
  @HiveField(8)
  Map<String, double> get minerals {
    if (_minerals is EqualUnmodifiableMapView) return _minerals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_minerals);
  }

  @override
  @JsonKey()
  @HiveField(9)
  final double carbohydrates;
  @override
  @JsonKey()
  @HiveField(10)
  final double cholesterol;

  @override
  String toString() {
    return 'NutritionInfo(calories: $calories, protein: $protein, carbs: $carbs, fat: $fat, fiber: $fiber, sugar: $sugar, sodium: $sodium, vitamins: $vitamins, minerals: $minerals, carbohydrates: $carbohydrates, cholesterol: $cholesterol)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NutritionInfoImpl &&
            (identical(other.calories, calories) ||
                other.calories == calories) &&
            (identical(other.protein, protein) || other.protein == protein) &&
            (identical(other.carbs, carbs) || other.carbs == carbs) &&
            (identical(other.fat, fat) || other.fat == fat) &&
            (identical(other.fiber, fiber) || other.fiber == fiber) &&
            (identical(other.sugar, sugar) || other.sugar == sugar) &&
            (identical(other.sodium, sodium) || other.sodium == sodium) &&
            const DeepCollectionEquality().equals(other._vitamins, _vitamins) &&
            const DeepCollectionEquality().equals(other._minerals, _minerals) &&
            (identical(other.carbohydrates, carbohydrates) ||
                other.carbohydrates == carbohydrates) &&
            (identical(other.cholesterol, cholesterol) ||
                other.cholesterol == cholesterol));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      calories,
      protein,
      carbs,
      fat,
      fiber,
      sugar,
      sodium,
      const DeepCollectionEquality().hash(_vitamins),
      const DeepCollectionEquality().hash(_minerals),
      carbohydrates,
      cholesterol);

  /// Create a copy of NutritionInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NutritionInfoImplCopyWith<_$NutritionInfoImpl> get copyWith =>
      __$$NutritionInfoImplCopyWithImpl<_$NutritionInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NutritionInfoImplToJson(
      this,
    );
  }
}

abstract class _NutritionInfo implements NutritionInfo {
  const factory _NutritionInfo(
      {@HiveField(0) required final double calories,
      @HiveField(1) required final double protein,
      @HiveField(2) required final double carbs,
      @HiveField(3) required final double fat,
      @HiveField(4) required final double fiber,
      @HiveField(5) required final double sugar,
      @HiveField(6) required final double sodium,
      @HiveField(7) final Map<String, double> vitamins,
      @HiveField(8) final Map<String, double> minerals,
      @HiveField(9) final double carbohydrates,
      @HiveField(10) final double cholesterol}) = _$NutritionInfoImpl;

  factory _NutritionInfo.fromJson(Map<String, dynamic> json) =
      _$NutritionInfoImpl.fromJson;

  @override
  @HiveField(0)
  double get calories;
  @override
  @HiveField(1)
  double get protein;
  @override
  @HiveField(2)
  double get carbs;
  @override
  @HiveField(3)
  double get fat;
  @override
  @HiveField(4)
  double get fiber;
  @override
  @HiveField(5)
  double get sugar;
  @override
  @HiveField(6)
  double get sodium;
  @override
  @HiveField(7)
  Map<String, double> get vitamins;
  @override
  @HiveField(8)
  Map<String, double> get minerals;
  @override
  @HiveField(9)
  double get carbohydrates;
  @override
  @HiveField(10)
  double get cholesterol;

  /// Create a copy of NutritionInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NutritionInfoImplCopyWith<_$NutritionInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserPreferences _$UserPreferencesFromJson(Map<String, dynamic> json) {
  return _UserPreferences.fromJson(json);
}

/// @nodoc
mixin _$UserPreferences {
  List<String> get favoriteCuisines => throw _privateConstructorUsedError;
  List<DietaryRestriction> get dietaryRestrictions =>
      throw _privateConstructorUsedError;
  List<String> get allergies => throw _privateConstructorUsedError;
  int get maxCookingTimeMinutes => throw _privateConstructorUsedError;
  DifficultyLevel get maxDifficulty => throw _privateConstructorUsedError;
  int get defaultServings => throw _privateConstructorUsedError;

  /// Serializes this UserPreferences to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserPreferences
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserPreferencesCopyWith<UserPreferences> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserPreferencesCopyWith<$Res> {
  factory $UserPreferencesCopyWith(
          UserPreferences value, $Res Function(UserPreferences) then) =
      _$UserPreferencesCopyWithImpl<$Res, UserPreferences>;
  @useResult
  $Res call(
      {List<String> favoriteCuisines,
      List<DietaryRestriction> dietaryRestrictions,
      List<String> allergies,
      int maxCookingTimeMinutes,
      DifficultyLevel maxDifficulty,
      int defaultServings});
}

/// @nodoc
class _$UserPreferencesCopyWithImpl<$Res, $Val extends UserPreferences>
    implements $UserPreferencesCopyWith<$Res> {
  _$UserPreferencesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserPreferences
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? favoriteCuisines = null,
    Object? dietaryRestrictions = null,
    Object? allergies = null,
    Object? maxCookingTimeMinutes = null,
    Object? maxDifficulty = null,
    Object? defaultServings = null,
  }) {
    return _then(_value.copyWith(
      favoriteCuisines: null == favoriteCuisines
          ? _value.favoriteCuisines
          : favoriteCuisines // ignore: cast_nullable_to_non_nullable
              as List<String>,
      dietaryRestrictions: null == dietaryRestrictions
          ? _value.dietaryRestrictions
          : dietaryRestrictions // ignore: cast_nullable_to_non_nullable
              as List<DietaryRestriction>,
      allergies: null == allergies
          ? _value.allergies
          : allergies // ignore: cast_nullable_to_non_nullable
              as List<String>,
      maxCookingTimeMinutes: null == maxCookingTimeMinutes
          ? _value.maxCookingTimeMinutes
          : maxCookingTimeMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      maxDifficulty: null == maxDifficulty
          ? _value.maxDifficulty
          : maxDifficulty // ignore: cast_nullable_to_non_nullable
              as DifficultyLevel,
      defaultServings: null == defaultServings
          ? _value.defaultServings
          : defaultServings // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserPreferencesImplCopyWith<$Res>
    implements $UserPreferencesCopyWith<$Res> {
  factory _$$UserPreferencesImplCopyWith(_$UserPreferencesImpl value,
          $Res Function(_$UserPreferencesImpl) then) =
      __$$UserPreferencesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String> favoriteCuisines,
      List<DietaryRestriction> dietaryRestrictions,
      List<String> allergies,
      int maxCookingTimeMinutes,
      DifficultyLevel maxDifficulty,
      int defaultServings});
}

/// @nodoc
class __$$UserPreferencesImplCopyWithImpl<$Res>
    extends _$UserPreferencesCopyWithImpl<$Res, _$UserPreferencesImpl>
    implements _$$UserPreferencesImplCopyWith<$Res> {
  __$$UserPreferencesImplCopyWithImpl(
      _$UserPreferencesImpl _value, $Res Function(_$UserPreferencesImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserPreferences
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? favoriteCuisines = null,
    Object? dietaryRestrictions = null,
    Object? allergies = null,
    Object? maxCookingTimeMinutes = null,
    Object? maxDifficulty = null,
    Object? defaultServings = null,
  }) {
    return _then(_$UserPreferencesImpl(
      favoriteCuisines: null == favoriteCuisines
          ? _value._favoriteCuisines
          : favoriteCuisines // ignore: cast_nullable_to_non_nullable
              as List<String>,
      dietaryRestrictions: null == dietaryRestrictions
          ? _value._dietaryRestrictions
          : dietaryRestrictions // ignore: cast_nullable_to_non_nullable
              as List<DietaryRestriction>,
      allergies: null == allergies
          ? _value._allergies
          : allergies // ignore: cast_nullable_to_non_nullable
              as List<String>,
      maxCookingTimeMinutes: null == maxCookingTimeMinutes
          ? _value.maxCookingTimeMinutes
          : maxCookingTimeMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      maxDifficulty: null == maxDifficulty
          ? _value.maxDifficulty
          : maxDifficulty // ignore: cast_nullable_to_non_nullable
              as DifficultyLevel,
      defaultServings: null == defaultServings
          ? _value.defaultServings
          : defaultServings // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserPreferencesImpl implements _UserPreferences {
  const _$UserPreferencesImpl(
      {final List<String> favoriteCuisines = const [],
      final List<DietaryRestriction> dietaryRestrictions = const [],
      final List<String> allergies = const [],
      this.maxCookingTimeMinutes = 30,
      this.maxDifficulty = DifficultyLevel.intermediate,
      this.defaultServings = 4})
      : _favoriteCuisines = favoriteCuisines,
        _dietaryRestrictions = dietaryRestrictions,
        _allergies = allergies;

  factory _$UserPreferencesImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserPreferencesImplFromJson(json);

  final List<String> _favoriteCuisines;
  @override
  @JsonKey()
  List<String> get favoriteCuisines {
    if (_favoriteCuisines is EqualUnmodifiableListView)
      return _favoriteCuisines;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_favoriteCuisines);
  }

  final List<DietaryRestriction> _dietaryRestrictions;
  @override
  @JsonKey()
  List<DietaryRestriction> get dietaryRestrictions {
    if (_dietaryRestrictions is EqualUnmodifiableListView)
      return _dietaryRestrictions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dietaryRestrictions);
  }

  final List<String> _allergies;
  @override
  @JsonKey()
  List<String> get allergies {
    if (_allergies is EqualUnmodifiableListView) return _allergies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allergies);
  }

  @override
  @JsonKey()
  final int maxCookingTimeMinutes;
  @override
  @JsonKey()
  final DifficultyLevel maxDifficulty;
  @override
  @JsonKey()
  final int defaultServings;

  @override
  String toString() {
    return 'UserPreferences(favoriteCuisines: $favoriteCuisines, dietaryRestrictions: $dietaryRestrictions, allergies: $allergies, maxCookingTimeMinutes: $maxCookingTimeMinutes, maxDifficulty: $maxDifficulty, defaultServings: $defaultServings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserPreferencesImpl &&
            const DeepCollectionEquality()
                .equals(other._favoriteCuisines, _favoriteCuisines) &&
            const DeepCollectionEquality()
                .equals(other._dietaryRestrictions, _dietaryRestrictions) &&
            const DeepCollectionEquality()
                .equals(other._allergies, _allergies) &&
            (identical(other.maxCookingTimeMinutes, maxCookingTimeMinutes) ||
                other.maxCookingTimeMinutes == maxCookingTimeMinutes) &&
            (identical(other.maxDifficulty, maxDifficulty) ||
                other.maxDifficulty == maxDifficulty) &&
            (identical(other.defaultServings, defaultServings) ||
                other.defaultServings == defaultServings));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_favoriteCuisines),
      const DeepCollectionEquality().hash(_dietaryRestrictions),
      const DeepCollectionEquality().hash(_allergies),
      maxCookingTimeMinutes,
      maxDifficulty,
      defaultServings);

  /// Create a copy of UserPreferences
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserPreferencesImplCopyWith<_$UserPreferencesImpl> get copyWith =>
      __$$UserPreferencesImplCopyWithImpl<_$UserPreferencesImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserPreferencesImplToJson(
      this,
    );
  }
}

abstract class _UserPreferences implements UserPreferences {
  const factory _UserPreferences(
      {final List<String> favoriteCuisines,
      final List<DietaryRestriction> dietaryRestrictions,
      final List<String> allergies,
      final int maxCookingTimeMinutes,
      final DifficultyLevel maxDifficulty,
      final int defaultServings}) = _$UserPreferencesImpl;

  factory _UserPreferences.fromJson(Map<String, dynamic> json) =
      _$UserPreferencesImpl.fromJson;

  @override
  List<String> get favoriteCuisines;
  @override
  List<DietaryRestriction> get dietaryRestrictions;
  @override
  List<String> get allergies;
  @override
  int get maxCookingTimeMinutes;
  @override
  DifficultyLevel get maxDifficulty;
  @override
  int get defaultServings;

  /// Create a copy of UserPreferences
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserPreferencesImplCopyWith<_$UserPreferencesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
