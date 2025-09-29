import 'dart:async';
import 'package:flutter/foundation.dart';
import '../errors/app_error.dart';
import '../errors/error_handler.dart';
import '../errors/error_logger.dart';
import '../errors/error_reporter.dart';
import '../utils/retry_manager.dart';
import '../utils/data_recovery_manager.dart';
import '../utils/offline_manager.dart';

/// Comprehensive error handling service that integrates all error handling components
class ErrorHandlingService {
  static final ErrorHandlingService _instance = ErrorHandlingService._internal();
  factory ErrorHandlingService() => _instance;
  ErrorHandlingService._internal();

  final ErrorHandler _errorHandler = ErrorHandler();
  final ErrorReporter _errorReporter = ErrorReporter();
  final RetryManager _retryManager = RetryManager();
  final DataRecoveryManager _recoveryManager = DataRecoveryManager();
  final OfflineManager _offlineManager = OfflineManager();
  final CircuitBreakerManager _circuitBreakerManager = CircuitBreakerManager();

  bool _isInitialized = false;

  /// Initialize the error handling service
  Future<void> initialize() async {
    if (_isInitialized) return;

    // Initialize error reporting
    await _errorReporter.initialize();

    // Add console error reporting service for development
    if (kDebugMode) {
      _errorReporter.addService(ConsoleErrorReportingService());
    }

    // Add mock external service for testing
    _errorReporter.addService(MockExternalErrorReportingService());

    // Initialize offline manager
    await _offlineManager.initialize();

    _isInitialized = true;

    if (kDebugMode) {
      print('🛡️ ErrorHandlingService initialized');
    }
  }

  /// Handle any error with full error handling pipeline
  Future<AppError> handleError(
    dynamic error, [
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  ]) async {
    final appError = _errorHandler.handleError(error, stackTrace);

    // Report error with context if provided
    if (context != null) {
      await _errorReporter.reportErrorWithContext(appError, context);
    } else {
      await _errorReporter.reportError(appError);
    }

    return appError;
  }

  /// Execute operation with comprehensive error handling
  Future<T> executeOperation<T>(
    Future<T> Function() operation, {
    String? operationName,
    RetryConfig? retryConfig,
    String? circuitBreakerName,
    Future<T> Function()? offlineFallback,
    Map<String, dynamic> Function()? getRecoveryState,
    Map<String, dynamic>? errorContext,
  }) async {
    try {
      // Use circuit breaker if specified
      if (circuitBreakerName != null) {
        final circuitBreaker = _circuitBreakerManager.getBreaker(circuitBreakerName);
        
        return await circuitBreaker.execute(() async {
          return await _executeWithRetryAndRecovery(
            operation,
            operationName: operationName,
            retryConfig: retryConfig,
            offlineFallback: offlineFallback,
            getRecoveryState: getRecoveryState,
            errorContext: errorContext,
          );
        });
      } else {
        return await _executeWithRetryAndRecovery(
          operation,
          operationName: operationName,
          retryConfig: retryConfig,
          offlineFallback: offlineFallback,
          getRecoveryState: getRecoveryState,
          errorContext: errorContext,
        );
      }
    } catch (error, stackTrace) {
      final appError = await handleError(error, stackTrace, errorContext);
      throw appError;
    }
  }

  /// Execute with retry and recovery
  Future<T> _executeWithRetryAndRecovery<T>(
    Future<T> Function() operation, {
    String? operationName,
    RetryConfig? retryConfig,
    Future<T> Function()? offlineFallback,
    Map<String, dynamic> Function()? getRecoveryState,
    Map<String, dynamic>? errorContext,
  }) async {
    // Execute with offline fallback if provided
    if (offlineFallback != null) {
      return await _offlineManager.executeWithOfflineFallback(
        () => _executeWithRetryAndRecoveryCore(
          operation,
          operationName: operationName,
          retryConfig: retryConfig,
          getRecoveryState: getRecoveryState,
        ),
        offlineFallback,
        operationName: operationName,
      );
    } else {
      return await _executeWithRetryAndRecoveryCore(
        operation,
        operationName: operationName,
        retryConfig: retryConfig,
        getRecoveryState: getRecoveryState,
      );
    }
  }

  /// Core execution with retry and recovery
  Future<T> _executeWithRetryAndRecoveryCore<T>(
    Future<T> Function() operation, {
    String? operationName,
    RetryConfig? retryConfig,
    Map<String, dynamic> Function()? getRecoveryState,
  }) async {
    // Execute with recovery if recovery state provider is given
    if (getRecoveryState != null && operationName != null) {
      return await _recoveryManager.executeWithRecovery(
        operationName,
        () => _executeWithRetry(operation, retryConfig, operationName),
        getRecoveryState,
      );
    } else {
      return await _executeWithRetry(operation, retryConfig, operationName);
    }
  }

  /// Execute with retry
  Future<T> _executeWithRetry<T>(
    Future<T> Function() operation,
    RetryConfig? retryConfig,
    String? operationName,
  ) async {
    return await _retryManager.execute(
      operation,
      config: retryConfig ?? RetryConfig.network,
      operationName: operationName,
    );
  }

  /// Execute API operation with full error handling
  Future<T> executeApiOperation<T>(
    Future<T> Function() operation, {
    required String serviceName,
    String? operationName,
    Future<T> Function()? fallbackOperation,
    Map<String, dynamic>? errorContext,
  }) async {
    return executeOperation(
      operation,
      operationName: operationName ?? serviceName,
      retryConfig: RetryConfig.rateLimited,
      circuitBreakerName: serviceName,
      offlineFallback: fallbackOperation,
      errorContext: {
        'service': serviceName,
        'operation': operationName ?? 'unknown',
        ...?errorContext,
      },
    );
  }

  /// Execute storage operation with backup and recovery
  Future<T> executeStorageOperation<T>(
    Future<T> Function() operation, {
    required String operationType,
    required Map<String, dynamic> Function() getBackupData,
    String? dataType,
    Map<String, dynamic>? errorContext,
  }) async {
    return executeOperation(
      operation,
      operationName: operationType,
      retryConfig: RetryConfig.critical,
      getRecoveryState: getBackupData,
      errorContext: {
        'operationType': operationType,
        'dataType': dataType ?? 'unknown',
        ...?errorContext,
      },
    );
  }

  /// Get error statistics
  ErrorStatistics getErrorStatistics() {
    return _errorHandler.logger.getStatistics();
  }

  /// Get circuit breaker statuses
  Map<String, Map<String, dynamic>> getCircuitBreakerStatuses() {
    return _circuitBreakerManager.getAllStatuses();
  }

  /// Reset all circuit breakers
  void resetCircuitBreakers() {
    _circuitBreakerManager.resetAll();
  }

  /// Get connectivity status
  bool get isOnline => _offlineManager.isOnline;

  /// Listen to connectivity changes
  Stream<bool> get connectivityStream => _offlineManager.connectivityStream;

  /// Create backup
  Future<String> createBackup(String dataType, Map<String, dynamic> data) {
    return _recoveryManager.createBackup(dataType, data);
  }

  /// List backups
  Future<List<BackupInfo>> listBackups(String dataType) {
    return _recoveryManager.listBackups(dataType);
  }

  /// Restore from backup
  Future<Map<String, dynamic>> restoreFromBackup(String fileName) {
    return _recoveryManager.restoreFromBackup(fileName);
  }

  /// Cache data for offline use
  Future<void> cacheData(String key, Map<String, dynamic> data) {
    return _offlineManager.cacheData(key, data);
  }

  /// Get cached data
  Future<Map<String, dynamic>?> getCachedData(String key) {
    return _offlineManager.getCachedData(key);
  }

  /// Clear error logs
  void clearErrorLogs() {
    _errorHandler.logger.clearLog();
  }

  /// Clear offline cache
  Future<void> clearOfflineCache() {
    return _offlineManager.clearCache();
  }

  /// Get system health status
  Future<SystemHealthStatus> getSystemHealthStatus() async {
    final errorStats = getErrorStatistics();
    final circuitBreakerStatuses = getCircuitBreakerStatuses();
    final cacheStats = await _offlineManager.getCacheStatistics();
    final pendingRecoveryPoints = await _recoveryManager.listPendingRecoveryPoints();

    // Calculate health score (0-100)
    int healthScore = 100;

    // Deduct points for recent errors
    if (errorStats.errorsLast24Hours > 0) {
      healthScore -= min(30, errorStats.errorsLast24Hours * 2);
    }

    // Deduct points for open circuit breakers
    final openBreakers = circuitBreakerStatuses.values
        .where((status) => status['state'] == 'open')
        .length;
    healthScore -= openBreakers * 10;

    // Deduct points for pending recovery points
    healthScore -= pendingRecoveryPoints.length * 5;

    // Ensure score is not negative
    healthScore = max(0, healthScore);

    return SystemHealthStatus(
      healthScore: healthScore,
      isOnline: _offlineManager.isOnline,
      errorStatistics: errorStats,
      circuitBreakerStatuses: circuitBreakerStatuses,
      cacheStatistics: cacheStats,
      pendingRecoveryPoints: pendingRecoveryPoints.length,
      lastUpdated: DateTime.now(),
    );
  }

  /// Dispose resources
  void dispose() {
    _offlineManager.dispose();
  }
}

/// System health status
class SystemHealthStatus {
  const SystemHealthStatus({
    required this.healthScore,
    required this.isOnline,
    required this.errorStatistics,
    required this.circuitBreakerStatuses,
    required this.cacheStatistics,
    required this.pendingRecoveryPoints,
    required this.lastUpdated,
  });

  final int healthScore;
  final bool isOnline;
  final ErrorStatistics errorStatistics;
  final Map<String, Map<String, dynamic>> circuitBreakerStatuses;
  final CacheStatistics cacheStatistics;
  final int pendingRecoveryPoints;
  final DateTime lastUpdated;

  String get healthStatus {
    if (healthScore >= 90) return 'Excellent';
    if (healthScore >= 70) return 'Good';
    if (healthScore >= 50) return 'Fair';
    if (healthScore >= 30) return 'Poor';
    return 'Critical';
  }

  bool get hasIssues => healthScore < 70;
}

/// Helper function to get minimum value
int min(int a, int b) => a < b ? a : b;

/// Helper function to get maximum value
int max(int a, int b) => a > b ? a : b;