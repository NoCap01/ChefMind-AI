import 'package:hive/hive.dart';
import '../domain/entities/pantry_item.dart';

class PantryService {
  static const String _boxName = 'pantry_items';
  Box<PantryItem>? _box;

  Future<void> initialize() async {
    if (!Hive.isBoxOpen(_boxName)) {
      _box = await Hive.openBox<PantryItem>(_boxName);
    } else {
      _box = Hive.box<PantryItem>(_boxName);
    }
  }

  Box<PantryItem> get _pantryBox {
    if (_box == null || !_box!.isOpen) {
      throw Exception('Pantry service not initialized. Call initialize() first.');
    }
    return _box!;
  }

  // Add new pantry item
  Future<void> addItem(PantryItem item) async {
    await _pantryBox.put(item.id, item);
  }

  // Get all pantry items
  List<PantryItem> getAllItems() {
    return _pantryBox.values.toList();
  }

  // Get item by ID
  PantryItem? getItem(String id) {
    return _pantryBox.get(id);
  }

  // Update existing item
  Future<void> updateItem(PantryItem item) async {
    item.updatedAt = DateTime.now();
    await _pantryBox.put(item.id, item);
  }

  // Delete item
  Future<void> deleteItem(String id) async {
    await _pantryBox.delete(id);
  }

  // Get items by category
  List<PantryItem> getItemsByCategory(String category) {
    return _pantryBox.values
        .where((item) => item.category == category)
        .toList();
  }

  // Get low stock items
  List<PantryItem> getLowStockItems() {
    return _pantryBox.values
        .where((item) => item.isLowStock)
        .toList();
  }

  // Get expiring items (within 3 days)
  List<PantryItem> getExpiringSoonItems() {
    return _pantryBox.values
        .where((item) => item.isExpiringSoon)
        .toList();
  }

  // Get expired items
  List<PantryItem> getExpiredItems() {
    return _pantryBox.values
        .where((item) => item.isExpired)
        .toList();
  }

  // Search items by name
  List<PantryItem> searchItems(String query) {
    final lowercaseQuery = query.toLowerCase();
    return _pantryBox.values
        .where((item) => item.name.toLowerCase().contains(lowercaseQuery))
        .toList();
  }

  // Update item quantity
  Future<void> updateItemQuantity(String id, double newQuantity) async {
    final item = _pantryBox.get(id);
    if (item != null) {
      item.updateQuantity(newQuantity);
      await _pantryBox.put(id, item);
    }
  }

  // Add to item quantity
  Future<void> addToItemQuantity(String id, double amount) async {
    final item = _pantryBox.get(id);
    if (item != null) {
      item.updateStock(amount);
      await _pantryBox.put(id, item);
    }
  }

  // Get all categories
  List<String> getAllCategories() {
    final categories = <String>{};
    for (final item in _pantryBox.values) {
      if (item.category != null) {
        categories.add(item.category!);
      }
    }
    return categories.toList()..sort();
  }

  // Check for notifications (low stock + expiring)
  Map<String, List<PantryItem>> getNotifications() {
    return {
      'lowStock': getLowStockItems(),
      'expiringSoon': getExpiringSoonItems(),
      'expired': getExpiredItems(),
    };
  }

  // Clear all items
  Future<void> clearAll() async {
    await _pantryBox.clear();
  }

  // Get items count
  int get itemCount => _pantryBox.length;

  // Check if item exists by name
  bool itemExists(String name) {
    return _pantryBox.values.any((item) => 
        item.name.toLowerCase() == name.toLowerCase());
  }

  // Find similar items by name
  List<PantryItem> findSimilarItems(String name) {
    final lowercaseName = name.toLowerCase();
    return _pantryBox.values
        .where((item) => item.name.toLowerCase().contains(lowercaseName))
        .toList();
  }
}