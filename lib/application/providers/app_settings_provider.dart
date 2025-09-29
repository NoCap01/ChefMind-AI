import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/app_settings_service.dart';
import 'auth_provider.dart';

// App settings service provider
final appSettingsServiceProvider = Provider<AppSettingsService>((ref) {
  return AppSettingsService();
});

// App settings provider
final appSettingsProvider = FutureProvider<AppSettings>((ref) async {
  final authState = ref.watch(authStateProvider);
  final settingsService = ref.watch(appSettingsServiceProvider);
  
  if (authState is AuthStateAuthenticated) {
    try {
      await settingsService.initialize();
      return await settingsService.getAppSettings(authState.user.userId);
    } catch (e) {
      return AppSettings.defaultSettings();
    }
  }
  
  return AppSettings.defaultSettings();
});

// App settings notifier for updates
final appSettingsNotifierProvider = StateNotifierProvider<AppSettingsNotifier, AsyncValue<AppSettings>>((ref) {
  final settingsService = ref.watch(appSettingsServiceProvider);
  return AppSettingsNotifier(settingsService);
});

class AppSettingsNotifier extends StateNotifier<AsyncValue<AppSettings>> {
  final AppSettingsService _settingsService;

  AppSettingsNotifier(this._settingsService) : super(AsyncValue.data(AppSettings.defaultSettings()));

  Future<void> initialize() async {
    try {
      await _settingsService.initialize();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> loadSettings(String userId) async {
    state = const AsyncValue.loading();
    
    try {
      final settings = await _settingsService.getAppSettings(userId);
      state = AsyncValue.data(settings);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> updateSettings(String userId, AppSettings settings) async {
    state = const AsyncValue.loading();
    
    try {
      await _settingsService.saveAppSettings(userId, settings);
      state = AsyncValue.data(settings);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> updateThemeMode(String userId, ThemeMode themeMode) async {
    try {
      await _settingsService.updateThemeMode(userId, themeMode);
      final currentSettings = state.value ?? AppSettings.defaultSettings();
      final updatedSettings = currentSettings.copyWith(themeMode: themeMode);
      state = AsyncValue.data(updatedSettings);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> updateNotificationSettings(String userId, NotificationSettings notificationSettings) async {
    try {
      await _settingsService.updateNotificationSettings(userId, notificationSettings);
      final currentSettings = state.value ?? AppSettings.defaultSettings();
      final updatedSettings = currentSettings.copyWith(notificationSettings: notificationSettings);
      state = AsyncValue.data(updatedSettings);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> updatePrivacySettings(String userId, PrivacySettings privacySettings) async {
    try {
      await _settingsService.updatePrivacySettings(userId, privacySettings);
      final currentSettings = state.value ?? AppSettings.defaultSettings();
      final updatedSettings = currentSettings.copyWith(privacySettings: privacySettings);
      state = AsyncValue.data(updatedSettings);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> updateAccessibilitySettings(String userId, AccessibilitySettings accessibilitySettings) async {
    try {
      await _settingsService.updateAccessibilitySettings(userId, accessibilitySettings);
      final currentSettings = state.value ?? AppSettings.defaultSettings();
      final updatedSettings = currentSettings.copyWith(accessibilitySettings: accessibilitySettings);
      state = AsyncValue.data(updatedSettings);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<Map<String, dynamic>?> exportUserData(String userId) async {
    try {
      return await _settingsService.exportUserData(userId);
    } catch (e) {
      return null;
    }
  }

  Future<bool> importUserData(String userId, Map<String, dynamic> data) async {
    try {
      final success = await _settingsService.importUserData(userId, data);
      if (success) {
        // Reload settings after import
        await loadSettings(userId);
      }
      return success;
    } catch (e) {
      return false;
    }
  }

  Future<void> clearAllUserData(String userId) async {
    try {
      await _settingsService.clearAllUserData(userId);
      state = AsyncValue.data(AppSettings.defaultSettings());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Map<String, String> getAppInfo() {
    return _settingsService.getAppInfo();
  }
}

// Theme mode provider for easy access
final themeModeProvider = Provider<ThemeMode>((ref) {
  final settingsAsync = ref.watch(appSettingsProvider);
  return settingsAsync.when(
    data: (settings) => settings.themeMode,
    loading: () => ThemeMode.system,
    error: (_, __) => ThemeMode.system,
  );
});

// Notification settings provider
final notificationSettingsProvider = Provider<NotificationSettings>((ref) {
  final settingsAsync = ref.watch(appSettingsProvider);
  return settingsAsync.when(
    data: (settings) => settings.notificationSettings,
    loading: () => const NotificationSettings(),
    error: (_, __) => const NotificationSettings(),
  );
});

// Privacy settings provider
final privacySettingsProvider = Provider<PrivacySettings>((ref) {
  final settingsAsync = ref.watch(appSettingsProvider);
  return settingsAsync.when(
    data: (settings) => settings.privacySettings,
    loading: () => const PrivacySettings(),
    error: (_, __) => const PrivacySettings(),
  );
});

// Accessibility settings provider
final accessibilitySettingsProvider = Provider<AccessibilitySettings>((ref) {
  final settingsAsync = ref.watch(appSettingsProvider);
  return settingsAsync.when(
    data: (settings) => settings.accessibilitySettings,
    loading: () => const AccessibilitySettings(),
    error: (_, __) => const AccessibilitySettings(),
  );
});