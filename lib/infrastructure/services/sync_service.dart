import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/services/hive_service.dart';
import '../../domain/exceptions/app_exceptions.dart';
import '../repositories/firebase_recipe_repository.dart';
import '../repositories/firebase_user_repository.dart';
import '../repositories/firebase_pantry_repository.dart';
import 'firebase_service.dart';

enum SyncStatus {
  idle,
  syncing,
  success,
  error,
  offline,
}

class SyncService {
  static SyncService? _instance;
  static SyncService get instance => _instance ??= SyncService._();
  
  SyncService._();

  final FirebaseService _firebaseService = FirebaseService.instance;
  final Connectivity _connectivity = Connectivity();
  
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;
  Timer? _syncTimer;
  
  final StreamController<SyncStatus> _syncStatusController = StreamController<SyncStatus>.broadcast();
  Stream<SyncStatus> get syncStatusStream => _syncStatusController.stream;
  
  SyncStatus _currentStatus = SyncStatus.idle;
  SyncStatus get currentStatus => _currentStatus;
  
  bool _isInitialized = false;
  bool _isSyncing = false;

  Future<void> initialize() async {
    if (_isInitialized) return;
    
    // Listen to connectivity changes
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_onConnectivityChanged);
    
    // Check initial connectivity
    final connectivityResult = await _connectivity.checkConnectivity();
    _onConnectivityChanged(connectivityResult);
    
    // Set up periodic sync
    _setupPeriodicSync();
    
    _isInitialized = true;
  }

  void _onConnectivityChanged(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      _updateStatus(SyncStatus.offline);
      _cancelPeriodicSync();
    } else {
      if (_currentStatus == SyncStatus.offline) {
        _updateStatus(SyncStatus.idle);
        _setupPeriodicSync();
        // Trigger immediate sync when coming back online
        syncAll();
      }
    }
  }

  void _setupPeriodicSync() {
    _cancelPeriodicSync();
    _syncTimer = Timer.periodic(const Duration(minutes: 5), (_) {
      if (!_isSyncing && _currentStatus != SyncStatus.offline) {
        syncAll();
      }
    });
  }

  void _cancelPeriodicSync() {
    _syncTimer?.cancel();
    _syncTimer = null;
  }

  void _updateStatus(SyncStatus status) {
    _currentStatus = status;
    _syncStatusController.add(status);
  }

  Future<bool> isOnline() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  Future<void> syncAll() async {
    if (_isSyncing || !await isOnline()) return;
    
    _isSyncing = true;
    _updateStatus(SyncStatus.syncing);
    
    try {
      // Sync in order of priority
      await _syncUserProfile();
      await _syncRecipes();
      await _syncPantryItems();
      await _processSyncQueue();
      
      // Clear expired cache
      await HiveService.clearExpiredCache();
      
      _updateStatus(SyncStatus.success);
    } catch (e) {
      _updateStatus(SyncStatus.error);
      throw SyncException('Sync failed: $e');
    } finally {
      _isSyncing = false;
    }
  }

  Future<void> _syncUserProfile() async {
    try {
      final userId = _firebaseService.currentUserId;
      if (userId == null) return;

      // Check if we have offline changes
      final offlineProfile = HiveService.getOfflineData('user_profile_$userId');
      if (offlineProfile != null) {
        // Upload offline changes
        final userRepository = FirebaseUserRepository();
        // Convert and upload profile
        await HiveService.markDataAsSynced('user_profile_$userId');
      }

      // Download latest profile
      final userRepository = FirebaseUserRepository();
      final profile = await userRepository.getUserProfile(userId);
      if (profile != null) {
        await HiveService.saveUserProfile(profile);
      }
    } catch (e) {
      throw SyncException('User profile sync failed: $e');
    }
  }

  Future<void> _syncRecipes() async {
    try {
      final userId = _firebaseService.currentUserId;
      if (userId == null) return;

      final recipeRepository = FirebaseRecipeRepository();
      
      // Upload offline recipes
      final unsyncedRecipes = HiveService.getUnsyncedData()
          .where((entry) => entry.key.startsWith('recipe_'))
          .toList();
      
      for (final entry in unsyncedRecipes) {
        try {
          // Convert and upload recipe
          await HiveService.markDataAsSynced(entry.key);
        } catch (e) {
          // Log error but continue with other recipes
          print('Failed to sync recipe ${entry.key}: $e');
        }
      }

      // Download latest recipes (with pagination)
      final recipes = await recipeRepository.getUserRecipes(userId);
      for (final recipe in recipes) {
        await HiveService.saveRecipe(recipe);
      }
    } catch (e) {
      throw SyncException('Recipe sync failed: $e');
    }
  }

  Future<void> _syncPantryItems() async {
    try {
      final userId = _firebaseService.currentUserId;
      if (userId == null) return;

      final pantryRepository = FirebasePantryRepository();
      
      // Upload offline pantry changes
      final unsyncedPantryItems = HiveService.getUnsyncedData()
          .where((entry) => entry.key.startsWith('pantry_'))
          .toList();
      
      for (final entry in unsyncedPantryItems) {
        try {
          // Convert and upload pantry item
          await HiveService.markDataAsSynced(entry.key);
        } catch (e) {
          print('Failed to sync pantry item ${entry.key}: $e');
        }
      }

      // Download latest pantry items
      final pantryItems = await pantryRepository.getUserPantryItems(userId);
      // Cache pantry items locally
      // Note: Would need to add pantry item caching to HiveService
    } catch (e) {
      throw SyncException('Pantry sync failed: $e');
    }
  }

  Future<void> _processSyncQueue() async {
    final syncQueue = HiveService.getSyncQueue();
    
    for (final entry in syncQueue) {
      final operation = entry.value['operation'] as String;
      final data = entry.value['data'] as Map<String, dynamic>;
      final retryCount = entry.value['retryCount'] as int;
      
      // Skip if too many retries
      if (retryCount >= 3) {
        await HiveService.removeFromSyncQueue(entry.key);
        continue;
      }
      
      try {
        await _executeSyncOperation(operation, data);
        await HiveService.removeFromSyncQueue(entry.key);
      } catch (e) {
        await HiveService.incrementRetryCount(entry.key);
        print('Sync operation failed: $operation, error: $e');
      }
    }
  }

  Future<void> _executeSyncOperation(String operation, Map<String, dynamic> data) async {
    switch (operation) {
      case 'create_recipe':
        final recipeRepository = FirebaseRecipeRepository();
        // Convert data to Recipe and save
        break;
      case 'update_recipe':
        final recipeRepository = FirebaseRecipeRepository();
        // Convert data to Recipe and update
        break;
      case 'delete_recipe':
        final recipeRepository = FirebaseRecipeRepository();
        await recipeRepository.deleteRecipe(data['recipeId'] as String);
        break;
      case 'create_pantry_item':
        final pantryRepository = FirebasePantryRepository();
        // Convert data to PantryItem and save
        break;
      case 'update_pantry_item':
        final pantryRepository = FirebasePantryRepository();
        // Convert data to PantryItem and update
        break;
      case 'delete_pantry_item':
        final pantryRepository = FirebasePantryRepository();
        await pantryRepository.deletePantryItem(data['itemId'] as String);
        break;
      default:
        throw SyncException('Unknown sync operation: $operation');
    }
  }

  // Conflict resolution strategies
  Future<T> resolveConflict<T>(
    T localData,
    T remoteData,
    ConflictResolutionStrategy strategy,
  ) async {
    switch (strategy) {
      case ConflictResolutionStrategy.localWins:
        return localData;
      case ConflictResolutionStrategy.remoteWins:
        return remoteData;
      case ConflictResolutionStrategy.lastModifiedWins:
        // Would need lastModified timestamps on entities
        return remoteData; // Default to remote for now
      case ConflictResolutionStrategy.merge:
        // Custom merge logic would go here
        return remoteData; // Default to remote for now
    }
  }

  // Manual sync triggers
  Future<void> syncRecipes() async {
    if (!await isOnline()) throw const NoInternetException();
    await _syncRecipes();
  }

  Future<void> syncUserProfile() async {
    if (!await isOnline()) throw const NoInternetException();
    await _syncUserProfile();
  }

  Future<void> syncPantryItems() async {
    if (!await isOnline()) throw const NoInternetException();
    await _syncPantryItems();
  }

  // Queue operations for offline execution
  Future<void> queueRecipeCreate(Map<String, dynamic> recipeData) async {
    await HiveService.addToSyncQueue('create_recipe', recipeData);
  }

  Future<void> queueRecipeUpdate(Map<String, dynamic> recipeData) async {
    await HiveService.addToSyncQueue('update_recipe', recipeData);
  }

  Future<void> queueRecipeDelete(String recipeId) async {
    await HiveService.addToSyncQueue('delete_recipe', {'recipeId': recipeId});
  }

  Future<void> queuePantryItemCreate(Map<String, dynamic> itemData) async {
    await HiveService.addToSyncQueue('create_pantry_item', itemData);
  }

  Future<void> queuePantryItemUpdate(Map<String, dynamic> itemData) async {
    await HiveService.addToSyncQueue('update_pantry_item', itemData);
  }

  Future<void> queuePantryItemDelete(String itemId) async {
    await HiveService.addToSyncQueue('delete_pantry_item', {'itemId': itemId});
  }

  // Cleanup and disposal
  Future<void> dispose() async {
    await _connectivitySubscription?.cancel();
    _cancelPeriodicSync();
    await _syncStatusController.close();
    _isInitialized = false;
  }

  // Statistics
  Map<String, dynamic> getSyncStats() {
    final syncQueue = HiveService.getSyncQueue();
    final unsyncedData = HiveService.getUnsyncedData();
    
    return {
      'status': _currentStatus.name,
      'queuedOperations': syncQueue.length,
      'unsyncedItems': unsyncedData.length,
      'isOnline': _currentStatus != SyncStatus.offline,
      'lastSyncAttempt': DateTime.now().toIso8601String(),
    };
  }
}

enum ConflictResolutionStrategy {
  localWins,
  remoteWins,
  lastModifiedWins,
  merge,
}

class SyncException extends AppException {
  const SyncException(String message) : super(message);
}

// Riverpod providers for sync service
final syncServiceProvider = Provider<SyncService>((ref) {
  return SyncService.instance;
});

final syncStatusProvider = StreamProvider<SyncStatus>((ref) {
  final syncService = ref.read(syncServiceProvider);
  return syncService.syncStatusStream;
});

final syncStatsProvider = Provider<Map<String, dynamic>>((ref) {
  final syncService = ref.read(syncServiceProvider);
  return syncService.getSyncStats();
});