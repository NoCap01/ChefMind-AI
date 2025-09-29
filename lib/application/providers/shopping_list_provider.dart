import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/shopping_list_item.dart';
import '../../domain/entities/recipe.dart';
import '../../services/shopping_list_service.dart';
import 'pantry_provider.dart';

// Shopping list service provider
final shoppingListServiceProvider = Provider<ShoppingListService>((ref) {
  final pantryService = ref.read(pantryServiceProvider);
  return ShoppingListService(pantryService);
});

// Shopping list state
class ShoppingListState {
  final List<ShoppingListItem> items;
  final bool isLoading;
  final String? error;
  final String searchQuery;
  final String? selectedCategory;
  final bool showCompletedItems;

  const ShoppingListState({
    this.items = const [],
    this.isLoading = false,
    this.error,
    this.searchQuery = '',
    this.selectedCategory,
    this.showCompletedItems = false,
  });

  ShoppingListState copyWith({
    List<ShoppingListItem>? items,
    bool? isLoading,
    String? error,
    String? searchQuery,
    String? selectedCategory,
    bool? showCompletedItems,
  }) {
    return ShoppingListState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      showCompletedItems: showCompletedItems ?? this.showCompletedItems,
    );
  }

  List<ShoppingListItem> get filteredItems {
    var filtered = items;

    // Filter by completion status
    if (!showCompletedItems) {
      filtered = filtered.where((item) => !item.isCompleted).toList();
    }

    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered
          .where((item) => item.name.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }

    // Filter by category
    if (selectedCategory != null && selectedCategory!.isNotEmpty) {
      filtered = filtered
          .where((item) => item.category == selectedCategory)
          .toList();
    }

    return filtered;
  }

  List<ShoppingListItem> get pendingItems {
    return items.where((item) => !item.isCompleted).toList();
  }

  List<ShoppingListItem> get completedItems {
    return items.where((item) => item.isCompleted).toList();
  }

  List<String> get categories {
    final categories = <String>{};
    for (final item in items) {
      if (item.category != null) {
        categories.add(item.category!);
      }
    }
    return categories.toList()..sort();
  }

  double get estimatedTotalCost {
    return pendingItems
        .where((item) => item.estimatedPrice != null)
        .fold(0.0, (sum, item) => sum + (item.estimatedPrice! * item.quantity));
  }

  int get totalItemCount => items.length;
  int get pendingItemCount => pendingItems.length;
  int get completedItemCount => completedItems.length;
}

// Shopping list notifier
class ShoppingListNotifier extends StateNotifier<ShoppingListState> {
  final ShoppingListService _shoppingListService;

  ShoppingListNotifier(this._shoppingListService) : super(const ShoppingListState()) {
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      await _shoppingListService.initialize();
      await loadItems();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> loadItems() async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final items = _shoppingListService.getAllItems();
      state = state.copyWith(items: items, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> addItem(ShoppingListItem item) async {
    try {
      await _shoppingListService.addItem(item);
      await loadItems();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> updateItem(ShoppingListItem item) async {
    try {
      await _shoppingListService.updateItem(item);
      await loadItems();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> deleteItem(String id) async {
    try {
      await _shoppingListService.deleteItem(id);
      await loadItems();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> toggleItemCompletion(String id) async {
    try {
      await _shoppingListService.toggleItemCompletion(id);
      await loadItems();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> addRecipeToShoppingList(Recipe recipe) async {
    try {
      await _shoppingListService.addRecipeToShoppingList(recipe);
      await loadItems();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> addRecipesToShoppingList(List<Recipe> recipes) async {
    try {
      await _shoppingListService.addRecipesToShoppingList(recipes);
      await loadItems();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> moveCompletedItemsToPantry() async {
    try {
      await _shoppingListService.moveCompletedItemsToPantry();
      await loadItems();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void setSelectedCategory(String? category) {
    state = state.copyWith(selectedCategory: category);
  }

  void toggleShowCompletedItems() {
    state = state.copyWith(showCompletedItems: !state.showCompletedItems);
  }

  void clearFilters() {
    state = state.copyWith(searchQuery: '', selectedCategory: null);
  }

  Future<void> clearCompletedItems() async {
    try {
      await _shoppingListService.clearCompletedItems();
      await loadItems();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> clearAllItems() async {
    try {
      await _shoppingListService.clearAll();
      await loadItems();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
}

// Shopping list provider
final shoppingListProvider = StateNotifierProvider<ShoppingListNotifier, ShoppingListState>((ref) {
  final shoppingListService = ref.read(shoppingListServiceProvider);
  return ShoppingListNotifier(shoppingListService);
});