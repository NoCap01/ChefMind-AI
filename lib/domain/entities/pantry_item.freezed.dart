// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pantry_item.dart';

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
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get quantity => throw _privateConstructorUsedError;
  String get unit => throw _privateConstructorUsedError;
  PantryCategory get category => throw _privateConstructorUsedError;
  DateTime? get expiryDate => throw _privateConstructorUsedError;
  DateTime? get purchaseDate => throw _privateConstructorUsedError;
  String? get brand => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  String? get barcode => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  bool get isLowStock => throw _privateConstructorUsedError;
  double? get minQuantity => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;

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
      {String id,
      String name,
      double quantity,
      String unit,
      PantryCategory category,
      DateTime? expiryDate,
      DateTime? purchaseDate,
      String? brand,
      String? notes,
      String? barcode,
      String? imageUrl,
      DateTime createdAt,
      DateTime? updatedAt,
      bool isLowStock,
      double? minQuantity,
      String? location});

  $PantryCategoryCopyWith<$Res> get category;
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
    Object? category = null,
    Object? expiryDate = freezed,
    Object? purchaseDate = freezed,
    Object? brand = freezed,
    Object? notes = freezed,
    Object? barcode = freezed,
    Object? imageUrl = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? isLowStock = null,
    Object? minQuantity = freezed,
    Object? location = freezed,
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
              as PantryCategory,
      expiryDate: freezed == expiryDate
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      purchaseDate: freezed == purchaseDate
          ? _value.purchaseDate
          : purchaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      brand: freezed == brand
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      barcode: freezed == barcode
          ? _value.barcode
          : barcode // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isLowStock: null == isLowStock
          ? _value.isLowStock
          : isLowStock // ignore: cast_nullable_to_non_nullable
              as bool,
      minQuantity: freezed == minQuantity
          ? _value.minQuantity
          : minQuantity // ignore: cast_nullable_to_non_nullable
              as double?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of PantryItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PantryCategoryCopyWith<$Res> get category {
    return $PantryCategoryCopyWith<$Res>(_value.category, (value) {
      return _then(_value.copyWith(category: value) as $Val);
    });
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
      {String id,
      String name,
      double quantity,
      String unit,
      PantryCategory category,
      DateTime? expiryDate,
      DateTime? purchaseDate,
      String? brand,
      String? notes,
      String? barcode,
      String? imageUrl,
      DateTime createdAt,
      DateTime? updatedAt,
      bool isLowStock,
      double? minQuantity,
      String? location});

  @override
  $PantryCategoryCopyWith<$Res> get category;
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
    Object? category = null,
    Object? expiryDate = freezed,
    Object? purchaseDate = freezed,
    Object? brand = freezed,
    Object? notes = freezed,
    Object? barcode = freezed,
    Object? imageUrl = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? isLowStock = null,
    Object? minQuantity = freezed,
    Object? location = freezed,
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
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as PantryCategory,
      expiryDate: freezed == expiryDate
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      purchaseDate: freezed == purchaseDate
          ? _value.purchaseDate
          : purchaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      brand: freezed == brand
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      barcode: freezed == barcode
          ? _value.barcode
          : barcode // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isLowStock: null == isLowStock
          ? _value.isLowStock
          : isLowStock // ignore: cast_nullable_to_non_nullable
              as bool,
      minQuantity: freezed == minQuantity
          ? _value.minQuantity
          : minQuantity // ignore: cast_nullable_to_non_nullable
              as double?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PantryItemImpl implements _PantryItem {
  const _$PantryItemImpl(
      {required this.id,
      required this.name,
      required this.quantity,
      required this.unit,
      required this.category,
      this.expiryDate,
      this.purchaseDate,
      this.brand,
      this.notes,
      this.barcode,
      this.imageUrl,
      required this.createdAt,
      this.updatedAt,
      this.isLowStock = false,
      this.minQuantity,
      this.location});

  factory _$PantryItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$PantryItemImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final double quantity;
  @override
  final String unit;
  @override
  final PantryCategory category;
  @override
  final DateTime? expiryDate;
  @override
  final DateTime? purchaseDate;
  @override
  final String? brand;
  @override
  final String? notes;
  @override
  final String? barcode;
  @override
  final String? imageUrl;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;
  @override
  @JsonKey()
  final bool isLowStock;
  @override
  final double? minQuantity;
  @override
  final String? location;

  @override
  String toString() {
    return 'PantryItem(id: $id, name: $name, quantity: $quantity, unit: $unit, category: $category, expiryDate: $expiryDate, purchaseDate: $purchaseDate, brand: $brand, notes: $notes, barcode: $barcode, imageUrl: $imageUrl, createdAt: $createdAt, updatedAt: $updatedAt, isLowStock: $isLowStock, minQuantity: $minQuantity, location: $location)';
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
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.barcode, barcode) || other.barcode == barcode) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.isLowStock, isLowStock) ||
                other.isLowStock == isLowStock) &&
            (identical(other.minQuantity, minQuantity) ||
                other.minQuantity == minQuantity) &&
            (identical(other.location, location) ||
                other.location == location));
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
      brand,
      notes,
      barcode,
      imageUrl,
      createdAt,
      updatedAt,
      isLowStock,
      minQuantity,
      location);

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
      {required final String id,
      required final String name,
      required final double quantity,
      required final String unit,
      required final PantryCategory category,
      final DateTime? expiryDate,
      final DateTime? purchaseDate,
      final String? brand,
      final String? notes,
      final String? barcode,
      final String? imageUrl,
      required final DateTime createdAt,
      final DateTime? updatedAt,
      final bool isLowStock,
      final double? minQuantity,
      final String? location}) = _$PantryItemImpl;

  factory _PantryItem.fromJson(Map<String, dynamic> json) =
      _$PantryItemImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  double get quantity;
  @override
  String get unit;
  @override
  PantryCategory get category;
  @override
  DateTime? get expiryDate;
  @override
  DateTime? get purchaseDate;
  @override
  String? get brand;
  @override
  String? get notes;
  @override
  String? get barcode;
  @override
  String? get imageUrl;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  bool get isLowStock;
  @override
  double? get minQuantity;
  @override
  String? get location;

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
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get icon => throw _privateConstructorUsedError;
  String get color => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  List<String> get commonItems => throw _privateConstructorUsedError;

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
      {String id,
      String name,
      String icon,
      String color,
      String? description,
      List<String> commonItems});
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
    Object? icon = null,
    Object? color = null,
    Object? description = freezed,
    Object? commonItems = null,
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
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      commonItems: null == commonItems
          ? _value.commonItems
          : commonItems // ignore: cast_nullable_to_non_nullable
              as List<String>,
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
      {String id,
      String name,
      String icon,
      String color,
      String? description,
      List<String> commonItems});
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
    Object? icon = null,
    Object? color = null,
    Object? description = freezed,
    Object? commonItems = null,
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
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      commonItems: null == commonItems
          ? _value._commonItems
          : commonItems // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PantryCategoryImpl implements _PantryCategory {
  const _$PantryCategoryImpl(
      {required this.id,
      required this.name,
      required this.icon,
      required this.color,
      this.description,
      final List<String> commonItems = const []})
      : _commonItems = commonItems;

  factory _$PantryCategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$PantryCategoryImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String icon;
  @override
  final String color;
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

  @override
  String toString() {
    return 'PantryCategory(id: $id, name: $name, icon: $icon, color: $color, description: $description, commonItems: $commonItems)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PantryCategoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._commonItems, _commonItems));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, icon, color,
      description, const DeepCollectionEquality().hash(_commonItems));

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
      {required final String id,
      required final String name,
      required final String icon,
      required final String color,
      final String? description,
      final List<String> commonItems}) = _$PantryCategoryImpl;

  factory _PantryCategory.fromJson(Map<String, dynamic> json) =
      _$PantryCategoryImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get icon;
  @override
  String get color;
  @override
  String? get description;
  @override
  List<String> get commonItems;

  /// Create a copy of PantryCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PantryCategoryImplCopyWith<_$PantryCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PantryStats _$PantryStatsFromJson(Map<String, dynamic> json) {
  return _PantryStats.fromJson(json);
}

/// @nodoc
mixin _$PantryStats {
  int get totalItems => throw _privateConstructorUsedError;
  int get expiringItems => throw _privateConstructorUsedError;
  int get lowStockItems => throw _privateConstructorUsedError;
  Map<String, int> get categoryDistribution =>
      throw _privateConstructorUsedError;
  double get totalValue => throw _privateConstructorUsedError;
  int get itemsAddedThisWeek => throw _privateConstructorUsedError;
  int get itemsUsedThisWeek => throw _privateConstructorUsedError;

  /// Serializes this PantryStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PantryStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PantryStatsCopyWith<PantryStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PantryStatsCopyWith<$Res> {
  factory $PantryStatsCopyWith(
          PantryStats value, $Res Function(PantryStats) then) =
      _$PantryStatsCopyWithImpl<$Res, PantryStats>;
  @useResult
  $Res call(
      {int totalItems,
      int expiringItems,
      int lowStockItems,
      Map<String, int> categoryDistribution,
      double totalValue,
      int itemsAddedThisWeek,
      int itemsUsedThisWeek});
}

/// @nodoc
class _$PantryStatsCopyWithImpl<$Res, $Val extends PantryStats>
    implements $PantryStatsCopyWith<$Res> {
  _$PantryStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PantryStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalItems = null,
    Object? expiringItems = null,
    Object? lowStockItems = null,
    Object? categoryDistribution = null,
    Object? totalValue = null,
    Object? itemsAddedThisWeek = null,
    Object? itemsUsedThisWeek = null,
  }) {
    return _then(_value.copyWith(
      totalItems: null == totalItems
          ? _value.totalItems
          : totalItems // ignore: cast_nullable_to_non_nullable
              as int,
      expiringItems: null == expiringItems
          ? _value.expiringItems
          : expiringItems // ignore: cast_nullable_to_non_nullable
              as int,
      lowStockItems: null == lowStockItems
          ? _value.lowStockItems
          : lowStockItems // ignore: cast_nullable_to_non_nullable
              as int,
      categoryDistribution: null == categoryDistribution
          ? _value.categoryDistribution
          : categoryDistribution // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      totalValue: null == totalValue
          ? _value.totalValue
          : totalValue // ignore: cast_nullable_to_non_nullable
              as double,
      itemsAddedThisWeek: null == itemsAddedThisWeek
          ? _value.itemsAddedThisWeek
          : itemsAddedThisWeek // ignore: cast_nullable_to_non_nullable
              as int,
      itemsUsedThisWeek: null == itemsUsedThisWeek
          ? _value.itemsUsedThisWeek
          : itemsUsedThisWeek // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PantryStatsImplCopyWith<$Res>
    implements $PantryStatsCopyWith<$Res> {
  factory _$$PantryStatsImplCopyWith(
          _$PantryStatsImpl value, $Res Function(_$PantryStatsImpl) then) =
      __$$PantryStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int totalItems,
      int expiringItems,
      int lowStockItems,
      Map<String, int> categoryDistribution,
      double totalValue,
      int itemsAddedThisWeek,
      int itemsUsedThisWeek});
}

/// @nodoc
class __$$PantryStatsImplCopyWithImpl<$Res>
    extends _$PantryStatsCopyWithImpl<$Res, _$PantryStatsImpl>
    implements _$$PantryStatsImplCopyWith<$Res> {
  __$$PantryStatsImplCopyWithImpl(
      _$PantryStatsImpl _value, $Res Function(_$PantryStatsImpl) _then)
      : super(_value, _then);

  /// Create a copy of PantryStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalItems = null,
    Object? expiringItems = null,
    Object? lowStockItems = null,
    Object? categoryDistribution = null,
    Object? totalValue = null,
    Object? itemsAddedThisWeek = null,
    Object? itemsUsedThisWeek = null,
  }) {
    return _then(_$PantryStatsImpl(
      totalItems: null == totalItems
          ? _value.totalItems
          : totalItems // ignore: cast_nullable_to_non_nullable
              as int,
      expiringItems: null == expiringItems
          ? _value.expiringItems
          : expiringItems // ignore: cast_nullable_to_non_nullable
              as int,
      lowStockItems: null == lowStockItems
          ? _value.lowStockItems
          : lowStockItems // ignore: cast_nullable_to_non_nullable
              as int,
      categoryDistribution: null == categoryDistribution
          ? _value._categoryDistribution
          : categoryDistribution // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      totalValue: null == totalValue
          ? _value.totalValue
          : totalValue // ignore: cast_nullable_to_non_nullable
              as double,
      itemsAddedThisWeek: null == itemsAddedThisWeek
          ? _value.itemsAddedThisWeek
          : itemsAddedThisWeek // ignore: cast_nullable_to_non_nullable
              as int,
      itemsUsedThisWeek: null == itemsUsedThisWeek
          ? _value.itemsUsedThisWeek
          : itemsUsedThisWeek // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PantryStatsImpl implements _PantryStats {
  const _$PantryStatsImpl(
      {required this.totalItems,
      required this.expiringItems,
      required this.lowStockItems,
      required final Map<String, int> categoryDistribution,
      required this.totalValue,
      required this.itemsAddedThisWeek,
      required this.itemsUsedThisWeek})
      : _categoryDistribution = categoryDistribution;

  factory _$PantryStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PantryStatsImplFromJson(json);

  @override
  final int totalItems;
  @override
  final int expiringItems;
  @override
  final int lowStockItems;
  final Map<String, int> _categoryDistribution;
  @override
  Map<String, int> get categoryDistribution {
    if (_categoryDistribution is EqualUnmodifiableMapView)
      return _categoryDistribution;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_categoryDistribution);
  }

  @override
  final double totalValue;
  @override
  final int itemsAddedThisWeek;
  @override
  final int itemsUsedThisWeek;

  @override
  String toString() {
    return 'PantryStats(totalItems: $totalItems, expiringItems: $expiringItems, lowStockItems: $lowStockItems, categoryDistribution: $categoryDistribution, totalValue: $totalValue, itemsAddedThisWeek: $itemsAddedThisWeek, itemsUsedThisWeek: $itemsUsedThisWeek)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PantryStatsImpl &&
            (identical(other.totalItems, totalItems) ||
                other.totalItems == totalItems) &&
            (identical(other.expiringItems, expiringItems) ||
                other.expiringItems == expiringItems) &&
            (identical(other.lowStockItems, lowStockItems) ||
                other.lowStockItems == lowStockItems) &&
            const DeepCollectionEquality()
                .equals(other._categoryDistribution, _categoryDistribution) &&
            (identical(other.totalValue, totalValue) ||
                other.totalValue == totalValue) &&
            (identical(other.itemsAddedThisWeek, itemsAddedThisWeek) ||
                other.itemsAddedThisWeek == itemsAddedThisWeek) &&
            (identical(other.itemsUsedThisWeek, itemsUsedThisWeek) ||
                other.itemsUsedThisWeek == itemsUsedThisWeek));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalItems,
      expiringItems,
      lowStockItems,
      const DeepCollectionEquality().hash(_categoryDistribution),
      totalValue,
      itemsAddedThisWeek,
      itemsUsedThisWeek);

  /// Create a copy of PantryStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PantryStatsImplCopyWith<_$PantryStatsImpl> get copyWith =>
      __$$PantryStatsImplCopyWithImpl<_$PantryStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PantryStatsImplToJson(
      this,
    );
  }
}

abstract class _PantryStats implements PantryStats {
  const factory _PantryStats(
      {required final int totalItems,
      required final int expiringItems,
      required final int lowStockItems,
      required final Map<String, int> categoryDistribution,
      required final double totalValue,
      required final int itemsAddedThisWeek,
      required final int itemsUsedThisWeek}) = _$PantryStatsImpl;

  factory _PantryStats.fromJson(Map<String, dynamic> json) =
      _$PantryStatsImpl.fromJson;

  @override
  int get totalItems;
  @override
  int get expiringItems;
  @override
  int get lowStockItems;
  @override
  Map<String, int> get categoryDistribution;
  @override
  double get totalValue;
  @override
  int get itemsAddedThisWeek;
  @override
  int get itemsUsedThisWeek;

  /// Create a copy of PantryStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PantryStatsImplCopyWith<_$PantryStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PantryFilter _$PantryFilterFromJson(Map<String, dynamic> json) {
  return _PantryFilter.fromJson(json);
}

/// @nodoc
mixin _$PantryFilter {
  List<String> get categories => throw _privateConstructorUsedError;
  List<String> get locations => throw _privateConstructorUsedError;
  bool get showExpiringOnly => throw _privateConstructorUsedError;
  bool get showLowStockOnly => throw _privateConstructorUsedError;
  DateTime? get expiryBefore => throw _privateConstructorUsedError;
  DateTime? get expiryAfter => throw _privateConstructorUsedError;
  String? get searchQuery => throw _privateConstructorUsedError;

  /// Serializes this PantryFilter to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PantryFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PantryFilterCopyWith<PantryFilter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PantryFilterCopyWith<$Res> {
  factory $PantryFilterCopyWith(
          PantryFilter value, $Res Function(PantryFilter) then) =
      _$PantryFilterCopyWithImpl<$Res, PantryFilter>;
  @useResult
  $Res call(
      {List<String> categories,
      List<String> locations,
      bool showExpiringOnly,
      bool showLowStockOnly,
      DateTime? expiryBefore,
      DateTime? expiryAfter,
      String? searchQuery});
}

/// @nodoc
class _$PantryFilterCopyWithImpl<$Res, $Val extends PantryFilter>
    implements $PantryFilterCopyWith<$Res> {
  _$PantryFilterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PantryFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categories = null,
    Object? locations = null,
    Object? showExpiringOnly = null,
    Object? showLowStockOnly = null,
    Object? expiryBefore = freezed,
    Object? expiryAfter = freezed,
    Object? searchQuery = freezed,
  }) {
    return _then(_value.copyWith(
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      locations: null == locations
          ? _value.locations
          : locations // ignore: cast_nullable_to_non_nullable
              as List<String>,
      showExpiringOnly: null == showExpiringOnly
          ? _value.showExpiringOnly
          : showExpiringOnly // ignore: cast_nullable_to_non_nullable
              as bool,
      showLowStockOnly: null == showLowStockOnly
          ? _value.showLowStockOnly
          : showLowStockOnly // ignore: cast_nullable_to_non_nullable
              as bool,
      expiryBefore: freezed == expiryBefore
          ? _value.expiryBefore
          : expiryBefore // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      expiryAfter: freezed == expiryAfter
          ? _value.expiryAfter
          : expiryAfter // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      searchQuery: freezed == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PantryFilterImplCopyWith<$Res>
    implements $PantryFilterCopyWith<$Res> {
  factory _$$PantryFilterImplCopyWith(
          _$PantryFilterImpl value, $Res Function(_$PantryFilterImpl) then) =
      __$$PantryFilterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String> categories,
      List<String> locations,
      bool showExpiringOnly,
      bool showLowStockOnly,
      DateTime? expiryBefore,
      DateTime? expiryAfter,
      String? searchQuery});
}

/// @nodoc
class __$$PantryFilterImplCopyWithImpl<$Res>
    extends _$PantryFilterCopyWithImpl<$Res, _$PantryFilterImpl>
    implements _$$PantryFilterImplCopyWith<$Res> {
  __$$PantryFilterImplCopyWithImpl(
      _$PantryFilterImpl _value, $Res Function(_$PantryFilterImpl) _then)
      : super(_value, _then);

  /// Create a copy of PantryFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categories = null,
    Object? locations = null,
    Object? showExpiringOnly = null,
    Object? showLowStockOnly = null,
    Object? expiryBefore = freezed,
    Object? expiryAfter = freezed,
    Object? searchQuery = freezed,
  }) {
    return _then(_$PantryFilterImpl(
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      locations: null == locations
          ? _value._locations
          : locations // ignore: cast_nullable_to_non_nullable
              as List<String>,
      showExpiringOnly: null == showExpiringOnly
          ? _value.showExpiringOnly
          : showExpiringOnly // ignore: cast_nullable_to_non_nullable
              as bool,
      showLowStockOnly: null == showLowStockOnly
          ? _value.showLowStockOnly
          : showLowStockOnly // ignore: cast_nullable_to_non_nullable
              as bool,
      expiryBefore: freezed == expiryBefore
          ? _value.expiryBefore
          : expiryBefore // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      expiryAfter: freezed == expiryAfter
          ? _value.expiryAfter
          : expiryAfter // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      searchQuery: freezed == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PantryFilterImpl implements _PantryFilter {
  const _$PantryFilterImpl(
      {final List<String> categories = const [],
      final List<String> locations = const [],
      this.showExpiringOnly = false,
      this.showLowStockOnly = false,
      this.expiryBefore,
      this.expiryAfter,
      this.searchQuery})
      : _categories = categories,
        _locations = locations;

  factory _$PantryFilterImpl.fromJson(Map<String, dynamic> json) =>
      _$$PantryFilterImplFromJson(json);

  final List<String> _categories;
  @override
  @JsonKey()
  List<String> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  final List<String> _locations;
  @override
  @JsonKey()
  List<String> get locations {
    if (_locations is EqualUnmodifiableListView) return _locations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_locations);
  }

  @override
  @JsonKey()
  final bool showExpiringOnly;
  @override
  @JsonKey()
  final bool showLowStockOnly;
  @override
  final DateTime? expiryBefore;
  @override
  final DateTime? expiryAfter;
  @override
  final String? searchQuery;

  @override
  String toString() {
    return 'PantryFilter(categories: $categories, locations: $locations, showExpiringOnly: $showExpiringOnly, showLowStockOnly: $showLowStockOnly, expiryBefore: $expiryBefore, expiryAfter: $expiryAfter, searchQuery: $searchQuery)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PantryFilterImpl &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            const DeepCollectionEquality()
                .equals(other._locations, _locations) &&
            (identical(other.showExpiringOnly, showExpiringOnly) ||
                other.showExpiringOnly == showExpiringOnly) &&
            (identical(other.showLowStockOnly, showLowStockOnly) ||
                other.showLowStockOnly == showLowStockOnly) &&
            (identical(other.expiryBefore, expiryBefore) ||
                other.expiryBefore == expiryBefore) &&
            (identical(other.expiryAfter, expiryAfter) ||
                other.expiryAfter == expiryAfter) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_categories),
      const DeepCollectionEquality().hash(_locations),
      showExpiringOnly,
      showLowStockOnly,
      expiryBefore,
      expiryAfter,
      searchQuery);

  /// Create a copy of PantryFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PantryFilterImplCopyWith<_$PantryFilterImpl> get copyWith =>
      __$$PantryFilterImplCopyWithImpl<_$PantryFilterImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PantryFilterImplToJson(
      this,
    );
  }
}

abstract class _PantryFilter implements PantryFilter {
  const factory _PantryFilter(
      {final List<String> categories,
      final List<String> locations,
      final bool showExpiringOnly,
      final bool showLowStockOnly,
      final DateTime? expiryBefore,
      final DateTime? expiryAfter,
      final String? searchQuery}) = _$PantryFilterImpl;

  factory _PantryFilter.fromJson(Map<String, dynamic> json) =
      _$PantryFilterImpl.fromJson;

  @override
  List<String> get categories;
  @override
  List<String> get locations;
  @override
  bool get showExpiringOnly;
  @override
  bool get showLowStockOnly;
  @override
  DateTime? get expiryBefore;
  @override
  DateTime? get expiryAfter;
  @override
  String? get searchQuery;

  /// Create a copy of PantryFilter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PantryFilterImplCopyWith<_$PantryFilterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
