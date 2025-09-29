import 'package:hive/hive.dart';
import '../domain/entities/shopping_list_item.dart';
import '../domain/entities/recipe.dart';
import '../domain/entities/pantry_item.dart';
import 'pantry_service.dart';

class ShoppingListService {
  static const String _boxName = 'shopping_list_items';
  Box<ShoppingListItem>? _box;
  final PantryService _pantryService;

  ShoppingListService(this._pantryService);

  Future<void> initialize() async {
    if (!Hive.isBoxOpen(_boxName)) {
      _box = await Hive.openBox<ShoppingListItem>(_boxName);
    } else {
      _box = Hive.box<ShoppingListItem>(_boxName);
    }
  }

  Box<ShoppingListItem> get _shoppingBox {
    if (_box == null || !_box!.isOpen) {
      throw Exception('Shopping list service not initialized. Call initialize() first.');
    }
    return _box!;
  }

  // Add new shopping list item
  Future<void> addItem(ShoppingListItem item) async {
    await _shoppingBox.put(item.id, item);
  }

  // Get all shopping list items
  List<ShoppingListItem> getAllItems() {
    return _shoppingBox.values.toList();
  }

  // Get pending items (not completed)
  List<ShoppingListItem> getPendingItems() {
    return _shoppingBox.values
        .where((item) => !item.isCompleted)
        .toList();
  }

  // Get completed items
  List<ShoppingListItem> getCompletedItems() {
    return _shoppingBox.values
        .where((item) => item.isCompleted)
        .toList();
  }

  // Get item by ID
  ShoppingListItem? getItem(String id) {
    return _shoppingBox.get(id);
  }

  // Update existing item
  Future<void> updateItem(ShoppingListItem item) async {
    item.updatedAt = DateTime.now();
    await _shoppingBox.put(item.id, item);
  }

  // Delete item
  Future<void> deleteItem(String id) async {
    await _shoppingBox.delete(id);
  }

  // Toggle item completion
  Future<void> toggleItemCompletion(String id) async {
    final item = _shoppingBox.get(id);
    if (item != null) {
      item.toggleCompleted();
      await _shoppingBox.put(id, item);
    }
  }

  // Get items by category
  List<ShoppingListItem> getItemsByCategory(String category) {
    return _shoppingBox.values
        .where((item) => item.category == category)
        .toList();
  }

  // Search items by name
  List<ShoppingListItem> searchItems(String query) {
    final lowercaseQuery = query.toLowerCase();
    return _shoppingBox.values
        .where((item) => item.name.toLowerCase().contains(lowercaseQuery))
        .toList();
  }

  // Generate shopping list from recipe
  Future<List<ShoppingListItem>> generateFromRecipe(Recipe recipe) async {
    final shoppingItems = <ShoppingListItem>[];
    
    for (final ingredient in recipe.ingredients) {
      // Check if we already have this ingredient in pantry
      final pantryItems = _pantryService.findSimilarItems(ingredient.name);
      double neededQuantity = ingredient.quantity;
      
      // Subtract available quantity from pantry
      for (final pantryItem in pantryItems) {
        if (pantryItem.unit == ingredient.unit) {
          neededQuantity -= pantryItem.quantity;
        }
      }
      
      // Only add to shopping list if we need more
      if (neededQuantity > 0) {
        final shoppingItem = ShoppingListItem.create(
          name: ingredient.name,
          quantity: neededQuantity,
          unit: ingredient.unit,
          category: ingredient.category,
          recipeId: recipe.id,
        );
        shoppingItems.add(shoppingItem);
      }
    }
    
    return shoppingItems;
  }

  // Generate shopping list from multiple recipes
  Future<List<ShoppingListItem>> generateFromRecipes(List<Recipe> recipes) async {
    final consolidatedItems = <String, ShoppingListItem>{};
    
    for (final recipe in recipes) {
      final recipeItems = await generateFromRecipe(recipe);
      
      for (final item in recipeItems) {
        final key = '${item.name}_${item.unit}';
        
        if (consolidatedItems.containsKey(key)) {
          // Combine quantities for same ingredient
          final existingItem = consolidatedItems[key]!;
          consolidatedItems[key] = existingItem.copyWith(
            quantity: existingItem.quantity + item.quantity,
          );
        } else {
          consolidatedItems[key] = item;
        }
      }
    }
    
    return consolidatedItems.values.toList();
  }

  // Add items from recipe to shopping list
  Future<void> addRecipeToShoppingList(Recipe recipe) async {
    final items = await generateFromRecipe(recipe);
    for (final item in items) {
      await addItem(item);
    }
  }

  // Add items from multiple recipes to shopping list
  Future<void> addRecipesToShoppingList(List<Recipe> recipes) async {
    final items = await generateFromRecipes(recipes);
    for (final item in items) {
      await addItem(item);
    }
  }

  // Move completed items to pantry
  Future<void> moveCompletedItemsToPantry() async {
    final completedItems = getCompletedItems();
    
    for (final item in completedItems) {
      // Check if item already exists in pantry
      final existingPantryItems = _pantryService.findSimilarItems(item.name);
      
      if (existingPantryItems.isNotEmpty) {
        // Update existing pantry item quantity
        final existingItem = existingPantryItems.first;
        if (existingItem.unit == item.unit) {
          await _pantryService.addToItemQuantity(existingItem.id, item.quantity);
        } else {
          // Different unit, create new pantry item
          final pantryItem = PantryItem.create(
            name: item.name,
            quantity: item.quantity,
            unit: item.unit,
            category: item.category,
          );
          await _pantryService.addItem(pantryItem);
        }
      } else {
        // Create new pantry item
        final pantryItem = PantryItem.create(
          name: item.name,
          quantity: item.quantity,
          unit: item.unit,
          category: item.category,
        );
        await _pantryService.addItem(pantryItem);
      }
      
      // Remove from shopping list
      await deleteItem(item.id);
    }
  }

  // Get all categories
  List<String> getAllCategories() {
    final categories = <String>{};
    for (final item in _shoppingBox.values) {
      if (item.category != null) {
        categories.add(item.category!);
      }
    }
    return categories.toList()..sort();
  }

  // Clear completed items
  Future<void> clearCompletedItems() async {
    final completedItems = getCompletedItems();
    for (final item in completedItems) {
      await deleteItem(item.id);
    }
  }

  // Clear all items
  Future<void> clearAll() async {
    await _shoppingBox.clear();
  }

  // Get items count
  int get itemCount => _shoppingBox.length;
  int get pendingItemCount => getPendingItems().length;
  int get completedItemCount => getCompletedItems().length;

  // Check if item exists by name
  bool itemExists(String name) {
    return _shoppingBox.values.any((item) => 
        item.name.toLowerCase() == name.toLowerCase());
  }

  // Get estimated total cost
  double get estimatedTotalCost {
    return _shoppingBox.values
        .where((item) => !item.isCompleted && item.estimatedPrice != null)
        .fold(0.0, (sum, item) => sum + (item.estimatedPrice! * item.quantity));
  }
}