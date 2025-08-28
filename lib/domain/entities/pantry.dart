import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'pantry.freezed.dart';
part 'pantry.g.dart';

@freezed
@HiveType(typeId: 24)
class PantryItem with _$PantryItem {
  const factory PantryItem({
    @HiveField(0) required String id,
    @HiveField(1) required String name,
    @HiveField(2) required double quantity,
    @HiveField(3) required String unit,
    @HiveField(4) String? category,
    @HiveField(5) DateTime? expiryDate,
    @HiveField(6) DateTime? purchaseDate,
    @HiveField(7) required DateTime lastUpdated,
    @HiveField(8) String? location, // Fridge, Pantry, Freezer, etc.
    @HiveField(9) String? brand,
    @HiveField(10) double? cost,
    @HiveField(11) String? barcode,
    @HiveField(12) @Default(PantryItemStatus.available) PantryItemStatus status,
    @HiveField(13) String? notes,
    @HiveField(14) @Default([]) List<String> tags,
    @HiveField(15) String? imageUrl,
  }) = _PantryItem;

  factory PantryItem.fromJson(Map<String, dynamic> json) => _$PantryItemFromJson(json);
}

@freezed
@HiveType(typeId: 25)
class PantryCategory with _$PantryCategory {
  const factory PantryCategory({
    @HiveField(0) required String id,
    @HiveField(1) required String name,
    @HiveField(2) String? description,
    @HiveField(3) String? iconName,
    @HiveField(4) String? color,
    @HiveField(5) @Default([]) List<String> itemIds,
    @HiveField(6) @Default(0) int sortOrder,
  }) = _PantryCategory;

  factory PantryCategory.fromJson(Map<String, dynamic> json) => _$PantryCategoryFromJson(json);
}

@freezed
@HiveType(typeId: 26)
class InventoryAlert with _$InventoryAlert {
  const factory InventoryAlert({
    @HiveField(0) required String id,
    @HiveField(1) required String pantryItemId,
    @HiveField(2) required AlertType type,
    @HiveField(3) required String message,
    @HiveField(4) required DateTime createdAt,
    @HiveField(5) @Default(false) bool isRead,
    @HiveField(6) @Default(AlertPriority.medium) AlertPriority priority,
    @HiveField(7) DateTime? actionDate,
    @HiveField(8) String? actionTaken,
  }) = _InventoryAlert;

  factory InventoryAlert.fromJson(Map<String, dynamic> json) => _$InventoryAlertFromJson(json);
}

@freezed
@HiveType(typeId: 27)
class PantryUsage with _$PantryUsage {
  const factory PantryUsage({
    @HiveField(0) required String id,
    @HiveField(1) required String pantryItemId,
    @HiveField(2) required double quantityUsed,
    @HiveField(3) required DateTime usedAt,
    @HiveField(4) String? recipeId,
    @HiveField(5) String? notes,
    @HiveField(6) @Default(UsageType.cooking) UsageType usageType,
  }) = _PantryUsage;

  factory PantryUsage.fromJson(Map<String, dynamic> json) => _$PantryUsageFromJson(json);
}

@HiveType(typeId: 28)
enum PantryItemStatus {
  @HiveField(0)
  available,
  @HiveField(1)
  lowStock,
  @HiveField(2)
  expired,
  @HiveField(3)
  nearExpiry,
  @HiveField(4)
  outOfStock,
}

@HiveType(typeId: 29)
enum AlertType {
  @HiveField(0)
  expiry,
  @HiveField(1)
  lowStock,
  @HiveField(2)
  outOfStock,
  @HiveField(3)
  priceAlert,
  @HiveField(4)
  recipeRecommendation,
}

@HiveType(typeId: 30)
enum AlertPriority {
  @HiveField(0)
  low,
  @HiveField(1)
  medium,
  @HiveField(2)
  high,
  @HiveField(3)
  urgent,
}

@HiveType(typeId: 31)
enum UsageType {
  @HiveField(0)
  cooking,
  @HiveField(1)
  snacking,
  @HiveField(2)
  waste,
  @HiveField(3)
  expired,
  @HiveField(4)
  donated,
}

extension PantryItemStatusExtension on PantryItemStatus {
  String get displayName {
    switch (this) {
      case PantryItemStatus.available:
        return 'Available';
      case PantryItemStatus.lowStock:
        return 'Low Stock';
      case PantryItemStatus.expired:
        return 'Expired';
      case PantryItemStatus.nearExpiry:
        return 'Near Expiry';
      case PantryItemStatus.outOfStock:
        return 'Out of Stock';
    }
  }

  bool get isActionRequired {
    return this == PantryItemStatus.expired ||
           this == PantryItemStatus.nearExpiry ||
           this == PantryItemStatus.outOfStock;
  }
}

extension AlertTypeExtension on AlertType {
  String get displayName {
    switch (this) {
      case AlertType.expiry:
        return 'Expiry Alert';
      case AlertType.lowStock:
        return 'Low Stock';
      case AlertType.outOfStock:
        return 'Out of Stock';
      case AlertType.priceAlert:
        return 'Price Alert';
      case AlertType.recipeRecommendation:
        return 'Recipe Suggestion';
    }
  }
}