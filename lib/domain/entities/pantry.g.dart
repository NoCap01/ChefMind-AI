// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pantry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PantryItemImpl _$$PantryItemImplFromJson(Map<String, dynamic> json) =>
    _$PantryItemImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      unit: json['unit'] as String,
      category: json['category'] as String?,
      expiryDate: json['expiryDate'] == null
          ? null
          : DateTime.parse(json['expiryDate'] as String),
      purchaseDate: json['purchaseDate'] == null
          ? null
          : DateTime.parse(json['purchaseDate'] as String),
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
      location: json['location'] as String?,
      brand: json['brand'] as String?,
      cost: (json['cost'] as num?)?.toDouble(),
      barcode: json['barcode'] as String?,
      status: $enumDecodeNullable(_$PantryItemStatusEnumMap, json['status']) ??
          PantryItemStatus.available,
      notes: json['notes'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$$PantryItemImplToJson(_$PantryItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'quantity': instance.quantity,
      'unit': instance.unit,
      'category': instance.category,
      'expiryDate': instance.expiryDate?.toIso8601String(),
      'purchaseDate': instance.purchaseDate?.toIso8601String(),
      'lastUpdated': instance.lastUpdated.toIso8601String(),
      'location': instance.location,
      'brand': instance.brand,
      'cost': instance.cost,
      'barcode': instance.barcode,
      'status': _$PantryItemStatusEnumMap[instance.status]!,
      'notes': instance.notes,
      'tags': instance.tags,
      'imageUrl': instance.imageUrl,
    };

const _$PantryItemStatusEnumMap = {
  PantryItemStatus.available: 'available',
  PantryItemStatus.lowStock: 'lowStock',
  PantryItemStatus.expired: 'expired',
  PantryItemStatus.nearExpiry: 'nearExpiry',
  PantryItemStatus.outOfStock: 'outOfStock',
};

_$PantryCategoryImpl _$$PantryCategoryImplFromJson(Map<String, dynamic> json) =>
    _$PantryCategoryImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      iconName: json['iconName'] as String?,
      color: json['color'] as String?,
      itemIds: (json['itemIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$PantryCategoryImplToJson(
        _$PantryCategoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'iconName': instance.iconName,
      'color': instance.color,
      'itemIds': instance.itemIds,
      'sortOrder': instance.sortOrder,
    };

_$InventoryAlertImpl _$$InventoryAlertImplFromJson(Map<String, dynamic> json) =>
    _$InventoryAlertImpl(
      id: json['id'] as String,
      pantryItemId: json['pantryItemId'] as String,
      type: $enumDecode(_$AlertTypeEnumMap, json['type']),
      message: json['message'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isRead: json['isRead'] as bool? ?? false,
      priority: $enumDecodeNullable(_$AlertPriorityEnumMap, json['priority']) ??
          AlertPriority.medium,
      actionDate: json['actionDate'] == null
          ? null
          : DateTime.parse(json['actionDate'] as String),
      actionTaken: json['actionTaken'] as String?,
    );

Map<String, dynamic> _$$InventoryAlertImplToJson(
        _$InventoryAlertImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pantryItemId': instance.pantryItemId,
      'type': _$AlertTypeEnumMap[instance.type]!,
      'message': instance.message,
      'createdAt': instance.createdAt.toIso8601String(),
      'isRead': instance.isRead,
      'priority': _$AlertPriorityEnumMap[instance.priority]!,
      'actionDate': instance.actionDate?.toIso8601String(),
      'actionTaken': instance.actionTaken,
    };

const _$AlertTypeEnumMap = {
  AlertType.expiry: 'expiry',
  AlertType.lowStock: 'lowStock',
  AlertType.outOfStock: 'outOfStock',
  AlertType.priceAlert: 'priceAlert',
  AlertType.recipeRecommendation: 'recipeRecommendation',
};

const _$AlertPriorityEnumMap = {
  AlertPriority.low: 'low',
  AlertPriority.medium: 'medium',
  AlertPriority.high: 'high',
  AlertPriority.urgent: 'urgent',
};

_$PantryUsageImpl _$$PantryUsageImplFromJson(Map<String, dynamic> json) =>
    _$PantryUsageImpl(
      id: json['id'] as String,
      pantryItemId: json['pantryItemId'] as String,
      quantityUsed: (json['quantityUsed'] as num).toDouble(),
      usedAt: DateTime.parse(json['usedAt'] as String),
      recipeId: json['recipeId'] as String?,
      notes: json['notes'] as String?,
      usageType: $enumDecodeNullable(_$UsageTypeEnumMap, json['usageType']) ??
          UsageType.cooking,
    );

Map<String, dynamic> _$$PantryUsageImplToJson(_$PantryUsageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pantryItemId': instance.pantryItemId,
      'quantityUsed': instance.quantityUsed,
      'usedAt': instance.usedAt.toIso8601String(),
      'recipeId': instance.recipeId,
      'notes': instance.notes,
      'usageType': _$UsageTypeEnumMap[instance.usageType]!,
    };

const _$UsageTypeEnumMap = {
  UsageType.cooking: 'cooking',
  UsageType.snacking: 'snacking',
  UsageType.waste: 'waste',
  UsageType.expired: 'expired',
  UsageType.donated: 'donated',
};
