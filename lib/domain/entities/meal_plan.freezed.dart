// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meal_plan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MealPlan _$MealPlanFromJson(Map<String, dynamic> json) {
  return _MealPlan.fromJson(json);
}

/// @nodoc
mixin _$MealPlan {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get name => throw _privateConstructorUsedError;
  @HiveField(2)
  String get userId => throw _privateConstructorUsedError;
  @HiveField(3)
  DateTime get startDate => throw _privateConstructorUsedError;
  @HiveField(4)
  DateTime get endDate => throw _privateConstructorUsedError;
  @HiveField(5)
  List<MealPlanDay> get days => throw _privateConstructorUsedError;
  @HiveField(6)
  DateTime get createdAt => throw _privateConstructorUsedError;
  @HiveField(7)
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @HiveField(8)
  String? get description => throw _privateConstructorUsedError;
  @HiveField(9)
  List<String> get tags => throw _privateConstructorUsedError;
  @HiveField(10)
  bool get isTemplate => throw _privateConstructorUsedError;
  @HiveField(11)
  bool get isShared => throw _privateConstructorUsedError;
  @HiveField(12)
  List<String> get sharedWith => throw _privateConstructorUsedError;
  @HiveField(13)
  NutritionGoals? get nutritionGoals => throw _privateConstructorUsedError;
  @HiveField(14)
  MealPlanPreferences? get preferences => throw _privateConstructorUsedError;
  @HiveField(15)
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this MealPlan to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MealPlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MealPlanCopyWith<MealPlan> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MealPlanCopyWith<$Res> {
  factory $MealPlanCopyWith(MealPlan value, $Res Function(MealPlan) then) =
      _$MealPlanCopyWithImpl<$Res, MealPlan>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String name,
      @HiveField(2) String userId,
      @HiveField(3) DateTime startDate,
      @HiveField(4) DateTime endDate,
      @HiveField(5) List<MealPlanDay> days,
      @HiveField(6) DateTime createdAt,
      @HiveField(7) DateTime? updatedAt,
      @HiveField(8) String? description,
      @HiveField(9) List<String> tags,
      @HiveField(10) bool isTemplate,
      @HiveField(11) bool isShared,
      @HiveField(12) List<String> sharedWith,
      @HiveField(13) NutritionGoals? nutritionGoals,
      @HiveField(14) MealPlanPreferences? preferences,
      @HiveField(15) Map<String, dynamic>? metadata});

  $MealPlanPreferencesCopyWith<$Res>? get preferences;
}

/// @nodoc
class _$MealPlanCopyWithImpl<$Res, $Val extends MealPlan>
    implements $MealPlanCopyWith<$Res> {
  _$MealPlanCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MealPlan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? userId = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? days = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? description = freezed,
    Object? tags = null,
    Object? isTemplate = null,
    Object? isShared = null,
    Object? sharedWith = null,
    Object? nutritionGoals = freezed,
    Object? preferences = freezed,
    Object? metadata = freezed,
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
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      days: null == days
          ? _value.days
          : days // ignore: cast_nullable_to_non_nullable
              as List<MealPlanDay>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isTemplate: null == isTemplate
          ? _value.isTemplate
          : isTemplate // ignore: cast_nullable_to_non_nullable
              as bool,
      isShared: null == isShared
          ? _value.isShared
          : isShared // ignore: cast_nullable_to_non_nullable
              as bool,
      sharedWith: null == sharedWith
          ? _value.sharedWith
          : sharedWith // ignore: cast_nullable_to_non_nullable
              as List<String>,
      nutritionGoals: freezed == nutritionGoals
          ? _value.nutritionGoals
          : nutritionGoals // ignore: cast_nullable_to_non_nullable
              as NutritionGoals?,
      preferences: freezed == preferences
          ? _value.preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as MealPlanPreferences?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }

  /// Create a copy of MealPlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MealPlanPreferencesCopyWith<$Res>? get preferences {
    if (_value.preferences == null) {
      return null;
    }

    return $MealPlanPreferencesCopyWith<$Res>(_value.preferences!, (value) {
      return _then(_value.copyWith(preferences: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MealPlanImplCopyWith<$Res>
    implements $MealPlanCopyWith<$Res> {
  factory _$$MealPlanImplCopyWith(
          _$MealPlanImpl value, $Res Function(_$MealPlanImpl) then) =
      __$$MealPlanImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String name,
      @HiveField(2) String userId,
      @HiveField(3) DateTime startDate,
      @HiveField(4) DateTime endDate,
      @HiveField(5) List<MealPlanDay> days,
      @HiveField(6) DateTime createdAt,
      @HiveField(7) DateTime? updatedAt,
      @HiveField(8) String? description,
      @HiveField(9) List<String> tags,
      @HiveField(10) bool isTemplate,
      @HiveField(11) bool isShared,
      @HiveField(12) List<String> sharedWith,
      @HiveField(13) NutritionGoals? nutritionGoals,
      @HiveField(14) MealPlanPreferences? preferences,
      @HiveField(15) Map<String, dynamic>? metadata});

  @override
  $MealPlanPreferencesCopyWith<$Res>? get preferences;
}

/// @nodoc
class __$$MealPlanImplCopyWithImpl<$Res>
    extends _$MealPlanCopyWithImpl<$Res, _$MealPlanImpl>
    implements _$$MealPlanImplCopyWith<$Res> {
  __$$MealPlanImplCopyWithImpl(
      _$MealPlanImpl _value, $Res Function(_$MealPlanImpl) _then)
      : super(_value, _then);

  /// Create a copy of MealPlan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? userId = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? days = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? description = freezed,
    Object? tags = null,
    Object? isTemplate = null,
    Object? isShared = null,
    Object? sharedWith = null,
    Object? nutritionGoals = freezed,
    Object? preferences = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$MealPlanImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      days: null == days
          ? _value._days
          : days // ignore: cast_nullable_to_non_nullable
              as List<MealPlanDay>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isTemplate: null == isTemplate
          ? _value.isTemplate
          : isTemplate // ignore: cast_nullable_to_non_nullable
              as bool,
      isShared: null == isShared
          ? _value.isShared
          : isShared // ignore: cast_nullable_to_non_nullable
              as bool,
      sharedWith: null == sharedWith
          ? _value._sharedWith
          : sharedWith // ignore: cast_nullable_to_non_nullable
              as List<String>,
      nutritionGoals: freezed == nutritionGoals
          ? _value.nutritionGoals
          : nutritionGoals // ignore: cast_nullable_to_non_nullable
              as NutritionGoals?,
      preferences: freezed == preferences
          ? _value.preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as MealPlanPreferences?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MealPlanImpl implements _MealPlan {
  const _$MealPlanImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.name,
      @HiveField(2) required this.userId,
      @HiveField(3) required this.startDate,
      @HiveField(4) required this.endDate,
      @HiveField(5) required final List<MealPlanDay> days,
      @HiveField(6) required this.createdAt,
      @HiveField(7) this.updatedAt,
      @HiveField(8) this.description,
      @HiveField(9) final List<String> tags = const [],
      @HiveField(10) this.isTemplate = false,
      @HiveField(11) this.isShared = false,
      @HiveField(12) final List<String> sharedWith = const [],
      @HiveField(13) this.nutritionGoals,
      @HiveField(14) this.preferences,
      @HiveField(15) final Map<String, dynamic>? metadata})
      : _days = days,
        _tags = tags,
        _sharedWith = sharedWith,
        _metadata = metadata;

  factory _$MealPlanImpl.fromJson(Map<String, dynamic> json) =>
      _$$MealPlanImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String name;
  @override
  @HiveField(2)
  final String userId;
  @override
  @HiveField(3)
  final DateTime startDate;
  @override
  @HiveField(4)
  final DateTime endDate;
  final List<MealPlanDay> _days;
  @override
  @HiveField(5)
  List<MealPlanDay> get days {
    if (_days is EqualUnmodifiableListView) return _days;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_days);
  }

  @override
  @HiveField(6)
  final DateTime createdAt;
  @override
  @HiveField(7)
  final DateTime? updatedAt;
  @override
  @HiveField(8)
  final String? description;
  final List<String> _tags;
  @override
  @JsonKey()
  @HiveField(9)
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  @JsonKey()
  @HiveField(10)
  final bool isTemplate;
  @override
  @JsonKey()
  @HiveField(11)
  final bool isShared;
  final List<String> _sharedWith;
  @override
  @JsonKey()
  @HiveField(12)
  List<String> get sharedWith {
    if (_sharedWith is EqualUnmodifiableListView) return _sharedWith;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sharedWith);
  }

  @override
  @HiveField(13)
  final NutritionGoals? nutritionGoals;
  @override
  @HiveField(14)
  final MealPlanPreferences? preferences;
  final Map<String, dynamic>? _metadata;
  @override
  @HiveField(15)
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'MealPlan(id: $id, name: $name, userId: $userId, startDate: $startDate, endDate: $endDate, days: $days, createdAt: $createdAt, updatedAt: $updatedAt, description: $description, tags: $tags, isTemplate: $isTemplate, isShared: $isShared, sharedWith: $sharedWith, nutritionGoals: $nutritionGoals, preferences: $preferences, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MealPlanImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            const DeepCollectionEquality().equals(other._days, _days) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.isTemplate, isTemplate) ||
                other.isTemplate == isTemplate) &&
            (identical(other.isShared, isShared) ||
                other.isShared == isShared) &&
            const DeepCollectionEquality()
                .equals(other._sharedWith, _sharedWith) &&
            const DeepCollectionEquality()
                .equals(other.nutritionGoals, nutritionGoals) &&
            (identical(other.preferences, preferences) ||
                other.preferences == preferences) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      userId,
      startDate,
      endDate,
      const DeepCollectionEquality().hash(_days),
      createdAt,
      updatedAt,
      description,
      const DeepCollectionEquality().hash(_tags),
      isTemplate,
      isShared,
      const DeepCollectionEquality().hash(_sharedWith),
      const DeepCollectionEquality().hash(nutritionGoals),
      preferences,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of MealPlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MealPlanImplCopyWith<_$MealPlanImpl> get copyWith =>
      __$$MealPlanImplCopyWithImpl<_$MealPlanImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MealPlanImplToJson(
      this,
    );
  }
}

abstract class _MealPlan implements MealPlan {
  const factory _MealPlan(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String name,
      @HiveField(2) required final String userId,
      @HiveField(3) required final DateTime startDate,
      @HiveField(4) required final DateTime endDate,
      @HiveField(5) required final List<MealPlanDay> days,
      @HiveField(6) required final DateTime createdAt,
      @HiveField(7) final DateTime? updatedAt,
      @HiveField(8) final String? description,
      @HiveField(9) final List<String> tags,
      @HiveField(10) final bool isTemplate,
      @HiveField(11) final bool isShared,
      @HiveField(12) final List<String> sharedWith,
      @HiveField(13) final NutritionGoals? nutritionGoals,
      @HiveField(14) final MealPlanPreferences? preferences,
      @HiveField(15) final Map<String, dynamic>? metadata}) = _$MealPlanImpl;

  factory _MealPlan.fromJson(Map<String, dynamic> json) =
      _$MealPlanImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get name;
  @override
  @HiveField(2)
  String get userId;
  @override
  @HiveField(3)
  DateTime get startDate;
  @override
  @HiveField(4)
  DateTime get endDate;
  @override
  @HiveField(5)
  List<MealPlanDay> get days;
  @override
  @HiveField(6)
  DateTime get createdAt;
  @override
  @HiveField(7)
  DateTime? get updatedAt;
  @override
  @HiveField(8)
  String? get description;
  @override
  @HiveField(9)
  List<String> get tags;
  @override
  @HiveField(10)
  bool get isTemplate;
  @override
  @HiveField(11)
  bool get isShared;
  @override
  @HiveField(12)
  List<String> get sharedWith;
  @override
  @HiveField(13)
  NutritionGoals? get nutritionGoals;
  @override
  @HiveField(14)
  MealPlanPreferences? get preferences;
  @override
  @HiveField(15)
  Map<String, dynamic>? get metadata;

  /// Create a copy of MealPlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MealPlanImplCopyWith<_$MealPlanImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MealPlanDay _$MealPlanDayFromJson(Map<String, dynamic> json) {
  return _MealPlanDay.fromJson(json);
}

/// @nodoc
mixin _$MealPlanDay {
  @HiveField(0)
  DateTime get date => throw _privateConstructorUsedError;
  @HiveField(1)
  List<PlannedMeal> get meals => throw _privateConstructorUsedError;
  @HiveField(2)
  List<String> get notes => throw _privateConstructorUsedError;
  @HiveField(3)
  NutritionSummary? get nutritionSummary => throw _privateConstructorUsedError;
  @HiveField(4)
  double get estimatedCost => throw _privateConstructorUsedError;
  @HiveField(5)
  int get prepTimeMinutes => throw _privateConstructorUsedError;
  @HiveField(6)
  bool get isCompleted => throw _privateConstructorUsedError;

  /// Serializes this MealPlanDay to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MealPlanDay
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MealPlanDayCopyWith<MealPlanDay> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MealPlanDayCopyWith<$Res> {
  factory $MealPlanDayCopyWith(
          MealPlanDay value, $Res Function(MealPlanDay) then) =
      _$MealPlanDayCopyWithImpl<$Res, MealPlanDay>;
  @useResult
  $Res call(
      {@HiveField(0) DateTime date,
      @HiveField(1) List<PlannedMeal> meals,
      @HiveField(2) List<String> notes,
      @HiveField(3) NutritionSummary? nutritionSummary,
      @HiveField(4) double estimatedCost,
      @HiveField(5) int prepTimeMinutes,
      @HiveField(6) bool isCompleted});

  $NutritionSummaryCopyWith<$Res>? get nutritionSummary;
}

/// @nodoc
class _$MealPlanDayCopyWithImpl<$Res, $Val extends MealPlanDay>
    implements $MealPlanDayCopyWith<$Res> {
  _$MealPlanDayCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MealPlanDay
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? meals = null,
    Object? notes = null,
    Object? nutritionSummary = freezed,
    Object? estimatedCost = null,
    Object? prepTimeMinutes = null,
    Object? isCompleted = null,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      meals: null == meals
          ? _value.meals
          : meals // ignore: cast_nullable_to_non_nullable
              as List<PlannedMeal>,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      nutritionSummary: freezed == nutritionSummary
          ? _value.nutritionSummary
          : nutritionSummary // ignore: cast_nullable_to_non_nullable
              as NutritionSummary?,
      estimatedCost: null == estimatedCost
          ? _value.estimatedCost
          : estimatedCost // ignore: cast_nullable_to_non_nullable
              as double,
      prepTimeMinutes: null == prepTimeMinutes
          ? _value.prepTimeMinutes
          : prepTimeMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of MealPlanDay
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NutritionSummaryCopyWith<$Res>? get nutritionSummary {
    if (_value.nutritionSummary == null) {
      return null;
    }

    return $NutritionSummaryCopyWith<$Res>(_value.nutritionSummary!, (value) {
      return _then(_value.copyWith(nutritionSummary: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MealPlanDayImplCopyWith<$Res>
    implements $MealPlanDayCopyWith<$Res> {
  factory _$$MealPlanDayImplCopyWith(
          _$MealPlanDayImpl value, $Res Function(_$MealPlanDayImpl) then) =
      __$$MealPlanDayImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) DateTime date,
      @HiveField(1) List<PlannedMeal> meals,
      @HiveField(2) List<String> notes,
      @HiveField(3) NutritionSummary? nutritionSummary,
      @HiveField(4) double estimatedCost,
      @HiveField(5) int prepTimeMinutes,
      @HiveField(6) bool isCompleted});

  @override
  $NutritionSummaryCopyWith<$Res>? get nutritionSummary;
}

/// @nodoc
class __$$MealPlanDayImplCopyWithImpl<$Res>
    extends _$MealPlanDayCopyWithImpl<$Res, _$MealPlanDayImpl>
    implements _$$MealPlanDayImplCopyWith<$Res> {
  __$$MealPlanDayImplCopyWithImpl(
      _$MealPlanDayImpl _value, $Res Function(_$MealPlanDayImpl) _then)
      : super(_value, _then);

  /// Create a copy of MealPlanDay
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? meals = null,
    Object? notes = null,
    Object? nutritionSummary = freezed,
    Object? estimatedCost = null,
    Object? prepTimeMinutes = null,
    Object? isCompleted = null,
  }) {
    return _then(_$MealPlanDayImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      meals: null == meals
          ? _value._meals
          : meals // ignore: cast_nullable_to_non_nullable
              as List<PlannedMeal>,
      notes: null == notes
          ? _value._notes
          : notes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      nutritionSummary: freezed == nutritionSummary
          ? _value.nutritionSummary
          : nutritionSummary // ignore: cast_nullable_to_non_nullable
              as NutritionSummary?,
      estimatedCost: null == estimatedCost
          ? _value.estimatedCost
          : estimatedCost // ignore: cast_nullable_to_non_nullable
              as double,
      prepTimeMinutes: null == prepTimeMinutes
          ? _value.prepTimeMinutes
          : prepTimeMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MealPlanDayImpl implements _MealPlanDay {
  const _$MealPlanDayImpl(
      {@HiveField(0) required this.date,
      @HiveField(1) required final List<PlannedMeal> meals,
      @HiveField(2) final List<String> notes = const [],
      @HiveField(3) this.nutritionSummary,
      @HiveField(4) this.estimatedCost = 0.0,
      @HiveField(5) this.prepTimeMinutes = 0,
      @HiveField(6) this.isCompleted = false})
      : _meals = meals,
        _notes = notes;

  factory _$MealPlanDayImpl.fromJson(Map<String, dynamic> json) =>
      _$$MealPlanDayImplFromJson(json);

  @override
  @HiveField(0)
  final DateTime date;
  final List<PlannedMeal> _meals;
  @override
  @HiveField(1)
  List<PlannedMeal> get meals {
    if (_meals is EqualUnmodifiableListView) return _meals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_meals);
  }

  final List<String> _notes;
  @override
  @JsonKey()
  @HiveField(2)
  List<String> get notes {
    if (_notes is EqualUnmodifiableListView) return _notes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_notes);
  }

  @override
  @HiveField(3)
  final NutritionSummary? nutritionSummary;
  @override
  @JsonKey()
  @HiveField(4)
  final double estimatedCost;
  @override
  @JsonKey()
  @HiveField(5)
  final int prepTimeMinutes;
  @override
  @JsonKey()
  @HiveField(6)
  final bool isCompleted;

  @override
  String toString() {
    return 'MealPlanDay(date: $date, meals: $meals, notes: $notes, nutritionSummary: $nutritionSummary, estimatedCost: $estimatedCost, prepTimeMinutes: $prepTimeMinutes, isCompleted: $isCompleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MealPlanDayImpl &&
            (identical(other.date, date) || other.date == date) &&
            const DeepCollectionEquality().equals(other._meals, _meals) &&
            const DeepCollectionEquality().equals(other._notes, _notes) &&
            (identical(other.nutritionSummary, nutritionSummary) ||
                other.nutritionSummary == nutritionSummary) &&
            (identical(other.estimatedCost, estimatedCost) ||
                other.estimatedCost == estimatedCost) &&
            (identical(other.prepTimeMinutes, prepTimeMinutes) ||
                other.prepTimeMinutes == prepTimeMinutes) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      date,
      const DeepCollectionEquality().hash(_meals),
      const DeepCollectionEquality().hash(_notes),
      nutritionSummary,
      estimatedCost,
      prepTimeMinutes,
      isCompleted);

  /// Create a copy of MealPlanDay
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MealPlanDayImplCopyWith<_$MealPlanDayImpl> get copyWith =>
      __$$MealPlanDayImplCopyWithImpl<_$MealPlanDayImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MealPlanDayImplToJson(
      this,
    );
  }
}

abstract class _MealPlanDay implements MealPlanDay {
  const factory _MealPlanDay(
      {@HiveField(0) required final DateTime date,
      @HiveField(1) required final List<PlannedMeal> meals,
      @HiveField(2) final List<String> notes,
      @HiveField(3) final NutritionSummary? nutritionSummary,
      @HiveField(4) final double estimatedCost,
      @HiveField(5) final int prepTimeMinutes,
      @HiveField(6) final bool isCompleted}) = _$MealPlanDayImpl;

  factory _MealPlanDay.fromJson(Map<String, dynamic> json) =
      _$MealPlanDayImpl.fromJson;

  @override
  @HiveField(0)
  DateTime get date;
  @override
  @HiveField(1)
  List<PlannedMeal> get meals;
  @override
  @HiveField(2)
  List<String> get notes;
  @override
  @HiveField(3)
  NutritionSummary? get nutritionSummary;
  @override
  @HiveField(4)
  double get estimatedCost;
  @override
  @HiveField(5)
  int get prepTimeMinutes;
  @override
  @HiveField(6)
  bool get isCompleted;

  /// Create a copy of MealPlanDay
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MealPlanDayImplCopyWith<_$MealPlanDayImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PlannedMeal _$PlannedMealFromJson(Map<String, dynamic> json) {
  return _PlannedMeal.fromJson(json);
}

/// @nodoc
mixin _$PlannedMeal {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  MealType get mealType => throw _privateConstructorUsedError;
  @HiveField(2)
  DateTime get scheduledTime => throw _privateConstructorUsedError;
  @HiveField(3)
  String? get recipeId => throw _privateConstructorUsedError;
  @HiveField(4)
  String? get recipeName => throw _privateConstructorUsedError;
  @HiveField(5)
  String? get customMealName => throw _privateConstructorUsedError;
  @HiveField(6)
  int get servings => throw _privateConstructorUsedError;
  @HiveField(7)
  List<String> get ingredients => throw _privateConstructorUsedError;
  @HiveField(8)
  int get prepTimeMinutes => throw _privateConstructorUsedError;
  @HiveField(9)
  int get cookTimeMinutes => throw _privateConstructorUsedError;
  @HiveField(10)
  NutritionInfo? get nutrition => throw _privateConstructorUsedError;
  @HiveField(11)
  double get estimatedCost => throw _privateConstructorUsedError;
  @HiveField(12)
  bool get isPrepared => throw _privateConstructorUsedError;
  @HiveField(13)
  bool get isLeftover => throw _privateConstructorUsedError;
  @HiveField(14)
  String? get leftoverFromMealId => throw _privateConstructorUsedError;
  @HiveField(15)
  DateTime? get prepStartTime => throw _privateConstructorUsedError;
  @HiveField(16)
  DateTime? get actualPrepTime => throw _privateConstructorUsedError;
  @HiveField(17)
  List<String> get notes => throw _privateConstructorUsedError;
  @HiveField(18)
  List<String> get tags => throw _privateConstructorUsedError;
  @HiveField(19)
  String? get imageUrl => throw _privateConstructorUsedError;

  /// Serializes this PlannedMeal to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlannedMeal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlannedMealCopyWith<PlannedMeal> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlannedMealCopyWith<$Res> {
  factory $PlannedMealCopyWith(
          PlannedMeal value, $Res Function(PlannedMeal) then) =
      _$PlannedMealCopyWithImpl<$Res, PlannedMeal>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) MealType mealType,
      @HiveField(2) DateTime scheduledTime,
      @HiveField(3) String? recipeId,
      @HiveField(4) String? recipeName,
      @HiveField(5) String? customMealName,
      @HiveField(6) int servings,
      @HiveField(7) List<String> ingredients,
      @HiveField(8) int prepTimeMinutes,
      @HiveField(9) int cookTimeMinutes,
      @HiveField(10) NutritionInfo? nutrition,
      @HiveField(11) double estimatedCost,
      @HiveField(12) bool isPrepared,
      @HiveField(13) bool isLeftover,
      @HiveField(14) String? leftoverFromMealId,
      @HiveField(15) DateTime? prepStartTime,
      @HiveField(16) DateTime? actualPrepTime,
      @HiveField(17) List<String> notes,
      @HiveField(18) List<String> tags,
      @HiveField(19) String? imageUrl});

  $NutritionInfoCopyWith<$Res>? get nutrition;
}

/// @nodoc
class _$PlannedMealCopyWithImpl<$Res, $Val extends PlannedMeal>
    implements $PlannedMealCopyWith<$Res> {
  _$PlannedMealCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlannedMeal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? mealType = freezed,
    Object? scheduledTime = null,
    Object? recipeId = freezed,
    Object? recipeName = freezed,
    Object? customMealName = freezed,
    Object? servings = null,
    Object? ingredients = null,
    Object? prepTimeMinutes = null,
    Object? cookTimeMinutes = null,
    Object? nutrition = freezed,
    Object? estimatedCost = null,
    Object? isPrepared = null,
    Object? isLeftover = null,
    Object? leftoverFromMealId = freezed,
    Object? prepStartTime = freezed,
    Object? actualPrepTime = freezed,
    Object? notes = null,
    Object? tags = null,
    Object? imageUrl = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      mealType: freezed == mealType
          ? _value.mealType
          : mealType // ignore: cast_nullable_to_non_nullable
              as MealType,
      scheduledTime: null == scheduledTime
          ? _value.scheduledTime
          : scheduledTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      recipeId: freezed == recipeId
          ? _value.recipeId
          : recipeId // ignore: cast_nullable_to_non_nullable
              as String?,
      recipeName: freezed == recipeName
          ? _value.recipeName
          : recipeName // ignore: cast_nullable_to_non_nullable
              as String?,
      customMealName: freezed == customMealName
          ? _value.customMealName
          : customMealName // ignore: cast_nullable_to_non_nullable
              as String?,
      servings: null == servings
          ? _value.servings
          : servings // ignore: cast_nullable_to_non_nullable
              as int,
      ingredients: null == ingredients
          ? _value.ingredients
          : ingredients // ignore: cast_nullable_to_non_nullable
              as List<String>,
      prepTimeMinutes: null == prepTimeMinutes
          ? _value.prepTimeMinutes
          : prepTimeMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      cookTimeMinutes: null == cookTimeMinutes
          ? _value.cookTimeMinutes
          : cookTimeMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      nutrition: freezed == nutrition
          ? _value.nutrition
          : nutrition // ignore: cast_nullable_to_non_nullable
              as NutritionInfo?,
      estimatedCost: null == estimatedCost
          ? _value.estimatedCost
          : estimatedCost // ignore: cast_nullable_to_non_nullable
              as double,
      isPrepared: null == isPrepared
          ? _value.isPrepared
          : isPrepared // ignore: cast_nullable_to_non_nullable
              as bool,
      isLeftover: null == isLeftover
          ? _value.isLeftover
          : isLeftover // ignore: cast_nullable_to_non_nullable
              as bool,
      leftoverFromMealId: freezed == leftoverFromMealId
          ? _value.leftoverFromMealId
          : leftoverFromMealId // ignore: cast_nullable_to_non_nullable
              as String?,
      prepStartTime: freezed == prepStartTime
          ? _value.prepStartTime
          : prepStartTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      actualPrepTime: freezed == actualPrepTime
          ? _value.actualPrepTime
          : actualPrepTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of PlannedMeal
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NutritionInfoCopyWith<$Res>? get nutrition {
    if (_value.nutrition == null) {
      return null;
    }

    return $NutritionInfoCopyWith<$Res>(_value.nutrition!, (value) {
      return _then(_value.copyWith(nutrition: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PlannedMealImplCopyWith<$Res>
    implements $PlannedMealCopyWith<$Res> {
  factory _$$PlannedMealImplCopyWith(
          _$PlannedMealImpl value, $Res Function(_$PlannedMealImpl) then) =
      __$$PlannedMealImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) MealType mealType,
      @HiveField(2) DateTime scheduledTime,
      @HiveField(3) String? recipeId,
      @HiveField(4) String? recipeName,
      @HiveField(5) String? customMealName,
      @HiveField(6) int servings,
      @HiveField(7) List<String> ingredients,
      @HiveField(8) int prepTimeMinutes,
      @HiveField(9) int cookTimeMinutes,
      @HiveField(10) NutritionInfo? nutrition,
      @HiveField(11) double estimatedCost,
      @HiveField(12) bool isPrepared,
      @HiveField(13) bool isLeftover,
      @HiveField(14) String? leftoverFromMealId,
      @HiveField(15) DateTime? prepStartTime,
      @HiveField(16) DateTime? actualPrepTime,
      @HiveField(17) List<String> notes,
      @HiveField(18) List<String> tags,
      @HiveField(19) String? imageUrl});

  @override
  $NutritionInfoCopyWith<$Res>? get nutrition;
}

/// @nodoc
class __$$PlannedMealImplCopyWithImpl<$Res>
    extends _$PlannedMealCopyWithImpl<$Res, _$PlannedMealImpl>
    implements _$$PlannedMealImplCopyWith<$Res> {
  __$$PlannedMealImplCopyWithImpl(
      _$PlannedMealImpl _value, $Res Function(_$PlannedMealImpl) _then)
      : super(_value, _then);

  /// Create a copy of PlannedMeal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? mealType = freezed,
    Object? scheduledTime = null,
    Object? recipeId = freezed,
    Object? recipeName = freezed,
    Object? customMealName = freezed,
    Object? servings = null,
    Object? ingredients = null,
    Object? prepTimeMinutes = null,
    Object? cookTimeMinutes = null,
    Object? nutrition = freezed,
    Object? estimatedCost = null,
    Object? isPrepared = null,
    Object? isLeftover = null,
    Object? leftoverFromMealId = freezed,
    Object? prepStartTime = freezed,
    Object? actualPrepTime = freezed,
    Object? notes = null,
    Object? tags = null,
    Object? imageUrl = freezed,
  }) {
    return _then(_$PlannedMealImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      mealType: freezed == mealType
          ? _value.mealType
          : mealType // ignore: cast_nullable_to_non_nullable
              as MealType,
      scheduledTime: null == scheduledTime
          ? _value.scheduledTime
          : scheduledTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      recipeId: freezed == recipeId
          ? _value.recipeId
          : recipeId // ignore: cast_nullable_to_non_nullable
              as String?,
      recipeName: freezed == recipeName
          ? _value.recipeName
          : recipeName // ignore: cast_nullable_to_non_nullable
              as String?,
      customMealName: freezed == customMealName
          ? _value.customMealName
          : customMealName // ignore: cast_nullable_to_non_nullable
              as String?,
      servings: null == servings
          ? _value.servings
          : servings // ignore: cast_nullable_to_non_nullable
              as int,
      ingredients: null == ingredients
          ? _value._ingredients
          : ingredients // ignore: cast_nullable_to_non_nullable
              as List<String>,
      prepTimeMinutes: null == prepTimeMinutes
          ? _value.prepTimeMinutes
          : prepTimeMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      cookTimeMinutes: null == cookTimeMinutes
          ? _value.cookTimeMinutes
          : cookTimeMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      nutrition: freezed == nutrition
          ? _value.nutrition
          : nutrition // ignore: cast_nullable_to_non_nullable
              as NutritionInfo?,
      estimatedCost: null == estimatedCost
          ? _value.estimatedCost
          : estimatedCost // ignore: cast_nullable_to_non_nullable
              as double,
      isPrepared: null == isPrepared
          ? _value.isPrepared
          : isPrepared // ignore: cast_nullable_to_non_nullable
              as bool,
      isLeftover: null == isLeftover
          ? _value.isLeftover
          : isLeftover // ignore: cast_nullable_to_non_nullable
              as bool,
      leftoverFromMealId: freezed == leftoverFromMealId
          ? _value.leftoverFromMealId
          : leftoverFromMealId // ignore: cast_nullable_to_non_nullable
              as String?,
      prepStartTime: freezed == prepStartTime
          ? _value.prepStartTime
          : prepStartTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      actualPrepTime: freezed == actualPrepTime
          ? _value.actualPrepTime
          : actualPrepTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      notes: null == notes
          ? _value._notes
          : notes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PlannedMealImpl implements _PlannedMeal {
  const _$PlannedMealImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.mealType,
      @HiveField(2) required this.scheduledTime,
      @HiveField(3) this.recipeId,
      @HiveField(4) this.recipeName,
      @HiveField(5) this.customMealName,
      @HiveField(6) this.servings = 4,
      @HiveField(7) final List<String> ingredients = const [],
      @HiveField(8) this.prepTimeMinutes = 0,
      @HiveField(9) this.cookTimeMinutes = 0,
      @HiveField(10) this.nutrition,
      @HiveField(11) this.estimatedCost = 0.0,
      @HiveField(12) this.isPrepared = false,
      @HiveField(13) this.isLeftover = false,
      @HiveField(14) this.leftoverFromMealId,
      @HiveField(15) this.prepStartTime,
      @HiveField(16) this.actualPrepTime,
      @HiveField(17) final List<String> notes = const [],
      @HiveField(18) final List<String> tags = const [],
      @HiveField(19) this.imageUrl})
      : _ingredients = ingredients,
        _notes = notes,
        _tags = tags;

  factory _$PlannedMealImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlannedMealImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final MealType mealType;
  @override
  @HiveField(2)
  final DateTime scheduledTime;
  @override
  @HiveField(3)
  final String? recipeId;
  @override
  @HiveField(4)
  final String? recipeName;
  @override
  @HiveField(5)
  final String? customMealName;
  @override
  @JsonKey()
  @HiveField(6)
  final int servings;
  final List<String> _ingredients;
  @override
  @JsonKey()
  @HiveField(7)
  List<String> get ingredients {
    if (_ingredients is EqualUnmodifiableListView) return _ingredients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ingredients);
  }

  @override
  @JsonKey()
  @HiveField(8)
  final int prepTimeMinutes;
  @override
  @JsonKey()
  @HiveField(9)
  final int cookTimeMinutes;
  @override
  @HiveField(10)
  final NutritionInfo? nutrition;
  @override
  @JsonKey()
  @HiveField(11)
  final double estimatedCost;
  @override
  @JsonKey()
  @HiveField(12)
  final bool isPrepared;
  @override
  @JsonKey()
  @HiveField(13)
  final bool isLeftover;
  @override
  @HiveField(14)
  final String? leftoverFromMealId;
  @override
  @HiveField(15)
  final DateTime? prepStartTime;
  @override
  @HiveField(16)
  final DateTime? actualPrepTime;
  final List<String> _notes;
  @override
  @JsonKey()
  @HiveField(17)
  List<String> get notes {
    if (_notes is EqualUnmodifiableListView) return _notes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_notes);
  }

  final List<String> _tags;
  @override
  @JsonKey()
  @HiveField(18)
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  @HiveField(19)
  final String? imageUrl;

  @override
  String toString() {
    return 'PlannedMeal(id: $id, mealType: $mealType, scheduledTime: $scheduledTime, recipeId: $recipeId, recipeName: $recipeName, customMealName: $customMealName, servings: $servings, ingredients: $ingredients, prepTimeMinutes: $prepTimeMinutes, cookTimeMinutes: $cookTimeMinutes, nutrition: $nutrition, estimatedCost: $estimatedCost, isPrepared: $isPrepared, isLeftover: $isLeftover, leftoverFromMealId: $leftoverFromMealId, prepStartTime: $prepStartTime, actualPrepTime: $actualPrepTime, notes: $notes, tags: $tags, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlannedMealImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other.mealType, mealType) &&
            (identical(other.scheduledTime, scheduledTime) ||
                other.scheduledTime == scheduledTime) &&
            (identical(other.recipeId, recipeId) ||
                other.recipeId == recipeId) &&
            (identical(other.recipeName, recipeName) ||
                other.recipeName == recipeName) &&
            (identical(other.customMealName, customMealName) ||
                other.customMealName == customMealName) &&
            (identical(other.servings, servings) ||
                other.servings == servings) &&
            const DeepCollectionEquality()
                .equals(other._ingredients, _ingredients) &&
            (identical(other.prepTimeMinutes, prepTimeMinutes) ||
                other.prepTimeMinutes == prepTimeMinutes) &&
            (identical(other.cookTimeMinutes, cookTimeMinutes) ||
                other.cookTimeMinutes == cookTimeMinutes) &&
            (identical(other.nutrition, nutrition) ||
                other.nutrition == nutrition) &&
            (identical(other.estimatedCost, estimatedCost) ||
                other.estimatedCost == estimatedCost) &&
            (identical(other.isPrepared, isPrepared) ||
                other.isPrepared == isPrepared) &&
            (identical(other.isLeftover, isLeftover) ||
                other.isLeftover == isLeftover) &&
            (identical(other.leftoverFromMealId, leftoverFromMealId) ||
                other.leftoverFromMealId == leftoverFromMealId) &&
            (identical(other.prepStartTime, prepStartTime) ||
                other.prepStartTime == prepStartTime) &&
            (identical(other.actualPrepTime, actualPrepTime) ||
                other.actualPrepTime == actualPrepTime) &&
            const DeepCollectionEquality().equals(other._notes, _notes) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        const DeepCollectionEquality().hash(mealType),
        scheduledTime,
        recipeId,
        recipeName,
        customMealName,
        servings,
        const DeepCollectionEquality().hash(_ingredients),
        prepTimeMinutes,
        cookTimeMinutes,
        nutrition,
        estimatedCost,
        isPrepared,
        isLeftover,
        leftoverFromMealId,
        prepStartTime,
        actualPrepTime,
        const DeepCollectionEquality().hash(_notes),
        const DeepCollectionEquality().hash(_tags),
        imageUrl
      ]);

  /// Create a copy of PlannedMeal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlannedMealImplCopyWith<_$PlannedMealImpl> get copyWith =>
      __$$PlannedMealImplCopyWithImpl<_$PlannedMealImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlannedMealImplToJson(
      this,
    );
  }
}

abstract class _PlannedMeal implements PlannedMeal {
  const factory _PlannedMeal(
      {@HiveField(0) required final String id,
      @HiveField(1) required final MealType mealType,
      @HiveField(2) required final DateTime scheduledTime,
      @HiveField(3) final String? recipeId,
      @HiveField(4) final String? recipeName,
      @HiveField(5) final String? customMealName,
      @HiveField(6) final int servings,
      @HiveField(7) final List<String> ingredients,
      @HiveField(8) final int prepTimeMinutes,
      @HiveField(9) final int cookTimeMinutes,
      @HiveField(10) final NutritionInfo? nutrition,
      @HiveField(11) final double estimatedCost,
      @HiveField(12) final bool isPrepared,
      @HiveField(13) final bool isLeftover,
      @HiveField(14) final String? leftoverFromMealId,
      @HiveField(15) final DateTime? prepStartTime,
      @HiveField(16) final DateTime? actualPrepTime,
      @HiveField(17) final List<String> notes,
      @HiveField(18) final List<String> tags,
      @HiveField(19) final String? imageUrl}) = _$PlannedMealImpl;

  factory _PlannedMeal.fromJson(Map<String, dynamic> json) =
      _$PlannedMealImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  MealType get mealType;
  @override
  @HiveField(2)
  DateTime get scheduledTime;
  @override
  @HiveField(3)
  String? get recipeId;
  @override
  @HiveField(4)
  String? get recipeName;
  @override
  @HiveField(5)
  String? get customMealName;
  @override
  @HiveField(6)
  int get servings;
  @override
  @HiveField(7)
  List<String> get ingredients;
  @override
  @HiveField(8)
  int get prepTimeMinutes;
  @override
  @HiveField(9)
  int get cookTimeMinutes;
  @override
  @HiveField(10)
  NutritionInfo? get nutrition;
  @override
  @HiveField(11)
  double get estimatedCost;
  @override
  @HiveField(12)
  bool get isPrepared;
  @override
  @HiveField(13)
  bool get isLeftover;
  @override
  @HiveField(14)
  String? get leftoverFromMealId;
  @override
  @HiveField(15)
  DateTime? get prepStartTime;
  @override
  @HiveField(16)
  DateTime? get actualPrepTime;
  @override
  @HiveField(17)
  List<String> get notes;
  @override
  @HiveField(18)
  List<String> get tags;
  @override
  @HiveField(19)
  String? get imageUrl;

  /// Create a copy of PlannedMeal
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlannedMealImplCopyWith<_$PlannedMealImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MealPlanPreferences _$MealPlanPreferencesFromJson(Map<String, dynamic> json) {
  return _MealPlanPreferences.fromJson(json);
}

/// @nodoc
mixin _$MealPlanPreferences {
  @HiveField(0)
  List<MealType> get preferredMealTypes => throw _privateConstructorUsedError;
  @HiveField(1)
  int get defaultServings => throw _privateConstructorUsedError;
  @HiveField(2)
  int get maxPrepTimeMinutes => throw _privateConstructorUsedError;
  @HiveField(3)
  int get maxCookTimeMinutes => throw _privateConstructorUsedError;
  @HiveField(4)
  List<String> get preferredCuisines => throw _privateConstructorUsedError;
  @HiveField(5)
  List<String> get dislikedIngredients => throw _privateConstructorUsedError;
  @HiveField(6)
  List<DietaryRestriction> get dietaryRestrictions =>
      throw _privateConstructorUsedError;
  @HiveField(7)
  List<String> get allergies => throw _privateConstructorUsedError;
  @HiveField(8)
  bool get allowLeftovers => throw _privateConstructorUsedError;
  @HiveField(9)
  int get maxLeftoverDays => throw _privateConstructorUsedError;
  @HiveField(10)
  bool get batchCookingPreferred => throw _privateConstructorUsedError;
  @HiveField(11)
  List<String> get kitchenEquipment => throw _privateConstructorUsedError;
  @HiveField(12)
  SkillLevel? get skillLevel =>
      throw _privateConstructorUsedError; // Now properly imported
  @HiveField(13)
  double get weeklyBudget => throw _privateConstructorUsedError;

  /// Serializes this MealPlanPreferences to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MealPlanPreferences
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MealPlanPreferencesCopyWith<MealPlanPreferences> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MealPlanPreferencesCopyWith<$Res> {
  factory $MealPlanPreferencesCopyWith(
          MealPlanPreferences value, $Res Function(MealPlanPreferences) then) =
      _$MealPlanPreferencesCopyWithImpl<$Res, MealPlanPreferences>;
  @useResult
  $Res call(
      {@HiveField(0) List<MealType> preferredMealTypes,
      @HiveField(1) int defaultServings,
      @HiveField(2) int maxPrepTimeMinutes,
      @HiveField(3) int maxCookTimeMinutes,
      @HiveField(4) List<String> preferredCuisines,
      @HiveField(5) List<String> dislikedIngredients,
      @HiveField(6) List<DietaryRestriction> dietaryRestrictions,
      @HiveField(7) List<String> allergies,
      @HiveField(8) bool allowLeftovers,
      @HiveField(9) int maxLeftoverDays,
      @HiveField(10) bool batchCookingPreferred,
      @HiveField(11) List<String> kitchenEquipment,
      @HiveField(12) SkillLevel? skillLevel,
      @HiveField(13) double weeklyBudget});
}

/// @nodoc
class _$MealPlanPreferencesCopyWithImpl<$Res, $Val extends MealPlanPreferences>
    implements $MealPlanPreferencesCopyWith<$Res> {
  _$MealPlanPreferencesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MealPlanPreferences
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? preferredMealTypes = null,
    Object? defaultServings = null,
    Object? maxPrepTimeMinutes = null,
    Object? maxCookTimeMinutes = null,
    Object? preferredCuisines = null,
    Object? dislikedIngredients = null,
    Object? dietaryRestrictions = null,
    Object? allergies = null,
    Object? allowLeftovers = null,
    Object? maxLeftoverDays = null,
    Object? batchCookingPreferred = null,
    Object? kitchenEquipment = null,
    Object? skillLevel = freezed,
    Object? weeklyBudget = null,
  }) {
    return _then(_value.copyWith(
      preferredMealTypes: null == preferredMealTypes
          ? _value.preferredMealTypes
          : preferredMealTypes // ignore: cast_nullable_to_non_nullable
              as List<MealType>,
      defaultServings: null == defaultServings
          ? _value.defaultServings
          : defaultServings // ignore: cast_nullable_to_non_nullable
              as int,
      maxPrepTimeMinutes: null == maxPrepTimeMinutes
          ? _value.maxPrepTimeMinutes
          : maxPrepTimeMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      maxCookTimeMinutes: null == maxCookTimeMinutes
          ? _value.maxCookTimeMinutes
          : maxCookTimeMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      preferredCuisines: null == preferredCuisines
          ? _value.preferredCuisines
          : preferredCuisines // ignore: cast_nullable_to_non_nullable
              as List<String>,
      dislikedIngredients: null == dislikedIngredients
          ? _value.dislikedIngredients
          : dislikedIngredients // ignore: cast_nullable_to_non_nullable
              as List<String>,
      dietaryRestrictions: null == dietaryRestrictions
          ? _value.dietaryRestrictions
          : dietaryRestrictions // ignore: cast_nullable_to_non_nullable
              as List<DietaryRestriction>,
      allergies: null == allergies
          ? _value.allergies
          : allergies // ignore: cast_nullable_to_non_nullable
              as List<String>,
      allowLeftovers: null == allowLeftovers
          ? _value.allowLeftovers
          : allowLeftovers // ignore: cast_nullable_to_non_nullable
              as bool,
      maxLeftoverDays: null == maxLeftoverDays
          ? _value.maxLeftoverDays
          : maxLeftoverDays // ignore: cast_nullable_to_non_nullable
              as int,
      batchCookingPreferred: null == batchCookingPreferred
          ? _value.batchCookingPreferred
          : batchCookingPreferred // ignore: cast_nullable_to_non_nullable
              as bool,
      kitchenEquipment: null == kitchenEquipment
          ? _value.kitchenEquipment
          : kitchenEquipment // ignore: cast_nullable_to_non_nullable
              as List<String>,
      skillLevel: freezed == skillLevel
          ? _value.skillLevel
          : skillLevel // ignore: cast_nullable_to_non_nullable
              as SkillLevel?,
      weeklyBudget: null == weeklyBudget
          ? _value.weeklyBudget
          : weeklyBudget // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MealPlanPreferencesImplCopyWith<$Res>
    implements $MealPlanPreferencesCopyWith<$Res> {
  factory _$$MealPlanPreferencesImplCopyWith(_$MealPlanPreferencesImpl value,
          $Res Function(_$MealPlanPreferencesImpl) then) =
      __$$MealPlanPreferencesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) List<MealType> preferredMealTypes,
      @HiveField(1) int defaultServings,
      @HiveField(2) int maxPrepTimeMinutes,
      @HiveField(3) int maxCookTimeMinutes,
      @HiveField(4) List<String> preferredCuisines,
      @HiveField(5) List<String> dislikedIngredients,
      @HiveField(6) List<DietaryRestriction> dietaryRestrictions,
      @HiveField(7) List<String> allergies,
      @HiveField(8) bool allowLeftovers,
      @HiveField(9) int maxLeftoverDays,
      @HiveField(10) bool batchCookingPreferred,
      @HiveField(11) List<String> kitchenEquipment,
      @HiveField(12) SkillLevel? skillLevel,
      @HiveField(13) double weeklyBudget});
}

/// @nodoc
class __$$MealPlanPreferencesImplCopyWithImpl<$Res>
    extends _$MealPlanPreferencesCopyWithImpl<$Res, _$MealPlanPreferencesImpl>
    implements _$$MealPlanPreferencesImplCopyWith<$Res> {
  __$$MealPlanPreferencesImplCopyWithImpl(_$MealPlanPreferencesImpl _value,
      $Res Function(_$MealPlanPreferencesImpl) _then)
      : super(_value, _then);

  /// Create a copy of MealPlanPreferences
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? preferredMealTypes = null,
    Object? defaultServings = null,
    Object? maxPrepTimeMinutes = null,
    Object? maxCookTimeMinutes = null,
    Object? preferredCuisines = null,
    Object? dislikedIngredients = null,
    Object? dietaryRestrictions = null,
    Object? allergies = null,
    Object? allowLeftovers = null,
    Object? maxLeftoverDays = null,
    Object? batchCookingPreferred = null,
    Object? kitchenEquipment = null,
    Object? skillLevel = freezed,
    Object? weeklyBudget = null,
  }) {
    return _then(_$MealPlanPreferencesImpl(
      preferredMealTypes: null == preferredMealTypes
          ? _value._preferredMealTypes
          : preferredMealTypes // ignore: cast_nullable_to_non_nullable
              as List<MealType>,
      defaultServings: null == defaultServings
          ? _value.defaultServings
          : defaultServings // ignore: cast_nullable_to_non_nullable
              as int,
      maxPrepTimeMinutes: null == maxPrepTimeMinutes
          ? _value.maxPrepTimeMinutes
          : maxPrepTimeMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      maxCookTimeMinutes: null == maxCookTimeMinutes
          ? _value.maxCookTimeMinutes
          : maxCookTimeMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      preferredCuisines: null == preferredCuisines
          ? _value._preferredCuisines
          : preferredCuisines // ignore: cast_nullable_to_non_nullable
              as List<String>,
      dislikedIngredients: null == dislikedIngredients
          ? _value._dislikedIngredients
          : dislikedIngredients // ignore: cast_nullable_to_non_nullable
              as List<String>,
      dietaryRestrictions: null == dietaryRestrictions
          ? _value._dietaryRestrictions
          : dietaryRestrictions // ignore: cast_nullable_to_non_nullable
              as List<DietaryRestriction>,
      allergies: null == allergies
          ? _value._allergies
          : allergies // ignore: cast_nullable_to_non_nullable
              as List<String>,
      allowLeftovers: null == allowLeftovers
          ? _value.allowLeftovers
          : allowLeftovers // ignore: cast_nullable_to_non_nullable
              as bool,
      maxLeftoverDays: null == maxLeftoverDays
          ? _value.maxLeftoverDays
          : maxLeftoverDays // ignore: cast_nullable_to_non_nullable
              as int,
      batchCookingPreferred: null == batchCookingPreferred
          ? _value.batchCookingPreferred
          : batchCookingPreferred // ignore: cast_nullable_to_non_nullable
              as bool,
      kitchenEquipment: null == kitchenEquipment
          ? _value._kitchenEquipment
          : kitchenEquipment // ignore: cast_nullable_to_non_nullable
              as List<String>,
      skillLevel: freezed == skillLevel
          ? _value.skillLevel
          : skillLevel // ignore: cast_nullable_to_non_nullable
              as SkillLevel?,
      weeklyBudget: null == weeklyBudget
          ? _value.weeklyBudget
          : weeklyBudget // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MealPlanPreferencesImpl implements _MealPlanPreferences {
  const _$MealPlanPreferencesImpl(
      {@HiveField(0) final List<MealType> preferredMealTypes = const [],
      @HiveField(1) this.defaultServings = 4,
      @HiveField(2) this.maxPrepTimeMinutes = 30,
      @HiveField(3) this.maxCookTimeMinutes = 60,
      @HiveField(4) final List<String> preferredCuisines = const [],
      @HiveField(5) final List<String> dislikedIngredients = const [],
      @HiveField(6)
      final List<DietaryRestriction> dietaryRestrictions = const [],
      @HiveField(7) final List<String> allergies = const [],
      @HiveField(8) this.allowLeftovers = false,
      @HiveField(9) this.maxLeftoverDays = 2,
      @HiveField(10) this.batchCookingPreferred = false,
      @HiveField(11) final List<String> kitchenEquipment = const [],
      @HiveField(12) this.skillLevel,
      @HiveField(13) this.weeklyBudget = 100.0})
      : _preferredMealTypes = preferredMealTypes,
        _preferredCuisines = preferredCuisines,
        _dislikedIngredients = dislikedIngredients,
        _dietaryRestrictions = dietaryRestrictions,
        _allergies = allergies,
        _kitchenEquipment = kitchenEquipment;

  factory _$MealPlanPreferencesImpl.fromJson(Map<String, dynamic> json) =>
      _$$MealPlanPreferencesImplFromJson(json);

  final List<MealType> _preferredMealTypes;
  @override
  @JsonKey()
  @HiveField(0)
  List<MealType> get preferredMealTypes {
    if (_preferredMealTypes is EqualUnmodifiableListView)
      return _preferredMealTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_preferredMealTypes);
  }

  @override
  @JsonKey()
  @HiveField(1)
  final int defaultServings;
  @override
  @JsonKey()
  @HiveField(2)
  final int maxPrepTimeMinutes;
  @override
  @JsonKey()
  @HiveField(3)
  final int maxCookTimeMinutes;
  final List<String> _preferredCuisines;
  @override
  @JsonKey()
  @HiveField(4)
  List<String> get preferredCuisines {
    if (_preferredCuisines is EqualUnmodifiableListView)
      return _preferredCuisines;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_preferredCuisines);
  }

  final List<String> _dislikedIngredients;
  @override
  @JsonKey()
  @HiveField(5)
  List<String> get dislikedIngredients {
    if (_dislikedIngredients is EqualUnmodifiableListView)
      return _dislikedIngredients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dislikedIngredients);
  }

  final List<DietaryRestriction> _dietaryRestrictions;
  @override
  @JsonKey()
  @HiveField(6)
  List<DietaryRestriction> get dietaryRestrictions {
    if (_dietaryRestrictions is EqualUnmodifiableListView)
      return _dietaryRestrictions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dietaryRestrictions);
  }

  final List<String> _allergies;
  @override
  @JsonKey()
  @HiveField(7)
  List<String> get allergies {
    if (_allergies is EqualUnmodifiableListView) return _allergies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allergies);
  }

  @override
  @JsonKey()
  @HiveField(8)
  final bool allowLeftovers;
  @override
  @JsonKey()
  @HiveField(9)
  final int maxLeftoverDays;
  @override
  @JsonKey()
  @HiveField(10)
  final bool batchCookingPreferred;
  final List<String> _kitchenEquipment;
  @override
  @JsonKey()
  @HiveField(11)
  List<String> get kitchenEquipment {
    if (_kitchenEquipment is EqualUnmodifiableListView)
      return _kitchenEquipment;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_kitchenEquipment);
  }

  @override
  @HiveField(12)
  final SkillLevel? skillLevel;
// Now properly imported
  @override
  @JsonKey()
  @HiveField(13)
  final double weeklyBudget;

  @override
  String toString() {
    return 'MealPlanPreferences(preferredMealTypes: $preferredMealTypes, defaultServings: $defaultServings, maxPrepTimeMinutes: $maxPrepTimeMinutes, maxCookTimeMinutes: $maxCookTimeMinutes, preferredCuisines: $preferredCuisines, dislikedIngredients: $dislikedIngredients, dietaryRestrictions: $dietaryRestrictions, allergies: $allergies, allowLeftovers: $allowLeftovers, maxLeftoverDays: $maxLeftoverDays, batchCookingPreferred: $batchCookingPreferred, kitchenEquipment: $kitchenEquipment, skillLevel: $skillLevel, weeklyBudget: $weeklyBudget)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MealPlanPreferencesImpl &&
            const DeepCollectionEquality()
                .equals(other._preferredMealTypes, _preferredMealTypes) &&
            (identical(other.defaultServings, defaultServings) ||
                other.defaultServings == defaultServings) &&
            (identical(other.maxPrepTimeMinutes, maxPrepTimeMinutes) ||
                other.maxPrepTimeMinutes == maxPrepTimeMinutes) &&
            (identical(other.maxCookTimeMinutes, maxCookTimeMinutes) ||
                other.maxCookTimeMinutes == maxCookTimeMinutes) &&
            const DeepCollectionEquality()
                .equals(other._preferredCuisines, _preferredCuisines) &&
            const DeepCollectionEquality()
                .equals(other._dislikedIngredients, _dislikedIngredients) &&
            const DeepCollectionEquality()
                .equals(other._dietaryRestrictions, _dietaryRestrictions) &&
            const DeepCollectionEquality()
                .equals(other._allergies, _allergies) &&
            (identical(other.allowLeftovers, allowLeftovers) ||
                other.allowLeftovers == allowLeftovers) &&
            (identical(other.maxLeftoverDays, maxLeftoverDays) ||
                other.maxLeftoverDays == maxLeftoverDays) &&
            (identical(other.batchCookingPreferred, batchCookingPreferred) ||
                other.batchCookingPreferred == batchCookingPreferred) &&
            const DeepCollectionEquality()
                .equals(other._kitchenEquipment, _kitchenEquipment) &&
            (identical(other.skillLevel, skillLevel) ||
                other.skillLevel == skillLevel) &&
            (identical(other.weeklyBudget, weeklyBudget) ||
                other.weeklyBudget == weeklyBudget));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_preferredMealTypes),
      defaultServings,
      maxPrepTimeMinutes,
      maxCookTimeMinutes,
      const DeepCollectionEquality().hash(_preferredCuisines),
      const DeepCollectionEquality().hash(_dislikedIngredients),
      const DeepCollectionEquality().hash(_dietaryRestrictions),
      const DeepCollectionEquality().hash(_allergies),
      allowLeftovers,
      maxLeftoverDays,
      batchCookingPreferred,
      const DeepCollectionEquality().hash(_kitchenEquipment),
      skillLevel,
      weeklyBudget);

  /// Create a copy of MealPlanPreferences
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MealPlanPreferencesImplCopyWith<_$MealPlanPreferencesImpl> get copyWith =>
      __$$MealPlanPreferencesImplCopyWithImpl<_$MealPlanPreferencesImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MealPlanPreferencesImplToJson(
      this,
    );
  }
}

abstract class _MealPlanPreferences implements MealPlanPreferences {
  const factory _MealPlanPreferences(
      {@HiveField(0) final List<MealType> preferredMealTypes,
      @HiveField(1) final int defaultServings,
      @HiveField(2) final int maxPrepTimeMinutes,
      @HiveField(3) final int maxCookTimeMinutes,
      @HiveField(4) final List<String> preferredCuisines,
      @HiveField(5) final List<String> dislikedIngredients,
      @HiveField(6) final List<DietaryRestriction> dietaryRestrictions,
      @HiveField(7) final List<String> allergies,
      @HiveField(8) final bool allowLeftovers,
      @HiveField(9) final int maxLeftoverDays,
      @HiveField(10) final bool batchCookingPreferred,
      @HiveField(11) final List<String> kitchenEquipment,
      @HiveField(12) final SkillLevel? skillLevel,
      @HiveField(13) final double weeklyBudget}) = _$MealPlanPreferencesImpl;

  factory _MealPlanPreferences.fromJson(Map<String, dynamic> json) =
      _$MealPlanPreferencesImpl.fromJson;

  @override
  @HiveField(0)
  List<MealType> get preferredMealTypes;
  @override
  @HiveField(1)
  int get defaultServings;
  @override
  @HiveField(2)
  int get maxPrepTimeMinutes;
  @override
  @HiveField(3)
  int get maxCookTimeMinutes;
  @override
  @HiveField(4)
  List<String> get preferredCuisines;
  @override
  @HiveField(5)
  List<String> get dislikedIngredients;
  @override
  @HiveField(6)
  List<DietaryRestriction> get dietaryRestrictions;
  @override
  @HiveField(7)
  List<String> get allergies;
  @override
  @HiveField(8)
  bool get allowLeftovers;
  @override
  @HiveField(9)
  int get maxLeftoverDays;
  @override
  @HiveField(10)
  bool get batchCookingPreferred;
  @override
  @HiveField(11)
  List<String> get kitchenEquipment;
  @override
  @HiveField(12)
  SkillLevel? get skillLevel; // Now properly imported
  @override
  @HiveField(13)
  double get weeklyBudget;

  /// Create a copy of MealPlanPreferences
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MealPlanPreferencesImplCopyWith<_$MealPlanPreferencesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NutritionSummary _$NutritionSummaryFromJson(Map<String, dynamic> json) {
  return _NutritionSummary.fromJson(json);
}

/// @nodoc
mixin _$NutritionSummary {
  @HiveField(0)
  double get totalCalories => throw _privateConstructorUsedError;
  @HiveField(1)
  double get totalProtein => throw _privateConstructorUsedError;
  @HiveField(2)
  double get totalCarbs => throw _privateConstructorUsedError;
  @HiveField(3)
  double get totalFat => throw _privateConstructorUsedError;
  @HiveField(4)
  double get totalFiber => throw _privateConstructorUsedError;
  @HiveField(5)
  double get totalSodium => throw _privateConstructorUsedError;
  @HiveField(6)
  double get totalSugar => throw _privateConstructorUsedError;
  @HiveField(7)
  Map<MealType, NutritionInfo> get mealBreakdown =>
      throw _privateConstructorUsedError;
  @HiveField(8)
  NutritionGoals? get goals => throw _privateConstructorUsedError;

  /// Serializes this NutritionSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NutritionSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NutritionSummaryCopyWith<NutritionSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NutritionSummaryCopyWith<$Res> {
  factory $NutritionSummaryCopyWith(
          NutritionSummary value, $Res Function(NutritionSummary) then) =
      _$NutritionSummaryCopyWithImpl<$Res, NutritionSummary>;
  @useResult
  $Res call(
      {@HiveField(0) double totalCalories,
      @HiveField(1) double totalProtein,
      @HiveField(2) double totalCarbs,
      @HiveField(3) double totalFat,
      @HiveField(4) double totalFiber,
      @HiveField(5) double totalSodium,
      @HiveField(6) double totalSugar,
      @HiveField(7) Map<MealType, NutritionInfo> mealBreakdown,
      @HiveField(8) NutritionGoals? goals});
}

/// @nodoc
class _$NutritionSummaryCopyWithImpl<$Res, $Val extends NutritionSummary>
    implements $NutritionSummaryCopyWith<$Res> {
  _$NutritionSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NutritionSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalCalories = null,
    Object? totalProtein = null,
    Object? totalCarbs = null,
    Object? totalFat = null,
    Object? totalFiber = null,
    Object? totalSodium = null,
    Object? totalSugar = null,
    Object? mealBreakdown = null,
    Object? goals = freezed,
  }) {
    return _then(_value.copyWith(
      totalCalories: null == totalCalories
          ? _value.totalCalories
          : totalCalories // ignore: cast_nullable_to_non_nullable
              as double,
      totalProtein: null == totalProtein
          ? _value.totalProtein
          : totalProtein // ignore: cast_nullable_to_non_nullable
              as double,
      totalCarbs: null == totalCarbs
          ? _value.totalCarbs
          : totalCarbs // ignore: cast_nullable_to_non_nullable
              as double,
      totalFat: null == totalFat
          ? _value.totalFat
          : totalFat // ignore: cast_nullable_to_non_nullable
              as double,
      totalFiber: null == totalFiber
          ? _value.totalFiber
          : totalFiber // ignore: cast_nullable_to_non_nullable
              as double,
      totalSodium: null == totalSodium
          ? _value.totalSodium
          : totalSodium // ignore: cast_nullable_to_non_nullable
              as double,
      totalSugar: null == totalSugar
          ? _value.totalSugar
          : totalSugar // ignore: cast_nullable_to_non_nullable
              as double,
      mealBreakdown: null == mealBreakdown
          ? _value.mealBreakdown
          : mealBreakdown // ignore: cast_nullable_to_non_nullable
              as Map<MealType, NutritionInfo>,
      goals: freezed == goals
          ? _value.goals
          : goals // ignore: cast_nullable_to_non_nullable
              as NutritionGoals?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NutritionSummaryImplCopyWith<$Res>
    implements $NutritionSummaryCopyWith<$Res> {
  factory _$$NutritionSummaryImplCopyWith(_$NutritionSummaryImpl value,
          $Res Function(_$NutritionSummaryImpl) then) =
      __$$NutritionSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) double totalCalories,
      @HiveField(1) double totalProtein,
      @HiveField(2) double totalCarbs,
      @HiveField(3) double totalFat,
      @HiveField(4) double totalFiber,
      @HiveField(5) double totalSodium,
      @HiveField(6) double totalSugar,
      @HiveField(7) Map<MealType, NutritionInfo> mealBreakdown,
      @HiveField(8) NutritionGoals? goals});
}

/// @nodoc
class __$$NutritionSummaryImplCopyWithImpl<$Res>
    extends _$NutritionSummaryCopyWithImpl<$Res, _$NutritionSummaryImpl>
    implements _$$NutritionSummaryImplCopyWith<$Res> {
  __$$NutritionSummaryImplCopyWithImpl(_$NutritionSummaryImpl _value,
      $Res Function(_$NutritionSummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of NutritionSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalCalories = null,
    Object? totalProtein = null,
    Object? totalCarbs = null,
    Object? totalFat = null,
    Object? totalFiber = null,
    Object? totalSodium = null,
    Object? totalSugar = null,
    Object? mealBreakdown = null,
    Object? goals = freezed,
  }) {
    return _then(_$NutritionSummaryImpl(
      totalCalories: null == totalCalories
          ? _value.totalCalories
          : totalCalories // ignore: cast_nullable_to_non_nullable
              as double,
      totalProtein: null == totalProtein
          ? _value.totalProtein
          : totalProtein // ignore: cast_nullable_to_non_nullable
              as double,
      totalCarbs: null == totalCarbs
          ? _value.totalCarbs
          : totalCarbs // ignore: cast_nullable_to_non_nullable
              as double,
      totalFat: null == totalFat
          ? _value.totalFat
          : totalFat // ignore: cast_nullable_to_non_nullable
              as double,
      totalFiber: null == totalFiber
          ? _value.totalFiber
          : totalFiber // ignore: cast_nullable_to_non_nullable
              as double,
      totalSodium: null == totalSodium
          ? _value.totalSodium
          : totalSodium // ignore: cast_nullable_to_non_nullable
              as double,
      totalSugar: null == totalSugar
          ? _value.totalSugar
          : totalSugar // ignore: cast_nullable_to_non_nullable
              as double,
      mealBreakdown: null == mealBreakdown
          ? _value._mealBreakdown
          : mealBreakdown // ignore: cast_nullable_to_non_nullable
              as Map<MealType, NutritionInfo>,
      goals: freezed == goals
          ? _value.goals
          : goals // ignore: cast_nullable_to_non_nullable
              as NutritionGoals?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NutritionSummaryImpl implements _NutritionSummary {
  const _$NutritionSummaryImpl(
      {@HiveField(0) required this.totalCalories,
      @HiveField(1) required this.totalProtein,
      @HiveField(2) required this.totalCarbs,
      @HiveField(3) required this.totalFat,
      @HiveField(4) required this.totalFiber,
      @HiveField(5) required this.totalSodium,
      @HiveField(6) required this.totalSugar,
      @HiveField(7) required final Map<MealType, NutritionInfo> mealBreakdown,
      @HiveField(8) this.goals})
      : _mealBreakdown = mealBreakdown;

  factory _$NutritionSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$NutritionSummaryImplFromJson(json);

  @override
  @HiveField(0)
  final double totalCalories;
  @override
  @HiveField(1)
  final double totalProtein;
  @override
  @HiveField(2)
  final double totalCarbs;
  @override
  @HiveField(3)
  final double totalFat;
  @override
  @HiveField(4)
  final double totalFiber;
  @override
  @HiveField(5)
  final double totalSodium;
  @override
  @HiveField(6)
  final double totalSugar;
  final Map<MealType, NutritionInfo> _mealBreakdown;
  @override
  @HiveField(7)
  Map<MealType, NutritionInfo> get mealBreakdown {
    if (_mealBreakdown is EqualUnmodifiableMapView) return _mealBreakdown;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_mealBreakdown);
  }

  @override
  @HiveField(8)
  final NutritionGoals? goals;

  @override
  String toString() {
    return 'NutritionSummary(totalCalories: $totalCalories, totalProtein: $totalProtein, totalCarbs: $totalCarbs, totalFat: $totalFat, totalFiber: $totalFiber, totalSodium: $totalSodium, totalSugar: $totalSugar, mealBreakdown: $mealBreakdown, goals: $goals)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NutritionSummaryImpl &&
            (identical(other.totalCalories, totalCalories) ||
                other.totalCalories == totalCalories) &&
            (identical(other.totalProtein, totalProtein) ||
                other.totalProtein == totalProtein) &&
            (identical(other.totalCarbs, totalCarbs) ||
                other.totalCarbs == totalCarbs) &&
            (identical(other.totalFat, totalFat) ||
                other.totalFat == totalFat) &&
            (identical(other.totalFiber, totalFiber) ||
                other.totalFiber == totalFiber) &&
            (identical(other.totalSodium, totalSodium) ||
                other.totalSodium == totalSodium) &&
            (identical(other.totalSugar, totalSugar) ||
                other.totalSugar == totalSugar) &&
            const DeepCollectionEquality()
                .equals(other._mealBreakdown, _mealBreakdown) &&
            const DeepCollectionEquality().equals(other.goals, goals));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalCalories,
      totalProtein,
      totalCarbs,
      totalFat,
      totalFiber,
      totalSodium,
      totalSugar,
      const DeepCollectionEquality().hash(_mealBreakdown),
      const DeepCollectionEquality().hash(goals));

  /// Create a copy of NutritionSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NutritionSummaryImplCopyWith<_$NutritionSummaryImpl> get copyWith =>
      __$$NutritionSummaryImplCopyWithImpl<_$NutritionSummaryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NutritionSummaryImplToJson(
      this,
    );
  }
}

abstract class _NutritionSummary implements NutritionSummary {
  const factory _NutritionSummary(
      {@HiveField(0) required final double totalCalories,
      @HiveField(1) required final double totalProtein,
      @HiveField(2) required final double totalCarbs,
      @HiveField(3) required final double totalFat,
      @HiveField(4) required final double totalFiber,
      @HiveField(5) required final double totalSodium,
      @HiveField(6) required final double totalSugar,
      @HiveField(7) required final Map<MealType, NutritionInfo> mealBreakdown,
      @HiveField(8) final NutritionGoals? goals}) = _$NutritionSummaryImpl;

  factory _NutritionSummary.fromJson(Map<String, dynamic> json) =
      _$NutritionSummaryImpl.fromJson;

  @override
  @HiveField(0)
  double get totalCalories;
  @override
  @HiveField(1)
  double get totalProtein;
  @override
  @HiveField(2)
  double get totalCarbs;
  @override
  @HiveField(3)
  double get totalFat;
  @override
  @HiveField(4)
  double get totalFiber;
  @override
  @HiveField(5)
  double get totalSodium;
  @override
  @HiveField(6)
  double get totalSugar;
  @override
  @HiveField(7)
  Map<MealType, NutritionInfo> get mealBreakdown;
  @override
  @HiveField(8)
  NutritionGoals? get goals;

  /// Create a copy of NutritionSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NutritionSummaryImplCopyWith<_$NutritionSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MealPlanTemplate _$MealPlanTemplateFromJson(Map<String, dynamic> json) {
  return _MealPlanTemplate.fromJson(json);
}

/// @nodoc
mixin _$MealPlanTemplate {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get name => throw _privateConstructorUsedError;
  @HiveField(2)
  String get description => throw _privateConstructorUsedError;
  @HiveField(3)
  int get durationDays => throw _privateConstructorUsedError;
  @HiveField(4)
  List<MealPlanDay> get templateDays => throw _privateConstructorUsedError;
  @HiveField(5)
  String get createdBy => throw _privateConstructorUsedError;
  @HiveField(6)
  DateTime get createdAt => throw _privateConstructorUsedError;
  @HiveField(7)
  List<String> get tags => throw _privateConstructorUsedError;
  @HiveField(8)
  bool get isPublic => throw _privateConstructorUsedError;
  @HiveField(9)
  int get usageCount => throw _privateConstructorUsedError;
  @HiveField(10)
  double get rating => throw _privateConstructorUsedError;
  @HiveField(11)
  NutritionGoals? get targetNutrition => throw _privateConstructorUsedError;
  @HiveField(12)
  double get estimatedWeeklyCost => throw _privateConstructorUsedError;
  @HiveField(13)
  List<String> get requiredEquipment => throw _privateConstructorUsedError;
  @HiveField(14)
  SkillLevel? get requiredSkillLevel => throw _privateConstructorUsedError;

  /// Serializes this MealPlanTemplate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MealPlanTemplate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MealPlanTemplateCopyWith<MealPlanTemplate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MealPlanTemplateCopyWith<$Res> {
  factory $MealPlanTemplateCopyWith(
          MealPlanTemplate value, $Res Function(MealPlanTemplate) then) =
      _$MealPlanTemplateCopyWithImpl<$Res, MealPlanTemplate>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String name,
      @HiveField(2) String description,
      @HiveField(3) int durationDays,
      @HiveField(4) List<MealPlanDay> templateDays,
      @HiveField(5) String createdBy,
      @HiveField(6) DateTime createdAt,
      @HiveField(7) List<String> tags,
      @HiveField(8) bool isPublic,
      @HiveField(9) int usageCount,
      @HiveField(10) double rating,
      @HiveField(11) NutritionGoals? targetNutrition,
      @HiveField(12) double estimatedWeeklyCost,
      @HiveField(13) List<String> requiredEquipment,
      @HiveField(14) SkillLevel? requiredSkillLevel});
}

/// @nodoc
class _$MealPlanTemplateCopyWithImpl<$Res, $Val extends MealPlanTemplate>
    implements $MealPlanTemplateCopyWith<$Res> {
  _$MealPlanTemplateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MealPlanTemplate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? durationDays = null,
    Object? templateDays = null,
    Object? createdBy = null,
    Object? createdAt = null,
    Object? tags = null,
    Object? isPublic = null,
    Object? usageCount = null,
    Object? rating = null,
    Object? targetNutrition = freezed,
    Object? estimatedWeeklyCost = null,
    Object? requiredEquipment = null,
    Object? requiredSkillLevel = freezed,
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
      durationDays: null == durationDays
          ? _value.durationDays
          : durationDays // ignore: cast_nullable_to_non_nullable
              as int,
      templateDays: null == templateDays
          ? _value.templateDays
          : templateDays // ignore: cast_nullable_to_non_nullable
              as List<MealPlanDay>,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isPublic: null == isPublic
          ? _value.isPublic
          : isPublic // ignore: cast_nullable_to_non_nullable
              as bool,
      usageCount: null == usageCount
          ? _value.usageCount
          : usageCount // ignore: cast_nullable_to_non_nullable
              as int,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      targetNutrition: freezed == targetNutrition
          ? _value.targetNutrition
          : targetNutrition // ignore: cast_nullable_to_non_nullable
              as NutritionGoals?,
      estimatedWeeklyCost: null == estimatedWeeklyCost
          ? _value.estimatedWeeklyCost
          : estimatedWeeklyCost // ignore: cast_nullable_to_non_nullable
              as double,
      requiredEquipment: null == requiredEquipment
          ? _value.requiredEquipment
          : requiredEquipment // ignore: cast_nullable_to_non_nullable
              as List<String>,
      requiredSkillLevel: freezed == requiredSkillLevel
          ? _value.requiredSkillLevel
          : requiredSkillLevel // ignore: cast_nullable_to_non_nullable
              as SkillLevel?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MealPlanTemplateImplCopyWith<$Res>
    implements $MealPlanTemplateCopyWith<$Res> {
  factory _$$MealPlanTemplateImplCopyWith(_$MealPlanTemplateImpl value,
          $Res Function(_$MealPlanTemplateImpl) then) =
      __$$MealPlanTemplateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String name,
      @HiveField(2) String description,
      @HiveField(3) int durationDays,
      @HiveField(4) List<MealPlanDay> templateDays,
      @HiveField(5) String createdBy,
      @HiveField(6) DateTime createdAt,
      @HiveField(7) List<String> tags,
      @HiveField(8) bool isPublic,
      @HiveField(9) int usageCount,
      @HiveField(10) double rating,
      @HiveField(11) NutritionGoals? targetNutrition,
      @HiveField(12) double estimatedWeeklyCost,
      @HiveField(13) List<String> requiredEquipment,
      @HiveField(14) SkillLevel? requiredSkillLevel});
}

/// @nodoc
class __$$MealPlanTemplateImplCopyWithImpl<$Res>
    extends _$MealPlanTemplateCopyWithImpl<$Res, _$MealPlanTemplateImpl>
    implements _$$MealPlanTemplateImplCopyWith<$Res> {
  __$$MealPlanTemplateImplCopyWithImpl(_$MealPlanTemplateImpl _value,
      $Res Function(_$MealPlanTemplateImpl) _then)
      : super(_value, _then);

  /// Create a copy of MealPlanTemplate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? durationDays = null,
    Object? templateDays = null,
    Object? createdBy = null,
    Object? createdAt = null,
    Object? tags = null,
    Object? isPublic = null,
    Object? usageCount = null,
    Object? rating = null,
    Object? targetNutrition = freezed,
    Object? estimatedWeeklyCost = null,
    Object? requiredEquipment = null,
    Object? requiredSkillLevel = freezed,
  }) {
    return _then(_$MealPlanTemplateImpl(
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
      durationDays: null == durationDays
          ? _value.durationDays
          : durationDays // ignore: cast_nullable_to_non_nullable
              as int,
      templateDays: null == templateDays
          ? _value._templateDays
          : templateDays // ignore: cast_nullable_to_non_nullable
              as List<MealPlanDay>,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isPublic: null == isPublic
          ? _value.isPublic
          : isPublic // ignore: cast_nullable_to_non_nullable
              as bool,
      usageCount: null == usageCount
          ? _value.usageCount
          : usageCount // ignore: cast_nullable_to_non_nullable
              as int,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      targetNutrition: freezed == targetNutrition
          ? _value.targetNutrition
          : targetNutrition // ignore: cast_nullable_to_non_nullable
              as NutritionGoals?,
      estimatedWeeklyCost: null == estimatedWeeklyCost
          ? _value.estimatedWeeklyCost
          : estimatedWeeklyCost // ignore: cast_nullable_to_non_nullable
              as double,
      requiredEquipment: null == requiredEquipment
          ? _value._requiredEquipment
          : requiredEquipment // ignore: cast_nullable_to_non_nullable
              as List<String>,
      requiredSkillLevel: freezed == requiredSkillLevel
          ? _value.requiredSkillLevel
          : requiredSkillLevel // ignore: cast_nullable_to_non_nullable
              as SkillLevel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MealPlanTemplateImpl implements _MealPlanTemplate {
  const _$MealPlanTemplateImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.name,
      @HiveField(2) required this.description,
      @HiveField(3) required this.durationDays,
      @HiveField(4) required final List<MealPlanDay> templateDays,
      @HiveField(5) required this.createdBy,
      @HiveField(6) required this.createdAt,
      @HiveField(7) final List<String> tags = const [],
      @HiveField(8) this.isPublic = false,
      @HiveField(9) this.usageCount = 0,
      @HiveField(10) this.rating = 0.0,
      @HiveField(11) this.targetNutrition,
      @HiveField(12) this.estimatedWeeklyCost = 0.0,
      @HiveField(13) final List<String> requiredEquipment = const [],
      @HiveField(14) this.requiredSkillLevel})
      : _templateDays = templateDays,
        _tags = tags,
        _requiredEquipment = requiredEquipment;

  factory _$MealPlanTemplateImpl.fromJson(Map<String, dynamic> json) =>
      _$$MealPlanTemplateImplFromJson(json);

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
  final int durationDays;
  final List<MealPlanDay> _templateDays;
  @override
  @HiveField(4)
  List<MealPlanDay> get templateDays {
    if (_templateDays is EqualUnmodifiableListView) return _templateDays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_templateDays);
  }

  @override
  @HiveField(5)
  final String createdBy;
  @override
  @HiveField(6)
  final DateTime createdAt;
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
  final bool isPublic;
  @override
  @JsonKey()
  @HiveField(9)
  final int usageCount;
  @override
  @JsonKey()
  @HiveField(10)
  final double rating;
  @override
  @HiveField(11)
  final NutritionGoals? targetNutrition;
  @override
  @JsonKey()
  @HiveField(12)
  final double estimatedWeeklyCost;
  final List<String> _requiredEquipment;
  @override
  @JsonKey()
  @HiveField(13)
  List<String> get requiredEquipment {
    if (_requiredEquipment is EqualUnmodifiableListView)
      return _requiredEquipment;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_requiredEquipment);
  }

  @override
  @HiveField(14)
  final SkillLevel? requiredSkillLevel;

  @override
  String toString() {
    return 'MealPlanTemplate(id: $id, name: $name, description: $description, durationDays: $durationDays, templateDays: $templateDays, createdBy: $createdBy, createdAt: $createdAt, tags: $tags, isPublic: $isPublic, usageCount: $usageCount, rating: $rating, targetNutrition: $targetNutrition, estimatedWeeklyCost: $estimatedWeeklyCost, requiredEquipment: $requiredEquipment, requiredSkillLevel: $requiredSkillLevel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MealPlanTemplateImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.durationDays, durationDays) ||
                other.durationDays == durationDays) &&
            const DeepCollectionEquality()
                .equals(other._templateDays, _templateDays) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.isPublic, isPublic) ||
                other.isPublic == isPublic) &&
            (identical(other.usageCount, usageCount) ||
                other.usageCount == usageCount) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            const DeepCollectionEquality()
                .equals(other.targetNutrition, targetNutrition) &&
            (identical(other.estimatedWeeklyCost, estimatedWeeklyCost) ||
                other.estimatedWeeklyCost == estimatedWeeklyCost) &&
            const DeepCollectionEquality()
                .equals(other._requiredEquipment, _requiredEquipment) &&
            (identical(other.requiredSkillLevel, requiredSkillLevel) ||
                other.requiredSkillLevel == requiredSkillLevel));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      durationDays,
      const DeepCollectionEquality().hash(_templateDays),
      createdBy,
      createdAt,
      const DeepCollectionEquality().hash(_tags),
      isPublic,
      usageCount,
      rating,
      const DeepCollectionEquality().hash(targetNutrition),
      estimatedWeeklyCost,
      const DeepCollectionEquality().hash(_requiredEquipment),
      requiredSkillLevel);

  /// Create a copy of MealPlanTemplate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MealPlanTemplateImplCopyWith<_$MealPlanTemplateImpl> get copyWith =>
      __$$MealPlanTemplateImplCopyWithImpl<_$MealPlanTemplateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MealPlanTemplateImplToJson(
      this,
    );
  }
}

abstract class _MealPlanTemplate implements MealPlanTemplate {
  const factory _MealPlanTemplate(
          {@HiveField(0) required final String id,
          @HiveField(1) required final String name,
          @HiveField(2) required final String description,
          @HiveField(3) required final int durationDays,
          @HiveField(4) required final List<MealPlanDay> templateDays,
          @HiveField(5) required final String createdBy,
          @HiveField(6) required final DateTime createdAt,
          @HiveField(7) final List<String> tags,
          @HiveField(8) final bool isPublic,
          @HiveField(9) final int usageCount,
          @HiveField(10) final double rating,
          @HiveField(11) final NutritionGoals? targetNutrition,
          @HiveField(12) final double estimatedWeeklyCost,
          @HiveField(13) final List<String> requiredEquipment,
          @HiveField(14) final SkillLevel? requiredSkillLevel}) =
      _$MealPlanTemplateImpl;

  factory _MealPlanTemplate.fromJson(Map<String, dynamic> json) =
      _$MealPlanTemplateImpl.fromJson;

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
  int get durationDays;
  @override
  @HiveField(4)
  List<MealPlanDay> get templateDays;
  @override
  @HiveField(5)
  String get createdBy;
  @override
  @HiveField(6)
  DateTime get createdAt;
  @override
  @HiveField(7)
  List<String> get tags;
  @override
  @HiveField(8)
  bool get isPublic;
  @override
  @HiveField(9)
  int get usageCount;
  @override
  @HiveField(10)
  double get rating;
  @override
  @HiveField(11)
  NutritionGoals? get targetNutrition;
  @override
  @HiveField(12)
  double get estimatedWeeklyCost;
  @override
  @HiveField(13)
  List<String> get requiredEquipment;
  @override
  @HiveField(14)
  SkillLevel? get requiredSkillLevel;

  /// Create a copy of MealPlanTemplate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MealPlanTemplateImplCopyWith<_$MealPlanTemplateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
