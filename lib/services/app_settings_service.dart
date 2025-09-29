import '../infrastructure/storage/hive_user_profile_storage.dart';
import '../core/errors/app_exceptions.dart';

/// Service for managing app settings and configuration
class AppSettingsService {
  final HiveUserProfileStorage _storage;

  AppSettingsService({HiveUserProfileStorage? storage})
      : _storage = storage ?? HiveUserProfileStorage();

  /// Initialize the service
  Future<void> initialize() async {
    await _storage.initialize();
  }

  /// Get app settings for a user
  Future<AppSettings> getAppSettings(String userId) async {
    try {
      final settings = await _storage.getUserSettings(userId);
      return AppSettings.fromJson(settings);
    } catch (e) {
      // Return default settings if none exist
      return AppSettings.defaultSettings();
    }
  }

  /// Save app settings for a user
  Future<void> saveAppSettings(String userId, AppSettings settings) async {
    try {
      await _storage.saveUserSettings(userId, settings.toJson());
    } catch (e) {
      throw ServiceException('Failed to save app settings: $e');
    }
  }

  /// Update theme mode
  Future<void> updateThemeMode(String userId, ThemeMode themeMode) async {
    try {
      final settings = await getAppSettings(userId);
      final updatedSettings = settings.copyWith(themeMode: themeMode);
      await saveAppSettings(userId, updatedSettings);
    } catch (e) {
      throw ServiceException('Failed to update theme mode: $e');
    }
  }

  /// Update notification settings
  Future<void> updateNotificationSettings(
      String userId, NotificationSettings notificationSettings) async {
    try {
      final settings = await getAppSettings(userId);
      final updatedSettings =
          settings.copyWith(notificationSettings: notificationSettings);
      await saveAppSettings(userId, updatedSettings);
    } catch (e) {
      throw ServiceException('Failed to update notification settings: $e');
    }
  }

  /// Update privacy settings
  Future<void> updatePrivacySettings(
      String userId, PrivacySettings privacySettings) async {
    try {
      final settings = await getAppSettings(userId);
      final updatedSettings =
          settings.copyWith(privacySettings: privacySettings);
      await saveAppSettings(userId, updatedSettings);
    } catch (e) {
      throw ServiceException('Failed to update privacy settings: $e');
    }
  }

  /// Update accessibility settings
  Future<void> updateAccessibilitySettings(
      String userId, AccessibilitySettings accessibilitySettings) async {
    try {
      final settings = await getAppSettings(userId);
      final updatedSettings =
          settings.copyWith(accessibilitySettings: accessibilitySettings);
      await saveAppSettings(userId, updatedSettings);
    } catch (e) {
      throw ServiceException('Failed to update accessibility settings: $e');
    }
  }

  /// Export user data
  Future<Map<String, dynamic>> exportUserData(String userId) async {
    try {
      final profile = await _storage.getUserProfile(userId);
      final settings = await _storage.getUserSettings(userId);
      final statistics = await _storage.getUserStatistics(userId);

      return {
        'profile': profile?.toJson(),
        'settings': settings,
        'statistics': statistics,
        'exportedAt': DateTime.now().toIso8601String(),
        'version': '1.0',
      };
    } catch (e) {
      throw ServiceException('Failed to export user data: $e');
    }
  }

  /// Import user data
  Future<bool> importUserData(String userId, Map<String, dynamic> data) async {
    try {
      // Validate data format
      if (!_validateImportData(data)) {
        throw const ServiceException('Invalid import data format');
      }

      // Import profile if present
      if (data['profile'] != null) {
        await _storage.importUserProfile(data['profile']);
      }

      // Import settings if present
      if (data['settings'] != null) {
        await _storage.saveUserSettings(userId, data['settings']);
      }

      // Import statistics if present
      if (data['statistics'] != null) {
        await _storage.saveUserStatistics(userId, data['statistics']);
      }

      return true;
    } catch (e) {
      throw ServiceException('Failed to import user data: $e');
    }
  }

  /// Clear all user data
  Future<void> clearAllUserData(String userId) async {
    try {
      await _storage.deleteUserProfile(userId);
    } catch (e) {
      throw ServiceException('Failed to clear user data: $e');
    }
  }

  /// Get app version and build info
  Map<String, String> getAppInfo() {
    return {
      'version': '1.0.0',
      'buildNumber': '1',
      'buildDate': '2024-01-01',
      'platform': 'Flutter',
    };
  }

  bool _validateImportData(Map<String, dynamic> data) {
    // Basic validation of import data structure
    return data.containsKey('version') &&
        data.containsKey('exportedAt') &&
        (data.containsKey('profile') ||
            data.containsKey('settings') ||
            data.containsKey('statistics'));
  }

  /// Dispose resources
  Future<void> dispose() async {
    await _storage.dispose();
  }
}

// App Settings Data Classes

class AppSettings {
  final ThemeMode themeMode;
  final String language;
  final NotificationSettings notificationSettings;
  final PrivacySettings privacySettings;
  final AccessibilitySettings accessibilitySettings;
  final Map<String, dynamic> customSettings;

  const AppSettings({
    required this.themeMode,
    required this.language,
    required this.notificationSettings,
    required this.privacySettings,
    required this.accessibilitySettings,
    this.customSettings = const {},
  });

  factory AppSettings.defaultSettings() {
    return const AppSettings(
      themeMode: ThemeMode.system,
      language: 'en',
      notificationSettings: NotificationSettings(),
      privacySettings: PrivacySettings(),
      accessibilitySettings: AccessibilitySettings(),
    );
  }

  AppSettings copyWith({
    ThemeMode? themeMode,
    String? language,
    NotificationSettings? notificationSettings,
    PrivacySettings? privacySettings,
    AccessibilitySettings? accessibilitySettings,
    Map<String, dynamic>? customSettings,
  }) {
    return AppSettings(
      themeMode: themeMode ?? this.themeMode,
      language: language ?? this.language,
      notificationSettings: notificationSettings ?? this.notificationSettings,
      privacySettings: privacySettings ?? this.privacySettings,
      accessibilitySettings:
          accessibilitySettings ?? this.accessibilitySettings,
      customSettings: customSettings ?? this.customSettings,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'themeMode': themeMode.name,
      'language': language,
      'notificationSettings': notificationSettings.toJson(),
      'privacySettings': privacySettings.toJson(),
      'accessibilitySettings': accessibilitySettings.toJson(),
      'customSettings': customSettings,
    };
  }

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      themeMode: ThemeMode.values.firstWhere(
        (e) => e.name == json['themeMode'],
        orElse: () => ThemeMode.system,
      ),
      language: json['language'] ?? 'en',
      notificationSettings: json['notificationSettings'] != null
          ? NotificationSettings.fromJson(json['notificationSettings'])
          : const NotificationSettings(),
      privacySettings: json['privacySettings'] != null
          ? PrivacySettings.fromJson(json['privacySettings'])
          : const PrivacySettings(),
      accessibilitySettings: json['accessibilitySettings'] != null
          ? AccessibilitySettings.fromJson(json['accessibilitySettings'])
          : const AccessibilitySettings(),
      customSettings: Map<String, dynamic>.from(json['customSettings'] ?? {}),
    );
  }
}

class NotificationSettings {
  final bool enablePushNotifications;
  final bool enableEmailNotifications;
  final bool enableRecipeReminders;
  final bool enableMealPlanNotifications;
  final bool enableShoppingListReminders;
  final bool enableAchievementNotifications;
  final String reminderTime;

  const NotificationSettings({
    this.enablePushNotifications = true,
    this.enableEmailNotifications = false,
    this.enableRecipeReminders = true,
    this.enableMealPlanNotifications = true,
    this.enableShoppingListReminders = true,
    this.enableAchievementNotifications = true,
    this.reminderTime = '18:00',
  });

  NotificationSettings copyWith({
    bool? enablePushNotifications,
    bool? enableEmailNotifications,
    bool? enableRecipeReminders,
    bool? enableMealPlanNotifications,
    bool? enableShoppingListReminders,
    bool? enableAchievementNotifications,
    String? reminderTime,
  }) {
    return NotificationSettings(
      enablePushNotifications:
          enablePushNotifications ?? this.enablePushNotifications,
      enableEmailNotifications:
          enableEmailNotifications ?? this.enableEmailNotifications,
      enableRecipeReminders:
          enableRecipeReminders ?? this.enableRecipeReminders,
      enableMealPlanNotifications:
          enableMealPlanNotifications ?? this.enableMealPlanNotifications,
      enableShoppingListReminders:
          enableShoppingListReminders ?? this.enableShoppingListReminders,
      enableAchievementNotifications:
          enableAchievementNotifications ?? this.enableAchievementNotifications,
      reminderTime: reminderTime ?? this.reminderTime,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'enablePushNotifications': enablePushNotifications,
      'enableEmailNotifications': enableEmailNotifications,
      'enableRecipeReminders': enableRecipeReminders,
      'enableMealPlanNotifications': enableMealPlanNotifications,
      'enableShoppingListReminders': enableShoppingListReminders,
      'enableAchievementNotifications': enableAchievementNotifications,
      'reminderTime': reminderTime,
    };
  }

  factory NotificationSettings.fromJson(Map<String, dynamic> json) {
    return NotificationSettings(
      enablePushNotifications: json['enablePushNotifications'] ?? true,
      enableEmailNotifications: json['enableEmailNotifications'] ?? false,
      enableRecipeReminders: json['enableRecipeReminders'] ?? true,
      enableMealPlanNotifications: json['enableMealPlanNotifications'] ?? true,
      enableShoppingListReminders: json['enableShoppingListReminders'] ?? true,
      enableAchievementNotifications:
          json['enableAchievementNotifications'] ?? true,
      reminderTime: json['reminderTime'] ?? '18:00',
    );
  }
}

class PrivacySettings {
  final bool shareUsageData;
  final bool shareRecipeData;
  final bool enableAnalytics;
  final bool enableCrashReporting;
  final bool allowPersonalization;

  const PrivacySettings({
    this.shareUsageData = false,
    this.shareRecipeData = false,
    this.enableAnalytics = true,
    this.enableCrashReporting = true,
    this.allowPersonalization = true,
  });

  PrivacySettings copyWith({
    bool? shareUsageData,
    bool? shareRecipeData,
    bool? enableAnalytics,
    bool? enableCrashReporting,
    bool? allowPersonalization,
  }) {
    return PrivacySettings(
      shareUsageData: shareUsageData ?? this.shareUsageData,
      shareRecipeData: shareRecipeData ?? this.shareRecipeData,
      enableAnalytics: enableAnalytics ?? this.enableAnalytics,
      enableCrashReporting: enableCrashReporting ?? this.enableCrashReporting,
      allowPersonalization: allowPersonalization ?? this.allowPersonalization,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'shareUsageData': shareUsageData,
      'shareRecipeData': shareRecipeData,
      'enableAnalytics': enableAnalytics,
      'enableCrashReporting': enableCrashReporting,
      'allowPersonalization': allowPersonalization,
    };
  }

  factory PrivacySettings.fromJson(Map<String, dynamic> json) {
    return PrivacySettings(
      shareUsageData: json['shareUsageData'] ?? false,
      shareRecipeData: json['shareRecipeData'] ?? false,
      enableAnalytics: json['enableAnalytics'] ?? true,
      enableCrashReporting: json['enableCrashReporting'] ?? true,
      allowPersonalization: json['allowPersonalization'] ?? true,
    );
  }
}

class AccessibilitySettings {
  final double textScale;
  final bool enableHighContrast;
  final bool enableLargeText;
  final bool enableVoiceOver;
  final bool enableHapticFeedback;
  final bool enableSoundEffects;

  const AccessibilitySettings({
    this.textScale = 1.0,
    this.enableHighContrast = false,
    this.enableLargeText = false,
    this.enableVoiceOver = false,
    this.enableHapticFeedback = true,
    this.enableSoundEffects = true,
  });

  AccessibilitySettings copyWith({
    double? textScale,
    bool? enableHighContrast,
    bool? enableLargeText,
    bool? enableVoiceOver,
    bool? enableHapticFeedback,
    bool? enableSoundEffects,
  }) {
    return AccessibilitySettings(
      textScale: textScale ?? this.textScale,
      enableHighContrast: enableHighContrast ?? this.enableHighContrast,
      enableLargeText: enableLargeText ?? this.enableLargeText,
      enableVoiceOver: enableVoiceOver ?? this.enableVoiceOver,
      enableHapticFeedback: enableHapticFeedback ?? this.enableHapticFeedback,
      enableSoundEffects: enableSoundEffects ?? this.enableSoundEffects,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'textScale': textScale,
      'enableHighContrast': enableHighContrast,
      'enableLargeText': enableLargeText,
      'enableVoiceOver': enableVoiceOver,
      'enableHapticFeedback': enableHapticFeedback,
      'enableSoundEffects': enableSoundEffects,
    };
  }

  factory AccessibilitySettings.fromJson(Map<String, dynamic> json) {
    return AccessibilitySettings(
      textScale: json['textScale']?.toDouble() ?? 1.0,
      enableHighContrast: json['enableHighContrast'] ?? false,
      enableLargeText: json['enableLargeText'] ?? false,
      enableVoiceOver: json['enableVoiceOver'] ?? false,
      enableHapticFeedback: json['enableHapticFeedback'] ?? true,
      enableSoundEffects: json['enableSoundEffects'] ?? true,
    );
  }
}

enum ThemeMode { system, light, dark }
