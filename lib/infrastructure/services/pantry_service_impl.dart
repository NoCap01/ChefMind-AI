import 'dart:math';

import '../../domain/entities/pantry_item.dart';
import '../../domain/repositories/pantry_repository.dart';
import '../../domain/services/pantry_service.dart';
import '../../domain/exceptions/app_exceptions.dart';
import 'barcode_scanner_service.dart';

class PantryServiceImpl implements IPantryService {
  final IPantryRepository _repository;
  final IBarcodeScannerService _barcodeService;

  PantryServiceImpl(this._repository, [IBarcodeScannerService? barcodeService])
      : _barcodeService = barcodeService ?? BarcodeScannerService.instance;

  @override
  Future<PantryItem> addItemWithBarcode(String barcode, String userId) async {
    try {
      // Check if item with barcode already exists
      final existingItem = await _repository.getPantryItemByBarcode(userId, barcode);
      if (existingItem != null) {
        throw ConflictException('Item with this barcode already exists in pantry');
      }

      // Get product information from barcode service
      final productInfo = await _barcodeService.getProductInfo(barcode);
      
      final item = PantryItem(
        id: _generateId(),
        name: productInfo?.name ?? 'Unknown Product',
        quantity: 1.0,
        unit: productInfo?.unit ?? 'piece',
        category: _getCategoryFromProductInfo(productInfo),
        barcode: barcode,
        brand: productInfo?.brand,
        notes: productInfo?.description,
        createdAt: DateTime.now(),
      );

      return await _repository.addPantryItem(item);
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServiceException('Failed to add item with barcode: $e');
    }
  }

  @override
  Future<List<ExpiryNotification>> getExpiryNotifications(String userId) async {
    try {
      final expiringItems = await _repository.getExpiringItems(userId, 7);
      final notifications = <ExpiryNotification>[];

      for (final item in expiringItems) {
        if (item.expiryDate == null) continue;

        final daysUntilExpiry = item.expiryDate!.difference(DateTime.now()).inDays;
        final priority = _getNotificationPriority(daysUntilExpiry);
        final suggestedRecipes = await _getSuggestedRecipesForItem(item);

        notifications.add(ExpiryNotification(
          itemId: item.id,
          itemName: item.name,
          expiryDate: item.expiryDate!,
          daysUntilExpiry: daysUntilExpiry,
          priority: priority,
          suggestedRecipes: suggestedRecipes,
        ));
      }

      // Sort by priority and expiry date
      notifications.sort((a, b) {
        final priorityComparison = b.priority.index.compareTo(a.priority.index);
        if (priorityComparison != 0) return priorityComparison;
        return a.daysUntilExpiry.compareTo(b.daysUntilExpiry);
      });

      return notifications;
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServiceException('Failed to get expiry notifications: $e');
    }
  }

  @override
  Future<List<String>> suggestRecipesForExpiringItems(String userId) async {
    try {
      final expiringItems = await _repository.getExpiringItems(userId, 7);
      final allSuggestions = <String>[];

      for (final item in expiringItems) {
        final suggestions = await _getSuggestedRecipesForItem(item);
        allSuggestions.addAll(suggestions);
      }

      // Remove duplicates and return top suggestions
      final uniqueSuggestions = allSuggestions.toSet().toList();
      uniqueSuggestions.shuffle();
      return uniqueSuggestions.take(10).toList();
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServiceException('Failed to suggest recipes for expiring items: $e');
    }
  }

  @override
  Future<double> calculatePantryValue(String userId) async {
    try {
      final items = await _repository.getUserPantryItems(userId);
      double totalValue = 0.0;

      for (final item in items) {
        // Estimate value based on quantity and category if no cost is available
        final itemValue = _estimateItemValue(item);
        totalValue += itemValue * item.quantity;
      }

      return totalValue;
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServiceException('Failed to calculate pantry value: $e');
    }
  }

  @override
  Future<List<ShoppingListItem>> generateShoppingListFromLowStock(String userId) async {
    try {
      final lowStockItems = await _repository.getLowStockItems(userId);
      final shoppingItems = <ShoppingListItem>[];

      for (final item in lowStockItems) {
        final suggestedQuantity = _calculateRestockQuantity(item);
        final estimatedPrice = _estimateItemPrice(item);

        shoppingItems.add(ShoppingListItem(
          name: item.name,
          quantity: suggestedQuantity,
          unit: item.unit,
          category: item.category.name,
          estimatedPrice: estimatedPrice,
          isUrgent: item.quantity <= 0,
        ));
      }

      // Sort by urgency and category
      shoppingItems.sort((a, b) {
        if (a.isUrgent != b.isUrgent) {
          return a.isUrgent ? -1 : 1;
        }
        return a.category.compareTo(b.category);
      });

      return shoppingItems;
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServiceException('Failed to generate shopping list: $e');
    }
  }

  @override
  Future<List<OrganizationSuggestion>> getOrganizationSuggestions(String userId) async {
    try {
      final items = await _repository.getUserPantryItems(userId);
      final suggestions = <OrganizationSuggestion>[];

      // Expiry-based suggestions
      final expiringItems = items.where((item) => 
        item.expiryDate != null && 
        item.expiryDate!.isBefore(DateTime.now().add(const Duration(days: 7)))
      ).toList();

      if (expiringItems.isNotEmpty) {
        suggestions.add(OrganizationSuggestion(
          title: 'Move Expiring Items Forward',
          description: 'Place items expiring soon at the front for easy access',
          type: OrganizationType.expiry,
          affectedItems: expiringItems.map((item) => item.name).toList(),
        ));
      }

      // Category-based suggestions
      final categoryGroups = <String, List<PantryItem>>{};
      for (final item in items) {
        categoryGroups.putIfAbsent(item.category.id, () => []).add(item);
      }

      for (final entry in categoryGroups.entries) {
        if (entry.value.length >= 3) {
          suggestions.add(OrganizationSuggestion(
            title: 'Group ${entry.value.first.category.name} Items',
            description: 'Keep similar items together for better organization',
            type: OrganizationType.category,
            affectedItems: entry.value.map((item) => item.name).toList(),
          ));
        }
      }

      // Location-based suggestions
      final itemsWithoutLocation = items.where((item) => item.location == null).toList();
      if (itemsWithoutLocation.isNotEmpty) {
        suggestions.add(OrganizationSuggestion(
          title: 'Assign Storage Locations',
          description: 'Set storage locations for better inventory tracking',
          type: OrganizationType.location,
          affectedItems: itemsWithoutLocation.map((item) => item.name).toList(),
        ));
      }

      return suggestions;
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServiceException('Failed to get organization suggestions: $e');
    }
  }

  @override
  Future<UsagePattern> analyzeUsagePatterns(String userId) async {
    try {
      final usageHistory = await _repository.getUsageHistory(userId);
      final items = await _repository.getUserPantryItems(userId);

      // Analyze frequently used items
      final usageCount = <String, double>{};
      final wasteCount = <String, double>{};
      final categoryUsage = <String, int>{};

      for (final usage in usageHistory) {
        usageCount[usage.itemName] = (usageCount[usage.itemName] ?? 0) + usage.quantityUsed;
        
        final item = items.firstWhere(
          (item) => item.id == usage.itemId,
          orElse: () => PantryItem(
            id: '',
            name: usage.itemName,
            quantity: 0,
            unit: usage.unit,
            category: PantryCategories.pantryStaples,
            createdAt: DateTime.now(),
          ),
        );

        categoryUsage[item.category.name] = (categoryUsage[item.category.name] ?? 0) + 1;

        // Check if item was wasted (expired before use)
        if (usage.recipeId == null) {
          wasteCount[usage.itemName] = (wasteCount[usage.itemName] ?? 0) + usage.quantityUsed;
        }
      }

      // Calculate average shelf life
      final shelfLives = <int>[];
      for (final item in items) {
        if (item.expiryDate != null && item.createdAt != null) {
          final shelfLife = item.expiryDate!.difference(item.createdAt).inDays;
          if (shelfLife > 0) shelfLives.add(shelfLife);
        }
      }

      final averageShelfLife = shelfLives.isNotEmpty 
        ? shelfLives.reduce((a, b) => a + b) / shelfLives.length 
        : 0.0;

      // Generate recommendations
      final recommendations = _generateUsageRecommendations(
        usageCount, 
        wasteCount, 
        categoryUsage,
      );

      return UsagePattern(
        frequentlyUsedItems: usageCount,
        wastedItems: wasteCount,
        categoryUsage: categoryUsage,
        averageShelfLife: averageShelfLife,
        recommendations: recommendations,
      );
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServiceException('Failed to analyze usage patterns: $e');
    }
  }

  @override
  Future<List<RestockingSuggestion>> getRestockingSuggestions(String userId) async {
    try {
      final usagePattern = await analyzeUsagePatterns(userId);
      final currentItems = await _repository.getUserPantryItems(userId);
      final suggestions = <RestockingSuggestion>[];

      // Suggest restocking based on usage frequency
      for (final entry in usagePattern.frequentlyUsedItems.entries) {
        final itemName = entry.key;
        final usageFrequency = entry.value;
        
        final currentItem = currentItems.firstWhere(
          (item) => item.name.toLowerCase() == itemName.toLowerCase(),
          orElse: () => PantryItem(
            id: '',
            name: itemName,
            quantity: 0,
            unit: 'piece',
            category: PantryCategories.pantryStaples,
            createdAt: DateTime.now(),
          ),
        );

        if (currentItem.quantity < usageFrequency) {
          final suggestedQuantity = (usageFrequency * 1.5).ceil().toDouble();
          final confidence = _calculateRestockingConfidence(usageFrequency, currentItem.quantity);
          
          suggestions.add(RestockingSuggestion(
            itemName: itemName,
            suggestedQuantity: suggestedQuantity,
            unit: currentItem.unit,
            reason: 'High usage frequency (${usageFrequency.toStringAsFixed(1)} per week)',
            confidence: confidence,
            suggestedPurchaseDate: DateTime.now().add(const Duration(days: 2)),
          ));
        }
      }

      // Sort by confidence
      suggestions.sort((a, b) => b.confidence.compareTo(a.confidence));
      
      return suggestions.take(10).toList();
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServiceException('Failed to get restocking suggestions: $e');
    }
  }

  // Helper methods
  String _generateId() {
    return DateTime.now().millisecondsSinceEpoch.toString() + 
           Random().nextInt(1000).toString();
  }

  PantryCategory _getCategoryFromProductInfo(ProductInfo? productInfo) {
    if (productInfo == null) return PantryCategories.pantryStaples;
    
    final categoryId = productInfo.category;
    return PantryCategories.getById(categoryId) ?? PantryCategories.pantryStaples;
  }

  NotificationPriority _getNotificationPriority(int daysUntilExpiry) {
    if (daysUntilExpiry <= 0) return NotificationPriority.urgent;
    if (daysUntilExpiry <= 1) return NotificationPriority.high;
    if (daysUntilExpiry <= 3) return NotificationPriority.medium;
    return NotificationPriority.low;
  }

  Future<List<String>> _getSuggestedRecipesForItem(PantryItem item) async {
    // In a real implementation, this would call the recipe service
    // For now, return some basic suggestions based on category
    final suggestions = <String>[];
    
    switch (item.category.id) {
      case 'vegetables':
        suggestions.addAll(['Vegetable Stir Fry', 'Roasted Vegetables', 'Vegetable Soup']);
        break;
      case 'fruits':
        suggestions.addAll(['Fruit Salad', 'Smoothie', 'Fruit Tart']);
        break;
      case 'dairy':
        suggestions.addAll(['Cheese Omelet', 'Creamy Pasta', 'Pancakes']);
        break;
      case 'meat':
        suggestions.addAll(['Grilled ${item.name}', '${item.name} Stew', '${item.name} Curry']);
        break;
      default:
        suggestions.addAll(['Quick ${item.name} Recipe', '${item.name} Special']);
    }
    
    return suggestions.take(3).toList();
  }

  double _estimateItemValue(PantryItem item) {
    // Basic price estimation based on category
    switch (item.category.id) {
      case 'meat':
        return 8.0; // $8 per unit
      case 'dairy':
        return 3.0; // $3 per unit
      case 'vegetables':
        return 2.0; // $2 per unit
      case 'fruits':
        return 2.5; // $2.50 per unit
      case 'grains':
        return 1.5; // $1.50 per unit
      default:
        return 1.0; // $1 per unit
    }
  }

  double _calculateRestockQuantity(PantryItem item) {
    // Calculate suggested restock quantity based on minimum quantity or default
    if (item.minQuantity != null && item.minQuantity! > 0) {
      return item.minQuantity! * 2; // Restock to twice the minimum
    }
    
    // Default restock quantities by category
    switch (item.category.id) {
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

  double _estimateItemPrice(PantryItem item) {
    final basePrice = _estimateItemValue(item);
    final quantity = _calculateRestockQuantity(item);
    return basePrice * quantity;
  }

  List<String> _generateUsageRecommendations(
    Map<String, double> usageCount,
    Map<String, double> wasteCount,
    Map<String, int> categoryUsage,
  ) {
    final recommendations = <String>[];

    // High waste items
    final highWasteItems = wasteCount.entries
        .where((entry) => entry.value > 2)
        .map((entry) => entry.key)
        .toList();

    if (highWasteItems.isNotEmpty) {
      recommendations.add('Consider buying smaller quantities of: ${highWasteItems.join(', ')}');
    }

    // Frequently used items
    final frequentItems = usageCount.entries
        .where((entry) => entry.value > 5)
        .map((entry) => entry.key)
        .toList();

    if (frequentItems.isNotEmpty) {
      recommendations.add('Stock up on frequently used items: ${frequentItems.join(', ')}');
    }

    // Category insights
    final topCategory = categoryUsage.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;

    recommendations.add('You cook a lot of $topCategory dishes - consider meal planning around this category');

    return recommendations;
  }

  double _calculateRestockingConfidence(double usageFrequency, double currentQuantity) {
    if (currentQuantity <= 0) return 0.9; // High confidence for out of stock
    if (usageFrequency > currentQuantity * 2) return 0.8; // High usage vs stock
    if (usageFrequency > currentQuantity) return 0.6; // Moderate confidence
    return 0.3; // Low confidence
  }
}