// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pantry_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PantryItemImpl _$$PantryItemImplFromJson(Map<String, dynamic> json) =>
    _$PantryItemImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      unit: json['unit'] as String,
      category:
          PantryCategory.fromJson(json['category'] as Map<String, dynamic>),
      expiryDate: json['expiryDate'] == null
          ? null
          : DateTime.parse(json['expiryDate'] as String),
      purchaseDate: json['purchaseDate'] == null
          ? null
          : DateTime.parse(json['purchaseDate'] as String),
      brand: json['brand'] as String?,
      notes: json['notes'] as String?,
      barcode: json['barcode'] as String?,
      imageUrl: json['imageUrl'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      isLowStock: json['isLowStock'] as bool? ?? false,
      minQuantity: (json['minQuantity'] as num?)?.toDouble(),
      location: json['location'] as String?,
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
      'brand': instance.brand,
      'notes': instance.notes,
      'barcode': instance.barcode,
      'imageUrl': instance.imageUrl,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'isLowStock': instance.isLowStock,
      'minQuantity': instance.minQuantity,
      'location': instance.location,
    };

_$PantryCategoryImpl _$$PantryCategoryImplFromJson(Map<String, dynamic> json) =>
    _$PantryCategoryImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      icon: json['icon'] as String,
      color: json['color'] as String,
      description: json['description'] as String?,
      commonItems: (json['commonItems'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$PantryCategoryImplToJson(
        _$PantryCategoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
      'color': instance.color,
      'description': instance.description,
      'commonItems': instance.commonItems,
    };

_$PantryStatsImpl _$$PantryStatsImplFromJson(Map<String, dynamic> json) =>
    _$PantryStatsImpl(
      totalItems: (json['totalItems'] as num).toInt(),
      expiringItems: (json['expiringItems'] as num).toInt(),
      lowStockItems: (json['lowStockItems'] as num).toInt(),
      categoryDistribution:
          Map<String, int>.from(json['categoryDistribution'] as Map),
      totalValue: (json['totalValue'] as num).toDouble(),
      itemsAddedThisWeek: (json['itemsAddedThisWeek'] as num).toInt(),
      itemsUsedThisWeek: (json['itemsUsedThisWeek'] as num).toInt(),
    );

Map<String, dynamic> _$$PantryStatsImplToJson(_$PantryStatsImpl instance) =>
    <String, dynamic>{
      'totalItems': instance.totalItems,
      'expiringItems': instance.expiringItems,
      'lowStockItems': instance.lowStockItems,
      'categoryDistribution': instance.categoryDistribution,
      'totalValue': instance.totalValue,
      'itemsAddedThisWeek': instance.itemsAddedThisWeek,
      'itemsUsedThisWeek': instance.itemsUsedThisWeek,
    };

_$PantryFilterImpl _$$PantryFilterImplFromJson(Map<String, dynamic> json) =>
    _$PantryFilterImpl(
      categories: (json['categories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      locations: (json['locations'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      showExpiringOnly: json['showExpiringOnly'] as bool? ?? false,
      showLowStockOnly: json['showLowStockOnly'] as bool? ?? false,
      expiryBefore: json['expiryBefore'] == null
          ? null
          : DateTime.parse(json['expiryBefore'] as String),
      expiryAfter: json['expiryAfter'] == null
          ? null
          : DateTime.parse(json['expiryAfter'] as String),
      searchQuery: json['searchQuery'] as String?,
    );

Map<String, dynamic> _$$PantryFilterImplToJson(_$PantryFilterImpl instance) =>
    <String, dynamic>{
      'categories': instance.categories,
      'locations': instance.locations,
      'showExpiringOnly': instance.showExpiringOnly,
      'showLowStockOnly': instance.showLowStockOnly,
      'expiryBefore': instance.expiryBefore?.toIso8601String(),
      'expiryAfter': instance.expiryAfter?.toIso8601String(),
      'searchQuery': instance.searchQuery,
    };
