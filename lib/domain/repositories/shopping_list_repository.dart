import '../entities/shopping_list.dart';

abstract class IShoppingListRepository {
  /// Get all shopping lists for a user
  Future<List<ShoppingList>> getUserShoppingLists(String userId);

  /// Get a specific shopping list by ID
  Future<ShoppingList?> getShoppingListById(String listId);

  /// Create a new shopping list
  Future<ShoppingList> createShoppingList(ShoppingList shoppingList);

  /// Update an existing shopping list
  Future<ShoppingList> updateShoppingList(ShoppingList shoppingList);

  /// Delete a shopping list
  Future<void> deleteShoppingList(String listId);

  /// Add item to shopping list
  Future<ShoppingList> addItemToList(String listId, ShoppingListItem item);

  /// Update item in shopping list
  Future<ShoppingList> updateItemInList(String listId, ShoppingListItem item);

  /// Remove item from shopping list
  Future<ShoppingList> removeItemFromList(String listId, String itemId);

  /// Mark item as completed
  Future<ShoppingList> markItemCompleted(String listId, String itemId, {String? completedBy});

  /// Mark item as uncompleted
  Future<ShoppingList> markItemUncompleted(String listId, String itemId);

  /// Get shared shopping lists
  Future<List<ShoppingList>> getSharedShoppingLists(String userId);

  /// Share shopping list with users
  Future<ShoppingList> shareShoppingList(String listId, List<String> userIds);

  /// Unshare shopping list
  Future<ShoppingList> unshareShoppingList(String listId, List<String> userIds);

  /// Get shopping list templates
  Future<List<ShoppingListTemplate>> getShoppingListTemplates();

  /// Create shopping list from template
  Future<ShoppingList> createFromTemplate(String templateId, String userId, String name);

  /// Get shopping list statistics
  Future<ShoppingListStats> getShoppingListStats(String listId);

  /// Search shopping lists
  Future<List<ShoppingList>> searchShoppingLists(String userId, String query);

  /// Get recent shopping lists
  Future<List<ShoppingList>> getRecentShoppingLists(String userId, {int limit = 10});

  /// Duplicate shopping list
  Future<ShoppingList> duplicateShoppingList(String listId, String newName);

  /// Archive shopping list
  Future<void> archiveShoppingList(String listId);

  /// Get archived shopping lists
  Future<List<ShoppingList>> getArchivedShoppingLists(String userId);

  /// Restore archived shopping list
  Future<ShoppingList> restoreShoppingList(String listId);

  /// Get shopping list by barcode
  Future<List<ShoppingListItem>> getItemsByBarcode(String barcode);

  /// Get price history for item
  Future<List<PriceHistory>> getPriceHistory(String itemName, {int days = 30});

  /// Update item price
  Future<void> updateItemPrice(String listId, String itemId, double price);

  /// Get store layout for optimization
  Future<StoreLayout?> getStoreLayout(String storeId);

  /// Optimize shopping list by store layout
  Future<ShoppingList> optimizeForStore(String listId, String storeId);
}

class PriceHistory {
  final String itemName;
  final double price;
  final String store;
  final DateTime date;
  final String? brand;
  final String? size;

  const PriceHistory({
    required this.itemName,
    required this.price,
    required this.store,
    required this.date,
    this.brand,
    this.size,
  });

  factory PriceHistory.fromJson(Map<String, dynamic> json) {
    return PriceHistory(
      itemName: json['itemName'] as String,
      price: (json['price'] as num).toDouble(),
      store: json['store'] as String,
      date: DateTime.parse(json['date'] as String),
      brand: json['brand'] as String?,
      size: json['size'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'itemName': itemName,
      'price': price,
      'store': store,
      'date': date.toIso8601String(),
      'brand': brand,
      'size': size,
    };
  }
}

class StoreLayout {
  final String storeId;
  final String storeName;
  final Map<String, int> aisleNumbers;
  final Map<String, List<String>> categoryAisles;
  final List<String> aisleOrder;

  const StoreLayout({
    required this.storeId,
    required this.storeName,
    required this.aisleNumbers,
    required this.categoryAisles,
    required this.aisleOrder,
  });

  factory StoreLayout.fromJson(Map<String, dynamic> json) {
    return StoreLayout(
      storeId: json['storeId'] as String,
      storeName: json['storeName'] as String,
      aisleNumbers: Map<String, int>.from(json['aisleNumbers'] as Map),
      categoryAisles: Map<String, List<String>>.from(
        (json['categoryAisles'] as Map).map(
          (key, value) => MapEntry(key as String, List<String>.from(value as List)),
        ),
      ),
      aisleOrder: List<String>.from(json['aisleOrder'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'storeId': storeId,
      'storeName': storeName,
      'aisleNumbers': aisleNumbers,
      'categoryAisles': categoryAisles,
      'aisleOrder': aisleOrder,
    };
  }
}