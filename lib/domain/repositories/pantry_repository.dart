import '../entities/pantry_item.dart';

abstract class IPantryRepository {
  /// Get all pantry items for a user
  Future<List<PantryItem>> getUserPantryItems(String userId);

  /// Get a specific pantry item by ID
  Future<PantryItem?> getPantryItemById(String itemId);

  /// Add a new pantry item
  Future<PantryItem> addPantryItem(PantryItem item);

  /// Update an existing pantry item
  Future<PantryItem> updatePantryItem(PantryItem item);

  /// Delete a pantry item
  Future<void> deletePantryItem(String itemId);

  /// Get pantry items by category
  Future<List<PantryItem>> getPantryItemsByCategory(String userId, String categoryId);

  /// Get expiring items (within specified days)
  Future<List<PantryItem>> getExpiringItems(String userId, int daysAhead);

  /// Get low stock items
  Future<List<PantryItem>> getLowStockItems(String userId);

  /// Search pantry items
  Future<List<PantryItem>> searchPantryItems(String userId, String query);

  /// Get pantry statistics
  Future<PantryStats> getPantryStats(String userId);

  /// Bulk update pantry items
  Future<List<PantryItem>> bulkUpdatePantryItems(List<PantryItem> items);

  /// Get pantry items by barcode
  Future<PantryItem?> getPantryItemByBarcode(String userId, String barcode);

  /// Get suggested items based on usage patterns
  Future<List<String>> getSuggestedItems(String userId);

  /// Mark item as used/consumed
  Future<void> markItemAsUsed(String itemId, double quantityUsed);

  /// Get pantry item usage history
  Future<List<PantryUsageRecord>> getUsageHistory(String userId, {DateTime? since});
}

class PantryUsageRecord {
  final String id;
  final String itemId;
  final String itemName;
  final double quantityUsed;
  final String unit;
  final DateTime usedAt;
  final String? recipeId;
  final String? recipeName;

  const PantryUsageRecord({
    required this.id,
    required this.itemId,
    required this.itemName,
    required this.quantityUsed,
    required this.unit,
    required this.usedAt,
    this.recipeId,
    this.recipeName,
  });

  factory PantryUsageRecord.fromJson(Map<String, dynamic> json) {
    return PantryUsageRecord(
      id: json['id'] as String,
      itemId: json['itemId'] as String,
      itemName: json['itemName'] as String,
      quantityUsed: (json['quantityUsed'] as num).toDouble(),
      unit: json['unit'] as String,
      usedAt: DateTime.parse(json['usedAt'] as String),
      recipeId: json['recipeId'] as String?,
      recipeName: json['recipeName'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'itemId': itemId,
      'itemName': itemName,
      'quantityUsed': quantityUsed,
      'unit': unit,
      'usedAt': usedAt.toIso8601String(),
      'recipeId': recipeId,
      'recipeName': recipeName,
    };
  }
}