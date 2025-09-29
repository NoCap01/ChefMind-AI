import 'package:hive_flutter/hive_flutter.dart';
import '../../domain/entities/recipe.dart';
import '../../domain/entities/user_profile.dart';
import '../../core/errors/app_exceptions.dart';

class HiveStorageService {
  static final HiveStorageService _instance = HiveStorageService._internal();
  factory HiveStorageService() => _instance;
  HiveStorageService._internal();

  Box? _recipesBox;
  Box? _userBox;
  Box? _preferencesBox;
  Box? _cacheBox;
  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;

    try {
      await Hive.initFlutter();

      _recipesBox = await Hive.openBox('recipes');
      _userBox = await Hive.openBox('user');
      _preferencesBox = await Hive.openBox('preferences');
      _cacheBox = await Hive.openBox('cache');

      _initialized = true;
    } catch (e) {
      throw const CacheException('Failed to initialize local storage: \$e');
    }
  }

  // Recipe operations
  Future<void> saveRecipe(Recipe recipe) async {
    _ensureInitialized();
    try {
      await _recipesBox!.put(recipe.id, recipe.toJson());
    } catch (e) {
      throw const CacheException('Failed to save recipe: \$e');
    }
  }

  Recipe? getRecipe(String recipeId) {
    _ensureInitialized();
    try {
      final data = _recipesBox!.get(recipeId);
      if (data != null) {
        return Recipe.fromJson(Map<String, dynamic>.from(data));
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  List<Recipe> getAllRecipes() {
    _ensureInitialized();
    try {
      return _recipesBox!.values
          .map((data) => Recipe.fromJson(Map<String, dynamic>.from(data)))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> deleteRecipe(String recipeId) async {
    _ensureInitialized();
    try {
      await _recipesBox!.delete(recipeId);
    } catch (e) {
      throw const CacheException('Failed to delete recipe: \$e');
    }
  }

  // User operations
  Future<void> saveUserProfile(UserProfile profile) async {
    _ensureInitialized();
    try {
      await _userBox!.put('profile', profile.toJson());
    } catch (e) {
      throw const CacheException('Failed to save user profile: \$e');
    }
  }

  UserProfile? getUserProfile() {
    _ensureInitialized();
    try {
      final data = _userBox!.get('profile');
      if (data != null) {
        return UserProfile.fromJson(Map<String, dynamic>.from(data));
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<void> deleteUserProfile() async {
    _ensureInitialized();
    try {
      await _userBox!.delete('profile');
    } catch (e) {
      throw const CacheException('Failed to delete user profile: \$e');
    }
  }

  // Preferences operations
  Future<void> savePreference(String key, dynamic value) async {
    _ensureInitialized();
    try {
      await _preferencesBox!.put(key, value);
    } catch (e) {
      throw const CacheException('Failed to save preference: \$e');
    }
  }

  T? getPreference<T>(String key) {
    _ensureInitialized();
    try {
      return _preferencesBox!.get(key) as T?;
    } catch (e) {
      return null;
    }
  }

  // Cache operations
  Future<void> cacheData(String key, Map<String, dynamic> data,
      {Duration? expiry}) async {
    _ensureInitialized();
    try {
      final cacheItem = {
        'data': data,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'expiry': expiry?.inMilliseconds,
      };
      await _cacheBox!.put(key, cacheItem);
    } catch (e) {
      throw const CacheException('Failed to cache data: \$e');
    }
  }

  Map<String, dynamic>? getCachedData(String key) {
    _ensureInitialized();
    try {
      final cacheItem = _cacheBox!.get(key);
      if (cacheItem == null) return null;

      final timestamp = cacheItem['timestamp'] as int;
      final expiry = cacheItem['expiry'] as int?;

      if (expiry != null) {
        final now = DateTime.now().millisecondsSinceEpoch;
        if (now - timestamp > expiry) {
          _cacheBox!.delete(key);
          return null;
        }
      }

      return Map<String, dynamic>.from(cacheItem['data']);
    } catch (e) {
      return null;
    }
  }

  // Utility methods
  Future<void> clearAllData() async {
    _ensureInitialized();
    try {
      await _recipesBox!.clear();
      await _userBox!.clear();
      await _preferencesBox!.clear();
      await _cacheBox!.clear();
    } catch (e) {
      throw const CacheException('Failed to clear all data: \$e');
    }
  }

  Future<void> clearExpiredCache() async {
    _ensureInitialized();
    try {
      final now = DateTime.now().millisecondsSinceEpoch;
      final keysToDelete = <String>[];

      for (final key in _cacheBox!.keys) {
        final cacheItem = _cacheBox!.get(key);
        if (cacheItem != null) {
          final timestamp = cacheItem['timestamp'] as int;
          final expiry = cacheItem['expiry'] as int?;

          if (expiry != null && now - timestamp > expiry) {
            keysToDelete.add(key.toString());
          }
        }
      }

      for (final key in keysToDelete) {
        await _cacheBox!.delete(key);
      }
    } catch (e) {
      throw const CacheException('Failed to clear expired cache: \$e');
    }
  }

  void _ensureInitialized() {
    if (!_initialized) {
      throw const CacheException('HiveStorageService not initialized');
    }
  }

  int get cacheSize => _cacheBox?.length ?? 0;
  int get recipesCount => _recipesBox?.length ?? 0;
}
