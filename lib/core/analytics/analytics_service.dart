import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../performance/performance_monitor.dart';

class AnalyticsService {
  static final AnalyticsService _instance = AnalyticsService._internal();
  factory AnalyticsService() => _instance;
  AnalyticsService._internal();

  final PerformanceMonitor _performanceMonitor = PerformanceMonitor();
  bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) return;
    
    _isInitialized = true;
    _performanceMonitor.startMonitoring();
    
    if (kDebugMode) {
      print('Analytics service initialized');
    }
  }

  // User behavior tracking
  void trackUserAction(String action, {Map<String, dynamic>? properties}) {
    _trackEvent('user_action', {
      'action': action,
      ...?properties,
    });
  }

  void trackScreenView(String screenName, {Map<String, dynamic>? properties}) {
    _trackEvent('screen_view', {
      'screen_name': screenName,
      ...?properties,
    });
  }

  // Recipe-specific analytics
  void trackRecipeGeneration({
    required String source,
    required int duration,
    required bool success,
    String? errorType,
    Map<String, dynamic>? recipeData,
  }) {
    _trackEvent('recipe_generation', {
      'source': source,
      'duration_ms': duration,
      'success': success,
      'error_type': errorType,
      'recipe_data': recipeData,
    });
  }

  void trackRecipeInteraction(String action, String recipeId, {Map<String, dynamic>? properties}) {
    _trackEvent('recipe_interaction', {
      'action': action,
      'recipe_id': recipeId,
      ...?properties,
    });
  }

  // Performance tracking
  void trackPerformanceMetric(String metric, num value, {Map<String, dynamic>? metadata}) {
    _performanceMonitor.recordCustomMetric(metric, value, metadata: metadata);
    
    _trackEvent('performance_metric', {
      'metric': metric,
      'value': value,
      'metadata': metadata,
    });
  }

  void trackError(String error, String context, {Map<String, dynamic>? metadata}) {
    _trackEvent('error', {
      'error': error,
      'context': context,
      'metadata': metadata,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  // App lifecycle tracking
  void trackAppStart() {
    _performanceMonitor.startTimer('app_startup');
    _trackEvent('app_start', {
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  void trackAppStartComplete() {
    _performanceMonitor.endTimer('app_startup');
    _trackEvent('app_start_complete', {
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  void trackAppBackground() {
    _trackEvent('app_background', {
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  void trackAppForeground() {
    _trackEvent('app_foreground', {
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  // Feature usage tracking
  void trackFeatureUsage(String feature, {Map<String, dynamic>? properties}) {
    _trackEvent('feature_usage', {
      'feature': feature,
      ...?properties,
    });
  }

  void trackSearchQuery(String query, int resultCount, {String? category}) {
    _trackEvent('search', {
      'query': query,
      'result_count': resultCount,
      'category': category,
    });
  }

  // API usage tracking
  void trackAPICall(String endpoint, int duration, bool success, {String? errorType}) {
    _trackEvent('api_call', {
      'endpoint': endpoint,
      'duration_ms': duration,
      'success': success,
      'error_type': errorType,
    });
  }

  // User engagement tracking
  void trackSessionStart() {
    _trackEvent('session_start', {
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  void trackSessionEnd(Duration sessionDuration) {
    _trackEvent('session_end', {
      'duration_ms': sessionDuration.inMilliseconds,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  // Custom events
  void trackCustomEvent(String eventName, Map<String, dynamic> properties) {
    _trackEvent(eventName, properties);
  }

  // Performance summary
  Map<String, dynamic> getPerformanceSummary() {
    return _performanceMonitor.getPerformanceSummary();
  }

  // Internal tracking method
  void _trackEvent(String eventName, Map<String, dynamic> properties) {
    final event = {
      'event': eventName,
      'properties': properties,
      'timestamp': DateTime.now().toIso8601String(),
      'platform': defaultTargetPlatform.name,
    };

    if (kDebugMode) {
      print('Analytics Event: ${json.encode(event)}');
    }

    // In production, send to your analytics service
    _sendToAnalyticsService(event);
  }

  void _sendToAnalyticsService(Map<String, dynamic> event) {
    // This would integrate with your chosen analytics service
    // Examples: Firebase Analytics, Mixpanel, Amplitude, etc.
    
    // For now, we'll just store locally for debugging
    if (kDebugMode) {
      _storeEventLocally(event);
    }
  }

  void _storeEventLocally(Map<String, dynamic> event) {
    // In a real implementation, you might want to batch events
    // and send them periodically to reduce network calls
  }

  void dispose() {
    _performanceMonitor.stopMonitoring();
    _isInitialized = false;
  }
}

// Extension for easy performance measurement
extension PerformanceTracking on AnalyticsService {
  Future<T> measureOperation<T>(
    String operationName,
    Future<T> Function() operation, {
    Map<String, dynamic>? metadata,
  }) async {
    final stopwatch = Stopwatch()..start();
    try {
      final result = await operation();
      stopwatch.stop();
      
      trackPerformanceMetric(operationName, stopwatch.elapsedMilliseconds, metadata: {
        'success': true,
        ...?metadata,
      });
      
      return result;
    } catch (e) {
      stopwatch.stop();
      
      trackPerformanceMetric(operationName, stopwatch.elapsedMilliseconds, metadata: {
        'success': false,
        'error': e.toString(),
        ...?metadata,
      });
      
      rethrow;
    }
  }
}