import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/pantry_item.dart';
import '../../domain/entities/shopping_list.dart';
import '../../domain/repositories/pantry_repository.dart';
import '../models/pantry_model.dart';
import '../../core/config/api_constants.dart';
import '../../core/errors/app_exceptions.dart';

class FirebasePantryRepository implements PantryRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> addPantryItem(PantryItem item) async {
    try {
      final model = PantryModel.fromDomain(item);
      await _firestore
          .collection('pantry_items')
          .doc(item.id)
          .set(model.toJson());
    } catch (e) {
      throw const DatabaseException('Failed to add pantry item');
    }
  }

  @override
  Future<void> updatePantryItem(PantryItem item) async {
    try {
      final model = PantryModel.fromDomain(item);
      await _firestore
          .collection('pantry_items')
          .doc(item.id)
          .update(model.toJson());
    } catch (e) {
      throw const DatabaseException('Failed to update pantry item');
    }
  }

  @override
  Future<void> deletePantryItem(String itemId) async {
    try {
      await _firestore.collection('pantry_items').doc(itemId).delete();
    } catch (e) {
      throw const DatabaseException('Failed to delete pantry item');
    }
  }

  @override
  Future<List<PantryItem>> getPantryItems(String userId,
      {String? category}) async {
    try {
      Query query = _firestore
          .collection(ApiConstants.usersCollection)
          .doc(userId)
          .collection('pantry')
          .orderBy('name');

      if (category != null) {
        query = query.where('category', isEqualTo: category);
      }

      final querySnapshot = await query.get();
      return querySnapshot.docs.map((doc) {
        final model = PantryModel.fromJson(doc.data() as Map<String, dynamic>);
        return model.toDomain();
      }).toList();
    } catch (e) {
      throw const DatabaseException('Failed to get pantry items');
    }
  }

  @override
  Future<List<PantryItem>> searchPantryItems(
      String userId, String query) async {
    try {
      final querySnapshot = await _firestore
          .collection(ApiConstants.usersCollection)
          .doc(userId)
          .collection('pantry')
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name', isLessThanOrEqualTo: '$query\uf8ff')
          .get();

      return querySnapshot.docs.map((doc) {
        final model = PantryModel.fromJson(doc.data());
        return model.toDomain();
      }).toList();
    } catch (e) {
      throw const DatabaseException('Failed to search pantry items');
    }
  }

  @override
  Future<List<PantryItem>> getExpiringItems(
      String userId, int daysFromNow) async {
    try {
      final futureDate = DateTime.now().add(Duration(days: daysFromNow));
      final querySnapshot = await _firestore
          .collection(ApiConstants.usersCollection)
          .doc(userId)
          .collection('pantry')
          .where('expiryDate',
              isLessThanOrEqualTo: Timestamp.fromDate(futureDate))
          .orderBy('expiryDate')
          .get();

      return querySnapshot.docs.map((doc) {
        final model = PantryModel.fromJson(doc.data());
        return model.toDomain();
      }).toList();
    } catch (e) {
      throw const DatabaseException('Failed to get expiring items');
    }
  }

  @override
  Future<ShoppingList> generateShoppingList(
      String userId, List<String> recipeIds) async {
    try {
      // Get pantry items for the user
      final pantryItems = await getPantryItems(userId);

      // Create shopping items from pantry items that are running low
      final shoppingItems = pantryItems
          .where((item) => item.isLowStock)
          .map((item) => ShoppingItem(
                id: item.id,
                name: item.name,
                category: item.category ?? 'Other',
                quantity: 1.0, // Default quantity
                unit: item.unit,
                isCompleted: false,
                isUrgent: false,
                estimatedCost: null, // item.cost not available in PantryItem
                brand: null, // item.brand not available in PantryItem
                notes: item.notes,
                addedAt: DateTime.now(),
              ))
          .toList();

      // Return proper ShoppingList using your entity structure
      return ShoppingList(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: 'Generated Shopping List',
        userId: userId,
        items: shoppingItems,
        isCompleted: false,
        isShared: false,
        sharedWithUsers: const [],
        createdAt: DateTime.now(),
        notes: 'Auto-generated from low pantry items',
      );
    } catch (e) {
      throw const DatabaseException('Failed to generate shopping list');
    }
  }

  @override
  Stream<List<PantryItem>> watchPantryItems(String userId) {
    return _firestore
        .collection(ApiConstants.usersCollection)
        .doc(userId)
        .collection('pantry')
        .orderBy('name')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final model = PantryModel.fromJson(doc.data());
        return model.toDomain();
      }).toList();
    });
  }
}
