import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/shopping_list.dart';
import '../../domain/repositories/shopping_list_repository.dart';
import '../../domain/exceptions/app_exceptions.dart';
import '../services/firebase_service.dart';

class FirebaseShoppingListRepository implements IShoppingListRepository {
  static final FirebaseShoppingListRepository _instance = FirebaseShoppingListRepository._internal();
  static FirebaseShoppingListRepository get instance => _instance;
  
  FirebaseShoppingListRepository._internal();

  final FirebaseService _firebaseService = FirebaseService.instance;
  
  FirebaseFirestore get _firestore => _firebaseService.firestore;
  String? get _currentUserId => _firebaseService.currentUserId;

  @override
  Future<ShoppingList> createShoppingList(ShoppingList shoppingList) async {
    try {
      if (_currentUserId == null) throw const UserNotSignedInException();
      
      await _firebaseService.userCollection(_currentUserId!, 'shoppingLists')
          .doc(shoppingList.id)
          .set(shoppingList.toJson());
      
      await _firebaseService.logEvent('shopping_list_created', {
        'list_name': shoppingList.name,
        'item_count': shoppingList.items.length,
      });
      
      return shoppingList;
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<ShoppingList?> getShoppingListById(String listId) async {
    try {
      if (_currentUserId == null) throw const UserNotSignedInException();
      
      final doc = await _firebaseService.userCollection(_currentUserId!, 'shoppingLists')
          .doc(listId)
          .get();
      
      if (doc.exists && doc.data() != null) {
        return ShoppingList.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<List<ShoppingList>> getUserShoppingLists(String userId) async {
    try {
      final querySnapshot = await _firebaseService.userCollection(userId, 'shoppingLists')
          .where('isCompleted', isEqualTo: false)
          .orderBy('createdAt', descending: true)
          .get();
      
      return querySnapshot.docs
          .map((doc) => ShoppingList.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<ShoppingList> updateShoppingList(ShoppingList shoppingList) async {
    try {
      if (_currentUserId == null) throw const UserNotSignedInException();
      
      final updatedList = shoppingList.copyWith(
        updatedAt: DateTime.now(),
      );
      
      await _firebaseService.userCollection(_currentUserId!, 'shoppingLists')
          .doc(shoppingList.id)
          .update(updatedList.toJson());
      
      return updatedList;
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<void> deleteShoppingList(String listId) async {
    try {
      if (_currentUserId == null) throw const UserNotSignedInException();
      
      await _firebaseService.userCollection(_currentUserId!, 'shoppingLists')
          .doc(listId)
          .delete();
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<ShoppingList> addItemToList(String listId, ShoppingListItem item) async {
    try {
      if (_currentUserId == null) throw const UserNotSignedInException();
      
      return await _firestore.runTransaction((transaction) async {
        final listRef = _firebaseService.userCollection(_currentUserId!, 'shoppingLists').doc(listId);
        final doc = await transaction.get(listRef);
        
        if (!doc.exists) {
          throw const NotFoundException('Shopping list not found');
        }
        
        final shoppingList = ShoppingList.fromJson(doc.data()!);
        final updatedItems = [...shoppingList.items, item];
        final updatedList = shoppingList.copyWith(
          items: updatedItems,
          updatedAt: DateTime.now(),
        );
        
        transaction.update(listRef, updatedList.toJson());
        return updatedList;
      });
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<ShoppingList> updateItemInList(String listId, ShoppingListItem item) async {
    try {
      if (_currentUserId == null) throw const UserNotSignedInException();
      
      return await _firestore.runTransaction((transaction) async {
        final listRef = _firebaseService.userCollection(_currentUserId!, 'shoppingLists').doc(listId);
        final doc = await transaction.get(listRef);
        
        if (!doc.exists) {
          throw const NotFoundException('Shopping list not found');
        }
        
        final shoppingList = ShoppingList.fromJson(doc.data()!);
        final updatedItems = shoppingList.items.map((existingItem) {
          return existingItem.id == item.id ? item : existingItem;
        }).toList();
        
        final updatedList = shoppingList.copyWith(
          items: updatedItems,
          updatedAt: DateTime.now(),
        );
        
        transaction.update(listRef, updatedList.toJson());
        return updatedList;
      });
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<ShoppingList> removeItemFromList(String listId, String itemId) async {
    try {
      if (_currentUserId == null) throw const UserNotSignedInException();
      
      return await _firestore.runTransaction((transaction) async {
        final listRef = _firebaseService.userCollection(_currentUserId!, 'shoppingLists').doc(listId);
        final doc = await transaction.get(listRef);
        
        if (!doc.exists) {
          throw const NotFoundException('Shopping list not found');
        }
        
        final shoppingList = ShoppingList.fromJson(doc.data()!);
        final updatedItems = shoppingList.items.where((item) => item.id != itemId).toList();
        
        final updatedList = shoppingList.copyWith(
          items: updatedItems,
          updatedAt: DateTime.now(),
        );
        
        transaction.update(listRef, updatedList.toJson());
        return updatedList;
      });
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<ShoppingList> markItemCompleted(String listId, String itemId, {String? completedBy}) async {
    try {
      if (_currentUserId == null) throw const UserNotSignedInException();
      
      return await _firestore.runTransaction((transaction) async {
        final listRef = _firebaseService.userCollection(_currentUserId!, 'shoppingLists').doc(listId);
        final doc = await transaction.get(listRef);
        
        if (!doc.exists) {
          throw const NotFoundException('Shopping list not found');
        }
        
        final shoppingList = ShoppingList.fromJson(doc.data()!);
        final updatedItems = shoppingList.items.map((item) {
          if (item.id == itemId) {
            return item.copyWith(
              isCompleted: true,
              completedAt: DateTime.now(),
              completedBy: completedBy ?? _currentUserId,
            );
          }
          return item;
        }).toList();
        
        final updatedList = shoppingList.copyWith(
          items: updatedItems,
          updatedAt: DateTime.now(),
        );
        
        transaction.update(listRef, updatedList.toJson());
        return updatedList;
      });
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<ShoppingList> markItemUncompleted(String listId, String itemId) async {
    try {
      if (_currentUserId == null) throw const UserNotSignedInException();
      
      return await _firestore.runTransaction((transaction) async {
        final listRef = _firebaseService.userCollection(_currentUserId!, 'shoppingLists').doc(listId);
        final doc = await transaction.get(listRef);
        
        if (!doc.exists) {
          throw const NotFoundException('Shopping list not found');
        }
        
        final shoppingList = ShoppingList.fromJson(doc.data()!);
        final updatedItems = shoppingList.items.map((item) {
          if (item.id == itemId) {
            return item.copyWith(
              isCompleted: false,
              completedAt: null,
              completedBy: null,
            );
          }
          return item;
        }).toList();
        
        final updatedList = shoppingList.copyWith(
          items: updatedItems,
          updatedAt: DateTime.now(),
        );
        
        transaction.update(listRef, updatedList.toJson());
        return updatedList;
      });
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<List<ShoppingList>> getSharedShoppingLists(String userId) async {
    try {
      final querySnapshot = await _firestore.collectionGroup('shoppingLists')
          .where('sharedWith', arrayContains: userId)
          .where('isCompleted', isEqualTo: false)
          .orderBy('updatedAt', descending: true)
          .get();
      
      return querySnapshot.docs
          .map((doc) => ShoppingList.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<ShoppingList> shareShoppingList(String listId, List<String> userIds) async {
    try {
      if (_currentUserId == null) throw const UserNotSignedInException();
      
      return await _firestore.runTransaction((transaction) async {
        final listRef = _firebaseService.userCollection(_currentUserId!, 'shoppingLists').doc(listId);
        final doc = await transaction.get(listRef);
        
        if (!doc.exists) {
          throw const NotFoundException('Shopping list not found');
        }
        
        final shoppingList = ShoppingList.fromJson(doc.data()!);
        final updatedSharedWith = [...shoppingList.sharedWith, ...userIds].toSet().toList();
        
        final updatedList = shoppingList.copyWith(
          isShared: true,
          sharedWith: updatedSharedWith,
          updatedAt: DateTime.now(),
        );
        
        transaction.update(listRef, updatedList.toJson());
        return updatedList;
      });
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<ShoppingList> unshareShoppingList(String listId, List<String> userIds) async {
    try {
      if (_currentUserId == null) throw const UserNotSignedInException();
      
      return await _firestore.runTransaction((transaction) async {
        final listRef = _firebaseService.userCollection(_currentUserId!, 'shoppingLists').doc(listId);
        final doc = await transaction.get(listRef);
        
        if (!doc.exists) {
          throw const NotFoundException('Shopping list not found');
        }
        
        final shoppingList = ShoppingList.fromJson(doc.data()!);
        final updatedSharedWith = shoppingList.sharedWith
            .where((userId) => !userIds.contains(userId))
            .toList();
        
        final updatedList = shoppingList.copyWith(
          isShared: updatedSharedWith.isNotEmpty,
          sharedWith: updatedSharedWith,
          updatedAt: DateTime.now(),
        );
        
        transaction.update(listRef, updatedList.toJson());
        return updatedList;
      });
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<List<ShoppingListTemplate>> getShoppingListTemplates() async {
    try {
      final querySnapshot = await _firestore.collection('shoppingListTemplates')
          .where('isPublic', isEqualTo: true)
          .orderBy('usageCount', descending: true)
          .get();
      
      return querySnapshot.docs
          .map((doc) => ShoppingListTemplate.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<ShoppingList> createFromTemplate(String templateId, String userId, String name) async {
    try {
      final templateDoc = await _firestore.collection('shoppingListTemplates')
          .doc(templateId)
          .get();
      
      if (!templateDoc.exists) {
        throw const NotFoundException('Template not found');
      }
      
      final template = ShoppingListTemplate.fromJson(templateDoc.data()!);
      final shoppingList = ShoppingList(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        userId: userId,
        items: template.items,
        createdAt: DateTime.now(),
      );
      
      return await createShoppingList(shoppingList);
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<ShoppingListStats> getShoppingListStats(String listId) async {
    try {
      final shoppingList = await getShoppingListById(listId);
      if (shoppingList == null) {
        throw const NotFoundException('Shopping list not found');
      }
      
      final totalItems = shoppingList.items.length;
      final completedItems = shoppingList.items.where((item) => item.isCompleted).length;
      final urgentItems = shoppingList.items.where((item) => item.isUrgent).length;
      
      final categoryDistribution = <String, int>{};
      double estimatedTotal = 0.0;
      double actualTotal = 0.0;
      
      for (final item in shoppingList.items) {
        categoryDistribution[item.category] = (categoryDistribution[item.category] ?? 0) + 1;
        
        if (item.estimatedPrice != null) {
          estimatedTotal += item.estimatedPrice! * item.quantity;
        }
        
        if (item.actualPrice != null) {
          actualTotal += item.actualPrice! * item.quantity;
        }
      }
      
      return ShoppingListStats(
        totalItems: totalItems,
        completedItems: completedItems,
        urgentItems: urgentItems,
        estimatedTotal: estimatedTotal,
        actualTotal: actualTotal,
        categoryDistribution: categoryDistribution,
        lastUpdated: shoppingList.updatedAt ?? shoppingList.createdAt,
        collaborators: shoppingList.sharedWith.length,
      );
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<List<ShoppingList>> searchShoppingLists(String userId, String query) async {
    try {
      final allLists = await getUserShoppingLists(userId);
      
      return allLists.where((list) {
        return list.name.toLowerCase().contains(query.toLowerCase()) ||
               (list.notes?.toLowerCase().contains(query.toLowerCase()) ?? false) ||
               list.items.any((item) => item.name.toLowerCase().contains(query.toLowerCase()));
      }).toList();
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<List<ShoppingList>> getRecentShoppingLists(String userId, {int limit = 10}) async {
    try {
      final querySnapshot = await _firebaseService.userCollection(userId, 'shoppingLists')
          .orderBy('updatedAt', descending: true)
          .limit(limit)
          .get();
      
      return querySnapshot.docs
          .map((doc) => ShoppingList.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<ShoppingList> duplicateShoppingList(String listId, String newName) async {
    try {
      final originalList = await getShoppingListById(listId);
      if (originalList == null) {
        throw const NotFoundException('Shopping list not found');
      }
      
      final duplicatedList = originalList.copyWith(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: newName,
        createdAt: DateTime.now(),
        updatedAt: null,
        completedAt: null,
        isCompleted: false,
        isShared: false,
        sharedWith: [],
        items: originalList.items.map((item) => item.copyWith(
          id: '${item.id}_${DateTime.now().millisecondsSinceEpoch}',
          isCompleted: false,
          completedAt: null,
          completedBy: null,
          actualPrice: null,
        )).toList(),
      );
      
      return await createShoppingList(duplicatedList);
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<void> archiveShoppingList(String listId) async {
    try {
      if (_currentUserId == null) throw const UserNotSignedInException();
      
      final shoppingList = await getShoppingListById(listId);
      if (shoppingList == null) {
        throw const NotFoundException('Shopping list not found');
      }
      
      final archivedList = shoppingList.copyWith(
        isCompleted: true,
        completedAt: DateTime.now(),
      );
      
      await updateShoppingList(archivedList);
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<List<ShoppingList>> getArchivedShoppingLists(String userId) async {
    try {
      final querySnapshot = await _firebaseService.userCollection(userId, 'shoppingLists')
          .where('isCompleted', isEqualTo: true)
          .orderBy('completedAt', descending: true)
          .get();
      
      return querySnapshot.docs
          .map((doc) => ShoppingList.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<ShoppingList> restoreShoppingList(String listId) async {
    try {
      final shoppingList = await getShoppingListById(listId);
      if (shoppingList == null) {
        throw const NotFoundException('Shopping list not found');
      }
      
      final restoredList = shoppingList.copyWith(
        isCompleted: false,
        completedAt: null,
        updatedAt: DateTime.now(),
      );
      
      return await updateShoppingList(restoredList);
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<List<ShoppingListItem>> getItemsByBarcode(String barcode) async {
    try {
      // This would typically query a product database
      // For now, return empty list
      return [];
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<List<PriceHistory>> getPriceHistory(String itemName, {int days = 30}) async {
    try {
      final cutoffDate = DateTime.now().subtract(Duration(days: days));
      
      final querySnapshot = await _firestore.collection('priceHistory')
          .where('itemName', isEqualTo: itemName)
          .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(cutoffDate))
          .orderBy('date', descending: true)
          .get();
      
      return querySnapshot.docs
          .map((doc) => PriceHistory.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<void> updateItemPrice(String listId, String itemId, double price) async {
    try {
      final item = await _getItemFromList(listId, itemId);
      if (item == null) {
        throw const NotFoundException('Item not found');
      }
      
      final updatedItem = item.copyWith(actualPrice: price);
      await updateItemInList(listId, updatedItem);
      
      // Record price history
      await _recordPriceHistory(item.name, price);
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<StoreLayout?> getStoreLayout(String storeId) async {
    try {
      final doc = await _firestore.collection('storeLayouts')
          .doc(storeId)
          .get();
      
      if (doc.exists && doc.data() != null) {
        return StoreLayout.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<ShoppingList> optimizeForStore(String listId, String storeId) async {
    try {
      final shoppingList = await getShoppingListById(listId);
      if (shoppingList == null) {
        throw const NotFoundException('Shopping list not found');
      }
      
      final storeLayout = await getStoreLayout(storeId);
      if (storeLayout == null) {
        return shoppingList; // Return unchanged if no layout available
      }
      
      // Sort items by store aisle order
      final sortedItems = List<ShoppingListItem>.from(shoppingList.items);
      sortedItems.sort((a, b) {
        final aAisle = _getAisleForCategory(a.category, storeLayout);
        final bAisle = _getAisleForCategory(b.category, storeLayout);
        
        final aIndex = storeLayout.aisleOrder.indexOf(aAisle);
        final bIndex = storeLayout.aisleOrder.indexOf(bAisle);
        
        if (aIndex == -1 && bIndex == -1) return 0;
        if (aIndex == -1) return 1;
        if (bIndex == -1) return -1;
        
        return aIndex.compareTo(bIndex);
      });
      
      final optimizedList = shoppingList.copyWith(
        items: sortedItems,
        storeId: storeId,
        updatedAt: DateTime.now(),
      );
      
      return await updateShoppingList(optimizedList);
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  // Helper methods
  Future<ShoppingListItem?> _getItemFromList(String listId, String itemId) async {
    final shoppingList = await getShoppingListById(listId);
    if (shoppingList == null) return null;
    
    try {
      return shoppingList.items.firstWhere((item) => item.id == itemId);
    } catch (e) {
      return null;
    }
  }

  Future<void> _recordPriceHistory(String itemName, double price) async {
    try {
      final priceRecord = PriceHistory(
        itemName: itemName,
        price: price,
        store: 'Unknown Store', // Would be determined from context
        date: DateTime.now(),
      );
      
      await _firestore.collection('priceHistory').add(priceRecord.toJson());
    } catch (e) {
      // Silently fail for price history recording
    }
  }

  String _getAisleForCategory(String category, StoreLayout storeLayout) {
    final aisles = storeLayout.categoryAisles[category];
    return aisles?.isNotEmpty == true ? aisles!.first : 'Unknown';
  }
}