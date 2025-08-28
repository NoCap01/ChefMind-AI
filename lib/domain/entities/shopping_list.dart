import 'package:freezed_annotation/freezed_annotation.dart';

part 'shopping_list.freezed.dart';
part 'shopping_list.g.dart';

@freezed
class ShoppingList with _$ShoppingList {
  const factory ShoppingList({
    required String id,
    required String name,
    required String userId,
    required List<ShoppingListItem> items,
    required DateTime createdAt,
    DateTime? updatedAt,
    DateTime? completedAt,
    @Default(false) bool isCompleted,
    @Default(false) bool isShared,
    @Default([]) List<String> sharedWith,
    String? notes,
    @Default(0.0) double estimatedTotal,
    String? storeId,
    String? storeName,
    Map<String, dynamic>? metadata,
  }) = _ShoppingList;

  factory ShoppingList.fromJson(Map<String, dynamic> json) => _$ShoppingListFromJson(json);
}

@freezed
class ShoppingListItem with _$ShoppingListItem {
  const factory ShoppingListItem({
    required String id,
    required String name,
    required double quantity,
    required String unit,
    required String category,
    @Default(false) bool isCompleted,
    @Default(false) bool isUrgent,
    double? estimatedPrice,
    double? actualPrice,
    String? brand,
    String? notes,
    String? recipeId,
    String? recipeName,
    DateTime? addedAt,
    DateTime? completedAt,
    String? addedBy,
    String? completedBy,
    @Default([]) List<String> alternatives,
    String? barcode,
    String? imageUrl,
  }) = _ShoppingListItem;

  factory ShoppingListItem.fromJson(Map<String, dynamic> json) => _$ShoppingListItemFromJson(json);
}

@freezed
class ShoppingListCategory with _$ShoppingListCategory {
  const factory ShoppingListCategory({
    required String id,
    required String name,
    required String icon,
    required String color,
    @Default(0) int sortOrder,
    String? description,
    @Default([]) List<String> commonItems,
    @Default([]) List<String> storeAisles,
  }) = _ShoppingListCategory;

  factory ShoppingListCategory.fromJson(Map<String, dynamic> json) => _$ShoppingListCategoryFromJson(json);
}

// Predefined shopping categories with store layout optimization
class ShoppingCategories {
  static const produce = ShoppingListCategory(
    id: 'produce',
    name: 'Produce',
    icon: '🥬',
    color: '#4CAF50',
    sortOrder: 1,
    description: 'Fresh fruits and vegetables',
    commonItems: ['apples', 'bananas', 'lettuce', 'tomatoes', 'onions'],
    storeAisles: ['Produce Section', 'Fresh Fruits', 'Fresh Vegetables'],
  );

  static const dairy = ShoppingListCategory(
    id: 'dairy',
    name: 'Dairy & Eggs',
    icon: '🥛',
    color: '#2196F3',
    sortOrder: 2,
    description: 'Milk, cheese, yogurt, and eggs',
    commonItems: ['milk', 'cheese', 'yogurt', 'butter', 'eggs'],
    storeAisles: ['Dairy Section', 'Refrigerated'],
  );

  static const meat = ShoppingListCategory(
    id: 'meat',
    name: 'Meat & Seafood',
    icon: '🥩',
    color: '#F44336',
    sortOrder: 3,
    description: 'Fresh and frozen meat, poultry, and seafood',
    commonItems: ['chicken', 'beef', 'pork', 'fish', 'shrimp'],
    storeAisles: ['Meat Department', 'Seafood Counter', 'Deli'],
  );

  static const bakery = ShoppingListCategory(
    id: 'bakery',
    name: 'Bakery',
    icon: '🍞',
    color: '#FF9800',
    sortOrder: 4,
    description: 'Fresh bread, pastries, and baked goods',
    commonItems: ['bread', 'bagels', 'croissants', 'muffins', 'cake'],
    storeAisles: ['Bakery Section', 'Fresh Bread'],
  );

  static const pantryStaples = ShoppingListCategory(
    id: 'pantry_staples',
    name: 'Pantry Staples',
    icon: '🏺',
    color: '#795548',
    sortOrder: 5,
    description: 'Canned goods, oils, spices, and condiments',
    commonItems: ['olive oil', 'salt', 'pepper', 'canned tomatoes', 'pasta'],
    storeAisles: ['Aisle 1', 'Aisle 2', 'Condiments', 'Canned Goods'],
  );

  static const grains = ShoppingListCategory(
    id: 'grains',
    name: 'Grains & Cereals',
    icon: '🌾',
    color: '#607D8B',
    sortOrder: 6,
    description: 'Rice, pasta, bread, and grain products',
    commonItems: ['rice', 'pasta', 'cereal', 'oats', 'quinoa'],
    storeAisles: ['Aisle 3', 'Aisle 4', 'Cereal Aisle'],
  );

  static const frozen = ShoppingListCategory(
    id: 'frozen',
    name: 'Frozen Foods',
    icon: '🧊',
    color: '#00BCD4',
    sortOrder: 7,
    description: 'Frozen vegetables, meals, and ice cream',
    commonItems: ['frozen vegetables', 'ice cream', 'frozen meals', 'frozen fruit'],
    storeAisles: ['Frozen Section', 'Ice Cream Aisle'],
  );

  static const beverages = ShoppingListCategory(
    id: 'beverages',
    name: 'Beverages',
    icon: '🥤',
    color: '#9C27B0',
    sortOrder: 8,
    description: 'Drinks, juices, and beverage ingredients',
    commonItems: ['water', 'juice', 'coffee', 'tea', 'soda'],
    storeAisles: ['Beverage Aisle', 'Water Section'],
  );

  static const snacks = ShoppingListCategory(
    id: 'snacks',
    name: 'Snacks',
    icon: '🍿',
    color: '#FFEB3B',
    sortOrder: 9,
    description: 'Chips, crackers, nuts, and snack foods',
    commonItems: ['chips', 'crackers', 'nuts', 'cookies', 'candy'],
    storeAisles: ['Snack Aisle', 'Candy Aisle'],
  );

  static const household = ShoppingListCategory(
    id: 'household',
    name: 'Household',
    icon: '🧽',
    color: '#9E9E9E',
    sortOrder: 10,
    description: 'Cleaning supplies and household items',
    commonItems: ['paper towels', 'toilet paper', 'dish soap', 'laundry detergent'],
    storeAisles: ['Household Aisle', 'Cleaning Supplies'],
  );

  static List<ShoppingListCategory> get all => [
    produce,
    dairy,
    meat,
    bakery,
    pantryStaples,
    grains,
    frozen,
    beverages,
    snacks,
    household,
  ];

  static ShoppingListCategory? getById(String id) {
    try {
      return all.firstWhere((category) => category.id == id);
    } catch (e) {
      return null;
    }
  }

  static ShoppingListCategory getByName(String name) {
    try {
      return all.firstWhere(
        (category) => category.name.toLowerCase() == name.toLowerCase(),
      );
    } catch (e) {
      return pantryStaples; // Default category
    }
  }

  static List<ShoppingListCategory> getSortedCategories() {
    final categories = List<ShoppingListCategory>.from(all);
    categories.sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
    return categories;
  }
}

@freezed
class ShoppingListStats with _$ShoppingListStats {
  const factory ShoppingListStats({
    required int totalItems,
    required int completedItems,
    required int urgentItems,
    required double estimatedTotal,
    required double actualTotal,
    required Map<String, int> categoryDistribution,
    required DateTime lastUpdated,
    @Default(0) int collaborators,
  }) = _ShoppingListStats;

  factory ShoppingListStats.fromJson(Map<String, dynamic> json) => _$ShoppingListStatsFromJson(json);
}

@freezed
class ShoppingListFilter with _$ShoppingListFilter {
  const factory ShoppingListFilter({
    @Default([]) List<String> categories,
    @Default(false) bool showCompletedOnly,
    @Default(false) bool showUrgentOnly,
    @Default(false) bool showMyItemsOnly,
    String? searchQuery,
    String? addedBy,
    DateTime? addedAfter,
    DateTime? addedBefore,
  }) = _ShoppingListFilter;

  factory ShoppingListFilter.fromJson(Map<String, dynamic> json) => _$ShoppingListFilterFromJson(json);
}

enum ShoppingSortOption {
  category,
  name,
  dateAdded,
  priority,
  price,
  aisle,
}

extension ShoppingSortOptionExtension on ShoppingSortOption {
  String get displayName {
    switch (this) {
      case ShoppingSortOption.category:
        return 'Category';
      case ShoppingSortOption.name:
        return 'Name';
      case ShoppingSortOption.dateAdded:
        return 'Date Added';
      case ShoppingSortOption.priority:
        return 'Priority';
      case ShoppingSortOption.price:
        return 'Price';
      case ShoppingSortOption.aisle:
        return 'Store Aisle';
    }
  }
}

@freezed
class ShoppingListTemplate with _$ShoppingListTemplate {
  const factory ShoppingListTemplate({
    required String id,
    required String name,
    required String description,
    required List<ShoppingListItem> items,
    required String createdBy,
    required DateTime createdAt,
    @Default(false) bool isPublic,
    @Default([]) List<String> tags,
    @Default(0) int usageCount,
    @Default(0.0) double rating,
  }) = _ShoppingListTemplate;

  factory ShoppingListTemplate.fromJson(Map<String, dynamic> json) => _$ShoppingListTemplateFromJson(json);
}

// Common shopping list templates
class ShoppingListTemplates {
  static const weeklyGroceries = ShoppingListTemplate(
    id: 'weekly_groceries',
    name: 'Weekly Groceries',
    description: 'Essential items for weekly grocery shopping',
    items: [],
    createdBy: 'system',
    createdAt: null, // Will be set at runtime
    isPublic: true,
    tags: ['weekly', 'essentials', 'groceries'],
  );

  static const mealPrepBasics = ShoppingListTemplate(
    id: 'meal_prep_basics',
    name: 'Meal Prep Basics',
    description: 'Items needed for weekly meal preparation',
    items: [],
    createdBy: 'system',
    createdAt: null, // Will be set at runtime
    isPublic: true,
    tags: ['meal prep', 'weekly', 'healthy'],
  );

  static const partySupplies = ShoppingListTemplate(
    id: 'party_supplies',
    name: 'Party Supplies',
    description: 'Everything needed for hosting a party',
    items: [],
    createdBy: 'system',
    createdAt: null, // Will be set at runtime
    isPublic: true,
    tags: ['party', 'entertaining', 'special occasion'],
  );

  static List<ShoppingListTemplate> get all => [
    weeklyGroceries,
    mealPrepBasics,
    partySupplies,
  ];
}