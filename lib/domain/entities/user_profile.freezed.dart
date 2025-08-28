// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) {
  return _UserProfile.fromJson(json);
}

/// @nodoc
mixin _$UserProfile {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get name => throw _privateConstructorUsedError;
  @HiveField(2)
  String get email => throw _privateConstructorUsedError;
  @HiveField(3)
  List<DietaryRestriction> get dietaryRestrictions =>
      throw _privateConstructorUsedError;
  @HiveField(4)
  List<String> get allergies => throw _privateConstructorUsedError;
  @HiveField(5)
  SkillLevel get skillLevel => throw _privateConstructorUsedError;
  @HiveField(6)
  List<KitchenEquipment> get equipment => throw _privateConstructorUsedError;
  @HiveField(7)
  CookingPreferences get preferences => throw _privateConstructorUsedError;
  @HiveField(8)
  DateTime get createdAt => throw _privateConstructorUsedError;
  @HiveField(9)
  DateTime get lastUpdated => throw _privateConstructorUsedError;
  @HiveField(10)
  String? get profileImageUrl => throw _privateConstructorUsedError;
  @HiveField(11)
  int get totalRecipesCooked => throw _privateConstructorUsedError;
  @HiveField(12)
  int get favoriteRecipesCount => throw _privateConstructorUsedError;

  /// Serializes this UserProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserProfileCopyWith<UserProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileCopyWith<$Res> {
  factory $UserProfileCopyWith(
          UserProfile value, $Res Function(UserProfile) then) =
      _$UserProfileCopyWithImpl<$Res, UserProfile>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String name,
      @HiveField(2) String email,
      @HiveField(3) List<DietaryRestriction> dietaryRestrictions,
      @HiveField(4) List<String> allergies,
      @HiveField(5) SkillLevel skillLevel,
      @HiveField(6) List<KitchenEquipment> equipment,
      @HiveField(7) CookingPreferences preferences,
      @HiveField(8) DateTime createdAt,
      @HiveField(9) DateTime lastUpdated,
      @HiveField(10) String? profileImageUrl,
      @HiveField(11) int totalRecipesCooked,
      @HiveField(12) int favoriteRecipesCount});

  $CookingPreferencesCopyWith<$Res> get preferences;
}

/// @nodoc
class _$UserProfileCopyWithImpl<$Res, $Val extends UserProfile>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? dietaryRestrictions = null,
    Object? allergies = null,
    Object? skillLevel = null,
    Object? equipment = null,
    Object? preferences = null,
    Object? createdAt = null,
    Object? lastUpdated = null,
    Object? profileImageUrl = freezed,
    Object? totalRecipesCooked = null,
    Object? favoriteRecipesCount = null,
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
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      dietaryRestrictions: null == dietaryRestrictions
          ? _value.dietaryRestrictions
          : dietaryRestrictions // ignore: cast_nullable_to_non_nullable
              as List<DietaryRestriction>,
      allergies: null == allergies
          ? _value.allergies
          : allergies // ignore: cast_nullable_to_non_nullable
              as List<String>,
      skillLevel: null == skillLevel
          ? _value.skillLevel
          : skillLevel // ignore: cast_nullable_to_non_nullable
              as SkillLevel,
      equipment: null == equipment
          ? _value.equipment
          : equipment // ignore: cast_nullable_to_non_nullable
              as List<KitchenEquipment>,
      preferences: null == preferences
          ? _value.preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as CookingPreferences,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      profileImageUrl: freezed == profileImageUrl
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      totalRecipesCooked: null == totalRecipesCooked
          ? _value.totalRecipesCooked
          : totalRecipesCooked // ignore: cast_nullable_to_non_nullable
              as int,
      favoriteRecipesCount: null == favoriteRecipesCount
          ? _value.favoriteRecipesCount
          : favoriteRecipesCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CookingPreferencesCopyWith<$Res> get preferences {
    return $CookingPreferencesCopyWith<$Res>(_value.preferences, (value) {
      return _then(_value.copyWith(preferences: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserProfileImplCopyWith<$Res>
    implements $UserProfileCopyWith<$Res> {
  factory _$$UserProfileImplCopyWith(
          _$UserProfileImpl value, $Res Function(_$UserProfileImpl) then) =
      __$$UserProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String name,
      @HiveField(2) String email,
      @HiveField(3) List<DietaryRestriction> dietaryRestrictions,
      @HiveField(4) List<String> allergies,
      @HiveField(5) SkillLevel skillLevel,
      @HiveField(6) List<KitchenEquipment> equipment,
      @HiveField(7) CookingPreferences preferences,
      @HiveField(8) DateTime createdAt,
      @HiveField(9) DateTime lastUpdated,
      @HiveField(10) String? profileImageUrl,
      @HiveField(11) int totalRecipesCooked,
      @HiveField(12) int favoriteRecipesCount});

  @override
  $CookingPreferencesCopyWith<$Res> get preferences;
}

/// @nodoc
class __$$UserProfileImplCopyWithImpl<$Res>
    extends _$UserProfileCopyWithImpl<$Res, _$UserProfileImpl>
    implements _$$UserProfileImplCopyWith<$Res> {
  __$$UserProfileImplCopyWithImpl(
      _$UserProfileImpl _value, $Res Function(_$UserProfileImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? dietaryRestrictions = null,
    Object? allergies = null,
    Object? skillLevel = null,
    Object? equipment = null,
    Object? preferences = null,
    Object? createdAt = null,
    Object? lastUpdated = null,
    Object? profileImageUrl = freezed,
    Object? totalRecipesCooked = null,
    Object? favoriteRecipesCount = null,
  }) {
    return _then(_$UserProfileImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      dietaryRestrictions: null == dietaryRestrictions
          ? _value._dietaryRestrictions
          : dietaryRestrictions // ignore: cast_nullable_to_non_nullable
              as List<DietaryRestriction>,
      allergies: null == allergies
          ? _value._allergies
          : allergies // ignore: cast_nullable_to_non_nullable
              as List<String>,
      skillLevel: null == skillLevel
          ? _value.skillLevel
          : skillLevel // ignore: cast_nullable_to_non_nullable
              as SkillLevel,
      equipment: null == equipment
          ? _value._equipment
          : equipment // ignore: cast_nullable_to_non_nullable
              as List<KitchenEquipment>,
      preferences: null == preferences
          ? _value.preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as CookingPreferences,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      profileImageUrl: freezed == profileImageUrl
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      totalRecipesCooked: null == totalRecipesCooked
          ? _value.totalRecipesCooked
          : totalRecipesCooked // ignore: cast_nullable_to_non_nullable
              as int,
      favoriteRecipesCount: null == favoriteRecipesCount
          ? _value.favoriteRecipesCount
          : favoriteRecipesCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserProfileImpl implements _UserProfile {
  const _$UserProfileImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.name,
      @HiveField(2) required this.email,
      @HiveField(3)
      final List<DietaryRestriction> dietaryRestrictions = const [],
      @HiveField(4) final List<String> allergies = const [],
      @HiveField(5) this.skillLevel = SkillLevel.beginner,
      @HiveField(6) final List<KitchenEquipment> equipment = const [],
      @HiveField(7) required this.preferences,
      @HiveField(8) required this.createdAt,
      @HiveField(9) required this.lastUpdated,
      @HiveField(10) this.profileImageUrl,
      @HiveField(11) this.totalRecipesCooked = 0,
      @HiveField(12) this.favoriteRecipesCount = 0})
      : _dietaryRestrictions = dietaryRestrictions,
        _allergies = allergies,
        _equipment = equipment;

  factory _$UserProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserProfileImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String name;
  @override
  @HiveField(2)
  final String email;
  final List<DietaryRestriction> _dietaryRestrictions;
  @override
  @JsonKey()
  @HiveField(3)
  List<DietaryRestriction> get dietaryRestrictions {
    if (_dietaryRestrictions is EqualUnmodifiableListView)
      return _dietaryRestrictions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dietaryRestrictions);
  }

  final List<String> _allergies;
  @override
  @JsonKey()
  @HiveField(4)
  List<String> get allergies {
    if (_allergies is EqualUnmodifiableListView) return _allergies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allergies);
  }

  @override
  @JsonKey()
  @HiveField(5)
  final SkillLevel skillLevel;
  final List<KitchenEquipment> _equipment;
  @override
  @JsonKey()
  @HiveField(6)
  List<KitchenEquipment> get equipment {
    if (_equipment is EqualUnmodifiableListView) return _equipment;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_equipment);
  }

  @override
  @HiveField(7)
  final CookingPreferences preferences;
  @override
  @HiveField(8)
  final DateTime createdAt;
  @override
  @HiveField(9)
  final DateTime lastUpdated;
  @override
  @HiveField(10)
  final String? profileImageUrl;
  @override
  @JsonKey()
  @HiveField(11)
  final int totalRecipesCooked;
  @override
  @JsonKey()
  @HiveField(12)
  final int favoriteRecipesCount;

  @override
  String toString() {
    return 'UserProfile(id: $id, name: $name, email: $email, dietaryRestrictions: $dietaryRestrictions, allergies: $allergies, skillLevel: $skillLevel, equipment: $equipment, preferences: $preferences, createdAt: $createdAt, lastUpdated: $lastUpdated, profileImageUrl: $profileImageUrl, totalRecipesCooked: $totalRecipesCooked, favoriteRecipesCount: $favoriteRecipesCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            const DeepCollectionEquality()
                .equals(other._dietaryRestrictions, _dietaryRestrictions) &&
            const DeepCollectionEquality()
                .equals(other._allergies, _allergies) &&
            (identical(other.skillLevel, skillLevel) ||
                other.skillLevel == skillLevel) &&
            const DeepCollectionEquality()
                .equals(other._equipment, _equipment) &&
            (identical(other.preferences, preferences) ||
                other.preferences == preferences) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated) &&
            (identical(other.profileImageUrl, profileImageUrl) ||
                other.profileImageUrl == profileImageUrl) &&
            (identical(other.totalRecipesCooked, totalRecipesCooked) ||
                other.totalRecipesCooked == totalRecipesCooked) &&
            (identical(other.favoriteRecipesCount, favoriteRecipesCount) ||
                other.favoriteRecipesCount == favoriteRecipesCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      email,
      const DeepCollectionEquality().hash(_dietaryRestrictions),
      const DeepCollectionEquality().hash(_allergies),
      skillLevel,
      const DeepCollectionEquality().hash(_equipment),
      preferences,
      createdAt,
      lastUpdated,
      profileImageUrl,
      totalRecipesCooked,
      favoriteRecipesCount);

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      __$$UserProfileImplCopyWithImpl<_$UserProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserProfileImplToJson(
      this,
    );
  }
}

abstract class _UserProfile implements UserProfile {
  const factory _UserProfile(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String name,
      @HiveField(2) required final String email,
      @HiveField(3) final List<DietaryRestriction> dietaryRestrictions,
      @HiveField(4) final List<String> allergies,
      @HiveField(5) final SkillLevel skillLevel,
      @HiveField(6) final List<KitchenEquipment> equipment,
      @HiveField(7) required final CookingPreferences preferences,
      @HiveField(8) required final DateTime createdAt,
      @HiveField(9) required final DateTime lastUpdated,
      @HiveField(10) final String? profileImageUrl,
      @HiveField(11) final int totalRecipesCooked,
      @HiveField(12) final int favoriteRecipesCount}) = _$UserProfileImpl;

  factory _UserProfile.fromJson(Map<String, dynamic> json) =
      _$UserProfileImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get name;
  @override
  @HiveField(2)
  String get email;
  @override
  @HiveField(3)
  List<DietaryRestriction> get dietaryRestrictions;
  @override
  @HiveField(4)
  List<String> get allergies;
  @override
  @HiveField(5)
  SkillLevel get skillLevel;
  @override
  @HiveField(6)
  List<KitchenEquipment> get equipment;
  @override
  @HiveField(7)
  CookingPreferences get preferences;
  @override
  @HiveField(8)
  DateTime get createdAt;
  @override
  @HiveField(9)
  DateTime get lastUpdated;
  @override
  @HiveField(10)
  String? get profileImageUrl;
  @override
  @HiveField(11)
  int get totalRecipesCooked;
  @override
  @HiveField(12)
  int get favoriteRecipesCount;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CookingPreferences _$CookingPreferencesFromJson(Map<String, dynamic> json) {
  return _CookingPreferences.fromJson(json);
}

/// @nodoc
mixin _$CookingPreferences {
  @HiveField(0)
  List<String> get favoriteCuisines => throw _privateConstructorUsedError;
  @HiveField(1)
  int get maxCookingTimeMinutes => throw _privateConstructorUsedError;
  @HiveField(2)
  DifficultyLevel get maxDifficulty => throw _privateConstructorUsedError;
  @HiveField(3)
  int get defaultServings => throw _privateConstructorUsedError;
  @HiveField(4)
  bool get preferQuickMeals => throw _privateConstructorUsedError;
  @HiveField(5)
  bool get preferHealthyOptions => throw _privateConstructorUsedError;
  @HiveField(6)
  List<String> get dislikedIngredients => throw _privateConstructorUsedError;
  @HiveField(7)
  SpiceLevel get spicePreference => throw _privateConstructorUsedError;

  /// Serializes this CookingPreferences to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CookingPreferences
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CookingPreferencesCopyWith<CookingPreferences> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CookingPreferencesCopyWith<$Res> {
  factory $CookingPreferencesCopyWith(
          CookingPreferences value, $Res Function(CookingPreferences) then) =
      _$CookingPreferencesCopyWithImpl<$Res, CookingPreferences>;
  @useResult
  $Res call(
      {@HiveField(0) List<String> favoriteCuisines,
      @HiveField(1) int maxCookingTimeMinutes,
      @HiveField(2) DifficultyLevel maxDifficulty,
      @HiveField(3) int defaultServings,
      @HiveField(4) bool preferQuickMeals,
      @HiveField(5) bool preferHealthyOptions,
      @HiveField(6) List<String> dislikedIngredients,
      @HiveField(7) SpiceLevel spicePreference});
}

/// @nodoc
class _$CookingPreferencesCopyWithImpl<$Res, $Val extends CookingPreferences>
    implements $CookingPreferencesCopyWith<$Res> {
  _$CookingPreferencesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CookingPreferences
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? favoriteCuisines = null,
    Object? maxCookingTimeMinutes = null,
    Object? maxDifficulty = null,
    Object? defaultServings = null,
    Object? preferQuickMeals = null,
    Object? preferHealthyOptions = null,
    Object? dislikedIngredients = null,
    Object? spicePreference = null,
  }) {
    return _then(_value.copyWith(
      favoriteCuisines: null == favoriteCuisines
          ? _value.favoriteCuisines
          : favoriteCuisines // ignore: cast_nullable_to_non_nullable
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
      preferQuickMeals: null == preferQuickMeals
          ? _value.preferQuickMeals
          : preferQuickMeals // ignore: cast_nullable_to_non_nullable
              as bool,
      preferHealthyOptions: null == preferHealthyOptions
          ? _value.preferHealthyOptions
          : preferHealthyOptions // ignore: cast_nullable_to_non_nullable
              as bool,
      dislikedIngredients: null == dislikedIngredients
          ? _value.dislikedIngredients
          : dislikedIngredients // ignore: cast_nullable_to_non_nullable
              as List<String>,
      spicePreference: null == spicePreference
          ? _value.spicePreference
          : spicePreference // ignore: cast_nullable_to_non_nullable
              as SpiceLevel,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CookingPreferencesImplCopyWith<$Res>
    implements $CookingPreferencesCopyWith<$Res> {
  factory _$$CookingPreferencesImplCopyWith(_$CookingPreferencesImpl value,
          $Res Function(_$CookingPreferencesImpl) then) =
      __$$CookingPreferencesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) List<String> favoriteCuisines,
      @HiveField(1) int maxCookingTimeMinutes,
      @HiveField(2) DifficultyLevel maxDifficulty,
      @HiveField(3) int defaultServings,
      @HiveField(4) bool preferQuickMeals,
      @HiveField(5) bool preferHealthyOptions,
      @HiveField(6) List<String> dislikedIngredients,
      @HiveField(7) SpiceLevel spicePreference});
}

/// @nodoc
class __$$CookingPreferencesImplCopyWithImpl<$Res>
    extends _$CookingPreferencesCopyWithImpl<$Res, _$CookingPreferencesImpl>
    implements _$$CookingPreferencesImplCopyWith<$Res> {
  __$$CookingPreferencesImplCopyWithImpl(_$CookingPreferencesImpl _value,
      $Res Function(_$CookingPreferencesImpl) _then)
      : super(_value, _then);

  /// Create a copy of CookingPreferences
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? favoriteCuisines = null,
    Object? maxCookingTimeMinutes = null,
    Object? maxDifficulty = null,
    Object? defaultServings = null,
    Object? preferQuickMeals = null,
    Object? preferHealthyOptions = null,
    Object? dislikedIngredients = null,
    Object? spicePreference = null,
  }) {
    return _then(_$CookingPreferencesImpl(
      favoriteCuisines: null == favoriteCuisines
          ? _value._favoriteCuisines
          : favoriteCuisines // ignore: cast_nullable_to_non_nullable
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
      preferQuickMeals: null == preferQuickMeals
          ? _value.preferQuickMeals
          : preferQuickMeals // ignore: cast_nullable_to_non_nullable
              as bool,
      preferHealthyOptions: null == preferHealthyOptions
          ? _value.preferHealthyOptions
          : preferHealthyOptions // ignore: cast_nullable_to_non_nullable
              as bool,
      dislikedIngredients: null == dislikedIngredients
          ? _value._dislikedIngredients
          : dislikedIngredients // ignore: cast_nullable_to_non_nullable
              as List<String>,
      spicePreference: null == spicePreference
          ? _value.spicePreference
          : spicePreference // ignore: cast_nullable_to_non_nullable
              as SpiceLevel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CookingPreferencesImpl implements _CookingPreferences {
  const _$CookingPreferencesImpl(
      {@HiveField(0) final List<String> favoriteCuisines = const [],
      @HiveField(1) this.maxCookingTimeMinutes = 30,
      @HiveField(2) this.maxDifficulty = DifficultyLevel.intermediate,
      @HiveField(3) this.defaultServings = 4,
      @HiveField(4) this.preferQuickMeals = false,
      @HiveField(5) this.preferHealthyOptions = false,
      @HiveField(6) final List<String> dislikedIngredients = const [],
      @HiveField(7) this.spicePreference = SpiceLevel.medium})
      : _favoriteCuisines = favoriteCuisines,
        _dislikedIngredients = dislikedIngredients;

  factory _$CookingPreferencesImpl.fromJson(Map<String, dynamic> json) =>
      _$$CookingPreferencesImplFromJson(json);

  final List<String> _favoriteCuisines;
  @override
  @JsonKey()
  @HiveField(0)
  List<String> get favoriteCuisines {
    if (_favoriteCuisines is EqualUnmodifiableListView)
      return _favoriteCuisines;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_favoriteCuisines);
  }

  @override
  @JsonKey()
  @HiveField(1)
  final int maxCookingTimeMinutes;
  @override
  @JsonKey()
  @HiveField(2)
  final DifficultyLevel maxDifficulty;
  @override
  @JsonKey()
  @HiveField(3)
  final int defaultServings;
  @override
  @JsonKey()
  @HiveField(4)
  final bool preferQuickMeals;
  @override
  @JsonKey()
  @HiveField(5)
  final bool preferHealthyOptions;
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

  @override
  @JsonKey()
  @HiveField(7)
  final SpiceLevel spicePreference;

  @override
  String toString() {
    return 'CookingPreferences(favoriteCuisines: $favoriteCuisines, maxCookingTimeMinutes: $maxCookingTimeMinutes, maxDifficulty: $maxDifficulty, defaultServings: $defaultServings, preferQuickMeals: $preferQuickMeals, preferHealthyOptions: $preferHealthyOptions, dislikedIngredients: $dislikedIngredients, spicePreference: $spicePreference)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CookingPreferencesImpl &&
            const DeepCollectionEquality()
                .equals(other._favoriteCuisines, _favoriteCuisines) &&
            (identical(other.maxCookingTimeMinutes, maxCookingTimeMinutes) ||
                other.maxCookingTimeMinutes == maxCookingTimeMinutes) &&
            (identical(other.maxDifficulty, maxDifficulty) ||
                other.maxDifficulty == maxDifficulty) &&
            (identical(other.defaultServings, defaultServings) ||
                other.defaultServings == defaultServings) &&
            (identical(other.preferQuickMeals, preferQuickMeals) ||
                other.preferQuickMeals == preferQuickMeals) &&
            (identical(other.preferHealthyOptions, preferHealthyOptions) ||
                other.preferHealthyOptions == preferHealthyOptions) &&
            const DeepCollectionEquality()
                .equals(other._dislikedIngredients, _dislikedIngredients) &&
            (identical(other.spicePreference, spicePreference) ||
                other.spicePreference == spicePreference));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_favoriteCuisines),
      maxCookingTimeMinutes,
      maxDifficulty,
      defaultServings,
      preferQuickMeals,
      preferHealthyOptions,
      const DeepCollectionEquality().hash(_dislikedIngredients),
      spicePreference);

  /// Create a copy of CookingPreferences
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CookingPreferencesImplCopyWith<_$CookingPreferencesImpl> get copyWith =>
      __$$CookingPreferencesImplCopyWithImpl<_$CookingPreferencesImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CookingPreferencesImplToJson(
      this,
    );
  }
}

abstract class _CookingPreferences implements CookingPreferences {
  const factory _CookingPreferences(
          {@HiveField(0) final List<String> favoriteCuisines,
          @HiveField(1) final int maxCookingTimeMinutes,
          @HiveField(2) final DifficultyLevel maxDifficulty,
          @HiveField(3) final int defaultServings,
          @HiveField(4) final bool preferQuickMeals,
          @HiveField(5) final bool preferHealthyOptions,
          @HiveField(6) final List<String> dislikedIngredients,
          @HiveField(7) final SpiceLevel spicePreference}) =
      _$CookingPreferencesImpl;

  factory _CookingPreferences.fromJson(Map<String, dynamic> json) =
      _$CookingPreferencesImpl.fromJson;

  @override
  @HiveField(0)
  List<String> get favoriteCuisines;
  @override
  @HiveField(1)
  int get maxCookingTimeMinutes;
  @override
  @HiveField(2)
  DifficultyLevel get maxDifficulty;
  @override
  @HiveField(3)
  int get defaultServings;
  @override
  @HiveField(4)
  bool get preferQuickMeals;
  @override
  @HiveField(5)
  bool get preferHealthyOptions;
  @override
  @HiveField(6)
  List<String> get dislikedIngredients;
  @override
  @HiveField(7)
  SpiceLevel get spicePreference;

  /// Create a copy of CookingPreferences
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CookingPreferencesImplCopyWith<_$CookingPreferencesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
