import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/pantry_item.dart';
import '../../domain/repositories/pantry_repository.dart';
import '../../domain/exceptions/app_exceptions.dart';
import '../services/firebase_service.dart';

class FirebasePantryRepository implements IPantryRepository {
  static final FirebasePantryRepository _instance = FirebasePantryRepository._internal();
  static FirebasePantryRepository get instance => _instance;
  
  FirebasePantryRepository._internal();

  final FirebaseService _firebaseService = FirebaseService.instance;
  
  FirebaseFirestore get _firestore => _firebaseService.firestore;
  String? get _currentUserId => _firebaseService.currentUserId;

  @override
  Future<PantryItem> addPantryItem(PantryItem item) async {
    try {
      if (_currentUserId == null) throw const UserNotSignedInException();
      
      await _firebaseService.userCollection(_currentUserId!, 'pantry')
          .doc(item.id)
          .set(item.toJson());
      
      await _firebaseService.logEvent('pantry_item_added', {
        'item_name': item.name,
        'category': item.category.id,
      });
      
      return item;
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<PantryItem?> getPantryItemById(String itemId) async {
    try {
      if (_currentUserId == null) throw const UserNotSignedInException();
      
      final doc = await _firebaseService.userCollection(_currentUserId!, 'pantry')
          .doc(itemId)
          .get();
      
      if (doc.exists && doc.data() != null) {
        return PantryItem.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<List<PantryItem>> getUserPantryItems(String userId) async {
    try {
      final querySnapshot = await _firebaseService.userCollection(userId, 'pantry')
          .orderBy('name')
          .get();
      
      return querySnapshot.docs
          .map((doc) => PantryItem.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<PantryItem> updatePantryItem(PantryItem item) async {
    try {
      if (_currentUserId == null) throw const UserNotSignedInException();
      
      final updatedItem = item.copyWith(
        updatedAt: DateTime.now(),
      );
      
      await _firebaseService.userCollection(_currentUserId!, 'pantry')
          .doc(item.id)
          .update(updatedItem.toJson());
      
      return updatedItem;
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<void> deletePantryItem(String itemId) async {
    try {
      if (_currentUserId == null) throw const UserNotSignedInException();
      
      await _firebaseService.userCollection(_currentUserId!, 'pantry')
          .doc(itemId)
          .delete();
      
      // Delete related alerts
      await _deleteItemAlerts(itemId);
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<List<PantryItem>> getPantryItemsByCategory(String userId, String categoryId) async {
    try {
      final querySnapshot = await _firebaseService.userCollection(userId, 'pantry')
          .where('category.id', isEqualTo: categoryId)
          .orderBy('name')
          .get();
      
      return querySnapshot.docs
          .map((doc) => PantryItem.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }



  @override
  Future<List<PantryItem>> getExpiringItems(String userId, int daysAhead) async {
    try {
      final cutoffDate = DateTime.now().add(Duration(days: daysAhead));
      
      final querySnapshot = await _firebaseService.userCollection(userId, 'pantry')
          .where('expiryDate', isLessThanOrEqualTo: Timestamp.fromDate(cutoffDate))
          .where('expiryDate', isGreaterThan: Timestamp.fromDate(DateTime.now()))
          .orderBy('expiryDate')
          .get();
      
      return querySnapshot.docs
          .map((doc) => PantryItem.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<List<PantryItem>> getLowStockItems(String userId) async {
    try {
      final querySnapshot = await _firebaseService.userCollection(userId, 'pantry')
          .where('isLowStock', isEqualTo: true)
          .orderBy('name')
          .get();
      
      return querySnapshot.docs
          .map((doc) => PantryItem.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<PantryStats> getPantryStats(String userId) async {
    try {
      final items = await getUserPantryItems(userId);
      final expiringItems = await getExpiringItems(userId, 7);
      final lowStockItems = await getLowStockItems(userId);
      
      final categoryDistribution = <String, int>{};
      double totalValue = 0.0;
      
      for (final item in items) {
        categoryDistribution[item.category.id] = 
            (categoryDistribution[item.category.id] ?? 0) + 1;
        // Estimate value if not available
        totalValue += (item.quantity * 2.0); // Basic estimation
      }
      
      return PantryStats(
        totalItems: items.length,
        expiringItems: expiringItems.length,
        lowStockItems: lowStockItems.length,
        categoryDistribution: categoryDistribution,
        totalValue: totalValue,
        itemsAddedThisWeek: await _getItemsAddedThisWeek(userId),
        itemsUsedThisWeek: await _getItemsUsedThisWeek(userId),
      );
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<List<PantryItem>> bulkUpdatePantryItems(List<PantryItem> items) async {
    try {
      if (_currentUserId == null) throw const UserNotSignedInException();
      
      final batch = _firestore.batch();
      final updatedItems = <PantryItem>[];
      
      for (final item in items) {
        final updatedItem = item.copyWith(updatedAt: DateTime.now());
        final docRef = _firebaseService.userCollection(_currentUserId!, 'pantry').doc(item.id);
        batch.update(docRef, updatedItem.toJson());
        updatedItems.add(updatedItem);
      }
      
      await batch.commit();
      return updatedItems;
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<PantryItem?> getPantryItemByBarcode(String userId, String barcode) async {
    try {
      final querySnapshot = await _firebaseService.userCollection(userId, 'pantry')
          .where('barcode', isEqualTo: barcode)
          .limit(1)
          .get();
      
      if (querySnapshot.docs.isNotEmpty) {
        return PantryItem.fromJson(querySnapshot.docs.first.data());
      }
      return null;
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<List<String>> getSuggestedItems(String userId) async {
    try {
      // In a real implementation, this would use ML or usage patterns
      // For now, return common pantry items
      return [
        'Milk', 'Bread', 'Eggs', 'Butter', 'Cheese',
        'Chicken', 'Rice', 'Pasta', 'Onions', 'Garlic',
      ];
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<void> markItemAsUsed(String itemId, double quantityUsed) async {
    try {
      if (_currentUserId == null) throw const UserNotSignedInException();
      
      await _firestore.runTransaction((transaction) async {
        final itemRef = _firebaseService.userCollection(_currentUserId!, 'pantry').doc(itemId);
        final doc = await transaction.get(itemRef);
        
        if (!doc.exists) {
          throw const NotFoundException('Pantry item not found');
        }
        
        final data = doc.data()!;
        final currentQuantity = (data['quantity'] as num?)?.toDouble() ?? 0.0;
        final newQuantity = (currentQuantity - quantityUsed).clamp(0.0, double.infinity);
        final minQuantity = (data['minQuantity'] as num?)?.toDouble();
        
        transaction.update(itemRef, {
          'quantity': newQuantity,
          'updatedAt': FieldValue.serverTimestamp(),
          'isLowStock': minQuantity != null && newQuantity <= minQuantity,
        });
        
        // Record usage
        final usageRef = _firebaseService.userCollection(_currentUserId!, 'pantryUsage').doc();
        transaction.set(usageRef, {
          'id': usageRef.id,
          'itemId': itemId,
          'itemName': data['name'],
          'quantityUsed': quantityUsed,
          'unit': data['unit'],
          'usedAt': FieldValue.serverTimestamp(),
        });
      });
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<List<PantryUsageRecord>> getUsageHistory(String userId, {DateTime? since}) async {
    try {
      var query = _firebaseService.userCollection(userId, 'pantryUsage')
          .orderBy('usedAt', descending: true);
      
      if (since != null) {
        query = query.where('usedAt', isGreaterThanOrEqualTo: Timestamp.fromDate(since));
      }
      
      final querySnapshot = await query.limit(100).get();
      
      return querySnapshot.docs
          .map((doc) => PantryUsageRecord.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  // Helper methods
  Future<int> _getItemsAddedThisWeek(String userId) async {
    try {
      final weekAgo = DateTime.now().subtract(const Duration(days: 7));
      final querySnapshot = await _firebaseService.userCollection(userId, 'pantry')
          .where('createdAt', isGreaterThanOrEqualTo: Timestamp.fromDate(weekAgo))
          .get();
      
      return querySnapshot.docs.length;
    } catch (e) {
      return 0;
    }
  }

  Future<int> _getItemsUsedThisWeek(String userId) async {
    try {
      final weekAgo = DateTime.now().subtract(const Duration(days: 7));
      final querySnapshot = await _firebaseService.userCollection(userId, 'pantryUsage')
          .where('usedAt', isGreaterThanOrEqualTo: Timestamp.fromDate(weekAgo))
          .get();
      
      return querySnapshot.docs.length;
    } catch (e) {
      return 0;
    }
  }

  @override
  Future<List<PantryItem>> searchPantryItems(String userId, String query) async {
    try {
      final allItems = await getUserPantryItems(userId);
      
      return allItems.where((item) {
        return item.name.toLowerCase().contains(query.toLowerCase()) ||
               (item.brand?.toLowerCase().contains(query.toLowerCase()) ?? false) ||
               (item.notes?.toLowerCase().contains(query.toLowerCase()) ?? false);
      }).toList();
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  Future<void> _deleteItemAlerts(String itemId) async {
    // TODO: Implement alert deletion logic
  }
}