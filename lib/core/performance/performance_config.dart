class PerformanceConfig {
  // Performance thresholds (in milliseconds)
  static const Map<String, int> performanceThresholds = {
    'app_startup': 3000,           // App should start within 3 seconds
    'recipe_generation': 10000,    // Recipe generation within 10 seconds
    'navigation': 500,             // Navigation should be under 500ms
    'data_load': 2000,            // Data loading within 2 seconds
    'image_load': 1000,           // Image loading within 1 second
    'search': 300,                // Search results within 300ms
    'form_validation': 100,       // Form validation within 100ms
    'state_update': 50,           // State updates within 50ms
  };

  // Memory thresholds (in bytes)
  static const Map<String, int> memoryThresholds = {
    'navigation_increase': 20 * 1024 * 1024,      // 20MB max increase during navigation
    'recipe_generation_increase': 30 * 1024 * 1024, // 30MB max increase during recipe generation
    'scrolling_increase': 10 * 1024 * 1024,       // 10MB max increase during scrolling
    'image_cache_max': 50 * 1024 * 1024,          // 50MB max for image cache
    'total_app_memory': 200 * 1024 * 1024,        // 200MB total app memory limit
  };

  // Performance monitoring settings
  static const bool enablePerformanceMonitoring = true;
  static const bool enableMemoryMonitoring = true;
  static const bool enableAnalytics = true;
  static const Duration memoryCheckInterval = Duration(minutes: 1);
  static const int maxStoredMetrics = 1000;

  // Frame rate settings
  static const double targetFPS = 60.0;
  static const double minimumAcceptableFPS = 30.0;
  static const Duration frameTimeThreshold = Duration(milliseconds: 16); // 60 FPS = 16ms per frame

  // Network performance settings
  static const Duration networkTimeout = Duration(seconds: 30);
  static const int maxRetryAttempts = 3;
  static const Duration retryDelay = Duration(seconds: 1);

  // Cache settings
  static const int maxCacheSize = 100 * 1024 * 1024; // 100MB
  static const Duration cacheExpiration = Duration(hours: 24);
  static const int maxCachedItems = 500;

  // Lazy loading settings
  static const int lazyLoadBatchSize = 20;
  static const Duration lazyLoadDelay = Duration(milliseconds: 100);
  static const double lazyLoadTriggerOffset = 200.0; // pixels from bottom

  // Image optimization settings
  static const int maxImageWidth = 1024;
  static const int maxImageHeight = 1024;
  static const int imageQuality = 85; // JPEG quality (0-100)

  // Database performance settings
  static const int maxDatabaseConnections = 5;
  static const Duration databaseTimeout = Duration(seconds: 10);
  static const int maxBatchSize = 100;

  // UI performance settings
  static const Duration debounceDelay = Duration(milliseconds: 300);
  static const Duration throttleDelay = Duration(milliseconds: 100);
  static const int maxListItems = 1000;

  // Get threshold for specific operation
  static int getThreshold(String operation) {
    return performanceThresholds[operation] ?? 1000; // Default 1 second
  }

  // Get memory threshold for specific operation
  static int getMemoryThreshold(String operation) {
    return memoryThresholds[operation] ?? 10 * 1024 * 1024; // Default 10MB
  }

  // Check if performance is acceptable
  static bool isPerformanceAcceptable(String operation, int duration) {
    final threshold = getThreshold(operation);
    return duration <= threshold;
  }

  // Check if memory usage is acceptable
  static bool isMemoryUsageAcceptable(String operation, int memoryIncrease) {
    final threshold = getMemoryThreshold(operation);
    return memoryIncrease <= threshold;
  }

  // Get performance status
  static PerformanceStatus getPerformanceStatus(String operation, int duration) {
    final threshold = getThreshold(operation);
    final warningThreshold = (threshold * 0.8).round();
    
    if (duration <= warningThreshold) {
      return PerformanceStatus.good;
    } else if (duration <= threshold) {
      return PerformanceStatus.warning;
    } else {
      return PerformanceStatus.poor;
    }
  }

  // Get memory status
  static PerformanceStatus getMemoryStatus(String operation, int memoryUsage) {
    final threshold = getMemoryThreshold(operation);
    final warningThreshold = (threshold * 0.8).round();
    
    if (memoryUsage <= warningThreshold) {
      return PerformanceStatus.good;
    } else if (memoryUsage <= threshold) {
      return PerformanceStatus.warning;
    } else {
      return PerformanceStatus.poor;
    }
  }
}

enum PerformanceStatus {
  good,
  warning,
  poor,
}

extension PerformanceStatusExtension on PerformanceStatus {
  String get displayName {
    switch (this) {
      case PerformanceStatus.good:
        return 'Good';
      case PerformanceStatus.warning:
        return 'Warning';
      case PerformanceStatus.poor:
        return 'Poor';
    }
  }

  String get emoji {
    switch (this) {
      case PerformanceStatus.good:
        return '🟢';
      case PerformanceStatus.warning:
        return '🟡';
      case PerformanceStatus.poor:
        return '🔴';
    }
  }
}