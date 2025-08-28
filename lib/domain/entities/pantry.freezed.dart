// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pantry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PantryItem _$PantryItemFromJson(Map<String, dynamic> json) {
  return _PantryItem.fromJson(json);
}

/// @nodoc
mixin _$PantryItem {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get name => throw _privateConstructorUsedError;
  @HiveField(2)
  double get quantity => throw _privateConstructorUsedError;
  @HiveField(3)
  String get unit => throw _privateConstructorUsedError;
  @HiveField(4)
  String? get category => throw _privateConstructorUsedError;
  @HiveField(5)
  DateTime? get expiryDate => throw _privateConstructorUsedError;
  @HiveField(6)
  DateTime? get purchaseDate => throw _privateConstructorUsedError;
  @HiveField(7)
  DateTime get lastUpdated => throw _privateConstructorUsedError;
  @HiveField(8)
  String? get location =>
      throw _privateConstructorUsedError; // Fridge, Pantry, Freezer, etc.
  @HiveField(9)
  String? get brand => throw _privateConstructorUsedError;
  @HiveField(10)
  double? get cost => throw _privateConstructorUsedError;
  @HiveField(11)
  String? get barcode => throw _privateConstructorUsedError;
  @HiveField(12)
  PantryItemStatus get status => throw _privateConstructorUsedError;
  @HiveField(13)
  String? get notes => throw _privateConstructorUsedError;
  @HiveField(14)
  List<String> get tags => throw _privateConstructorUsedError;
  @HiveField(15)
  String? get imageUrl => throw _privateConstructorUsedError;

  /// Serializes this PantryItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PantryItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PantryItemCopyWith<PantryItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PantryItemCopyWith<$Res> {
  factory $PantryItemCopyWith(
          PantryItem value, $Res Function(PantryItem) then) =
      _$PantryItemCopyWithImpl<$Res, PantryItem>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String name,
      @HiveField(2) double quantity,
      @HiveField(3) String unit,
      @HiveField(4) String? category,
      @HiveField(5) DateTime? expiryDate,
      @HiveField(6) DateTime? purchaseDate,
      @HiveField(7) DateTime lastUpdated,
      @HiveField(8) String? location,
      @HiveField(9) String? brand,
      @HiveField(10) double? cost,
      @HiveField(11) String? barcode,
      @HiveField(12) PantryItemStatus status,
      @HiveField(13) String? notes,
      @HiveField(14) List<String> tags,
      @HiveField(15) String? imageUrl});
}

/// @nodoc
class _$PantryItemCopyWithImpl<$Res, $Val extends PantryItem>
    implements $PantryItemCopyWith<$Res> {
  _$PantryItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PantryItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? quantity = null,
    Object? unit = null,
    Object? category = freezed,
    Object? expiryDate = freezed,
    Object? purchaseDate = freezed,
    Object? lastUpdated = null,
    Object? location = freezed,
    Object? brand = freezed,
    Object? cost = freezed,
    Object? barcode = freezed,
    Object? status = null,
    Object? notes = freezed,
    Object? tags = null,
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
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      expiryDate: freezed == expiryDate
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      purchaseDate: freezed == purchaseDate
          ? _value.purchaseDate
          : purchaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      brand: freezed == brand
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String?,
      cost: freezed == cost
          ? _value.cost
          : cost // ignore: cast_nullable_to_non_nullable
              as double?,
      barcode: freezed == barcode
          ? _value.barcode
          : barcode // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PantryItemStatus,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
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
}

/// @nodoc
abstract class _$$PantryItemImplCopyWith<$Res>
    implements $PantryItemCopyWith<$Res> {
  factory _$$PantryItemImplCopyWith(
          _$PantryItemImpl value, $Res Function(_$PantryItemImpl) then) =
      __$$PantryItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String name,
      @HiveField(2) double quantity,
      @HiveField(3) String unit,
      @HiveField(4) String? category,
      @HiveField(5) DateTime? expiryDate,
      @HiveField(6) DateTime? purchaseDate,
      @HiveField(7) DateTime lastUpdated,
      @HiveField(8) String? location,
      @HiveField(9) String? brand,
      @HiveField(10) double? cost,
      @HiveField(11) String? barcode,
      @HiveField(12) PantryItemStatus status,
      @HiveField(13) String? notes,
      @HiveField(14) List<String> tags,
      @HiveField(15) String? imageUrl});
}

/// @nodoc
class __$$PantryItemImplCopyWithImpl<$Res>
    extends _$PantryItemCopyWithImpl<$Res, _$PantryItemImpl>
    implements _$$PantryItemImplCopyWith<$Res> {
  __$$PantryItemImplCopyWithImpl(
      _$PantryItemImpl _value, $Res Function(_$PantryItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of PantryItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? quantity = null,
    Object? unit = null,
    Object? category = freezed,
    Object? expiryDate = freezed,
    Object? purchaseDate = freezed,
    Object? lastUpdated = null,
    Object? location = freezed,
    Object? brand = freezed,
    Object? cost = freezed,
    Object? barcode = freezed,
    Object? status = null,
    Object? notes = freezed,
    Object? tags = null,
    Object? imageUrl = freezed,
  }) {
    return _then(_$PantryItemImpl(
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
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      expiryDate: freezed == expiryDate
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      purchaseDate: freezed == purchaseDate
          ? _value.purchaseDate
          : purchaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      brand: freezed == brand
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String?,
      cost: freezed == cost
          ? _value.cost
          : cost // ignore: cast_nullable_to_non_nullable
              as double?,
      barcode: freezed == barcode
          ? _value.barcode
          : barcode // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PantryItemStatus,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
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
class _$PantryItemImpl implements _PantryItem {
  const _$PantryItemImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.name,
      @HiveField(2) required this.quantity,
      @HiveField(3) required this.unit,
      @HiveField(4) this.category,
      @HiveField(5) this.expiryDate,
      @HiveField(6) this.purchaseDate,
      @HiveField(7) required this.lastUpdated,
      @HiveField(8) this.location,
      @HiveField(9) this.brand,
      @HiveField(10) this.cost,
      @HiveField(11) this.barcode,
      @HiveField(12) this.status = PantryItemStatus.available,
      @HiveField(13) this.notes,
      @HiveField(14) final List<String> tags = const [],
      @HiveField(15) this.imageUrl})
      : _tags = tags;

  factory _$PantryItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$PantryItemImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String name;
  @override
  @HiveField(2)
  final double quantity;
  @override
  @HiveField(3)
  final String unit;
  @override
  @HiveField(4)
  final String? category;
  @override
  @HiveField(5)
  final DateTime? expiryDate;
  @override
  @HiveField(6)
  final DateTime? purchaseDate;
  @override
  @HiveField(7)
  final DateTime lastUpdated;
  @override
  @HiveField(8)
  final String? location;
// Fridge, Pantry, Freezer, etc.
  @override
  @HiveField(9)
  final String? brand;
  @override
  @HiveField(10)
  final double? cost;
  @override
  @HiveField(11)
  final String? barcode;
  @override
  @JsonKey()
  @HiveField(12)
  final PantryItemStatus status;
  @override
  @HiveField(13)
  final String? notes;
  final List<String> _tags;
  @override
  @JsonKey()
  @HiveField(14)
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  @HiveField(15)
  final String? imageUrl;

  @override
  String toString() {
    return 'PantryItem(id: $id, name: $name, quantity: $quantity, unit: $unit, category: $category, expiryDate: $expiryDate, purchaseDate: $purchaseDate, lastUpdated: $lastUpdated, location: $location, brand: $brand, cost: $cost, barcode: $barcode, status: $status, notes: $notes, tags: $tags, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PantryItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.expiryDate, expiryDate) ||
                other.expiryDate == expiryDate) &&
            (identical(other.purchaseDate, purchaseDate) ||
                other.purchaseDate == purchaseDate) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.cost, cost) || other.cost == cost) &&
            (identical(other.barcode, barcode) || other.barcode == barcode) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      quantity,
      unit,
      category,
      expiryDate,
      purchaseDate,
      lastUpdated,
      location,
      brand,
      cost,
      barcode,
      status,
      notes,
      const DeepCollectionEquality().hash(_tags),
      imageUrl);

  /// Create a copy of PantryItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PantryItemImplCopyWith<_$PantryItemImpl> get copyWith =>
      __$$PantryItemImplCopyWithImpl<_$PantryItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PantryItemImplToJson(
      this,
    );
  }
}

abstract class _PantryItem implements PantryItem {
  const factory _PantryItem(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String name,
      @HiveField(2) required final double quantity,
      @HiveField(3) required final String unit,
      @HiveField(4) final String? category,
      @HiveField(5) final DateTime? expiryDate,
      @HiveField(6) final DateTime? purchaseDate,
      @HiveField(7) required final DateTime lastUpdated,
      @HiveField(8) final String? location,
      @HiveField(9) final String? brand,
      @HiveField(10) final double? cost,
      @HiveField(11) final String? barcode,
      @HiveField(12) final PantryItemStatus status,
      @HiveField(13) final String? notes,
      @HiveField(14) final List<String> tags,
      @HiveField(15) final String? imageUrl}) = _$PantryItemImpl;

  factory _PantryItem.fromJson(Map<String, dynamic> json) =
      _$PantryItemImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get name;
  @override
  @HiveField(2)
  double get quantity;
  @override
  @HiveField(3)
  String get unit;
  @override
  @HiveField(4)
  String? get category;
  @override
  @HiveField(5)
  DateTime? get expiryDate;
  @override
  @HiveField(6)
  DateTime? get purchaseDate;
  @override
  @HiveField(7)
  DateTime get lastUpdated;
  @override
  @HiveField(8)
  String? get location; // Fridge, Pantry, Freezer, etc.
  @override
  @HiveField(9)
  String? get brand;
  @override
  @HiveField(10)
  double? get cost;
  @override
  @HiveField(11)
  String? get barcode;
  @override
  @HiveField(12)
  PantryItemStatus get status;
  @override
  @HiveField(13)
  String? get notes;
  @override
  @HiveField(14)
  List<String> get tags;
  @override
  @HiveField(15)
  String? get imageUrl;

  /// Create a copy of PantryItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PantryItemImplCopyWith<_$PantryItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PantryCategory _$PantryCategoryFromJson(Map<String, dynamic> json) {
  return _PantryCategory.fromJson(json);
}

/// @nodoc
mixin _$PantryCategory {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get name => throw _privateConstructorUsedError;
  @HiveField(2)
  String? get description => throw _privateConstructorUsedError;
  @HiveField(3)
  String? get iconName => throw _privateConstructorUsedError;
  @HiveField(4)
  String? get color => throw _privateConstructorUsedError;
  @HiveField(5)
  List<String> get itemIds => throw _privateConstructorUsedError;
  @HiveField(6)
  int get sortOrder => throw _privateConstructorUsedError;

  /// Serializes this PantryCategory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PantryCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PantryCategoryCopyWith<PantryCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PantryCategoryCopyWith<$Res> {
  factory $PantryCategoryCopyWith(
          PantryCategory value, $Res Function(PantryCategory) then) =
      _$PantryCategoryCopyWithImpl<$Res, PantryCategory>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String name,
      @HiveField(2) String? description,
      @HiveField(3) String? iconName,
      @HiveField(4) String? color,
      @HiveField(5) List<String> itemIds,
      @HiveField(6) int sortOrder});
}

/// @nodoc
class _$PantryCategoryCopyWithImpl<$Res, $Val extends PantryCategory>
    implements $PantryCategoryCopyWith<$Res> {
  _$PantryCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PantryCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? iconName = freezed,
    Object? color = freezed,
    Object? itemIds = null,
    Object? sortOrder = null,
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
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      iconName: freezed == iconName
          ? _value.iconName
          : iconName // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      itemIds: null == itemIds
          ? _value.itemIds
          : itemIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PantryCategoryImplCopyWith<$Res>
    implements $PantryCategoryCopyWith<$Res> {
  factory _$$PantryCategoryImplCopyWith(_$PantryCategoryImpl value,
          $Res Function(_$PantryCategoryImpl) then) =
      __$$PantryCategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String name,
      @HiveField(2) String? description,
      @HiveField(3) String? iconName,
      @HiveField(4) String? color,
      @HiveField(5) List<String> itemIds,
      @HiveField(6) int sortOrder});
}

/// @nodoc
class __$$PantryCategoryImplCopyWithImpl<$Res>
    extends _$PantryCategoryCopyWithImpl<$Res, _$PantryCategoryImpl>
    implements _$$PantryCategoryImplCopyWith<$Res> {
  __$$PantryCategoryImplCopyWithImpl(
      _$PantryCategoryImpl _value, $Res Function(_$PantryCategoryImpl) _then)
      : super(_value, _then);

  /// Create a copy of PantryCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? iconName = freezed,
    Object? color = freezed,
    Object? itemIds = null,
    Object? sortOrder = null,
  }) {
    return _then(_$PantryCategoryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      iconName: freezed == iconName
          ? _value.iconName
          : iconName // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      itemIds: null == itemIds
          ? _value._itemIds
          : itemIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PantryCategoryImpl implements _PantryCategory {
  const _$PantryCategoryImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.name,
      @HiveField(2) this.description,
      @HiveField(3) this.iconName,
      @HiveField(4) this.color,
      @HiveField(5) final List<String> itemIds = const [],
      @HiveField(6) this.sortOrder = 0})
      : _itemIds = itemIds;

  factory _$PantryCategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$PantryCategoryImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String name;
  @override
  @HiveField(2)
  final String? description;
  @override
  @HiveField(3)
  final String? iconName;
  @override
  @HiveField(4)
  final String? color;
  final List<String> _itemIds;
  @override
  @JsonKey()
  @HiveField(5)
  List<String> get itemIds {
    if (_itemIds is EqualUnmodifiableListView) return _itemIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_itemIds);
  }

  @override
  @JsonKey()
  @HiveField(6)
  final int sortOrder;

  @override
  String toString() {
    return 'PantryCategory(id: $id, name: $name, description: $description, iconName: $iconName, color: $color, itemIds: $itemIds, sortOrder: $sortOrder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PantryCategoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.iconName, iconName) ||
                other.iconName == iconName) &&
            (identical(other.color, color) || other.color == color) &&
            const DeepCollectionEquality().equals(other._itemIds, _itemIds) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description, iconName,
      color, const DeepCollectionEquality().hash(_itemIds), sortOrder);

  /// Create a copy of PantryCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PantryCategoryImplCopyWith<_$PantryCategoryImpl> get copyWith =>
      __$$PantryCategoryImplCopyWithImpl<_$PantryCategoryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PantryCategoryImplToJson(
      this,
    );
  }
}

abstract class _PantryCategory implements PantryCategory {
  const factory _PantryCategory(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String name,
      @HiveField(2) final String? description,
      @HiveField(3) final String? iconName,
      @HiveField(4) final String? color,
      @HiveField(5) final List<String> itemIds,
      @HiveField(6) final int sortOrder}) = _$PantryCategoryImpl;

  factory _PantryCategory.fromJson(Map<String, dynamic> json) =
      _$PantryCategoryImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get name;
  @override
  @HiveField(2)
  String? get description;
  @override
  @HiveField(3)
  String? get iconName;
  @override
  @HiveField(4)
  String? get color;
  @override
  @HiveField(5)
  List<String> get itemIds;
  @override
  @HiveField(6)
  int get sortOrder;

  /// Create a copy of PantryCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PantryCategoryImplCopyWith<_$PantryCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

InventoryAlert _$InventoryAlertFromJson(Map<String, dynamic> json) {
  return _InventoryAlert.fromJson(json);
}

/// @nodoc
mixin _$InventoryAlert {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get pantryItemId => throw _privateConstructorUsedError;
  @HiveField(2)
  AlertType get type => throw _privateConstructorUsedError;
  @HiveField(3)
  String get message => throw _privateConstructorUsedError;
  @HiveField(4)
  DateTime get createdAt => throw _privateConstructorUsedError;
  @HiveField(5)
  bool get isRead => throw _privateConstructorUsedError;
  @HiveField(6)
  AlertPriority get priority => throw _privateConstructorUsedError;
  @HiveField(7)
  DateTime? get actionDate => throw _privateConstructorUsedError;
  @HiveField(8)
  String? get actionTaken => throw _privateConstructorUsedError;

  /// Serializes this InventoryAlert to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InventoryAlert
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InventoryAlertCopyWith<InventoryAlert> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InventoryAlertCopyWith<$Res> {
  factory $InventoryAlertCopyWith(
          InventoryAlert value, $Res Function(InventoryAlert) then) =
      _$InventoryAlertCopyWithImpl<$Res, InventoryAlert>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String pantryItemId,
      @HiveField(2) AlertType type,
      @HiveField(3) String message,
      @HiveField(4) DateTime createdAt,
      @HiveField(5) bool isRead,
      @HiveField(6) AlertPriority priority,
      @HiveField(7) DateTime? actionDate,
      @HiveField(8) String? actionTaken});
}

/// @nodoc
class _$InventoryAlertCopyWithImpl<$Res, $Val extends InventoryAlert>
    implements $InventoryAlertCopyWith<$Res> {
  _$InventoryAlertCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InventoryAlert
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? pantryItemId = null,
    Object? type = null,
    Object? message = null,
    Object? createdAt = null,
    Object? isRead = null,
    Object? priority = null,
    Object? actionDate = freezed,
    Object? actionTaken = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      pantryItemId: null == pantryItemId
          ? _value.pantryItemId
          : pantryItemId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as AlertType,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isRead: null == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as AlertPriority,
      actionDate: freezed == actionDate
          ? _value.actionDate
          : actionDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      actionTaken: freezed == actionTaken
          ? _value.actionTaken
          : actionTaken // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InventoryAlertImplCopyWith<$Res>
    implements $InventoryAlertCopyWith<$Res> {
  factory _$$InventoryAlertImplCopyWith(_$InventoryAlertImpl value,
          $Res Function(_$InventoryAlertImpl) then) =
      __$$InventoryAlertImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String pantryItemId,
      @HiveField(2) AlertType type,
      @HiveField(3) String message,
      @HiveField(4) DateTime createdAt,
      @HiveField(5) bool isRead,
      @HiveField(6) AlertPriority priority,
      @HiveField(7) DateTime? actionDate,
      @HiveField(8) String? actionTaken});
}

/// @nodoc
class __$$InventoryAlertImplCopyWithImpl<$Res>
    extends _$InventoryAlertCopyWithImpl<$Res, _$InventoryAlertImpl>
    implements _$$InventoryAlertImplCopyWith<$Res> {
  __$$InventoryAlertImplCopyWithImpl(
      _$InventoryAlertImpl _value, $Res Function(_$InventoryAlertImpl) _then)
      : super(_value, _then);

  /// Create a copy of InventoryAlert
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? pantryItemId = null,
    Object? type = null,
    Object? message = null,
    Object? createdAt = null,
    Object? isRead = null,
    Object? priority = null,
    Object? actionDate = freezed,
    Object? actionTaken = freezed,
  }) {
    return _then(_$InventoryAlertImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      pantryItemId: null == pantryItemId
          ? _value.pantryItemId
          : pantryItemId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as AlertType,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isRead: null == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as AlertPriority,
      actionDate: freezed == actionDate
          ? _value.actionDate
          : actionDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      actionTaken: freezed == actionTaken
          ? _value.actionTaken
          : actionTaken // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InventoryAlertImpl implements _InventoryAlert {
  const _$InventoryAlertImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.pantryItemId,
      @HiveField(2) required this.type,
      @HiveField(3) required this.message,
      @HiveField(4) required this.createdAt,
      @HiveField(5) this.isRead = false,
      @HiveField(6) this.priority = AlertPriority.medium,
      @HiveField(7) this.actionDate,
      @HiveField(8) this.actionTaken});

  factory _$InventoryAlertImpl.fromJson(Map<String, dynamic> json) =>
      _$$InventoryAlertImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String pantryItemId;
  @override
  @HiveField(2)
  final AlertType type;
  @override
  @HiveField(3)
  final String message;
  @override
  @HiveField(4)
  final DateTime createdAt;
  @override
  @JsonKey()
  @HiveField(5)
  final bool isRead;
  @override
  @JsonKey()
  @HiveField(6)
  final AlertPriority priority;
  @override
  @HiveField(7)
  final DateTime? actionDate;
  @override
  @HiveField(8)
  final String? actionTaken;

  @override
  String toString() {
    return 'InventoryAlert(id: $id, pantryItemId: $pantryItemId, type: $type, message: $message, createdAt: $createdAt, isRead: $isRead, priority: $priority, actionDate: $actionDate, actionTaken: $actionTaken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventoryAlertImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.pantryItemId, pantryItemId) ||
                other.pantryItemId == pantryItemId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.actionDate, actionDate) ||
                other.actionDate == actionDate) &&
            (identical(other.actionTaken, actionTaken) ||
                other.actionTaken == actionTaken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, pantryItemId, type, message,
      createdAt, isRead, priority, actionDate, actionTaken);

  /// Create a copy of InventoryAlert
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InventoryAlertImplCopyWith<_$InventoryAlertImpl> get copyWith =>
      __$$InventoryAlertImplCopyWithImpl<_$InventoryAlertImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InventoryAlertImplToJson(
      this,
    );
  }
}

abstract class _InventoryAlert implements InventoryAlert {
  const factory _InventoryAlert(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String pantryItemId,
      @HiveField(2) required final AlertType type,
      @HiveField(3) required final String message,
      @HiveField(4) required final DateTime createdAt,
      @HiveField(5) final bool isRead,
      @HiveField(6) final AlertPriority priority,
      @HiveField(7) final DateTime? actionDate,
      @HiveField(8) final String? actionTaken}) = _$InventoryAlertImpl;

  factory _InventoryAlert.fromJson(Map<String, dynamic> json) =
      _$InventoryAlertImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get pantryItemId;
  @override
  @HiveField(2)
  AlertType get type;
  @override
  @HiveField(3)
  String get message;
  @override
  @HiveField(4)
  DateTime get createdAt;
  @override
  @HiveField(5)
  bool get isRead;
  @override
  @HiveField(6)
  AlertPriority get priority;
  @override
  @HiveField(7)
  DateTime? get actionDate;
  @override
  @HiveField(8)
  String? get actionTaken;

  /// Create a copy of InventoryAlert
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InventoryAlertImplCopyWith<_$InventoryAlertImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PantryUsage _$PantryUsageFromJson(Map<String, dynamic> json) {
  return _PantryUsage.fromJson(json);
}

/// @nodoc
mixin _$PantryUsage {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get pantryItemId => throw _privateConstructorUsedError;
  @HiveField(2)
  double get quantityUsed => throw _privateConstructorUsedError;
  @HiveField(3)
  DateTime get usedAt => throw _privateConstructorUsedError;
  @HiveField(4)
  String? get recipeId => throw _privateConstructorUsedError;
  @HiveField(5)
  String? get notes => throw _privateConstructorUsedError;
  @HiveField(6)
  UsageType get usageType => throw _privateConstructorUsedError;

  /// Serializes this PantryUsage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PantryUsage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PantryUsageCopyWith<PantryUsage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PantryUsageCopyWith<$Res> {
  factory $PantryUsageCopyWith(
          PantryUsage value, $Res Function(PantryUsage) then) =
      _$PantryUsageCopyWithImpl<$Res, PantryUsage>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String pantryItemId,
      @HiveField(2) double quantityUsed,
      @HiveField(3) DateTime usedAt,
      @HiveField(4) String? recipeId,
      @HiveField(5) String? notes,
      @HiveField(6) UsageType usageType});
}

/// @nodoc
class _$PantryUsageCopyWithImpl<$Res, $Val extends PantryUsage>
    implements $PantryUsageCopyWith<$Res> {
  _$PantryUsageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PantryUsage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? pantryItemId = null,
    Object? quantityUsed = null,
    Object? usedAt = null,
    Object? recipeId = freezed,
    Object? notes = freezed,
    Object? usageType = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      pantryItemId: null == pantryItemId
          ? _value.pantryItemId
          : pantryItemId // ignore: cast_nullable_to_non_nullable
              as String,
      quantityUsed: null == quantityUsed
          ? _value.quantityUsed
          : quantityUsed // ignore: cast_nullable_to_non_nullable
              as double,
      usedAt: null == usedAt
          ? _value.usedAt
          : usedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      recipeId: freezed == recipeId
          ? _value.recipeId
          : recipeId // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      usageType: null == usageType
          ? _value.usageType
          : usageType // ignore: cast_nullable_to_non_nullable
              as UsageType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PantryUsageImplCopyWith<$Res>
    implements $PantryUsageCopyWith<$Res> {
  factory _$$PantryUsageImplCopyWith(
          _$PantryUsageImpl value, $Res Function(_$PantryUsageImpl) then) =
      __$$PantryUsageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String pantryItemId,
      @HiveField(2) double quantityUsed,
      @HiveField(3) DateTime usedAt,
      @HiveField(4) String? recipeId,
      @HiveField(5) String? notes,
      @HiveField(6) UsageType usageType});
}

/// @nodoc
class __$$PantryUsageImplCopyWithImpl<$Res>
    extends _$PantryUsageCopyWithImpl<$Res, _$PantryUsageImpl>
    implements _$$PantryUsageImplCopyWith<$Res> {
  __$$PantryUsageImplCopyWithImpl(
      _$PantryUsageImpl _value, $Res Function(_$PantryUsageImpl) _then)
      : super(_value, _then);

  /// Create a copy of PantryUsage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? pantryItemId = null,
    Object? quantityUsed = null,
    Object? usedAt = null,
    Object? recipeId = freezed,
    Object? notes = freezed,
    Object? usageType = null,
  }) {
    return _then(_$PantryUsageImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      pantryItemId: null == pantryItemId
          ? _value.pantryItemId
          : pantryItemId // ignore: cast_nullable_to_non_nullable
              as String,
      quantityUsed: null == quantityUsed
          ? _value.quantityUsed
          : quantityUsed // ignore: cast_nullable_to_non_nullable
              as double,
      usedAt: null == usedAt
          ? _value.usedAt
          : usedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      recipeId: freezed == recipeId
          ? _value.recipeId
          : recipeId // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      usageType: null == usageType
          ? _value.usageType
          : usageType // ignore: cast_nullable_to_non_nullable
              as UsageType,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PantryUsageImpl implements _PantryUsage {
  const _$PantryUsageImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.pantryItemId,
      @HiveField(2) required this.quantityUsed,
      @HiveField(3) required this.usedAt,
      @HiveField(4) this.recipeId,
      @HiveField(5) this.notes,
      @HiveField(6) this.usageType = UsageType.cooking});

  factory _$PantryUsageImpl.fromJson(Map<String, dynamic> json) =>
      _$$PantryUsageImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String pantryItemId;
  @override
  @HiveField(2)
  final double quantityUsed;
  @override
  @HiveField(3)
  final DateTime usedAt;
  @override
  @HiveField(4)
  final String? recipeId;
  @override
  @HiveField(5)
  final String? notes;
  @override
  @JsonKey()
  @HiveField(6)
  final UsageType usageType;

  @override
  String toString() {
    return 'PantryUsage(id: $id, pantryItemId: $pantryItemId, quantityUsed: $quantityUsed, usedAt: $usedAt, recipeId: $recipeId, notes: $notes, usageType: $usageType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PantryUsageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.pantryItemId, pantryItemId) ||
                other.pantryItemId == pantryItemId) &&
            (identical(other.quantityUsed, quantityUsed) ||
                other.quantityUsed == quantityUsed) &&
            (identical(other.usedAt, usedAt) || other.usedAt == usedAt) &&
            (identical(other.recipeId, recipeId) ||
                other.recipeId == recipeId) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.usageType, usageType) ||
                other.usageType == usageType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, pantryItemId, quantityUsed,
      usedAt, recipeId, notes, usageType);

  /// Create a copy of PantryUsage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PantryUsageImplCopyWith<_$PantryUsageImpl> get copyWith =>
      __$$PantryUsageImplCopyWithImpl<_$PantryUsageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PantryUsageImplToJson(
      this,
    );
  }
}

abstract class _PantryUsage implements PantryUsage {
  const factory _PantryUsage(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String pantryItemId,
      @HiveField(2) required final double quantityUsed,
      @HiveField(3) required final DateTime usedAt,
      @HiveField(4) final String? recipeId,
      @HiveField(5) final String? notes,
      @HiveField(6) final UsageType usageType}) = _$PantryUsageImpl;

  factory _PantryUsage.fromJson(Map<String, dynamic> json) =
      _$PantryUsageImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get pantryItemId;
  @override
  @HiveField(2)
  double get quantityUsed;
  @override
  @HiveField(3)
  DateTime get usedAt;
  @override
  @HiveField(4)
  String? get recipeId;
  @override
  @HiveField(5)
  String? get notes;
  @override
  @HiveField(6)
  UsageType get usageType;

  /// Create a copy of PantryUsage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PantryUsageImplCopyWith<_$PantryUsageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
