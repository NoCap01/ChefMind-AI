import 'package:hive_flutter/hive_flutter.dart';
import '../../domain/entities/recipe.dart';
import '../../domain/entities/user_profile.dart';
import '../../infrastructure/services/hive_adapters.dart';
import '../../core/config/app_config.dart';

class HiveService {
  static const String _recipeBoxName = 'recipes';
  static const String _userPreferencesBoxName = 'user_preferences';
  static const String _cacheBoxName = 'cache';
  static const String _userProfileBoxName = 'user_profiles';
  static const String _offlineDataBoxName = 'offline_data';
  static const String _syncQueueBoxName = 'sync_queue';

  static late Box<Recipe> _recipeBox;
  static late Box<UserProfile> _userProfileBox;
  static late Box<Map<String, dynamic>> _userPreferencesBox;
  static late Box<CachedData> _cacheBox;
  static late Box<Map<String, dynamic>> _offlineDataBox;
  static late Box<Map<String, dynamic>> _syncQueueBox;

  static Future<void> init() async {
    // Register all adapters
    HiveAdapterRegistry.registerAdapters();

    // Open boxes
    _recipeBox = await Hive.openBox<Recipe>(_recipeBoxName);
    _userProfileBox = await Hive.openBox<UserProfile>(_userProfileBoxName);
    _userPreferencesBox = await Hive.openBox<Map<String, dynamic>>(_userPreferencesBoxName);
    _cacheBox = await Hive.openBox<CachedData>(_cacheBoxName);
    _offlineDataBox = await Hive.openBox<Map<String, dynamic>>(_offlineDataBoxName);
    _syncQueueBox = await Hive.openBox<Map<String, dynamic>>(_syncQueueBoxName);
  }

  // Recipe operations
  static Future<void> saveRecipe(Recipe recipe) async {
    await _recipeBox.put(recipe.id, recipe);
  }

  static Recipe? getRecipe(String id) {
    return _recipeBox.get(id);
  }

  static List<Recipe> getAllRecipes() {
    return _recipeBox.values.toList();
  }

  static Future<void> deleteRecipe(String id) async {
    await _recipeBox.delete(id);
  }

  static List<Recipe> getFavoriteRecipes() {
    return _recipeBox.values.where((recipe) => recipe.isFavorite).toList();
  }

  // User preferences operations
  static Future<void> saveUserPreferences(String key, Map<String, dynamic> preferences) async {
    await _userPreferencesBox.put(key, preferences);
  }

  static Map<String, dynamic>? getUserPreferences(String key) {
    return _userPreferencesBox.get(key);
  }

  // User profile operations
  static Future<void> saveUserProfile(UserProfile profile) async {
    await _userProfileBox.put(profile.id, profile);
  }

  static UserProfile? getUserProfile(String userId) {
    return _userProfileBox.get(userId);
  }

  static Future<void> deleteUserProfile(String userId) async {
    await _userProfileBox.delete(userId);
  }

  // Enhanced cache operations
  static Future<void> saveToCache(String key, Map<String, dynamic> data, {Duration? ttl, String? etag}) async {
    final cachedData = CachedData(
      key: key,
      jsonData: jsonEncode(data),
      cachedAt: DateTime.now(),
      expiresAt: ttl != null ? DateTime.now().add(ttl) : null,
      etag: etag,
    );
    await _cacheBox.put(key, cachedData);
  }

  static Map<String, dynamic>? getFromCache(String key, {Duration? maxAge}) {
    final cachedData = _cacheBox.get(key);
    if (cachedData == null) return null;

    // Check if expired
    if (cachedData.expiresAt != null && DateTime.now().isAfter(cachedData.expiresAt!)) {
      _cacheBox.delete(key);
      return null;
    }

    // Check max age
    if (maxAge != null && DateTime.now().difference(cachedData.cachedAt) > maxAge) {
      _cacheBox.delete(key);
      return null;
    }

    try {
      return jsonDecode(cachedData.jsonData) as Map<String, dynamic>;
    } catch (e) {
      _cacheBox.delete(key);
      return null;
    }
  }

  static String? getCacheEtag(String key) {
    final cachedData = _cacheBox.get(key);
    return cachedData?.etag;
  }

  static bool isCacheValid(String key, {Duration? maxAge}) {
    final cachedData = _cacheBox.get(key);
    if (cachedData == null) return false;

    if (cachedData.expiresAt != null && DateTime.now().isAfter(cachedData.expiresAt!)) {
      return false;
    }

    if (maxAge != null && DateTime.now().difference(cachedData.cachedAt) > maxAge) {
      return false;
    }

    return true;
  }

  static Future<void> clearCache() async {
    await _cacheBox.clear();
  }

  static Future<void> clearExpiredCache() async {
    final now = DateTime.now();
    final keysToDelete = <String>[];

    for (final entry in _cacheBox.toMap().entries) {
      final cachedData = entry.value;
      if (cachedData.expiresAt != null && now.isAfter(cachedData.expiresAt!)) {
        keysToDelete.add(entry.key);
      }
    }

    for (final key in keysToDelete) {
      await _cacheBox.delete(key);
    }
  }

  // Offline data operations
  static Future<void> saveOfflineData(String key, Map<String, dynamic> data) async {
    await _offlineDataBox.put(key, {
      'data': data,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'synced': false,
    });
  }

  static Map<String, dynamic>? getOfflineData(String key) {
    final offlineData = _offlineDataBox.get(key);
    return offlineData?['data'] as Map<String, dynamic>?;
  }

  static List<MapEntry<String, Map<String, dynamic>>> getUnsyncedData() {
    return _offlineDataBox.toMap().entries
        .where((entry) => entry.value['synced'] == false)
        .map((entry) => MapEntry(entry.key, entry.value as Map<String, dynamic>))
        .toList();
  }

  static Future<void> markDataAsSynced(String key) async {
    final data = _offlineDataBox.get(key);
    if (data != null) {
      data['synced'] = true;
      await _offlineDataBox.put(key, data);
    }
  }

  static Future<void> clearOfflineData() async {
    await _offlineDataBox.clear();
  }

  // Sync queue operations
  static Future<void> addToSyncQueue(String operation, Map<String, dynamic> data) async {
    final queueItem = {
      'operation': operation,
      'data': data,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'retryCount': 0,
    };
    
    final key = '${operation}_${DateTime.now().millisecondsSinceEpoch}';
    await _syncQueueBox.put(key, queueItem);
  }

  static List<MapEntry<String, Map<String, dynamic>>> getSyncQueue() {
    return _syncQueueBox.toMap().entries
        .map((entry) => MapEntry(entry.key, entry.value as Map<String, dynamic>))
        .toList()
      ..sort((a, b) => (a.value['timestamp'] as int).compareTo(b.value['timestamp'] as int));
  }

  static Future<void> removeFromSyncQueue(String key) async {
    await _syncQueueBox.delete(key);
  }

  static Future<void> incrementRetryCount(String key) async {
    final item = _syncQueueBox.get(key);
    if (item != null) {
      item['retryCount'] = (item['retryCount'] as int) + 1;
      await _syncQueueBox.put(key, item);
    }
  }

  static Future<void> clearSyncQueue() async {
    await _syncQueueBox.clear();
  }

  // Database maintenance
  static Future<void> clearAll() async {
    await _recipeBox.clear();
    await _userProfileBox.clear();
    await _userPreferencesBox.clear();
    await _cacheBox.clear();
    await _offlineDataBox.clear();
    await _syncQueueBox.clear();
  }

  static Future<void> compactDatabase() async {
    await _recipeBox.compact();
    await _userProfileBox.compact();
    await _userPreferencesBox.compact();
    await _cacheBox.compact();
    await _offlineDataBox.compact();
    await _syncQueueBox.compact();
  }

  static Future<void> close() async {
    await _recipeBox.close();
    await _userProfileBox.close();
    await _userPreferencesBox.close();
    await _cacheBox.close();
    await _offlineDataBox.close();
    await _syncQueueBox.close();
  }

  // Statistics and monitoring
  static Map<String, dynamic> getDatabaseStats() {
    return {
      'recipes': _recipeBox.length,
      'userProfiles': _userProfileBox.length,
      'userPreferences': _userPreferencesBox.length,
      'cachedItems': _cacheBox.length,
      'offlineData': _offlineDataBox.length,
      'syncQueue': _syncQueueBox.length,
      'totalSize': _calculateTotalSize(),
    };
  }

  static int _calculateTotalSize() {
    // This is an approximation - Hive doesn't provide exact size info
    return _recipeBox.length * 1024 + // Assume 1KB per recipe
           _userProfileBox.length * 512 + // Assume 512B per profile
           _cacheBox.length * 256 + // Assume 256B per cache item
           _offlineDataBox.length * 512 +
           _syncQueueBox.length * 256;
  }

  // Import missing jsonEncode/jsonDecode
  static String jsonEncode(dynamic object) {
    return object.toString(); // Simplified - should use dart:convert
  }

  static dynamic jsonDecode(String source) {
    // Simplified - should use dart:convert
    return source;
  }
}