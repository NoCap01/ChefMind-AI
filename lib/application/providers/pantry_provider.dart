import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/pantry_item.dart';
import '../../services/pantry_service.dart';

// Pantry service provider
final pantryServiceProvider = Provider<PantryService>((ref) {
  return PantryService();
});

// Pantry state
class PantryState {
  final List<PantryItem> items;
  final bool isLoading;
  final String? error;
  final String searchQuery;
  final String? selectedCategory;

  const PantryState({
    this.items = const [],
    this.isLoading = false,
    this.error,
    this.searchQuery = '',
    this.selectedCategory,
  });

  PantryState copyWith({
    List<PantryItem>? items,
    bool? isLoading,
    String? error,
    String? searchQuery,
    String? selectedCategory,
  }) {
    return PantryState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }

  List<PantryItem> get filteredItems {
    var filtered = items;

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

  List<PantryItem> get lowStockItems {
    return items.where((item) => item.isLowStock).toList();
  }

  List<PantryItem> get expiringSoonItems {
    return items.where((item) => item.isExpiringSoon).toList();
  }

  List<PantryItem> get expiredItems {
    return items.where((item) => item.isExpired).toList();
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

  bool get hasNotifications {
    return lowStockItems.isNotEmpty || expiringSoonItems.isNotEmpty || expiredItems.isNotEmpty;
  }
}

// Pantry notifier
class PantryNotifier extends StateNotifier<PantryState> {
  final PantryService _pantryService;

  PantryNotifier(this._pantryService) : super(const PantryState()) {
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      await _pantryService.initialize();
      await loadItems();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> loadItems() async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final items = _pantryService.getAllItems();
      state = state.copyWith(items: items, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> addItem(PantryItem item) async {
    try {
      await _pantryService.addItem(item);
      await loadItems();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> updateItem(PantryItem item) async {
    try {
      await _pantryService.updateItem(item);
      await loadItems();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> deleteItem(String id) async {
    try {
      await _pantryService.deleteItem(id);
      await loadItems();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> updateItemQuantity(String id, double quantity) async {
    try {
      await _pantryService.updateItemQuantity(id, quantity);
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

  void clearFilters() {
    state = state.copyWith(searchQuery: '', selectedCategory: null);
  }

  Future<void> clearAllItems() async {
    try {
      await _pantryService.clearAll();
      await loadItems();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
}

// Pantry provider
final pantryProvider = StateNotifierProvider<PantryNotifier, PantryState>((ref) {
  final pantryService = ref.read(pantryServiceProvider);
  return PantryNotifier(pantryService);
});

// Notifications provider
final pantryNotificationsProvider = Provider<Map<String, List<PantryItem>>>((ref) {
  final pantryState = ref.watch(pantryProvider);
  return {
    'lowStock': pantryState.lowStockItems,
    'expiringSoon': pantryState.expiringSoonItems,
    'expired': pantryState.expiredItems,
  };
});