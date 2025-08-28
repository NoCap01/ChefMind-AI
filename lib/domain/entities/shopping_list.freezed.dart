// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shopping_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ShoppingList _$ShoppingListFromJson(Map<String, dynamic> json) {
  return _ShoppingList.fromJson(json);
}

/// @nodoc
mixin _$ShoppingList {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  List<ShoppingListItem> get items => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;
  bool get isShared => throw _privateConstructorUsedError;
  List<String> get sharedWith => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  double get estimatedTotal => throw _privateConstructorUsedError;
  String? get storeId => throw _privateConstructorUsedError;
  String? get storeName => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this ShoppingList to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ShoppingList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShoppingListCopyWith<ShoppingList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShoppingListCopyWith<$Res> {
  factory $ShoppingListCopyWith(
          ShoppingList value, $Res Function(ShoppingList) then) =
      _$ShoppingListCopyWithImpl<$Res, ShoppingList>;
  @useResult
  $Res call(
      {String id,
      String name,
      String userId,
      List<ShoppingListItem> items,
      DateTime createdAt,
      DateTime? updatedAt,
      DateTime? completedAt,
      bool isCompleted,
      bool isShared,
      List<String> sharedWith,
      String? notes,
      double estimatedTotal,
      String? storeId,
      String? storeName,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$ShoppingListCopyWithImpl<$Res, $Val extends ShoppingList>
    implements $ShoppingListCopyWith<$Res> {
  _$ShoppingListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShoppingList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? userId = null,
    Object? items = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? completedAt = freezed,
    Object? isCompleted = null,
    Object? isShared = null,
    Object? sharedWith = null,
    Object? notes = freezed,
    Object? estimatedTotal = null,
    Object? storeId = freezed,
    Object? storeName = freezed,
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
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ShoppingListItem>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      isShared: null == isShared
          ? _value.isShared
          : isShared // ignore: cast_nullable_to_non_nullable
              as bool,
      sharedWith: null == sharedWith
          ? _value.sharedWith
          : sharedWith // ignore: cast_nullable_to_non_nullable
              as List<String>,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      estimatedTotal: null == estimatedTotal
          ? _value.estimatedTotal
          : estimatedTotal // ignore: cast_nullable_to_non_nullable
              as double,
      storeId: freezed == storeId
          ? _value.storeId
          : storeId // ignore: cast_nullable_to_non_nullable
              as String?,
      storeName: freezed == storeName
          ? _value.storeName
          : storeName // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ShoppingListImplCopyWith<$Res>
    implements $ShoppingListCopyWith<$Res> {
  factory _$$ShoppingListImplCopyWith(
          _$ShoppingListImpl value, $Res Function(_$ShoppingListImpl) then) =
      __$$ShoppingListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String userId,
      List<ShoppingListItem> items,
      DateTime createdAt,
      DateTime? updatedAt,
      DateTime? completedAt,
      bool isCompleted,
      bool isShared,
      List<String> sharedWith,
      String? notes,
      double estimatedTotal,
      String? storeId,
      String? storeName,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$ShoppingListImplCopyWithImpl<$Res>
    extends _$ShoppingListCopyWithImpl<$Res, _$ShoppingListImpl>
    implements _$$ShoppingListImplCopyWith<$Res> {
  __$$ShoppingListImplCopyWithImpl(
      _$ShoppingListImpl _value, $Res Function(_$ShoppingListImpl) _then)
      : super(_value, _then);

  /// Create a copy of ShoppingList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? userId = null,
    Object? items = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? completedAt = freezed,
    Object? isCompleted = null,
    Object? isShared = null,
    Object? sharedWith = null,
    Object? notes = freezed,
    Object? estimatedTotal = null,
    Object? storeId = freezed,
    Object? storeName = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$ShoppingListImpl(
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
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ShoppingListItem>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      isShared: null == isShared
          ? _value.isShared
          : isShared // ignore: cast_nullable_to_non_nullable
              as bool,
      sharedWith: null == sharedWith
          ? _value._sharedWith
          : sharedWith // ignore: cast_nullable_to_non_nullable
              as List<String>,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      estimatedTotal: null == estimatedTotal
          ? _value.estimatedTotal
          : estimatedTotal // ignore: cast_nullable_to_non_nullable
              as double,
      storeId: freezed == storeId
          ? _value.storeId
          : storeId // ignore: cast_nullable_to_non_nullable
              as String?,
      storeName: freezed == storeName
          ? _value.storeName
          : storeName // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ShoppingListImpl implements _ShoppingList {
  const _$ShoppingListImpl(
      {required this.id,
      required this.name,
      required this.userId,
      required final List<ShoppingListItem> items,
      required this.createdAt,
      this.updatedAt,
      this.completedAt,
      this.isCompleted = false,
      this.isShared = false,
      final List<String> sharedWith = const [],
      this.notes,
      this.estimatedTotal = 0.0,
      this.storeId,
      this.storeName,
      final Map<String, dynamic>? metadata})
      : _items = items,
        _sharedWith = sharedWith,
        _metadata = metadata;

  factory _$ShoppingListImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShoppingListImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String userId;
  final List<ShoppingListItem> _items;
  @override
  List<ShoppingListItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final DateTime? completedAt;
  @override
  @JsonKey()
  final bool isCompleted;
  @override
  @JsonKey()
  final bool isShared;
  final List<String> _sharedWith;
  @override
  @JsonKey()
  List<String> get sharedWith {
    if (_sharedWith is EqualUnmodifiableListView) return _sharedWith;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sharedWith);
  }

  @override
  final String? notes;
  @override
  @JsonKey()
  final double estimatedTotal;
  @override
  final String? storeId;
  @override
  final String? storeName;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'ShoppingList(id: $id, name: $name, userId: $userId, items: $items, createdAt: $createdAt, updatedAt: $updatedAt, completedAt: $completedAt, isCompleted: $isCompleted, isShared: $isShared, sharedWith: $sharedWith, notes: $notes, estimatedTotal: $estimatedTotal, storeId: $storeId, storeName: $storeName, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShoppingListImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.isShared, isShared) ||
                other.isShared == isShared) &&
            const DeepCollectionEquality()
                .equals(other._sharedWith, _sharedWith) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.estimatedTotal, estimatedTotal) ||
                other.estimatedTotal == estimatedTotal) &&
            (identical(other.storeId, storeId) || other.storeId == storeId) &&
            (identical(other.storeName, storeName) ||
                other.storeName == storeName) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      userId,
      const DeepCollectionEquality().hash(_items),
      createdAt,
      updatedAt,
      completedAt,
      isCompleted,
      isShared,
      const DeepCollectionEquality().hash(_sharedWith),
      notes,
      estimatedTotal,
      storeId,
      storeName,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of ShoppingList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShoppingListImplCopyWith<_$ShoppingListImpl> get copyWith =>
      __$$ShoppingListImplCopyWithImpl<_$ShoppingListImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShoppingListImplToJson(
      this,
    );
  }
}

abstract class _ShoppingList implements ShoppingList {
  const factory _ShoppingList(
      {required final String id,
      required final String name,
      required final String userId,
      required final List<ShoppingListItem> items,
      required final DateTime createdAt,
      final DateTime? updatedAt,
      final DateTime? completedAt,
      final bool isCompleted,
      final bool isShared,
      final List<String> sharedWith,
      final String? notes,
      final double estimatedTotal,
      final String? storeId,
      final String? storeName,
      final Map<String, dynamic>? metadata}) = _$ShoppingListImpl;

  factory _ShoppingList.fromJson(Map<String, dynamic> json) =
      _$ShoppingListImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get userId;
  @override
  List<ShoppingListItem> get items;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  DateTime? get completedAt;
  @override
  bool get isCompleted;
  @override
  bool get isShared;
  @override
  List<String> get sharedWith;
  @override
  String? get notes;
  @override
  double get estimatedTotal;
  @override
  String? get storeId;
  @override
  String? get storeName;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of ShoppingList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShoppingListImplCopyWith<_$ShoppingListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ShoppingListItem _$ShoppingListItemFromJson(Map<String, dynamic> json) {
  return _ShoppingListItem.fromJson(json);
}

/// @nodoc
mixin _$ShoppingListItem {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get quantity => throw _privateConstructorUsedError;
  String get unit => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;
  bool get isUrgent => throw _privateConstructorUsedError;
  double? get estimatedPrice => throw _privateConstructorUsedError;
  double? get actualPrice => throw _privateConstructorUsedError;
  String? get brand => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  String? get recipeId => throw _privateConstructorUsedError;
  String? get recipeName => throw _privateConstructorUsedError;
  DateTime? get addedAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  String? get addedBy => throw _privateConstructorUsedError;
  String? get completedBy => throw _privateConstructorUsedError;
  List<String> get alternatives => throw _privateConstructorUsedError;
  String? get barcode => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;

  /// Serializes this ShoppingListItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ShoppingListItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShoppingListItemCopyWith<ShoppingListItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShoppingListItemCopyWith<$Res> {
  factory $ShoppingListItemCopyWith(
          ShoppingListItem value, $Res Function(ShoppingListItem) then) =
      _$ShoppingListItemCopyWithImpl<$Res, ShoppingListItem>;
  @useResult
  $Res call(
      {String id,
      String name,
      double quantity,
      String unit,
      String category,
      bool isCompleted,
      bool isUrgent,
      double? estimatedPrice,
      double? actualPrice,
      String? brand,
      String? notes,
      String? recipeId,
      String? recipeName,
      DateTime? addedAt,
      DateTime? completedAt,
      String? addedBy,
      String? completedBy,
      List<String> alternatives,
      String? barcode,
      String? imageUrl});
}

/// @nodoc
class _$ShoppingListItemCopyWithImpl<$Res, $Val extends ShoppingListItem>
    implements $ShoppingListItemCopyWith<$Res> {
  _$ShoppingListItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShoppingListItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? quantity = null,
    Object? unit = null,
    Object? category = null,
    Object? isCompleted = null,
    Object? isUrgent = null,
    Object? estimatedPrice = freezed,
    Object? actualPrice = freezed,
    Object? brand = freezed,
    Object? notes = freezed,
    Object? recipeId = freezed,
    Object? recipeName = freezed,
    Object? addedAt = freezed,
    Object? completedAt = freezed,
    Object? addedBy = freezed,
    Object? completedBy = freezed,
    Object? alternatives = null,
    Object? barcode = freezed,
    Object? imageUrl = freezed,
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
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      isUrgent: null == isUrgent
          ? _value.isUrgent
          : isUrgent // ignore: cast_nullable_to_non_nullable
              as bool,
      estimatedPrice: freezed == estimatedPrice
          ? _value.estimatedPrice
          : estimatedPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      actualPrice: freezed == actualPrice
          ? _value.actualPrice
          : actualPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      brand: freezed == brand
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      recipeId: freezed == recipeId
          ? _value.recipeId
          : recipeId // ignore: cast_nullable_to_non_nullable
              as String?,
      recipeName: freezed == recipeName
          ? _value.recipeName
          : recipeName // ignore: cast_nullable_to_non_nullable
              as String?,
      addedAt: freezed == addedAt
          ? _value.addedAt
          : addedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      addedBy: freezed == addedBy
          ? _value.addedBy
          : addedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      completedBy: freezed == completedBy
          ? _value.completedBy
          : completedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      alternatives: null == alternatives
          ? _value.alternatives
          : alternatives // ignore: cast_nullable_to_non_nullable
              as List<String>,
      barcode: freezed == barcode
          ? _value.barcode
          : barcode // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ShoppingListItemImplCopyWith<$Res>
    implements $ShoppingListItemCopyWith<$Res> {
  factory _$$ShoppingListItemImplCopyWith(_$ShoppingListItemImpl value,
          $Res Function(_$ShoppingListItemImpl) then) =
      __$$ShoppingListItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      double quantity,
      String unit,
      String category,
      bool isCompleted,
      bool isUrgent,
      double? estimatedPrice,
      double? actualPrice,
      String? brand,
      String? notes,
      String? recipeId,
      String? recipeName,
      DateTime? addedAt,
      DateTime? completedAt,
      String? addedBy,
      String? completedBy,
      List<String> alternatives,
      String? barcode,
      String? imageUrl});
}

/// @nodoc
class __$$ShoppingListItemImplCopyWithImpl<$Res>
    extends _$ShoppingListItemCopyWithImpl<$Res, _$ShoppingListItemImpl>
    implements _$$ShoppingListItemImplCopyWith<$Res> {
  __$$ShoppingListItemImplCopyWithImpl(_$ShoppingListItemImpl _value,
      $Res Function(_$ShoppingListItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of ShoppingListItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? quantity = null,
    Object? unit = null,
    Object? category = null,
    Object? isCompleted = null,
    Object? isUrgent = null,
    Object? estimatedPrice = freezed,
    Object? actualPrice = freezed,
    Object? brand = freezed,
    Object? notes = freezed,
    Object? recipeId = freezed,
    Object? recipeName = freezed,
    Object? addedAt = freezed,
    Object? completedAt = freezed,
    Object? addedBy = freezed,
    Object? completedBy = freezed,
    Object? alternatives = null,
    Object? barcode = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(_$ShoppingListItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
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
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      isUrgent: null == isUrgent
          ? _value.isUrgent
          : isUrgent // ignore: cast_nullable_to_non_nullable
              as bool,
      estimatedPrice: freezed == estimatedPrice
          ? _value.estimatedPrice
          : estimatedPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      actualPrice: freezed == actualPrice
          ? _value.actualPrice
          : actualPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      brand: freezed == brand
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      recipeId: freezed == recipeId
          ? _value.recipeId
          : recipeId // ignore: cast_nullable_to_non_nullable
              as String?,
      recipeName: freezed == recipeName
          ? _value.recipeName
          : recipeName // ignore: cast_nullable_to_non_nullable
              as String?,
      addedAt: freezed == addedAt
          ? _value.addedAt
          : addedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      addedBy: freezed == addedBy
          ? _value.addedBy
          : addedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      completedBy: freezed == completedBy
          ? _value.completedBy
          : completedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      alternatives: null == alternatives
          ? _value._alternatives
          : alternatives // ignore: cast_nullable_to_non_nullable
              as List<String>,
      barcode: freezed == barcode
          ? _value.barcode
          : barcode // ignore: cast_nullable_to_non_nullable
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
class _$ShoppingListItemImpl implements _ShoppingListItem {
  const _$ShoppingListItemImpl(
      {required this.id,
      required this.name,
      required this.quantity,
      required this.unit,
      required this.category,
      this.isCompleted = false,
      this.isUrgent = false,
      this.estimatedPrice,
      this.actualPrice,
      this.brand,
      this.notes,
      this.recipeId,
      this.recipeName,
      this.addedAt,
      this.completedAt,
      this.addedBy,
      this.completedBy,
      final List<String> alternatives = const [],
      this.barcode,
      this.imageUrl})
      : _alternatives = alternatives;

  factory _$ShoppingListItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShoppingListItemImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final double quantity;
  @override
  final String unit;
  @override
  final String category;
  @override
  @JsonKey()
  final bool isCompleted;
  @override
  @JsonKey()
  final bool isUrgent;
  @override
  final double? estimatedPrice;
  @override
  final double? actualPrice;
  @override
  final String? brand;
  @override
  final String? notes;
  @override
  final String? recipeId;
  @override
  final String? recipeName;
  @override
  final DateTime? addedAt;
  @override
  final DateTime? completedAt;
  @override
  final String? addedBy;
  @override
  final String? completedBy;
  final List<String> _alternatives;
  @override
  @JsonKey()
  List<String> get alternatives {
    if (_alternatives is EqualUnmodifiableListView) return _alternatives;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_alternatives);
  }

  @override
  final String? barcode;
  @override
  final String? imageUrl;

  @override
  String toString() {
    return 'ShoppingListItem(id: $id, name: $name, quantity: $quantity, unit: $unit, category: $category, isCompleted: $isCompleted, isUrgent: $isUrgent, estimatedPrice: $estimatedPrice, actualPrice: $actualPrice, brand: $brand, notes: $notes, recipeId: $recipeId, recipeName: $recipeName, addedAt: $addedAt, completedAt: $completedAt, addedBy: $addedBy, completedBy: $completedBy, alternatives: $alternatives, barcode: $barcode, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShoppingListItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.isUrgent, isUrgent) ||
                other.isUrgent == isUrgent) &&
            (identical(other.estimatedPrice, estimatedPrice) ||
                other.estimatedPrice == estimatedPrice) &&
            (identical(other.actualPrice, actualPrice) ||
                other.actualPrice == actualPrice) &&
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.recipeId, recipeId) ||
                other.recipeId == recipeId) &&
            (identical(other.recipeName, recipeName) ||
                other.recipeName == recipeName) &&
            (identical(other.addedAt, addedAt) || other.addedAt == addedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.addedBy, addedBy) || other.addedBy == addedBy) &&
            (identical(other.completedBy, completedBy) ||
                other.completedBy == completedBy) &&
            const DeepCollectionEquality()
                .equals(other._alternatives, _alternatives) &&
            (identical(other.barcode, barcode) || other.barcode == barcode) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        name,
        quantity,
        unit,
        category,
        isCompleted,
        isUrgent,
        estimatedPrice,
        actualPrice,
        brand,
        notes,
        recipeId,
        recipeName,
        addedAt,
        completedAt,
        addedBy,
        completedBy,
        const DeepCollectionEquality().hash(_alternatives),
        barcode,
        imageUrl
      ]);

  /// Create a copy of ShoppingListItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShoppingListItemImplCopyWith<_$ShoppingListItemImpl> get copyWith =>
      __$$ShoppingListItemImplCopyWithImpl<_$ShoppingListItemImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShoppingListItemImplToJson(
      this,
    );
  }
}

abstract class _ShoppingListItem implements ShoppingListItem {
  const factory _ShoppingListItem(
      {required final String id,
      required final String name,
      required final double quantity,
      required final String unit,
      required final String category,
      final bool isCompleted,
      final bool isUrgent,
      final double? estimatedPrice,
      final double? actualPrice,
      final String? brand,
      final String? notes,
      final String? recipeId,
      final String? recipeName,
      final DateTime? addedAt,
      final DateTime? completedAt,
      final String? addedBy,
      final String? completedBy,
      final List<String> alternatives,
      final String? barcode,
      final String? imageUrl}) = _$ShoppingListItemImpl;

  factory _ShoppingListItem.fromJson(Map<String, dynamic> json) =
      _$ShoppingListItemImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  double get quantity;
  @override
  String get unit;
  @override
  String get category;
  @override
  bool get isCompleted;
  @override
  bool get isUrgent;
  @override
  double? get estimatedPrice;
  @override
  double? get actualPrice;
  @override
  String? get brand;
  @override
  String? get notes;
  @override
  String? get recipeId;
  @override
  String? get recipeName;
  @override
  DateTime? get addedAt;
  @override
  DateTime? get completedAt;
  @override
  String? get addedBy;
  @override
  String? get completedBy;
  @override
  List<String> get alternatives;
  @override
  String? get barcode;
  @override
  String? get imageUrl;

  /// Create a copy of ShoppingListItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShoppingListItemImplCopyWith<_$ShoppingListItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ShoppingListCategory _$ShoppingListCategoryFromJson(Map<String, dynamic> json) {
  return _ShoppingListCategory.fromJson(json);
}

/// @nodoc
mixin _$ShoppingListCategory {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get icon => throw _privateConstructorUsedError;
  String get color => throw _privateConstructorUsedError;
  int get sortOrder => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  List<String> get commonItems => throw _privateConstructorUsedError;
  List<String> get storeAisles => throw _privateConstructorUsedError;

  /// Serializes this ShoppingListCategory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ShoppingListCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShoppingListCategoryCopyWith<ShoppingListCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShoppingListCategoryCopyWith<$Res> {
  factory $ShoppingListCategoryCopyWith(ShoppingListCategory value,
          $Res Function(ShoppingListCategory) then) =
      _$ShoppingListCategoryCopyWithImpl<$Res, ShoppingListCategory>;
  @useResult
  $Res call(
      {String id,
      String name,
      String icon,
      String color,
      int sortOrder,
      String? description,
      List<String> commonItems,
      List<String> storeAisles});
}

/// @nodoc
class _$ShoppingListCategoryCopyWithImpl<$Res,
        $Val extends ShoppingListCategory>
    implements $ShoppingListCategoryCopyWith<$Res> {
  _$ShoppingListCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShoppingListCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? icon = null,
    Object? color = null,
    Object? sortOrder = null,
    Object? description = freezed,
    Object? commonItems = null,
    Object? storeAisles = null,
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
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      commonItems: null == commonItems
          ? _value.commonItems
          : commonItems // ignore: cast_nullable_to_non_nullable
              as List<String>,
      storeAisles: null == storeAisles
          ? _value.storeAisles
          : storeAisles // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ShoppingListCategoryImplCopyWith<$Res>
    implements $ShoppingListCategoryCopyWith<$Res> {
  factory _$$ShoppingListCategoryImplCopyWith(_$ShoppingListCategoryImpl value,
          $Res Function(_$ShoppingListCategoryImpl) then) =
      __$$ShoppingListCategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String icon,
      String color,
      int sortOrder,
      String? description,
      List<String> commonItems,
      List<String> storeAisles});
}

/// @nodoc
class __$$ShoppingListCategoryImplCopyWithImpl<$Res>
    extends _$ShoppingListCategoryCopyWithImpl<$Res, _$ShoppingListCategoryImpl>
    implements _$$ShoppingListCategoryImplCopyWith<$Res> {
  __$$ShoppingListCategoryImplCopyWithImpl(_$ShoppingListCategoryImpl _value,
      $Res Function(_$ShoppingListCategoryImpl) _then)
      : super(_value, _then);

  /// Create a copy of ShoppingListCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? icon = null,
    Object? color = null,
    Object? sortOrder = null,
    Object? description = freezed,
    Object? commonItems = null,
    Object? storeAisles = null,
  }) {
    return _then(_$ShoppingListCategoryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      commonItems: null == commonItems
          ? _value._commonItems
          : commonItems // ignore: cast_nullable_to_non_nullable
              as List<String>,
      storeAisles: null == storeAisles
          ? _value._storeAisles
          : storeAisles // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ShoppingListCategoryImpl implements _ShoppingListCategory {
  const _$ShoppingListCategoryImpl(
      {required this.id,
      required this.name,
      required this.icon,
      required this.color,
      this.sortOrder = 0,
      this.description,
      final List<String> commonItems = const [],
      final List<String> storeAisles = const []})
      : _commonItems = commonItems,
        _storeAisles = storeAisles;

  factory _$ShoppingListCategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShoppingListCategoryImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String icon;
  @override
  final String color;
  @override
  @JsonKey()
  final int sortOrder;
  @override
  final String? description;
  final List<String> _commonItems;
  @override
  @JsonKey()
  List<String> get commonItems {
    if (_commonItems is EqualUnmodifiableListView) return _commonItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_commonItems);
  }

  final List<String> _storeAisles;
  @override
  @JsonKey()
  List<String> get storeAisles {
    if (_storeAisles is EqualUnmodifiableListView) return _storeAisles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_storeAisles);
  }

  @override
  String toString() {
    return 'ShoppingListCategory(id: $id, name: $name, icon: $icon, color: $color, sortOrder: $sortOrder, description: $description, commonItems: $commonItems, storeAisles: $storeAisles)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShoppingListCategoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._commonItems, _commonItems) &&
            const DeepCollectionEquality()
                .equals(other._storeAisles, _storeAisles));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      icon,
      color,
      sortOrder,
      description,
      const DeepCollectionEquality().hash(_commonItems),
      const DeepCollectionEquality().hash(_storeAisles));

  /// Create a copy of ShoppingListCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShoppingListCategoryImplCopyWith<_$ShoppingListCategoryImpl>
      get copyWith =>
          __$$ShoppingListCategoryImplCopyWithImpl<_$ShoppingListCategoryImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShoppingListCategoryImplToJson(
      this,
    );
  }
}

abstract class _ShoppingListCategory implements ShoppingListCategory {
  const factory _ShoppingListCategory(
      {required final String id,
      required final String name,
      required final String icon,
      required final String color,
      final int sortOrder,
      final String? description,
      final List<String> commonItems,
      final List<String> storeAisles}) = _$ShoppingListCategoryImpl;

  factory _ShoppingListCategory.fromJson(Map<String, dynamic> json) =
      _$ShoppingListCategoryImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get icon;
  @override
  String get color;
  @override
  int get sortOrder;
  @override
  String? get description;
  @override
  List<String> get commonItems;
  @override
  List<String> get storeAisles;

  /// Create a copy of ShoppingListCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShoppingListCategoryImplCopyWith<_$ShoppingListCategoryImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ShoppingListStats _$ShoppingListStatsFromJson(Map<String, dynamic> json) {
  return _ShoppingListStats.fromJson(json);
}

/// @nodoc
mixin _$ShoppingListStats {
  int get totalItems => throw _privateConstructorUsedError;
  int get completedItems => throw _privateConstructorUsedError;
  int get urgentItems => throw _privateConstructorUsedError;
  double get estimatedTotal => throw _privateConstructorUsedError;
  double get actualTotal => throw _privateConstructorUsedError;
  Map<String, int> get categoryDistribution =>
      throw _privateConstructorUsedError;
  DateTime get lastUpdated => throw _privateConstructorUsedError;
  int get collaborators => throw _privateConstructorUsedError;

  /// Serializes this ShoppingListStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ShoppingListStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShoppingListStatsCopyWith<ShoppingListStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShoppingListStatsCopyWith<$Res> {
  factory $ShoppingListStatsCopyWith(
          ShoppingListStats value, $Res Function(ShoppingListStats) then) =
      _$ShoppingListStatsCopyWithImpl<$Res, ShoppingListStats>;
  @useResult
  $Res call(
      {int totalItems,
      int completedItems,
      int urgentItems,
      double estimatedTotal,
      double actualTotal,
      Map<String, int> categoryDistribution,
      DateTime lastUpdated,
      int collaborators});
}

/// @nodoc
class _$ShoppingListStatsCopyWithImpl<$Res, $Val extends ShoppingListStats>
    implements $ShoppingListStatsCopyWith<$Res> {
  _$ShoppingListStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShoppingListStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalItems = null,
    Object? completedItems = null,
    Object? urgentItems = null,
    Object? estimatedTotal = null,
    Object? actualTotal = null,
    Object? categoryDistribution = null,
    Object? lastUpdated = null,
    Object? collaborators = null,
  }) {
    return _then(_value.copyWith(
      totalItems: null == totalItems
          ? _value.totalItems
          : totalItems // ignore: cast_nullable_to_non_nullable
              as int,
      completedItems: null == completedItems
          ? _value.completedItems
          : completedItems // ignore: cast_nullable_to_non_nullable
              as int,
      urgentItems: null == urgentItems
          ? _value.urgentItems
          : urgentItems // ignore: cast_nullable_to_non_nullable
              as int,
      estimatedTotal: null == estimatedTotal
          ? _value.estimatedTotal
          : estimatedTotal // ignore: cast_nullable_to_non_nullable
              as double,
      actualTotal: null == actualTotal
          ? _value.actualTotal
          : actualTotal // ignore: cast_nullable_to_non_nullable
              as double,
      categoryDistribution: null == categoryDistribution
          ? _value.categoryDistribution
          : categoryDistribution // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      collaborators: null == collaborators
          ? _value.collaborators
          : collaborators // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ShoppingListStatsImplCopyWith<$Res>
    implements $ShoppingListStatsCopyWith<$Res> {
  factory _$$ShoppingListStatsImplCopyWith(_$ShoppingListStatsImpl value,
          $Res Function(_$ShoppingListStatsImpl) then) =
      __$$ShoppingListStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int totalItems,
      int completedItems,
      int urgentItems,
      double estimatedTotal,
      double actualTotal,
      Map<String, int> categoryDistribution,
      DateTime lastUpdated,
      int collaborators});
}

/// @nodoc
class __$$ShoppingListStatsImplCopyWithImpl<$Res>
    extends _$ShoppingListStatsCopyWithImpl<$Res, _$ShoppingListStatsImpl>
    implements _$$ShoppingListStatsImplCopyWith<$Res> {
  __$$ShoppingListStatsImplCopyWithImpl(_$ShoppingListStatsImpl _value,
      $Res Function(_$ShoppingListStatsImpl) _then)
      : super(_value, _then);

  /// Create a copy of ShoppingListStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalItems = null,
    Object? completedItems = null,
    Object? urgentItems = null,
    Object? estimatedTotal = null,
    Object? actualTotal = null,
    Object? categoryDistribution = null,
    Object? lastUpdated = null,
    Object? collaborators = null,
  }) {
    return _then(_$ShoppingListStatsImpl(
      totalItems: null == totalItems
          ? _value.totalItems
          : totalItems // ignore: cast_nullable_to_non_nullable
              as int,
      completedItems: null == completedItems
          ? _value.completedItems
          : completedItems // ignore: cast_nullable_to_non_nullable
              as int,
      urgentItems: null == urgentItems
          ? _value.urgentItems
          : urgentItems // ignore: cast_nullable_to_non_nullable
              as int,
      estimatedTotal: null == estimatedTotal
          ? _value.estimatedTotal
          : estimatedTotal // ignore: cast_nullable_to_non_nullable
              as double,
      actualTotal: null == actualTotal
          ? _value.actualTotal
          : actualTotal // ignore: cast_nullable_to_non_nullable
              as double,
      categoryDistribution: null == categoryDistribution
          ? _value._categoryDistribution
          : categoryDistribution // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      collaborators: null == collaborators
          ? _value.collaborators
          : collaborators // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ShoppingListStatsImpl implements _ShoppingListStats {
  const _$ShoppingListStatsImpl(
      {required this.totalItems,
      required this.completedItems,
      required this.urgentItems,
      required this.estimatedTotal,
      required this.actualTotal,
      required final Map<String, int> categoryDistribution,
      required this.lastUpdated,
      this.collaborators = 0})
      : _categoryDistribution = categoryDistribution;

  factory _$ShoppingListStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShoppingListStatsImplFromJson(json);

  @override
  final int totalItems;
  @override
  final int completedItems;
  @override
  final int urgentItems;
  @override
  final double estimatedTotal;
  @override
  final double actualTotal;
  final Map<String, int> _categoryDistribution;
  @override
  Map<String, int> get categoryDistribution {
    if (_categoryDistribution is EqualUnmodifiableMapView)
      return _categoryDistribution;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_categoryDistribution);
  }

  @override
  final DateTime lastUpdated;
  @override
  @JsonKey()
  final int collaborators;

  @override
  String toString() {
    return 'ShoppingListStats(totalItems: $totalItems, completedItems: $completedItems, urgentItems: $urgentItems, estimatedTotal: $estimatedTotal, actualTotal: $actualTotal, categoryDistribution: $categoryDistribution, lastUpdated: $lastUpdated, collaborators: $collaborators)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShoppingListStatsImpl &&
            (identical(other.totalItems, totalItems) ||
                other.totalItems == totalItems) &&
            (identical(other.completedItems, completedItems) ||
                other.completedItems == completedItems) &&
            (identical(other.urgentItems, urgentItems) ||
                other.urgentItems == urgentItems) &&
            (identical(other.estimatedTotal, estimatedTotal) ||
                other.estimatedTotal == estimatedTotal) &&
            (identical(other.actualTotal, actualTotal) ||
                other.actualTotal == actualTotal) &&
            const DeepCollectionEquality()
                .equals(other._categoryDistribution, _categoryDistribution) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated) &&
            (identical(other.collaborators, collaborators) ||
                other.collaborators == collaborators));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalItems,
      completedItems,
      urgentItems,
      estimatedTotal,
      actualTotal,
      const DeepCollectionEquality().hash(_categoryDistribution),
      lastUpdated,
      collaborators);

  /// Create a copy of ShoppingListStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShoppingListStatsImplCopyWith<_$ShoppingListStatsImpl> get copyWith =>
      __$$ShoppingListStatsImplCopyWithImpl<_$ShoppingListStatsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShoppingListStatsImplToJson(
      this,
    );
  }
}

abstract class _ShoppingListStats implements ShoppingListStats {
  const factory _ShoppingListStats(
      {required final int totalItems,
      required final int completedItems,
      required final int urgentItems,
      required final double estimatedTotal,
      required final double actualTotal,
      required final Map<String, int> categoryDistribution,
      required final DateTime lastUpdated,
      final int collaborators}) = _$ShoppingListStatsImpl;

  factory _ShoppingListStats.fromJson(Map<String, dynamic> json) =
      _$ShoppingListStatsImpl.fromJson;

  @override
  int get totalItems;
  @override
  int get completedItems;
  @override
  int get urgentItems;
  @override
  double get estimatedTotal;
  @override
  double get actualTotal;
  @override
  Map<String, int> get categoryDistribution;
  @override
  DateTime get lastUpdated;
  @override
  int get collaborators;

  /// Create a copy of ShoppingListStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShoppingListStatsImplCopyWith<_$ShoppingListStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ShoppingListFilter _$ShoppingListFilterFromJson(Map<String, dynamic> json) {
  return _ShoppingListFilter.fromJson(json);
}

/// @nodoc
mixin _$ShoppingListFilter {
  List<String> get categories => throw _privateConstructorUsedError;
  bool get showCompletedOnly => throw _privateConstructorUsedError;
  bool get showUrgentOnly => throw _privateConstructorUsedError;
  bool get showMyItemsOnly => throw _privateConstructorUsedError;
  String? get searchQuery => throw _privateConstructorUsedError;
  String? get addedBy => throw _privateConstructorUsedError;
  DateTime? get addedAfter => throw _privateConstructorUsedError;
  DateTime? get addedBefore => throw _privateConstructorUsedError;

  /// Serializes this ShoppingListFilter to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ShoppingListFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShoppingListFilterCopyWith<ShoppingListFilter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShoppingListFilterCopyWith<$Res> {
  factory $ShoppingListFilterCopyWith(
          ShoppingListFilter value, $Res Function(ShoppingListFilter) then) =
      _$ShoppingListFilterCopyWithImpl<$Res, ShoppingListFilter>;
  @useResult
  $Res call(
      {List<String> categories,
      bool showCompletedOnly,
      bool showUrgentOnly,
      bool showMyItemsOnly,
      String? searchQuery,
      String? addedBy,
      DateTime? addedAfter,
      DateTime? addedBefore});
}

/// @nodoc
class _$ShoppingListFilterCopyWithImpl<$Res, $Val extends ShoppingListFilter>
    implements $ShoppingListFilterCopyWith<$Res> {
  _$ShoppingListFilterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShoppingListFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categories = null,
    Object? showCompletedOnly = null,
    Object? showUrgentOnly = null,
    Object? showMyItemsOnly = null,
    Object? searchQuery = freezed,
    Object? addedBy = freezed,
    Object? addedAfter = freezed,
    Object? addedBefore = freezed,
  }) {
    return _then(_value.copyWith(
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      showCompletedOnly: null == showCompletedOnly
          ? _value.showCompletedOnly
          : showCompletedOnly // ignore: cast_nullable_to_non_nullable
              as bool,
      showUrgentOnly: null == showUrgentOnly
          ? _value.showUrgentOnly
          : showUrgentOnly // ignore: cast_nullable_to_non_nullable
              as bool,
      showMyItemsOnly: null == showMyItemsOnly
          ? _value.showMyItemsOnly
          : showMyItemsOnly // ignore: cast_nullable_to_non_nullable
              as bool,
      searchQuery: freezed == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String?,
      addedBy: freezed == addedBy
          ? _value.addedBy
          : addedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      addedAfter: freezed == addedAfter
          ? _value.addedAfter
          : addedAfter // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      addedBefore: freezed == addedBefore
          ? _value.addedBefore
          : addedBefore // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ShoppingListFilterImplCopyWith<$Res>
    implements $ShoppingListFilterCopyWith<$Res> {
  factory _$$ShoppingListFilterImplCopyWith(_$ShoppingListFilterImpl value,
          $Res Function(_$ShoppingListFilterImpl) then) =
      __$$ShoppingListFilterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String> categories,
      bool showCompletedOnly,
      bool showUrgentOnly,
      bool showMyItemsOnly,
      String? searchQuery,
      String? addedBy,
      DateTime? addedAfter,
      DateTime? addedBefore});
}

/// @nodoc
class __$$ShoppingListFilterImplCopyWithImpl<$Res>
    extends _$ShoppingListFilterCopyWithImpl<$Res, _$ShoppingListFilterImpl>
    implements _$$ShoppingListFilterImplCopyWith<$Res> {
  __$$ShoppingListFilterImplCopyWithImpl(_$ShoppingListFilterImpl _value,
      $Res Function(_$ShoppingListFilterImpl) _then)
      : super(_value, _then);

  /// Create a copy of ShoppingListFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categories = null,
    Object? showCompletedOnly = null,
    Object? showUrgentOnly = null,
    Object? showMyItemsOnly = null,
    Object? searchQuery = freezed,
    Object? addedBy = freezed,
    Object? addedAfter = freezed,
    Object? addedBefore = freezed,
  }) {
    return _then(_$ShoppingListFilterImpl(
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      showCompletedOnly: null == showCompletedOnly
          ? _value.showCompletedOnly
          : showCompletedOnly // ignore: cast_nullable_to_non_nullable
              as bool,
      showUrgentOnly: null == showUrgentOnly
          ? _value.showUrgentOnly
          : showUrgentOnly // ignore: cast_nullable_to_non_nullable
              as bool,
      showMyItemsOnly: null == showMyItemsOnly
          ? _value.showMyItemsOnly
          : showMyItemsOnly // ignore: cast_nullable_to_non_nullable
              as bool,
      searchQuery: freezed == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String?,
      addedBy: freezed == addedBy
          ? _value.addedBy
          : addedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      addedAfter: freezed == addedAfter
          ? _value.addedAfter
          : addedAfter // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      addedBefore: freezed == addedBefore
          ? _value.addedBefore
          : addedBefore // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ShoppingListFilterImpl implements _ShoppingListFilter {
  const _$ShoppingListFilterImpl(
      {final List<String> categories = const [],
      this.showCompletedOnly = false,
      this.showUrgentOnly = false,
      this.showMyItemsOnly = false,
      this.searchQuery,
      this.addedBy,
      this.addedAfter,
      this.addedBefore})
      : _categories = categories;

  factory _$ShoppingListFilterImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShoppingListFilterImplFromJson(json);

  final List<String> _categories;
  @override
  @JsonKey()
  List<String> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  @override
  @JsonKey()
  final bool showCompletedOnly;
  @override
  @JsonKey()
  final bool showUrgentOnly;
  @override
  @JsonKey()
  final bool showMyItemsOnly;
  @override
  final String? searchQuery;
  @override
  final String? addedBy;
  @override
  final DateTime? addedAfter;
  @override
  final DateTime? addedBefore;

  @override
  String toString() {
    return 'ShoppingListFilter(categories: $categories, showCompletedOnly: $showCompletedOnly, showUrgentOnly: $showUrgentOnly, showMyItemsOnly: $showMyItemsOnly, searchQuery: $searchQuery, addedBy: $addedBy, addedAfter: $addedAfter, addedBefore: $addedBefore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShoppingListFilterImpl &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            (identical(other.showCompletedOnly, showCompletedOnly) ||
                other.showCompletedOnly == showCompletedOnly) &&
            (identical(other.showUrgentOnly, showUrgentOnly) ||
                other.showUrgentOnly == showUrgentOnly) &&
            (identical(other.showMyItemsOnly, showMyItemsOnly) ||
                other.showMyItemsOnly == showMyItemsOnly) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.addedBy, addedBy) || other.addedBy == addedBy) &&
            (identical(other.addedAfter, addedAfter) ||
                other.addedAfter == addedAfter) &&
            (identical(other.addedBefore, addedBefore) ||
                other.addedBefore == addedBefore));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_categories),
      showCompletedOnly,
      showUrgentOnly,
      showMyItemsOnly,
      searchQuery,
      addedBy,
      addedAfter,
      addedBefore);

  /// Create a copy of ShoppingListFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShoppingListFilterImplCopyWith<_$ShoppingListFilterImpl> get copyWith =>
      __$$ShoppingListFilterImplCopyWithImpl<_$ShoppingListFilterImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShoppingListFilterImplToJson(
      this,
    );
  }
}

abstract class _ShoppingListFilter implements ShoppingListFilter {
  const factory _ShoppingListFilter(
      {final List<String> categories,
      final bool showCompletedOnly,
      final bool showUrgentOnly,
      final bool showMyItemsOnly,
      final String? searchQuery,
      final String? addedBy,
      final DateTime? addedAfter,
      final DateTime? addedBefore}) = _$ShoppingListFilterImpl;

  factory _ShoppingListFilter.fromJson(Map<String, dynamic> json) =
      _$ShoppingListFilterImpl.fromJson;

  @override
  List<String> get categories;
  @override
  bool get showCompletedOnly;
  @override
  bool get showUrgentOnly;
  @override
  bool get showMyItemsOnly;
  @override
  String? get searchQuery;
  @override
  String? get addedBy;
  @override
  DateTime? get addedAfter;
  @override
  DateTime? get addedBefore;

  /// Create a copy of ShoppingListFilter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShoppingListFilterImplCopyWith<_$ShoppingListFilterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ShoppingListTemplate _$ShoppingListTemplateFromJson(Map<String, dynamic> json) {
  return _ShoppingListTemplate.fromJson(json);
}

/// @nodoc
mixin _$ShoppingListTemplate {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<ShoppingListItem> get items => throw _privateConstructorUsedError;
  String get createdBy => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  bool get isPublic => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  int get usageCount => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;

  /// Serializes this ShoppingListTemplate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ShoppingListTemplate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShoppingListTemplateCopyWith<ShoppingListTemplate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShoppingListTemplateCopyWith<$Res> {
  factory $ShoppingListTemplateCopyWith(ShoppingListTemplate value,
          $Res Function(ShoppingListTemplate) then) =
      _$ShoppingListTemplateCopyWithImpl<$Res, ShoppingListTemplate>;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      List<ShoppingListItem> items,
      String createdBy,
      DateTime createdAt,
      bool isPublic,
      List<String> tags,
      int usageCount,
      double rating});
}

/// @nodoc
class _$ShoppingListTemplateCopyWithImpl<$Res,
        $Val extends ShoppingListTemplate>
    implements $ShoppingListTemplateCopyWith<$Res> {
  _$ShoppingListTemplateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShoppingListTemplate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? items = null,
    Object? createdBy = null,
    Object? createdAt = null,
    Object? isPublic = null,
    Object? tags = null,
    Object? usageCount = null,
    Object? rating = null,
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
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ShoppingListItem>,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isPublic: null == isPublic
          ? _value.isPublic
          : isPublic // ignore: cast_nullable_to_non_nullable
              as bool,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      usageCount: null == usageCount
          ? _value.usageCount
          : usageCount // ignore: cast_nullable_to_non_nullable
              as int,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ShoppingListTemplateImplCopyWith<$Res>
    implements $ShoppingListTemplateCopyWith<$Res> {
  factory _$$ShoppingListTemplateImplCopyWith(_$ShoppingListTemplateImpl value,
          $Res Function(_$ShoppingListTemplateImpl) then) =
      __$$ShoppingListTemplateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      List<ShoppingListItem> items,
      String createdBy,
      DateTime createdAt,
      bool isPublic,
      List<String> tags,
      int usageCount,
      double rating});
}

/// @nodoc
class __$$ShoppingListTemplateImplCopyWithImpl<$Res>
    extends _$ShoppingListTemplateCopyWithImpl<$Res, _$ShoppingListTemplateImpl>
    implements _$$ShoppingListTemplateImplCopyWith<$Res> {
  __$$ShoppingListTemplateImplCopyWithImpl(_$ShoppingListTemplateImpl _value,
      $Res Function(_$ShoppingListTemplateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ShoppingListTemplate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? items = null,
    Object? createdBy = null,
    Object? createdAt = null,
    Object? isPublic = null,
    Object? tags = null,
    Object? usageCount = null,
    Object? rating = null,
  }) {
    return _then(_$ShoppingListTemplateImpl(
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
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ShoppingListItem>,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isPublic: null == isPublic
          ? _value.isPublic
          : isPublic // ignore: cast_nullable_to_non_nullable
              as bool,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      usageCount: null == usageCount
          ? _value.usageCount
          : usageCount // ignore: cast_nullable_to_non_nullable
              as int,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ShoppingListTemplateImpl implements _ShoppingListTemplate {
  const _$ShoppingListTemplateImpl(
      {required this.id,
      required this.name,
      required this.description,
      required final List<ShoppingListItem> items,
      required this.createdBy,
      required this.createdAt,
      this.isPublic = false,
      final List<String> tags = const [],
      this.usageCount = 0,
      this.rating = 0.0})
      : _items = items,
        _tags = tags;

  factory _$ShoppingListTemplateImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShoppingListTemplateImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  final List<ShoppingListItem> _items;
  @override
  List<ShoppingListItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final String createdBy;
  @override
  final DateTime createdAt;
  @override
  @JsonKey()
  final bool isPublic;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  @JsonKey()
  final int usageCount;
  @override
  @JsonKey()
  final double rating;

  @override
  String toString() {
    return 'ShoppingListTemplate(id: $id, name: $name, description: $description, items: $items, createdBy: $createdBy, createdAt: $createdAt, isPublic: $isPublic, tags: $tags, usageCount: $usageCount, rating: $rating)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShoppingListTemplateImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isPublic, isPublic) ||
                other.isPublic == isPublic) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.usageCount, usageCount) ||
                other.usageCount == usageCount) &&
            (identical(other.rating, rating) || other.rating == rating));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      const DeepCollectionEquality().hash(_items),
      createdBy,
      createdAt,
      isPublic,
      const DeepCollectionEquality().hash(_tags),
      usageCount,
      rating);

  /// Create a copy of ShoppingListTemplate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShoppingListTemplateImplCopyWith<_$ShoppingListTemplateImpl>
      get copyWith =>
          __$$ShoppingListTemplateImplCopyWithImpl<_$ShoppingListTemplateImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShoppingListTemplateImplToJson(
      this,
    );
  }
}

abstract class _ShoppingListTemplate implements ShoppingListTemplate {
  const factory _ShoppingListTemplate(
      {required final String id,
      required final String name,
      required final String description,
      required final List<ShoppingListItem> items,
      required final String createdBy,
      required final DateTime createdAt,
      final bool isPublic,
      final List<String> tags,
      final int usageCount,
      final double rating}) = _$ShoppingListTemplateImpl;

  factory _ShoppingListTemplate.fromJson(Map<String, dynamic> json) =
      _$ShoppingListTemplateImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  List<ShoppingListItem> get items;
  @override
  String get createdBy;
  @override
  DateTime get createdAt;
  @override
  bool get isPublic;
  @override
  List<String> get tags;
  @override
  int get usageCount;
  @override
  double get rating;

  /// Create a copy of ShoppingListTemplate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShoppingListTemplateImplCopyWith<_$ShoppingListTemplateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
