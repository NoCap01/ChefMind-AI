import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/services/hive_service.dart';
import '../../domain/entities/recipe.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/entities/pantry.dart';
import '../../domain/exceptions/app_exceptions.dart';
import 'sync_service.dart';

class OfflineService {
  static OfflineService? _instance;
  static OfflineService get instance => _instance ??= OfflineService._();
  
  OfflineService._();

  final Connectivity _connectivity = Connectivity();
  final SyncService _syncService = SyncService.instance;
  
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;
  
  bool _isOnline = true;
  bool get isOnline => _isOnline;
  
  final StreamController<bool> _connectivityController = StreamController<bool>.broadcast();
  Stream<bool> get connectivityStream => _connectivityController.stream;

  Future<void> initialize() async {
    // Check initial connectivity
    final connectivityResult = await _connectivity.checkConnectivity();
    _updateConnectivity(connectivityResult != ConnectivityResult.none);
    
    // Listen to connectivity changes
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((result) {
      _updateConnectivity(result != ConnectivityResult.none);
    });
  }

  void _updateConnectivity(bool isOnline) {
    if (_isOnline != isOnline) {
      _isOnline = isOnline;
      _connectivityController.add(isOnline);
      
      if (isOnline) {
        // Trigger sync when coming back online
        _syncService.syncAll().catchError((e) {
          print('Auto-sync failed: $e');
        });
      }
    }
  }

  // Recipe operations with offline support
  Future<void> saveRecipeOffline(Recipe recipe) async {
    try {
      // Save to local storage immediately
      await HiveService.saveRecipe(recipe);
      
      if (_isOnline) {
        // Try to sync immediately if online
        await _syncService.queueRecipeCreate(recipe.toJson());
      } else {
        // Queue for later sync
        await HiveService.saveOfflineData('recipe_${recipe.id}', recipe.toJson());
      }
    } catch (e) {
      throw StorageException('Failed to save recipe offline: $e');
    }
  }

  Future<void> updateRecipeOffline(Recipe recipe) async {
    try {
      // Update local storage
      await HiveService.saveRecipe(recipe);
      
      if (_isOnline) {
        await _syncService.queueRecipeUpdate(recipe.toJson());
      } else {
        await HiveService.saveOfflineData('recipe_${recipe.id}', recipe.toJson());
      }
    } catch (e) {
      throw StorageException('Failed to update recipe offline: $e');
    }
  }

  Future<void> deleteRecipeOffline(String recipeId) async {
    try {
      // Delete from local storage
      await HiveService.deleteRecipe(recipeId);
      
      if (_isOnline) {
        await _syncService.queueRecipeDelete(recipeId);
      } else {
        // Mark for deletion when online
        await HiveService.saveOfflineData('delete_recipe_$recipeId', {
          'operation': 'delete',
          'recipeId': recipeId,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        });
      }
    } catch (e) {
      throw StorageException('Failed to delete recipe offline: $e');
    }
  }

  Recipe? getRecipeOffline(String recipeId) {
    try {
      return HiveService.getRecipe(recipeId);
    } catch (e) {
      throw StorageException('Failed to get recipe offline: $e');
    }
  }

  List<Recipe> getAllRecipesOffline() {
    try {
      return HiveService.getAllRecipes();
    } catch (e) {
      throw StorageException('Failed to get recipes offline: $e');
    }
  }

  List<Recipe> getFavoriteRecipesOffline() {
    try {
      return HiveService.getFavoriteRecipes();
    } catch (e) {
      throw StorageException('Failed to get favorite recipes offline: $e');
    }
  }

  // User profile operations with offline support
  Future<void> saveUserProfileOffline(UserProfile profile) async {
    try {
      await HiveService.saveUserProfile(profile);
      
      if (_isOnline) {
        // Sync immediately if online
        // Would queue user profile update
      } else {
        await HiveService.saveOfflineData('user_profile_${profile.id}', profile.toJson());
      }
    } catch (e) {
      throw StorageException('Failed to save user profile offline: $e');
    }
  }

  UserProfile? getUserProfileOffline(String userId) {
    try {
      return HiveService.getUserProfile(userId);
    } catch (e) {
      throw StorageException('Failed to get user profile offline: $e');
    }
  }

  // Search operations with offline support
  List<Recipe> searchRecipesOffline(String query) {
    try {
      final allRecipes = HiveService.getAllRecipes();
      
      if (query.isEmpty) return allRecipes;
      
      return allRecipes.where((recipe) {
        final searchText = query.toLowerCase();
        return recipe.title.toLowerCase().contains(searchText) ||
               recipe.description.toLowerCase().contains(searchText) ||
               recipe.ingredients.any((ingredient) => 
                   ingredient.name.toLowerCase().contains(searchText)) ||
               recipe.tags.any((tag) => 
                   tag.toLowerCase().contains(searchText));
      }).toList();
    } catch (e) {
      throw StorageException('Failed to search recipes offline: $e');
    }
  }

  List<Recipe> filterRecipesOffline({
    List<String>? tags,
    DifficultyLevel? maxDifficulty,
    Duration? maxCookingTime,
    List<String>? ingredients,
    List<String>? excludeIngredients,
  }) {
    try {
      List<Recipe> recipes = HiveService.getAllRecipes();
      
      if (tags != null && tags.isNotEmpty) {
        recipes = recipes.where((recipe) => 
            tags.any((tag) => recipe.tags.contains(tag))).toList();
      }
      
      if (maxDifficulty != null) {
        recipes = recipes.where((recipe) => 
            recipe.difficulty.level <= maxDifficulty.level).toList();
      }
      
      if (maxCookingTime != null) {
        recipes = recipes.where((recipe) => 
            recipe.cookingTime <= maxCookingTime).toList();
      }
      
      if (ingredients != null && ingredients.isNotEmpty) {
        recipes = recipes.where((recipe) {
          return ingredients.every((ingredient) =>
              recipe.ingredients.any((recipeIngredient) =>
                  recipeIngredient.name.toLowerCase().contains(ingredient.toLowerCase())));
        }).toList();
      }
      
      if (excludeIngredients != null && excludeIngredients.isNotEmpty) {
        recipes = recipes.where((recipe) {
          return !excludeIngredients.any((ingredient) =>
              recipe.ingredients.any((recipeIngredient) =>
                  recipeIngredient.name.toLowerCase().contains(ingredient.toLowerCase())));
        }).toList();
      }
      
      return recipes;
    } catch (e) {
      throw StorageException('Failed to filter recipes offline: $e');
    }
  }

  // Cache management for offline support
  Future<void> cacheDataForOffline(String key, Map<String, dynamic> data, {Duration? ttl}) async {
    try {
      await HiveService.saveToCache(key, data, ttl: ttl);
    } catch (e) {
      throw CacheException('Failed to cache data: $e');
    }
  }

  Map<String, dynamic>? getCachedData(String key) {
    try {
      return HiveService.getFromCache(key);
    } catch (e) {
      throw CacheException('Failed to get cached data: $e');
    }
  }

  bool isCacheValid(String key, {Duration? maxAge}) {
    try {
      return HiveService.isCacheValid(key, maxAge: maxAge);
    } catch (e) {
      return false;
    }
  }

  // Offline data management
  Future<void> clearOfflineData() async {
    try {
      await HiveService.clearOfflineData();
    } catch (e) {
      throw StorageException('Failed to clear offline data: $e');
    }
  }

  List<MapEntry<String, Map<String, dynamic>>> getUnsyncedData() {
    try {
      return HiveService.getUnsyncedData();
    } catch (e) {
      throw StorageException('Failed to get unsynced data: $e');
    }
  }

  int getUnsyncedDataCount() {
    try {
      return HiveService.getUnsyncedData().length;
    } catch (e) {
      return 0;
    }
  }

  // Offline-specific recipe operations
  Future<void> toggleFavoriteOffline(String recipeId) async {
    try {
      final recipe = HiveService.getRecipe(recipeId);
      if (recipe != null) {
        final updatedRecipe = recipe.copyWith(isFavorite: !recipe.isFavorite);
        await updateRecipeOffline(updatedRecipe);
      }
    } catch (e) {
      throw StorageException('Failed to toggle favorite offline: $e');
    }
  }

  Future<void> rateRecipeOffline(String recipeId, double rating) async {
    try {
      final recipe = HiveService.getRecipe(recipeId);
      if (recipe != null) {
        final updatedRecipe = recipe.copyWith(rating: rating);
        await updateRecipeOffline(updatedRecipe);
      }
    } catch (e) {
      throw StorageException('Failed to rate recipe offline: $e');
    }
  }

  Future<void> incrementCookCountOffline(String recipeId) async {
    try {
      final recipe = HiveService.getRecipe(recipeId);
      if (recipe != null) {
        final updatedRecipe = recipe.copyWith(cookCount: recipe.cookCount + 1);
        await updateRecipeOffline(updatedRecipe);
      }
    } catch (e) {
      throw StorageException('Failed to increment cook count offline: $e');
    }
  }

  // Offline analytics and insights
  Map<String, dynamic> getOfflineAnalytics() {
    try {
      final recipes = HiveService.getAllRecipes();
      final favorites = HiveService.getFavoriteRecipes();
      
      final cuisineCount = <String, int>{};
      final difficultyCount = <String, int>{};
      var totalCookingTime = Duration.zero;
      var totalCookCount = 0;
      
      for (final recipe in recipes) {
        // Count cuisines (from tags)
        for (final tag in recipe.tags) {
          cuisineCount[tag] = (cuisineCount[tag] ?? 0) + 1;
        }
        
        // Count difficulties
        final difficulty = recipe.difficulty.displayName;
        difficultyCount[difficulty] = (difficultyCount[difficulty] ?? 0) + 1;
        
        // Sum cooking times and cook counts
        totalCookingTime += recipe.cookingTime;
        totalCookCount += recipe.cookCount;
      }
      
      return {
        'totalRecipes': recipes.length,
        'favoriteRecipes': favorites.length,
        'totalCookingSessions': totalCookCount,
        'averageCookingTime': recipes.isNotEmpty 
            ? totalCookingTime.inMinutes / recipes.length 
            : 0,
        'cuisineDistribution': cuisineCount,
        'difficultyDistribution': difficultyCount,
        'offlineDataCount': getUnsyncedDataCount(),
        'cacheStats': HiveService.getDatabaseStats(),
      };
    } catch (e) {
      return {'error': 'Failed to generate offline analytics: $e'};
    }
  }

  // Data export for backup
  Future<Map<String, dynamic>> exportOfflineData() async {
    try {
      final recipes = HiveService.getAllRecipes();
      final userPreferences = HiveService.getUserPreferences('current_user') ?? {};
      final unsyncedData = HiveService.getUnsyncedData();
      
      return {
        'recipes': recipes.map((recipe) => recipe.toJson()).toList(),
        'userPreferences': userPreferences,
        'unsyncedData': unsyncedData.map((entry) => {
          'key': entry.key,
          'data': entry.value,
        }).toList(),
        'exportedAt': DateTime.now().toIso8601String(),
        'version': '1.0',
      };
    } catch (e) {
      throw StorageException('Failed to export offline data: $e');
    }
  }

  // Data import for restore
  Future<void> importOfflineData(Map<String, dynamic> data) async {
    try {
      // Import recipes
      if (data['recipes'] != null) {
        final recipes = (data['recipes'] as List)
            .map((recipeJson) => Recipe.fromJson(recipeJson as Map<String, dynamic>))
            .toList();
        
        for (final recipe in recipes) {
          await HiveService.saveRecipe(recipe);
        }
      }
      
      // Import user preferences
      if (data['userPreferences'] != null) {
        await HiveService.saveUserPreferences('current_user', 
            data['userPreferences'] as Map<String, dynamic>);
      }
      
      // Import unsynced data
      if (data['unsyncedData'] != null) {
        final unsyncedItems = data['unsyncedData'] as List;
        for (final item in unsyncedItems) {
          await HiveService.saveOfflineData(
            item['key'] as String,
            item['data'] as Map<String, dynamic>,
          );
        }
      }
    } catch (e) {
      throw StorageException('Failed to import offline data: $e');
    }
  }

  // Cleanup and maintenance
  Future<void> performMaintenance() async {
    try {
      // Clear expired cache
      await HiveService.clearExpiredCache();
      
      // Compact database
      await HiveService.compactDatabase();
      
      // Clean up old unsynced data (older than 30 days)
      final cutoffDate = DateTime.now().subtract(const Duration(days: 30));
      final unsyncedData = HiveService.getUnsyncedData();
      
      for (final entry in unsyncedData) {
        final timestamp = entry.value['timestamp'] as int?;
        if (timestamp != null) {
          final dataDate = DateTime.fromMillisecondsSinceEpoch(timestamp);
          if (dataDate.isBefore(cutoffDate)) {
            await HiveService.markDataAsSynced(entry.key);
          }
        }
      }
    } catch (e) {
      throw StorageException('Failed to perform maintenance: $e');
    }
  }

  // Disposal
  Future<void> dispose() async {
    await _connectivitySubscription?.cancel();
    await _connectivityController.close();
  }
}

// Riverpod providers for offline service
final offlineServiceProvider = Provider<OfflineService>((ref) {
  return OfflineService.instance;
});

final connectivityProvider = StreamProvider<bool>((ref) {
  final offlineService = ref.read(offlineServiceProvider);
  return offlineService.connectivityStream;
});

final offlineAnalyticsProvider = Provider<Map<String, dynamic>>((ref) {
  final offlineService = ref.read(offlineServiceProvider);
  return offlineService.getOfflineAnalytics();
});

final unsyncedDataCountProvider = Provider<int>((ref) {
  final offlineService = ref.read(offlineServiceProvider);
  return offlineService.getUnsyncedDataCount();
});