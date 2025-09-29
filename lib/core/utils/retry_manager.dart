import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import '../errors/app_error.dart';

/// Configuration for retry behavior
class RetryConfig {
  const RetryConfig({
    this.maxAttempts = 3,
    this.baseDelay = const Duration(seconds: 1),
    this.maxDelay = const Duration(seconds: 30),
    this.backoffMultiplier = 2.0,
    this.jitter = true,
    this.retryIf,
  });

  final int maxAttempts;
  final Duration baseDelay;
  final Duration maxDelay;
  final double backoffMultiplier;
  final bool jitter;
  final bool Function(AppError error)? retryIf;

  /// Default config for network operations
  static const network = RetryConfig(
    maxAttempts: 3,
    baseDelay: Duration(seconds: 1),
    maxDelay: Duration(seconds: 10),
    backoffMultiplier: 2.0,
    jitter: true,
  );

  /// Config for API rate limiting
  static const rateLimited = RetryConfig(
    maxAttempts: 5,
    baseDelay: Duration(seconds: 2),
    maxDelay: Duration(minutes: 2),
    backoffMultiplier: 2.0,
    jitter: true,
  );

  /// Config for critical operations
  static const critical = RetryConfig(
    maxAttempts: 5,
    baseDelay: Duration(milliseconds: 500),
    maxDelay: Duration(seconds: 15),
    backoffMultiplier: 1.5,
    jitter: true,
  );
}

/// Retry manager for handling operation retries
class RetryManager {
  static final RetryManager _instance = RetryManager._internal();
  factory RetryManager() => _instance;
  RetryManager._internal();

  final Random _random = Random();

  /// Execute an operation with retry logic
  Future<T> execute<T>(
    Future<T> Function() operation, {
    RetryConfig config = RetryConfig.network,
    String? operationName,
  }) async {
    int attempt = 0;
    AppError? lastError;

    while (attempt < config.maxAttempts) {
      attempt++;
      
      try {
        if (kDebugMode && operationName != null) {
          print('🔄 Executing $operationName (attempt $attempt/${config.maxAttempts})');
        }
        
        final result = await operation();
        
        if (kDebugMode && operationName != null && attempt > 1) {
          print('✅ $operationName succeeded on attempt $attempt');
        }
        
        return result;
      } catch (error, stackTrace) {
        lastError = error is AppError 
            ? error 
            : UnknownError(
                message: error.toString(),
                stackTrace: stackTrace,
              );

        if (kDebugMode && operationName != null) {
          print('❌ $operationName failed on attempt $attempt: ${lastError.message}');
        }

        // Check if we should retry this error
        if (!_shouldRetry(lastError, config)) {
          if (kDebugMode && operationName != null) {
            print('🚫 Not retrying $operationName: error not retryable');
          }
          throw lastError;
        }

        // Don't delay on the last attempt
        if (attempt < config.maxAttempts) {
          final delay = _calculateDelay(attempt, config);
          if (kDebugMode && operationName != null) {
            print('⏳ Waiting ${delay.inMilliseconds}ms before retry');
          }
          await Future.delayed(delay);
        }
      }
    }

    if (kDebugMode && operationName != null) {
      print('💥 $operationName failed after ${config.maxAttempts} attempts');
    }

    throw lastError!;
  }

  /// Execute with custom retry condition
  Future<T> executeWithCondition<T>(
    Future<T> Function() operation,
    bool Function(dynamic error) shouldRetry, {
    RetryConfig config = RetryConfig.network,
    String? operationName,
  }) async {
    final customConfig = RetryConfig(
      maxAttempts: config.maxAttempts,
      baseDelay: config.baseDelay,
      maxDelay: config.maxDelay,
      backoffMultiplier: config.backoffMultiplier,
      jitter: config.jitter,
      retryIf: (error) => shouldRetry(error),
    );

    return execute(operation, config: customConfig, operationName: operationName);
  }

  /// Check if an error should be retried
  bool _shouldRetry(AppError error, RetryConfig config) {
    // Use custom retry condition if provided
    if (config.retryIf != null) {
      return config.retryIf!(error);
    }

    // Default retry logic
    return error.isRetryable;
  }

  /// Calculate delay for exponential backoff
  Duration _calculateDelay(int attempt, RetryConfig config) {
    final exponentialDelay = config.baseDelay.inMilliseconds * 
        pow(config.backoffMultiplier, attempt - 1);
    
    var delayMs = exponentialDelay.toInt();
    
    // Apply maximum delay limit
    delayMs = min(delayMs, config.maxDelay.inMilliseconds);
    
    // Add jitter to prevent thundering herd
    if (config.jitter) {
      final jitterRange = (delayMs * 0.1).toInt();
      final jitter = _random.nextInt(jitterRange * 2) - jitterRange;
      delayMs += jitter;
    }
    
    return Duration(milliseconds: max(0, delayMs));
  }
}

/// Mixin for adding retry capabilities to classes
mixin RetryMixin {
  final RetryManager _retryManager = RetryManager();

  /// Execute operation with retry
  Future<T> withRetry<T>(
    Future<T> Function() operation, {
    RetryConfig config = RetryConfig.network,
    String? operationName,
  }) {
    return _retryManager.execute(
      operation,
      config: config,
      operationName: operationName,
    );
  }

  /// Execute with custom retry condition
  Future<T> withCustomRetry<T>(
    Future<T> Function() operation,
    bool Function(dynamic error) shouldRetry, {
    RetryConfig config = RetryConfig.network,
    String? operationName,
  }) {
    return _retryManager.executeWithCondition(
      operation,
      shouldRetry,
      config: config,
      operationName: operationName,
    );
  }
}

/// Circuit breaker for preventing cascading failures
class CircuitBreaker {
  CircuitBreaker({
    required this.name,
    this.failureThreshold = 5,
    this.recoveryTimeout = const Duration(minutes: 1),
    this.monitoringPeriod = const Duration(minutes: 5),
  });

  final String name;
  final int failureThreshold;
  final Duration recoveryTimeout;
  final Duration monitoringPeriod;

  CircuitBreakerState _state = CircuitBreakerState.closed;
  int _failureCount = 0;
  DateTime? _lastFailureTime;
  DateTime? _nextAttemptTime;

  CircuitBreakerState get state => _state;
  int get failureCount => _failureCount;

  /// Execute operation through circuit breaker
  Future<T> execute<T>(Future<T> Function() operation) async {
    if (_state == CircuitBreakerState.open) {
      if (_nextAttemptTime != null && DateTime.now().isBefore(_nextAttemptTime!)) {
        throw ApiError(
          message: 'Circuit breaker is open for $name',
          code: 'circuit_breaker_open',
          details: 'Next attempt allowed at ${_nextAttemptTime!.toIso8601String()}',
        );
      } else {
        _state = CircuitBreakerState.halfOpen;
        if (kDebugMode) {
          print('🔄 Circuit breaker $name transitioning to half-open');
        }
      }
    }

    try {
      final result = await operation();
      _onSuccess();
      return result;
    } catch (error) {
      _onFailure();
      rethrow;
    }
  }

  void _onSuccess() {
    _failureCount = 0;
    _lastFailureTime = null;
    _nextAttemptTime = null;
    
    if (_state == CircuitBreakerState.halfOpen) {
      _state = CircuitBreakerState.closed;
      if (kDebugMode) {
        print('✅ Circuit breaker $name closed after successful operation');
      }
    }
  }

  void _onFailure() {
    _failureCount++;
    _lastFailureTime = DateTime.now();

    if (_failureCount >= failureThreshold) {
      _state = CircuitBreakerState.open;
      _nextAttemptTime = DateTime.now().add(recoveryTimeout);
      
      if (kDebugMode) {
        print('🚫 Circuit breaker $name opened after $failureCount failures');
      }
    }
  }

  /// Reset circuit breaker
  void reset() {
    _state = CircuitBreakerState.closed;
    _failureCount = 0;
    _lastFailureTime = null;
    _nextAttemptTime = null;
    
    if (kDebugMode) {
      print('🔄 Circuit breaker $name reset');
    }
  }

  /// Get circuit breaker status
  Map<String, dynamic> getStatus() {
    return {
      'name': name,
      'state': _state.name,
      'failureCount': _failureCount,
      'lastFailureTime': _lastFailureTime?.toIso8601String(),
      'nextAttemptTime': _nextAttemptTime?.toIso8601String(),
    };
  }
}

enum CircuitBreakerState {
  closed,
  open,
  halfOpen,
}

/// Manager for multiple circuit breakers
class CircuitBreakerManager {
  static final CircuitBreakerManager _instance = CircuitBreakerManager._internal();
  factory CircuitBreakerManager() => _instance;
  CircuitBreakerManager._internal();

  final Map<String, CircuitBreaker> _breakers = {};

  /// Get or create a circuit breaker
  CircuitBreaker getBreaker(
    String name, {
    int failureThreshold = 5,
    Duration recoveryTimeout = const Duration(minutes: 1),
    Duration monitoringPeriod = const Duration(minutes: 5),
  }) {
    return _breakers.putIfAbsent(
      name,
      () => CircuitBreaker(
        name: name,
        failureThreshold: failureThreshold,
        recoveryTimeout: recoveryTimeout,
        monitoringPeriod: monitoringPeriod,
      ),
    );
  }

  /// Get all circuit breaker statuses
  Map<String, Map<String, dynamic>> getAllStatuses() {
    return _breakers.map((name, breaker) => MapEntry(name, breaker.getStatus()));
  }

  /// Reset all circuit breakers
  void resetAll() {
    for (final breaker in _breakers.values) {
      breaker.reset();
    }
  }
}