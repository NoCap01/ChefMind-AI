import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';

import '../../domain/entities/pantry_item.dart';
import '../../domain/repositories/pantry_repository.dart';
import '../../domain/services/pantry_service.dart';
import '../../infrastructure/repositories/firebase_pantry_repository.dart';
import '../../infrastructure/services/pantry_service_impl.dart';
import 'auth_provider.dart';

// Repository and service providers
final pantryRepositoryProvider = Provider<IPantryRepository>((ref) {
  return FirebasePantryRepository.instance;
});

final pantryServiceProvider = Provider<IPantryService>((ref) {
  final repository = ref.watch(pantryRepositoryProvider);
  return PantryServiceImpl(repository);
});

// Pantry state providers
final pantryStateProvider = StateNotifierProvider<PantryStateNotifier, PantryState>((ref) {
  final repository = ref.watch(pantryRepositoryProvider);
  final service = ref.watch(pantryServiceProvider);
  final userId = ref.watch(currentUserIdProvider);
  return PantryStateNotifier(repository, service, userId);
});

// Pantry filtering and sorting providers
final pantryFilterProvider = StateProvider<PantryFilter>((ref) => const PantryFilter());
final pantrySortProvider = StateProvider<PantrySortOption>((ref) => PantrySortOption.expiryDate);

// Filtered and sorted pantry items provider
final filteredPantryItemsProvider = Provider<List<PantryItem>>((ref) {
  final pantryState = ref.watch(pantryStateProvider);
  final filter = ref.watch(pantryFilterProvider);
  final sortOption = ref.watch(pantrySortProvider);
  
  return _filterAndSortPantryItems(pantryState.items, filter, sortOption);
});

// Category-specific providers
final pantryItemsByCategoryProvider = Provider<Map<String, List<PantryItem>>>((ref) {
  final items = ref.watch(filteredPantryItemsProvider);
  final categories = <String, List<PantryItem>>{};
  
  for (final item in items) {
    categories.putIfAbsent(item.category.id, () => []).add(item);
  }
  
  return categories;
});

// Expiring items provider
final expiringItemsProvider = Provider<List<PantryItem>>((ref) {
  final items = ref.watch(filteredPantryItemsProvider);
  final now = DateTime.now();
  
  return items.where((item) {
    if (item.expiryDate == null) return false;
    final daysUntilExpiry = item.expiryDate!.difference(now).inDays;
    return daysUntilExpiry <= 7 && daysUntilExpiry >= 0;
  }).toList()
    ..sort((a, b) => a.expiryDate!.compareTo(b.expiryDate!));
});

// Low stock items provider
final lowStockItemsProvider = Provider<List<PantryItem>>((ref) {
  final items = ref.watch(filteredPantryItemsProvider);
  return items.where((item) => item.isLowStock).toList();
});

// Pantry statistics provider
final pantryStatsProvider = Provider<PantryStats>((ref) {
  final pantryState = ref.watch(pantryStateProvider);
  return pantryState.stats;
});

// Individual pantry item provider
final pantryItemByIdProvider = Provider.family<PantryItem?, String>((ref, itemId) {
  final items = ref.watch(pantryStateProvider).items;
  return items.firstWhereOrNull((item) => item.id == itemId);
});

// Expiry notifications provider
final expiryNotificationsProvider = FutureProvider<List<ExpiryNotification>>((ref) async {
  final service = ref.watch(pantryServiceProvider);
  final userId = ref.watch(currentUserIdProvider);
  
  if (userId == null) return [];
  
  return await service.getExpiryNotifications(userId);
});

/// Pantry state model
class PantryState {
  final List<PantryItem> items;
  final PantryStats stats;
  final bool isLoading;
  final String? errorMessage;
  final Map<String, PantryItem> itemCache;

  const PantryState({
    this.items = const [],
    this.stats = const PantryStats(
      totalItems: 0,
      expiringItems: 0,
      lowStockItems: 0,
      categoryDistribution: {},
      totalValue: 0.0,
      itemsAddedThisWeek: 0,
      itemsUsedThisWeek: 0,
    ),
    this.isLoading = false,
    this.errorMessage,
    this.itemCache = const {},
  });

  PantryState copyWith({
    List<PantryItem>? items,
    PantryStats? stats,
    bool? isLoading,
    String? errorMessage,
    Map<String, PantryItem>? itemCache,
  }) {
    return PantryState(
      items: items ?? this.items,
      stats: stats ?? this.stats,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      itemCache: itemCache ?? this.itemCache,
    );
  }
}

/// Pantry state notifier
class PantryStateNotifier extends StateNotifier<PantryState> {
  final IPantryRepository _repository;
  final IPantryService _service;
  final String? _userId;

  PantryStateNotifier(this._repository, this._service, this._userId) 
      : super(const PantryState()) {
    _loadPantryItems();
  }

  Future<void> _loadPantryItems() async {
    if (_userId == null) return;

    state = state.copyWith(isLoading: true, errorMessage: null);
    
    try {
      final items = await _repository.getUserPantryItems(_userId!);
      final stats = await _repository.getPantryStats(_userId!);
      
      state = state.copyWith(
        items: items,
        stats: stats,
        isLoading: false,
        itemCache: {for (final item in items) item.id: item},
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load pantry items: $e',
      );
    }
  }

  /// Add a new pantry item
  Future<void> addPantryItem(PantryItem item) async {
    if (_userId == null) return;

    try {
      final savedItem = await _repository.addPantryItem(item);
      final updatedItems = [...state.items, savedItem];
      final updatedCache = {...state.itemCache, savedItem.id: savedItem};
      
      state = state.copyWith(
        items: updatedItems,
        itemCache: updatedCache,
      );
      
      await _updateStats();
    } catch (e) {
      state = state.copyWith(errorMessage: 'Failed to add pantry item: $e');
    }
  }

  /// Add item with barcode scanning
  Future<void> addItemWithBarcode(String barcode) async {
    if (_userId == null) return;

    state = state.copyWith(isLoading: true, errorMessage: null);
    
    try {
      final item = await _service.addItemWithBarcode(barcode, _userId!);
      final updatedItems = [...state.items, item];
      final updatedCache = {...state.itemCache, item.id: item};
      
      state = state.copyWith(
        items: updatedItems,
        itemCache: updatedCache,
        isLoading: false,
      );
      
      await _updateStats();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to add item with barcode: $e',
      );
    }
  }

  /// Update an existing pantry item
  Future<void> updatePantryItem(PantryItem item) async {
    try {
      final updatedItem = await _repository.updatePantryItem(item);
      final updatedItems = state.items
          .map((i) => i.id == item.id ? updatedItem : i)
          .toList();
      final updatedCache = {...state.itemCache, updatedItem.id: updatedItem};
      
      state = state.copyWith(
        items: updatedItems,
        itemCache: updatedCache,
      );
      
      await _updateStats();
    } catch (e) {
      state = state.copyWith(errorMessage: 'Failed to update pantry item: $e');
    }
  }

  /// Delete a pantry item
  Future<void> deletePantryItem(String itemId) async {
    try {
      await _repository.deletePantryItem(itemId);
      final updatedItems = state.items.where((i) => i.id != itemId).toList();
      final updatedCache = Map<String, PantryItem>.from(state.itemCache)..remove(itemId);
      
      state = state.copyWith(
        items: updatedItems,
        itemCache: updatedCache,
      );
      
      await _updateStats();
    } catch (e) {
      state = state.copyWith(errorMessage: 'Failed to delete pantry item: $e');
    }
  }

  /// Mark item as used
  Future<void> markItemAsUsed(String itemId, double quantityUsed) async {
    try {
      await _repository.markItemAsUsed(itemId, quantityUsed);
      
      final item = state.itemCache[itemId];
      if (item != null) {
        final updatedQuantity = (item.quantity - quantityUsed).clamp(0.0, double.infinity);
        final updatedItem = item.copyWith(
          quantity: updatedQuantity,
          isLowStock: item.minQuantity != null && updatedQuantity <= item.minQuantity!,
          updatedAt: DateTime.now(),
        );
        
        await updatePantryItem(updatedItem);
      }
    } catch (e) {
      state = state.copyWith(errorMessage: 'Failed to mark item as used: $e');
    }
  }

  /// Update item quantity
  Future<void> updateItemQuantity(String itemId, double newQuantity) async {
    final item = state.itemCache[itemId];
    if (item == null) return;

    final updatedItem = item.copyWith(
      quantity: newQuantity,
      isLowStock: item.minQuantity != null && newQuantity <= item.minQuantity!,
      updatedAt: DateTime.now(),
    );
    
    await updatePantryItem(updatedItem);
  }

  /// Set low stock threshold
  Future<void> setLowStockThreshold(String itemId, double threshold) async {
    final item = state.itemCache[itemId];
    if (item == null) return;

    final updatedItem = item.copyWith(
      minQuantity: threshold,
      isLowStock: item.quantity <= threshold,
      updatedAt: DateTime.now(),
    );
    
    await updatePantryItem(updatedItem);
  }

  /// Update item expiry date
  Future<void> updateExpiryDate(String itemId, DateTime? expiryDate) async {
    final item = state.itemCache[itemId];
    if (item == null) return;

    final updatedItem = item.copyWith(
      expiryDate: expiryDate,
      updatedAt: DateTime.now(),
    );
    
    await updatePantryItem(updatedItem);
  }

  /// Move item to different location
  Future<void> moveItemToLocation(String itemId, String location) async {
    final item = state.itemCache[itemId];
    if (item == null) return;

    final updatedItem = item.copyWith(
      location: location,
      updatedAt: DateTime.now(),
    );
    
    await updatePantryItem(updatedItem);
  }

  /// Bulk update items
  Future<void> bulkUpdateItems(List<PantryItem> items) async {
    try {
      final updatedItems = await _repository.bulkUpdatePantryItems(items);
      final updatedItemsMap = {for (final item in updatedItems) item.id: item};
      
      final newItems = state.items.map((item) {
        return updatedItemsMap[item.id] ?? item;
      }).toList();
      
      final newCache = {...state.itemCache};
      for (final item in updatedItems) {
        newCache[item.id] = item;
      }
      
      state = state.copyWith(
        items: newItems,
        itemCache: newCache,
      );
      
      await _updateStats();
    } catch (e) {
      state = state.copyWith(errorMessage: 'Failed to bulk update items: $e');
    }
  }

  /// Generate shopping list from low stock items
  Future<List<ShoppingListItem>> generateShoppingList() async {
    if (_userId == null) return [];

    try {
      return await _service.generateShoppingListFromLowStock(_userId!);
    } catch (e) {
      state = state.copyWith(errorMessage: 'Failed to generate shopping list: $e');
      return [];
    }
  }

  /// Get recipe suggestions for expiring items
  Future<List<String>> getRecipeSuggestions() async {
    if (_userId == null) return [];

    try {
      return await _service.suggestRecipesForExpiringItems(_userId!);
    } catch (e) {
      state = state.copyWith(errorMessage: 'Failed to get recipe suggestions: $e');
      return [];
    }
  }

  /// Refresh pantry data
  Future<void> refresh() async {
    await _loadPantryItems();
  }

  /// Clear error message
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  /// Update statistics
  Future<void> _updateStats() async {
    if (_userId == null) return;

    try {
      final stats = await _repository.getPantryStats(_userId!);
      state = state.copyWith(stats: stats);
    } catch (e) {
      // Don't update error state for stats update failure
    }
  }
}

// Helper function for filtering and sorting pantry items
List<PantryItem> _filterAndSortPantryItems(
  List<PantryItem> items,
  PantryFilter filter,
  PantrySortOption sortOption,
) {
  var filteredItems = items.where((item) {
    // Search query filter
    if (filter.searchQuery != null && filter.searchQuery!.isNotEmpty) {
      final query = filter.searchQuery!.toLowerCase();
      final matchesName = item.name.toLowerCase().contains(query);
      final matchesBrand = item.brand?.toLowerCase().contains(query) ?? false;
      final matchesNotes = item.notes?.toLowerCase().contains(query) ?? false;
      
      if (!matchesName && !matchesBrand && !matchesNotes) {
        return false;
      }
    }

    // Category filter
    if (filter.categories.isNotEmpty) {
      if (!filter.categories.contains(item.category.id)) return false;
    }

    // Location filter
    if (filter.locations.isNotEmpty) {
      if (item.location == null || !filter.locations.contains(item.location!)) {
        return false;
      }
    }

    // Expiring items filter
    if (filter.showExpiringOnly) {
      if (item.expiryDate == null) return false;
      final daysUntilExpiry = item.expiryDate!.difference(DateTime.now()).inDays;
      if (daysUntilExpiry > 7 || daysUntilExpiry < 0) return false;
    }

    // Low stock filter
    if (filter.showLowStockOnly) {
      if (!item.isLowStock) return false;
    }

    // Expiry date range filters
    if (filter.expiryBefore != null) {
      if (item.expiryDate == null || item.expiryDate!.isAfter(filter.expiryBefore!)) {
        return false;
      }
    }

    if (filter.expiryAfter != null) {
      if (item.expiryDate == null || item.expiryDate!.isBefore(filter.expiryAfter!)) {
        return false;
      }
    }

    return true;
  }).toList();

  // Sort items
  switch (sortOption) {
    case PantrySortOption.name:
      filteredItems.sort((a, b) => a.name.compareTo(b.name));
      break;
    case PantrySortOption.expiryDate:
      filteredItems.sort((a, b) {
        if (a.expiryDate == null && b.expiryDate == null) return 0;
        if (a.expiryDate == null) return 1;
        if (b.expiryDate == null) return -1;
        return a.expiryDate!.compareTo(b.expiryDate!);
      });
      break;
    case PantrySortOption.quantity:
      filteredItems.sort((a, b) => a.quantity.compareTo(b.quantity));
      break;
    case PantrySortOption.category:
      filteredItems.sort((a, b) => a.category.name.compareTo(b.category.name));
      break;
    case PantrySortOption.dateAdded:
      filteredItems.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      break;
  }

  return filteredItems;
}