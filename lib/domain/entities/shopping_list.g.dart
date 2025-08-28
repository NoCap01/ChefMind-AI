// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ShoppingListImpl _$$ShoppingListImplFromJson(Map<String, dynamic> json) =>
    _$ShoppingListImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      userId: json['userId'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => ShoppingListItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      isCompleted: json['isCompleted'] as bool? ?? false,
      isShared: json['isShared'] as bool? ?? false,
      sharedWith: (json['sharedWith'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      notes: json['notes'] as String?,
      estimatedTotal: (json['estimatedTotal'] as num?)?.toDouble() ?? 0.0,
      storeId: json['storeId'] as String?,
      storeName: json['storeName'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$ShoppingListImplToJson(_$ShoppingListImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'userId': instance.userId,
      'items': instance.items,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'isCompleted': instance.isCompleted,
      'isShared': instance.isShared,
      'sharedWith': instance.sharedWith,
      'notes': instance.notes,
      'estimatedTotal': instance.estimatedTotal,
      'storeId': instance.storeId,
      'storeName': instance.storeName,
      'metadata': instance.metadata,
    };

_$ShoppingListItemImpl _$$ShoppingListItemImplFromJson(
        Map<String, dynamic> json) =>
    _$ShoppingListItemImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      unit: json['unit'] as String,
      category: json['category'] as String,
      isCompleted: json['isCompleted'] as bool? ?? false,
      isUrgent: json['isUrgent'] as bool? ?? false,
      estimatedPrice: (json['estimatedPrice'] as num?)?.toDouble(),
      actualPrice: (json['actualPrice'] as num?)?.toDouble(),
      brand: json['brand'] as String?,
      notes: json['notes'] as String?,
      recipeId: json['recipeId'] as String?,
      recipeName: json['recipeName'] as String?,
      addedAt: json['addedAt'] == null
          ? null
          : DateTime.parse(json['addedAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      addedBy: json['addedBy'] as String?,
      completedBy: json['completedBy'] as String?,
      alternatives: (json['alternatives'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      barcode: json['barcode'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$$ShoppingListItemImplToJson(
        _$ShoppingListItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'quantity': instance.quantity,
      'unit': instance.unit,
      'category': instance.category,
      'isCompleted': instance.isCompleted,
      'isUrgent': instance.isUrgent,
      'estimatedPrice': instance.estimatedPrice,
      'actualPrice': instance.actualPrice,
      'brand': instance.brand,
      'notes': instance.notes,
      'recipeId': instance.recipeId,
      'recipeName': instance.recipeName,
      'addedAt': instance.addedAt?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'addedBy': instance.addedBy,
      'completedBy': instance.completedBy,
      'alternatives': instance.alternatives,
      'barcode': instance.barcode,
      'imageUrl': instance.imageUrl,
    };

_$ShoppingListCategoryImpl _$$ShoppingListCategoryImplFromJson(
        Map<String, dynamic> json) =>
    _$ShoppingListCategoryImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      icon: json['icon'] as String,
      color: json['color'] as String,
      sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
      description: json['description'] as String?,
      commonItems: (json['commonItems'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      storeAisles: (json['storeAisles'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ShoppingListCategoryImplToJson(
        _$ShoppingListCategoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
      'color': instance.color,
      'sortOrder': instance.sortOrder,
      'description': instance.description,
      'commonItems': instance.commonItems,
      'storeAisles': instance.storeAisles,
    };

_$ShoppingListStatsImpl _$$ShoppingListStatsImplFromJson(
        Map<String, dynamic> json) =>
    _$ShoppingListStatsImpl(
      totalItems: (json['totalItems'] as num).toInt(),
      completedItems: (json['completedItems'] as num).toInt(),
      urgentItems: (json['urgentItems'] as num).toInt(),
      estimatedTotal: (json['estimatedTotal'] as num).toDouble(),
      actualTotal: (json['actualTotal'] as num).toDouble(),
      categoryDistribution:
          Map<String, int>.from(json['categoryDistribution'] as Map),
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
      collaborators: (json['collaborators'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$ShoppingListStatsImplToJson(
        _$ShoppingListStatsImpl instance) =>
    <String, dynamic>{
      'totalItems': instance.totalItems,
      'completedItems': instance.completedItems,
      'urgentItems': instance.urgentItems,
      'estimatedTotal': instance.estimatedTotal,
      'actualTotal': instance.actualTotal,
      'categoryDistribution': instance.categoryDistribution,
      'lastUpdated': instance.lastUpdated.toIso8601String(),
      'collaborators': instance.collaborators,
    };

_$ShoppingListFilterImpl _$$ShoppingListFilterImplFromJson(
        Map<String, dynamic> json) =>
    _$ShoppingListFilterImpl(
      categories: (json['categories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      showCompletedOnly: json['showCompletedOnly'] as bool? ?? false,
      showUrgentOnly: json['showUrgentOnly'] as bool? ?? false,
      showMyItemsOnly: json['showMyItemsOnly'] as bool? ?? false,
      searchQuery: json['searchQuery'] as String?,
      addedBy: json['addedBy'] as String?,
      addedAfter: json['addedAfter'] == null
          ? null
          : DateTime.parse(json['addedAfter'] as String),
      addedBefore: json['addedBefore'] == null
          ? null
          : DateTime.parse(json['addedBefore'] as String),
    );

Map<String, dynamic> _$$ShoppingListFilterImplToJson(
        _$ShoppingListFilterImpl instance) =>
    <String, dynamic>{
      'categories': instance.categories,
      'showCompletedOnly': instance.showCompletedOnly,
      'showUrgentOnly': instance.showUrgentOnly,
      'showMyItemsOnly': instance.showMyItemsOnly,
      'searchQuery': instance.searchQuery,
      'addedBy': instance.addedBy,
      'addedAfter': instance.addedAfter?.toIso8601String(),
      'addedBefore': instance.addedBefore?.toIso8601String(),
    };

_$ShoppingListTemplateImpl _$$ShoppingListTemplateImplFromJson(
        Map<String, dynamic> json) =>
    _$ShoppingListTemplateImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => ShoppingListItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdBy: json['createdBy'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isPublic: json['isPublic'] as bool? ?? false,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      usageCount: (json['usageCount'] as num?)?.toInt() ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$ShoppingListTemplateImplToJson(
        _$ShoppingListTemplateImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'items': instance.items,
      'createdBy': instance.createdBy,
      'createdAt': instance.createdAt.toIso8601String(),
      'isPublic': instance.isPublic,
      'tags': instance.tags,
      'usageCount': instance.usageCount,
      'rating': instance.rating,
    };
