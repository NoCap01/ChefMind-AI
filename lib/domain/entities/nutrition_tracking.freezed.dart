// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nutrition_tracking.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NutritionEntry _$NutritionEntryFromJson(Map<String, dynamic> json) {
  return _NutritionEntry.fromJson(json);
}

/// @nodoc
mixin _$NutritionEntry {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  List<FoodEntry> get foods => throw _privateConstructorUsedError;
  NutritionInfo get totalNutrition => throw _privateConstructorUsedError;
  Map<MealType, NutritionInfo> get mealBreakdown =>
      throw _privateConstructorUsedError;
  NutritionGoals? get dailyGoals => throw _privateConstructorUsedError;
  double get waterIntakeMl => throw _privateConstructorUsedError;
  List<String> get notes => throw _privateConstructorUsedError;
  List<String> get symptoms => throw _privateConstructorUsedError;
  double get exerciseCaloriesBurned => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this NutritionEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NutritionEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NutritionEntryCopyWith<NutritionEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NutritionEntryCopyWith<$Res> {
  factory $NutritionEntryCopyWith(
          NutritionEntry value, $Res Function(NutritionEntry) then) =
      _$NutritionEntryCopyWithImpl<$Res, NutritionEntry>;
  @useResult
  $Res call(
      {String id,
      String userId,
      DateTime date,
      List<FoodEntry> foods,
      NutritionInfo totalNutrition,
      Map<MealType, NutritionInfo> mealBreakdown,
      NutritionGoals? dailyGoals,
      double waterIntakeMl,
      List<String> notes,
      List<String> symptoms,
      double exerciseCaloriesBurned,
      DateTime createdAt,
      DateTime? updatedAt});

  $NutritionInfoCopyWith<$Res> get totalNutrition;
}

/// @nodoc
class _$NutritionEntryCopyWithImpl<$Res, $Val extends NutritionEntry>
    implements $NutritionEntryCopyWith<$Res> {
  _$NutritionEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NutritionEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? date = null,
    Object? foods = null,
    Object? totalNutrition = null,
    Object? mealBreakdown = null,
    Object? dailyGoals = freezed,
    Object? waterIntakeMl = null,
    Object? notes = null,
    Object? symptoms = null,
    Object? exerciseCaloriesBurned = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
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
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      foods: null == foods
          ? _value.foods
          : foods // ignore: cast_nullable_to_non_nullable
              as List<FoodEntry>,
      totalNutrition: null == totalNutrition
          ? _value.totalNutrition
          : totalNutrition // ignore: cast_nullable_to_non_nullable
              as NutritionInfo,
      mealBreakdown: null == mealBreakdown
          ? _value.mealBreakdown
          : mealBreakdown // ignore: cast_nullable_to_non_nullable
              as Map<MealType, NutritionInfo>,
      dailyGoals: freezed == dailyGoals
          ? _value.dailyGoals
          : dailyGoals // ignore: cast_nullable_to_non_nullable
              as NutritionGoals?,
      waterIntakeMl: null == waterIntakeMl
          ? _value.waterIntakeMl
          : waterIntakeMl // ignore: cast_nullable_to_non_nullable
              as double,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      symptoms: null == symptoms
          ? _value.symptoms
          : symptoms // ignore: cast_nullable_to_non_nullable
              as List<String>,
      exerciseCaloriesBurned: null == exerciseCaloriesBurned
          ? _value.exerciseCaloriesBurned
          : exerciseCaloriesBurned // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  /// Create a copy of NutritionEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NutritionInfoCopyWith<$Res> get totalNutrition {
    return $NutritionInfoCopyWith<$Res>(_value.totalNutrition, (value) {
      return _then(_value.copyWith(totalNutrition: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NutritionEntryImplCopyWith<$Res>
    implements $NutritionEntryCopyWith<$Res> {
  factory _$$NutritionEntryImplCopyWith(_$NutritionEntryImpl value,
          $Res Function(_$NutritionEntryImpl) then) =
      __$$NutritionEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      DateTime date,
      List<FoodEntry> foods,
      NutritionInfo totalNutrition,
      Map<MealType, NutritionInfo> mealBreakdown,
      NutritionGoals? dailyGoals,
      double waterIntakeMl,
      List<String> notes,
      List<String> symptoms,
      double exerciseCaloriesBurned,
      DateTime createdAt,
      DateTime? updatedAt});

  @override
  $NutritionInfoCopyWith<$Res> get totalNutrition;
}

/// @nodoc
class __$$NutritionEntryImplCopyWithImpl<$Res>
    extends _$NutritionEntryCopyWithImpl<$Res, _$NutritionEntryImpl>
    implements _$$NutritionEntryImplCopyWith<$Res> {
  __$$NutritionEntryImplCopyWithImpl(
      _$NutritionEntryImpl _value, $Res Function(_$NutritionEntryImpl) _then)
      : super(_value, _then);

  /// Create a copy of NutritionEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? date = null,
    Object? foods = null,
    Object? totalNutrition = null,
    Object? mealBreakdown = null,
    Object? dailyGoals = freezed,
    Object? waterIntakeMl = null,
    Object? notes = null,
    Object? symptoms = null,
    Object? exerciseCaloriesBurned = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_$NutritionEntryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      foods: null == foods
          ? _value._foods
          : foods // ignore: cast_nullable_to_non_nullable
              as List<FoodEntry>,
      totalNutrition: null == totalNutrition
          ? _value.totalNutrition
          : totalNutrition // ignore: cast_nullable_to_non_nullable
              as NutritionInfo,
      mealBreakdown: null == mealBreakdown
          ? _value._mealBreakdown
          : mealBreakdown // ignore: cast_nullable_to_non_nullable
              as Map<MealType, NutritionInfo>,
      dailyGoals: freezed == dailyGoals
          ? _value.dailyGoals
          : dailyGoals // ignore: cast_nullable_to_non_nullable
              as NutritionGoals?,
      waterIntakeMl: null == waterIntakeMl
          ? _value.waterIntakeMl
          : waterIntakeMl // ignore: cast_nullable_to_non_nullable
              as double,
      notes: null == notes
          ? _value._notes
          : notes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      symptoms: null == symptoms
          ? _value._symptoms
          : symptoms // ignore: cast_nullable_to_non_nullable
              as List<String>,
      exerciseCaloriesBurned: null == exerciseCaloriesBurned
          ? _value.exerciseCaloriesBurned
          : exerciseCaloriesBurned // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NutritionEntryImpl implements _NutritionEntry {
  const _$NutritionEntryImpl(
      {required this.id,
      required this.userId,
      required this.date,
      required final List<FoodEntry> foods,
      required this.totalNutrition,
      required final Map<MealType, NutritionInfo> mealBreakdown,
      this.dailyGoals,
      this.waterIntakeMl = 0.0,
      final List<String> notes = const [],
      final List<String> symptoms = const [],
      this.exerciseCaloriesBurned = 0.0,
      required this.createdAt,
      this.updatedAt})
      : _foods = foods,
        _mealBreakdown = mealBreakdown,
        _notes = notes,
        _symptoms = symptoms;

  factory _$NutritionEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$NutritionEntryImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final DateTime date;
  final List<FoodEntry> _foods;
  @override
  List<FoodEntry> get foods {
    if (_foods is EqualUnmodifiableListView) return _foods;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_foods);
  }

  @override
  final NutritionInfo totalNutrition;
  final Map<MealType, NutritionInfo> _mealBreakdown;
  @override
  Map<MealType, NutritionInfo> get mealBreakdown {
    if (_mealBreakdown is EqualUnmodifiableMapView) return _mealBreakdown;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_mealBreakdown);
  }

  @override
  final NutritionGoals? dailyGoals;
  @override
  @JsonKey()
  final double waterIntakeMl;
  final List<String> _notes;
  @override
  @JsonKey()
  List<String> get notes {
    if (_notes is EqualUnmodifiableListView) return _notes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_notes);
  }

  final List<String> _symptoms;
  @override
  @JsonKey()
  List<String> get symptoms {
    if (_symptoms is EqualUnmodifiableListView) return _symptoms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_symptoms);
  }

  @override
  @JsonKey()
  final double exerciseCaloriesBurned;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'NutritionEntry(id: $id, userId: $userId, date: $date, foods: $foods, totalNutrition: $totalNutrition, mealBreakdown: $mealBreakdown, dailyGoals: $dailyGoals, waterIntakeMl: $waterIntakeMl, notes: $notes, symptoms: $symptoms, exerciseCaloriesBurned: $exerciseCaloriesBurned, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NutritionEntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.date, date) || other.date == date) &&
            const DeepCollectionEquality().equals(other._foods, _foods) &&
            (identical(other.totalNutrition, totalNutrition) ||
                other.totalNutrition == totalNutrition) &&
            const DeepCollectionEquality()
                .equals(other._mealBreakdown, _mealBreakdown) &&
            const DeepCollectionEquality()
                .equals(other.dailyGoals, dailyGoals) &&
            (identical(other.waterIntakeMl, waterIntakeMl) ||
                other.waterIntakeMl == waterIntakeMl) &&
            const DeepCollectionEquality().equals(other._notes, _notes) &&
            const DeepCollectionEquality().equals(other._symptoms, _symptoms) &&
            (identical(other.exerciseCaloriesBurned, exerciseCaloriesBurned) ||
                other.exerciseCaloriesBurned == exerciseCaloriesBurned) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      date,
      const DeepCollectionEquality().hash(_foods),
      totalNutrition,
      const DeepCollectionEquality().hash(_mealBreakdown),
      const DeepCollectionEquality().hash(dailyGoals),
      waterIntakeMl,
      const DeepCollectionEquality().hash(_notes),
      const DeepCollectionEquality().hash(_symptoms),
      exerciseCaloriesBurned,
      createdAt,
      updatedAt);

  /// Create a copy of NutritionEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NutritionEntryImplCopyWith<_$NutritionEntryImpl> get copyWith =>
      __$$NutritionEntryImplCopyWithImpl<_$NutritionEntryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NutritionEntryImplToJson(
      this,
    );
  }
}

abstract class _NutritionEntry implements NutritionEntry {
  const factory _NutritionEntry(
      {required final String id,
      required final String userId,
      required final DateTime date,
      required final List<FoodEntry> foods,
      required final NutritionInfo totalNutrition,
      required final Map<MealType, NutritionInfo> mealBreakdown,
      final NutritionGoals? dailyGoals,
      final double waterIntakeMl,
      final List<String> notes,
      final List<String> symptoms,
      final double exerciseCaloriesBurned,
      required final DateTime createdAt,
      final DateTime? updatedAt}) = _$NutritionEntryImpl;

  factory _NutritionEntry.fromJson(Map<String, dynamic> json) =
      _$NutritionEntryImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  DateTime get date;
  @override
  List<FoodEntry> get foods;
  @override
  NutritionInfo get totalNutrition;
  @override
  Map<MealType, NutritionInfo> get mealBreakdown;
  @override
  NutritionGoals? get dailyGoals;
  @override
  double get waterIntakeMl;
  @override
  List<String> get notes;
  @override
  List<String> get symptoms;
  @override
  double get exerciseCaloriesBurned;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of NutritionEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NutritionEntryImplCopyWith<_$NutritionEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FoodEntry _$FoodEntryFromJson(Map<String, dynamic> json) {
  return _FoodEntry.fromJson(json);
}

/// @nodoc
mixin _$FoodEntry {
  String get id => throw _privateConstructorUsedError;
  String get foodName => throw _privateConstructorUsedError;
  double get quantity => throw _privateConstructorUsedError;
  String get unit => throw _privateConstructorUsedError;
  NutritionInfo get nutrition => throw _privateConstructorUsedError;
  MealType get mealType => throw _privateConstructorUsedError;
  DateTime get consumedAt => throw _privateConstructorUsedError;
  String? get recipeId => throw _privateConstructorUsedError;
  String? get recipeName => throw _privateConstructorUsedError;
  String? get brand => throw _privateConstructorUsedError;
  String? get barcode => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;

  /// Serializes this FoodEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FoodEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FoodEntryCopyWith<FoodEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FoodEntryCopyWith<$Res> {
  factory $FoodEntryCopyWith(FoodEntry value, $Res Function(FoodEntry) then) =
      _$FoodEntryCopyWithImpl<$Res, FoodEntry>;
  @useResult
  $Res call(
      {String id,
      String foodName,
      double quantity,
      String unit,
      NutritionInfo nutrition,
      MealType mealType,
      DateTime consumedAt,
      String? recipeId,
      String? recipeName,
      String? brand,
      String? barcode,
      List<String> tags,
      String? notes,
      String? imageUrl});

  $NutritionInfoCopyWith<$Res> get nutrition;
}

/// @nodoc
class _$FoodEntryCopyWithImpl<$Res, $Val extends FoodEntry>
    implements $FoodEntryCopyWith<$Res> {
  _$FoodEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FoodEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? foodName = null,
    Object? quantity = null,
    Object? unit = null,
    Object? nutrition = null,
    Object? mealType = freezed,
    Object? consumedAt = null,
    Object? recipeId = freezed,
    Object? recipeName = freezed,
    Object? brand = freezed,
    Object? barcode = freezed,
    Object? tags = null,
    Object? notes = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      foodName: null == foodName
          ? _value.foodName
          : foodName // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      nutrition: null == nutrition
          ? _value.nutrition
          : nutrition // ignore: cast_nullable_to_non_nullable
              as NutritionInfo,
      mealType: freezed == mealType
          ? _value.mealType
          : mealType // ignore: cast_nullable_to_non_nullable
              as MealType,
      consumedAt: null == consumedAt
          ? _value.consumedAt
          : consumedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      recipeId: freezed == recipeId
          ? _value.recipeId
          : recipeId // ignore: cast_nullable_to_non_nullable
              as String?,
      recipeName: freezed == recipeName
          ? _value.recipeName
          : recipeName // ignore: cast_nullable_to_non_nullable
              as String?,
      brand: freezed == brand
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String?,
      barcode: freezed == barcode
          ? _value.barcode
          : barcode // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of FoodEntry
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
abstract class _$$FoodEntryImplCopyWith<$Res>
    implements $FoodEntryCopyWith<$Res> {
  factory _$$FoodEntryImplCopyWith(
          _$FoodEntryImpl value, $Res Function(_$FoodEntryImpl) then) =
      __$$FoodEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String foodName,
      double quantity,
      String unit,
      NutritionInfo nutrition,
      MealType mealType,
      DateTime consumedAt,
      String? recipeId,
      String? recipeName,
      String? brand,
      String? barcode,
      List<String> tags,
      String? notes,
      String? imageUrl});

  @override
  $NutritionInfoCopyWith<$Res> get nutrition;
}

/// @nodoc
class __$$FoodEntryImplCopyWithImpl<$Res>
    extends _$FoodEntryCopyWithImpl<$Res, _$FoodEntryImpl>
    implements _$$FoodEntryImplCopyWith<$Res> {
  __$$FoodEntryImplCopyWithImpl(
      _$FoodEntryImpl _value, $Res Function(_$FoodEntryImpl) _then)
      : super(_value, _then);

  /// Create a copy of FoodEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? foodName = null,
    Object? quantity = null,
    Object? unit = null,
    Object? nutrition = null,
    Object? mealType = freezed,
    Object? consumedAt = null,
    Object? recipeId = freezed,
    Object? recipeName = freezed,
    Object? brand = freezed,
    Object? barcode = freezed,
    Object? tags = null,
    Object? notes = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(_$FoodEntryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      foodName: null == foodName
          ? _value.foodName
          : foodName // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      nutrition: null == nutrition
          ? _value.nutrition
          : nutrition // ignore: cast_nullable_to_non_nullable
              as NutritionInfo,
      mealType: freezed == mealType
          ? _value.mealType
          : mealType // ignore: cast_nullable_to_non_nullable
              as MealType,
      consumedAt: null == consumedAt
          ? _value.consumedAt
          : consumedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      recipeId: freezed == recipeId
          ? _value.recipeId
          : recipeId // ignore: cast_nullable_to_non_nullable
              as String?,
      recipeName: freezed == recipeName
          ? _value.recipeName
          : recipeName // ignore: cast_nullable_to_non_nullable
              as String?,
      brand: freezed == brand
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String?,
      barcode: freezed == barcode
          ? _value.barcode
          : barcode // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FoodEntryImpl implements _FoodEntry {
  const _$FoodEntryImpl(
      {required this.id,
      required this.foodName,
      required this.quantity,
      required this.unit,
      required this.nutrition,
      required this.mealType,
      required this.consumedAt,
      this.recipeId,
      this.recipeName,
      this.brand,
      this.barcode,
      final List<String> tags = const [],
      this.notes,
      this.imageUrl})
      : _tags = tags;

  factory _$FoodEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$FoodEntryImplFromJson(json);

  @override
  final String id;
  @override
  final String foodName;
  @override
  final double quantity;
  @override
  final String unit;
  @override
  final NutritionInfo nutrition;
  @override
  final MealType mealType;
  @override
  final DateTime consumedAt;
  @override
  final String? recipeId;
  @override
  final String? recipeName;
  @override
  final String? brand;
  @override
  final String? barcode;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final String? notes;
  @override
  final String? imageUrl;

  @override
  String toString() {
    return 'FoodEntry(id: $id, foodName: $foodName, quantity: $quantity, unit: $unit, nutrition: $nutrition, mealType: $mealType, consumedAt: $consumedAt, recipeId: $recipeId, recipeName: $recipeName, brand: $brand, barcode: $barcode, tags: $tags, notes: $notes, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FoodEntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.foodName, foodName) ||
                other.foodName == foodName) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.nutrition, nutrition) ||
                other.nutrition == nutrition) &&
            const DeepCollectionEquality().equals(other.mealType, mealType) &&
            (identical(other.consumedAt, consumedAt) ||
                other.consumedAt == consumedAt) &&
            (identical(other.recipeId, recipeId) ||
                other.recipeId == recipeId) &&
            (identical(other.recipeName, recipeName) ||
                other.recipeName == recipeName) &&
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.barcode, barcode) || other.barcode == barcode) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      foodName,
      quantity,
      unit,
      nutrition,
      const DeepCollectionEquality().hash(mealType),
      consumedAt,
      recipeId,
      recipeName,
      brand,
      barcode,
      const DeepCollectionEquality().hash(_tags),
      notes,
      imageUrl);

  /// Create a copy of FoodEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FoodEntryImplCopyWith<_$FoodEntryImpl> get copyWith =>
      __$$FoodEntryImplCopyWithImpl<_$FoodEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FoodEntryImplToJson(
      this,
    );
  }
}

abstract class _FoodEntry implements FoodEntry {
  const factory _FoodEntry(
      {required final String id,
      required final String foodName,
      required final double quantity,
      required final String unit,
      required final NutritionInfo nutrition,
      required final MealType mealType,
      required final DateTime consumedAt,
      final String? recipeId,
      final String? recipeName,
      final String? brand,
      final String? barcode,
      final List<String> tags,
      final String? notes,
      final String? imageUrl}) = _$FoodEntryImpl;

  factory _FoodEntry.fromJson(Map<String, dynamic> json) =
      _$FoodEntryImpl.fromJson;

  @override
  String get id;
  @override
  String get foodName;
  @override
  double get quantity;
  @override
  String get unit;
  @override
  NutritionInfo get nutrition;
  @override
  MealType get mealType;
  @override
  DateTime get consumedAt;
  @override
  String? get recipeId;
  @override
  String? get recipeName;
  @override
  String? get brand;
  @override
  String? get barcode;
  @override
  List<String> get tags;
  @override
  String? get notes;
  @override
  String? get imageUrl;

  /// Create a copy of FoodEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FoodEntryImplCopyWith<_$FoodEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NutritionGoal _$NutritionGoalFromJson(Map<String, dynamic> json) {
  return _NutritionGoal.fromJson(json);
}

/// @nodoc
mixin _$NutritionGoal {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  NutritionGoals get targets => throw _privateConstructorUsedError;
  GoalType get goalType => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  List<DietaryRestriction> get dietaryRestrictions =>
      throw _privateConstructorUsedError;
  List<String> get allergies => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  double get targetWeight => throw _privateConstructorUsedError;
  double get currentWeight => throw _privateConstructorUsedError;
  ActivityLevel? get activityLevel => throw _privateConstructorUsedError;
  Gender? get gender => throw _privateConstructorUsedError;
  int? get age => throw _privateConstructorUsedError;
  double get heightCm => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this NutritionGoal to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NutritionGoal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NutritionGoalCopyWith<NutritionGoal> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NutritionGoalCopyWith<$Res> {
  factory $NutritionGoalCopyWith(
          NutritionGoal value, $Res Function(NutritionGoal) then) =
      _$NutritionGoalCopyWithImpl<$Res, NutritionGoal>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String name,
      NutritionGoals targets,
      GoalType goalType,
      DateTime startDate,
      DateTime? endDate,
      bool isActive,
      List<DietaryRestriction> dietaryRestrictions,
      List<String> allergies,
      String? description,
      double targetWeight,
      double currentWeight,
      ActivityLevel? activityLevel,
      Gender? gender,
      int? age,
      double heightCm,
      DateTime createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$NutritionGoalCopyWithImpl<$Res, $Val extends NutritionGoal>
    implements $NutritionGoalCopyWith<$Res> {
  _$NutritionGoalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NutritionGoal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? name = null,
    Object? targets = freezed,
    Object? goalType = null,
    Object? startDate = null,
    Object? endDate = freezed,
    Object? isActive = null,
    Object? dietaryRestrictions = null,
    Object? allergies = null,
    Object? description = freezed,
    Object? targetWeight = null,
    Object? currentWeight = null,
    Object? activityLevel = freezed,
    Object? gender = freezed,
    Object? age = freezed,
    Object? heightCm = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
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
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      targets: freezed == targets
          ? _value.targets
          : targets // ignore: cast_nullable_to_non_nullable
              as NutritionGoals,
      goalType: null == goalType
          ? _value.goalType
          : goalType // ignore: cast_nullable_to_non_nullable
              as GoalType,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      dietaryRestrictions: null == dietaryRestrictions
          ? _value.dietaryRestrictions
          : dietaryRestrictions // ignore: cast_nullable_to_non_nullable
              as List<DietaryRestriction>,
      allergies: null == allergies
          ? _value.allergies
          : allergies // ignore: cast_nullable_to_non_nullable
              as List<String>,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      targetWeight: null == targetWeight
          ? _value.targetWeight
          : targetWeight // ignore: cast_nullable_to_non_nullable
              as double,
      currentWeight: null == currentWeight
          ? _value.currentWeight
          : currentWeight // ignore: cast_nullable_to_non_nullable
              as double,
      activityLevel: freezed == activityLevel
          ? _value.activityLevel
          : activityLevel // ignore: cast_nullable_to_non_nullable
              as ActivityLevel?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as Gender?,
      age: freezed == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int?,
      heightCm: null == heightCm
          ? _value.heightCm
          : heightCm // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NutritionGoalImplCopyWith<$Res>
    implements $NutritionGoalCopyWith<$Res> {
  factory _$$NutritionGoalImplCopyWith(
          _$NutritionGoalImpl value, $Res Function(_$NutritionGoalImpl) then) =
      __$$NutritionGoalImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String name,
      NutritionGoals targets,
      GoalType goalType,
      DateTime startDate,
      DateTime? endDate,
      bool isActive,
      List<DietaryRestriction> dietaryRestrictions,
      List<String> allergies,
      String? description,
      double targetWeight,
      double currentWeight,
      ActivityLevel? activityLevel,
      Gender? gender,
      int? age,
      double heightCm,
      DateTime createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$NutritionGoalImplCopyWithImpl<$Res>
    extends _$NutritionGoalCopyWithImpl<$Res, _$NutritionGoalImpl>
    implements _$$NutritionGoalImplCopyWith<$Res> {
  __$$NutritionGoalImplCopyWithImpl(
      _$NutritionGoalImpl _value, $Res Function(_$NutritionGoalImpl) _then)
      : super(_value, _then);

  /// Create a copy of NutritionGoal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? name = null,
    Object? targets = freezed,
    Object? goalType = null,
    Object? startDate = null,
    Object? endDate = freezed,
    Object? isActive = null,
    Object? dietaryRestrictions = null,
    Object? allergies = null,
    Object? description = freezed,
    Object? targetWeight = null,
    Object? currentWeight = null,
    Object? activityLevel = freezed,
    Object? gender = freezed,
    Object? age = freezed,
    Object? heightCm = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_$NutritionGoalImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      targets: freezed == targets
          ? _value.targets
          : targets // ignore: cast_nullable_to_non_nullable
              as NutritionGoals,
      goalType: null == goalType
          ? _value.goalType
          : goalType // ignore: cast_nullable_to_non_nullable
              as GoalType,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      dietaryRestrictions: null == dietaryRestrictions
          ? _value._dietaryRestrictions
          : dietaryRestrictions // ignore: cast_nullable_to_non_nullable
              as List<DietaryRestriction>,
      allergies: null == allergies
          ? _value._allergies
          : allergies // ignore: cast_nullable_to_non_nullable
              as List<String>,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      targetWeight: null == targetWeight
          ? _value.targetWeight
          : targetWeight // ignore: cast_nullable_to_non_nullable
              as double,
      currentWeight: null == currentWeight
          ? _value.currentWeight
          : currentWeight // ignore: cast_nullable_to_non_nullable
              as double,
      activityLevel: freezed == activityLevel
          ? _value.activityLevel
          : activityLevel // ignore: cast_nullable_to_non_nullable
              as ActivityLevel?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as Gender?,
      age: freezed == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int?,
      heightCm: null == heightCm
          ? _value.heightCm
          : heightCm // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NutritionGoalImpl implements _NutritionGoal {
  const _$NutritionGoalImpl(
      {required this.id,
      required this.userId,
      required this.name,
      required this.targets,
      required this.goalType,
      required this.startDate,
      this.endDate,
      this.isActive = true,
      final List<DietaryRestriction> dietaryRestrictions = const [],
      final List<String> allergies = const [],
      this.description,
      this.targetWeight = 0.0,
      this.currentWeight = 0.0,
      this.activityLevel,
      this.gender,
      this.age,
      this.heightCm = 170.0,
      required this.createdAt,
      this.updatedAt})
      : _dietaryRestrictions = dietaryRestrictions,
        _allergies = allergies;

  factory _$NutritionGoalImpl.fromJson(Map<String, dynamic> json) =>
      _$$NutritionGoalImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String name;
  @override
  final NutritionGoals targets;
  @override
  final GoalType goalType;
  @override
  final DateTime startDate;
  @override
  final DateTime? endDate;
  @override
  @JsonKey()
  final bool isActive;
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
  final String? description;
  @override
  @JsonKey()
  final double targetWeight;
  @override
  @JsonKey()
  final double currentWeight;
  @override
  final ActivityLevel? activityLevel;
  @override
  final Gender? gender;
  @override
  final int? age;
  @override
  @JsonKey()
  final double heightCm;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'NutritionGoal(id: $id, userId: $userId, name: $name, targets: $targets, goalType: $goalType, startDate: $startDate, endDate: $endDate, isActive: $isActive, dietaryRestrictions: $dietaryRestrictions, allergies: $allergies, description: $description, targetWeight: $targetWeight, currentWeight: $currentWeight, activityLevel: $activityLevel, gender: $gender, age: $age, heightCm: $heightCm, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NutritionGoalImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other.targets, targets) &&
            (identical(other.goalType, goalType) ||
                other.goalType == goalType) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            const DeepCollectionEquality()
                .equals(other._dietaryRestrictions, _dietaryRestrictions) &&
            const DeepCollectionEquality()
                .equals(other._allergies, _allergies) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.targetWeight, targetWeight) ||
                other.targetWeight == targetWeight) &&
            (identical(other.currentWeight, currentWeight) ||
                other.currentWeight == currentWeight) &&
            (identical(other.activityLevel, activityLevel) ||
                other.activityLevel == activityLevel) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.heightCm, heightCm) ||
                other.heightCm == heightCm) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        userId,
        name,
        const DeepCollectionEquality().hash(targets),
        goalType,
        startDate,
        endDate,
        isActive,
        const DeepCollectionEquality().hash(_dietaryRestrictions),
        const DeepCollectionEquality().hash(_allergies),
        description,
        targetWeight,
        currentWeight,
        activityLevel,
        gender,
        age,
        heightCm,
        createdAt,
        updatedAt
      ]);

  /// Create a copy of NutritionGoal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NutritionGoalImplCopyWith<_$NutritionGoalImpl> get copyWith =>
      __$$NutritionGoalImplCopyWithImpl<_$NutritionGoalImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NutritionGoalImplToJson(
      this,
    );
  }
}

abstract class _NutritionGoal implements NutritionGoal {
  const factory _NutritionGoal(
      {required final String id,
      required final String userId,
      required final String name,
      required final NutritionGoals targets,
      required final GoalType goalType,
      required final DateTime startDate,
      final DateTime? endDate,
      final bool isActive,
      final List<DietaryRestriction> dietaryRestrictions,
      final List<String> allergies,
      final String? description,
      final double targetWeight,
      final double currentWeight,
      final ActivityLevel? activityLevel,
      final Gender? gender,
      final int? age,
      final double heightCm,
      required final DateTime createdAt,
      final DateTime? updatedAt}) = _$NutritionGoalImpl;

  factory _NutritionGoal.fromJson(Map<String, dynamic> json) =
      _$NutritionGoalImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get name;
  @override
  NutritionGoals get targets;
  @override
  GoalType get goalType;
  @override
  DateTime get startDate;
  @override
  DateTime? get endDate;
  @override
  bool get isActive;
  @override
  List<DietaryRestriction> get dietaryRestrictions;
  @override
  List<String> get allergies;
  @override
  String? get description;
  @override
  double get targetWeight;
  @override
  double get currentWeight;
  @override
  ActivityLevel? get activityLevel;
  @override
  Gender? get gender;
  @override
  int? get age;
  @override
  double get heightCm;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of NutritionGoal
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NutritionGoalImplCopyWith<_$NutritionGoalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NutritionProgress _$NutritionProgressFromJson(Map<String, dynamic> json) {
  return _NutritionProgress.fromJson(json);
}

/// @nodoc
mixin _$NutritionProgress {
  String get userId => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  NutritionGoals get goals => throw _privateConstructorUsedError;
  NutritionInfo get consumed => throw _privateConstructorUsedError;
  Map<String, double> get percentageAchieved =>
      throw _privateConstructorUsedError;
  List<NutritionDeficiency> get deficiencies =>
      throw _privateConstructorUsedError;
  List<NutritionExcess> get excesses => throw _privateConstructorUsedError;
  double get overallScore => throw _privateConstructorUsedError;
  List<String> get recommendations => throw _privateConstructorUsedError;
  double get waterIntakeGoal => throw _privateConstructorUsedError;
  double get waterIntakeActual => throw _privateConstructorUsedError;
  double get exerciseCaloriesGoal => throw _privateConstructorUsedError;
  double get exerciseCaloriesActual => throw _privateConstructorUsedError;

  /// Serializes this NutritionProgress to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NutritionProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NutritionProgressCopyWith<NutritionProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NutritionProgressCopyWith<$Res> {
  factory $NutritionProgressCopyWith(
          NutritionProgress value, $Res Function(NutritionProgress) then) =
      _$NutritionProgressCopyWithImpl<$Res, NutritionProgress>;
  @useResult
  $Res call(
      {String userId,
      DateTime date,
      NutritionGoals goals,
      NutritionInfo consumed,
      Map<String, double> percentageAchieved,
      List<NutritionDeficiency> deficiencies,
      List<NutritionExcess> excesses,
      double overallScore,
      List<String> recommendations,
      double waterIntakeGoal,
      double waterIntakeActual,
      double exerciseCaloriesGoal,
      double exerciseCaloriesActual});

  $NutritionInfoCopyWith<$Res> get consumed;
}

/// @nodoc
class _$NutritionProgressCopyWithImpl<$Res, $Val extends NutritionProgress>
    implements $NutritionProgressCopyWith<$Res> {
  _$NutritionProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NutritionProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? date = null,
    Object? goals = freezed,
    Object? consumed = null,
    Object? percentageAchieved = null,
    Object? deficiencies = null,
    Object? excesses = null,
    Object? overallScore = null,
    Object? recommendations = null,
    Object? waterIntakeGoal = null,
    Object? waterIntakeActual = null,
    Object? exerciseCaloriesGoal = null,
    Object? exerciseCaloriesActual = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      goals: freezed == goals
          ? _value.goals
          : goals // ignore: cast_nullable_to_non_nullable
              as NutritionGoals,
      consumed: null == consumed
          ? _value.consumed
          : consumed // ignore: cast_nullable_to_non_nullable
              as NutritionInfo,
      percentageAchieved: null == percentageAchieved
          ? _value.percentageAchieved
          : percentageAchieved // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      deficiencies: null == deficiencies
          ? _value.deficiencies
          : deficiencies // ignore: cast_nullable_to_non_nullable
              as List<NutritionDeficiency>,
      excesses: null == excesses
          ? _value.excesses
          : excesses // ignore: cast_nullable_to_non_nullable
              as List<NutritionExcess>,
      overallScore: null == overallScore
          ? _value.overallScore
          : overallScore // ignore: cast_nullable_to_non_nullable
              as double,
      recommendations: null == recommendations
          ? _value.recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<String>,
      waterIntakeGoal: null == waterIntakeGoal
          ? _value.waterIntakeGoal
          : waterIntakeGoal // ignore: cast_nullable_to_non_nullable
              as double,
      waterIntakeActual: null == waterIntakeActual
          ? _value.waterIntakeActual
          : waterIntakeActual // ignore: cast_nullable_to_non_nullable
              as double,
      exerciseCaloriesGoal: null == exerciseCaloriesGoal
          ? _value.exerciseCaloriesGoal
          : exerciseCaloriesGoal // ignore: cast_nullable_to_non_nullable
              as double,
      exerciseCaloriesActual: null == exerciseCaloriesActual
          ? _value.exerciseCaloriesActual
          : exerciseCaloriesActual // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }

  /// Create a copy of NutritionProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NutritionInfoCopyWith<$Res> get consumed {
    return $NutritionInfoCopyWith<$Res>(_value.consumed, (value) {
      return _then(_value.copyWith(consumed: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NutritionProgressImplCopyWith<$Res>
    implements $NutritionProgressCopyWith<$Res> {
  factory _$$NutritionProgressImplCopyWith(_$NutritionProgressImpl value,
          $Res Function(_$NutritionProgressImpl) then) =
      __$$NutritionProgressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      DateTime date,
      NutritionGoals goals,
      NutritionInfo consumed,
      Map<String, double> percentageAchieved,
      List<NutritionDeficiency> deficiencies,
      List<NutritionExcess> excesses,
      double overallScore,
      List<String> recommendations,
      double waterIntakeGoal,
      double waterIntakeActual,
      double exerciseCaloriesGoal,
      double exerciseCaloriesActual});

  @override
  $NutritionInfoCopyWith<$Res> get consumed;
}

/// @nodoc
class __$$NutritionProgressImplCopyWithImpl<$Res>
    extends _$NutritionProgressCopyWithImpl<$Res, _$NutritionProgressImpl>
    implements _$$NutritionProgressImplCopyWith<$Res> {
  __$$NutritionProgressImplCopyWithImpl(_$NutritionProgressImpl _value,
      $Res Function(_$NutritionProgressImpl) _then)
      : super(_value, _then);

  /// Create a copy of NutritionProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? date = null,
    Object? goals = freezed,
    Object? consumed = null,
    Object? percentageAchieved = null,
    Object? deficiencies = null,
    Object? excesses = null,
    Object? overallScore = null,
    Object? recommendations = null,
    Object? waterIntakeGoal = null,
    Object? waterIntakeActual = null,
    Object? exerciseCaloriesGoal = null,
    Object? exerciseCaloriesActual = null,
  }) {
    return _then(_$NutritionProgressImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      goals: freezed == goals
          ? _value.goals
          : goals // ignore: cast_nullable_to_non_nullable
              as NutritionGoals,
      consumed: null == consumed
          ? _value.consumed
          : consumed // ignore: cast_nullable_to_non_nullable
              as NutritionInfo,
      percentageAchieved: null == percentageAchieved
          ? _value._percentageAchieved
          : percentageAchieved // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      deficiencies: null == deficiencies
          ? _value._deficiencies
          : deficiencies // ignore: cast_nullable_to_non_nullable
              as List<NutritionDeficiency>,
      excesses: null == excesses
          ? _value._excesses
          : excesses // ignore: cast_nullable_to_non_nullable
              as List<NutritionExcess>,
      overallScore: null == overallScore
          ? _value.overallScore
          : overallScore // ignore: cast_nullable_to_non_nullable
              as double,
      recommendations: null == recommendations
          ? _value._recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<String>,
      waterIntakeGoal: null == waterIntakeGoal
          ? _value.waterIntakeGoal
          : waterIntakeGoal // ignore: cast_nullable_to_non_nullable
              as double,
      waterIntakeActual: null == waterIntakeActual
          ? _value.waterIntakeActual
          : waterIntakeActual // ignore: cast_nullable_to_non_nullable
              as double,
      exerciseCaloriesGoal: null == exerciseCaloriesGoal
          ? _value.exerciseCaloriesGoal
          : exerciseCaloriesGoal // ignore: cast_nullable_to_non_nullable
              as double,
      exerciseCaloriesActual: null == exerciseCaloriesActual
          ? _value.exerciseCaloriesActual
          : exerciseCaloriesActual // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NutritionProgressImpl implements _NutritionProgress {
  const _$NutritionProgressImpl(
      {required this.userId,
      required this.date,
      required this.goals,
      required this.consumed,
      required final Map<String, double> percentageAchieved,
      required final List<NutritionDeficiency> deficiencies,
      required final List<NutritionExcess> excesses,
      required this.overallScore,
      final List<String> recommendations = const [],
      this.waterIntakeGoal = 0.0,
      this.waterIntakeActual = 0.0,
      this.exerciseCaloriesGoal = 0.0,
      this.exerciseCaloriesActual = 0.0})
      : _percentageAchieved = percentageAchieved,
        _deficiencies = deficiencies,
        _excesses = excesses,
        _recommendations = recommendations;

  factory _$NutritionProgressImpl.fromJson(Map<String, dynamic> json) =>
      _$$NutritionProgressImplFromJson(json);

  @override
  final String userId;
  @override
  final DateTime date;
  @override
  final NutritionGoals goals;
  @override
  final NutritionInfo consumed;
  final Map<String, double> _percentageAchieved;
  @override
  Map<String, double> get percentageAchieved {
    if (_percentageAchieved is EqualUnmodifiableMapView)
      return _percentageAchieved;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_percentageAchieved);
  }

  final List<NutritionDeficiency> _deficiencies;
  @override
  List<NutritionDeficiency> get deficiencies {
    if (_deficiencies is EqualUnmodifiableListView) return _deficiencies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_deficiencies);
  }

  final List<NutritionExcess> _excesses;
  @override
  List<NutritionExcess> get excesses {
    if (_excesses is EqualUnmodifiableListView) return _excesses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_excesses);
  }

  @override
  final double overallScore;
  final List<String> _recommendations;
  @override
  @JsonKey()
  List<String> get recommendations {
    if (_recommendations is EqualUnmodifiableListView) return _recommendations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recommendations);
  }

  @override
  @JsonKey()
  final double waterIntakeGoal;
  @override
  @JsonKey()
  final double waterIntakeActual;
  @override
  @JsonKey()
  final double exerciseCaloriesGoal;
  @override
  @JsonKey()
  final double exerciseCaloriesActual;

  @override
  String toString() {
    return 'NutritionProgress(userId: $userId, date: $date, goals: $goals, consumed: $consumed, percentageAchieved: $percentageAchieved, deficiencies: $deficiencies, excesses: $excesses, overallScore: $overallScore, recommendations: $recommendations, waterIntakeGoal: $waterIntakeGoal, waterIntakeActual: $waterIntakeActual, exerciseCaloriesGoal: $exerciseCaloriesGoal, exerciseCaloriesActual: $exerciseCaloriesActual)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NutritionProgressImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.date, date) || other.date == date) &&
            const DeepCollectionEquality().equals(other.goals, goals) &&
            (identical(other.consumed, consumed) ||
                other.consumed == consumed) &&
            const DeepCollectionEquality()
                .equals(other._percentageAchieved, _percentageAchieved) &&
            const DeepCollectionEquality()
                .equals(other._deficiencies, _deficiencies) &&
            const DeepCollectionEquality().equals(other._excesses, _excesses) &&
            (identical(other.overallScore, overallScore) ||
                other.overallScore == overallScore) &&
            const DeepCollectionEquality()
                .equals(other._recommendations, _recommendations) &&
            (identical(other.waterIntakeGoal, waterIntakeGoal) ||
                other.waterIntakeGoal == waterIntakeGoal) &&
            (identical(other.waterIntakeActual, waterIntakeActual) ||
                other.waterIntakeActual == waterIntakeActual) &&
            (identical(other.exerciseCaloriesGoal, exerciseCaloriesGoal) ||
                other.exerciseCaloriesGoal == exerciseCaloriesGoal) &&
            (identical(other.exerciseCaloriesActual, exerciseCaloriesActual) ||
                other.exerciseCaloriesActual == exerciseCaloriesActual));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      date,
      const DeepCollectionEquality().hash(goals),
      consumed,
      const DeepCollectionEquality().hash(_percentageAchieved),
      const DeepCollectionEquality().hash(_deficiencies),
      const DeepCollectionEquality().hash(_excesses),
      overallScore,
      const DeepCollectionEquality().hash(_recommendations),
      waterIntakeGoal,
      waterIntakeActual,
      exerciseCaloriesGoal,
      exerciseCaloriesActual);

  /// Create a copy of NutritionProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NutritionProgressImplCopyWith<_$NutritionProgressImpl> get copyWith =>
      __$$NutritionProgressImplCopyWithImpl<_$NutritionProgressImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NutritionProgressImplToJson(
      this,
    );
  }
}

abstract class _NutritionProgress implements NutritionProgress {
  const factory _NutritionProgress(
      {required final String userId,
      required final DateTime date,
      required final NutritionGoals goals,
      required final NutritionInfo consumed,
      required final Map<String, double> percentageAchieved,
      required final List<NutritionDeficiency> deficiencies,
      required final List<NutritionExcess> excesses,
      required final double overallScore,
      final List<String> recommendations,
      final double waterIntakeGoal,
      final double waterIntakeActual,
      final double exerciseCaloriesGoal,
      final double exerciseCaloriesActual}) = _$NutritionProgressImpl;

  factory _NutritionProgress.fromJson(Map<String, dynamic> json) =
      _$NutritionProgressImpl.fromJson;

  @override
  String get userId;
  @override
  DateTime get date;
  @override
  NutritionGoals get goals;
  @override
  NutritionInfo get consumed;
  @override
  Map<String, double> get percentageAchieved;
  @override
  List<NutritionDeficiency> get deficiencies;
  @override
  List<NutritionExcess> get excesses;
  @override
  double get overallScore;
  @override
  List<String> get recommendations;
  @override
  double get waterIntakeGoal;
  @override
  double get waterIntakeActual;
  @override
  double get exerciseCaloriesGoal;
  @override
  double get exerciseCaloriesActual;

  /// Create a copy of NutritionProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NutritionProgressImplCopyWith<_$NutritionProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WeeklyNutritionSummary _$WeeklyNutritionSummaryFromJson(
    Map<String, dynamic> json) {
  return _WeeklyNutritionSummary.fromJson(json);
}

/// @nodoc
mixin _$WeeklyNutritionSummary {
  String get userId => throw _privateConstructorUsedError;
  DateTime get weekStartDate => throw _privateConstructorUsedError;
  List<NutritionEntry> get dailyEntries => throw _privateConstructorUsedError;
  NutritionInfo get averageDaily => throw _privateConstructorUsedError;
  NutritionInfo get weeklyTotal => throw _privateConstructorUsedError;
  Map<String, double> get goalAchievementRates =>
      throw _privateConstructorUsedError;
  List<NutritionTrend> get trends => throw _privateConstructorUsedError;
  double get averageWaterIntake => throw _privateConstructorUsedError;
  double get totalExerciseCalories => throw _privateConstructorUsedError;
  double get weightChange => throw _privateConstructorUsedError;
  double get overallScore => throw _privateConstructorUsedError;

  /// Serializes this WeeklyNutritionSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WeeklyNutritionSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WeeklyNutritionSummaryCopyWith<WeeklyNutritionSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeeklyNutritionSummaryCopyWith<$Res> {
  factory $WeeklyNutritionSummaryCopyWith(WeeklyNutritionSummary value,
          $Res Function(WeeklyNutritionSummary) then) =
      _$WeeklyNutritionSummaryCopyWithImpl<$Res, WeeklyNutritionSummary>;
  @useResult
  $Res call(
      {String userId,
      DateTime weekStartDate,
      List<NutritionEntry> dailyEntries,
      NutritionInfo averageDaily,
      NutritionInfo weeklyTotal,
      Map<String, double> goalAchievementRates,
      List<NutritionTrend> trends,
      double averageWaterIntake,
      double totalExerciseCalories,
      double weightChange,
      double overallScore});

  $NutritionInfoCopyWith<$Res> get averageDaily;
  $NutritionInfoCopyWith<$Res> get weeklyTotal;
}

/// @nodoc
class _$WeeklyNutritionSummaryCopyWithImpl<$Res,
        $Val extends WeeklyNutritionSummary>
    implements $WeeklyNutritionSummaryCopyWith<$Res> {
  _$WeeklyNutritionSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WeeklyNutritionSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? weekStartDate = null,
    Object? dailyEntries = null,
    Object? averageDaily = null,
    Object? weeklyTotal = null,
    Object? goalAchievementRates = null,
    Object? trends = null,
    Object? averageWaterIntake = null,
    Object? totalExerciseCalories = null,
    Object? weightChange = null,
    Object? overallScore = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      weekStartDate: null == weekStartDate
          ? _value.weekStartDate
          : weekStartDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dailyEntries: null == dailyEntries
          ? _value.dailyEntries
          : dailyEntries // ignore: cast_nullable_to_non_nullable
              as List<NutritionEntry>,
      averageDaily: null == averageDaily
          ? _value.averageDaily
          : averageDaily // ignore: cast_nullable_to_non_nullable
              as NutritionInfo,
      weeklyTotal: null == weeklyTotal
          ? _value.weeklyTotal
          : weeklyTotal // ignore: cast_nullable_to_non_nullable
              as NutritionInfo,
      goalAchievementRates: null == goalAchievementRates
          ? _value.goalAchievementRates
          : goalAchievementRates // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      trends: null == trends
          ? _value.trends
          : trends // ignore: cast_nullable_to_non_nullable
              as List<NutritionTrend>,
      averageWaterIntake: null == averageWaterIntake
          ? _value.averageWaterIntake
          : averageWaterIntake // ignore: cast_nullable_to_non_nullable
              as double,
      totalExerciseCalories: null == totalExerciseCalories
          ? _value.totalExerciseCalories
          : totalExerciseCalories // ignore: cast_nullable_to_non_nullable
              as double,
      weightChange: null == weightChange
          ? _value.weightChange
          : weightChange // ignore: cast_nullable_to_non_nullable
              as double,
      overallScore: null == overallScore
          ? _value.overallScore
          : overallScore // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }

  /// Create a copy of WeeklyNutritionSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NutritionInfoCopyWith<$Res> get averageDaily {
    return $NutritionInfoCopyWith<$Res>(_value.averageDaily, (value) {
      return _then(_value.copyWith(averageDaily: value) as $Val);
    });
  }

  /// Create a copy of WeeklyNutritionSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NutritionInfoCopyWith<$Res> get weeklyTotal {
    return $NutritionInfoCopyWith<$Res>(_value.weeklyTotal, (value) {
      return _then(_value.copyWith(weeklyTotal: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WeeklyNutritionSummaryImplCopyWith<$Res>
    implements $WeeklyNutritionSummaryCopyWith<$Res> {
  factory _$$WeeklyNutritionSummaryImplCopyWith(
          _$WeeklyNutritionSummaryImpl value,
          $Res Function(_$WeeklyNutritionSummaryImpl) then) =
      __$$WeeklyNutritionSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      DateTime weekStartDate,
      List<NutritionEntry> dailyEntries,
      NutritionInfo averageDaily,
      NutritionInfo weeklyTotal,
      Map<String, double> goalAchievementRates,
      List<NutritionTrend> trends,
      double averageWaterIntake,
      double totalExerciseCalories,
      double weightChange,
      double overallScore});

  @override
  $NutritionInfoCopyWith<$Res> get averageDaily;
  @override
  $NutritionInfoCopyWith<$Res> get weeklyTotal;
}

/// @nodoc
class __$$WeeklyNutritionSummaryImplCopyWithImpl<$Res>
    extends _$WeeklyNutritionSummaryCopyWithImpl<$Res,
        _$WeeklyNutritionSummaryImpl>
    implements _$$WeeklyNutritionSummaryImplCopyWith<$Res> {
  __$$WeeklyNutritionSummaryImplCopyWithImpl(
      _$WeeklyNutritionSummaryImpl _value,
      $Res Function(_$WeeklyNutritionSummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of WeeklyNutritionSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? weekStartDate = null,
    Object? dailyEntries = null,
    Object? averageDaily = null,
    Object? weeklyTotal = null,
    Object? goalAchievementRates = null,
    Object? trends = null,
    Object? averageWaterIntake = null,
    Object? totalExerciseCalories = null,
    Object? weightChange = null,
    Object? overallScore = null,
  }) {
    return _then(_$WeeklyNutritionSummaryImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      weekStartDate: null == weekStartDate
          ? _value.weekStartDate
          : weekStartDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dailyEntries: null == dailyEntries
          ? _value._dailyEntries
          : dailyEntries // ignore: cast_nullable_to_non_nullable
              as List<NutritionEntry>,
      averageDaily: null == averageDaily
          ? _value.averageDaily
          : averageDaily // ignore: cast_nullable_to_non_nullable
              as NutritionInfo,
      weeklyTotal: null == weeklyTotal
          ? _value.weeklyTotal
          : weeklyTotal // ignore: cast_nullable_to_non_nullable
              as NutritionInfo,
      goalAchievementRates: null == goalAchievementRates
          ? _value._goalAchievementRates
          : goalAchievementRates // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      trends: null == trends
          ? _value._trends
          : trends // ignore: cast_nullable_to_non_nullable
              as List<NutritionTrend>,
      averageWaterIntake: null == averageWaterIntake
          ? _value.averageWaterIntake
          : averageWaterIntake // ignore: cast_nullable_to_non_nullable
              as double,
      totalExerciseCalories: null == totalExerciseCalories
          ? _value.totalExerciseCalories
          : totalExerciseCalories // ignore: cast_nullable_to_non_nullable
              as double,
      weightChange: null == weightChange
          ? _value.weightChange
          : weightChange // ignore: cast_nullable_to_non_nullable
              as double,
      overallScore: null == overallScore
          ? _value.overallScore
          : overallScore // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WeeklyNutritionSummaryImpl implements _WeeklyNutritionSummary {
  const _$WeeklyNutritionSummaryImpl(
      {required this.userId,
      required this.weekStartDate,
      required final List<NutritionEntry> dailyEntries,
      required this.averageDaily,
      required this.weeklyTotal,
      required final Map<String, double> goalAchievementRates,
      required final List<NutritionTrend> trends,
      this.averageWaterIntake = 0.0,
      this.totalExerciseCalories = 0.0,
      this.weightChange = 0.0,
      required this.overallScore})
      : _dailyEntries = dailyEntries,
        _goalAchievementRates = goalAchievementRates,
        _trends = trends;

  factory _$WeeklyNutritionSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$WeeklyNutritionSummaryImplFromJson(json);

  @override
  final String userId;
  @override
  final DateTime weekStartDate;
  final List<NutritionEntry> _dailyEntries;
  @override
  List<NutritionEntry> get dailyEntries {
    if (_dailyEntries is EqualUnmodifiableListView) return _dailyEntries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dailyEntries);
  }

  @override
  final NutritionInfo averageDaily;
  @override
  final NutritionInfo weeklyTotal;
  final Map<String, double> _goalAchievementRates;
  @override
  Map<String, double> get goalAchievementRates {
    if (_goalAchievementRates is EqualUnmodifiableMapView)
      return _goalAchievementRates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_goalAchievementRates);
  }

  final List<NutritionTrend> _trends;
  @override
  List<NutritionTrend> get trends {
    if (_trends is EqualUnmodifiableListView) return _trends;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_trends);
  }

  @override
  @JsonKey()
  final double averageWaterIntake;
  @override
  @JsonKey()
  final double totalExerciseCalories;
  @override
  @JsonKey()
  final double weightChange;
  @override
  final double overallScore;

  @override
  String toString() {
    return 'WeeklyNutritionSummary(userId: $userId, weekStartDate: $weekStartDate, dailyEntries: $dailyEntries, averageDaily: $averageDaily, weeklyTotal: $weeklyTotal, goalAchievementRates: $goalAchievementRates, trends: $trends, averageWaterIntake: $averageWaterIntake, totalExerciseCalories: $totalExerciseCalories, weightChange: $weightChange, overallScore: $overallScore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeeklyNutritionSummaryImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.weekStartDate, weekStartDate) ||
                other.weekStartDate == weekStartDate) &&
            const DeepCollectionEquality()
                .equals(other._dailyEntries, _dailyEntries) &&
            (identical(other.averageDaily, averageDaily) ||
                other.averageDaily == averageDaily) &&
            (identical(other.weeklyTotal, weeklyTotal) ||
                other.weeklyTotal == weeklyTotal) &&
            const DeepCollectionEquality()
                .equals(other._goalAchievementRates, _goalAchievementRates) &&
            const DeepCollectionEquality().equals(other._trends, _trends) &&
            (identical(other.averageWaterIntake, averageWaterIntake) ||
                other.averageWaterIntake == averageWaterIntake) &&
            (identical(other.totalExerciseCalories, totalExerciseCalories) ||
                other.totalExerciseCalories == totalExerciseCalories) &&
            (identical(other.weightChange, weightChange) ||
                other.weightChange == weightChange) &&
            (identical(other.overallScore, overallScore) ||
                other.overallScore == overallScore));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      weekStartDate,
      const DeepCollectionEquality().hash(_dailyEntries),
      averageDaily,
      weeklyTotal,
      const DeepCollectionEquality().hash(_goalAchievementRates),
      const DeepCollectionEquality().hash(_trends),
      averageWaterIntake,
      totalExerciseCalories,
      weightChange,
      overallScore);

  /// Create a copy of WeeklyNutritionSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WeeklyNutritionSummaryImplCopyWith<_$WeeklyNutritionSummaryImpl>
      get copyWith => __$$WeeklyNutritionSummaryImplCopyWithImpl<
          _$WeeklyNutritionSummaryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WeeklyNutritionSummaryImplToJson(
      this,
    );
  }
}

abstract class _WeeklyNutritionSummary implements WeeklyNutritionSummary {
  const factory _WeeklyNutritionSummary(
      {required final String userId,
      required final DateTime weekStartDate,
      required final List<NutritionEntry> dailyEntries,
      required final NutritionInfo averageDaily,
      required final NutritionInfo weeklyTotal,
      required final Map<String, double> goalAchievementRates,
      required final List<NutritionTrend> trends,
      final double averageWaterIntake,
      final double totalExerciseCalories,
      final double weightChange,
      required final double overallScore}) = _$WeeklyNutritionSummaryImpl;

  factory _WeeklyNutritionSummary.fromJson(Map<String, dynamic> json) =
      _$WeeklyNutritionSummaryImpl.fromJson;

  @override
  String get userId;
  @override
  DateTime get weekStartDate;
  @override
  List<NutritionEntry> get dailyEntries;
  @override
  NutritionInfo get averageDaily;
  @override
  NutritionInfo get weeklyTotal;
  @override
  Map<String, double> get goalAchievementRates;
  @override
  List<NutritionTrend> get trends;
  @override
  double get averageWaterIntake;
  @override
  double get totalExerciseCalories;
  @override
  double get weightChange;
  @override
  double get overallScore;

  /// Create a copy of WeeklyNutritionSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WeeklyNutritionSummaryImplCopyWith<_$WeeklyNutritionSummaryImpl>
      get copyWith => throw _privateConstructorUsedError;
}

NutritionTrend _$NutritionTrendFromJson(Map<String, dynamic> json) {
  return _NutritionTrend.fromJson(json);
}

/// @nodoc
mixin _$NutritionTrend {
  String get nutrient => throw _privateConstructorUsedError;
  TrendDirection get direction => throw _privateConstructorUsedError;
  double get changePercentage => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  TrendSignificance get significance => throw _privateConstructorUsedError;

  /// Serializes this NutritionTrend to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NutritionTrend
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NutritionTrendCopyWith<NutritionTrend> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NutritionTrendCopyWith<$Res> {
  factory $NutritionTrendCopyWith(
          NutritionTrend value, $Res Function(NutritionTrend) then) =
      _$NutritionTrendCopyWithImpl<$Res, NutritionTrend>;
  @useResult
  $Res call(
      {String nutrient,
      TrendDirection direction,
      double changePercentage,
      String description,
      TrendSignificance significance});
}

/// @nodoc
class _$NutritionTrendCopyWithImpl<$Res, $Val extends NutritionTrend>
    implements $NutritionTrendCopyWith<$Res> {
  _$NutritionTrendCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NutritionTrend
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nutrient = null,
    Object? direction = null,
    Object? changePercentage = null,
    Object? description = null,
    Object? significance = null,
  }) {
    return _then(_value.copyWith(
      nutrient: null == nutrient
          ? _value.nutrient
          : nutrient // ignore: cast_nullable_to_non_nullable
              as String,
      direction: null == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as TrendDirection,
      changePercentage: null == changePercentage
          ? _value.changePercentage
          : changePercentage // ignore: cast_nullable_to_non_nullable
              as double,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      significance: null == significance
          ? _value.significance
          : significance // ignore: cast_nullable_to_non_nullable
              as TrendSignificance,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NutritionTrendImplCopyWith<$Res>
    implements $NutritionTrendCopyWith<$Res> {
  factory _$$NutritionTrendImplCopyWith(_$NutritionTrendImpl value,
          $Res Function(_$NutritionTrendImpl) then) =
      __$$NutritionTrendImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String nutrient,
      TrendDirection direction,
      double changePercentage,
      String description,
      TrendSignificance significance});
}

/// @nodoc
class __$$NutritionTrendImplCopyWithImpl<$Res>
    extends _$NutritionTrendCopyWithImpl<$Res, _$NutritionTrendImpl>
    implements _$$NutritionTrendImplCopyWith<$Res> {
  __$$NutritionTrendImplCopyWithImpl(
      _$NutritionTrendImpl _value, $Res Function(_$NutritionTrendImpl) _then)
      : super(_value, _then);

  /// Create a copy of NutritionTrend
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nutrient = null,
    Object? direction = null,
    Object? changePercentage = null,
    Object? description = null,
    Object? significance = null,
  }) {
    return _then(_$NutritionTrendImpl(
      nutrient: null == nutrient
          ? _value.nutrient
          : nutrient // ignore: cast_nullable_to_non_nullable
              as String,
      direction: null == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as TrendDirection,
      changePercentage: null == changePercentage
          ? _value.changePercentage
          : changePercentage // ignore: cast_nullable_to_non_nullable
              as double,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      significance: null == significance
          ? _value.significance
          : significance // ignore: cast_nullable_to_non_nullable
              as TrendSignificance,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NutritionTrendImpl implements _NutritionTrend {
  const _$NutritionTrendImpl(
      {required this.nutrient,
      required this.direction,
      required this.changePercentage,
      required this.description,
      required this.significance});

  factory _$NutritionTrendImpl.fromJson(Map<String, dynamic> json) =>
      _$$NutritionTrendImplFromJson(json);

  @override
  final String nutrient;
  @override
  final TrendDirection direction;
  @override
  final double changePercentage;
  @override
  final String description;
  @override
  final TrendSignificance significance;

  @override
  String toString() {
    return 'NutritionTrend(nutrient: $nutrient, direction: $direction, changePercentage: $changePercentage, description: $description, significance: $significance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NutritionTrendImpl &&
            (identical(other.nutrient, nutrient) ||
                other.nutrient == nutrient) &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            (identical(other.changePercentage, changePercentage) ||
                other.changePercentage == changePercentage) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.significance, significance) ||
                other.significance == significance));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, nutrient, direction,
      changePercentage, description, significance);

  /// Create a copy of NutritionTrend
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NutritionTrendImplCopyWith<_$NutritionTrendImpl> get copyWith =>
      __$$NutritionTrendImplCopyWithImpl<_$NutritionTrendImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NutritionTrendImplToJson(
      this,
    );
  }
}

abstract class _NutritionTrend implements NutritionTrend {
  const factory _NutritionTrend(
      {required final String nutrient,
      required final TrendDirection direction,
      required final double changePercentage,
      required final String description,
      required final TrendSignificance significance}) = _$NutritionTrendImpl;

  factory _NutritionTrend.fromJson(Map<String, dynamic> json) =
      _$NutritionTrendImpl.fromJson;

  @override
  String get nutrient;
  @override
  TrendDirection get direction;
  @override
  double get changePercentage;
  @override
  String get description;
  @override
  TrendSignificance get significance;

  /// Create a copy of NutritionTrend
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NutritionTrendImplCopyWith<_$NutritionTrendImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FoodDatabase _$FoodDatabaseFromJson(Map<String, dynamic> json) {
  return _FoodDatabase.fromJson(json);
}

/// @nodoc
mixin _$FoodDatabase {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get brand => throw _privateConstructorUsedError;
  NutritionInfo get nutritionPer100g => throw _privateConstructorUsedError;
  List<String> get categories => throw _privateConstructorUsedError;
  List<String> get allergens => throw _privateConstructorUsedError;
  String? get barcode => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  bool get isVerified => throw _privateConstructorUsedError;
  int get usageCount => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this FoodDatabase to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FoodDatabase
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FoodDatabaseCopyWith<FoodDatabase> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FoodDatabaseCopyWith<$Res> {
  factory $FoodDatabaseCopyWith(
          FoodDatabase value, $Res Function(FoodDatabase) then) =
      _$FoodDatabaseCopyWithImpl<$Res, FoodDatabase>;
  @useResult
  $Res call(
      {String id,
      String name,
      String brand,
      NutritionInfo nutritionPer100g,
      List<String> categories,
      List<String> allergens,
      String? barcode,
      String? imageUrl,
      bool isVerified,
      int usageCount,
      DateTime createdAt,
      DateTime? updatedAt});

  $NutritionInfoCopyWith<$Res> get nutritionPer100g;
}

/// @nodoc
class _$FoodDatabaseCopyWithImpl<$Res, $Val extends FoodDatabase>
    implements $FoodDatabaseCopyWith<$Res> {
  _$FoodDatabaseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FoodDatabase
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? brand = null,
    Object? nutritionPer100g = null,
    Object? categories = null,
    Object? allergens = null,
    Object? barcode = freezed,
    Object? imageUrl = freezed,
    Object? isVerified = null,
    Object? usageCount = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
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
      brand: null == brand
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String,
      nutritionPer100g: null == nutritionPer100g
          ? _value.nutritionPer100g
          : nutritionPer100g // ignore: cast_nullable_to_non_nullable
              as NutritionInfo,
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      allergens: null == allergens
          ? _value.allergens
          : allergens // ignore: cast_nullable_to_non_nullable
              as List<String>,
      barcode: freezed == barcode
          ? _value.barcode
          : barcode // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      usageCount: null == usageCount
          ? _value.usageCount
          : usageCount // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  /// Create a copy of FoodDatabase
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NutritionInfoCopyWith<$Res> get nutritionPer100g {
    return $NutritionInfoCopyWith<$Res>(_value.nutritionPer100g, (value) {
      return _then(_value.copyWith(nutritionPer100g: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FoodDatabaseImplCopyWith<$Res>
    implements $FoodDatabaseCopyWith<$Res> {
  factory _$$FoodDatabaseImplCopyWith(
          _$FoodDatabaseImpl value, $Res Function(_$FoodDatabaseImpl) then) =
      __$$FoodDatabaseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String brand,
      NutritionInfo nutritionPer100g,
      List<String> categories,
      List<String> allergens,
      String? barcode,
      String? imageUrl,
      bool isVerified,
      int usageCount,
      DateTime createdAt,
      DateTime? updatedAt});

  @override
  $NutritionInfoCopyWith<$Res> get nutritionPer100g;
}

/// @nodoc
class __$$FoodDatabaseImplCopyWithImpl<$Res>
    extends _$FoodDatabaseCopyWithImpl<$Res, _$FoodDatabaseImpl>
    implements _$$FoodDatabaseImplCopyWith<$Res> {
  __$$FoodDatabaseImplCopyWithImpl(
      _$FoodDatabaseImpl _value, $Res Function(_$FoodDatabaseImpl) _then)
      : super(_value, _then);

  /// Create a copy of FoodDatabase
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? brand = null,
    Object? nutritionPer100g = null,
    Object? categories = null,
    Object? allergens = null,
    Object? barcode = freezed,
    Object? imageUrl = freezed,
    Object? isVerified = null,
    Object? usageCount = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_$FoodDatabaseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      brand: null == brand
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String,
      nutritionPer100g: null == nutritionPer100g
          ? _value.nutritionPer100g
          : nutritionPer100g // ignore: cast_nullable_to_non_nullable
              as NutritionInfo,
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      allergens: null == allergens
          ? _value._allergens
          : allergens // ignore: cast_nullable_to_non_nullable
              as List<String>,
      barcode: freezed == barcode
          ? _value.barcode
          : barcode // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      usageCount: null == usageCount
          ? _value.usageCount
          : usageCount // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FoodDatabaseImpl implements _FoodDatabase {
  const _$FoodDatabaseImpl(
      {required this.id,
      required this.name,
      required this.brand,
      required this.nutritionPer100g,
      final List<String> categories = const [],
      final List<String> allergens = const [],
      this.barcode,
      this.imageUrl,
      this.isVerified = false,
      this.usageCount = 0,
      required this.createdAt,
      this.updatedAt})
      : _categories = categories,
        _allergens = allergens;

  factory _$FoodDatabaseImpl.fromJson(Map<String, dynamic> json) =>
      _$$FoodDatabaseImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String brand;
  @override
  final NutritionInfo nutritionPer100g;
  final List<String> _categories;
  @override
  @JsonKey()
  List<String> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  final List<String> _allergens;
  @override
  @JsonKey()
  List<String> get allergens {
    if (_allergens is EqualUnmodifiableListView) return _allergens;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allergens);
  }

  @override
  final String? barcode;
  @override
  final String? imageUrl;
  @override
  @JsonKey()
  final bool isVerified;
  @override
  @JsonKey()
  final int usageCount;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'FoodDatabase(id: $id, name: $name, brand: $brand, nutritionPer100g: $nutritionPer100g, categories: $categories, allergens: $allergens, barcode: $barcode, imageUrl: $imageUrl, isVerified: $isVerified, usageCount: $usageCount, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FoodDatabaseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.nutritionPer100g, nutritionPer100g) ||
                other.nutritionPer100g == nutritionPer100g) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            const DeepCollectionEquality()
                .equals(other._allergens, _allergens) &&
            (identical(other.barcode, barcode) || other.barcode == barcode) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified) &&
            (identical(other.usageCount, usageCount) ||
                other.usageCount == usageCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      brand,
      nutritionPer100g,
      const DeepCollectionEquality().hash(_categories),
      const DeepCollectionEquality().hash(_allergens),
      barcode,
      imageUrl,
      isVerified,
      usageCount,
      createdAt,
      updatedAt);

  /// Create a copy of FoodDatabase
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FoodDatabaseImplCopyWith<_$FoodDatabaseImpl> get copyWith =>
      __$$FoodDatabaseImplCopyWithImpl<_$FoodDatabaseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FoodDatabaseImplToJson(
      this,
    );
  }
}

abstract class _FoodDatabase implements FoodDatabase {
  const factory _FoodDatabase(
      {required final String id,
      required final String name,
      required final String brand,
      required final NutritionInfo nutritionPer100g,
      final List<String> categories,
      final List<String> allergens,
      final String? barcode,
      final String? imageUrl,
      final bool isVerified,
      final int usageCount,
      required final DateTime createdAt,
      final DateTime? updatedAt}) = _$FoodDatabaseImpl;

  factory _FoodDatabase.fromJson(Map<String, dynamic> json) =
      _$FoodDatabaseImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get brand;
  @override
  NutritionInfo get nutritionPer100g;
  @override
  List<String> get categories;
  @override
  List<String> get allergens;
  @override
  String? get barcode;
  @override
  String? get imageUrl;
  @override
  bool get isVerified;
  @override
  int get usageCount;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of FoodDatabase
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FoodDatabaseImplCopyWith<_$FoodDatabaseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NutritionAnalytics _$NutritionAnalyticsFromJson(Map<String, dynamic> json) {
  return _NutritionAnalytics.fromJson(json);
}

/// @nodoc
mixin _$NutritionAnalytics {
  String get userId => throw _privateConstructorUsedError;
  DateTime get periodStart => throw _privateConstructorUsedError;
  DateTime get periodEnd => throw _privateConstructorUsedError;
  Map<String, double> get averageNutrients =>
      throw _privateConstructorUsedError;
  Map<String, List<double>> get nutrientTrends =>
      throw _privateConstructorUsedError;
  Map<String, double> get goalAchievementRates =>
      throw _privateConstructorUsedError;
  List<String> get topFoods => throw _privateConstructorUsedError;
  List<String> get frequentDeficiencies => throw _privateConstructorUsedError;
  Map<MealType, NutritionInfo> get mealTypeBreakdown =>
      throw _privateConstructorUsedError;
  double get averageCalorieIntake => throw _privateConstructorUsedError;
  double get averageWaterIntake => throw _privateConstructorUsedError;
  int get totalDaysTracked => throw _privateConstructorUsedError;
  double get consistencyScore => throw _privateConstructorUsedError;

  /// Serializes this NutritionAnalytics to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NutritionAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NutritionAnalyticsCopyWith<NutritionAnalytics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NutritionAnalyticsCopyWith<$Res> {
  factory $NutritionAnalyticsCopyWith(
          NutritionAnalytics value, $Res Function(NutritionAnalytics) then) =
      _$NutritionAnalyticsCopyWithImpl<$Res, NutritionAnalytics>;
  @useResult
  $Res call(
      {String userId,
      DateTime periodStart,
      DateTime periodEnd,
      Map<String, double> averageNutrients,
      Map<String, List<double>> nutrientTrends,
      Map<String, double> goalAchievementRates,
      List<String> topFoods,
      List<String> frequentDeficiencies,
      Map<MealType, NutritionInfo> mealTypeBreakdown,
      double averageCalorieIntake,
      double averageWaterIntake,
      int totalDaysTracked,
      double consistencyScore});
}

/// @nodoc
class _$NutritionAnalyticsCopyWithImpl<$Res, $Val extends NutritionAnalytics>
    implements $NutritionAnalyticsCopyWith<$Res> {
  _$NutritionAnalyticsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NutritionAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? periodStart = null,
    Object? periodEnd = null,
    Object? averageNutrients = null,
    Object? nutrientTrends = null,
    Object? goalAchievementRates = null,
    Object? topFoods = null,
    Object? frequentDeficiencies = null,
    Object? mealTypeBreakdown = null,
    Object? averageCalorieIntake = null,
    Object? averageWaterIntake = null,
    Object? totalDaysTracked = null,
    Object? consistencyScore = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      periodStart: null == periodStart
          ? _value.periodStart
          : periodStart // ignore: cast_nullable_to_non_nullable
              as DateTime,
      periodEnd: null == periodEnd
          ? _value.periodEnd
          : periodEnd // ignore: cast_nullable_to_non_nullable
              as DateTime,
      averageNutrients: null == averageNutrients
          ? _value.averageNutrients
          : averageNutrients // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      nutrientTrends: null == nutrientTrends
          ? _value.nutrientTrends
          : nutrientTrends // ignore: cast_nullable_to_non_nullable
              as Map<String, List<double>>,
      goalAchievementRates: null == goalAchievementRates
          ? _value.goalAchievementRates
          : goalAchievementRates // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      topFoods: null == topFoods
          ? _value.topFoods
          : topFoods // ignore: cast_nullable_to_non_nullable
              as List<String>,
      frequentDeficiencies: null == frequentDeficiencies
          ? _value.frequentDeficiencies
          : frequentDeficiencies // ignore: cast_nullable_to_non_nullable
              as List<String>,
      mealTypeBreakdown: null == mealTypeBreakdown
          ? _value.mealTypeBreakdown
          : mealTypeBreakdown // ignore: cast_nullable_to_non_nullable
              as Map<MealType, NutritionInfo>,
      averageCalorieIntake: null == averageCalorieIntake
          ? _value.averageCalorieIntake
          : averageCalorieIntake // ignore: cast_nullable_to_non_nullable
              as double,
      averageWaterIntake: null == averageWaterIntake
          ? _value.averageWaterIntake
          : averageWaterIntake // ignore: cast_nullable_to_non_nullable
              as double,
      totalDaysTracked: null == totalDaysTracked
          ? _value.totalDaysTracked
          : totalDaysTracked // ignore: cast_nullable_to_non_nullable
              as int,
      consistencyScore: null == consistencyScore
          ? _value.consistencyScore
          : consistencyScore // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NutritionAnalyticsImplCopyWith<$Res>
    implements $NutritionAnalyticsCopyWith<$Res> {
  factory _$$NutritionAnalyticsImplCopyWith(_$NutritionAnalyticsImpl value,
          $Res Function(_$NutritionAnalyticsImpl) then) =
      __$$NutritionAnalyticsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      DateTime periodStart,
      DateTime periodEnd,
      Map<String, double> averageNutrients,
      Map<String, List<double>> nutrientTrends,
      Map<String, double> goalAchievementRates,
      List<String> topFoods,
      List<String> frequentDeficiencies,
      Map<MealType, NutritionInfo> mealTypeBreakdown,
      double averageCalorieIntake,
      double averageWaterIntake,
      int totalDaysTracked,
      double consistencyScore});
}

/// @nodoc
class __$$NutritionAnalyticsImplCopyWithImpl<$Res>
    extends _$NutritionAnalyticsCopyWithImpl<$Res, _$NutritionAnalyticsImpl>
    implements _$$NutritionAnalyticsImplCopyWith<$Res> {
  __$$NutritionAnalyticsImplCopyWithImpl(_$NutritionAnalyticsImpl _value,
      $Res Function(_$NutritionAnalyticsImpl) _then)
      : super(_value, _then);

  /// Create a copy of NutritionAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? periodStart = null,
    Object? periodEnd = null,
    Object? averageNutrients = null,
    Object? nutrientTrends = null,
    Object? goalAchievementRates = null,
    Object? topFoods = null,
    Object? frequentDeficiencies = null,
    Object? mealTypeBreakdown = null,
    Object? averageCalorieIntake = null,
    Object? averageWaterIntake = null,
    Object? totalDaysTracked = null,
    Object? consistencyScore = null,
  }) {
    return _then(_$NutritionAnalyticsImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      periodStart: null == periodStart
          ? _value.periodStart
          : periodStart // ignore: cast_nullable_to_non_nullable
              as DateTime,
      periodEnd: null == periodEnd
          ? _value.periodEnd
          : periodEnd // ignore: cast_nullable_to_non_nullable
              as DateTime,
      averageNutrients: null == averageNutrients
          ? _value._averageNutrients
          : averageNutrients // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      nutrientTrends: null == nutrientTrends
          ? _value._nutrientTrends
          : nutrientTrends // ignore: cast_nullable_to_non_nullable
              as Map<String, List<double>>,
      goalAchievementRates: null == goalAchievementRates
          ? _value._goalAchievementRates
          : goalAchievementRates // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      topFoods: null == topFoods
          ? _value._topFoods
          : topFoods // ignore: cast_nullable_to_non_nullable
              as List<String>,
      frequentDeficiencies: null == frequentDeficiencies
          ? _value._frequentDeficiencies
          : frequentDeficiencies // ignore: cast_nullable_to_non_nullable
              as List<String>,
      mealTypeBreakdown: null == mealTypeBreakdown
          ? _value._mealTypeBreakdown
          : mealTypeBreakdown // ignore: cast_nullable_to_non_nullable
              as Map<MealType, NutritionInfo>,
      averageCalorieIntake: null == averageCalorieIntake
          ? _value.averageCalorieIntake
          : averageCalorieIntake // ignore: cast_nullable_to_non_nullable
              as double,
      averageWaterIntake: null == averageWaterIntake
          ? _value.averageWaterIntake
          : averageWaterIntake // ignore: cast_nullable_to_non_nullable
              as double,
      totalDaysTracked: null == totalDaysTracked
          ? _value.totalDaysTracked
          : totalDaysTracked // ignore: cast_nullable_to_non_nullable
              as int,
      consistencyScore: null == consistencyScore
          ? _value.consistencyScore
          : consistencyScore // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NutritionAnalyticsImpl implements _NutritionAnalytics {
  const _$NutritionAnalyticsImpl(
      {required this.userId,
      required this.periodStart,
      required this.periodEnd,
      required final Map<String, double> averageNutrients,
      required final Map<String, List<double>> nutrientTrends,
      required final Map<String, double> goalAchievementRates,
      required final List<String> topFoods,
      required final List<String> frequentDeficiencies,
      required final Map<MealType, NutritionInfo> mealTypeBreakdown,
      required this.averageCalorieIntake,
      required this.averageWaterIntake,
      required this.totalDaysTracked,
      required this.consistencyScore})
      : _averageNutrients = averageNutrients,
        _nutrientTrends = nutrientTrends,
        _goalAchievementRates = goalAchievementRates,
        _topFoods = topFoods,
        _frequentDeficiencies = frequentDeficiencies,
        _mealTypeBreakdown = mealTypeBreakdown;

  factory _$NutritionAnalyticsImpl.fromJson(Map<String, dynamic> json) =>
      _$$NutritionAnalyticsImplFromJson(json);

  @override
  final String userId;
  @override
  final DateTime periodStart;
  @override
  final DateTime periodEnd;
  final Map<String, double> _averageNutrients;
  @override
  Map<String, double> get averageNutrients {
    if (_averageNutrients is EqualUnmodifiableMapView) return _averageNutrients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_averageNutrients);
  }

  final Map<String, List<double>> _nutrientTrends;
  @override
  Map<String, List<double>> get nutrientTrends {
    if (_nutrientTrends is EqualUnmodifiableMapView) return _nutrientTrends;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_nutrientTrends);
  }

  final Map<String, double> _goalAchievementRates;
  @override
  Map<String, double> get goalAchievementRates {
    if (_goalAchievementRates is EqualUnmodifiableMapView)
      return _goalAchievementRates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_goalAchievementRates);
  }

  final List<String> _topFoods;
  @override
  List<String> get topFoods {
    if (_topFoods is EqualUnmodifiableListView) return _topFoods;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_topFoods);
  }

  final List<String> _frequentDeficiencies;
  @override
  List<String> get frequentDeficiencies {
    if (_frequentDeficiencies is EqualUnmodifiableListView)
      return _frequentDeficiencies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_frequentDeficiencies);
  }

  final Map<MealType, NutritionInfo> _mealTypeBreakdown;
  @override
  Map<MealType, NutritionInfo> get mealTypeBreakdown {
    if (_mealTypeBreakdown is EqualUnmodifiableMapView)
      return _mealTypeBreakdown;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_mealTypeBreakdown);
  }

  @override
  final double averageCalorieIntake;
  @override
  final double averageWaterIntake;
  @override
  final int totalDaysTracked;
  @override
  final double consistencyScore;

  @override
  String toString() {
    return 'NutritionAnalytics(userId: $userId, periodStart: $periodStart, periodEnd: $periodEnd, averageNutrients: $averageNutrients, nutrientTrends: $nutrientTrends, goalAchievementRates: $goalAchievementRates, topFoods: $topFoods, frequentDeficiencies: $frequentDeficiencies, mealTypeBreakdown: $mealTypeBreakdown, averageCalorieIntake: $averageCalorieIntake, averageWaterIntake: $averageWaterIntake, totalDaysTracked: $totalDaysTracked, consistencyScore: $consistencyScore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NutritionAnalyticsImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.periodStart, periodStart) ||
                other.periodStart == periodStart) &&
            (identical(other.periodEnd, periodEnd) ||
                other.periodEnd == periodEnd) &&
            const DeepCollectionEquality()
                .equals(other._averageNutrients, _averageNutrients) &&
            const DeepCollectionEquality()
                .equals(other._nutrientTrends, _nutrientTrends) &&
            const DeepCollectionEquality()
                .equals(other._goalAchievementRates, _goalAchievementRates) &&
            const DeepCollectionEquality().equals(other._topFoods, _topFoods) &&
            const DeepCollectionEquality()
                .equals(other._frequentDeficiencies, _frequentDeficiencies) &&
            const DeepCollectionEquality()
                .equals(other._mealTypeBreakdown, _mealTypeBreakdown) &&
            (identical(other.averageCalorieIntake, averageCalorieIntake) ||
                other.averageCalorieIntake == averageCalorieIntake) &&
            (identical(other.averageWaterIntake, averageWaterIntake) ||
                other.averageWaterIntake == averageWaterIntake) &&
            (identical(other.totalDaysTracked, totalDaysTracked) ||
                other.totalDaysTracked == totalDaysTracked) &&
            (identical(other.consistencyScore, consistencyScore) ||
                other.consistencyScore == consistencyScore));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      periodStart,
      periodEnd,
      const DeepCollectionEquality().hash(_averageNutrients),
      const DeepCollectionEquality().hash(_nutrientTrends),
      const DeepCollectionEquality().hash(_goalAchievementRates),
      const DeepCollectionEquality().hash(_topFoods),
      const DeepCollectionEquality().hash(_frequentDeficiencies),
      const DeepCollectionEquality().hash(_mealTypeBreakdown),
      averageCalorieIntake,
      averageWaterIntake,
      totalDaysTracked,
      consistencyScore);

  /// Create a copy of NutritionAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NutritionAnalyticsImplCopyWith<_$NutritionAnalyticsImpl> get copyWith =>
      __$$NutritionAnalyticsImplCopyWithImpl<_$NutritionAnalyticsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NutritionAnalyticsImplToJson(
      this,
    );
  }
}

abstract class _NutritionAnalytics implements NutritionAnalytics {
  const factory _NutritionAnalytics(
      {required final String userId,
      required final DateTime periodStart,
      required final DateTime periodEnd,
      required final Map<String, double> averageNutrients,
      required final Map<String, List<double>> nutrientTrends,
      required final Map<String, double> goalAchievementRates,
      required final List<String> topFoods,
      required final List<String> frequentDeficiencies,
      required final Map<MealType, NutritionInfo> mealTypeBreakdown,
      required final double averageCalorieIntake,
      required final double averageWaterIntake,
      required final int totalDaysTracked,
      required final double consistencyScore}) = _$NutritionAnalyticsImpl;

  factory _NutritionAnalytics.fromJson(Map<String, dynamic> json) =
      _$NutritionAnalyticsImpl.fromJson;

  @override
  String get userId;
  @override
  DateTime get periodStart;
  @override
  DateTime get periodEnd;
  @override
  Map<String, double> get averageNutrients;
  @override
  Map<String, List<double>> get nutrientTrends;
  @override
  Map<String, double> get goalAchievementRates;
  @override
  List<String> get topFoods;
  @override
  List<String> get frequentDeficiencies;
  @override
  Map<MealType, NutritionInfo> get mealTypeBreakdown;
  @override
  double get averageCalorieIntake;
  @override
  double get averageWaterIntake;
  @override
  int get totalDaysTracked;
  @override
  double get consistencyScore;

  /// Create a copy of NutritionAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NutritionAnalyticsImplCopyWith<_$NutritionAnalyticsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NutritionRecommendation _$NutritionRecommendationFromJson(
    Map<String, dynamic> json) {
  return _NutritionRecommendation.fromJson(json);
}

/// @nodoc
mixin _$NutritionRecommendation {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  RecommendationType get type => throw _privateConstructorUsedError;
  RecommendationPriority get priority => throw _privateConstructorUsedError;
  List<String> get suggestedFoods => throw _privateConstructorUsedError;
  List<String> get suggestedRecipes => throw _privateConstructorUsedError;
  List<String> get avoidFoods => throw _privateConstructorUsedError;
  String? get reasoning => throw _privateConstructorUsedError;
  List<String> get benefits => throw _privateConstructorUsedError;
  DateTime? get expiresAt => throw _privateConstructorUsedError;
  bool get isDismissed => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this NutritionRecommendation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NutritionRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NutritionRecommendationCopyWith<NutritionRecommendation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NutritionRecommendationCopyWith<$Res> {
  factory $NutritionRecommendationCopyWith(NutritionRecommendation value,
          $Res Function(NutritionRecommendation) then) =
      _$NutritionRecommendationCopyWithImpl<$Res, NutritionRecommendation>;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      RecommendationType type,
      RecommendationPriority priority,
      List<String> suggestedFoods,
      List<String> suggestedRecipes,
      List<String> avoidFoods,
      String? reasoning,
      List<String> benefits,
      DateTime? expiresAt,
      bool isDismissed,
      DateTime createdAt});
}

/// @nodoc
class _$NutritionRecommendationCopyWithImpl<$Res,
        $Val extends NutritionRecommendation>
    implements $NutritionRecommendationCopyWith<$Res> {
  _$NutritionRecommendationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NutritionRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? type = null,
    Object? priority = null,
    Object? suggestedFoods = null,
    Object? suggestedRecipes = null,
    Object? avoidFoods = null,
    Object? reasoning = freezed,
    Object? benefits = null,
    Object? expiresAt = freezed,
    Object? isDismissed = null,
    Object? createdAt = null,
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
              as RecommendationType,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as RecommendationPriority,
      suggestedFoods: null == suggestedFoods
          ? _value.suggestedFoods
          : suggestedFoods // ignore: cast_nullable_to_non_nullable
              as List<String>,
      suggestedRecipes: null == suggestedRecipes
          ? _value.suggestedRecipes
          : suggestedRecipes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      avoidFoods: null == avoidFoods
          ? _value.avoidFoods
          : avoidFoods // ignore: cast_nullable_to_non_nullable
              as List<String>,
      reasoning: freezed == reasoning
          ? _value.reasoning
          : reasoning // ignore: cast_nullable_to_non_nullable
              as String?,
      benefits: null == benefits
          ? _value.benefits
          : benefits // ignore: cast_nullable_to_non_nullable
              as List<String>,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isDismissed: null == isDismissed
          ? _value.isDismissed
          : isDismissed // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NutritionRecommendationImplCopyWith<$Res>
    implements $NutritionRecommendationCopyWith<$Res> {
  factory _$$NutritionRecommendationImplCopyWith(
          _$NutritionRecommendationImpl value,
          $Res Function(_$NutritionRecommendationImpl) then) =
      __$$NutritionRecommendationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      RecommendationType type,
      RecommendationPriority priority,
      List<String> suggestedFoods,
      List<String> suggestedRecipes,
      List<String> avoidFoods,
      String? reasoning,
      List<String> benefits,
      DateTime? expiresAt,
      bool isDismissed,
      DateTime createdAt});
}

/// @nodoc
class __$$NutritionRecommendationImplCopyWithImpl<$Res>
    extends _$NutritionRecommendationCopyWithImpl<$Res,
        _$NutritionRecommendationImpl>
    implements _$$NutritionRecommendationImplCopyWith<$Res> {
  __$$NutritionRecommendationImplCopyWithImpl(
      _$NutritionRecommendationImpl _value,
      $Res Function(_$NutritionRecommendationImpl) _then)
      : super(_value, _then);

  /// Create a copy of NutritionRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? type = null,
    Object? priority = null,
    Object? suggestedFoods = null,
    Object? suggestedRecipes = null,
    Object? avoidFoods = null,
    Object? reasoning = freezed,
    Object? benefits = null,
    Object? expiresAt = freezed,
    Object? isDismissed = null,
    Object? createdAt = null,
  }) {
    return _then(_$NutritionRecommendationImpl(
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
              as RecommendationType,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as RecommendationPriority,
      suggestedFoods: null == suggestedFoods
          ? _value._suggestedFoods
          : suggestedFoods // ignore: cast_nullable_to_non_nullable
              as List<String>,
      suggestedRecipes: null == suggestedRecipes
          ? _value._suggestedRecipes
          : suggestedRecipes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      avoidFoods: null == avoidFoods
          ? _value._avoidFoods
          : avoidFoods // ignore: cast_nullable_to_non_nullable
              as List<String>,
      reasoning: freezed == reasoning
          ? _value.reasoning
          : reasoning // ignore: cast_nullable_to_non_nullable
              as String?,
      benefits: null == benefits
          ? _value._benefits
          : benefits // ignore: cast_nullable_to_non_nullable
              as List<String>,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isDismissed: null == isDismissed
          ? _value.isDismissed
          : isDismissed // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NutritionRecommendationImpl implements _NutritionRecommendation {
  const _$NutritionRecommendationImpl(
      {required this.id,
      required this.title,
      required this.description,
      required this.type,
      required this.priority,
      required final List<String> suggestedFoods,
      required final List<String> suggestedRecipes,
      final List<String> avoidFoods = const [],
      this.reasoning,
      final List<String> benefits = const [],
      this.expiresAt,
      this.isDismissed = false,
      required this.createdAt})
      : _suggestedFoods = suggestedFoods,
        _suggestedRecipes = suggestedRecipes,
        _avoidFoods = avoidFoods,
        _benefits = benefits;

  factory _$NutritionRecommendationImpl.fromJson(Map<String, dynamic> json) =>
      _$$NutritionRecommendationImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final RecommendationType type;
  @override
  final RecommendationPriority priority;
  final List<String> _suggestedFoods;
  @override
  List<String> get suggestedFoods {
    if (_suggestedFoods is EqualUnmodifiableListView) return _suggestedFoods;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_suggestedFoods);
  }

  final List<String> _suggestedRecipes;
  @override
  List<String> get suggestedRecipes {
    if (_suggestedRecipes is EqualUnmodifiableListView)
      return _suggestedRecipes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_suggestedRecipes);
  }

  final List<String> _avoidFoods;
  @override
  @JsonKey()
  List<String> get avoidFoods {
    if (_avoidFoods is EqualUnmodifiableListView) return _avoidFoods;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_avoidFoods);
  }

  @override
  final String? reasoning;
  final List<String> _benefits;
  @override
  @JsonKey()
  List<String> get benefits {
    if (_benefits is EqualUnmodifiableListView) return _benefits;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_benefits);
  }

  @override
  final DateTime? expiresAt;
  @override
  @JsonKey()
  final bool isDismissed;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'NutritionRecommendation(id: $id, title: $title, description: $description, type: $type, priority: $priority, suggestedFoods: $suggestedFoods, suggestedRecipes: $suggestedRecipes, avoidFoods: $avoidFoods, reasoning: $reasoning, benefits: $benefits, expiresAt: $expiresAt, isDismissed: $isDismissed, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NutritionRecommendationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            const DeepCollectionEquality()
                .equals(other._suggestedFoods, _suggestedFoods) &&
            const DeepCollectionEquality()
                .equals(other._suggestedRecipes, _suggestedRecipes) &&
            const DeepCollectionEquality()
                .equals(other._avoidFoods, _avoidFoods) &&
            (identical(other.reasoning, reasoning) ||
                other.reasoning == reasoning) &&
            const DeepCollectionEquality().equals(other._benefits, _benefits) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.isDismissed, isDismissed) ||
                other.isDismissed == isDismissed) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      type,
      priority,
      const DeepCollectionEquality().hash(_suggestedFoods),
      const DeepCollectionEquality().hash(_suggestedRecipes),
      const DeepCollectionEquality().hash(_avoidFoods),
      reasoning,
      const DeepCollectionEquality().hash(_benefits),
      expiresAt,
      isDismissed,
      createdAt);

  /// Create a copy of NutritionRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NutritionRecommendationImplCopyWith<_$NutritionRecommendationImpl>
      get copyWith => __$$NutritionRecommendationImplCopyWithImpl<
          _$NutritionRecommendationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NutritionRecommendationImplToJson(
      this,
    );
  }
}

abstract class _NutritionRecommendation implements NutritionRecommendation {
  const factory _NutritionRecommendation(
      {required final String id,
      required final String title,
      required final String description,
      required final RecommendationType type,
      required final RecommendationPriority priority,
      required final List<String> suggestedFoods,
      required final List<String> suggestedRecipes,
      final List<String> avoidFoods,
      final String? reasoning,
      final List<String> benefits,
      final DateTime? expiresAt,
      final bool isDismissed,
      required final DateTime createdAt}) = _$NutritionRecommendationImpl;

  factory _NutritionRecommendation.fromJson(Map<String, dynamic> json) =
      _$NutritionRecommendationImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  RecommendationType get type;
  @override
  RecommendationPriority get priority;
  @override
  List<String> get suggestedFoods;
  @override
  List<String> get suggestedRecipes;
  @override
  List<String> get avoidFoods;
  @override
  String? get reasoning;
  @override
  List<String> get benefits;
  @override
  DateTime? get expiresAt;
  @override
  bool get isDismissed;
  @override
  DateTime get createdAt;

  /// Create a copy of NutritionRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NutritionRecommendationImplCopyWith<_$NutritionRecommendationImpl>
      get copyWith => throw _privateConstructorUsedError;
}

NutritionFilter _$NutritionFilterFromJson(Map<String, dynamic> json) {
  return _NutritionFilter.fromJson(json);
}

/// @nodoc
mixin _$NutritionFilter {
  DateTime? get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  List<MealType> get mealTypes => throw _privateConstructorUsedError;
  List<String> get foodCategories => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  String? get searchQuery => throw _privateConstructorUsedError;
  bool get showOnlyDeficiencies => throw _privateConstructorUsedError;
  bool get showOnlyExcesses => throw _privateConstructorUsedError;
  double? get minCalories => throw _privateConstructorUsedError;
  double? get maxCalories => throw _privateConstructorUsedError;

  /// Serializes this NutritionFilter to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NutritionFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NutritionFilterCopyWith<NutritionFilter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NutritionFilterCopyWith<$Res> {
  factory $NutritionFilterCopyWith(
          NutritionFilter value, $Res Function(NutritionFilter) then) =
      _$NutritionFilterCopyWithImpl<$Res, NutritionFilter>;
  @useResult
  $Res call(
      {DateTime? startDate,
      DateTime? endDate,
      List<MealType> mealTypes,
      List<String> foodCategories,
      List<String> tags,
      String? searchQuery,
      bool showOnlyDeficiencies,
      bool showOnlyExcesses,
      double? minCalories,
      double? maxCalories});
}

/// @nodoc
class _$NutritionFilterCopyWithImpl<$Res, $Val extends NutritionFilter>
    implements $NutritionFilterCopyWith<$Res> {
  _$NutritionFilterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NutritionFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? mealTypes = null,
    Object? foodCategories = null,
    Object? tags = null,
    Object? searchQuery = freezed,
    Object? showOnlyDeficiencies = null,
    Object? showOnlyExcesses = null,
    Object? minCalories = freezed,
    Object? maxCalories = freezed,
  }) {
    return _then(_value.copyWith(
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      mealTypes: null == mealTypes
          ? _value.mealTypes
          : mealTypes // ignore: cast_nullable_to_non_nullable
              as List<MealType>,
      foodCategories: null == foodCategories
          ? _value.foodCategories
          : foodCategories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      searchQuery: freezed == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String?,
      showOnlyDeficiencies: null == showOnlyDeficiencies
          ? _value.showOnlyDeficiencies
          : showOnlyDeficiencies // ignore: cast_nullable_to_non_nullable
              as bool,
      showOnlyExcesses: null == showOnlyExcesses
          ? _value.showOnlyExcesses
          : showOnlyExcesses // ignore: cast_nullable_to_non_nullable
              as bool,
      minCalories: freezed == minCalories
          ? _value.minCalories
          : minCalories // ignore: cast_nullable_to_non_nullable
              as double?,
      maxCalories: freezed == maxCalories
          ? _value.maxCalories
          : maxCalories // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NutritionFilterImplCopyWith<$Res>
    implements $NutritionFilterCopyWith<$Res> {
  factory _$$NutritionFilterImplCopyWith(_$NutritionFilterImpl value,
          $Res Function(_$NutritionFilterImpl) then) =
      __$$NutritionFilterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime? startDate,
      DateTime? endDate,
      List<MealType> mealTypes,
      List<String> foodCategories,
      List<String> tags,
      String? searchQuery,
      bool showOnlyDeficiencies,
      bool showOnlyExcesses,
      double? minCalories,
      double? maxCalories});
}

/// @nodoc
class __$$NutritionFilterImplCopyWithImpl<$Res>
    extends _$NutritionFilterCopyWithImpl<$Res, _$NutritionFilterImpl>
    implements _$$NutritionFilterImplCopyWith<$Res> {
  __$$NutritionFilterImplCopyWithImpl(
      _$NutritionFilterImpl _value, $Res Function(_$NutritionFilterImpl) _then)
      : super(_value, _then);

  /// Create a copy of NutritionFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? mealTypes = null,
    Object? foodCategories = null,
    Object? tags = null,
    Object? searchQuery = freezed,
    Object? showOnlyDeficiencies = null,
    Object? showOnlyExcesses = null,
    Object? minCalories = freezed,
    Object? maxCalories = freezed,
  }) {
    return _then(_$NutritionFilterImpl(
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      mealTypes: null == mealTypes
          ? _value._mealTypes
          : mealTypes // ignore: cast_nullable_to_non_nullable
              as List<MealType>,
      foodCategories: null == foodCategories
          ? _value._foodCategories
          : foodCategories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      searchQuery: freezed == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String?,
      showOnlyDeficiencies: null == showOnlyDeficiencies
          ? _value.showOnlyDeficiencies
          : showOnlyDeficiencies // ignore: cast_nullable_to_non_nullable
              as bool,
      showOnlyExcesses: null == showOnlyExcesses
          ? _value.showOnlyExcesses
          : showOnlyExcesses // ignore: cast_nullable_to_non_nullable
              as bool,
      minCalories: freezed == minCalories
          ? _value.minCalories
          : minCalories // ignore: cast_nullable_to_non_nullable
              as double?,
      maxCalories: freezed == maxCalories
          ? _value.maxCalories
          : maxCalories // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NutritionFilterImpl implements _NutritionFilter {
  const _$NutritionFilterImpl(
      {this.startDate,
      this.endDate,
      final List<MealType> mealTypes = const [],
      final List<String> foodCategories = const [],
      final List<String> tags = const [],
      this.searchQuery,
      this.showOnlyDeficiencies = false,
      this.showOnlyExcesses = false,
      this.minCalories,
      this.maxCalories})
      : _mealTypes = mealTypes,
        _foodCategories = foodCategories,
        _tags = tags;

  factory _$NutritionFilterImpl.fromJson(Map<String, dynamic> json) =>
      _$$NutritionFilterImplFromJson(json);

  @override
  final DateTime? startDate;
  @override
  final DateTime? endDate;
  final List<MealType> _mealTypes;
  @override
  @JsonKey()
  List<MealType> get mealTypes {
    if (_mealTypes is EqualUnmodifiableListView) return _mealTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_mealTypes);
  }

  final List<String> _foodCategories;
  @override
  @JsonKey()
  List<String> get foodCategories {
    if (_foodCategories is EqualUnmodifiableListView) return _foodCategories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_foodCategories);
  }

  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final String? searchQuery;
  @override
  @JsonKey()
  final bool showOnlyDeficiencies;
  @override
  @JsonKey()
  final bool showOnlyExcesses;
  @override
  final double? minCalories;
  @override
  final double? maxCalories;

  @override
  String toString() {
    return 'NutritionFilter(startDate: $startDate, endDate: $endDate, mealTypes: $mealTypes, foodCategories: $foodCategories, tags: $tags, searchQuery: $searchQuery, showOnlyDeficiencies: $showOnlyDeficiencies, showOnlyExcesses: $showOnlyExcesses, minCalories: $minCalories, maxCalories: $maxCalories)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NutritionFilterImpl &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            const DeepCollectionEquality()
                .equals(other._mealTypes, _mealTypes) &&
            const DeepCollectionEquality()
                .equals(other._foodCategories, _foodCategories) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.showOnlyDeficiencies, showOnlyDeficiencies) ||
                other.showOnlyDeficiencies == showOnlyDeficiencies) &&
            (identical(other.showOnlyExcesses, showOnlyExcesses) ||
                other.showOnlyExcesses == showOnlyExcesses) &&
            (identical(other.minCalories, minCalories) ||
                other.minCalories == minCalories) &&
            (identical(other.maxCalories, maxCalories) ||
                other.maxCalories == maxCalories));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      startDate,
      endDate,
      const DeepCollectionEquality().hash(_mealTypes),
      const DeepCollectionEquality().hash(_foodCategories),
      const DeepCollectionEquality().hash(_tags),
      searchQuery,
      showOnlyDeficiencies,
      showOnlyExcesses,
      minCalories,
      maxCalories);

  /// Create a copy of NutritionFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NutritionFilterImplCopyWith<_$NutritionFilterImpl> get copyWith =>
      __$$NutritionFilterImplCopyWithImpl<_$NutritionFilterImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NutritionFilterImplToJson(
      this,
    );
  }
}

abstract class _NutritionFilter implements NutritionFilter {
  const factory _NutritionFilter(
      {final DateTime? startDate,
      final DateTime? endDate,
      final List<MealType> mealTypes,
      final List<String> foodCategories,
      final List<String> tags,
      final String? searchQuery,
      final bool showOnlyDeficiencies,
      final bool showOnlyExcesses,
      final double? minCalories,
      final double? maxCalories}) = _$NutritionFilterImpl;

  factory _NutritionFilter.fromJson(Map<String, dynamic> json) =
      _$NutritionFilterImpl.fromJson;

  @override
  DateTime? get startDate;
  @override
  DateTime? get endDate;
  @override
  List<MealType> get mealTypes;
  @override
  List<String> get foodCategories;
  @override
  List<String> get tags;
  @override
  String? get searchQuery;
  @override
  bool get showOnlyDeficiencies;
  @override
  bool get showOnlyExcesses;
  @override
  double? get minCalories;
  @override
  double? get maxCalories;

  /// Create a copy of NutritionFilter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NutritionFilterImplCopyWith<_$NutritionFilterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NutritionDeficiency _$NutritionDeficiencyFromJson(Map<String, dynamic> json) {
  return _NutritionDeficiency.fromJson(json);
}

/// @nodoc
mixin _$NutritionDeficiency {
  String get nutrient => throw _privateConstructorUsedError;
  double get currentAmount => throw _privateConstructorUsedError;
  double get targetAmount => throw _privateConstructorUsedError;
  double get deficitPercentage => throw _privateConstructorUsedError;
  List<String> get suggestedFoods => throw _privateConstructorUsedError;
  DeficiencySeverity get severity => throw _privateConstructorUsedError;
  String? get healthImpact => throw _privateConstructorUsedError;
  List<String> get symptoms => throw _privateConstructorUsedError;

  /// Serializes this NutritionDeficiency to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NutritionDeficiency
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NutritionDeficiencyCopyWith<NutritionDeficiency> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NutritionDeficiencyCopyWith<$Res> {
  factory $NutritionDeficiencyCopyWith(
          NutritionDeficiency value, $Res Function(NutritionDeficiency) then) =
      _$NutritionDeficiencyCopyWithImpl<$Res, NutritionDeficiency>;
  @useResult
  $Res call(
      {String nutrient,
      double currentAmount,
      double targetAmount,
      double deficitPercentage,
      List<String> suggestedFoods,
      DeficiencySeverity severity,
      String? healthImpact,
      List<String> symptoms});
}

/// @nodoc
class _$NutritionDeficiencyCopyWithImpl<$Res, $Val extends NutritionDeficiency>
    implements $NutritionDeficiencyCopyWith<$Res> {
  _$NutritionDeficiencyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NutritionDeficiency
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nutrient = null,
    Object? currentAmount = null,
    Object? targetAmount = null,
    Object? deficitPercentage = null,
    Object? suggestedFoods = null,
    Object? severity = null,
    Object? healthImpact = freezed,
    Object? symptoms = null,
  }) {
    return _then(_value.copyWith(
      nutrient: null == nutrient
          ? _value.nutrient
          : nutrient // ignore: cast_nullable_to_non_nullable
              as String,
      currentAmount: null == currentAmount
          ? _value.currentAmount
          : currentAmount // ignore: cast_nullable_to_non_nullable
              as double,
      targetAmount: null == targetAmount
          ? _value.targetAmount
          : targetAmount // ignore: cast_nullable_to_non_nullable
              as double,
      deficitPercentage: null == deficitPercentage
          ? _value.deficitPercentage
          : deficitPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      suggestedFoods: null == suggestedFoods
          ? _value.suggestedFoods
          : suggestedFoods // ignore: cast_nullable_to_non_nullable
              as List<String>,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as DeficiencySeverity,
      healthImpact: freezed == healthImpact
          ? _value.healthImpact
          : healthImpact // ignore: cast_nullable_to_non_nullable
              as String?,
      symptoms: null == symptoms
          ? _value.symptoms
          : symptoms // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NutritionDeficiencyImplCopyWith<$Res>
    implements $NutritionDeficiencyCopyWith<$Res> {
  factory _$$NutritionDeficiencyImplCopyWith(_$NutritionDeficiencyImpl value,
          $Res Function(_$NutritionDeficiencyImpl) then) =
      __$$NutritionDeficiencyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String nutrient,
      double currentAmount,
      double targetAmount,
      double deficitPercentage,
      List<String> suggestedFoods,
      DeficiencySeverity severity,
      String? healthImpact,
      List<String> symptoms});
}

/// @nodoc
class __$$NutritionDeficiencyImplCopyWithImpl<$Res>
    extends _$NutritionDeficiencyCopyWithImpl<$Res, _$NutritionDeficiencyImpl>
    implements _$$NutritionDeficiencyImplCopyWith<$Res> {
  __$$NutritionDeficiencyImplCopyWithImpl(_$NutritionDeficiencyImpl _value,
      $Res Function(_$NutritionDeficiencyImpl) _then)
      : super(_value, _then);

  /// Create a copy of NutritionDeficiency
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nutrient = null,
    Object? currentAmount = null,
    Object? targetAmount = null,
    Object? deficitPercentage = null,
    Object? suggestedFoods = null,
    Object? severity = null,
    Object? healthImpact = freezed,
    Object? symptoms = null,
  }) {
    return _then(_$NutritionDeficiencyImpl(
      nutrient: null == nutrient
          ? _value.nutrient
          : nutrient // ignore: cast_nullable_to_non_nullable
              as String,
      currentAmount: null == currentAmount
          ? _value.currentAmount
          : currentAmount // ignore: cast_nullable_to_non_nullable
              as double,
      targetAmount: null == targetAmount
          ? _value.targetAmount
          : targetAmount // ignore: cast_nullable_to_non_nullable
              as double,
      deficitPercentage: null == deficitPercentage
          ? _value.deficitPercentage
          : deficitPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      suggestedFoods: null == suggestedFoods
          ? _value._suggestedFoods
          : suggestedFoods // ignore: cast_nullable_to_non_nullable
              as List<String>,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as DeficiencySeverity,
      healthImpact: freezed == healthImpact
          ? _value.healthImpact
          : healthImpact // ignore: cast_nullable_to_non_nullable
              as String?,
      symptoms: null == symptoms
          ? _value._symptoms
          : symptoms // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NutritionDeficiencyImpl implements _NutritionDeficiency {
  const _$NutritionDeficiencyImpl(
      {required this.nutrient,
      required this.currentAmount,
      required this.targetAmount,
      required this.deficitPercentage,
      required final List<String> suggestedFoods,
      this.severity = DeficiencySeverity.moderate,
      this.healthImpact,
      final List<String> symptoms = const []})
      : _suggestedFoods = suggestedFoods,
        _symptoms = symptoms;

  factory _$NutritionDeficiencyImpl.fromJson(Map<String, dynamic> json) =>
      _$$NutritionDeficiencyImplFromJson(json);

  @override
  final String nutrient;
  @override
  final double currentAmount;
  @override
  final double targetAmount;
  @override
  final double deficitPercentage;
  final List<String> _suggestedFoods;
  @override
  List<String> get suggestedFoods {
    if (_suggestedFoods is EqualUnmodifiableListView) return _suggestedFoods;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_suggestedFoods);
  }

  @override
  @JsonKey()
  final DeficiencySeverity severity;
  @override
  final String? healthImpact;
  final List<String> _symptoms;
  @override
  @JsonKey()
  List<String> get symptoms {
    if (_symptoms is EqualUnmodifiableListView) return _symptoms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_symptoms);
  }

  @override
  String toString() {
    return 'NutritionDeficiency(nutrient: $nutrient, currentAmount: $currentAmount, targetAmount: $targetAmount, deficitPercentage: $deficitPercentage, suggestedFoods: $suggestedFoods, severity: $severity, healthImpact: $healthImpact, symptoms: $symptoms)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NutritionDeficiencyImpl &&
            (identical(other.nutrient, nutrient) ||
                other.nutrient == nutrient) &&
            (identical(other.currentAmount, currentAmount) ||
                other.currentAmount == currentAmount) &&
            (identical(other.targetAmount, targetAmount) ||
                other.targetAmount == targetAmount) &&
            (identical(other.deficitPercentage, deficitPercentage) ||
                other.deficitPercentage == deficitPercentage) &&
            const DeepCollectionEquality()
                .equals(other._suggestedFoods, _suggestedFoods) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.healthImpact, healthImpact) ||
                other.healthImpact == healthImpact) &&
            const DeepCollectionEquality().equals(other._symptoms, _symptoms));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      nutrient,
      currentAmount,
      targetAmount,
      deficitPercentage,
      const DeepCollectionEquality().hash(_suggestedFoods),
      severity,
      healthImpact,
      const DeepCollectionEquality().hash(_symptoms));

  /// Create a copy of NutritionDeficiency
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NutritionDeficiencyImplCopyWith<_$NutritionDeficiencyImpl> get copyWith =>
      __$$NutritionDeficiencyImplCopyWithImpl<_$NutritionDeficiencyImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NutritionDeficiencyImplToJson(
      this,
    );
  }
}

abstract class _NutritionDeficiency implements NutritionDeficiency {
  const factory _NutritionDeficiency(
      {required final String nutrient,
      required final double currentAmount,
      required final double targetAmount,
      required final double deficitPercentage,
      required final List<String> suggestedFoods,
      final DeficiencySeverity severity,
      final String? healthImpact,
      final List<String> symptoms}) = _$NutritionDeficiencyImpl;

  factory _NutritionDeficiency.fromJson(Map<String, dynamic> json) =
      _$NutritionDeficiencyImpl.fromJson;

  @override
  String get nutrient;
  @override
  double get currentAmount;
  @override
  double get targetAmount;
  @override
  double get deficitPercentage;
  @override
  List<String> get suggestedFoods;
  @override
  DeficiencySeverity get severity;
  @override
  String? get healthImpact;
  @override
  List<String> get symptoms;

  /// Create a copy of NutritionDeficiency
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NutritionDeficiencyImplCopyWith<_$NutritionDeficiencyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NutritionExcess _$NutritionExcessFromJson(Map<String, dynamic> json) {
  return _NutritionExcess.fromJson(json);
}

/// @nodoc
mixin _$NutritionExcess {
  String get nutrient => throw _privateConstructorUsedError;
  double get currentAmount => throw _privateConstructorUsedError;
  double get targetAmount => throw _privateConstructorUsedError;
  double get excessPercentage => throw _privateConstructorUsedError;
  List<String> get reductionSuggestions => throw _privateConstructorUsedError;
  ExcessSeverity get severity => throw _privateConstructorUsedError;
  String? get healthImpact => throw _privateConstructorUsedError;
  List<String> get risks => throw _privateConstructorUsedError;

  /// Serializes this NutritionExcess to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NutritionExcess
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NutritionExcessCopyWith<NutritionExcess> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NutritionExcessCopyWith<$Res> {
  factory $NutritionExcessCopyWith(
          NutritionExcess value, $Res Function(NutritionExcess) then) =
      _$NutritionExcessCopyWithImpl<$Res, NutritionExcess>;
  @useResult
  $Res call(
      {String nutrient,
      double currentAmount,
      double targetAmount,
      double excessPercentage,
      List<String> reductionSuggestions,
      ExcessSeverity severity,
      String? healthImpact,
      List<String> risks});
}

/// @nodoc
class _$NutritionExcessCopyWithImpl<$Res, $Val extends NutritionExcess>
    implements $NutritionExcessCopyWith<$Res> {
  _$NutritionExcessCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NutritionExcess
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nutrient = null,
    Object? currentAmount = null,
    Object? targetAmount = null,
    Object? excessPercentage = null,
    Object? reductionSuggestions = null,
    Object? severity = null,
    Object? healthImpact = freezed,
    Object? risks = null,
  }) {
    return _then(_value.copyWith(
      nutrient: null == nutrient
          ? _value.nutrient
          : nutrient // ignore: cast_nullable_to_non_nullable
              as String,
      currentAmount: null == currentAmount
          ? _value.currentAmount
          : currentAmount // ignore: cast_nullable_to_non_nullable
              as double,
      targetAmount: null == targetAmount
          ? _value.targetAmount
          : targetAmount // ignore: cast_nullable_to_non_nullable
              as double,
      excessPercentage: null == excessPercentage
          ? _value.excessPercentage
          : excessPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      reductionSuggestions: null == reductionSuggestions
          ? _value.reductionSuggestions
          : reductionSuggestions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as ExcessSeverity,
      healthImpact: freezed == healthImpact
          ? _value.healthImpact
          : healthImpact // ignore: cast_nullable_to_non_nullable
              as String?,
      risks: null == risks
          ? _value.risks
          : risks // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NutritionExcessImplCopyWith<$Res>
    implements $NutritionExcessCopyWith<$Res> {
  factory _$$NutritionExcessImplCopyWith(_$NutritionExcessImpl value,
          $Res Function(_$NutritionExcessImpl) then) =
      __$$NutritionExcessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String nutrient,
      double currentAmount,
      double targetAmount,
      double excessPercentage,
      List<String> reductionSuggestions,
      ExcessSeverity severity,
      String? healthImpact,
      List<String> risks});
}

/// @nodoc
class __$$NutritionExcessImplCopyWithImpl<$Res>
    extends _$NutritionExcessCopyWithImpl<$Res, _$NutritionExcessImpl>
    implements _$$NutritionExcessImplCopyWith<$Res> {
  __$$NutritionExcessImplCopyWithImpl(
      _$NutritionExcessImpl _value, $Res Function(_$NutritionExcessImpl) _then)
      : super(_value, _then);

  /// Create a copy of NutritionExcess
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nutrient = null,
    Object? currentAmount = null,
    Object? targetAmount = null,
    Object? excessPercentage = null,
    Object? reductionSuggestions = null,
    Object? severity = null,
    Object? healthImpact = freezed,
    Object? risks = null,
  }) {
    return _then(_$NutritionExcessImpl(
      nutrient: null == nutrient
          ? _value.nutrient
          : nutrient // ignore: cast_nullable_to_non_nullable
              as String,
      currentAmount: null == currentAmount
          ? _value.currentAmount
          : currentAmount // ignore: cast_nullable_to_non_nullable
              as double,
      targetAmount: null == targetAmount
          ? _value.targetAmount
          : targetAmount // ignore: cast_nullable_to_non_nullable
              as double,
      excessPercentage: null == excessPercentage
          ? _value.excessPercentage
          : excessPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      reductionSuggestions: null == reductionSuggestions
          ? _value._reductionSuggestions
          : reductionSuggestions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as ExcessSeverity,
      healthImpact: freezed == healthImpact
          ? _value.healthImpact
          : healthImpact // ignore: cast_nullable_to_non_nullable
              as String?,
      risks: null == risks
          ? _value._risks
          : risks // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NutritionExcessImpl implements _NutritionExcess {
  const _$NutritionExcessImpl(
      {required this.nutrient,
      required this.currentAmount,
      required this.targetAmount,
      required this.excessPercentage,
      required final List<String> reductionSuggestions,
      this.severity = ExcessSeverity.moderate,
      this.healthImpact,
      final List<String> risks = const []})
      : _reductionSuggestions = reductionSuggestions,
        _risks = risks;

  factory _$NutritionExcessImpl.fromJson(Map<String, dynamic> json) =>
      _$$NutritionExcessImplFromJson(json);

  @override
  final String nutrient;
  @override
  final double currentAmount;
  @override
  final double targetAmount;
  @override
  final double excessPercentage;
  final List<String> _reductionSuggestions;
  @override
  List<String> get reductionSuggestions {
    if (_reductionSuggestions is EqualUnmodifiableListView)
      return _reductionSuggestions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reductionSuggestions);
  }

  @override
  @JsonKey()
  final ExcessSeverity severity;
  @override
  final String? healthImpact;
  final List<String> _risks;
  @override
  @JsonKey()
  List<String> get risks {
    if (_risks is EqualUnmodifiableListView) return _risks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_risks);
  }

  @override
  String toString() {
    return 'NutritionExcess(nutrient: $nutrient, currentAmount: $currentAmount, targetAmount: $targetAmount, excessPercentage: $excessPercentage, reductionSuggestions: $reductionSuggestions, severity: $severity, healthImpact: $healthImpact, risks: $risks)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NutritionExcessImpl &&
            (identical(other.nutrient, nutrient) ||
                other.nutrient == nutrient) &&
            (identical(other.currentAmount, currentAmount) ||
                other.currentAmount == currentAmount) &&
            (identical(other.targetAmount, targetAmount) ||
                other.targetAmount == targetAmount) &&
            (identical(other.excessPercentage, excessPercentage) ||
                other.excessPercentage == excessPercentage) &&
            const DeepCollectionEquality()
                .equals(other._reductionSuggestions, _reductionSuggestions) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.healthImpact, healthImpact) ||
                other.healthImpact == healthImpact) &&
            const DeepCollectionEquality().equals(other._risks, _risks));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      nutrient,
      currentAmount,
      targetAmount,
      excessPercentage,
      const DeepCollectionEquality().hash(_reductionSuggestions),
      severity,
      healthImpact,
      const DeepCollectionEquality().hash(_risks));

  /// Create a copy of NutritionExcess
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NutritionExcessImplCopyWith<_$NutritionExcessImpl> get copyWith =>
      __$$NutritionExcessImplCopyWithImpl<_$NutritionExcessImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NutritionExcessImplToJson(
      this,
    );
  }
}

abstract class _NutritionExcess implements NutritionExcess {
  const factory _NutritionExcess(
      {required final String nutrient,
      required final double currentAmount,
      required final double targetAmount,
      required final double excessPercentage,
      required final List<String> reductionSuggestions,
      final ExcessSeverity severity,
      final String? healthImpact,
      final List<String> risks}) = _$NutritionExcessImpl;

  factory _NutritionExcess.fromJson(Map<String, dynamic> json) =
      _$NutritionExcessImpl.fromJson;

  @override
  String get nutrient;
  @override
  double get currentAmount;
  @override
  double get targetAmount;
  @override
  double get excessPercentage;
  @override
  List<String> get reductionSuggestions;
  @override
  ExcessSeverity get severity;
  @override
  String? get healthImpact;
  @override
  List<String> get risks;

  /// Create a copy of NutritionExcess
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NutritionExcessImplCopyWith<_$NutritionExcessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
