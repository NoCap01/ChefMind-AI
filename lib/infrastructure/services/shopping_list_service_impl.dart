import 'dart:math';

import '../../domain/entities/shopping_list.dart';
import '../../domain/entities/pantry_item.dart';
import '../../domain/entities/recipe.dart';
import '../../domain/repositories/shopping_list_repository.dart';
import '../../domain/repositories/pantry_repository.dart';
import '../../domain/services/shopping_list_service.dart';
import '../../domain/exceptions/app_exceptions.dart';

class ShoppingListServiceImpl implements IShoppingListService {
  final IShoppingListRepository _shoppingListRepository;
  final IPantryRepository _pantryRepository;

  ShoppingListServiceImpl(
    this._shoppingListRepository,
    this._pantryRepository,
  );

  @override
  Future<ShoppingList> generateFromRecipes(
    List<Recipe> recipes,
    String userId,
    String listName, {
    bool consolidateIngredients = true,
    bool excludePantryItems = true,
  }) async {
    try {
      final items = <ShoppingListItem>[];
      final ingredientMap = <String, ShoppingListItem>{};

      // Get user's pantry items if excluding them
      List<PantryItem> pantryItems = [];
      if (excludePantryItems) {
        pantryItems = await _pantryRepository.getUserPantryItems(userId);
      }

      // Process each recipe
      for (final recipe in recipes) {
        for (final ingredient in recipe.ingredients) {
          // Check if ingredient is already in pantry with sufficient quantity
          if (excludePantryItems && _hasEnoughInPantry(ingredient, pantryItems)) {
            continue;
          }

          final itemKey = '${ingredient.name.toLowerCase()}_${ingredient.unit}';
          
          if (consolidateIngredients && ingredientMap.containsKey(itemKey)) {
            // Consolidate with existing item
            final existingItem = ingredientMap[itemKey]!;
            final newQuantity = existingItem.quantity + ingredient.quantity;
            
            ingredientMap[itemKey] = existingItem.copyWith(
              quantity: newQuantity,
              recipeId: null, // Multiple recipes
              recipeName: null,
            );
          } else {
            // Create new shopping list item
            final item = ShoppingListItem(
              id: _generateId(),
              name: ingredient.name,
              quantity: ingredient.quantity,
              unit: ingredient.unit,
              category: _getCategoryForIngredient(ingredient.name),
              isUrgent: ingredient.isOptional ? false : true,
              recipeId: recipe.id,
              recipeName: recipe.title,
              addedAt: DateTime.now(),
              addedBy: userId,
              estimatedPrice: _estimatePrice(ingredient.name, ingredient.quantity),
            );
            
            if (consolidateIngredients) {
              ingredientMap[itemKey] = item;
            } else {
              items.add(item);
            }
          }
        }
      }

      // Add consolidated items if consolidation is enabled
      if (consolidateIngredients) {
        items.addAll(ingredientMap.values);
      }

      // Create shopping list
      final shoppingList = ShoppingList(
        id: _generateId(),
        name: listName,
        userId: userId,
        items: items,
        createdAt: DateTime.now(),
        estimatedTotal: items.fold(0.0, (sum, item) => 
          sum + (item.estimatedPrice ?? 0.0) * item.quantity),
      );

      // Categorize and optimize
      final categorizedList = await categorizeItems(shoppingList);
      
      return await _shoppingListRepository.createShoppingList(categorizedList);
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServiceException('Failed to generate shopping list from recipes: $e');
    }
  }

  @override
  Future<ShoppingList> generateFromLowStock(
    String userId,
    String listName, {
    bool includeRecommendations = true,
  }) async {
    try {
      final lowStockItems = await _pantryRepository.getLowStockItems(userId);
      final items = <ShoppingListItem>[];

      // Convert pantry items to shopping list items
      for (final pantryItem in lowStockItems) {
        final restockQuantity = _calculateRestockQuantity(pantryItem);
        
        final item = ShoppingListItem(
          id: _generateId(),
          name: pantryItem.name,
          quantity: restockQuantity,
          unit: pantryItem.unit,
          category: _mapPantryCategoryToShopping(pantryItem.category.id),
          isUrgent: pantryItem.quantity <= 0,
          addedAt: DateTime.now(),
          addedBy: userId,
          estimatedPrice: _estimatePrice(pantryItem.name, restockQuantity),
          notes: pantryItem.quantity <= 0 ? 'Out of stock' : 'Running low',
        );
        
        items.add(item);
      }

      // Add smart recommendations if enabled
      if (includeRecommendations) {
        final recommendations = await _getSmartRecommendations(userId, items);
        items.addAll(recommendations);
      }

      final shoppingList = ShoppingList(
        id: _generateId(),
        name: listName,
        userId: userId,
        items: items,
        createdAt: DateTime.now(),
        estimatedTotal: items.fold(0.0, (sum, item) => 
          sum + (item.estimatedPrice ?? 0.0) * item.quantity),
      );

      return await _shoppingListRepository.createShoppingList(shoppingList);
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServiceException('Failed to generate shopping list from low stock: $e');
    }
  }

  @override
  Future<ShoppingList> generateFromMealPlan(
    String mealPlanId,
    String userId,
    String listName,
  ) async {
    try {
      // This would integrate with meal planning service
      // For now, return empty list
      final shoppingList = ShoppingList(
        id: _generateId(),
        name: listName,
        userId: userId,
        items: [],
        createdAt: DateTime.now(),
      );

      return await _shoppingListRepository.createShoppingList(shoppingList);
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServiceException('Failed to generate shopping list from meal plan: $e');
    }
  }

  @override
  Future<ShoppingList> consolidateItems(ShoppingList shoppingList) async {
    try {
      final consolidatedMap = <String, ShoppingListItem>{};

      for (final item in shoppingList.items) {
        final key = '${item.name.toLowerCase()}_${item.unit}';
        
        if (consolidatedMap.containsKey(key)) {
          final existing = consolidatedMap[key]!;
          consolidatedMap[key] = existing.copyWith(
            quantity: existing.quantity + item.quantity,
            estimatedPrice: _averagePrice(existing.estimatedPrice, item.estimatedPrice),
            isUrgent: existing.isUrgent || item.isUrgent,
            notes: _combineNotes(existing.notes, item.notes),
          );
        } else {
          consolidatedMap[key] = item;
        }
      }

      final consolidatedList = shoppingList.copyWith(
        items: consolidatedMap.values.toList(),
        updatedAt: DateTime.now(),
      );

      return await _shoppingListRepository.updateShoppingList(consolidatedList);
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServiceException('Failed to consolidate shopping list items: $e');
    }
  }

  @override
  Future<ShoppingList> categorizeItems(ShoppingList shoppingList) async {
    try {
      final categorizedItems = shoppingList.items.map((item) {
        final category = _getCategoryForIngredient(item.name);
        return item.copyWith(category: category);
      }).toList();

      // Sort by category order
      categorizedItems.sort((a, b) {
        final categoryA = ShoppingCategories.getById(a.category);
        final categoryB = ShoppingCategories.getById(b.category);
        
        if (categoryA == null && categoryB == null) return 0;
        if (categoryA == null) return 1;
        if (categoryB == null) return -1;
        
        return categoryA.sortOrder.compareTo(categoryB.sortOrder);
      });

      final categorizedList = shoppingList.copyWith(
        items: categorizedItems,
        updatedAt: DateTime.now(),
      );

      return await _shoppingListRepository.updateShoppingList(categorizedList);
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServiceException('Failed to categorize shopping list items: $e');
    }
  }

  @override
  Future<ShoppingList> optimizeForStore(ShoppingList shoppingList, String storeId) async {
    try {
      return await _shoppingListRepository.optimizeForStore(shoppingList.id, storeId);
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServiceException('Failed to optimize shopping list for store: $e');
    }
  }

  @override
  Future<List<ShoppingListItem>> getSmartSuggestions(
    ShoppingList shoppingList,
    String userId,
  ) async {
    try {
      final suggestions = <ShoppingListItem>[];
      
      // Get frequently bought items
      final frequentItems = await getFrequentlyBoughtItems(userId);
      
      // Get seasonal recommendations
      final seasonalItems = await getSeasonalRecommendations(userId);
      
      // Combine and filter suggestions
      final allSuggestions = [...frequentItems, ...seasonalItems];
      final existingItemNames = shoppingList.items.map((item) => item.name.toLowerCase()).toSet();
      
      for (final suggestion in allSuggestions) {
        if (!existingItemNames.contains(suggestion.name.toLowerCase())) {
          suggestions.add(suggestion);
        }
      }
      
      return suggestions.take(10).toList();
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServiceException('Failed to get smart suggestions: $e');
    }
  }

  @override
  Future<double> calculateEstimatedTotal(ShoppingList shoppingList) async {
    try {
      double total = 0.0;
      
      for (final item in shoppingList.items) {
        if (item.estimatedPrice != null) {
          total += item.estimatedPrice! * item.quantity;
        } else {
          // Estimate price if not available
          final estimatedPrice = _estimatePrice(item.name, item.quantity);
          total += estimatedPrice;
        }
      }
      
      return total;
    } catch (e) {
      throw ServiceException('Failed to calculate estimated total: $e');
    }
  }

  @override
  Future<Map<String, double>> getPriceComparison(
    ShoppingListItem item,
    List<String> storeIds,
  ) async {
    try {
      final priceComparison = <String, double>{};
      
      // This would integrate with price comparison services
      // For now, return mock data
      for (final storeId in storeIds) {
        final basePrice = _estimatePrice(item.name, 1.0);
        final variation = Random().nextDouble() * 0.4 - 0.2; // ±20% variation
        priceComparison[storeId] = basePrice * (1 + variation);
      }
      
      return priceComparison;
    } catch (e) {
      throw ServiceException('Failed to get price comparison: $e');
    }
  }

  @override
  Future<void> shareWithCollaborators(
    String listId,
    List<String> collaboratorIds, {
    String? message,
  }) async {
    try {
      await _shoppingListRepository.shareShoppingList(listId, collaboratorIds);
      
      // Send notifications to collaborators
      // This would integrate with notification service
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServiceException('Failed to share shopping list: $e');
    }
  }

  @override
  Future<ShoppingList> syncCollaborativeChanges(String listId) async {
    try {
      final shoppingList = await _shoppingListRepository.getShoppingListById(listId);
      if (shoppingList == null) {
        throw const NotFoundException('Shopping list not found');
      }
      
      // In a real implementation, this would sync changes from all collaborators
      return shoppingList;
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServiceException('Failed to sync collaborative changes: $e');
    }
  }

  @override
  Future<ShoppingListAnalytics> getShoppingAnalytics(String userId) async {
    try {
      // This would analyze user's shopping history
      // For now, return mock analytics
      return const ShoppingListAnalytics(
        averageListSize: 15.5,
        averageSpending: 85.50,
        mostBoughtCategories: {
          'produce': 25,
          'dairy': 20,
          'meat': 15,
        },
        categorySpending: {
          'produce': 120.50,
          'dairy': 95.25,
          'meat': 180.75,
        },
        frequentItems: ['milk', 'bread', 'eggs', 'bananas', 'chicken'],
        savingsFromDeals: 45.25,
        completedLists: 12,
        averageShoppingTime: Duration(minutes: 45),
      );
    } catch (e) {
      throw ServiceException('Failed to get shopping analytics: $e');
    }
  }

  @override
  Future<ShoppingList> importFromText(
    String text,
    String userId,
    String listName,
  ) async {
    try {
      final lines = text.split('\n').where((line) => line.trim().isNotEmpty);
      final items = <ShoppingListItem>[];

      for (final line in lines) {
        final item = _parseTextLine(line, userId);
        if (item != null) {
          items.add(item);
        }
      }

      final shoppingList = ShoppingList(
        id: _generateId(),
        name: listName,
        userId: userId,
        items: items,
        createdAt: DateTime.now(),
      );

      return await _shoppingListRepository.createShoppingList(shoppingList);
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServiceException('Failed to import shopping list from text: $e');
    }
  }

  @override
  Future<String> exportShoppingList(
    ShoppingList shoppingList,
    ExportFormat format,
  ) async {
    try {
      switch (format) {
        case ExportFormat.text:
          return _exportAsText(shoppingList);
        case ExportFormat.csv:
          return _exportAsCsv(shoppingList);
        case ExportFormat.json:
          return _exportAsJson(shoppingList);
        case ExportFormat.pdf:
          return _exportAsPdf(shoppingList);
      }
    } catch (e) {
      throw ServiceException('Failed to export shopping list: $e');
    }
  }

  @override
  Future<List<ShoppingListItem>> getFrequentlyBoughtItems(String userId) async {
    try {
      // This would analyze user's purchase history
      // For now, return common items
      final commonItems = [
        'Milk', 'Bread', 'Eggs', 'Bananas', 'Chicken Breast',
        'Rice', 'Pasta', 'Onions', 'Tomatoes', 'Cheese',
      ];

      return commonItems.map((name) => ShoppingListItem(
        id: _generateId(),
        name: name,
        quantity: 1.0,
        unit: 'piece',
        category: _getCategoryForIngredient(name),
        addedAt: DateTime.now(),
        addedBy: userId,
        estimatedPrice: _estimatePrice(name, 1.0),
      )).toList();
    } catch (e) {
      throw ServiceException('Failed to get frequently bought items: $e');
    }
  }

  @override
  Future<List<ShoppingListItem>> getSeasonalRecommendations(String userId) async {
    try {
      final now = DateTime.now();
      final month = now.month;
      
      List<String> seasonalItems = [];
      
      // Spring (March-May)
      if (month >= 3 && month <= 5) {
        seasonalItems = ['Asparagus', 'Strawberries', 'Peas', 'Artichokes'];
      }
      // Summer (June-August)
      else if (month >= 6 && month <= 8) {
        seasonalItems = ['Tomatoes', 'Corn', 'Peaches', 'Zucchini'];
      }
      // Fall (September-November)
      else if (month >= 9 && month <= 11) {
        seasonalItems = ['Pumpkin', 'Apples', 'Sweet Potatoes', 'Brussels Sprouts'];
      }
      // Winter (December-February)
      else {
        seasonalItems = ['Citrus Fruits', 'Root Vegetables', 'Cabbage', 'Pomegranates'];
      }

      return seasonalItems.map((name) => ShoppingListItem(
        id: _generateId(),
        name: name,
        quantity: 1.0,
        unit: 'piece',
        category: _getCategoryForIngredient(name),
        addedAt: DateTime.now(),
        addedBy: userId,
        estimatedPrice: _estimatePrice(name, 1.0),
        notes: 'Seasonal recommendation',
      )).toList();
    } catch (e) {
      throw ServiceException('Failed to get seasonal recommendations: $e');
    }
  }

  @override
  Future<Map<String, bool>> checkItemAvailability(
    ShoppingListItem item,
    List<String> storeIds,
  ) async {
    try {
      final availability = <String, bool>{};
      
      // This would check real store inventory
      // For now, return mock availability
      for (final storeId in storeIds) {
        availability[storeId] = Random().nextBool();
      }
      
      return availability;
    } catch (e) {
      throw ServiceException('Failed to check item availability: $e');
    }
  }

  @override
  Future<List<ShoppingListItem>> getAlternativeProducts(ShoppingListItem item) async {
    try {
      // This would suggest alternative products
      // For now, return basic alternatives
      final alternatives = <ShoppingListItem>[];
      
      if (item.name.toLowerCase().contains('milk')) {
        alternatives.addAll([
          item.copyWith(id: _generateId(), name: 'Almond Milk'),
          item.copyWith(id: _generateId(), name: 'Oat Milk'),
          item.copyWith(id: _generateId(), name: 'Soy Milk'),
        ]);
      }
      
      return alternatives;
    } catch (e) {
      throw ServiceException('Failed to get alternative products: $e');
    }
  }

  @override
  Future<void> trackShoppingSession(
    String listId,
    DateTime startTime,
    DateTime endTime,
    double totalSpent,
  ) async {
    try {
      // This would track shopping analytics
      // For now, just log the session
      final duration = endTime.difference(startTime);
      
      // Update shopping list with completion data
      final shoppingList = await _shoppingListRepository.getShoppingListById(listId);
      if (shoppingList != null) {
        final updatedList = shoppingList.copyWith(
          isCompleted: true,
          completedAt: endTime,
          estimatedTotal: totalSpent,
        );
        
        await _shoppingListRepository.updateShoppingList(updatedList);
      }
    } catch (e) {
      throw ServiceException('Failed to track shopping session: $e');
    }
  }

  // Helper methods
  String _generateId() {
    return DateTime.now().millisecondsSinceEpoch.toString() + 
           Random().nextInt(1000).toString();
  }

  bool _hasEnoughInPantry(Ingredient ingredient, List<PantryItem> pantryItems) {
    for (final pantryItem in pantryItems) {
      if (pantryItem.name.toLowerCase() == ingredient.name.toLowerCase() &&
          pantryItem.unit == ingredient.unit &&
          pantryItem.quantity >= ingredient.quantity) {
        return true;
      }
    }
    return false;
  }

  String _getCategoryForIngredient(String ingredientName) {
    final name = ingredientName.toLowerCase();
    
    // Produce
    if (_isInCategory(name, ['apple', 'banana', 'orange', 'berry', 'grape', 'lemon', 'lime'])) {
      return 'produce';
    }
    if (_isInCategory(name, ['carrot', 'onion', 'potato', 'tomato', 'lettuce', 'spinach', 'broccoli'])) {
      return 'produce';
    }
    
    // Dairy
    if (_isInCategory(name, ['milk', 'cheese', 'yogurt', 'butter', 'cream', 'egg'])) {
      return 'dairy';
    }
    
    // Meat
    if (_isInCategory(name, ['chicken', 'beef', 'pork', 'fish', 'salmon', 'shrimp', 'turkey'])) {
      return 'meat';
    }
    
    // Bakery
    if (_isInCategory(name, ['bread', 'bagel', 'croissant', 'muffin', 'cake', 'pastry'])) {
      return 'bakery';
    }
    
    // Grains
    if (_isInCategory(name, ['rice', 'pasta', 'cereal', 'oats', 'quinoa', 'flour'])) {
      return 'grains';
    }
    
    // Frozen
    if (name.contains('frozen')) {
      return 'frozen';
    }
    
    // Beverages
    if (_isInCategory(name, ['water', 'juice', 'coffee', 'tea', 'soda', 'beer', 'wine'])) {
      return 'beverages';
    }
    
    // Snacks
    if (_isInCategory(name, ['chips', 'crackers', 'nuts', 'cookies', 'candy', 'chocolate'])) {
      return 'snacks';
    }
    
    // Default to pantry staples
    return 'pantry_staples';
  }

  bool _isInCategory(String itemName, List<String> categoryItems) {
    return categoryItems.any((item) => itemName.contains(item));
  }

  String _mapPantryCategoryToShopping(String pantryCategoryId) {
    switch (pantryCategoryId) {
      case 'vegetables':
      case 'fruits':
        return 'produce';
      case 'dairy':
        return 'dairy';
      case 'meat':
        return 'meat';
      case 'grains':
        return 'grains';
      case 'frozen':
        return 'frozen';
      case 'beverages':
        return 'beverages';
      case 'snacks':
        return 'snacks';
      case 'baking':
        return 'grains';
      default:
        return 'pantry_staples';
    }
  }

  double _calculateRestockQuantity(PantryItem pantryItem) {
    if (pantryItem.minQuantity != null && pantryItem.minQuantity! > 0) {
      return pantryItem.minQuantity! * 2; // Restock to twice the minimum
    }
    
    // Default restock quantities by category
    switch (pantryItem.category.id) {
      case 'dairy':
      case 'meat':
        return 2.0; // Perishables: smaller quantities
      case 'vegetables':
      case 'fruits':
        return 3.0; // Fresh produce: moderate quantities
      case 'grains':
      case 'pantry_staples':
        return 5.0; // Shelf-stable: larger quantities
      default:
        return 2.0;
    }
  }

  double _estimatePrice(String itemName, double quantity) {
    // Basic price estimation
    final name = itemName.toLowerCase();
    double basePrice = 2.0; // Default price per unit
    
    if (_isInCategory(name, ['meat', 'fish', 'salmon', 'beef'])) {
      basePrice = 8.0;
    } else if (_isInCategory(name, ['cheese', 'butter', 'cream'])) {
      basePrice = 4.0;
    } else if (_isInCategory(name, ['milk', 'yogurt', 'eggs'])) {
      basePrice = 3.0;
    } else if (_isInCategory(name, ['bread', 'bagel', 'pastry'])) {
      basePrice = 3.5;
    } else if (_isInCategory(name, ['apple', 'banana', 'orange'])) {
      basePrice = 1.5;
    }
    
    return basePrice * quantity;
  }

  Future<List<ShoppingListItem>> _getSmartRecommendations(
    String userId,
    List<ShoppingListItem> currentItems,
  ) async {
    final recommendations = <ShoppingListItem>[];
    
    // Add complementary items based on what's already in the list
    final currentItemNames = currentItems.map((item) => item.name.toLowerCase()).toSet();
    
    // If they have pasta, suggest pasta sauce
    if (currentItemNames.any((name) => name.contains('pasta'))) {
      if (!currentItemNames.any((name) => name.contains('sauce'))) {
        recommendations.add(ShoppingListItem(
          id: _generateId(),
          name: 'Pasta Sauce',
          quantity: 1.0,
          unit: 'jar',
          category: 'pantry_staples',
          addedAt: DateTime.now(),
          addedBy: userId,
          estimatedPrice: 2.50,
          notes: 'Suggested complement',
        ));
      }
    }
    
    return recommendations;
  }

  double? _averagePrice(double? price1, double? price2) {
    if (price1 == null && price2 == null) return null;
    if (price1 == null) return price2;
    if (price2 == null) return price1;
    return (price1 + price2) / 2;
  }

  String? _combineNotes(String? notes1, String? notes2) {
    if (notes1 == null && notes2 == null) return null;
    if (notes1 == null) return notes2;
    if (notes2 == null) return notes1;
    return '$notes1; $notes2';
  }

  ShoppingListItem? _parseTextLine(String line, String userId) {
    // Basic text parsing - could be enhanced with NLP
    final trimmed = line.trim();
    if (trimmed.isEmpty) return null;
    
    // Try to extract quantity and unit
    final regex = RegExp(r'^(\d+(?:\.\d+)?)\s*(\w+)?\s+(.+)$');
    final match = regex.firstMatch(trimmed);
    
    if (match != null) {
      final quantity = double.tryParse(match.group(1)!) ?? 1.0;
      final unit = match.group(2) ?? 'piece';
      final name = match.group(3)!;
      
      return ShoppingListItem(
        id: _generateId(),
        name: name,
        quantity: quantity,
        unit: unit,
        category: _getCategoryForIngredient(name),
        addedAt: DateTime.now(),
        addedBy: userId,
        estimatedPrice: _estimatePrice(name, quantity),
      );
    } else {
      // Just treat the whole line as item name
      return ShoppingListItem(
        id: _generateId(),
        name: trimmed,
        quantity: 1.0,
        unit: 'piece',
        category: _getCategoryForIngredient(trimmed),
        addedAt: DateTime.now(),
        addedBy: userId,
        estimatedPrice: _estimatePrice(trimmed, 1.0),
      );
    }
  }

  String _exportAsText(ShoppingList shoppingList) {
    final buffer = StringBuffer();
    buffer.writeln('Shopping List: ${shoppingList.name}');
    buffer.writeln('Created: ${shoppingList.createdAt}');
    buffer.writeln('');
    
    final groupedItems = <String, List<ShoppingListItem>>{};
    for (final item in shoppingList.items) {
      groupedItems.putIfAbsent(item.category, () => []).add(item);
    }
    
    for (final category in groupedItems.keys) {
      final categoryName = ShoppingCategories.getById(category)?.name ?? category;
      buffer.writeln('$categoryName:');
      
      for (final item in groupedItems[category]!) {
        final status = item.isCompleted ? '✓' : '☐';
        buffer.writeln('  $status ${item.quantity} ${item.unit} ${item.name}');
      }
      buffer.writeln('');
    }
    
    return buffer.toString();
  }

  String _exportAsCsv(ShoppingList shoppingList) {
    final buffer = StringBuffer();
    buffer.writeln('Name,Quantity,Unit,Category,Completed,Estimated Price');
    
    for (final item in shoppingList.items) {
      buffer.writeln('${item.name},${item.quantity},${item.unit},${item.category},${item.isCompleted},${item.estimatedPrice ?? ''}');
    }
    
    return buffer.toString();
  }

  String _exportAsJson(ShoppingList shoppingList) {
    // This would use proper JSON encoding
    return shoppingList.toString(); // Simplified for now
  }

  String _exportAsPdf(ShoppingList shoppingList) {
    // This would generate a PDF document
    // For now, return text format
    return _exportAsText(shoppingList);
  }
}