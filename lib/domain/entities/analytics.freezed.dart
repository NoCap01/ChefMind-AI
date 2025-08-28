// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'analytics.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserAnalytics _$UserAnalyticsFromJson(Map<String, dynamic> json) {
  return _UserAnalytics.fromJson(json);
}

/// @nodoc
mixin _$UserAnalytics {
  @HiveField(0)
  String get userId => throw _privateConstructorUsedError;
  @HiveField(1)
  CookingStatistics get cookingStats => throw _privateConstructorUsedError;
  @HiveField(2)
  TasteProfile get tasteProfile => throw _privateConstructorUsedError;
  @HiveField(3)
  EfficiencyMetrics get efficiency => throw _privateConstructorUsedError;
  @HiveField(4)
  CostAnalysis get costAnalysis => throw _privateConstructorUsedError;
  @HiveField(5)
  HealthImpact get healthImpact => throw _privateConstructorUsedError;
  @HiveField(6)
  EnvironmentalImpact get environmentalImpact =>
      throw _privateConstructorUsedError;
  @HiveField(7)
  DateTime get lastUpdated => throw _privateConstructorUsedError;
  @HiveField(8)
  Map<String, dynamic> get customMetrics => throw _privateConstructorUsedError;
  @HiveField(9)
  String get cookingFrequency => throw _privateConstructorUsedError;
  @HiveField(10)
  String get preferredDifficulty => throw _privateConstructorUsedError;

  /// Serializes this UserAnalytics to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserAnalyticsCopyWith<UserAnalytics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserAnalyticsCopyWith<$Res> {
  factory $UserAnalyticsCopyWith(
          UserAnalytics value, $Res Function(UserAnalytics) then) =
      _$UserAnalyticsCopyWithImpl<$Res, UserAnalytics>;
  @useResult
  $Res call(
      {@HiveField(0) String userId,
      @HiveField(1) CookingStatistics cookingStats,
      @HiveField(2) TasteProfile tasteProfile,
      @HiveField(3) EfficiencyMetrics efficiency,
      @HiveField(4) CostAnalysis costAnalysis,
      @HiveField(5) HealthImpact healthImpact,
      @HiveField(6) EnvironmentalImpact environmentalImpact,
      @HiveField(7) DateTime lastUpdated,
      @HiveField(8) Map<String, dynamic> customMetrics,
      @HiveField(9) String cookingFrequency,
      @HiveField(10) String preferredDifficulty});

  $CookingStatisticsCopyWith<$Res> get cookingStats;
  $TasteProfileCopyWith<$Res> get tasteProfile;
  $EfficiencyMetricsCopyWith<$Res> get efficiency;
  $CostAnalysisCopyWith<$Res> get costAnalysis;
  $HealthImpactCopyWith<$Res> get healthImpact;
  $EnvironmentalImpactCopyWith<$Res> get environmentalImpact;
}

/// @nodoc
class _$UserAnalyticsCopyWithImpl<$Res, $Val extends UserAnalytics>
    implements $UserAnalyticsCopyWith<$Res> {
  _$UserAnalyticsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? cookingStats = null,
    Object? tasteProfile = null,
    Object? efficiency = null,
    Object? costAnalysis = null,
    Object? healthImpact = null,
    Object? environmentalImpact = null,
    Object? lastUpdated = null,
    Object? customMetrics = null,
    Object? cookingFrequency = null,
    Object? preferredDifficulty = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      cookingStats: null == cookingStats
          ? _value.cookingStats
          : cookingStats // ignore: cast_nullable_to_non_nullable
              as CookingStatistics,
      tasteProfile: null == tasteProfile
          ? _value.tasteProfile
          : tasteProfile // ignore: cast_nullable_to_non_nullable
              as TasteProfile,
      efficiency: null == efficiency
          ? _value.efficiency
          : efficiency // ignore: cast_nullable_to_non_nullable
              as EfficiencyMetrics,
      costAnalysis: null == costAnalysis
          ? _value.costAnalysis
          : costAnalysis // ignore: cast_nullable_to_non_nullable
              as CostAnalysis,
      healthImpact: null == healthImpact
          ? _value.healthImpact
          : healthImpact // ignore: cast_nullable_to_non_nullable
              as HealthImpact,
      environmentalImpact: null == environmentalImpact
          ? _value.environmentalImpact
          : environmentalImpact // ignore: cast_nullable_to_non_nullable
              as EnvironmentalImpact,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      customMetrics: null == customMetrics
          ? _value.customMetrics
          : customMetrics // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      cookingFrequency: null == cookingFrequency
          ? _value.cookingFrequency
          : cookingFrequency // ignore: cast_nullable_to_non_nullable
              as String,
      preferredDifficulty: null == preferredDifficulty
          ? _value.preferredDifficulty
          : preferredDifficulty // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  /// Create a copy of UserAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CookingStatisticsCopyWith<$Res> get cookingStats {
    return $CookingStatisticsCopyWith<$Res>(_value.cookingStats, (value) {
      return _then(_value.copyWith(cookingStats: value) as $Val);
    });
  }

  /// Create a copy of UserAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TasteProfileCopyWith<$Res> get tasteProfile {
    return $TasteProfileCopyWith<$Res>(_value.tasteProfile, (value) {
      return _then(_value.copyWith(tasteProfile: value) as $Val);
    });
  }

  /// Create a copy of UserAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EfficiencyMetricsCopyWith<$Res> get efficiency {
    return $EfficiencyMetricsCopyWith<$Res>(_value.efficiency, (value) {
      return _then(_value.copyWith(efficiency: value) as $Val);
    });
  }

  /// Create a copy of UserAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CostAnalysisCopyWith<$Res> get costAnalysis {
    return $CostAnalysisCopyWith<$Res>(_value.costAnalysis, (value) {
      return _then(_value.copyWith(costAnalysis: value) as $Val);
    });
  }

  /// Create a copy of UserAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $HealthImpactCopyWith<$Res> get healthImpact {
    return $HealthImpactCopyWith<$Res>(_value.healthImpact, (value) {
      return _then(_value.copyWith(healthImpact: value) as $Val);
    });
  }

  /// Create a copy of UserAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EnvironmentalImpactCopyWith<$Res> get environmentalImpact {
    return $EnvironmentalImpactCopyWith<$Res>(_value.environmentalImpact,
        (value) {
      return _then(_value.copyWith(environmentalImpact: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserAnalyticsImplCopyWith<$Res>
    implements $UserAnalyticsCopyWith<$Res> {
  factory _$$UserAnalyticsImplCopyWith(
          _$UserAnalyticsImpl value, $Res Function(_$UserAnalyticsImpl) then) =
      __$$UserAnalyticsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String userId,
      @HiveField(1) CookingStatistics cookingStats,
      @HiveField(2) TasteProfile tasteProfile,
      @HiveField(3) EfficiencyMetrics efficiency,
      @HiveField(4) CostAnalysis costAnalysis,
      @HiveField(5) HealthImpact healthImpact,
      @HiveField(6) EnvironmentalImpact environmentalImpact,
      @HiveField(7) DateTime lastUpdated,
      @HiveField(8) Map<String, dynamic> customMetrics,
      @HiveField(9) String cookingFrequency,
      @HiveField(10) String preferredDifficulty});

  @override
  $CookingStatisticsCopyWith<$Res> get cookingStats;
  @override
  $TasteProfileCopyWith<$Res> get tasteProfile;
  @override
  $EfficiencyMetricsCopyWith<$Res> get efficiency;
  @override
  $CostAnalysisCopyWith<$Res> get costAnalysis;
  @override
  $HealthImpactCopyWith<$Res> get healthImpact;
  @override
  $EnvironmentalImpactCopyWith<$Res> get environmentalImpact;
}

/// @nodoc
class __$$UserAnalyticsImplCopyWithImpl<$Res>
    extends _$UserAnalyticsCopyWithImpl<$Res, _$UserAnalyticsImpl>
    implements _$$UserAnalyticsImplCopyWith<$Res> {
  __$$UserAnalyticsImplCopyWithImpl(
      _$UserAnalyticsImpl _value, $Res Function(_$UserAnalyticsImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? cookingStats = null,
    Object? tasteProfile = null,
    Object? efficiency = null,
    Object? costAnalysis = null,
    Object? healthImpact = null,
    Object? environmentalImpact = null,
    Object? lastUpdated = null,
    Object? customMetrics = null,
    Object? cookingFrequency = null,
    Object? preferredDifficulty = null,
  }) {
    return _then(_$UserAnalyticsImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      cookingStats: null == cookingStats
          ? _value.cookingStats
          : cookingStats // ignore: cast_nullable_to_non_nullable
              as CookingStatistics,
      tasteProfile: null == tasteProfile
          ? _value.tasteProfile
          : tasteProfile // ignore: cast_nullable_to_non_nullable
              as TasteProfile,
      efficiency: null == efficiency
          ? _value.efficiency
          : efficiency // ignore: cast_nullable_to_non_nullable
              as EfficiencyMetrics,
      costAnalysis: null == costAnalysis
          ? _value.costAnalysis
          : costAnalysis // ignore: cast_nullable_to_non_nullable
              as CostAnalysis,
      healthImpact: null == healthImpact
          ? _value.healthImpact
          : healthImpact // ignore: cast_nullable_to_non_nullable
              as HealthImpact,
      environmentalImpact: null == environmentalImpact
          ? _value.environmentalImpact
          : environmentalImpact // ignore: cast_nullable_to_non_nullable
              as EnvironmentalImpact,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      customMetrics: null == customMetrics
          ? _value._customMetrics
          : customMetrics // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      cookingFrequency: null == cookingFrequency
          ? _value.cookingFrequency
          : cookingFrequency // ignore: cast_nullable_to_non_nullable
              as String,
      preferredDifficulty: null == preferredDifficulty
          ? _value.preferredDifficulty
          : preferredDifficulty // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserAnalyticsImpl implements _UserAnalytics {
  const _$UserAnalyticsImpl(
      {@HiveField(0) required this.userId,
      @HiveField(1) required this.cookingStats,
      @HiveField(2) required this.tasteProfile,
      @HiveField(3) required this.efficiency,
      @HiveField(4) required this.costAnalysis,
      @HiveField(5) required this.healthImpact,
      @HiveField(6) required this.environmentalImpact,
      @HiveField(7) required this.lastUpdated,
      @HiveField(8) final Map<String, dynamic> customMetrics = const {},
      @HiveField(9) this.cookingFrequency = 'weekly',
      @HiveField(10) this.preferredDifficulty = 'intermediate'})
      : _customMetrics = customMetrics;

  factory _$UserAnalyticsImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserAnalyticsImplFromJson(json);

  @override
  @HiveField(0)
  final String userId;
  @override
  @HiveField(1)
  final CookingStatistics cookingStats;
  @override
  @HiveField(2)
  final TasteProfile tasteProfile;
  @override
  @HiveField(3)
  final EfficiencyMetrics efficiency;
  @override
  @HiveField(4)
  final CostAnalysis costAnalysis;
  @override
  @HiveField(5)
  final HealthImpact healthImpact;
  @override
  @HiveField(6)
  final EnvironmentalImpact environmentalImpact;
  @override
  @HiveField(7)
  final DateTime lastUpdated;
  final Map<String, dynamic> _customMetrics;
  @override
  @JsonKey()
  @HiveField(8)
  Map<String, dynamic> get customMetrics {
    if (_customMetrics is EqualUnmodifiableMapView) return _customMetrics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_customMetrics);
  }

  @override
  @JsonKey()
  @HiveField(9)
  final String cookingFrequency;
  @override
  @JsonKey()
  @HiveField(10)
  final String preferredDifficulty;

  @override
  String toString() {
    return 'UserAnalytics(userId: $userId, cookingStats: $cookingStats, tasteProfile: $tasteProfile, efficiency: $efficiency, costAnalysis: $costAnalysis, healthImpact: $healthImpact, environmentalImpact: $environmentalImpact, lastUpdated: $lastUpdated, customMetrics: $customMetrics, cookingFrequency: $cookingFrequency, preferredDifficulty: $preferredDifficulty)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserAnalyticsImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.cookingStats, cookingStats) ||
                other.cookingStats == cookingStats) &&
            (identical(other.tasteProfile, tasteProfile) ||
                other.tasteProfile == tasteProfile) &&
            (identical(other.efficiency, efficiency) ||
                other.efficiency == efficiency) &&
            (identical(other.costAnalysis, costAnalysis) ||
                other.costAnalysis == costAnalysis) &&
            (identical(other.healthImpact, healthImpact) ||
                other.healthImpact == healthImpact) &&
            (identical(other.environmentalImpact, environmentalImpact) ||
                other.environmentalImpact == environmentalImpact) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated) &&
            const DeepCollectionEquality()
                .equals(other._customMetrics, _customMetrics) &&
            (identical(other.cookingFrequency, cookingFrequency) ||
                other.cookingFrequency == cookingFrequency) &&
            (identical(other.preferredDifficulty, preferredDifficulty) ||
                other.preferredDifficulty == preferredDifficulty));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      cookingStats,
      tasteProfile,
      efficiency,
      costAnalysis,
      healthImpact,
      environmentalImpact,
      lastUpdated,
      const DeepCollectionEquality().hash(_customMetrics),
      cookingFrequency,
      preferredDifficulty);

  /// Create a copy of UserAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserAnalyticsImplCopyWith<_$UserAnalyticsImpl> get copyWith =>
      __$$UserAnalyticsImplCopyWithImpl<_$UserAnalyticsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserAnalyticsImplToJson(
      this,
    );
  }
}

abstract class _UserAnalytics implements UserAnalytics {
  const factory _UserAnalytics(
      {@HiveField(0) required final String userId,
      @HiveField(1) required final CookingStatistics cookingStats,
      @HiveField(2) required final TasteProfile tasteProfile,
      @HiveField(3) required final EfficiencyMetrics efficiency,
      @HiveField(4) required final CostAnalysis costAnalysis,
      @HiveField(5) required final HealthImpact healthImpact,
      @HiveField(6) required final EnvironmentalImpact environmentalImpact,
      @HiveField(7) required final DateTime lastUpdated,
      @HiveField(8) final Map<String, dynamic> customMetrics,
      @HiveField(9) final String cookingFrequency,
      @HiveField(10) final String preferredDifficulty}) = _$UserAnalyticsImpl;

  factory _UserAnalytics.fromJson(Map<String, dynamic> json) =
      _$UserAnalyticsImpl.fromJson;

  @override
  @HiveField(0)
  String get userId;
  @override
  @HiveField(1)
  CookingStatistics get cookingStats;
  @override
  @HiveField(2)
  TasteProfile get tasteProfile;
  @override
  @HiveField(3)
  EfficiencyMetrics get efficiency;
  @override
  @HiveField(4)
  CostAnalysis get costAnalysis;
  @override
  @HiveField(5)
  HealthImpact get healthImpact;
  @override
  @HiveField(6)
  EnvironmentalImpact get environmentalImpact;
  @override
  @HiveField(7)
  DateTime get lastUpdated;
  @override
  @HiveField(8)
  Map<String, dynamic> get customMetrics;
  @override
  @HiveField(9)
  String get cookingFrequency;
  @override
  @HiveField(10)
  String get preferredDifficulty;

  /// Create a copy of UserAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserAnalyticsImplCopyWith<_$UserAnalyticsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CookingStatistics _$CookingStatisticsFromJson(Map<String, dynamic> json) {
  return _CookingStatistics.fromJson(json);
}

/// @nodoc
mixin _$CookingStatistics {
  @HiveField(0)
  int get totalRecipesCooked => throw _privateConstructorUsedError;
  @HiveField(1)
  int get uniqueRecipesCooked => throw _privateConstructorUsedError;
  @HiveField(2)
  int get totalCookingTimeMinutes => throw _privateConstructorUsedError;
  @HiveField(3)
  int get currentStreak => throw _privateConstructorUsedError;
  @HiveField(4)
  int get longestStreak => throw _privateConstructorUsedError;
  @HiveField(5)
  Map<String, int> get cuisineFrequency => throw _privateConstructorUsedError;
  @HiveField(6)
  Map<String, int> get difficultyDistribution =>
      throw _privateConstructorUsedError;
  @HiveField(7)
  Map<String, int> get cookingMethodFrequency =>
      throw _privateConstructorUsedError;
  @HiveField(8)
  Map<String, double> get averageRatings => throw _privateConstructorUsedError;
  @HiveField(9)
  Map<String, int> get monthlyActivity => throw _privateConstructorUsedError;
  @HiveField(10)
  DateTime? get lastCookingDate => throw _privateConstructorUsedError;
  @HiveField(11)
  List<String> get favoriteRecipeIds => throw _privateConstructorUsedError;
  @HiveField(12)
  List<CookingMilestone> get milestones => throw _privateConstructorUsedError;

  /// Serializes this CookingStatistics to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CookingStatistics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CookingStatisticsCopyWith<CookingStatistics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CookingStatisticsCopyWith<$Res> {
  factory $CookingStatisticsCopyWith(
          CookingStatistics value, $Res Function(CookingStatistics) then) =
      _$CookingStatisticsCopyWithImpl<$Res, CookingStatistics>;
  @useResult
  $Res call(
      {@HiveField(0) int totalRecipesCooked,
      @HiveField(1) int uniqueRecipesCooked,
      @HiveField(2) int totalCookingTimeMinutes,
      @HiveField(3) int currentStreak,
      @HiveField(4) int longestStreak,
      @HiveField(5) Map<String, int> cuisineFrequency,
      @HiveField(6) Map<String, int> difficultyDistribution,
      @HiveField(7) Map<String, int> cookingMethodFrequency,
      @HiveField(8) Map<String, double> averageRatings,
      @HiveField(9) Map<String, int> monthlyActivity,
      @HiveField(10) DateTime? lastCookingDate,
      @HiveField(11) List<String> favoriteRecipeIds,
      @HiveField(12) List<CookingMilestone> milestones});
}

/// @nodoc
class _$CookingStatisticsCopyWithImpl<$Res, $Val extends CookingStatistics>
    implements $CookingStatisticsCopyWith<$Res> {
  _$CookingStatisticsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CookingStatistics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalRecipesCooked = null,
    Object? uniqueRecipesCooked = null,
    Object? totalCookingTimeMinutes = null,
    Object? currentStreak = null,
    Object? longestStreak = null,
    Object? cuisineFrequency = null,
    Object? difficultyDistribution = null,
    Object? cookingMethodFrequency = null,
    Object? averageRatings = null,
    Object? monthlyActivity = null,
    Object? lastCookingDate = freezed,
    Object? favoriteRecipeIds = null,
    Object? milestones = null,
  }) {
    return _then(_value.copyWith(
      totalRecipesCooked: null == totalRecipesCooked
          ? _value.totalRecipesCooked
          : totalRecipesCooked // ignore: cast_nullable_to_non_nullable
              as int,
      uniqueRecipesCooked: null == uniqueRecipesCooked
          ? _value.uniqueRecipesCooked
          : uniqueRecipesCooked // ignore: cast_nullable_to_non_nullable
              as int,
      totalCookingTimeMinutes: null == totalCookingTimeMinutes
          ? _value.totalCookingTimeMinutes
          : totalCookingTimeMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      currentStreak: null == currentStreak
          ? _value.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      longestStreak: null == longestStreak
          ? _value.longestStreak
          : longestStreak // ignore: cast_nullable_to_non_nullable
              as int,
      cuisineFrequency: null == cuisineFrequency
          ? _value.cuisineFrequency
          : cuisineFrequency // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      difficultyDistribution: null == difficultyDistribution
          ? _value.difficultyDistribution
          : difficultyDistribution // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      cookingMethodFrequency: null == cookingMethodFrequency
          ? _value.cookingMethodFrequency
          : cookingMethodFrequency // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      averageRatings: null == averageRatings
          ? _value.averageRatings
          : averageRatings // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      monthlyActivity: null == monthlyActivity
          ? _value.monthlyActivity
          : monthlyActivity // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      lastCookingDate: freezed == lastCookingDate
          ? _value.lastCookingDate
          : lastCookingDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      favoriteRecipeIds: null == favoriteRecipeIds
          ? _value.favoriteRecipeIds
          : favoriteRecipeIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      milestones: null == milestones
          ? _value.milestones
          : milestones // ignore: cast_nullable_to_non_nullable
              as List<CookingMilestone>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CookingStatisticsImplCopyWith<$Res>
    implements $CookingStatisticsCopyWith<$Res> {
  factory _$$CookingStatisticsImplCopyWith(_$CookingStatisticsImpl value,
          $Res Function(_$CookingStatisticsImpl) then) =
      __$$CookingStatisticsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) int totalRecipesCooked,
      @HiveField(1) int uniqueRecipesCooked,
      @HiveField(2) int totalCookingTimeMinutes,
      @HiveField(3) int currentStreak,
      @HiveField(4) int longestStreak,
      @HiveField(5) Map<String, int> cuisineFrequency,
      @HiveField(6) Map<String, int> difficultyDistribution,
      @HiveField(7) Map<String, int> cookingMethodFrequency,
      @HiveField(8) Map<String, double> averageRatings,
      @HiveField(9) Map<String, int> monthlyActivity,
      @HiveField(10) DateTime? lastCookingDate,
      @HiveField(11) List<String> favoriteRecipeIds,
      @HiveField(12) List<CookingMilestone> milestones});
}

/// @nodoc
class __$$CookingStatisticsImplCopyWithImpl<$Res>
    extends _$CookingStatisticsCopyWithImpl<$Res, _$CookingStatisticsImpl>
    implements _$$CookingStatisticsImplCopyWith<$Res> {
  __$$CookingStatisticsImplCopyWithImpl(_$CookingStatisticsImpl _value,
      $Res Function(_$CookingStatisticsImpl) _then)
      : super(_value, _then);

  /// Create a copy of CookingStatistics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalRecipesCooked = null,
    Object? uniqueRecipesCooked = null,
    Object? totalCookingTimeMinutes = null,
    Object? currentStreak = null,
    Object? longestStreak = null,
    Object? cuisineFrequency = null,
    Object? difficultyDistribution = null,
    Object? cookingMethodFrequency = null,
    Object? averageRatings = null,
    Object? monthlyActivity = null,
    Object? lastCookingDate = freezed,
    Object? favoriteRecipeIds = null,
    Object? milestones = null,
  }) {
    return _then(_$CookingStatisticsImpl(
      totalRecipesCooked: null == totalRecipesCooked
          ? _value.totalRecipesCooked
          : totalRecipesCooked // ignore: cast_nullable_to_non_nullable
              as int,
      uniqueRecipesCooked: null == uniqueRecipesCooked
          ? _value.uniqueRecipesCooked
          : uniqueRecipesCooked // ignore: cast_nullable_to_non_nullable
              as int,
      totalCookingTimeMinutes: null == totalCookingTimeMinutes
          ? _value.totalCookingTimeMinutes
          : totalCookingTimeMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      currentStreak: null == currentStreak
          ? _value.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      longestStreak: null == longestStreak
          ? _value.longestStreak
          : longestStreak // ignore: cast_nullable_to_non_nullable
              as int,
      cuisineFrequency: null == cuisineFrequency
          ? _value._cuisineFrequency
          : cuisineFrequency // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      difficultyDistribution: null == difficultyDistribution
          ? _value._difficultyDistribution
          : difficultyDistribution // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      cookingMethodFrequency: null == cookingMethodFrequency
          ? _value._cookingMethodFrequency
          : cookingMethodFrequency // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      averageRatings: null == averageRatings
          ? _value._averageRatings
          : averageRatings // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      monthlyActivity: null == monthlyActivity
          ? _value._monthlyActivity
          : monthlyActivity // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      lastCookingDate: freezed == lastCookingDate
          ? _value.lastCookingDate
          : lastCookingDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      favoriteRecipeIds: null == favoriteRecipeIds
          ? _value._favoriteRecipeIds
          : favoriteRecipeIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      milestones: null == milestones
          ? _value._milestones
          : milestones // ignore: cast_nullable_to_non_nullable
              as List<CookingMilestone>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CookingStatisticsImpl implements _CookingStatistics {
  const _$CookingStatisticsImpl(
      {@HiveField(0) this.totalRecipesCooked = 0,
      @HiveField(1) this.uniqueRecipesCooked = 0,
      @HiveField(2) this.totalCookingTimeMinutes = 0,
      @HiveField(3) this.currentStreak = 0,
      @HiveField(4) this.longestStreak = 0,
      @HiveField(5) final Map<String, int> cuisineFrequency = const {},
      @HiveField(6) final Map<String, int> difficultyDistribution = const {},
      @HiveField(7) final Map<String, int> cookingMethodFrequency = const {},
      @HiveField(8) final Map<String, double> averageRatings = const {},
      @HiveField(9) final Map<String, int> monthlyActivity = const {},
      @HiveField(10) this.lastCookingDate,
      @HiveField(11) final List<String> favoriteRecipeIds = const [],
      @HiveField(12) final List<CookingMilestone> milestones = const []})
      : _cuisineFrequency = cuisineFrequency,
        _difficultyDistribution = difficultyDistribution,
        _cookingMethodFrequency = cookingMethodFrequency,
        _averageRatings = averageRatings,
        _monthlyActivity = monthlyActivity,
        _favoriteRecipeIds = favoriteRecipeIds,
        _milestones = milestones;

  factory _$CookingStatisticsImpl.fromJson(Map<String, dynamic> json) =>
      _$$CookingStatisticsImplFromJson(json);

  @override
  @JsonKey()
  @HiveField(0)
  final int totalRecipesCooked;
  @override
  @JsonKey()
  @HiveField(1)
  final int uniqueRecipesCooked;
  @override
  @JsonKey()
  @HiveField(2)
  final int totalCookingTimeMinutes;
  @override
  @JsonKey()
  @HiveField(3)
  final int currentStreak;
  @override
  @JsonKey()
  @HiveField(4)
  final int longestStreak;
  final Map<String, int> _cuisineFrequency;
  @override
  @JsonKey()
  @HiveField(5)
  Map<String, int> get cuisineFrequency {
    if (_cuisineFrequency is EqualUnmodifiableMapView) return _cuisineFrequency;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_cuisineFrequency);
  }

  final Map<String, int> _difficultyDistribution;
  @override
  @JsonKey()
  @HiveField(6)
  Map<String, int> get difficultyDistribution {
    if (_difficultyDistribution is EqualUnmodifiableMapView)
      return _difficultyDistribution;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_difficultyDistribution);
  }

  final Map<String, int> _cookingMethodFrequency;
  @override
  @JsonKey()
  @HiveField(7)
  Map<String, int> get cookingMethodFrequency {
    if (_cookingMethodFrequency is EqualUnmodifiableMapView)
      return _cookingMethodFrequency;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_cookingMethodFrequency);
  }

  final Map<String, double> _averageRatings;
  @override
  @JsonKey()
  @HiveField(8)
  Map<String, double> get averageRatings {
    if (_averageRatings is EqualUnmodifiableMapView) return _averageRatings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_averageRatings);
  }

  final Map<String, int> _monthlyActivity;
  @override
  @JsonKey()
  @HiveField(9)
  Map<String, int> get monthlyActivity {
    if (_monthlyActivity is EqualUnmodifiableMapView) return _monthlyActivity;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_monthlyActivity);
  }

  @override
  @HiveField(10)
  final DateTime? lastCookingDate;
  final List<String> _favoriteRecipeIds;
  @override
  @JsonKey()
  @HiveField(11)
  List<String> get favoriteRecipeIds {
    if (_favoriteRecipeIds is EqualUnmodifiableListView)
      return _favoriteRecipeIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_favoriteRecipeIds);
  }

  final List<CookingMilestone> _milestones;
  @override
  @JsonKey()
  @HiveField(12)
  List<CookingMilestone> get milestones {
    if (_milestones is EqualUnmodifiableListView) return _milestones;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_milestones);
  }

  @override
  String toString() {
    return 'CookingStatistics(totalRecipesCooked: $totalRecipesCooked, uniqueRecipesCooked: $uniqueRecipesCooked, totalCookingTimeMinutes: $totalCookingTimeMinutes, currentStreak: $currentStreak, longestStreak: $longestStreak, cuisineFrequency: $cuisineFrequency, difficultyDistribution: $difficultyDistribution, cookingMethodFrequency: $cookingMethodFrequency, averageRatings: $averageRatings, monthlyActivity: $monthlyActivity, lastCookingDate: $lastCookingDate, favoriteRecipeIds: $favoriteRecipeIds, milestones: $milestones)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CookingStatisticsImpl &&
            (identical(other.totalRecipesCooked, totalRecipesCooked) ||
                other.totalRecipesCooked == totalRecipesCooked) &&
            (identical(other.uniqueRecipesCooked, uniqueRecipesCooked) ||
                other.uniqueRecipesCooked == uniqueRecipesCooked) &&
            (identical(
                    other.totalCookingTimeMinutes, totalCookingTimeMinutes) ||
                other.totalCookingTimeMinutes == totalCookingTimeMinutes) &&
            (identical(other.currentStreak, currentStreak) ||
                other.currentStreak == currentStreak) &&
            (identical(other.longestStreak, longestStreak) ||
                other.longestStreak == longestStreak) &&
            const DeepCollectionEquality()
                .equals(other._cuisineFrequency, _cuisineFrequency) &&
            const DeepCollectionEquality().equals(
                other._difficultyDistribution, _difficultyDistribution) &&
            const DeepCollectionEquality().equals(
                other._cookingMethodFrequency, _cookingMethodFrequency) &&
            const DeepCollectionEquality()
                .equals(other._averageRatings, _averageRatings) &&
            const DeepCollectionEquality()
                .equals(other._monthlyActivity, _monthlyActivity) &&
            (identical(other.lastCookingDate, lastCookingDate) ||
                other.lastCookingDate == lastCookingDate) &&
            const DeepCollectionEquality()
                .equals(other._favoriteRecipeIds, _favoriteRecipeIds) &&
            const DeepCollectionEquality()
                .equals(other._milestones, _milestones));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalRecipesCooked,
      uniqueRecipesCooked,
      totalCookingTimeMinutes,
      currentStreak,
      longestStreak,
      const DeepCollectionEquality().hash(_cuisineFrequency),
      const DeepCollectionEquality().hash(_difficultyDistribution),
      const DeepCollectionEquality().hash(_cookingMethodFrequency),
      const DeepCollectionEquality().hash(_averageRatings),
      const DeepCollectionEquality().hash(_monthlyActivity),
      lastCookingDate,
      const DeepCollectionEquality().hash(_favoriteRecipeIds),
      const DeepCollectionEquality().hash(_milestones));

  /// Create a copy of CookingStatistics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CookingStatisticsImplCopyWith<_$CookingStatisticsImpl> get copyWith =>
      __$$CookingStatisticsImplCopyWithImpl<_$CookingStatisticsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CookingStatisticsImplToJson(
      this,
    );
  }
}

abstract class _CookingStatistics implements CookingStatistics {
  const factory _CookingStatistics(
          {@HiveField(0) final int totalRecipesCooked,
          @HiveField(1) final int uniqueRecipesCooked,
          @HiveField(2) final int totalCookingTimeMinutes,
          @HiveField(3) final int currentStreak,
          @HiveField(4) final int longestStreak,
          @HiveField(5) final Map<String, int> cuisineFrequency,
          @HiveField(6) final Map<String, int> difficultyDistribution,
          @HiveField(7) final Map<String, int> cookingMethodFrequency,
          @HiveField(8) final Map<String, double> averageRatings,
          @HiveField(9) final Map<String, int> monthlyActivity,
          @HiveField(10) final DateTime? lastCookingDate,
          @HiveField(11) final List<String> favoriteRecipeIds,
          @HiveField(12) final List<CookingMilestone> milestones}) =
      _$CookingStatisticsImpl;

  factory _CookingStatistics.fromJson(Map<String, dynamic> json) =
      _$CookingStatisticsImpl.fromJson;

  @override
  @HiveField(0)
  int get totalRecipesCooked;
  @override
  @HiveField(1)
  int get uniqueRecipesCooked;
  @override
  @HiveField(2)
  int get totalCookingTimeMinutes;
  @override
  @HiveField(3)
  int get currentStreak;
  @override
  @HiveField(4)
  int get longestStreak;
  @override
  @HiveField(5)
  Map<String, int> get cuisineFrequency;
  @override
  @HiveField(6)
  Map<String, int> get difficultyDistribution;
  @override
  @HiveField(7)
  Map<String, int> get cookingMethodFrequency;
  @override
  @HiveField(8)
  Map<String, double> get averageRatings;
  @override
  @HiveField(9)
  Map<String, int> get monthlyActivity;
  @override
  @HiveField(10)
  DateTime? get lastCookingDate;
  @override
  @HiveField(11)
  List<String> get favoriteRecipeIds;
  @override
  @HiveField(12)
  List<CookingMilestone> get milestones;

  /// Create a copy of CookingStatistics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CookingStatisticsImplCopyWith<_$CookingStatisticsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TasteProfile _$TasteProfileFromJson(Map<String, dynamic> json) {
  return _TasteProfile.fromJson(json);
}

/// @nodoc
mixin _$TasteProfile {
  @HiveField(0)
  Map<String, double> get flavorPreferences =>
      throw _privateConstructorUsedError;
  @HiveField(1)
  Map<String, double> get ingredientFrequency =>
      throw _privateConstructorUsedError;
  @HiveField(2)
  Map<String, double> get cuisinePreferences =>
      throw _privateConstructorUsedError;
  @HiveField(3)
  Map<String, double> get spiceLevelDistribution =>
      throw _privateConstructorUsedError;
  @HiveField(4)
  Map<String, double> get texturePreferences =>
      throw _privateConstructorUsedError;
  @HiveField(5)
  Map<String, double> get cookingTimePreferences =>
      throw _privateConstructorUsedError;
  @HiveField(6)
  List<String> get dislikedIngredients => throw _privateConstructorUsedError;
  @HiveField(7)
  List<String> get allergens => throw _privateConstructorUsedError;
  @HiveField(8)
  Map<String, TrendData> get preferenceTrends =>
      throw _privateConstructorUsedError;
  @HiveField(9)
  DateTime? get lastAnalyzed => throw _privateConstructorUsedError;

  /// Serializes this TasteProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TasteProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TasteProfileCopyWith<TasteProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TasteProfileCopyWith<$Res> {
  factory $TasteProfileCopyWith(
          TasteProfile value, $Res Function(TasteProfile) then) =
      _$TasteProfileCopyWithImpl<$Res, TasteProfile>;
  @useResult
  $Res call(
      {@HiveField(0) Map<String, double> flavorPreferences,
      @HiveField(1) Map<String, double> ingredientFrequency,
      @HiveField(2) Map<String, double> cuisinePreferences,
      @HiveField(3) Map<String, double> spiceLevelDistribution,
      @HiveField(4) Map<String, double> texturePreferences,
      @HiveField(5) Map<String, double> cookingTimePreferences,
      @HiveField(6) List<String> dislikedIngredients,
      @HiveField(7) List<String> allergens,
      @HiveField(8) Map<String, TrendData> preferenceTrends,
      @HiveField(9) DateTime? lastAnalyzed});
}

/// @nodoc
class _$TasteProfileCopyWithImpl<$Res, $Val extends TasteProfile>
    implements $TasteProfileCopyWith<$Res> {
  _$TasteProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TasteProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? flavorPreferences = null,
    Object? ingredientFrequency = null,
    Object? cuisinePreferences = null,
    Object? spiceLevelDistribution = null,
    Object? texturePreferences = null,
    Object? cookingTimePreferences = null,
    Object? dislikedIngredients = null,
    Object? allergens = null,
    Object? preferenceTrends = null,
    Object? lastAnalyzed = freezed,
  }) {
    return _then(_value.copyWith(
      flavorPreferences: null == flavorPreferences
          ? _value.flavorPreferences
          : flavorPreferences // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      ingredientFrequency: null == ingredientFrequency
          ? _value.ingredientFrequency
          : ingredientFrequency // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      cuisinePreferences: null == cuisinePreferences
          ? _value.cuisinePreferences
          : cuisinePreferences // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      spiceLevelDistribution: null == spiceLevelDistribution
          ? _value.spiceLevelDistribution
          : spiceLevelDistribution // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      texturePreferences: null == texturePreferences
          ? _value.texturePreferences
          : texturePreferences // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      cookingTimePreferences: null == cookingTimePreferences
          ? _value.cookingTimePreferences
          : cookingTimePreferences // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      dislikedIngredients: null == dislikedIngredients
          ? _value.dislikedIngredients
          : dislikedIngredients // ignore: cast_nullable_to_non_nullable
              as List<String>,
      allergens: null == allergens
          ? _value.allergens
          : allergens // ignore: cast_nullable_to_non_nullable
              as List<String>,
      preferenceTrends: null == preferenceTrends
          ? _value.preferenceTrends
          : preferenceTrends // ignore: cast_nullable_to_non_nullable
              as Map<String, TrendData>,
      lastAnalyzed: freezed == lastAnalyzed
          ? _value.lastAnalyzed
          : lastAnalyzed // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TasteProfileImplCopyWith<$Res>
    implements $TasteProfileCopyWith<$Res> {
  factory _$$TasteProfileImplCopyWith(
          _$TasteProfileImpl value, $Res Function(_$TasteProfileImpl) then) =
      __$$TasteProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) Map<String, double> flavorPreferences,
      @HiveField(1) Map<String, double> ingredientFrequency,
      @HiveField(2) Map<String, double> cuisinePreferences,
      @HiveField(3) Map<String, double> spiceLevelDistribution,
      @HiveField(4) Map<String, double> texturePreferences,
      @HiveField(5) Map<String, double> cookingTimePreferences,
      @HiveField(6) List<String> dislikedIngredients,
      @HiveField(7) List<String> allergens,
      @HiveField(8) Map<String, TrendData> preferenceTrends,
      @HiveField(9) DateTime? lastAnalyzed});
}

/// @nodoc
class __$$TasteProfileImplCopyWithImpl<$Res>
    extends _$TasteProfileCopyWithImpl<$Res, _$TasteProfileImpl>
    implements _$$TasteProfileImplCopyWith<$Res> {
  __$$TasteProfileImplCopyWithImpl(
      _$TasteProfileImpl _value, $Res Function(_$TasteProfileImpl) _then)
      : super(_value, _then);

  /// Create a copy of TasteProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? flavorPreferences = null,
    Object? ingredientFrequency = null,
    Object? cuisinePreferences = null,
    Object? spiceLevelDistribution = null,
    Object? texturePreferences = null,
    Object? cookingTimePreferences = null,
    Object? dislikedIngredients = null,
    Object? allergens = null,
    Object? preferenceTrends = null,
    Object? lastAnalyzed = freezed,
  }) {
    return _then(_$TasteProfileImpl(
      flavorPreferences: null == flavorPreferences
          ? _value._flavorPreferences
          : flavorPreferences // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      ingredientFrequency: null == ingredientFrequency
          ? _value._ingredientFrequency
          : ingredientFrequency // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      cuisinePreferences: null == cuisinePreferences
          ? _value._cuisinePreferences
          : cuisinePreferences // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      spiceLevelDistribution: null == spiceLevelDistribution
          ? _value._spiceLevelDistribution
          : spiceLevelDistribution // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      texturePreferences: null == texturePreferences
          ? _value._texturePreferences
          : texturePreferences // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      cookingTimePreferences: null == cookingTimePreferences
          ? _value._cookingTimePreferences
          : cookingTimePreferences // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      dislikedIngredients: null == dislikedIngredients
          ? _value._dislikedIngredients
          : dislikedIngredients // ignore: cast_nullable_to_non_nullable
              as List<String>,
      allergens: null == allergens
          ? _value._allergens
          : allergens // ignore: cast_nullable_to_non_nullable
              as List<String>,
      preferenceTrends: null == preferenceTrends
          ? _value._preferenceTrends
          : preferenceTrends // ignore: cast_nullable_to_non_nullable
              as Map<String, TrendData>,
      lastAnalyzed: freezed == lastAnalyzed
          ? _value.lastAnalyzed
          : lastAnalyzed // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TasteProfileImpl implements _TasteProfile {
  const _$TasteProfileImpl(
      {@HiveField(0) final Map<String, double> flavorPreferences = const {},
      @HiveField(1) final Map<String, double> ingredientFrequency = const {},
      @HiveField(2) final Map<String, double> cuisinePreferences = const {},
      @HiveField(3) final Map<String, double> spiceLevelDistribution = const {},
      @HiveField(4) final Map<String, double> texturePreferences = const {},
      @HiveField(5) final Map<String, double> cookingTimePreferences = const {},
      @HiveField(6) final List<String> dislikedIngredients = const [],
      @HiveField(7) final List<String> allergens = const [],
      @HiveField(8) final Map<String, TrendData> preferenceTrends = const {},
      @HiveField(9) this.lastAnalyzed})
      : _flavorPreferences = flavorPreferences,
        _ingredientFrequency = ingredientFrequency,
        _cuisinePreferences = cuisinePreferences,
        _spiceLevelDistribution = spiceLevelDistribution,
        _texturePreferences = texturePreferences,
        _cookingTimePreferences = cookingTimePreferences,
        _dislikedIngredients = dislikedIngredients,
        _allergens = allergens,
        _preferenceTrends = preferenceTrends;

  factory _$TasteProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$TasteProfileImplFromJson(json);

  final Map<String, double> _flavorPreferences;
  @override
  @JsonKey()
  @HiveField(0)
  Map<String, double> get flavorPreferences {
    if (_flavorPreferences is EqualUnmodifiableMapView)
      return _flavorPreferences;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_flavorPreferences);
  }

  final Map<String, double> _ingredientFrequency;
  @override
  @JsonKey()
  @HiveField(1)
  Map<String, double> get ingredientFrequency {
    if (_ingredientFrequency is EqualUnmodifiableMapView)
      return _ingredientFrequency;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_ingredientFrequency);
  }

  final Map<String, double> _cuisinePreferences;
  @override
  @JsonKey()
  @HiveField(2)
  Map<String, double> get cuisinePreferences {
    if (_cuisinePreferences is EqualUnmodifiableMapView)
      return _cuisinePreferences;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_cuisinePreferences);
  }

  final Map<String, double> _spiceLevelDistribution;
  @override
  @JsonKey()
  @HiveField(3)
  Map<String, double> get spiceLevelDistribution {
    if (_spiceLevelDistribution is EqualUnmodifiableMapView)
      return _spiceLevelDistribution;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_spiceLevelDistribution);
  }

  final Map<String, double> _texturePreferences;
  @override
  @JsonKey()
  @HiveField(4)
  Map<String, double> get texturePreferences {
    if (_texturePreferences is EqualUnmodifiableMapView)
      return _texturePreferences;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_texturePreferences);
  }

  final Map<String, double> _cookingTimePreferences;
  @override
  @JsonKey()
  @HiveField(5)
  Map<String, double> get cookingTimePreferences {
    if (_cookingTimePreferences is EqualUnmodifiableMapView)
      return _cookingTimePreferences;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_cookingTimePreferences);
  }

  final List<String> _dislikedIngredients;
  @override
  @JsonKey()
  @HiveField(6)
  List<String> get dislikedIngredients {
    if (_dislikedIngredients is EqualUnmodifiableListView)
      return _dislikedIngredients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dislikedIngredients);
  }

  final List<String> _allergens;
  @override
  @JsonKey()
  @HiveField(7)
  List<String> get allergens {
    if (_allergens is EqualUnmodifiableListView) return _allergens;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allergens);
  }

  final Map<String, TrendData> _preferenceTrends;
  @override
  @JsonKey()
  @HiveField(8)
  Map<String, TrendData> get preferenceTrends {
    if (_preferenceTrends is EqualUnmodifiableMapView) return _preferenceTrends;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_preferenceTrends);
  }

  @override
  @HiveField(9)
  final DateTime? lastAnalyzed;

  @override
  String toString() {
    return 'TasteProfile(flavorPreferences: $flavorPreferences, ingredientFrequency: $ingredientFrequency, cuisinePreferences: $cuisinePreferences, spiceLevelDistribution: $spiceLevelDistribution, texturePreferences: $texturePreferences, cookingTimePreferences: $cookingTimePreferences, dislikedIngredients: $dislikedIngredients, allergens: $allergens, preferenceTrends: $preferenceTrends, lastAnalyzed: $lastAnalyzed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TasteProfileImpl &&
            const DeepCollectionEquality()
                .equals(other._flavorPreferences, _flavorPreferences) &&
            const DeepCollectionEquality()
                .equals(other._ingredientFrequency, _ingredientFrequency) &&
            const DeepCollectionEquality()
                .equals(other._cuisinePreferences, _cuisinePreferences) &&
            const DeepCollectionEquality().equals(
                other._spiceLevelDistribution, _spiceLevelDistribution) &&
            const DeepCollectionEquality()
                .equals(other._texturePreferences, _texturePreferences) &&
            const DeepCollectionEquality().equals(
                other._cookingTimePreferences, _cookingTimePreferences) &&
            const DeepCollectionEquality()
                .equals(other._dislikedIngredients, _dislikedIngredients) &&
            const DeepCollectionEquality()
                .equals(other._allergens, _allergens) &&
            const DeepCollectionEquality()
                .equals(other._preferenceTrends, _preferenceTrends) &&
            (identical(other.lastAnalyzed, lastAnalyzed) ||
                other.lastAnalyzed == lastAnalyzed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_flavorPreferences),
      const DeepCollectionEquality().hash(_ingredientFrequency),
      const DeepCollectionEquality().hash(_cuisinePreferences),
      const DeepCollectionEquality().hash(_spiceLevelDistribution),
      const DeepCollectionEquality().hash(_texturePreferences),
      const DeepCollectionEquality().hash(_cookingTimePreferences),
      const DeepCollectionEquality().hash(_dislikedIngredients),
      const DeepCollectionEquality().hash(_allergens),
      const DeepCollectionEquality().hash(_preferenceTrends),
      lastAnalyzed);

  /// Create a copy of TasteProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TasteProfileImplCopyWith<_$TasteProfileImpl> get copyWith =>
      __$$TasteProfileImplCopyWithImpl<_$TasteProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TasteProfileImplToJson(
      this,
    );
  }
}

abstract class _TasteProfile implements TasteProfile {
  const factory _TasteProfile(
      {@HiveField(0) final Map<String, double> flavorPreferences,
      @HiveField(1) final Map<String, double> ingredientFrequency,
      @HiveField(2) final Map<String, double> cuisinePreferences,
      @HiveField(3) final Map<String, double> spiceLevelDistribution,
      @HiveField(4) final Map<String, double> texturePreferences,
      @HiveField(5) final Map<String, double> cookingTimePreferences,
      @HiveField(6) final List<String> dislikedIngredients,
      @HiveField(7) final List<String> allergens,
      @HiveField(8) final Map<String, TrendData> preferenceTrends,
      @HiveField(9) final DateTime? lastAnalyzed}) = _$TasteProfileImpl;

  factory _TasteProfile.fromJson(Map<String, dynamic> json) =
      _$TasteProfileImpl.fromJson;

  @override
  @HiveField(0)
  Map<String, double> get flavorPreferences;
  @override
  @HiveField(1)
  Map<String, double> get ingredientFrequency;
  @override
  @HiveField(2)
  Map<String, double> get cuisinePreferences;
  @override
  @HiveField(3)
  Map<String, double> get spiceLevelDistribution;
  @override
  @HiveField(4)
  Map<String, double> get texturePreferences;
  @override
  @HiveField(5)
  Map<String, double> get cookingTimePreferences;
  @override
  @HiveField(6)
  List<String> get dislikedIngredients;
  @override
  @HiveField(7)
  List<String> get allergens;
  @override
  @HiveField(8)
  Map<String, TrendData> get preferenceTrends;
  @override
  @HiveField(9)
  DateTime? get lastAnalyzed;

  /// Create a copy of TasteProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TasteProfileImplCopyWith<_$TasteProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EfficiencyMetrics _$EfficiencyMetricsFromJson(Map<String, dynamic> json) {
  return _EfficiencyMetrics.fromJson(json);
}

/// @nodoc
mixin _$EfficiencyMetrics {
  @HiveField(0)
  double get averageCookingTime => throw _privateConstructorUsedError;
  @HiveField(1)
  double get averagePrepTime => throw _privateConstructorUsedError;
  @HiveField(2)
  double get successRate => throw _privateConstructorUsedError;
  @HiveField(3)
  double get recipeCompletionRate => throw _privateConstructorUsedError;
  @HiveField(4)
  double get ingredientUtilizationRate => throw _privateConstructorUsedError;
  @HiveField(5)
  double get mealPlanAdherence => throw _privateConstructorUsedError;
  @HiveField(6)
  double get foodWasteReduction => throw _privateConstructorUsedError;
  @HiveField(7)
  Map<String, double> get skillProgression =>
      throw _privateConstructorUsedError;
  @HiveField(8)
  Map<String, int> get equipmentUsage => throw _privateConstructorUsedError;
  @HiveField(9)
  List<EfficiencyTip> get recommendations => throw _privateConstructorUsedError;

  /// Serializes this EfficiencyMetrics to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EfficiencyMetrics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EfficiencyMetricsCopyWith<EfficiencyMetrics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EfficiencyMetricsCopyWith<$Res> {
  factory $EfficiencyMetricsCopyWith(
          EfficiencyMetrics value, $Res Function(EfficiencyMetrics) then) =
      _$EfficiencyMetricsCopyWithImpl<$Res, EfficiencyMetrics>;
  @useResult
  $Res call(
      {@HiveField(0) double averageCookingTime,
      @HiveField(1) double averagePrepTime,
      @HiveField(2) double successRate,
      @HiveField(3) double recipeCompletionRate,
      @HiveField(4) double ingredientUtilizationRate,
      @HiveField(5) double mealPlanAdherence,
      @HiveField(6) double foodWasteReduction,
      @HiveField(7) Map<String, double> skillProgression,
      @HiveField(8) Map<String, int> equipmentUsage,
      @HiveField(9) List<EfficiencyTip> recommendations});
}

/// @nodoc
class _$EfficiencyMetricsCopyWithImpl<$Res, $Val extends EfficiencyMetrics>
    implements $EfficiencyMetricsCopyWith<$Res> {
  _$EfficiencyMetricsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EfficiencyMetrics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? averageCookingTime = null,
    Object? averagePrepTime = null,
    Object? successRate = null,
    Object? recipeCompletionRate = null,
    Object? ingredientUtilizationRate = null,
    Object? mealPlanAdherence = null,
    Object? foodWasteReduction = null,
    Object? skillProgression = null,
    Object? equipmentUsage = null,
    Object? recommendations = null,
  }) {
    return _then(_value.copyWith(
      averageCookingTime: null == averageCookingTime
          ? _value.averageCookingTime
          : averageCookingTime // ignore: cast_nullable_to_non_nullable
              as double,
      averagePrepTime: null == averagePrepTime
          ? _value.averagePrepTime
          : averagePrepTime // ignore: cast_nullable_to_non_nullable
              as double,
      successRate: null == successRate
          ? _value.successRate
          : successRate // ignore: cast_nullable_to_non_nullable
              as double,
      recipeCompletionRate: null == recipeCompletionRate
          ? _value.recipeCompletionRate
          : recipeCompletionRate // ignore: cast_nullable_to_non_nullable
              as double,
      ingredientUtilizationRate: null == ingredientUtilizationRate
          ? _value.ingredientUtilizationRate
          : ingredientUtilizationRate // ignore: cast_nullable_to_non_nullable
              as double,
      mealPlanAdherence: null == mealPlanAdherence
          ? _value.mealPlanAdherence
          : mealPlanAdherence // ignore: cast_nullable_to_non_nullable
              as double,
      foodWasteReduction: null == foodWasteReduction
          ? _value.foodWasteReduction
          : foodWasteReduction // ignore: cast_nullable_to_non_nullable
              as double,
      skillProgression: null == skillProgression
          ? _value.skillProgression
          : skillProgression // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      equipmentUsage: null == equipmentUsage
          ? _value.equipmentUsage
          : equipmentUsage // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      recommendations: null == recommendations
          ? _value.recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<EfficiencyTip>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EfficiencyMetricsImplCopyWith<$Res>
    implements $EfficiencyMetricsCopyWith<$Res> {
  factory _$$EfficiencyMetricsImplCopyWith(_$EfficiencyMetricsImpl value,
          $Res Function(_$EfficiencyMetricsImpl) then) =
      __$$EfficiencyMetricsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) double averageCookingTime,
      @HiveField(1) double averagePrepTime,
      @HiveField(2) double successRate,
      @HiveField(3) double recipeCompletionRate,
      @HiveField(4) double ingredientUtilizationRate,
      @HiveField(5) double mealPlanAdherence,
      @HiveField(6) double foodWasteReduction,
      @HiveField(7) Map<String, double> skillProgression,
      @HiveField(8) Map<String, int> equipmentUsage,
      @HiveField(9) List<EfficiencyTip> recommendations});
}

/// @nodoc
class __$$EfficiencyMetricsImplCopyWithImpl<$Res>
    extends _$EfficiencyMetricsCopyWithImpl<$Res, _$EfficiencyMetricsImpl>
    implements _$$EfficiencyMetricsImplCopyWith<$Res> {
  __$$EfficiencyMetricsImplCopyWithImpl(_$EfficiencyMetricsImpl _value,
      $Res Function(_$EfficiencyMetricsImpl) _then)
      : super(_value, _then);

  /// Create a copy of EfficiencyMetrics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? averageCookingTime = null,
    Object? averagePrepTime = null,
    Object? successRate = null,
    Object? recipeCompletionRate = null,
    Object? ingredientUtilizationRate = null,
    Object? mealPlanAdherence = null,
    Object? foodWasteReduction = null,
    Object? skillProgression = null,
    Object? equipmentUsage = null,
    Object? recommendations = null,
  }) {
    return _then(_$EfficiencyMetricsImpl(
      averageCookingTime: null == averageCookingTime
          ? _value.averageCookingTime
          : averageCookingTime // ignore: cast_nullable_to_non_nullable
              as double,
      averagePrepTime: null == averagePrepTime
          ? _value.averagePrepTime
          : averagePrepTime // ignore: cast_nullable_to_non_nullable
              as double,
      successRate: null == successRate
          ? _value.successRate
          : successRate // ignore: cast_nullable_to_non_nullable
              as double,
      recipeCompletionRate: null == recipeCompletionRate
          ? _value.recipeCompletionRate
          : recipeCompletionRate // ignore: cast_nullable_to_non_nullable
              as double,
      ingredientUtilizationRate: null == ingredientUtilizationRate
          ? _value.ingredientUtilizationRate
          : ingredientUtilizationRate // ignore: cast_nullable_to_non_nullable
              as double,
      mealPlanAdherence: null == mealPlanAdherence
          ? _value.mealPlanAdherence
          : mealPlanAdherence // ignore: cast_nullable_to_non_nullable
              as double,
      foodWasteReduction: null == foodWasteReduction
          ? _value.foodWasteReduction
          : foodWasteReduction // ignore: cast_nullable_to_non_nullable
              as double,
      skillProgression: null == skillProgression
          ? _value._skillProgression
          : skillProgression // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      equipmentUsage: null == equipmentUsage
          ? _value._equipmentUsage
          : equipmentUsage // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      recommendations: null == recommendations
          ? _value._recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<EfficiencyTip>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EfficiencyMetricsImpl implements _EfficiencyMetrics {
  const _$EfficiencyMetricsImpl(
      {@HiveField(0) this.averageCookingTime = 0.0,
      @HiveField(1) this.averagePrepTime = 0.0,
      @HiveField(2) this.successRate = 0.0,
      @HiveField(3) this.recipeCompletionRate = 0.0,
      @HiveField(4) this.ingredientUtilizationRate = 0.0,
      @HiveField(5) this.mealPlanAdherence = 0.0,
      @HiveField(6) this.foodWasteReduction = 0.0,
      @HiveField(7) final Map<String, double> skillProgression = const {},
      @HiveField(8) final Map<String, int> equipmentUsage = const {},
      @HiveField(9) final List<EfficiencyTip> recommendations = const []})
      : _skillProgression = skillProgression,
        _equipmentUsage = equipmentUsage,
        _recommendations = recommendations;

  factory _$EfficiencyMetricsImpl.fromJson(Map<String, dynamic> json) =>
      _$$EfficiencyMetricsImplFromJson(json);

  @override
  @JsonKey()
  @HiveField(0)
  final double averageCookingTime;
  @override
  @JsonKey()
  @HiveField(1)
  final double averagePrepTime;
  @override
  @JsonKey()
  @HiveField(2)
  final double successRate;
  @override
  @JsonKey()
  @HiveField(3)
  final double recipeCompletionRate;
  @override
  @JsonKey()
  @HiveField(4)
  final double ingredientUtilizationRate;
  @override
  @JsonKey()
  @HiveField(5)
  final double mealPlanAdherence;
  @override
  @JsonKey()
  @HiveField(6)
  final double foodWasteReduction;
  final Map<String, double> _skillProgression;
  @override
  @JsonKey()
  @HiveField(7)
  Map<String, double> get skillProgression {
    if (_skillProgression is EqualUnmodifiableMapView) return _skillProgression;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_skillProgression);
  }

  final Map<String, int> _equipmentUsage;
  @override
  @JsonKey()
  @HiveField(8)
  Map<String, int> get equipmentUsage {
    if (_equipmentUsage is EqualUnmodifiableMapView) return _equipmentUsage;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_equipmentUsage);
  }

  final List<EfficiencyTip> _recommendations;
  @override
  @JsonKey()
  @HiveField(9)
  List<EfficiencyTip> get recommendations {
    if (_recommendations is EqualUnmodifiableListView) return _recommendations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recommendations);
  }

  @override
  String toString() {
    return 'EfficiencyMetrics(averageCookingTime: $averageCookingTime, averagePrepTime: $averagePrepTime, successRate: $successRate, recipeCompletionRate: $recipeCompletionRate, ingredientUtilizationRate: $ingredientUtilizationRate, mealPlanAdherence: $mealPlanAdherence, foodWasteReduction: $foodWasteReduction, skillProgression: $skillProgression, equipmentUsage: $equipmentUsage, recommendations: $recommendations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EfficiencyMetricsImpl &&
            (identical(other.averageCookingTime, averageCookingTime) ||
                other.averageCookingTime == averageCookingTime) &&
            (identical(other.averagePrepTime, averagePrepTime) ||
                other.averagePrepTime == averagePrepTime) &&
            (identical(other.successRate, successRate) ||
                other.successRate == successRate) &&
            (identical(other.recipeCompletionRate, recipeCompletionRate) ||
                other.recipeCompletionRate == recipeCompletionRate) &&
            (identical(other.ingredientUtilizationRate,
                    ingredientUtilizationRate) ||
                other.ingredientUtilizationRate == ingredientUtilizationRate) &&
            (identical(other.mealPlanAdherence, mealPlanAdherence) ||
                other.mealPlanAdherence == mealPlanAdherence) &&
            (identical(other.foodWasteReduction, foodWasteReduction) ||
                other.foodWasteReduction == foodWasteReduction) &&
            const DeepCollectionEquality()
                .equals(other._skillProgression, _skillProgression) &&
            const DeepCollectionEquality()
                .equals(other._equipmentUsage, _equipmentUsage) &&
            const DeepCollectionEquality()
                .equals(other._recommendations, _recommendations));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      averageCookingTime,
      averagePrepTime,
      successRate,
      recipeCompletionRate,
      ingredientUtilizationRate,
      mealPlanAdherence,
      foodWasteReduction,
      const DeepCollectionEquality().hash(_skillProgression),
      const DeepCollectionEquality().hash(_equipmentUsage),
      const DeepCollectionEquality().hash(_recommendations));

  /// Create a copy of EfficiencyMetrics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EfficiencyMetricsImplCopyWith<_$EfficiencyMetricsImpl> get copyWith =>
      __$$EfficiencyMetricsImplCopyWithImpl<_$EfficiencyMetricsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EfficiencyMetricsImplToJson(
      this,
    );
  }
}

abstract class _EfficiencyMetrics implements EfficiencyMetrics {
  const factory _EfficiencyMetrics(
          {@HiveField(0) final double averageCookingTime,
          @HiveField(1) final double averagePrepTime,
          @HiveField(2) final double successRate,
          @HiveField(3) final double recipeCompletionRate,
          @HiveField(4) final double ingredientUtilizationRate,
          @HiveField(5) final double mealPlanAdherence,
          @HiveField(6) final double foodWasteReduction,
          @HiveField(7) final Map<String, double> skillProgression,
          @HiveField(8) final Map<String, int> equipmentUsage,
          @HiveField(9) final List<EfficiencyTip> recommendations}) =
      _$EfficiencyMetricsImpl;

  factory _EfficiencyMetrics.fromJson(Map<String, dynamic> json) =
      _$EfficiencyMetricsImpl.fromJson;

  @override
  @HiveField(0)
  double get averageCookingTime;
  @override
  @HiveField(1)
  double get averagePrepTime;
  @override
  @HiveField(2)
  double get successRate;
  @override
  @HiveField(3)
  double get recipeCompletionRate;
  @override
  @HiveField(4)
  double get ingredientUtilizationRate;
  @override
  @HiveField(5)
  double get mealPlanAdherence;
  @override
  @HiveField(6)
  double get foodWasteReduction;
  @override
  @HiveField(7)
  Map<String, double> get skillProgression;
  @override
  @HiveField(8)
  Map<String, int> get equipmentUsage;
  @override
  @HiveField(9)
  List<EfficiencyTip> get recommendations;

  /// Create a copy of EfficiencyMetrics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EfficiencyMetricsImplCopyWith<_$EfficiencyMetricsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CostAnalysis _$CostAnalysisFromJson(Map<String, dynamic> json) {
  return _CostAnalysis.fromJson(json);
}

/// @nodoc
mixin _$CostAnalysis {
  @HiveField(0)
  double get totalSpent => throw _privateConstructorUsedError;
  @HiveField(1)
  double get averageMealCost => throw _privateConstructorUsedError;
  @HiveField(2)
  double get averageIngredientCost => throw _privateConstructorUsedError;
  @HiveField(3)
  Map<String, double> get monthlySpending => throw _privateConstructorUsedError;
  @HiveField(4)
  Map<String, double> get categorySpending =>
      throw _privateConstructorUsedError;
  @HiveField(5)
  Map<String, double> get costPerCuisine => throw _privateConstructorUsedError;
  @HiveField(6)
  double get budgetAdherence => throw _privateConstructorUsedError;
  @HiveField(7)
  double get savingsFromMealPlanning => throw _privateConstructorUsedError;
  @HiveField(8)
  List<CostSavingTip> get savingsTips => throw _privateConstructorUsedError;
  @HiveField(9)
  Map<String, PriceHistory> get priceHistory =>
      throw _privateConstructorUsedError;

  /// Serializes this CostAnalysis to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CostAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CostAnalysisCopyWith<CostAnalysis> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CostAnalysisCopyWith<$Res> {
  factory $CostAnalysisCopyWith(
          CostAnalysis value, $Res Function(CostAnalysis) then) =
      _$CostAnalysisCopyWithImpl<$Res, CostAnalysis>;
  @useResult
  $Res call(
      {@HiveField(0) double totalSpent,
      @HiveField(1) double averageMealCost,
      @HiveField(2) double averageIngredientCost,
      @HiveField(3) Map<String, double> monthlySpending,
      @HiveField(4) Map<String, double> categorySpending,
      @HiveField(5) Map<String, double> costPerCuisine,
      @HiveField(6) double budgetAdherence,
      @HiveField(7) double savingsFromMealPlanning,
      @HiveField(8) List<CostSavingTip> savingsTips,
      @HiveField(9) Map<String, PriceHistory> priceHistory});
}

/// @nodoc
class _$CostAnalysisCopyWithImpl<$Res, $Val extends CostAnalysis>
    implements $CostAnalysisCopyWith<$Res> {
  _$CostAnalysisCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CostAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalSpent = null,
    Object? averageMealCost = null,
    Object? averageIngredientCost = null,
    Object? monthlySpending = null,
    Object? categorySpending = null,
    Object? costPerCuisine = null,
    Object? budgetAdherence = null,
    Object? savingsFromMealPlanning = null,
    Object? savingsTips = null,
    Object? priceHistory = null,
  }) {
    return _then(_value.copyWith(
      totalSpent: null == totalSpent
          ? _value.totalSpent
          : totalSpent // ignore: cast_nullable_to_non_nullable
              as double,
      averageMealCost: null == averageMealCost
          ? _value.averageMealCost
          : averageMealCost // ignore: cast_nullable_to_non_nullable
              as double,
      averageIngredientCost: null == averageIngredientCost
          ? _value.averageIngredientCost
          : averageIngredientCost // ignore: cast_nullable_to_non_nullable
              as double,
      monthlySpending: null == monthlySpending
          ? _value.monthlySpending
          : monthlySpending // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      categorySpending: null == categorySpending
          ? _value.categorySpending
          : categorySpending // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      costPerCuisine: null == costPerCuisine
          ? _value.costPerCuisine
          : costPerCuisine // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      budgetAdherence: null == budgetAdherence
          ? _value.budgetAdherence
          : budgetAdherence // ignore: cast_nullable_to_non_nullable
              as double,
      savingsFromMealPlanning: null == savingsFromMealPlanning
          ? _value.savingsFromMealPlanning
          : savingsFromMealPlanning // ignore: cast_nullable_to_non_nullable
              as double,
      savingsTips: null == savingsTips
          ? _value.savingsTips
          : savingsTips // ignore: cast_nullable_to_non_nullable
              as List<CostSavingTip>,
      priceHistory: null == priceHistory
          ? _value.priceHistory
          : priceHistory // ignore: cast_nullable_to_non_nullable
              as Map<String, PriceHistory>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CostAnalysisImplCopyWith<$Res>
    implements $CostAnalysisCopyWith<$Res> {
  factory _$$CostAnalysisImplCopyWith(
          _$CostAnalysisImpl value, $Res Function(_$CostAnalysisImpl) then) =
      __$$CostAnalysisImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) double totalSpent,
      @HiveField(1) double averageMealCost,
      @HiveField(2) double averageIngredientCost,
      @HiveField(3) Map<String, double> monthlySpending,
      @HiveField(4) Map<String, double> categorySpending,
      @HiveField(5) Map<String, double> costPerCuisine,
      @HiveField(6) double budgetAdherence,
      @HiveField(7) double savingsFromMealPlanning,
      @HiveField(8) List<CostSavingTip> savingsTips,
      @HiveField(9) Map<String, PriceHistory> priceHistory});
}

/// @nodoc
class __$$CostAnalysisImplCopyWithImpl<$Res>
    extends _$CostAnalysisCopyWithImpl<$Res, _$CostAnalysisImpl>
    implements _$$CostAnalysisImplCopyWith<$Res> {
  __$$CostAnalysisImplCopyWithImpl(
      _$CostAnalysisImpl _value, $Res Function(_$CostAnalysisImpl) _then)
      : super(_value, _then);

  /// Create a copy of CostAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalSpent = null,
    Object? averageMealCost = null,
    Object? averageIngredientCost = null,
    Object? monthlySpending = null,
    Object? categorySpending = null,
    Object? costPerCuisine = null,
    Object? budgetAdherence = null,
    Object? savingsFromMealPlanning = null,
    Object? savingsTips = null,
    Object? priceHistory = null,
  }) {
    return _then(_$CostAnalysisImpl(
      totalSpent: null == totalSpent
          ? _value.totalSpent
          : totalSpent // ignore: cast_nullable_to_non_nullable
              as double,
      averageMealCost: null == averageMealCost
          ? _value.averageMealCost
          : averageMealCost // ignore: cast_nullable_to_non_nullable
              as double,
      averageIngredientCost: null == averageIngredientCost
          ? _value.averageIngredientCost
          : averageIngredientCost // ignore: cast_nullable_to_non_nullable
              as double,
      monthlySpending: null == monthlySpending
          ? _value._monthlySpending
          : monthlySpending // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      categorySpending: null == categorySpending
          ? _value._categorySpending
          : categorySpending // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      costPerCuisine: null == costPerCuisine
          ? _value._costPerCuisine
          : costPerCuisine // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      budgetAdherence: null == budgetAdherence
          ? _value.budgetAdherence
          : budgetAdherence // ignore: cast_nullable_to_non_nullable
              as double,
      savingsFromMealPlanning: null == savingsFromMealPlanning
          ? _value.savingsFromMealPlanning
          : savingsFromMealPlanning // ignore: cast_nullable_to_non_nullable
              as double,
      savingsTips: null == savingsTips
          ? _value._savingsTips
          : savingsTips // ignore: cast_nullable_to_non_nullable
              as List<CostSavingTip>,
      priceHistory: null == priceHistory
          ? _value._priceHistory
          : priceHistory // ignore: cast_nullable_to_non_nullable
              as Map<String, PriceHistory>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CostAnalysisImpl implements _CostAnalysis {
  const _$CostAnalysisImpl(
      {@HiveField(0) this.totalSpent = 0.0,
      @HiveField(1) this.averageMealCost = 0.0,
      @HiveField(2) this.averageIngredientCost = 0.0,
      @HiveField(3) final Map<String, double> monthlySpending = const {},
      @HiveField(4) final Map<String, double> categorySpending = const {},
      @HiveField(5) final Map<String, double> costPerCuisine = const {},
      @HiveField(6) this.budgetAdherence = 0.0,
      @HiveField(7) this.savingsFromMealPlanning = 0.0,
      @HiveField(8) final List<CostSavingTip> savingsTips = const [],
      @HiveField(9) final Map<String, PriceHistory> priceHistory = const {}})
      : _monthlySpending = monthlySpending,
        _categorySpending = categorySpending,
        _costPerCuisine = costPerCuisine,
        _savingsTips = savingsTips,
        _priceHistory = priceHistory;

  factory _$CostAnalysisImpl.fromJson(Map<String, dynamic> json) =>
      _$$CostAnalysisImplFromJson(json);

  @override
  @JsonKey()
  @HiveField(0)
  final double totalSpent;
  @override
  @JsonKey()
  @HiveField(1)
  final double averageMealCost;
  @override
  @JsonKey()
  @HiveField(2)
  final double averageIngredientCost;
  final Map<String, double> _monthlySpending;
  @override
  @JsonKey()
  @HiveField(3)
  Map<String, double> get monthlySpending {
    if (_monthlySpending is EqualUnmodifiableMapView) return _monthlySpending;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_monthlySpending);
  }

  final Map<String, double> _categorySpending;
  @override
  @JsonKey()
  @HiveField(4)
  Map<String, double> get categorySpending {
    if (_categorySpending is EqualUnmodifiableMapView) return _categorySpending;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_categorySpending);
  }

  final Map<String, double> _costPerCuisine;
  @override
  @JsonKey()
  @HiveField(5)
  Map<String, double> get costPerCuisine {
    if (_costPerCuisine is EqualUnmodifiableMapView) return _costPerCuisine;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_costPerCuisine);
  }

  @override
  @JsonKey()
  @HiveField(6)
  final double budgetAdherence;
  @override
  @JsonKey()
  @HiveField(7)
  final double savingsFromMealPlanning;
  final List<CostSavingTip> _savingsTips;
  @override
  @JsonKey()
  @HiveField(8)
  List<CostSavingTip> get savingsTips {
    if (_savingsTips is EqualUnmodifiableListView) return _savingsTips;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_savingsTips);
  }

  final Map<String, PriceHistory> _priceHistory;
  @override
  @JsonKey()
  @HiveField(9)
  Map<String, PriceHistory> get priceHistory {
    if (_priceHistory is EqualUnmodifiableMapView) return _priceHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_priceHistory);
  }

  @override
  String toString() {
    return 'CostAnalysis(totalSpent: $totalSpent, averageMealCost: $averageMealCost, averageIngredientCost: $averageIngredientCost, monthlySpending: $monthlySpending, categorySpending: $categorySpending, costPerCuisine: $costPerCuisine, budgetAdherence: $budgetAdherence, savingsFromMealPlanning: $savingsFromMealPlanning, savingsTips: $savingsTips, priceHistory: $priceHistory)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CostAnalysisImpl &&
            (identical(other.totalSpent, totalSpent) ||
                other.totalSpent == totalSpent) &&
            (identical(other.averageMealCost, averageMealCost) ||
                other.averageMealCost == averageMealCost) &&
            (identical(other.averageIngredientCost, averageIngredientCost) ||
                other.averageIngredientCost == averageIngredientCost) &&
            const DeepCollectionEquality()
                .equals(other._monthlySpending, _monthlySpending) &&
            const DeepCollectionEquality()
                .equals(other._categorySpending, _categorySpending) &&
            const DeepCollectionEquality()
                .equals(other._costPerCuisine, _costPerCuisine) &&
            (identical(other.budgetAdherence, budgetAdherence) ||
                other.budgetAdherence == budgetAdherence) &&
            (identical(
                    other.savingsFromMealPlanning, savingsFromMealPlanning) ||
                other.savingsFromMealPlanning == savingsFromMealPlanning) &&
            const DeepCollectionEquality()
                .equals(other._savingsTips, _savingsTips) &&
            const DeepCollectionEquality()
                .equals(other._priceHistory, _priceHistory));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalSpent,
      averageMealCost,
      averageIngredientCost,
      const DeepCollectionEquality().hash(_monthlySpending),
      const DeepCollectionEquality().hash(_categorySpending),
      const DeepCollectionEquality().hash(_costPerCuisine),
      budgetAdherence,
      savingsFromMealPlanning,
      const DeepCollectionEquality().hash(_savingsTips),
      const DeepCollectionEquality().hash(_priceHistory));

  /// Create a copy of CostAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CostAnalysisImplCopyWith<_$CostAnalysisImpl> get copyWith =>
      __$$CostAnalysisImplCopyWithImpl<_$CostAnalysisImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CostAnalysisImplToJson(
      this,
    );
  }
}

abstract class _CostAnalysis implements CostAnalysis {
  const factory _CostAnalysis(
          {@HiveField(0) final double totalSpent,
          @HiveField(1) final double averageMealCost,
          @HiveField(2) final double averageIngredientCost,
          @HiveField(3) final Map<String, double> monthlySpending,
          @HiveField(4) final Map<String, double> categorySpending,
          @HiveField(5) final Map<String, double> costPerCuisine,
          @HiveField(6) final double budgetAdherence,
          @HiveField(7) final double savingsFromMealPlanning,
          @HiveField(8) final List<CostSavingTip> savingsTips,
          @HiveField(9) final Map<String, PriceHistory> priceHistory}) =
      _$CostAnalysisImpl;

  factory _CostAnalysis.fromJson(Map<String, dynamic> json) =
      _$CostAnalysisImpl.fromJson;

  @override
  @HiveField(0)
  double get totalSpent;
  @override
  @HiveField(1)
  double get averageMealCost;
  @override
  @HiveField(2)
  double get averageIngredientCost;
  @override
  @HiveField(3)
  Map<String, double> get monthlySpending;
  @override
  @HiveField(4)
  Map<String, double> get categorySpending;
  @override
  @HiveField(5)
  Map<String, double> get costPerCuisine;
  @override
  @HiveField(6)
  double get budgetAdherence;
  @override
  @HiveField(7)
  double get savingsFromMealPlanning;
  @override
  @HiveField(8)
  List<CostSavingTip> get savingsTips;
  @override
  @HiveField(9)
  Map<String, PriceHistory> get priceHistory;

  /// Create a copy of CostAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CostAnalysisImplCopyWith<_$CostAnalysisImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HealthImpact _$HealthImpactFromJson(Map<String, dynamic> json) {
  return _HealthImpact.fromJson(json);
}

/// @nodoc
mixin _$HealthImpact {
  @HiveField(0)
  Map<String, double> get nutritionTrends => throw _privateConstructorUsedError;
  @HiveField(1)
  double get averageDailyCalories => throw _privateConstructorUsedError;
  @HiveField(2)
  Map<String, double> get macroDistribution =>
      throw _privateConstructorUsedError;
  @HiveField(3)
  Map<String, double> get micronutrientIntake =>
      throw _privateConstructorUsedError;
  @HiveField(4)
  double get dietaryGoalProgress => throw _privateConstructorUsedError;
  @HiveField(5)
  double get nutritionScore => throw _privateConstructorUsedError;
  @HiveField(6)
  List<HealthInsight> get insights => throw _privateConstructorUsedError;
  @HiveField(7)
  Map<String, TrendData> get healthTrends => throw _privateConstructorUsedError;
  @HiveField(8)
  DateTime? get lastNutritionAnalysis => throw _privateConstructorUsedError;

  /// Serializes this HealthImpact to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HealthImpact
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HealthImpactCopyWith<HealthImpact> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HealthImpactCopyWith<$Res> {
  factory $HealthImpactCopyWith(
          HealthImpact value, $Res Function(HealthImpact) then) =
      _$HealthImpactCopyWithImpl<$Res, HealthImpact>;
  @useResult
  $Res call(
      {@HiveField(0) Map<String, double> nutritionTrends,
      @HiveField(1) double averageDailyCalories,
      @HiveField(2) Map<String, double> macroDistribution,
      @HiveField(3) Map<String, double> micronutrientIntake,
      @HiveField(4) double dietaryGoalProgress,
      @HiveField(5) double nutritionScore,
      @HiveField(6) List<HealthInsight> insights,
      @HiveField(7) Map<String, TrendData> healthTrends,
      @HiveField(8) DateTime? lastNutritionAnalysis});
}

/// @nodoc
class _$HealthImpactCopyWithImpl<$Res, $Val extends HealthImpact>
    implements $HealthImpactCopyWith<$Res> {
  _$HealthImpactCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HealthImpact
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nutritionTrends = null,
    Object? averageDailyCalories = null,
    Object? macroDistribution = null,
    Object? micronutrientIntake = null,
    Object? dietaryGoalProgress = null,
    Object? nutritionScore = null,
    Object? insights = null,
    Object? healthTrends = null,
    Object? lastNutritionAnalysis = freezed,
  }) {
    return _then(_value.copyWith(
      nutritionTrends: null == nutritionTrends
          ? _value.nutritionTrends
          : nutritionTrends // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      averageDailyCalories: null == averageDailyCalories
          ? _value.averageDailyCalories
          : averageDailyCalories // ignore: cast_nullable_to_non_nullable
              as double,
      macroDistribution: null == macroDistribution
          ? _value.macroDistribution
          : macroDistribution // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      micronutrientIntake: null == micronutrientIntake
          ? _value.micronutrientIntake
          : micronutrientIntake // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      dietaryGoalProgress: null == dietaryGoalProgress
          ? _value.dietaryGoalProgress
          : dietaryGoalProgress // ignore: cast_nullable_to_non_nullable
              as double,
      nutritionScore: null == nutritionScore
          ? _value.nutritionScore
          : nutritionScore // ignore: cast_nullable_to_non_nullable
              as double,
      insights: null == insights
          ? _value.insights
          : insights // ignore: cast_nullable_to_non_nullable
              as List<HealthInsight>,
      healthTrends: null == healthTrends
          ? _value.healthTrends
          : healthTrends // ignore: cast_nullable_to_non_nullable
              as Map<String, TrendData>,
      lastNutritionAnalysis: freezed == lastNutritionAnalysis
          ? _value.lastNutritionAnalysis
          : lastNutritionAnalysis // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HealthImpactImplCopyWith<$Res>
    implements $HealthImpactCopyWith<$Res> {
  factory _$$HealthImpactImplCopyWith(
          _$HealthImpactImpl value, $Res Function(_$HealthImpactImpl) then) =
      __$$HealthImpactImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) Map<String, double> nutritionTrends,
      @HiveField(1) double averageDailyCalories,
      @HiveField(2) Map<String, double> macroDistribution,
      @HiveField(3) Map<String, double> micronutrientIntake,
      @HiveField(4) double dietaryGoalProgress,
      @HiveField(5) double nutritionScore,
      @HiveField(6) List<HealthInsight> insights,
      @HiveField(7) Map<String, TrendData> healthTrends,
      @HiveField(8) DateTime? lastNutritionAnalysis});
}

/// @nodoc
class __$$HealthImpactImplCopyWithImpl<$Res>
    extends _$HealthImpactCopyWithImpl<$Res, _$HealthImpactImpl>
    implements _$$HealthImpactImplCopyWith<$Res> {
  __$$HealthImpactImplCopyWithImpl(
      _$HealthImpactImpl _value, $Res Function(_$HealthImpactImpl) _then)
      : super(_value, _then);

  /// Create a copy of HealthImpact
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nutritionTrends = null,
    Object? averageDailyCalories = null,
    Object? macroDistribution = null,
    Object? micronutrientIntake = null,
    Object? dietaryGoalProgress = null,
    Object? nutritionScore = null,
    Object? insights = null,
    Object? healthTrends = null,
    Object? lastNutritionAnalysis = freezed,
  }) {
    return _then(_$HealthImpactImpl(
      nutritionTrends: null == nutritionTrends
          ? _value._nutritionTrends
          : nutritionTrends // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      averageDailyCalories: null == averageDailyCalories
          ? _value.averageDailyCalories
          : averageDailyCalories // ignore: cast_nullable_to_non_nullable
              as double,
      macroDistribution: null == macroDistribution
          ? _value._macroDistribution
          : macroDistribution // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      micronutrientIntake: null == micronutrientIntake
          ? _value._micronutrientIntake
          : micronutrientIntake // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      dietaryGoalProgress: null == dietaryGoalProgress
          ? _value.dietaryGoalProgress
          : dietaryGoalProgress // ignore: cast_nullable_to_non_nullable
              as double,
      nutritionScore: null == nutritionScore
          ? _value.nutritionScore
          : nutritionScore // ignore: cast_nullable_to_non_nullable
              as double,
      insights: null == insights
          ? _value._insights
          : insights // ignore: cast_nullable_to_non_nullable
              as List<HealthInsight>,
      healthTrends: null == healthTrends
          ? _value._healthTrends
          : healthTrends // ignore: cast_nullable_to_non_nullable
              as Map<String, TrendData>,
      lastNutritionAnalysis: freezed == lastNutritionAnalysis
          ? _value.lastNutritionAnalysis
          : lastNutritionAnalysis // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HealthImpactImpl implements _HealthImpact {
  const _$HealthImpactImpl(
      {@HiveField(0) final Map<String, double> nutritionTrends = const {},
      @HiveField(1) this.averageDailyCalories = 0.0,
      @HiveField(2) final Map<String, double> macroDistribution = const {},
      @HiveField(3) final Map<String, double> micronutrientIntake = const {},
      @HiveField(4) this.dietaryGoalProgress = 0.0,
      @HiveField(5) this.nutritionScore = 0.0,
      @HiveField(6) final List<HealthInsight> insights = const [],
      @HiveField(7) final Map<String, TrendData> healthTrends = const {},
      @HiveField(8) this.lastNutritionAnalysis})
      : _nutritionTrends = nutritionTrends,
        _macroDistribution = macroDistribution,
        _micronutrientIntake = micronutrientIntake,
        _insights = insights,
        _healthTrends = healthTrends;

  factory _$HealthImpactImpl.fromJson(Map<String, dynamic> json) =>
      _$$HealthImpactImplFromJson(json);

  final Map<String, double> _nutritionTrends;
  @override
  @JsonKey()
  @HiveField(0)
  Map<String, double> get nutritionTrends {
    if (_nutritionTrends is EqualUnmodifiableMapView) return _nutritionTrends;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_nutritionTrends);
  }

  @override
  @JsonKey()
  @HiveField(1)
  final double averageDailyCalories;
  final Map<String, double> _macroDistribution;
  @override
  @JsonKey()
  @HiveField(2)
  Map<String, double> get macroDistribution {
    if (_macroDistribution is EqualUnmodifiableMapView)
      return _macroDistribution;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_macroDistribution);
  }

  final Map<String, double> _micronutrientIntake;
  @override
  @JsonKey()
  @HiveField(3)
  Map<String, double> get micronutrientIntake {
    if (_micronutrientIntake is EqualUnmodifiableMapView)
      return _micronutrientIntake;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_micronutrientIntake);
  }

  @override
  @JsonKey()
  @HiveField(4)
  final double dietaryGoalProgress;
  @override
  @JsonKey()
  @HiveField(5)
  final double nutritionScore;
  final List<HealthInsight> _insights;
  @override
  @JsonKey()
  @HiveField(6)
  List<HealthInsight> get insights {
    if (_insights is EqualUnmodifiableListView) return _insights;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_insights);
  }

  final Map<String, TrendData> _healthTrends;
  @override
  @JsonKey()
  @HiveField(7)
  Map<String, TrendData> get healthTrends {
    if (_healthTrends is EqualUnmodifiableMapView) return _healthTrends;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_healthTrends);
  }

  @override
  @HiveField(8)
  final DateTime? lastNutritionAnalysis;

  @override
  String toString() {
    return 'HealthImpact(nutritionTrends: $nutritionTrends, averageDailyCalories: $averageDailyCalories, macroDistribution: $macroDistribution, micronutrientIntake: $micronutrientIntake, dietaryGoalProgress: $dietaryGoalProgress, nutritionScore: $nutritionScore, insights: $insights, healthTrends: $healthTrends, lastNutritionAnalysis: $lastNutritionAnalysis)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HealthImpactImpl &&
            const DeepCollectionEquality()
                .equals(other._nutritionTrends, _nutritionTrends) &&
            (identical(other.averageDailyCalories, averageDailyCalories) ||
                other.averageDailyCalories == averageDailyCalories) &&
            const DeepCollectionEquality()
                .equals(other._macroDistribution, _macroDistribution) &&
            const DeepCollectionEquality()
                .equals(other._micronutrientIntake, _micronutrientIntake) &&
            (identical(other.dietaryGoalProgress, dietaryGoalProgress) ||
                other.dietaryGoalProgress == dietaryGoalProgress) &&
            (identical(other.nutritionScore, nutritionScore) ||
                other.nutritionScore == nutritionScore) &&
            const DeepCollectionEquality().equals(other._insights, _insights) &&
            const DeepCollectionEquality()
                .equals(other._healthTrends, _healthTrends) &&
            (identical(other.lastNutritionAnalysis, lastNutritionAnalysis) ||
                other.lastNutritionAnalysis == lastNutritionAnalysis));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_nutritionTrends),
      averageDailyCalories,
      const DeepCollectionEquality().hash(_macroDistribution),
      const DeepCollectionEquality().hash(_micronutrientIntake),
      dietaryGoalProgress,
      nutritionScore,
      const DeepCollectionEquality().hash(_insights),
      const DeepCollectionEquality().hash(_healthTrends),
      lastNutritionAnalysis);

  /// Create a copy of HealthImpact
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HealthImpactImplCopyWith<_$HealthImpactImpl> get copyWith =>
      __$$HealthImpactImplCopyWithImpl<_$HealthImpactImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HealthImpactImplToJson(
      this,
    );
  }
}

abstract class _HealthImpact implements HealthImpact {
  const factory _HealthImpact(
          {@HiveField(0) final Map<String, double> nutritionTrends,
          @HiveField(1) final double averageDailyCalories,
          @HiveField(2) final Map<String, double> macroDistribution,
          @HiveField(3) final Map<String, double> micronutrientIntake,
          @HiveField(4) final double dietaryGoalProgress,
          @HiveField(5) final double nutritionScore,
          @HiveField(6) final List<HealthInsight> insights,
          @HiveField(7) final Map<String, TrendData> healthTrends,
          @HiveField(8) final DateTime? lastNutritionAnalysis}) =
      _$HealthImpactImpl;

  factory _HealthImpact.fromJson(Map<String, dynamic> json) =
      _$HealthImpactImpl.fromJson;

  @override
  @HiveField(0)
  Map<String, double> get nutritionTrends;
  @override
  @HiveField(1)
  double get averageDailyCalories;
  @override
  @HiveField(2)
  Map<String, double> get macroDistribution;
  @override
  @HiveField(3)
  Map<String, double> get micronutrientIntake;
  @override
  @HiveField(4)
  double get dietaryGoalProgress;
  @override
  @HiveField(5)
  double get nutritionScore;
  @override
  @HiveField(6)
  List<HealthInsight> get insights;
  @override
  @HiveField(7)
  Map<String, TrendData> get healthTrends;
  @override
  @HiveField(8)
  DateTime? get lastNutritionAnalysis;

  /// Create a copy of HealthImpact
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HealthImpactImplCopyWith<_$HealthImpactImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EnvironmentalImpact _$EnvironmentalImpactFromJson(Map<String, dynamic> json) {
  return _EnvironmentalImpact.fromJson(json);
}

/// @nodoc
mixin _$EnvironmentalImpact {
  @HiveField(0)
  double get carbonFootprint => throw _privateConstructorUsedError;
  @HiveField(1)
  double get waterUsage => throw _privateConstructorUsedError;
  @HiveField(2)
  double get foodWasteReduction => throw _privateConstructorUsedError;
  @HiveField(3)
  double get localIngredientPercentage => throw _privateConstructorUsedError;
  @HiveField(4)
  double get seasonalIngredientPercentage => throw _privateConstructorUsedError;
  @HiveField(5)
  double get sustainabilityScore => throw _privateConstructorUsedError;
  @HiveField(6)
  List<SustainabilityTip> get tips => throw _privateConstructorUsedError;
  @HiveField(7)
  Map<String, double> get impactByCategory =>
      throw _privateConstructorUsedError;
  @HiveField(8)
  Map<String, TrendData> get environmentalTrends =>
      throw _privateConstructorUsedError;

  /// Serializes this EnvironmentalImpact to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EnvironmentalImpact
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EnvironmentalImpactCopyWith<EnvironmentalImpact> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EnvironmentalImpactCopyWith<$Res> {
  factory $EnvironmentalImpactCopyWith(
          EnvironmentalImpact value, $Res Function(EnvironmentalImpact) then) =
      _$EnvironmentalImpactCopyWithImpl<$Res, EnvironmentalImpact>;
  @useResult
  $Res call(
      {@HiveField(0) double carbonFootprint,
      @HiveField(1) double waterUsage,
      @HiveField(2) double foodWasteReduction,
      @HiveField(3) double localIngredientPercentage,
      @HiveField(4) double seasonalIngredientPercentage,
      @HiveField(5) double sustainabilityScore,
      @HiveField(6) List<SustainabilityTip> tips,
      @HiveField(7) Map<String, double> impactByCategory,
      @HiveField(8) Map<String, TrendData> environmentalTrends});
}

/// @nodoc
class _$EnvironmentalImpactCopyWithImpl<$Res, $Val extends EnvironmentalImpact>
    implements $EnvironmentalImpactCopyWith<$Res> {
  _$EnvironmentalImpactCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EnvironmentalImpact
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? carbonFootprint = null,
    Object? waterUsage = null,
    Object? foodWasteReduction = null,
    Object? localIngredientPercentage = null,
    Object? seasonalIngredientPercentage = null,
    Object? sustainabilityScore = null,
    Object? tips = null,
    Object? impactByCategory = null,
    Object? environmentalTrends = null,
  }) {
    return _then(_value.copyWith(
      carbonFootprint: null == carbonFootprint
          ? _value.carbonFootprint
          : carbonFootprint // ignore: cast_nullable_to_non_nullable
              as double,
      waterUsage: null == waterUsage
          ? _value.waterUsage
          : waterUsage // ignore: cast_nullable_to_non_nullable
              as double,
      foodWasteReduction: null == foodWasteReduction
          ? _value.foodWasteReduction
          : foodWasteReduction // ignore: cast_nullable_to_non_nullable
              as double,
      localIngredientPercentage: null == localIngredientPercentage
          ? _value.localIngredientPercentage
          : localIngredientPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      seasonalIngredientPercentage: null == seasonalIngredientPercentage
          ? _value.seasonalIngredientPercentage
          : seasonalIngredientPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      sustainabilityScore: null == sustainabilityScore
          ? _value.sustainabilityScore
          : sustainabilityScore // ignore: cast_nullable_to_non_nullable
              as double,
      tips: null == tips
          ? _value.tips
          : tips // ignore: cast_nullable_to_non_nullable
              as List<SustainabilityTip>,
      impactByCategory: null == impactByCategory
          ? _value.impactByCategory
          : impactByCategory // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      environmentalTrends: null == environmentalTrends
          ? _value.environmentalTrends
          : environmentalTrends // ignore: cast_nullable_to_non_nullable
              as Map<String, TrendData>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EnvironmentalImpactImplCopyWith<$Res>
    implements $EnvironmentalImpactCopyWith<$Res> {
  factory _$$EnvironmentalImpactImplCopyWith(_$EnvironmentalImpactImpl value,
          $Res Function(_$EnvironmentalImpactImpl) then) =
      __$$EnvironmentalImpactImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) double carbonFootprint,
      @HiveField(1) double waterUsage,
      @HiveField(2) double foodWasteReduction,
      @HiveField(3) double localIngredientPercentage,
      @HiveField(4) double seasonalIngredientPercentage,
      @HiveField(5) double sustainabilityScore,
      @HiveField(6) List<SustainabilityTip> tips,
      @HiveField(7) Map<String, double> impactByCategory,
      @HiveField(8) Map<String, TrendData> environmentalTrends});
}

/// @nodoc
class __$$EnvironmentalImpactImplCopyWithImpl<$Res>
    extends _$EnvironmentalImpactCopyWithImpl<$Res, _$EnvironmentalImpactImpl>
    implements _$$EnvironmentalImpactImplCopyWith<$Res> {
  __$$EnvironmentalImpactImplCopyWithImpl(_$EnvironmentalImpactImpl _value,
      $Res Function(_$EnvironmentalImpactImpl) _then)
      : super(_value, _then);

  /// Create a copy of EnvironmentalImpact
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? carbonFootprint = null,
    Object? waterUsage = null,
    Object? foodWasteReduction = null,
    Object? localIngredientPercentage = null,
    Object? seasonalIngredientPercentage = null,
    Object? sustainabilityScore = null,
    Object? tips = null,
    Object? impactByCategory = null,
    Object? environmentalTrends = null,
  }) {
    return _then(_$EnvironmentalImpactImpl(
      carbonFootprint: null == carbonFootprint
          ? _value.carbonFootprint
          : carbonFootprint // ignore: cast_nullable_to_non_nullable
              as double,
      waterUsage: null == waterUsage
          ? _value.waterUsage
          : waterUsage // ignore: cast_nullable_to_non_nullable
              as double,
      foodWasteReduction: null == foodWasteReduction
          ? _value.foodWasteReduction
          : foodWasteReduction // ignore: cast_nullable_to_non_nullable
              as double,
      localIngredientPercentage: null == localIngredientPercentage
          ? _value.localIngredientPercentage
          : localIngredientPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      seasonalIngredientPercentage: null == seasonalIngredientPercentage
          ? _value.seasonalIngredientPercentage
          : seasonalIngredientPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      sustainabilityScore: null == sustainabilityScore
          ? _value.sustainabilityScore
          : sustainabilityScore // ignore: cast_nullable_to_non_nullable
              as double,
      tips: null == tips
          ? _value._tips
          : tips // ignore: cast_nullable_to_non_nullable
              as List<SustainabilityTip>,
      impactByCategory: null == impactByCategory
          ? _value._impactByCategory
          : impactByCategory // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      environmentalTrends: null == environmentalTrends
          ? _value._environmentalTrends
          : environmentalTrends // ignore: cast_nullable_to_non_nullable
              as Map<String, TrendData>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EnvironmentalImpactImpl implements _EnvironmentalImpact {
  const _$EnvironmentalImpactImpl(
      {@HiveField(0) this.carbonFootprint = 0.0,
      @HiveField(1) this.waterUsage = 0.0,
      @HiveField(2) this.foodWasteReduction = 0.0,
      @HiveField(3) this.localIngredientPercentage = 0.0,
      @HiveField(4) this.seasonalIngredientPercentage = 0.0,
      @HiveField(5) this.sustainabilityScore = 0.0,
      @HiveField(6) final List<SustainabilityTip> tips = const [],
      @HiveField(7) final Map<String, double> impactByCategory = const {},
      @HiveField(8)
      final Map<String, TrendData> environmentalTrends = const {}})
      : _tips = tips,
        _impactByCategory = impactByCategory,
        _environmentalTrends = environmentalTrends;

  factory _$EnvironmentalImpactImpl.fromJson(Map<String, dynamic> json) =>
      _$$EnvironmentalImpactImplFromJson(json);

  @override
  @JsonKey()
  @HiveField(0)
  final double carbonFootprint;
  @override
  @JsonKey()
  @HiveField(1)
  final double waterUsage;
  @override
  @JsonKey()
  @HiveField(2)
  final double foodWasteReduction;
  @override
  @JsonKey()
  @HiveField(3)
  final double localIngredientPercentage;
  @override
  @JsonKey()
  @HiveField(4)
  final double seasonalIngredientPercentage;
  @override
  @JsonKey()
  @HiveField(5)
  final double sustainabilityScore;
  final List<SustainabilityTip> _tips;
  @override
  @JsonKey()
  @HiveField(6)
  List<SustainabilityTip> get tips {
    if (_tips is EqualUnmodifiableListView) return _tips;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tips);
  }

  final Map<String, double> _impactByCategory;
  @override
  @JsonKey()
  @HiveField(7)
  Map<String, double> get impactByCategory {
    if (_impactByCategory is EqualUnmodifiableMapView) return _impactByCategory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_impactByCategory);
  }

  final Map<String, TrendData> _environmentalTrends;
  @override
  @JsonKey()
  @HiveField(8)
  Map<String, TrendData> get environmentalTrends {
    if (_environmentalTrends is EqualUnmodifiableMapView)
      return _environmentalTrends;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_environmentalTrends);
  }

  @override
  String toString() {
    return 'EnvironmentalImpact(carbonFootprint: $carbonFootprint, waterUsage: $waterUsage, foodWasteReduction: $foodWasteReduction, localIngredientPercentage: $localIngredientPercentage, seasonalIngredientPercentage: $seasonalIngredientPercentage, sustainabilityScore: $sustainabilityScore, tips: $tips, impactByCategory: $impactByCategory, environmentalTrends: $environmentalTrends)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EnvironmentalImpactImpl &&
            (identical(other.carbonFootprint, carbonFootprint) ||
                other.carbonFootprint == carbonFootprint) &&
            (identical(other.waterUsage, waterUsage) ||
                other.waterUsage == waterUsage) &&
            (identical(other.foodWasteReduction, foodWasteReduction) ||
                other.foodWasteReduction == foodWasteReduction) &&
            (identical(other.localIngredientPercentage,
                    localIngredientPercentage) ||
                other.localIngredientPercentage == localIngredientPercentage) &&
            (identical(other.seasonalIngredientPercentage,
                    seasonalIngredientPercentage) ||
                other.seasonalIngredientPercentage ==
                    seasonalIngredientPercentage) &&
            (identical(other.sustainabilityScore, sustainabilityScore) ||
                other.sustainabilityScore == sustainabilityScore) &&
            const DeepCollectionEquality().equals(other._tips, _tips) &&
            const DeepCollectionEquality()
                .equals(other._impactByCategory, _impactByCategory) &&
            const DeepCollectionEquality()
                .equals(other._environmentalTrends, _environmentalTrends));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      carbonFootprint,
      waterUsage,
      foodWasteReduction,
      localIngredientPercentage,
      seasonalIngredientPercentage,
      sustainabilityScore,
      const DeepCollectionEquality().hash(_tips),
      const DeepCollectionEquality().hash(_impactByCategory),
      const DeepCollectionEquality().hash(_environmentalTrends));

  /// Create a copy of EnvironmentalImpact
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EnvironmentalImpactImplCopyWith<_$EnvironmentalImpactImpl> get copyWith =>
      __$$EnvironmentalImpactImplCopyWithImpl<_$EnvironmentalImpactImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EnvironmentalImpactImplToJson(
      this,
    );
  }
}

abstract class _EnvironmentalImpact implements EnvironmentalImpact {
  const factory _EnvironmentalImpact(
          {@HiveField(0) final double carbonFootprint,
          @HiveField(1) final double waterUsage,
          @HiveField(2) final double foodWasteReduction,
          @HiveField(3) final double localIngredientPercentage,
          @HiveField(4) final double seasonalIngredientPercentage,
          @HiveField(5) final double sustainabilityScore,
          @HiveField(6) final List<SustainabilityTip> tips,
          @HiveField(7) final Map<String, double> impactByCategory,
          @HiveField(8) final Map<String, TrendData> environmentalTrends}) =
      _$EnvironmentalImpactImpl;

  factory _EnvironmentalImpact.fromJson(Map<String, dynamic> json) =
      _$EnvironmentalImpactImpl.fromJson;

  @override
  @HiveField(0)
  double get carbonFootprint;
  @override
  @HiveField(1)
  double get waterUsage;
  @override
  @HiveField(2)
  double get foodWasteReduction;
  @override
  @HiveField(3)
  double get localIngredientPercentage;
  @override
  @HiveField(4)
  double get seasonalIngredientPercentage;
  @override
  @HiveField(5)
  double get sustainabilityScore;
  @override
  @HiveField(6)
  List<SustainabilityTip> get tips;
  @override
  @HiveField(7)
  Map<String, double> get impactByCategory;
  @override
  @HiveField(8)
  Map<String, TrendData> get environmentalTrends;

  /// Create a copy of EnvironmentalImpact
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EnvironmentalImpactImplCopyWith<_$EnvironmentalImpactImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TrendData _$TrendDataFromJson(Map<String, dynamic> json) {
  return _TrendData.fromJson(json);
}

/// @nodoc
mixin _$TrendData {
  @HiveField(0)
  List<DataPoint> get dataPoints => throw _privateConstructorUsedError;
  @HiveField(1)
  TrendDirection get direction => throw _privateConstructorUsedError;
  @HiveField(2)
  double get changePercentage => throw _privateConstructorUsedError;
  @HiveField(3)
  String get timeframe => throw _privateConstructorUsedError;

  /// Serializes this TrendData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TrendData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TrendDataCopyWith<TrendData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrendDataCopyWith<$Res> {
  factory $TrendDataCopyWith(TrendData value, $Res Function(TrendData) then) =
      _$TrendDataCopyWithImpl<$Res, TrendData>;
  @useResult
  $Res call(
      {@HiveField(0) List<DataPoint> dataPoints,
      @HiveField(1) TrendDirection direction,
      @HiveField(2) double changePercentage,
      @HiveField(3) String timeframe});
}

/// @nodoc
class _$TrendDataCopyWithImpl<$Res, $Val extends TrendData>
    implements $TrendDataCopyWith<$Res> {
  _$TrendDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TrendData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dataPoints = null,
    Object? direction = null,
    Object? changePercentage = null,
    Object? timeframe = null,
  }) {
    return _then(_value.copyWith(
      dataPoints: null == dataPoints
          ? _value.dataPoints
          : dataPoints // ignore: cast_nullable_to_non_nullable
              as List<DataPoint>,
      direction: null == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as TrendDirection,
      changePercentage: null == changePercentage
          ? _value.changePercentage
          : changePercentage // ignore: cast_nullable_to_non_nullable
              as double,
      timeframe: null == timeframe
          ? _value.timeframe
          : timeframe // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TrendDataImplCopyWith<$Res>
    implements $TrendDataCopyWith<$Res> {
  factory _$$TrendDataImplCopyWith(
          _$TrendDataImpl value, $Res Function(_$TrendDataImpl) then) =
      __$$TrendDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) List<DataPoint> dataPoints,
      @HiveField(1) TrendDirection direction,
      @HiveField(2) double changePercentage,
      @HiveField(3) String timeframe});
}

/// @nodoc
class __$$TrendDataImplCopyWithImpl<$Res>
    extends _$TrendDataCopyWithImpl<$Res, _$TrendDataImpl>
    implements _$$TrendDataImplCopyWith<$Res> {
  __$$TrendDataImplCopyWithImpl(
      _$TrendDataImpl _value, $Res Function(_$TrendDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of TrendData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dataPoints = null,
    Object? direction = null,
    Object? changePercentage = null,
    Object? timeframe = null,
  }) {
    return _then(_$TrendDataImpl(
      dataPoints: null == dataPoints
          ? _value._dataPoints
          : dataPoints // ignore: cast_nullable_to_non_nullable
              as List<DataPoint>,
      direction: null == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as TrendDirection,
      changePercentage: null == changePercentage
          ? _value.changePercentage
          : changePercentage // ignore: cast_nullable_to_non_nullable
              as double,
      timeframe: null == timeframe
          ? _value.timeframe
          : timeframe // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TrendDataImpl implements _TrendData {
  const _$TrendDataImpl(
      {@HiveField(0) required final List<DataPoint> dataPoints,
      @HiveField(1) required this.direction,
      @HiveField(2) required this.changePercentage,
      @HiveField(3) required this.timeframe})
      : _dataPoints = dataPoints;

  factory _$TrendDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrendDataImplFromJson(json);

  final List<DataPoint> _dataPoints;
  @override
  @HiveField(0)
  List<DataPoint> get dataPoints {
    if (_dataPoints is EqualUnmodifiableListView) return _dataPoints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dataPoints);
  }

  @override
  @HiveField(1)
  final TrendDirection direction;
  @override
  @HiveField(2)
  final double changePercentage;
  @override
  @HiveField(3)
  final String timeframe;

  @override
  String toString() {
    return 'TrendData(dataPoints: $dataPoints, direction: $direction, changePercentage: $changePercentage, timeframe: $timeframe)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrendDataImpl &&
            const DeepCollectionEquality()
                .equals(other._dataPoints, _dataPoints) &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            (identical(other.changePercentage, changePercentage) ||
                other.changePercentage == changePercentage) &&
            (identical(other.timeframe, timeframe) ||
                other.timeframe == timeframe));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_dataPoints),
      direction,
      changePercentage,
      timeframe);

  /// Create a copy of TrendData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TrendDataImplCopyWith<_$TrendDataImpl> get copyWith =>
      __$$TrendDataImplCopyWithImpl<_$TrendDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TrendDataImplToJson(
      this,
    );
  }
}

abstract class _TrendData implements TrendData {
  const factory _TrendData(
      {@HiveField(0) required final List<DataPoint> dataPoints,
      @HiveField(1) required final TrendDirection direction,
      @HiveField(2) required final double changePercentage,
      @HiveField(3) required final String timeframe}) = _$TrendDataImpl;

  factory _TrendData.fromJson(Map<String, dynamic> json) =
      _$TrendDataImpl.fromJson;

  @override
  @HiveField(0)
  List<DataPoint> get dataPoints;
  @override
  @HiveField(1)
  TrendDirection get direction;
  @override
  @HiveField(2)
  double get changePercentage;
  @override
  @HiveField(3)
  String get timeframe;

  /// Create a copy of TrendData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TrendDataImplCopyWith<_$TrendDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DataPoint _$DataPointFromJson(Map<String, dynamic> json) {
  return _DataPoint.fromJson(json);
}

/// @nodoc
mixin _$DataPoint {
  @HiveField(0)
  DateTime get timestamp => throw _privateConstructorUsedError;
  @HiveField(1)
  double get value => throw _privateConstructorUsedError;
  @HiveField(2)
  String? get label => throw _privateConstructorUsedError;

  /// Serializes this DataPoint to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DataPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DataPointCopyWith<DataPoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataPointCopyWith<$Res> {
  factory $DataPointCopyWith(DataPoint value, $Res Function(DataPoint) then) =
      _$DataPointCopyWithImpl<$Res, DataPoint>;
  @useResult
  $Res call(
      {@HiveField(0) DateTime timestamp,
      @HiveField(1) double value,
      @HiveField(2) String? label});
}

/// @nodoc
class _$DataPointCopyWithImpl<$Res, $Val extends DataPoint>
    implements $DataPointCopyWith<$Res> {
  _$DataPointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DataPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = null,
    Object? value = null,
    Object? label = freezed,
  }) {
    return _then(_value.copyWith(
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      label: freezed == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DataPointImplCopyWith<$Res>
    implements $DataPointCopyWith<$Res> {
  factory _$$DataPointImplCopyWith(
          _$DataPointImpl value, $Res Function(_$DataPointImpl) then) =
      __$$DataPointImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) DateTime timestamp,
      @HiveField(1) double value,
      @HiveField(2) String? label});
}

/// @nodoc
class __$$DataPointImplCopyWithImpl<$Res>
    extends _$DataPointCopyWithImpl<$Res, _$DataPointImpl>
    implements _$$DataPointImplCopyWith<$Res> {
  __$$DataPointImplCopyWithImpl(
      _$DataPointImpl _value, $Res Function(_$DataPointImpl) _then)
      : super(_value, _then);

  /// Create a copy of DataPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = null,
    Object? value = null,
    Object? label = freezed,
  }) {
    return _then(_$DataPointImpl(
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      label: freezed == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DataPointImpl implements _DataPoint {
  const _$DataPointImpl(
      {@HiveField(0) required this.timestamp,
      @HiveField(1) required this.value,
      @HiveField(2) this.label});

  factory _$DataPointImpl.fromJson(Map<String, dynamic> json) =>
      _$$DataPointImplFromJson(json);

  @override
  @HiveField(0)
  final DateTime timestamp;
  @override
  @HiveField(1)
  final double value;
  @override
  @HiveField(2)
  final String? label;

  @override
  String toString() {
    return 'DataPoint(timestamp: $timestamp, value: $value, label: $label)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DataPointImpl &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.label, label) || other.label == label));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, timestamp, value, label);

  /// Create a copy of DataPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DataPointImplCopyWith<_$DataPointImpl> get copyWith =>
      __$$DataPointImplCopyWithImpl<_$DataPointImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DataPointImplToJson(
      this,
    );
  }
}

abstract class _DataPoint implements DataPoint {
  const factory _DataPoint(
      {@HiveField(0) required final DateTime timestamp,
      @HiveField(1) required final double value,
      @HiveField(2) final String? label}) = _$DataPointImpl;

  factory _DataPoint.fromJson(Map<String, dynamic> json) =
      _$DataPointImpl.fromJson;

  @override
  @HiveField(0)
  DateTime get timestamp;
  @override
  @HiveField(1)
  double get value;
  @override
  @HiveField(2)
  String? get label;

  /// Create a copy of DataPoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DataPointImplCopyWith<_$DataPointImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CookingMilestone _$CookingMilestoneFromJson(Map<String, dynamic> json) {
  return _CookingMilestone.fromJson(json);
}

/// @nodoc
mixin _$CookingMilestone {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get title => throw _privateConstructorUsedError;
  @HiveField(2)
  String get description => throw _privateConstructorUsedError;
  @HiveField(3)
  DateTime get achievedAt => throw _privateConstructorUsedError;
  @HiveField(4)
  MilestoneType get type => throw _privateConstructorUsedError;
  @HiveField(5)
  String? get badgeUrl => throw _privateConstructorUsedError;
  @HiveField(6)
  int get points => throw _privateConstructorUsedError;

  /// Serializes this CookingMilestone to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CookingMilestone
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CookingMilestoneCopyWith<CookingMilestone> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CookingMilestoneCopyWith<$Res> {
  factory $CookingMilestoneCopyWith(
          CookingMilestone value, $Res Function(CookingMilestone) then) =
      _$CookingMilestoneCopyWithImpl<$Res, CookingMilestone>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String title,
      @HiveField(2) String description,
      @HiveField(3) DateTime achievedAt,
      @HiveField(4) MilestoneType type,
      @HiveField(5) String? badgeUrl,
      @HiveField(6) int points});
}

/// @nodoc
class _$CookingMilestoneCopyWithImpl<$Res, $Val extends CookingMilestone>
    implements $CookingMilestoneCopyWith<$Res> {
  _$CookingMilestoneCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CookingMilestone
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? achievedAt = null,
    Object? type = null,
    Object? badgeUrl = freezed,
    Object? points = null,
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
      achievedAt: null == achievedAt
          ? _value.achievedAt
          : achievedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MilestoneType,
      badgeUrl: freezed == badgeUrl
          ? _value.badgeUrl
          : badgeUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CookingMilestoneImplCopyWith<$Res>
    implements $CookingMilestoneCopyWith<$Res> {
  factory _$$CookingMilestoneImplCopyWith(_$CookingMilestoneImpl value,
          $Res Function(_$CookingMilestoneImpl) then) =
      __$$CookingMilestoneImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String title,
      @HiveField(2) String description,
      @HiveField(3) DateTime achievedAt,
      @HiveField(4) MilestoneType type,
      @HiveField(5) String? badgeUrl,
      @HiveField(6) int points});
}

/// @nodoc
class __$$CookingMilestoneImplCopyWithImpl<$Res>
    extends _$CookingMilestoneCopyWithImpl<$Res, _$CookingMilestoneImpl>
    implements _$$CookingMilestoneImplCopyWith<$Res> {
  __$$CookingMilestoneImplCopyWithImpl(_$CookingMilestoneImpl _value,
      $Res Function(_$CookingMilestoneImpl) _then)
      : super(_value, _then);

  /// Create a copy of CookingMilestone
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? achievedAt = null,
    Object? type = null,
    Object? badgeUrl = freezed,
    Object? points = null,
  }) {
    return _then(_$CookingMilestoneImpl(
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
      achievedAt: null == achievedAt
          ? _value.achievedAt
          : achievedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MilestoneType,
      badgeUrl: freezed == badgeUrl
          ? _value.badgeUrl
          : badgeUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CookingMilestoneImpl implements _CookingMilestone {
  const _$CookingMilestoneImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.title,
      @HiveField(2) required this.description,
      @HiveField(3) required this.achievedAt,
      @HiveField(4) required this.type,
      @HiveField(5) this.badgeUrl,
      @HiveField(6) this.points = 0});

  factory _$CookingMilestoneImpl.fromJson(Map<String, dynamic> json) =>
      _$$CookingMilestoneImplFromJson(json);

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
  final DateTime achievedAt;
  @override
  @HiveField(4)
  final MilestoneType type;
  @override
  @HiveField(5)
  final String? badgeUrl;
  @override
  @JsonKey()
  @HiveField(6)
  final int points;

  @override
  String toString() {
    return 'CookingMilestone(id: $id, title: $title, description: $description, achievedAt: $achievedAt, type: $type, badgeUrl: $badgeUrl, points: $points)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CookingMilestoneImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.achievedAt, achievedAt) ||
                other.achievedAt == achievedAt) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.badgeUrl, badgeUrl) ||
                other.badgeUrl == badgeUrl) &&
            (identical(other.points, points) || other.points == points));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, title, description, achievedAt, type, badgeUrl, points);

  /// Create a copy of CookingMilestone
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CookingMilestoneImplCopyWith<_$CookingMilestoneImpl> get copyWith =>
      __$$CookingMilestoneImplCopyWithImpl<_$CookingMilestoneImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CookingMilestoneImplToJson(
      this,
    );
  }
}

abstract class _CookingMilestone implements CookingMilestone {
  const factory _CookingMilestone(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String title,
      @HiveField(2) required final String description,
      @HiveField(3) required final DateTime achievedAt,
      @HiveField(4) required final MilestoneType type,
      @HiveField(5) final String? badgeUrl,
      @HiveField(6) final int points}) = _$CookingMilestoneImpl;

  factory _CookingMilestone.fromJson(Map<String, dynamic> json) =
      _$CookingMilestoneImpl.fromJson;

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
  DateTime get achievedAt;
  @override
  @HiveField(4)
  MilestoneType get type;
  @override
  @HiveField(5)
  String? get badgeUrl;
  @override
  @HiveField(6)
  int get points;

  /// Create a copy of CookingMilestone
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CookingMilestoneImplCopyWith<_$CookingMilestoneImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EfficiencyTip _$EfficiencyTipFromJson(Map<String, dynamic> json) {
  return _EfficiencyTip.fromJson(json);
}

/// @nodoc
mixin _$EfficiencyTip {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get title => throw _privateConstructorUsedError;
  @HiveField(2)
  String get description => throw _privateConstructorUsedError;
  @HiveField(3)
  TipCategory get category => throw _privateConstructorUsedError;
  @HiveField(4)
  double get potentialImprovement => throw _privateConstructorUsedError;
  @HiveField(5)
  TipPriority get priority => throw _privateConstructorUsedError;

  /// Serializes this EfficiencyTip to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EfficiencyTip
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EfficiencyTipCopyWith<EfficiencyTip> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EfficiencyTipCopyWith<$Res> {
  factory $EfficiencyTipCopyWith(
          EfficiencyTip value, $Res Function(EfficiencyTip) then) =
      _$EfficiencyTipCopyWithImpl<$Res, EfficiencyTip>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String title,
      @HiveField(2) String description,
      @HiveField(3) TipCategory category,
      @HiveField(4) double potentialImprovement,
      @HiveField(5) TipPriority priority});
}

/// @nodoc
class _$EfficiencyTipCopyWithImpl<$Res, $Val extends EfficiencyTip>
    implements $EfficiencyTipCopyWith<$Res> {
  _$EfficiencyTipCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EfficiencyTip
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? category = null,
    Object? potentialImprovement = null,
    Object? priority = null,
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
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as TipCategory,
      potentialImprovement: null == potentialImprovement
          ? _value.potentialImprovement
          : potentialImprovement // ignore: cast_nullable_to_non_nullable
              as double,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as TipPriority,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EfficiencyTipImplCopyWith<$Res>
    implements $EfficiencyTipCopyWith<$Res> {
  factory _$$EfficiencyTipImplCopyWith(
          _$EfficiencyTipImpl value, $Res Function(_$EfficiencyTipImpl) then) =
      __$$EfficiencyTipImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String title,
      @HiveField(2) String description,
      @HiveField(3) TipCategory category,
      @HiveField(4) double potentialImprovement,
      @HiveField(5) TipPriority priority});
}

/// @nodoc
class __$$EfficiencyTipImplCopyWithImpl<$Res>
    extends _$EfficiencyTipCopyWithImpl<$Res, _$EfficiencyTipImpl>
    implements _$$EfficiencyTipImplCopyWith<$Res> {
  __$$EfficiencyTipImplCopyWithImpl(
      _$EfficiencyTipImpl _value, $Res Function(_$EfficiencyTipImpl) _then)
      : super(_value, _then);

  /// Create a copy of EfficiencyTip
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? category = null,
    Object? potentialImprovement = null,
    Object? priority = null,
  }) {
    return _then(_$EfficiencyTipImpl(
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
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as TipCategory,
      potentialImprovement: null == potentialImprovement
          ? _value.potentialImprovement
          : potentialImprovement // ignore: cast_nullable_to_non_nullable
              as double,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as TipPriority,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EfficiencyTipImpl implements _EfficiencyTip {
  const _$EfficiencyTipImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.title,
      @HiveField(2) required this.description,
      @HiveField(3) required this.category,
      @HiveField(4) required this.potentialImprovement,
      @HiveField(5) this.priority = TipPriority.medium});

  factory _$EfficiencyTipImpl.fromJson(Map<String, dynamic> json) =>
      _$$EfficiencyTipImplFromJson(json);

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
  final TipCategory category;
  @override
  @HiveField(4)
  final double potentialImprovement;
  @override
  @JsonKey()
  @HiveField(5)
  final TipPriority priority;

  @override
  String toString() {
    return 'EfficiencyTip(id: $id, title: $title, description: $description, category: $category, potentialImprovement: $potentialImprovement, priority: $priority)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EfficiencyTipImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.potentialImprovement, potentialImprovement) ||
                other.potentialImprovement == potentialImprovement) &&
            (identical(other.priority, priority) ||
                other.priority == priority));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, description, category,
      potentialImprovement, priority);

  /// Create a copy of EfficiencyTip
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EfficiencyTipImplCopyWith<_$EfficiencyTipImpl> get copyWith =>
      __$$EfficiencyTipImplCopyWithImpl<_$EfficiencyTipImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EfficiencyTipImplToJson(
      this,
    );
  }
}

abstract class _EfficiencyTip implements EfficiencyTip {
  const factory _EfficiencyTip(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String title,
      @HiveField(2) required final String description,
      @HiveField(3) required final TipCategory category,
      @HiveField(4) required final double potentialImprovement,
      @HiveField(5) final TipPriority priority}) = _$EfficiencyTipImpl;

  factory _EfficiencyTip.fromJson(Map<String, dynamic> json) =
      _$EfficiencyTipImpl.fromJson;

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
  TipCategory get category;
  @override
  @HiveField(4)
  double get potentialImprovement;
  @override
  @HiveField(5)
  TipPriority get priority;

  /// Create a copy of EfficiencyTip
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EfficiencyTipImplCopyWith<_$EfficiencyTipImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CostSavingTip _$CostSavingTipFromJson(Map<String, dynamic> json) {
  return _CostSavingTip.fromJson(json);
}

/// @nodoc
mixin _$CostSavingTip {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get title => throw _privateConstructorUsedError;
  @HiveField(2)
  String get description => throw _privateConstructorUsedError;
  @HiveField(3)
  double get potentialSavings => throw _privateConstructorUsedError;
  @HiveField(4)
  TipCategory get category => throw _privateConstructorUsedError;
  @HiveField(5)
  TipPriority get priority => throw _privateConstructorUsedError;

  /// Serializes this CostSavingTip to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CostSavingTip
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CostSavingTipCopyWith<CostSavingTip> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CostSavingTipCopyWith<$Res> {
  factory $CostSavingTipCopyWith(
          CostSavingTip value, $Res Function(CostSavingTip) then) =
      _$CostSavingTipCopyWithImpl<$Res, CostSavingTip>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String title,
      @HiveField(2) String description,
      @HiveField(3) double potentialSavings,
      @HiveField(4) TipCategory category,
      @HiveField(5) TipPriority priority});
}

/// @nodoc
class _$CostSavingTipCopyWithImpl<$Res, $Val extends CostSavingTip>
    implements $CostSavingTipCopyWith<$Res> {
  _$CostSavingTipCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CostSavingTip
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? potentialSavings = null,
    Object? category = null,
    Object? priority = null,
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
      potentialSavings: null == potentialSavings
          ? _value.potentialSavings
          : potentialSavings // ignore: cast_nullable_to_non_nullable
              as double,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as TipCategory,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as TipPriority,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CostSavingTipImplCopyWith<$Res>
    implements $CostSavingTipCopyWith<$Res> {
  factory _$$CostSavingTipImplCopyWith(
          _$CostSavingTipImpl value, $Res Function(_$CostSavingTipImpl) then) =
      __$$CostSavingTipImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String title,
      @HiveField(2) String description,
      @HiveField(3) double potentialSavings,
      @HiveField(4) TipCategory category,
      @HiveField(5) TipPriority priority});
}

/// @nodoc
class __$$CostSavingTipImplCopyWithImpl<$Res>
    extends _$CostSavingTipCopyWithImpl<$Res, _$CostSavingTipImpl>
    implements _$$CostSavingTipImplCopyWith<$Res> {
  __$$CostSavingTipImplCopyWithImpl(
      _$CostSavingTipImpl _value, $Res Function(_$CostSavingTipImpl) _then)
      : super(_value, _then);

  /// Create a copy of CostSavingTip
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? potentialSavings = null,
    Object? category = null,
    Object? priority = null,
  }) {
    return _then(_$CostSavingTipImpl(
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
      potentialSavings: null == potentialSavings
          ? _value.potentialSavings
          : potentialSavings // ignore: cast_nullable_to_non_nullable
              as double,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as TipCategory,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as TipPriority,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CostSavingTipImpl implements _CostSavingTip {
  const _$CostSavingTipImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.title,
      @HiveField(2) required this.description,
      @HiveField(3) required this.potentialSavings,
      @HiveField(4) required this.category,
      @HiveField(5) this.priority = TipPriority.medium});

  factory _$CostSavingTipImpl.fromJson(Map<String, dynamic> json) =>
      _$$CostSavingTipImplFromJson(json);

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
  final double potentialSavings;
  @override
  @HiveField(4)
  final TipCategory category;
  @override
  @JsonKey()
  @HiveField(5)
  final TipPriority priority;

  @override
  String toString() {
    return 'CostSavingTip(id: $id, title: $title, description: $description, potentialSavings: $potentialSavings, category: $category, priority: $priority)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CostSavingTipImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.potentialSavings, potentialSavings) ||
                other.potentialSavings == potentialSavings) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.priority, priority) ||
                other.priority == priority));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, description,
      potentialSavings, category, priority);

  /// Create a copy of CostSavingTip
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CostSavingTipImplCopyWith<_$CostSavingTipImpl> get copyWith =>
      __$$CostSavingTipImplCopyWithImpl<_$CostSavingTipImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CostSavingTipImplToJson(
      this,
    );
  }
}

abstract class _CostSavingTip implements CostSavingTip {
  const factory _CostSavingTip(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String title,
      @HiveField(2) required final String description,
      @HiveField(3) required final double potentialSavings,
      @HiveField(4) required final TipCategory category,
      @HiveField(5) final TipPriority priority}) = _$CostSavingTipImpl;

  factory _CostSavingTip.fromJson(Map<String, dynamic> json) =
      _$CostSavingTipImpl.fromJson;

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
  double get potentialSavings;
  @override
  @HiveField(4)
  TipCategory get category;
  @override
  @HiveField(5)
  TipPriority get priority;

  /// Create a copy of CostSavingTip
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CostSavingTipImplCopyWith<_$CostSavingTipImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HealthInsight _$HealthInsightFromJson(Map<String, dynamic> json) {
  return _HealthInsight.fromJson(json);
}

/// @nodoc
mixin _$HealthInsight {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get title => throw _privateConstructorUsedError;
  @HiveField(2)
  String get description => throw _privateConstructorUsedError;
  @HiveField(3)
  InsightType get type => throw _privateConstructorUsedError;
  @HiveField(4)
  double get impact => throw _privateConstructorUsedError;
  @HiveField(5)
  List<String> get recommendations => throw _privateConstructorUsedError;

  /// Serializes this HealthInsight to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HealthInsight
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HealthInsightCopyWith<HealthInsight> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HealthInsightCopyWith<$Res> {
  factory $HealthInsightCopyWith(
          HealthInsight value, $Res Function(HealthInsight) then) =
      _$HealthInsightCopyWithImpl<$Res, HealthInsight>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String title,
      @HiveField(2) String description,
      @HiveField(3) InsightType type,
      @HiveField(4) double impact,
      @HiveField(5) List<String> recommendations});
}

/// @nodoc
class _$HealthInsightCopyWithImpl<$Res, $Val extends HealthInsight>
    implements $HealthInsightCopyWith<$Res> {
  _$HealthInsightCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HealthInsight
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? type = null,
    Object? impact = null,
    Object? recommendations = null,
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as InsightType,
      impact: null == impact
          ? _value.impact
          : impact // ignore: cast_nullable_to_non_nullable
              as double,
      recommendations: null == recommendations
          ? _value.recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HealthInsightImplCopyWith<$Res>
    implements $HealthInsightCopyWith<$Res> {
  factory _$$HealthInsightImplCopyWith(
          _$HealthInsightImpl value, $Res Function(_$HealthInsightImpl) then) =
      __$$HealthInsightImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String title,
      @HiveField(2) String description,
      @HiveField(3) InsightType type,
      @HiveField(4) double impact,
      @HiveField(5) List<String> recommendations});
}

/// @nodoc
class __$$HealthInsightImplCopyWithImpl<$Res>
    extends _$HealthInsightCopyWithImpl<$Res, _$HealthInsightImpl>
    implements _$$HealthInsightImplCopyWith<$Res> {
  __$$HealthInsightImplCopyWithImpl(
      _$HealthInsightImpl _value, $Res Function(_$HealthInsightImpl) _then)
      : super(_value, _then);

  /// Create a copy of HealthInsight
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? type = null,
    Object? impact = null,
    Object? recommendations = null,
  }) {
    return _then(_$HealthInsightImpl(
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as InsightType,
      impact: null == impact
          ? _value.impact
          : impact // ignore: cast_nullable_to_non_nullable
              as double,
      recommendations: null == recommendations
          ? _value._recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HealthInsightImpl implements _HealthInsight {
  const _$HealthInsightImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.title,
      @HiveField(2) required this.description,
      @HiveField(3) required this.type,
      @HiveField(4) required this.impact,
      @HiveField(5) final List<String> recommendations = const []})
      : _recommendations = recommendations;

  factory _$HealthInsightImpl.fromJson(Map<String, dynamic> json) =>
      _$$HealthInsightImplFromJson(json);

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
  final InsightType type;
  @override
  @HiveField(4)
  final double impact;
  final List<String> _recommendations;
  @override
  @JsonKey()
  @HiveField(5)
  List<String> get recommendations {
    if (_recommendations is EqualUnmodifiableListView) return _recommendations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recommendations);
  }

  @override
  String toString() {
    return 'HealthInsight(id: $id, title: $title, description: $description, type: $type, impact: $impact, recommendations: $recommendations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HealthInsightImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.impact, impact) || other.impact == impact) &&
            const DeepCollectionEquality()
                .equals(other._recommendations, _recommendations));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, description, type,
      impact, const DeepCollectionEquality().hash(_recommendations));

  /// Create a copy of HealthInsight
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HealthInsightImplCopyWith<_$HealthInsightImpl> get copyWith =>
      __$$HealthInsightImplCopyWithImpl<_$HealthInsightImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HealthInsightImplToJson(
      this,
    );
  }
}

abstract class _HealthInsight implements HealthInsight {
  const factory _HealthInsight(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String title,
      @HiveField(2) required final String description,
      @HiveField(3) required final InsightType type,
      @HiveField(4) required final double impact,
      @HiveField(5) final List<String> recommendations}) = _$HealthInsightImpl;

  factory _HealthInsight.fromJson(Map<String, dynamic> json) =
      _$HealthInsightImpl.fromJson;

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
  InsightType get type;
  @override
  @HiveField(4)
  double get impact;
  @override
  @HiveField(5)
  List<String> get recommendations;

  /// Create a copy of HealthInsight
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HealthInsightImplCopyWith<_$HealthInsightImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SustainabilityTip _$SustainabilityTipFromJson(Map<String, dynamic> json) {
  return _SustainabilityTip.fromJson(json);
}

/// @nodoc
mixin _$SustainabilityTip {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get title => throw _privateConstructorUsedError;
  @HiveField(2)
  String get description => throw _privateConstructorUsedError;
  @HiveField(3)
  double get environmentalImpact => throw _privateConstructorUsedError;
  @HiveField(4)
  TipCategory get category => throw _privateConstructorUsedError;
  @HiveField(5)
  TipPriority get priority => throw _privateConstructorUsedError;

  /// Serializes this SustainabilityTip to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SustainabilityTip
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SustainabilityTipCopyWith<SustainabilityTip> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SustainabilityTipCopyWith<$Res> {
  factory $SustainabilityTipCopyWith(
          SustainabilityTip value, $Res Function(SustainabilityTip) then) =
      _$SustainabilityTipCopyWithImpl<$Res, SustainabilityTip>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String title,
      @HiveField(2) String description,
      @HiveField(3) double environmentalImpact,
      @HiveField(4) TipCategory category,
      @HiveField(5) TipPriority priority});
}

/// @nodoc
class _$SustainabilityTipCopyWithImpl<$Res, $Val extends SustainabilityTip>
    implements $SustainabilityTipCopyWith<$Res> {
  _$SustainabilityTipCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SustainabilityTip
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? environmentalImpact = null,
    Object? category = null,
    Object? priority = null,
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
      environmentalImpact: null == environmentalImpact
          ? _value.environmentalImpact
          : environmentalImpact // ignore: cast_nullable_to_non_nullable
              as double,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as TipCategory,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as TipPriority,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SustainabilityTipImplCopyWith<$Res>
    implements $SustainabilityTipCopyWith<$Res> {
  factory _$$SustainabilityTipImplCopyWith(_$SustainabilityTipImpl value,
          $Res Function(_$SustainabilityTipImpl) then) =
      __$$SustainabilityTipImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String title,
      @HiveField(2) String description,
      @HiveField(3) double environmentalImpact,
      @HiveField(4) TipCategory category,
      @HiveField(5) TipPriority priority});
}

/// @nodoc
class __$$SustainabilityTipImplCopyWithImpl<$Res>
    extends _$SustainabilityTipCopyWithImpl<$Res, _$SustainabilityTipImpl>
    implements _$$SustainabilityTipImplCopyWith<$Res> {
  __$$SustainabilityTipImplCopyWithImpl(_$SustainabilityTipImpl _value,
      $Res Function(_$SustainabilityTipImpl) _then)
      : super(_value, _then);

  /// Create a copy of SustainabilityTip
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? environmentalImpact = null,
    Object? category = null,
    Object? priority = null,
  }) {
    return _then(_$SustainabilityTipImpl(
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
      environmentalImpact: null == environmentalImpact
          ? _value.environmentalImpact
          : environmentalImpact // ignore: cast_nullable_to_non_nullable
              as double,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as TipCategory,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as TipPriority,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SustainabilityTipImpl implements _SustainabilityTip {
  const _$SustainabilityTipImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.title,
      @HiveField(2) required this.description,
      @HiveField(3) required this.environmentalImpact,
      @HiveField(4) required this.category,
      @HiveField(5) this.priority = TipPriority.medium});

  factory _$SustainabilityTipImpl.fromJson(Map<String, dynamic> json) =>
      _$$SustainabilityTipImplFromJson(json);

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
  final double environmentalImpact;
  @override
  @HiveField(4)
  final TipCategory category;
  @override
  @JsonKey()
  @HiveField(5)
  final TipPriority priority;

  @override
  String toString() {
    return 'SustainabilityTip(id: $id, title: $title, description: $description, environmentalImpact: $environmentalImpact, category: $category, priority: $priority)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SustainabilityTipImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.environmentalImpact, environmentalImpact) ||
                other.environmentalImpact == environmentalImpact) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.priority, priority) ||
                other.priority == priority));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, description,
      environmentalImpact, category, priority);

  /// Create a copy of SustainabilityTip
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SustainabilityTipImplCopyWith<_$SustainabilityTipImpl> get copyWith =>
      __$$SustainabilityTipImplCopyWithImpl<_$SustainabilityTipImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SustainabilityTipImplToJson(
      this,
    );
  }
}

abstract class _SustainabilityTip implements SustainabilityTip {
  const factory _SustainabilityTip(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String title,
      @HiveField(2) required final String description,
      @HiveField(3) required final double environmentalImpact,
      @HiveField(4) required final TipCategory category,
      @HiveField(5) final TipPriority priority}) = _$SustainabilityTipImpl;

  factory _SustainabilityTip.fromJson(Map<String, dynamic> json) =
      _$SustainabilityTipImpl.fromJson;

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
  double get environmentalImpact;
  @override
  @HiveField(4)
  TipCategory get category;
  @override
  @HiveField(5)
  TipPriority get priority;

  /// Create a copy of SustainabilityTip
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SustainabilityTipImplCopyWith<_$SustainabilityTipImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PriceHistory _$PriceHistoryFromJson(Map<String, dynamic> json) {
  return _PriceHistory.fromJson(json);
}

/// @nodoc
mixin _$PriceHistory {
  @HiveField(0)
  String get itemName => throw _privateConstructorUsedError;
  @HiveField(1)
  List<PricePoint> get pricePoints => throw _privateConstructorUsedError;
  @HiveField(2)
  double get averagePrice => throw _privateConstructorUsedError;
  @HiveField(3)
  double get lowestPrice => throw _privateConstructorUsedError;
  @HiveField(4)
  double get highestPrice => throw _privateConstructorUsedError;
  @HiveField(5)
  TrendDirection get priceTrend => throw _privateConstructorUsedError;

  /// Serializes this PriceHistory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PriceHistory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PriceHistoryCopyWith<PriceHistory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PriceHistoryCopyWith<$Res> {
  factory $PriceHistoryCopyWith(
          PriceHistory value, $Res Function(PriceHistory) then) =
      _$PriceHistoryCopyWithImpl<$Res, PriceHistory>;
  @useResult
  $Res call(
      {@HiveField(0) String itemName,
      @HiveField(1) List<PricePoint> pricePoints,
      @HiveField(2) double averagePrice,
      @HiveField(3) double lowestPrice,
      @HiveField(4) double highestPrice,
      @HiveField(5) TrendDirection priceTrend});
}

/// @nodoc
class _$PriceHistoryCopyWithImpl<$Res, $Val extends PriceHistory>
    implements $PriceHistoryCopyWith<$Res> {
  _$PriceHistoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PriceHistory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemName = null,
    Object? pricePoints = null,
    Object? averagePrice = null,
    Object? lowestPrice = null,
    Object? highestPrice = null,
    Object? priceTrend = null,
  }) {
    return _then(_value.copyWith(
      itemName: null == itemName
          ? _value.itemName
          : itemName // ignore: cast_nullable_to_non_nullable
              as String,
      pricePoints: null == pricePoints
          ? _value.pricePoints
          : pricePoints // ignore: cast_nullable_to_non_nullable
              as List<PricePoint>,
      averagePrice: null == averagePrice
          ? _value.averagePrice
          : averagePrice // ignore: cast_nullable_to_non_nullable
              as double,
      lowestPrice: null == lowestPrice
          ? _value.lowestPrice
          : lowestPrice // ignore: cast_nullable_to_non_nullable
              as double,
      highestPrice: null == highestPrice
          ? _value.highestPrice
          : highestPrice // ignore: cast_nullable_to_non_nullable
              as double,
      priceTrend: null == priceTrend
          ? _value.priceTrend
          : priceTrend // ignore: cast_nullable_to_non_nullable
              as TrendDirection,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PriceHistoryImplCopyWith<$Res>
    implements $PriceHistoryCopyWith<$Res> {
  factory _$$PriceHistoryImplCopyWith(
          _$PriceHistoryImpl value, $Res Function(_$PriceHistoryImpl) then) =
      __$$PriceHistoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String itemName,
      @HiveField(1) List<PricePoint> pricePoints,
      @HiveField(2) double averagePrice,
      @HiveField(3) double lowestPrice,
      @HiveField(4) double highestPrice,
      @HiveField(5) TrendDirection priceTrend});
}

/// @nodoc
class __$$PriceHistoryImplCopyWithImpl<$Res>
    extends _$PriceHistoryCopyWithImpl<$Res, _$PriceHistoryImpl>
    implements _$$PriceHistoryImplCopyWith<$Res> {
  __$$PriceHistoryImplCopyWithImpl(
      _$PriceHistoryImpl _value, $Res Function(_$PriceHistoryImpl) _then)
      : super(_value, _then);

  /// Create a copy of PriceHistory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemName = null,
    Object? pricePoints = null,
    Object? averagePrice = null,
    Object? lowestPrice = null,
    Object? highestPrice = null,
    Object? priceTrend = null,
  }) {
    return _then(_$PriceHistoryImpl(
      itemName: null == itemName
          ? _value.itemName
          : itemName // ignore: cast_nullable_to_non_nullable
              as String,
      pricePoints: null == pricePoints
          ? _value._pricePoints
          : pricePoints // ignore: cast_nullable_to_non_nullable
              as List<PricePoint>,
      averagePrice: null == averagePrice
          ? _value.averagePrice
          : averagePrice // ignore: cast_nullable_to_non_nullable
              as double,
      lowestPrice: null == lowestPrice
          ? _value.lowestPrice
          : lowestPrice // ignore: cast_nullable_to_non_nullable
              as double,
      highestPrice: null == highestPrice
          ? _value.highestPrice
          : highestPrice // ignore: cast_nullable_to_non_nullable
              as double,
      priceTrend: null == priceTrend
          ? _value.priceTrend
          : priceTrend // ignore: cast_nullable_to_non_nullable
              as TrendDirection,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PriceHistoryImpl implements _PriceHistory {
  const _$PriceHistoryImpl(
      {@HiveField(0) required this.itemName,
      @HiveField(1) required final List<PricePoint> pricePoints,
      @HiveField(2) required this.averagePrice,
      @HiveField(3) required this.lowestPrice,
      @HiveField(4) required this.highestPrice,
      @HiveField(5) required this.priceTrend})
      : _pricePoints = pricePoints;

  factory _$PriceHistoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$PriceHistoryImplFromJson(json);

  @override
  @HiveField(0)
  final String itemName;
  final List<PricePoint> _pricePoints;
  @override
  @HiveField(1)
  List<PricePoint> get pricePoints {
    if (_pricePoints is EqualUnmodifiableListView) return _pricePoints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pricePoints);
  }

  @override
  @HiveField(2)
  final double averagePrice;
  @override
  @HiveField(3)
  final double lowestPrice;
  @override
  @HiveField(4)
  final double highestPrice;
  @override
  @HiveField(5)
  final TrendDirection priceTrend;

  @override
  String toString() {
    return 'PriceHistory(itemName: $itemName, pricePoints: $pricePoints, averagePrice: $averagePrice, lowestPrice: $lowestPrice, highestPrice: $highestPrice, priceTrend: $priceTrend)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PriceHistoryImpl &&
            (identical(other.itemName, itemName) ||
                other.itemName == itemName) &&
            const DeepCollectionEquality()
                .equals(other._pricePoints, _pricePoints) &&
            (identical(other.averagePrice, averagePrice) ||
                other.averagePrice == averagePrice) &&
            (identical(other.lowestPrice, lowestPrice) ||
                other.lowestPrice == lowestPrice) &&
            (identical(other.highestPrice, highestPrice) ||
                other.highestPrice == highestPrice) &&
            (identical(other.priceTrend, priceTrend) ||
                other.priceTrend == priceTrend));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      itemName,
      const DeepCollectionEquality().hash(_pricePoints),
      averagePrice,
      lowestPrice,
      highestPrice,
      priceTrend);

  /// Create a copy of PriceHistory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PriceHistoryImplCopyWith<_$PriceHistoryImpl> get copyWith =>
      __$$PriceHistoryImplCopyWithImpl<_$PriceHistoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PriceHistoryImplToJson(
      this,
    );
  }
}

abstract class _PriceHistory implements PriceHistory {
  const factory _PriceHistory(
          {@HiveField(0) required final String itemName,
          @HiveField(1) required final List<PricePoint> pricePoints,
          @HiveField(2) required final double averagePrice,
          @HiveField(3) required final double lowestPrice,
          @HiveField(4) required final double highestPrice,
          @HiveField(5) required final TrendDirection priceTrend}) =
      _$PriceHistoryImpl;

  factory _PriceHistory.fromJson(Map<String, dynamic> json) =
      _$PriceHistoryImpl.fromJson;

  @override
  @HiveField(0)
  String get itemName;
  @override
  @HiveField(1)
  List<PricePoint> get pricePoints;
  @override
  @HiveField(2)
  double get averagePrice;
  @override
  @HiveField(3)
  double get lowestPrice;
  @override
  @HiveField(4)
  double get highestPrice;
  @override
  @HiveField(5)
  TrendDirection get priceTrend;

  /// Create a copy of PriceHistory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PriceHistoryImplCopyWith<_$PriceHistoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PricePoint _$PricePointFromJson(Map<String, dynamic> json) {
  return _PricePoint.fromJson(json);
}

/// @nodoc
mixin _$PricePoint {
  @HiveField(0)
  DateTime get date => throw _privateConstructorUsedError;
  @HiveField(1)
  double get price => throw _privateConstructorUsedError;
  @HiveField(2)
  String? get store => throw _privateConstructorUsedError;
  @HiveField(3)
  String? get location => throw _privateConstructorUsedError;

  /// Serializes this PricePoint to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PricePoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PricePointCopyWith<PricePoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PricePointCopyWith<$Res> {
  factory $PricePointCopyWith(
          PricePoint value, $Res Function(PricePoint) then) =
      _$PricePointCopyWithImpl<$Res, PricePoint>;
  @useResult
  $Res call(
      {@HiveField(0) DateTime date,
      @HiveField(1) double price,
      @HiveField(2) String? store,
      @HiveField(3) String? location});
}

/// @nodoc
class _$PricePointCopyWithImpl<$Res, $Val extends PricePoint>
    implements $PricePointCopyWith<$Res> {
  _$PricePointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PricePoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? price = null,
    Object? store = freezed,
    Object? location = freezed,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      store: freezed == store
          ? _value.store
          : store // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PricePointImplCopyWith<$Res>
    implements $PricePointCopyWith<$Res> {
  factory _$$PricePointImplCopyWith(
          _$PricePointImpl value, $Res Function(_$PricePointImpl) then) =
      __$$PricePointImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) DateTime date,
      @HiveField(1) double price,
      @HiveField(2) String? store,
      @HiveField(3) String? location});
}

/// @nodoc
class __$$PricePointImplCopyWithImpl<$Res>
    extends _$PricePointCopyWithImpl<$Res, _$PricePointImpl>
    implements _$$PricePointImplCopyWith<$Res> {
  __$$PricePointImplCopyWithImpl(
      _$PricePointImpl _value, $Res Function(_$PricePointImpl) _then)
      : super(_value, _then);

  /// Create a copy of PricePoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? price = null,
    Object? store = freezed,
    Object? location = freezed,
  }) {
    return _then(_$PricePointImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      store: freezed == store
          ? _value.store
          : store // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PricePointImpl implements _PricePoint {
  const _$PricePointImpl(
      {@HiveField(0) required this.date,
      @HiveField(1) required this.price,
      @HiveField(2) this.store,
      @HiveField(3) this.location});

  factory _$PricePointImpl.fromJson(Map<String, dynamic> json) =>
      _$$PricePointImplFromJson(json);

  @override
  @HiveField(0)
  final DateTime date;
  @override
  @HiveField(1)
  final double price;
  @override
  @HiveField(2)
  final String? store;
  @override
  @HiveField(3)
  final String? location;

  @override
  String toString() {
    return 'PricePoint(date: $date, price: $price, store: $store, location: $location)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PricePointImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.store, store) || other.store == store) &&
            (identical(other.location, location) ||
                other.location == location));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, date, price, store, location);

  /// Create a copy of PricePoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PricePointImplCopyWith<_$PricePointImpl> get copyWith =>
      __$$PricePointImplCopyWithImpl<_$PricePointImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PricePointImplToJson(
      this,
    );
  }
}

abstract class _PricePoint implements PricePoint {
  const factory _PricePoint(
      {@HiveField(0) required final DateTime date,
      @HiveField(1) required final double price,
      @HiveField(2) final String? store,
      @HiveField(3) final String? location}) = _$PricePointImpl;

  factory _PricePoint.fromJson(Map<String, dynamic> json) =
      _$PricePointImpl.fromJson;

  @override
  @HiveField(0)
  DateTime get date;
  @override
  @HiveField(1)
  double get price;
  @override
  @HiveField(2)
  String? get store;
  @override
  @HiveField(3)
  String? get location;

  /// Create a copy of PricePoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PricePointImplCopyWith<_$PricePointImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
