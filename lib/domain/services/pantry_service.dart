import '../entities/pantry_item.dart';
import '../repositories/pantry_repository.dart';

abstract class IPantryService {
  /// Add item to pantry with barcode scanning
  Future<PantryItem> addItemWithBarcode(String barcode, String userId);

  /// Get expiry notifications for user
  Future<List<ExpiryNotification>> getExpiryNotifications(String userId);

  /// Suggest recipes based on expiring items
  Future<List<String>> suggestRecipesForExpiringItems(String userId);

  /// Calculate pantry value
  Future<double> calculatePantryValue(String userId);

  /// Generate shopping list from low stock items
  Future<List<ShoppingListItem>> generateShoppingListFromLowStock(String userId);

  /// Optimize pantry organization suggestions
  Future<List<OrganizationSuggestion>> getOrganizationSuggestions(String userId);

  /// Track pantry usage patterns
  Future<UsagePattern> analyzeUsagePatterns(String userId);

  /// Get smart restocking suggestions
  Future<List<RestockingSuggestion>> getRestockingSuggestions(String userId);
}

class ExpiryNotification {
  final String itemId;
  final String itemName;
  final DateTime expiryDate;
  final int daysUntilExpiry;
  final NotificationPriority priority;
  final List<String> suggestedRecipes;

  const ExpiryNotification({
    required this.itemId,
    required this.itemName,
    required this.expiryDate,
    required this.daysUntilExpiry,
    required this.priority,
    required this.suggestedRecipes,
  });
}

enum NotificationPriority {
  low,
  medium,
  high,
  urgent,
}

class ShoppingListItem {
  final String name;
  final double quantity;
  final String unit;
  final String category;
  final double? estimatedPrice;
  final bool isUrgent;

  const ShoppingListItem({
    required this.name,
    required this.quantity,
    required this.unit,
    required this.category,
    this.estimatedPrice,
    required this.isUrgent,
  });
}

class OrganizationSuggestion {
  final String title;
  final String description;
  final OrganizationType type;
  final List<String> affectedItems;

  const OrganizationSuggestion({
    required this.title,
    required this.description,
    required this.type,
    required this.affectedItems,
  });
}

enum OrganizationType {
  expiry,
  category,
  location,
  frequency,
}

class UsagePattern {
  final Map<String, double> frequentlyUsedItems;
  final Map<String, double> wastedItems;
  final Map<String, int> categoryUsage;
  final double averageShelfLife;
  final List<String> recommendations;

  const UsagePattern({
    required this.frequentlyUsedItems,
    required this.wastedItems,
    required this.categoryUsage,
    required this.averageShelfLife,
    required this.recommendations,
  });
}

class RestockingSuggestion {
  final String itemName;
  final double suggestedQuantity;
  final String unit;
  final String reason;
  final double confidence;
  final DateTime suggestedPurchaseDate;

  const RestockingSuggestion({
    required this.itemName,
    required this.suggestedQuantity,
    required this.unit,
    required this.reason,
    required this.confidence,
    required this.suggestedPurchaseDate,
  });
}