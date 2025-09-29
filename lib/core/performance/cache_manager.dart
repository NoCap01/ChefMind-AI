import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Comprehensive cache manager for app data
class CacheManager {
  static CacheManager? _instance;
  static CacheManager get instance => _instance ??= CacheManager._();
  
  CacheManager._();

  SharedPreferences? _prefs;
  final Map<String, CacheEntry> _memoryCache = {};
  final Map<String, Timer> _expirationTimers = {};

  static const Duration _defaultTtl = Duration(hours: 1);
  static const int _maxMemoryCacheSize = 100;

  /// Initialize the cache manager
  Future<void> initialize() async {
    _prefs ??= await SharedPreferences.getInstance();
    _cleanupExpiredEntries();
  }

  /// Store data in cache with TTL
  Future<void> set<T>(
    String key,
    T data, {
    Duration? ttl,
    bool persistToDisk = false,
  }) async {
    await initialize();
    
    final entry = CacheEntry<T>(
      data: data,
      timestamp: DateTime.now(),
      ttl: ttl ?? _defaultTtl,
    );

    // Store in memory cache
    _memoryCache[key] = entry;
    _setExpirationTimer(key, entry.ttl);

    // Optionally persist to disk
    if (persistToDisk && _prefs != null) {
      try {
        final serialized = _serializeData(data);
        if (serialized != null) {
          await _prefs!.setString(key, serialized);
          await _prefs!.setInt('${key}_timestamp', entry.timestamp.millisecondsSinceEpoch);
          await _prefs!.setInt('${key}_ttl', entry.ttl.inMilliseconds);
        }
      } catch (e) {
        debugPrint('Failed to persist cache entry: $e');
      }
    }

    // Cleanup memory cache if it gets too large
    if (_memoryCache.length > _maxMemoryCacheSize) {
      _cleanupOldestEntries();
    }
  }

  /// Get data from cache
  Future<T?> get<T>(String key) async {
    await initialize();

    // Check memory cache first
    final memoryEntry = _memoryCache[key];
    if (memoryEntry != null && !memoryEntry.isExpired) {
      return memoryEntry.data as T?;
    }

    // Check disk cache
    if (_prefs != null) {
      try {
        final serialized = _prefs!.getString(key);
        final timestamp = _prefs!.getInt('${key}_timestamp');
        final ttlMs = _prefs!.getInt('${key}_ttl');

        if (serialized != null && timestamp != null && ttlMs != null) {
          final entry = CacheEntry<String>(
            data: serialized,
            timestamp: DateTime.fromMillisecondsSinceEpoch(timestamp),
            ttl: Duration(milliseconds: ttlMs),
          );

          if (!entry.isExpired) {
            final data = _deserializeData<T>(serialized);
            if (data != null) {
              // Store back in memory cache
              _memoryCache[key] = CacheEntry<T>(
                data: data,
                timestamp: entry.timestamp,
                ttl: entry.ttl,
              );
              return data;
            }
          } else {
            // Remove expired disk entry
            await remove(key);
          }
        }
      } catch (e) {
        debugPrint('Failed to read cache entry: $e');
      }
    }

    return null;
  }

  /// Check if key exists and is not expired
  Future<bool> has(String key) async {
    final data = await get(key);
    return data != null;
  }

  /// Remove specific cache entry
  Future<void> remove(String key) async {
    await initialize();

    _memoryCache.remove(key);
    _expirationTimers[key]?.cancel();
    _expirationTimers.remove(key);

    if (_prefs != null) {
      await _prefs!.remove(key);
      await _prefs!.remove('${key}_timestamp');
      await _prefs!.remove('${key}_ttl');
    }
  }

  /// Clear all cache entries
  Future<void> clear() async {
    await initialize();

    _memoryCache.clear();
    for (final timer in _expirationTimers.values) {
      timer.cancel();
    }
    _expirationTimers.clear();

    if (_prefs != null) {
      final keys = _prefs!.getKeys().where((key) => 
        !key.endsWith('_timestamp') && !key.endsWith('_ttl')
      ).toList();
      
      for (final key in keys) {
        await _prefs!.remove(key);
        await _prefs!.remove('${key}_timestamp');
        await _prefs!.remove('${key}_ttl');
      }
    }
  }

  /// Get cache statistics
  CacheStats getStats() {
    final memorySize = _memoryCache.length;
    final expiredCount = _memoryCache.values.where((entry) => entry.isExpired).length;
    
    return CacheStats(
      memoryEntries: memorySize,
      expiredEntries: expiredCount,
      activeTimers: _expirationTimers.length,
    );
  }

  /// Cache with automatic refresh
  Future<T> getOrSet<T>(
    String key,
    Future<T> Function() fetchFunction, {
    Duration? ttl,
    bool persistToDisk = false,
    bool forceRefresh = false,
  }) async {
    if (!forceRefresh) {
      final cached = await get<T>(key);
      if (cached != null) {
        return cached;
      }
    }

    final data = await fetchFunction();
    await set(key, data, ttl: ttl, persistToDisk: persistToDisk);
    return data;
  }

  /// Batch operations
  Future<void> setMultiple<T>(
    Map<String, T> entries, {
    Duration? ttl,
    bool persistToDisk = false,
  }) async {
    for (final entry in entries.entries) {
      await set(entry.key, entry.value, ttl: ttl, persistToDisk: persistToDisk);
    }
  }

  Future<Map<String, T?>> getMultiple<T>(List<String> keys) async {
    final result = <String, T?>{};
    for (final key in keys) {
      result[key] = await get<T>(key);
    }
    return result;
  }

  /// Private helper methods
  void _setExpirationTimer(String key, Duration ttl) {
    _expirationTimers[key]?.cancel();
    _expirationTimers[key] = Timer(ttl, () {
      _memoryCache.remove(key);
      _expirationTimers.remove(key);
    });
  }

  void _cleanupExpiredEntries() {
    final expiredKeys = _memoryCache.entries
        .where((entry) => entry.value.isExpired)
        .map((entry) => entry.key)
        .toList();

    for (final key in expiredKeys) {
      _memoryCache.remove(key);
      _expirationTimers[key]?.cancel();
      _expirationTimers.remove(key);
    }
  }

  void _cleanupOldestEntries() {
    final sortedEntries = _memoryCache.entries.toList()
      ..sort((a, b) => a.value.timestamp.compareTo(b.value.timestamp));

    final entriesToRemove = sortedEntries.take(_memoryCache.length - _maxMemoryCacheSize);
    for (final entry in entriesToRemove) {
      _memoryCache.remove(entry.key);
      _expirationTimers[entry.key]?.cancel();
      _expirationTimers.remove(entry.key);
    }
  }

  String? _serializeData<T>(T data) {
    try {
      if (data is String) return data;
      if (data is num || data is bool) return data.toString();
      if (data is Map || data is List) return jsonEncode(data);
      // For complex objects, you might want to implement custom serialization
      return jsonEncode(data);
    } catch (e) {
      debugPrint('Failed to serialize data: $e');
      return null;
    }
  }

  T? _deserializeData<T>(String serialized) {
    try {
      if (T == String) return serialized as T;
      if (T == int) return int.parse(serialized) as T;
      if (T == double) return double.parse(serialized) as T;
      if (T == bool) return (serialized.toLowerCase() == 'true') as T;
      
      final decoded = jsonDecode(serialized);
      return decoded as T;
    } catch (e) {
      debugPrint('Failed to deserialize data: $e');
      return null;
    }
  }
}

/// Cache entry with expiration
class CacheEntry<T> {
  final T data;
  final DateTime timestamp;
  final Duration ttl;

  CacheEntry({
    required this.data,
    required this.timestamp,
    required this.ttl,
  });

  bool get isExpired => DateTime.now().isAfter(timestamp.add(ttl));
}

/// Cache statistics
class CacheStats {
  final int memoryEntries;
  final int expiredEntries;
  final int activeTimers;

  CacheStats({
    required this.memoryEntries,
    required this.expiredEntries,
    required this.activeTimers,
  });

  @override
  String toString() {
    return 'CacheStats(memory: $memoryEntries, expired: $expiredEntries, timers: $activeTimers)';
  }
}

/// Cache keys constants
class CacheKeys {
  static const String recipes = 'recipes';
  static const String favoriteRecipes = 'favorite_recipes';
  static const String recipeStatistics = 'recipe_statistics';
  static const String userProfile = 'user_profile';
  static const String pantryItems = 'pantry_items';
  static const String shoppingList = 'shopping_list';
  static const String mealPlans = 'meal_plans';
  static const String ingredientSuggestions = 'ingredient_suggestions';
  
  // API response caches
  static const String openaiResponse = 'openai_response';
  static const String huggingfaceResponse = 'huggingface_response';
  
  // Image caches
  static const String recipeImages = 'recipe_images';
  
  // Search caches
  static String recipeSearch(String query) => 'recipe_search_$query';
  static String recipeFilter(String filterHash) => 'recipe_filter_$filterHash';
}