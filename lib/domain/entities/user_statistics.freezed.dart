// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_statistics.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserStatistics _$UserStatisticsFromJson(Map<String, dynamic> json) {
  return _UserStatistics.fromJson(json);
}

/// @nodoc
mixin _$UserStatistics {
  String get userId => throw _privateConstructorUsedError;
  int get recipesGenerated => throw _privateConstructorUsedError;
  int get recipesCooked => throw _privateConstructorUsedError;
  int get favoriteRecipes => throw _privateConstructorUsedError;
  Map<String, int> get cuisinePreferences => throw _privateConstructorUsedError;
  Map<String, int> get ingredientUsage => throw _privateConstructorUsedError;
  Map<String, int> get cookingMethods => throw _privateConstructorUsedError;
  double get averageRating => throw _privateConstructorUsedError;
  int get totalCookingTime => throw _privateConstructorUsedError;
  DateTime get lastActivity => throw _privateConstructorUsedError;
  Map<String, dynamic> get achievements => throw _privateConstructorUsedError;
  int get streakDays => throw _privateConstructorUsedError;
  int get totalCaloriesCooked => throw _privateConstructorUsedError;
  Map<String, int> get nutritionStats => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserStatisticsCopyWith<UserStatistics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserStatisticsCopyWith<$Res> {
  factory $UserStatisticsCopyWith(
          UserStatistics value, $Res Function(UserStatistics) then) =
      _$UserStatisticsCopyWithImpl<$Res, UserStatistics>;
  @useResult
  $Res call(
      {String userId,
      int recipesGenerated,
      int recipesCooked,
      int favoriteRecipes,
      Map<String, int> cuisinePreferences,
      Map<String, int> ingredientUsage,
      Map<String, int> cookingMethods,
      double averageRating,
      int totalCookingTime,
      DateTime lastActivity,
      Map<String, dynamic> achievements,
      int streakDays,
      int totalCaloriesCooked,
      Map<String, int> nutritionStats});
}

/// @nodoc
class _$UserStatisticsCopyWithImpl<$Res, $Val extends UserStatistics>
    implements $UserStatisticsCopyWith<$Res> {
  _$UserStatisticsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? recipesGenerated = null,
    Object? recipesCooked = null,
    Object? favoriteRecipes = null,
    Object? cuisinePreferences = null,
    Object? ingredientUsage = null,
    Object? cookingMethods = null,
    Object? averageRating = null,
    Object? totalCookingTime = null,
    Object? lastActivity = null,
    Object? achievements = null,
    Object? streakDays = null,
    Object? totalCaloriesCooked = null,
    Object? nutritionStats = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      recipesGenerated: null == recipesGenerated
          ? _value.recipesGenerated
          : recipesGenerated // ignore: cast_nullable_to_non_nullable
              as int,
      recipesCooked: null == recipesCooked
          ? _value.recipesCooked
          : recipesCooked // ignore: cast_nullable_to_non_nullable
              as int,
      favoriteRecipes: null == favoriteRecipes
          ? _value.favoriteRecipes
          : favoriteRecipes // ignore: cast_nullable_to_non_nullable
              as int,
      cuisinePreferences: null == cuisinePreferences
          ? _value.cuisinePreferences
          : cuisinePreferences // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      ingredientUsage: null == ingredientUsage
          ? _value.ingredientUsage
          : ingredientUsage // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      cookingMethods: null == cookingMethods
          ? _value.cookingMethods
          : cookingMethods // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      averageRating: null == averageRating
          ? _value.averageRating
          : averageRating // ignore: cast_nullable_to_non_nullable
              as double,
      totalCookingTime: null == totalCookingTime
          ? _value.totalCookingTime
          : totalCookingTime // ignore: cast_nullable_to_non_nullable
              as int,
      lastActivity: null == lastActivity
          ? _value.lastActivity
          : lastActivity // ignore: cast_nullable_to_non_nullable
              as DateTime,
      achievements: null == achievements
          ? _value.achievements
          : achievements // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      streakDays: null == streakDays
          ? _value.streakDays
          : streakDays // ignore: cast_nullable_to_non_nullable
              as int,
      totalCaloriesCooked: null == totalCaloriesCooked
          ? _value.totalCaloriesCooked
          : totalCaloriesCooked // ignore: cast_nullable_to_non_nullable
              as int,
      nutritionStats: null == nutritionStats
          ? _value.nutritionStats
          : nutritionStats // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserStatisticsImplCopyWith<$Res>
    implements $UserStatisticsCopyWith<$Res> {
  factory _$$UserStatisticsImplCopyWith(_$UserStatisticsImpl value,
          $Res Function(_$UserStatisticsImpl) then) =
      __$$UserStatisticsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      int recipesGenerated,
      int recipesCooked,
      int favoriteRecipes,
      Map<String, int> cuisinePreferences,
      Map<String, int> ingredientUsage,
      Map<String, int> cookingMethods,
      double averageRating,
      int totalCookingTime,
      DateTime lastActivity,
      Map<String, dynamic> achievements,
      int streakDays,
      int totalCaloriesCooked,
      Map<String, int> nutritionStats});
}

/// @nodoc
class __$$UserStatisticsImplCopyWithImpl<$Res>
    extends _$UserStatisticsCopyWithImpl<$Res, _$UserStatisticsImpl>
    implements _$$UserStatisticsImplCopyWith<$Res> {
  __$$UserStatisticsImplCopyWithImpl(
      _$UserStatisticsImpl _value, $Res Function(_$UserStatisticsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? recipesGenerated = null,
    Object? recipesCooked = null,
    Object? favoriteRecipes = null,
    Object? cuisinePreferences = null,
    Object? ingredientUsage = null,
    Object? cookingMethods = null,
    Object? averageRating = null,
    Object? totalCookingTime = null,
    Object? lastActivity = null,
    Object? achievements = null,
    Object? streakDays = null,
    Object? totalCaloriesCooked = null,
    Object? nutritionStats = null,
  }) {
    return _then(_$UserStatisticsImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      recipesGenerated: null == recipesGenerated
          ? _value.recipesGenerated
          : recipesGenerated // ignore: cast_nullable_to_non_nullable
              as int,
      recipesCooked: null == recipesCooked
          ? _value.recipesCooked
          : recipesCooked // ignore: cast_nullable_to_non_nullable
              as int,
      favoriteRecipes: null == favoriteRecipes
          ? _value.favoriteRecipes
          : favoriteRecipes // ignore: cast_nullable_to_non_nullable
              as int,
      cuisinePreferences: null == cuisinePreferences
          ? _value._cuisinePreferences
          : cuisinePreferences // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      ingredientUsage: null == ingredientUsage
          ? _value._ingredientUsage
          : ingredientUsage // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      cookingMethods: null == cookingMethods
          ? _value._cookingMethods
          : cookingMethods // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      averageRating: null == averageRating
          ? _value.averageRating
          : averageRating // ignore: cast_nullable_to_non_nullable
              as double,
      totalCookingTime: null == totalCookingTime
          ? _value.totalCookingTime
          : totalCookingTime // ignore: cast_nullable_to_non_nullable
              as int,
      lastActivity: null == lastActivity
          ? _value.lastActivity
          : lastActivity // ignore: cast_nullable_to_non_nullable
              as DateTime,
      achievements: null == achievements
          ? _value._achievements
          : achievements // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      streakDays: null == streakDays
          ? _value.streakDays
          : streakDays // ignore: cast_nullable_to_non_nullable
              as int,
      totalCaloriesCooked: null == totalCaloriesCooked
          ? _value.totalCaloriesCooked
          : totalCaloriesCooked // ignore: cast_nullable_to_non_nullable
              as int,
      nutritionStats: null == nutritionStats
          ? _value._nutritionStats
          : nutritionStats // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserStatisticsImpl implements _UserStatistics {
  const _$UserStatisticsImpl(
      {required this.userId,
      required this.recipesGenerated,
      required this.recipesCooked,
      required this.favoriteRecipes,
      required final Map<String, int> cuisinePreferences,
      required final Map<String, int> ingredientUsage,
      required final Map<String, int> cookingMethods,
      required this.averageRating,
      required this.totalCookingTime,
      required this.lastActivity,
      final Map<String, dynamic> achievements = const {},
      this.streakDays = 0,
      this.totalCaloriesCooked = 0,
      final Map<String, int> nutritionStats = const {}})
      : _cuisinePreferences = cuisinePreferences,
        _ingredientUsage = ingredientUsage,
        _cookingMethods = cookingMethods,
        _achievements = achievements,
        _nutritionStats = nutritionStats;

  factory _$UserStatisticsImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserStatisticsImplFromJson(json);

  @override
  final String userId;
  @override
  final int recipesGenerated;
  @override
  final int recipesCooked;
  @override
  final int favoriteRecipes;
  final Map<String, int> _cuisinePreferences;
  @override
  Map<String, int> get cuisinePreferences {
    if (_cuisinePreferences is EqualUnmodifiableMapView)
      return _cuisinePreferences;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_cuisinePreferences);
  }

  final Map<String, int> _ingredientUsage;
  @override
  Map<String, int> get ingredientUsage {
    if (_ingredientUsage is EqualUnmodifiableMapView) return _ingredientUsage;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_ingredientUsage);
  }

  final Map<String, int> _cookingMethods;
  @override
  Map<String, int> get cookingMethods {
    if (_cookingMethods is EqualUnmodifiableMapView) return _cookingMethods;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_cookingMethods);
  }

  @override
  final double averageRating;
  @override
  final int totalCookingTime;
  @override
  final DateTime lastActivity;
  final Map<String, dynamic> _achievements;
  @override
  @JsonKey()
  Map<String, dynamic> get achievements {
    if (_achievements is EqualUnmodifiableMapView) return _achievements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_achievements);
  }

  @override
  @JsonKey()
  final int streakDays;
  @override
  @JsonKey()
  final int totalCaloriesCooked;
  final Map<String, int> _nutritionStats;
  @override
  @JsonKey()
  Map<String, int> get nutritionStats {
    if (_nutritionStats is EqualUnmodifiableMapView) return _nutritionStats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_nutritionStats);
  }

  @override
  String toString() {
    return 'UserStatistics(userId: $userId, recipesGenerated: $recipesGenerated, recipesCooked: $recipesCooked, favoriteRecipes: $favoriteRecipes, cuisinePreferences: $cuisinePreferences, ingredientUsage: $ingredientUsage, cookingMethods: $cookingMethods, averageRating: $averageRating, totalCookingTime: $totalCookingTime, lastActivity: $lastActivity, achievements: $achievements, streakDays: $streakDays, totalCaloriesCooked: $totalCaloriesCooked, nutritionStats: $nutritionStats)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserStatisticsImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.recipesGenerated, recipesGenerated) ||
                other.recipesGenerated == recipesGenerated) &&
            (identical(other.recipesCooked, recipesCooked) ||
                other.recipesCooked == recipesCooked) &&
            (identical(other.favoriteRecipes, favoriteRecipes) ||
                other.favoriteRecipes == favoriteRecipes) &&
            const DeepCollectionEquality()
                .equals(other._cuisinePreferences, _cuisinePreferences) &&
            const DeepCollectionEquality()
                .equals(other._ingredientUsage, _ingredientUsage) &&
            const DeepCollectionEquality()
                .equals(other._cookingMethods, _cookingMethods) &&
            (identical(other.averageRating, averageRating) ||
                other.averageRating == averageRating) &&
            (identical(other.totalCookingTime, totalCookingTime) ||
                other.totalCookingTime == totalCookingTime) &&
            (identical(other.lastActivity, lastActivity) ||
                other.lastActivity == lastActivity) &&
            const DeepCollectionEquality()
                .equals(other._achievements, _achievements) &&
            (identical(other.streakDays, streakDays) ||
                other.streakDays == streakDays) &&
            (identical(other.totalCaloriesCooked, totalCaloriesCooked) ||
                other.totalCaloriesCooked == totalCaloriesCooked) &&
            const DeepCollectionEquality()
                .equals(other._nutritionStats, _nutritionStats));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      recipesGenerated,
      recipesCooked,
      favoriteRecipes,
      const DeepCollectionEquality().hash(_cuisinePreferences),
      const DeepCollectionEquality().hash(_ingredientUsage),
      const DeepCollectionEquality().hash(_cookingMethods),
      averageRating,
      totalCookingTime,
      lastActivity,
      const DeepCollectionEquality().hash(_achievements),
      streakDays,
      totalCaloriesCooked,
      const DeepCollectionEquality().hash(_nutritionStats));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserStatisticsImplCopyWith<_$UserStatisticsImpl> get copyWith =>
      __$$UserStatisticsImplCopyWithImpl<_$UserStatisticsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserStatisticsImplToJson(
      this,
    );
  }
}

abstract class _UserStatistics implements UserStatistics {
  const factory _UserStatistics(
      {required final String userId,
      required final int recipesGenerated,
      required final int recipesCooked,
      required final int favoriteRecipes,
      required final Map<String, int> cuisinePreferences,
      required final Map<String, int> ingredientUsage,
      required final Map<String, int> cookingMethods,
      required final double averageRating,
      required final int totalCookingTime,
      required final DateTime lastActivity,
      final Map<String, dynamic> achievements,
      final int streakDays,
      final int totalCaloriesCooked,
      final Map<String, int> nutritionStats}) = _$UserStatisticsImpl;

  factory _UserStatistics.fromJson(Map<String, dynamic> json) =
      _$UserStatisticsImpl.fromJson;

  @override
  String get userId;
  @override
  int get recipesGenerated;
  @override
  int get recipesCooked;
  @override
  int get favoriteRecipes;
  @override
  Map<String, int> get cuisinePreferences;
  @override
  Map<String, int> get ingredientUsage;
  @override
  Map<String, int> get cookingMethods;
  @override
  double get averageRating;
  @override
  int get totalCookingTime;
  @override
  DateTime get lastActivity;
  @override
  Map<String, dynamic> get achievements;
  @override
  int get streakDays;
  @override
  int get totalCaloriesCooked;
  @override
  Map<String, int> get nutritionStats;
  @override
  @JsonKey(ignore: true)
  _$$UserStatisticsImplCopyWith<_$UserStatisticsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CookingAchievement _$CookingAchievementFromJson(Map<String, dynamic> json) {
  return _CookingAchievement.fromJson(json);
}

/// @nodoc
mixin _$CookingAchievement {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get iconPath => throw _privateConstructorUsedError;
  DateTime get unlockedAt => throw _privateConstructorUsedError;
  bool get isUnlocked => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CookingAchievementCopyWith<CookingAchievement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CookingAchievementCopyWith<$Res> {
  factory $CookingAchievementCopyWith(
          CookingAchievement value, $Res Function(CookingAchievement) then) =
      _$CookingAchievementCopyWithImpl<$Res, CookingAchievement>;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      String iconPath,
      DateTime unlockedAt,
      bool isUnlocked});
}

/// @nodoc
class _$CookingAchievementCopyWithImpl<$Res, $Val extends CookingAchievement>
    implements $CookingAchievementCopyWith<$Res> {
  _$CookingAchievementCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? iconPath = null,
    Object? unlockedAt = null,
    Object? isUnlocked = null,
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
      iconPath: null == iconPath
          ? _value.iconPath
          : iconPath // ignore: cast_nullable_to_non_nullable
              as String,
      unlockedAt: null == unlockedAt
          ? _value.unlockedAt
          : unlockedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isUnlocked: null == isUnlocked
          ? _value.isUnlocked
          : isUnlocked // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CookingAchievementImplCopyWith<$Res>
    implements $CookingAchievementCopyWith<$Res> {
  factory _$$CookingAchievementImplCopyWith(_$CookingAchievementImpl value,
          $Res Function(_$CookingAchievementImpl) then) =
      __$$CookingAchievementImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      String iconPath,
      DateTime unlockedAt,
      bool isUnlocked});
}

/// @nodoc
class __$$CookingAchievementImplCopyWithImpl<$Res>
    extends _$CookingAchievementCopyWithImpl<$Res, _$CookingAchievementImpl>
    implements _$$CookingAchievementImplCopyWith<$Res> {
  __$$CookingAchievementImplCopyWithImpl(_$CookingAchievementImpl _value,
      $Res Function(_$CookingAchievementImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? iconPath = null,
    Object? unlockedAt = null,
    Object? isUnlocked = null,
  }) {
    return _then(_$CookingAchievementImpl(
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
      iconPath: null == iconPath
          ? _value.iconPath
          : iconPath // ignore: cast_nullable_to_non_nullable
              as String,
      unlockedAt: null == unlockedAt
          ? _value.unlockedAt
          : unlockedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isUnlocked: null == isUnlocked
          ? _value.isUnlocked
          : isUnlocked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CookingAchievementImpl implements _CookingAchievement {
  const _$CookingAchievementImpl(
      {required this.id,
      required this.title,
      required this.description,
      required this.iconPath,
      required this.unlockedAt,
      this.isUnlocked = false});

  factory _$CookingAchievementImpl.fromJson(Map<String, dynamic> json) =>
      _$$CookingAchievementImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final String iconPath;
  @override
  final DateTime unlockedAt;
  @override
  @JsonKey()
  final bool isUnlocked;

  @override
  String toString() {
    return 'CookingAchievement(id: $id, title: $title, description: $description, iconPath: $iconPath, unlockedAt: $unlockedAt, isUnlocked: $isUnlocked)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CookingAchievementImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.iconPath, iconPath) ||
                other.iconPath == iconPath) &&
            (identical(other.unlockedAt, unlockedAt) ||
                other.unlockedAt == unlockedAt) &&
            (identical(other.isUnlocked, isUnlocked) ||
                other.isUnlocked == isUnlocked));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, title, description, iconPath, unlockedAt, isUnlocked);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CookingAchievementImplCopyWith<_$CookingAchievementImpl> get copyWith =>
      __$$CookingAchievementImplCopyWithImpl<_$CookingAchievementImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CookingAchievementImplToJson(
      this,
    );
  }
}

abstract class _CookingAchievement implements CookingAchievement {
  const factory _CookingAchievement(
      {required final String id,
      required final String title,
      required final String description,
      required final String iconPath,
      required final DateTime unlockedAt,
      final bool isUnlocked}) = _$CookingAchievementImpl;

  factory _CookingAchievement.fromJson(Map<String, dynamic> json) =
      _$CookingAchievementImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  String get iconPath;
  @override
  DateTime get unlockedAt;
  @override
  bool get isUnlocked;
  @override
  @JsonKey(ignore: true)
  _$$CookingAchievementImplCopyWith<_$CookingAchievementImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
