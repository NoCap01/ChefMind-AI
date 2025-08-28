import 'package:freezed_annotation/freezed_annotation.dart';

part 'pantry_item.freezed.dart';
part 'pantry_item.g.dart';

@freezed
class PantryItem with _$PantryItem {
  const factory PantryItem({
    required String id,
    required String name,
    required double quantity,
    required String unit,
    required PantryCategory category,
    DateTime? expiryDate,
    DateTime? purchaseDate,
    String? brand,
    String? notes,
    String? barcode,
    String? imageUrl,
    required DateTime createdAt,
    DateTime? updatedAt,
    @Default(false) bool isLowStock,
    double? minQuantity,
    String? location, // e.g., "Fridge", "Pantry", "Freezer"
  }) = _PantryItem;

  factory PantryItem.fromJson(Map<String, dynamic> json) => _$PantryItemFromJson(json);
}

@freezed
class PantryCategory with _$PantryCategory {
  const factory PantryCategory({
    required String id,
    required String name,
    required String icon,
    required String color,
    String? description,
    @Default([]) List<String> commonItems,
  }) = _PantryCategory;

  factory PantryCategory.fromJson(Map<String, dynamic> json) => _$PantryCategoryFromJson(json);
}

// Predefined pantry categories
class PantryCategories {
  static const vegetables = PantryCategory(
    id: 'vegetables',
    name: 'Vegetables',
    icon: '🥕',
    color: '#4CAF50',
    description: 'Fresh and frozen vegetables',
    commonItems: ['carrots', 'onions', 'potatoes', 'tomatoes', 'lettuce'],
  );

  static const fruits = PantryCategory(
    id: 'fruits',
    name: 'Fruits',
    icon: '🍎',
    color: '#FF9800',
    description: 'Fresh and dried fruits',
    commonItems: ['apples', 'bananas', 'oranges', 'berries', 'grapes'],
  );

  static const dairy = PantryCategory(
    id: 'dairy',
    name: 'Dairy',
    icon: '🥛',
    color: '#2196F3',
    description: 'Milk, cheese, yogurt, and dairy products',
    commonItems: ['milk', 'cheese', 'yogurt', 'butter', 'eggs'],
  );

  static const meat = PantryCategory(
    id: 'meat',
    name: 'Meat & Seafood',
    icon: '🥩',
    color: '#F44336',
    description: 'Fresh and frozen meat, poultry, and seafood',
    commonItems: ['chicken', 'beef', 'pork', 'fish', 'shrimp'],
  );

  static const grains = PantryCategory(
    id: 'grains',
    name: 'Grains & Cereals',
    icon: '🌾',
    color: '#795548',
    description: 'Rice, pasta, bread, and grain products',
    commonItems: ['rice', 'pasta', 'bread', 'oats', 'quinoa'],
  );

  static const pantryStaples = PantryCategory(
    id: 'pantry_staples',
    name: 'Pantry Staples',
    icon: '🏺',
    color: '#607D8B',
    description: 'Canned goods, oils, spices, and condiments',
    commonItems: ['olive oil', 'salt', 'pepper', 'garlic', 'onion powder'],
  );

  static const beverages = PantryCategory(
    id: 'beverages',
    name: 'Beverages',
    icon: '🥤',
    color: '#9C27B0',
    description: 'Drinks, juices, and beverage ingredients',
    commonItems: ['water', 'juice', 'coffee', 'tea', 'soda'],
  );

  static const frozen = PantryCategory(
    id: 'frozen',
    name: 'Frozen Foods',
    icon: '🧊',
    color: '#00BCD4',
    description: 'Frozen vegetables, meals, and ice cream',
    commonItems: ['frozen vegetables', 'ice cream', 'frozen meals', 'frozen fruit'],
  );

  static const snacks = PantryCategory(
    id: 'snacks',
    name: 'Snacks',
    icon: '🍿',
    color: '#FFEB3B',
    description: 'Chips, crackers, nuts, and snack foods',
    commonItems: ['chips', 'crackers', 'nuts', 'cookies', 'candy'],
  );

  static const baking = PantryCategory(
    id: 'baking',
    name: 'Baking',
    icon: '🧁',
    color: '#E91E63',
    description: 'Flour, sugar, baking powder, and baking ingredients',
    commonItems: ['flour', 'sugar', 'baking powder', 'vanilla', 'chocolate chips'],
  );

  static List<PantryCategory> get all => [
    vegetables,
    fruits,
    dairy,
    meat,
    grains,
    pantryStaples,
    beverages,
    frozen,
    snacks,
    baking,
  ];

  static PantryCategory? getById(String id) {
    try {
      return all.firstWhere((category) => category.id == id);
    } catch (e) {
      return null;
    }
  }

  static PantryCategory getByName(String name) {
    try {
      return all.firstWhere(
        (category) => category.name.toLowerCase() == name.toLowerCase(),
      );
    } catch (e) {
      return pantryStaples; // Default category
    }
  }
}

@freezed
class PantryStats with _$PantryStats {
  const factory PantryStats({
    required int totalItems,
    required int expiringItems,
    required int lowStockItems,
    required Map<String, int> categoryDistribution,
    required double totalValue,
    required int itemsAddedThisWeek,
    required int itemsUsedThisWeek,
  }) = _PantryStats;

  factory PantryStats.fromJson(Map<String, dynamic> json) => _$PantryStatsFromJson(json);
}

@freezed
class PantryFilter with _$PantryFilter {
  const factory PantryFilter({
    @Default([]) List<String> categories,
    @Default([]) List<String> locations,
    @Default(false) bool showExpiringOnly,
    @Default(false) bool showLowStockOnly,
    DateTime? expiryBefore,
    DateTime? expiryAfter,
    String? searchQuery,
  }) = _PantryFilter;

  factory PantryFilter.fromJson(Map<String, dynamic> json) => _$PantryFilterFromJson(json);
}

enum PantrySortOption {
  name,
  expiryDate,
  quantity,
  category,
  dateAdded,
}

extension PantrySortOptionExtension on PantrySortOption {
  String get displayName {
    switch (this) {
      case PantrySortOption.name:
        return 'Name';
      case PantrySortOption.expiryDate:
        return 'Expiry Date';
      case PantrySortOption.quantity:
        return 'Quantity';
      case PantrySortOption.category:
        return 'Category';
      case PantrySortOption.dateAdded:
        return 'Date Added';
    }
  }
}