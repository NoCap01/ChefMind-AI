import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';

import '../../domain/entities/shopping_list.dart';
import '../../domain/repositories/shopping_list_repository.dart';
import '../../domain/services/shopping_list_service.dart';
import '../../infrastructure/repositories/firebase_shopping_list_repository.dart';
import '../../infrastructure/services/shopping_list_service_impl.dart';
import 'auth_provider.dart';
import 'pantry_provider.dart';

// Repository and service providers
final shoppingListRepositoryProvider = Provider<IShoppingListRepository>((ref) {
  return FirebaseShoppingListRepository.instance;
});

final shoppingListServiceProvider = Provider<IShoppingListService>((ref) {
  final repository = ref.watch(shoppingListRepositoryProvider);
  final pantryRepository = ref.watch(pantryRepositoryProvider);
  return ShoppingListServiceImpl(repository, pantryRepository);
});

// Shopping list state providers
final shoppingListStateProvider = StateNotifierProvider<ShoppingListStateNotifier, ShoppingListState>((ref) {
  final repository = ref.watch(shoppingListRepositoryProvider);
  final service = ref.watch(shoppingListServiceProvider);
  final userId = ref.watch(currentUserIdProvider);
  return ShoppingListStateNotifier(repository, service, userId);
});

// Shopping list filtering and sorting providers
final shoppingListFilterProvider = StateProvider<ShoppingListFilter>((ref) => const ShoppingListFilter());
final shoppingSortProvider = StateProvider<ShoppingSortOption>((ref) => ShoppingSortOption.category);

// Filtered and sorted shopping lists provider
final filteredShoppingListsProvider = Provider<List<ShoppingList>>((ref) {
  final shoppingListState = ref.watch(shoppingListStateProvider);
  final filter = ref.watch(shoppingListFilterProvider);
  
  return _filterShoppingLists(shoppingListState.shoppingLists, filter);
});

// Active shopping list provider
final activeShoppingListProvider = StateProvider<String?>((ref) => null);

// Current shopping list provider
final currentShoppingListProvider = Provider<ShoppingList?>((ref) {
  final activeListId = ref.watch(activeShoppingListProvider);
  if (activeListId == null) return null;
  
  final shoppingLists = ref.watch(shoppingListStateProvider).shoppingLists;
  return shoppingLists.firstWhereOrNull((list) => list.id == activeListId);
});

// Filtered shopping list items provider
final filteredShoppingListItemsProvider = Provider<List<ShoppingListItem>>((ref) {
  final currentList = ref.watch(currentShoppingListProvider);
  final filter = ref.watch(shoppingListFilterProvider);
  final sortOption = ref.watch(shoppingSortProvider);
  
  if (currentList == null) return [];
  
  return _filterAndSortItems(currentList.items, filter, sortOption);
});

// Shopping list items by category provider
final shoppingListItemsByCategoryProvider = Provider<Map<String, List<ShoppingListItem>>>((ref) {
  final items = ref.watch(filteredShoppingListItemsProvider);
  final categories = <String, List<ShoppingListItem>>{};
  
  for (final item in items) {
    categories.putIfAbsent(item.category, () => []).add(item);
  }
  
  // Sort categories by their defined order
  final sortedCategories = <String, List<ShoppingListItem>>{};
  for (final category in ShoppingCategories.getSortedCategories()) {
    if (categories.containsKey(category.id)) {
      sortedCategories[category.id] = categories[category.id]!;
    }
  }
  
  return sortedCategories;
});

// Shopping list statistics provider
final shoppingListStatsProvider = FutureProvider.family<ShoppingListStats, String>((ref, listId) async {
  final repository = ref.watch(shoppingListRepositoryProvider);
  return await repository.getShoppingListStats(listId);
});

// Shared shopping lists provider
final sharedShoppingListsProvider = FutureProvider<List<ShoppingList>>((ref) async {
  final repository = ref.watch(shoppingListRepositoryProvider);
  final userId = ref.watch(currentUserIdProvider);
  
  if (userId == null) return [];
  
  return await repository.getSharedShoppingLists(userId);
});

// Shopping list templates provider
final shoppingListTemplatesProvider = FutureProvider<List<ShoppingListTemplate>>((ref) async {
  final repository = ref.watch(shoppingListRepositoryProvider);
  return await repository.getShoppingListTemplates();
});

// Shopping analytics provider
final shoppingAnalyticsProvider = FutureProvider<ShoppingListAnalytics>((ref) async {
  final service = ref.watch(shoppingListServiceProvider);
  final userId = ref.watch(currentUserIdProvider);
  
  if (userId == null) {
    return const ShoppingListAnalytics(
      averageListSize: 0,
      averageSpending: 0,
      mostBoughtCategories: {},
      categorySpending: {},
      frequentItems: [],
      savingsFromDeals: 0,
      completedLists: 0,
      averageShoppingTime: Duration.zero,
    );
  }
  
  return await service.getShoppingAnalytics(userId);
});

/// Shopping list state model
class ShoppingListState {
  final List<ShoppingList> shoppingLists;
  final bool isLoading;
  final String? errorMessage;
  final Map<String, ShoppingList> listCache;

  const ShoppingListState({
    this.shoppingLists = const [],
    this.isLoading = false,
    this.errorMessage,
    this.listCache = const {},
  });

  ShoppingListState copyWith({
    List<ShoppingList>? shoppingLists,
    bool? isLoading,
    String? errorMessage,
    Map<String, ShoppingList>? listCache,
  }) {
    return ShoppingListState(
      shoppingLists: shoppingLists ?? this.shoppingLists,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      listCache: listCache ?? this.listCache,
    );
  }
}

/// Shopping list state notifier
class ShoppingListStateNotifier extends StateNotifier<ShoppingListState> {
  final IShoppingListRepository _repository;
  final IShoppingListService _service;
  final String? _userId;

  ShoppingListStateNotifier(this._repository, this._service, this._userId) 
      : super(const ShoppingListState()) {
    _loadShoppingLists();
  }

  Future<void> _loadShoppingLists() async {
    if (_userId == null) return;

    state = state.copyWith(isLoading: true, errorMessage: null);
    
    try {
      final lists = await _repository.getUserShoppingLists(_userId!);
      
      state = state.copyWith(
        shoppingLists: lists,
        isLoading: false,
        listCache: {for (final list in lists) list.id: list},
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load shopping lists: $e',
      );
    }
  }

  /// Create a new shopping list
  Future<void> createShoppingList(ShoppingList shoppingList) async {
    try {
      final savedList = await _repository.createShoppingList(shoppingList);
      final updatedLists = [...state.shoppingLists, savedList];
      final updatedCache = {...state.listCache, savedList.id: savedList};
      
      state = state.copyWith(
        shoppingLists: updatedLists,
        listCache: updatedCache,
      );
    } catch (e) {
      state = state.copyWith(errorMessage: 'Failed to create shopping list: $e');
    }
  }

  /// Update an existing shopping list
  Future<void> updateShoppingList(ShoppingList shoppingList) async {
    try {
      final updatedList = await _repository.updateShoppingList(shoppingList);
      final updatedLists = state.shoppingLists
          .map((list) => list.id == shoppingList.id ? updatedList : list)
          .toList();
      final updatedCache = {...state.listCache, updatedList.id: updatedList};
      
      state = state.copyWith(
        shoppingLists: updatedLists,
        listCache: updatedCache,
      );
    } catch (e) {
      state = state.copyWith(errorMessage: 'Failed to update shopping list: $e');
    }
  }

  /// Delete a shopping list
  Future<void> deleteShoppingList(String listId) async {
    try {
      await _repository.deleteShoppingList(listId);
      final updatedLists = state.shoppingLists.where((list) => list.id != listId).toList();
      final updatedCache = Map<String, ShoppingList>.from(state.listCache)..remove(listId);
      
      state = state.copyWith(
        shoppingLists: updatedLists,
        listCache: updatedCache,
      );
    } catch (e) {
      state = state.copyWith(errorMessage: 'Failed to delete shopping list: $e');
    }
  }

  /// Add item to shopping list
  Future<void> addItemToList(String listId, ShoppingListItem item) async {
    try {
      final updatedList = await _repository.addItemToList(listId, item);
      await _updateListInState(updatedList);
    } catch (e) {
      state = state.copyWith(errorMessage: 'Failed to add item to list: $e');
    }
  }

  /// Update item in shopping list
  Future<void> updateItemInList(String listId, ShoppingListItem item) async {
    try {
      final updatedList = await _repository.updateItemInList(listId, item);
      await _updateListInState(updatedList);
    } catch (e) {
      state = state.copyWith(errorMessage: 'Failed to update item: $e');
    }
  }

  /// Remove item from shopping list
  Future<void> removeItemFromList(String listId, String itemId) async {
    try {
      final updatedList = await _repository.removeItemFromList(listId, itemId);
      await _updateListInState(updatedList);
    } catch (e) {
      state = state.copyWith(errorMessage: 'Failed to remove item: $e');
    }
  }

  /// Mark item as completed
  Future<void> markItemCompleted(String listId, String itemId, {String? completedBy}) async {
    try {
      final updatedList = await _repository.markItemCompleted(listId, itemId, completedBy: completedBy);
      await _updateListInState(updatedList);
    } catch (e) {
      state = state.copyWith(errorMessage: 'Failed to mark item completed: $e');
    }
  }

  /// Mark item as uncompleted
  Future<void> markItemUncompleted(String listId, String itemId) async {
    try {
      final updatedList = await _repository.markItemUncompleted(listId, itemId);
      await _updateListInState(updatedList);
    } catch (e) {
      state = state.copyWith(errorMessage: 'Failed to mark item uncompleted: $e');
    }
  }

  /// Generate shopping list from recipes
  Future<void> generateFromRecipes(
    List<Recipe> recipes,
    String listName, {
    bool consolidateIngredients = true,
    bool excludePantryItems = true,
  }) async {
    if (_userId == null) return;

    state = state.copyWith(isLoading: true, errorMessage: null);
    
    try {
      final shoppingList = await _service.generateFromRecipes(
        recipes,
        _userId!,
        listName,
        consolidateIngredients: consolidateIngredients,
        excludePantryItems: excludePantryItems,
      );
      
      final updatedLists = [...state.shoppingLists, shoppingList];
      final updatedCache = {...state.listCache, shoppingList.id: shoppingList};
      
      state = state.copyWith(
        shoppingLists: updatedLists,
        listCache: updatedCache,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to generate shopping list from recipes: $e',
      );
    }
  }

  /// Generate shopping list from low stock items
  Future<void> generateFromLowStock(
    String listName, {
    bool includeRecommendations = true,
  }) async {
    if (_userId == null) return;

    state = state.copyWith(isLoading: true, errorMessage: null);
    
    try {
      final shoppingList = await _service.generateFromLowStock(
        _userId!,
        listName,
        includeRecommendations: includeRecommendations,
      );
      
      final updatedLists = [...state.shoppingLists, shoppingList];
      final updatedCache = {...state.listCache, shoppingList.id: shoppingList};
      
      state = state.copyWith(
        shoppingLists: updatedLists,
        listCache: updatedCache,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to generate shopping list from low stock: $e',
      );
    }
  }

  /// Share shopping list with collaborators
  Future<void> shareShoppingList(String listId, List<String> collaboratorIds) async {
    try {
      await _service.shareWithCollaborators(listId, collaboratorIds);
      
      // Refresh the list to get updated sharing info
      final updatedList = await _repository.getShoppingListById(listId);
      if (updatedList != null) {
        await _updateListInState(updatedList);
      }
    } catch (e) {
      state = state.copyWith(errorMessage: 'Failed to share shopping list: $e');
    }
  }

  /// Consolidate items in shopping list
  Future<void> consolidateItems(String listId) async {
    try {
      final shoppingList = state.listCache[listId];
      if (shoppingList == null) return;
      
      final consolidatedList = await _service.consolidateItems(shoppingList);
      await _updateListInState(consolidatedList);
    } catch (e) {
      state = state.copyWith(errorMessage: 'Failed to consolidate items: $e');
    }
  }

  /// Optimize shopping list for store
  Future<void> optimizeForStore(String listId, String storeId) async {
    try {
      final shoppingList = state.listCache[listId];
      if (shoppingList == null) return;
      
      final optimizedList = await _service.optimizeForStore(shoppingList, storeId);
      await _updateListInState(optimizedList);
    } catch (e) {
      state = state.copyWith(errorMessage: 'Failed to optimize for store: $e');
    }
  }

  /// Import shopping list from text
  Future<void> importFromText(String text, String listName) async {
    if (_userId == null) return;

    state = state.copyWith(isLoading: true, errorMessage: null);
    
    try {
      final shoppingList = await _service.importFromText(text, _userId!, listName);
      
      final updatedLists = [...state.shoppingLists, shoppingList];
      final updatedCache = {...state.listCache, shoppingList.id: shoppingList};
      
      state = state.copyWith(
        shoppingLists: updatedLists,
        listCache: updatedCache,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to import shopping list: $e',
      );
    }
  }

  /// Export shopping list
  Future<String?> exportShoppingList(String listId, ExportFormat format) async {
    try {
      final shoppingList = state.listCache[listId];
      if (shoppingList == null) return null;
      
      return await _service.exportShoppingList(shoppingList, format);
    } catch (e) {
      state = state.copyWith(errorMessage: 'Failed to export shopping list: $e');
      return null;
    }
  }

  /// Duplicate shopping list
  Future<void> duplicateShoppingList(String listId, String newName) async {
    try {
      final duplicatedList = await _repository.duplicateShoppingList(listId, newName);
      
      final updatedLists = [...state.shoppingLists, duplicatedList];
      final updatedCache = {...state.listCache, duplicatedList.id: duplicatedList};
      
      state = state.copyWith(
        shoppingLists: updatedLists,
        listCache: updatedCache,
      );
    } catch (e) {
      state = state.copyWith(errorMessage: 'Failed to duplicate shopping list: $e');
    }
  }

  /// Archive shopping list
  Future<void> archiveShoppingList(String listId) async {
    try {
      await _repository.archiveShoppingList(listId);
      
      // Remove from active lists
      final updatedLists = state.shoppingLists.where((list) => list.id != listId).toList();
      final updatedCache = Map<String, ShoppingList>.from(state.listCache)..remove(listId);
      
      state = state.copyWith(
        shoppingLists: updatedLists,
        listCache: updatedCache,
      );
    } catch (e) {
      state = state.copyWith(errorMessage: 'Failed to archive shopping list: $e');
    }
  }

  /// Refresh shopping lists
  Future<void> refresh() async {
    await _loadShoppingLists();
  }

  /// Clear error message
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  /// Update a list in the current state
  Future<void> _updateListInState(ShoppingList updatedList) async {
    final updatedLists = state.shoppingLists
        .map((list) => list.id == updatedList.id ? updatedList : list)
        .toList();
    final updatedCache = {...state.listCache, updatedList.id: updatedList};
    
    state = state.copyWith(
      shoppingLists: updatedLists,
      listCache: updatedCache,
    );
  }
}

// Helper functions for filtering and sorting
List<ShoppingList> _filterShoppingLists(
  List<ShoppingList> lists,
  ShoppingListFilter filter,
) {
  return lists.where((list) {
    // Search query filter
    if (filter.searchQuery != null && filter.searchQuery!.isNotEmpty) {
      final query = filter.searchQuery!.toLowerCase();
      final matchesName = list.name.toLowerCase().contains(query);
      final matchesNotes = list.notes?.toLowerCase().contains(query) ?? false;
      final matchesItems = list.items.any((item) => 
        item.name.toLowerCase().contains(query));
      
      if (!matchesName && !matchesNotes && !matchesItems) {
        return false;
      }
    }

    // Show completed only filter
    if (filter.showCompletedOnly && !list.isCompleted) {
      return false;
    }

    // Show urgent only filter
    if (filter.showUrgentOnly && !list.items.any((item) => item.isUrgent)) {
      return false;
    }

    // Added by filter
    if (filter.addedBy != null && list.userId != filter.addedBy) {
      return false;
    }

    // Date range filters
    if (filter.addedAfter != null && list.createdAt.isBefore(filter.addedAfter!)) {
      return false;
    }

    if (filter.addedBefore != null && list.createdAt.isAfter(filter.addedBefore!)) {
      return false;
    }

    return true;
  }).toList();
}

List<ShoppingListItem> _filterAndSortItems(
  List<ShoppingListItem> items,
  ShoppingListFilter filter,
  ShoppingSortOption sortOption,
) {
  var filteredItems = items.where((item) {
    // Category filter
    if (filter.categories.isNotEmpty && !filter.categories.contains(item.category)) {
      return false;
    }

    // Completed only filter
    if (filter.showCompletedOnly && !item.isCompleted) {
      return false;
    }

    // Urgent only filter
    if (filter.showUrgentOnly && !item.isUrgent) {
      return false;
    }

    // My items only filter
    if (filter.showMyItemsOnly && item.addedBy != filter.addedBy) {
      return false;
    }

    return true;
  }).toList();

  // Sort items
  switch (sortOption) {
    case ShoppingSortOption.category:
      filteredItems.sort((a, b) {
        final categoryA = ShoppingCategories.getById(a.category);
        final categoryB = ShoppingCategories.getById(b.category);
        
        if (categoryA == null && categoryB == null) return 0;
        if (categoryA == null) return 1;
        if (categoryB == null) return -1;
        
        return categoryA.sortOrder.compareTo(categoryB.sortOrder);
      });
      break;
    case ShoppingSortOption.name:
      filteredItems.sort((a, b) => a.name.compareTo(b.name));
      break;
    case ShoppingSortOption.dateAdded:
      filteredItems.sort((a, b) {
        if (a.addedAt == null && b.addedAt == null) return 0;
        if (a.addedAt == null) return 1;
        if (b.addedAt == null) return -1;
        return b.addedAt!.compareTo(a.addedAt!);
      });
      break;
    case ShoppingSortOption.priority:
      filteredItems.sort((a, b) {
        if (a.isUrgent && !b.isUrgent) return -1;
        if (!a.isUrgent && b.isUrgent) return 1;
        return 0;
      });
      break;
    case ShoppingSortOption.price:
      filteredItems.sort((a, b) {
        final priceA = a.estimatedPrice ?? 0.0;
        final priceB = b.estimatedPrice ?? 0.0;
        return priceB.compareTo(priceA);
      });
      break;
    case ShoppingSortOption.aisle:
      // This would sort by store aisle if available
      filteredItems.sort((a, b) => a.category.compareTo(b.category));
      break;
  }

  return filteredItems;
}