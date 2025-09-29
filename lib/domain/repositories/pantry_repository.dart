import '../entities/pantry_item.dart';
import '../entities/shopping_list.dart';

abstract class PantryRepository {
  Future<void> addPantryItem(PantryItem item);
  Future<List<PantryItem>> getPantryItems(String userId);
  Future<void> updatePantryItem(PantryItem item);
  Future<void> deletePantryItem(String itemId);
  Future<List<PantryItem>> getExpiringItems(String userId, int days);
  Future<List<PantryItem>> searchPantryItems(String userId, String query);
  Future<ShoppingList> generateShoppingList(String userId, List<String> recipeIds);
  Stream<List<PantryItem>> watchPantryItems(String userId);
}
