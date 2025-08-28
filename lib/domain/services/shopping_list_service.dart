import '../entities/shopping_list.dart';
import '../entities/pantry_item.dart';
import '../entities/recipe.dart';

abstract class IShoppingListService {
  /// Generate shopping list from selected recipes
  Future<ShoppingList> generateFromRecipes(
    List<Recipe> recipes,
    String userId,
    String listName, {
    bool consolidateIngredients = true,
    bool excludePantryItems = true,
  });

  /// Generate shopping list from low stock pantry items
  Future<ShoppingList> generateFromLowStock(
    String userId,
    String listName, {
    bool includeRecommendations = true,
  });

  /// Generate shopping list from meal plan
  Future<ShoppingList> generateFromMealPlan(
    String mealPlanId,
    String userId,
    String listName,
  );

  /// Consolidate duplicate items in shopping list
  Future<ShoppingList> consolidateItems(ShoppingList shoppingList);

  /// Categorize shopping list items
  Future<ShoppingList> categorizeItems(ShoppingList shoppingList);

  /// Optimize shopping list for store layout
  Future<ShoppingList> optimizeForStore(ShoppingList shoppingList, String storeId);

  /// Get smart suggestions for shopping list
  Future<List<ShoppingListItem>> getSmartSuggestions(
    ShoppingList shoppingList,
    String userId,
  );

  /// Calculate estimated total cost
  Future<double> calculateEstimatedTotal(ShoppingList shoppingList);

  /// Get price comparison across stores
  Future<Map<String, double>> getPriceComparison(
    ShoppingListItem item,
    List<String> storeIds,
  );

  /// Share shopping list with collaborators
  Future<void> shareWithCollaborators(
    String listId,
    List<String> collaboratorIds,
    {String? message}
  );

  /// Sync collaborative changes
  Future<ShoppingList> syncCollaborativeChanges(String listId);

  /// Get shopping list analytics
  Future<ShoppingListAnalytics> getShoppingAnalytics(String userId);

  /// Import shopping list from text
  Future<ShoppingList> importFromText(
    String text,
    String userId,
    String listName,
  );

  /// Export shopping list to various formats
  Future<String> exportShoppingList(
    ShoppingList shoppingList,
    ExportFormat format,
  );

  /// Get frequently bought items
  Future<List<ShoppingListItem>> getFrequentlyBoughtItems(String userId);

  /// Get seasonal recommendations
  Future<List<ShoppingListItem>> getSeasonalRecommendations(String userId);

  /// Check item availability in stores
  Future<Map<String, bool>> checkItemAvailability(
    ShoppingListItem item,
    List<String> storeIds,
  );

  /// Get alternative products
  Future<List<ShoppingListItem>> getAlternativeProducts(ShoppingListItem item);

  /// Track shopping completion time
  Future<void> trackShoppingSession(
    String listId,
    DateTime startTime,
    DateTime endTime,
    double totalSpent,
  );
}

class ShoppingListAnalytics {
  final double averageListSize;
  final double averageSpending;
  final Map<String, int> mostBoughtCategories;
  final Map<String, double> categorySpending;
  final List<String> frequentItems;
  final double savingsFromDeals;
  final int completedLists;
  final Duration averageShoppingTime;

  const ShoppingListAnalytics({
    required this.averageListSize,
    required this.averageSpending,
    required this.mostBoughtCategories,
    required this.categorySpending,
    required this.frequentItems,
    required this.savingsFromDeals,
    required this.completedLists,
    required this.averageShoppingTime,
  });

  factory ShoppingListAnalytics.fromJson(Map<String, dynamic> json) {
    return ShoppingListAnalytics(
      averageListSize: (json['averageListSize'] as num).toDouble(),
      averageSpending: (json['averageSpending'] as num).toDouble(),
      mostBoughtCategories: Map<String, int>.from(json['mostBoughtCategories'] as Map),
      categorySpending: Map<String, double>.from(json['categorySpending'] as Map),
      frequentItems: List<String>.from(json['frequentItems'] as List),
      savingsFromDeals: (json['savingsFromDeals'] as num).toDouble(),
      completedLists: json['completedLists'] as int,
      averageShoppingTime: Duration(seconds: json['averageShoppingTimeSeconds'] as int),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'averageListSize': averageListSize,
      'averageSpending': averageSpending,
      'mostBoughtCategories': mostBoughtCategories,
      'categorySpending': categorySpending,
      'frequentItems': frequentItems,
      'savingsFromDeals': savingsFromDeals,
      'completedLists': completedLists,
      'averageShoppingTimeSeconds': averageShoppingTime.inSeconds,
    };
  }
}

enum ExportFormat {
  text,
  csv,
  pdf,
  json,
}

extension ExportFormatExtension on ExportFormat {
  String get displayName {
    switch (this) {
      case ExportFormat.text:
        return 'Text';
      case ExportFormat.csv:
        return 'CSV';
      case ExportFormat.pdf:
        return 'PDF';
      case ExportFormat.json:
        return 'JSON';
    }
  }

  String get fileExtension {
    switch (this) {
      case ExportFormat.text:
        return '.txt';
      case ExportFormat.csv:
        return '.csv';
      case ExportFormat.pdf:
        return '.pdf';
      case ExportFormat.json:
        return '.json';
    }
  }
}

class ShoppingListGenerationRequest {
  final String userId;
  final String listName;
  final List<Recipe>? recipes;
  final List<PantryItem>? pantryItems;
  final String? mealPlanId;
  final bool consolidateIngredients;
  final bool excludePantryItems;
  final bool includeRecommendations;
  final String? storeId;
  final List<String>? categories;

  const ShoppingListGenerationRequest({
    required this.userId,
    required this.listName,
    this.recipes,
    this.pantryItems,
    this.mealPlanId,
    this.consolidateIngredients = true,
    this.excludePantryItems = true,
    this.includeRecommendations = false,
    this.storeId,
    this.categories,
  });
}

class ShoppingListOptimization {
  final ShoppingList optimizedList;
  final Map<String, int> aisleOrder;
  final double estimatedShoppingTime;
  final List<String> optimizationTips;

  const ShoppingListOptimization({
    required this.optimizedList,
    required this.aisleOrder,
    required this.estimatedShoppingTime,
    required this.optimizationTips,
  });
}

class CollaborativeUpdate {
  final String itemId;
  final String action; // 'added', 'completed', 'updated', 'removed'
  final String userId;
  final String userName;
  final DateTime timestamp;
  final Map<String, dynamic>? data;

  const CollaborativeUpdate({
    required this.itemId,
    required this.action,
    required this.userId,
    required this.userName,
    required this.timestamp,
    this.data,
  });

  factory CollaborativeUpdate.fromJson(Map<String, dynamic> json) {
    return CollaborativeUpdate(
      itemId: json['itemId'] as String,
      action: json['action'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      data: json['data'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'itemId': itemId,
      'action': action,
      'userId': userId,
      'userName': userName,
      'timestamp': timestamp.toIso8601String(),
      'data': data,
    };
  }
}