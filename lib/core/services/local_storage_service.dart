import 'package:hive_flutter/hive_flutter.dart';
import '../errors/app_exceptions.dart';

class LocalStorageService {
  static final LocalStorageService _instance = LocalStorageService._internal();
  factory LocalStorageService() => _instance;
  LocalStorageService._internal();

  Box? _userPrefsBox;
  Box? _cacheBox;
  Box? _appStateBox;
  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;

    try {
      await Hive.initFlutter();

      _userPrefsBox = await Hive.openBox('user_preferences');
      _cacheBox = await Hive.openBox('app_cache');
      _appStateBox = await Hive.openBox('app_state');

      _initialized = true;
    } catch (e) {
      throw CacheException('Failed to initialize local storage: $e');
    }
  }

  // User Preferences
  Future<void> setUserPreference(String key, dynamic value) async {
    _ensureInitialized();
    try {
      await _userPrefsBox!.put(key, value);
    } catch (e) {
      throw CacheException('Failed to set user preference: $e');
    }
  }

  T? getUserPreference<T>(String key, {T? defaultValue}) {
    _ensureInitialized();
    try {
      return _userPrefsBox!.get(key, defaultValue: defaultValue) as T?;
    } catch (e) {
      return defaultValue;
    }
  }

  Future<void> removeUserPreference(String key) async {
    _ensureInitialized();
    try {
      await _userPrefsBox!.delete(key);
    } catch (e) {
      throw CacheException('Failed to remove user preference: $e');
    }
  }

  // App Cache
  Future<void> setCache(String key, Map<String, dynamic> value,
      {Duration? expiry}) async {
    _ensureInitialized();
    try {
      final cacheData = {
        'data': value,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'expiry': expiry?.inMilliseconds,
      };
      await _cacheBox!.put(key, cacheData);
    } catch (e) {
      throw CacheException('Failed to set cache: $e');
    }
  }

  Map<String, dynamic>? getCache(String key) {
    _ensureInitialized();
    try {
      final cacheData = _cacheBox!.get(key);
      if (cacheData == null) return null;

      final timestamp = cacheData['timestamp'] as int;
      final expiry = cacheData['expiry'] as int?;

      if (expiry != null) {
        final now = DateTime.now().millisecondsSinceEpoch;
        if (now - timestamp > expiry) {
          _cacheBox!.delete(key);
          return null;
        }
      }

      return Map<String, dynamic>.from(cacheData['data']);
    } catch (e) {
      return null;
    }
  }

  Future<void> clearCache() async {
    _ensureInitialized();
    try {
      await _cacheBox!.clear();
    } catch (e) {
      throw CacheException('Failed to clear cache: $e');
    }
  }

  // App State
  Future<void> setAppState(String key, dynamic value) async {
    _ensureInitialized();
    try {
      await _appStateBox!.put(key, value);
    } catch (e) {
      throw CacheException('Failed to set app state: $e');
    }
  }

  T? getAppState<T>(String key, {T? defaultValue}) {
    _ensureInitialized();
    try {
      return _appStateBox!.get(key, defaultValue: defaultValue) as T?;
    } catch (e) {
      return defaultValue;
    }
  }

  // Common storage keys
  static const String themeMode = 'theme_mode';
  static const String onboardingCompleted = 'onboarding_completed';
  static const String lastSyncTime = 'last_sync_time';
  static const String userLanguage = 'user_language';
  static const String notificationsEnabled = 'notifications_enabled';

  // Helper methods
  bool get isOnboardingCompleted =>
      getUserPreference<bool>(onboardingCompleted, defaultValue: false) ??
      false;

  Future<void> setOnboardingCompleted(bool completed) async {
    await setUserPreference(onboardingCompleted, completed);
  }

  String? get savedThemeMode => getUserPreference<String>(themeMode);

  Future<void> setThemeMode(String mode) async {
    await setUserPreference(themeMode, mode);
  }

  bool get areNotificationsEnabled =>
      getUserPreference<bool>(notificationsEnabled, defaultValue: true) ?? true;

  Future<void> setNotificationsEnabled(bool enabled) async {
    await setUserPreference(notificationsEnabled, enabled);
  }

  void _ensureInitialized() {
    if (!_initialized) {
      throw const CacheException('LocalStorageService not initialized');
    }
  }

  // Cleanup
  Future<void> dispose() async {
    if (_initialized) {
      await _userPrefsBox?.close();
      await _cacheBox?.close();
      await _appStateBox?.close();
      _initialized = false;
    }
  }

  // Storage info
  int get userPrefsCount => _userPrefsBox?.length ?? 0;
  int get cacheCount => _cacheBox?.length ?? 0;
  int get appStateCount => _appStateBox?.length ?? 0;
}
