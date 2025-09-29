import 'dart:async';
import 'package:flutter/foundation.dart';
import 'app_error.dart';
import 'error_logger.dart';

/// Service for reporting errors to external services
class ErrorReporter {
  static final ErrorReporter _instance = ErrorReporter._internal();
  factory ErrorReporter() => _instance;
  ErrorReporter._internal();

  final ErrorLogger _logger = ErrorLogger();
  final List<ErrorReportingService> _services = [];
  bool _isInitialized = false;

  /// Initialize error reporting
  Future<void> initialize() async {
    if (_isInitialized) return;

    // Set up global error handlers
    FlutterError.onError = (FlutterErrorDetails details) {
      final error = UnknownError(
        message: details.exception.toString(),
        details: details.toString(),
        stackTrace: details.stack,
      );
      reportError(error);
    };

    // Handle errors outside of Flutter
    PlatformDispatcher.instance.onError = (error, stack) {
      final appError = UnknownError(
        message: error.toString(),
        stackTrace: stack,
      );
      reportError(appError);
      return true;
    };

    _isInitialized = true;
  }

  /// Add an error reporting service
  void addService(ErrorReportingService service) {
    _services.add(service);
  }

  /// Remove an error reporting service
  void removeService(ErrorReportingService service) {
    _services.remove(service);
  }

  /// Report an error to all configured services
  Future<void> reportError(AppError error) async {
    // Log locally first
    _logger.logError(error);

    // Report to external services
    for (final service in _services) {
      try {
        await service.reportError(error);
      } catch (e) {
        // Don't let reporting errors crash the app
        if (kDebugMode) {
          print('Failed to report error to ${service.name}: $e');
        }
      }
    }
  }

  /// Report an error with additional context
  Future<void> reportErrorWithContext(
    AppError error,
    Map<String, dynamic> context,
  ) async {
    // Log locally with context
    _logger.logError(error);

    // Report to external services with context
    for (final service in _services) {
      try {
        await service.reportErrorWithContext(error, context);
      } catch (e) {
        if (kDebugMode) {
          print('Failed to report error with context to ${service.name}: $e');
        }
      }
    }
  }

  /// Get error statistics
  ErrorStatistics getStatistics() {
    return _logger.getStatistics();
  }

  /// Clear error logs
  void clearLogs() {
    _logger.clearLog();
  }
}

/// Abstract base class for error reporting services
abstract class ErrorReportingService {
  String get name;
  
  Future<void> reportError(AppError error);
  
  Future<void> reportErrorWithContext(
    AppError error,
    Map<String, dynamic> context,
  );
}

/// Console error reporting service (for development)
class ConsoleErrorReportingService implements ErrorReportingService {
  @override
  String get name => 'Console';

  @override
  Future<void> reportError(AppError error) async {
    if (kDebugMode) {
      print('🔴 ERROR REPORT');
      print('Code: ${error.code}');
      print('Message: ${error.message}');
      print('Severity: ${error.severity.name}');
      if (error.details != null) {
        print('Details: ${error.details}');
      }
      if (error.stackTrace != null) {
        print('Stack trace:');
        print(error.stackTrace);
      }
      print('---');
    }
  }

  @override
  Future<void> reportErrorWithContext(
    AppError error,
    Map<String, dynamic> context,
  ) async {
    if (kDebugMode) {
      print('🔴 ERROR REPORT WITH CONTEXT');
      print('Code: ${error.code}');
      print('Message: ${error.message}');
      print('Severity: ${error.severity.name}');
      print('Context: $context');
      if (error.details != null) {
        print('Details: ${error.details}');
      }
      if (error.stackTrace != null) {
        print('Stack trace:');
        print(error.stackTrace);
      }
      print('---');
    }
  }
}

/// Mock external error reporting service
class MockExternalErrorReportingService implements ErrorReportingService {
  @override
  String get name => 'MockExternal';

  final List<ErrorReport> _reports = [];

  @override
  Future<void> reportError(AppError error) async {
    _reports.add(ErrorReport(
      error: error,
      context: {},
      timestamp: DateTime.now(),
    ));
  }

  @override
  Future<void> reportErrorWithContext(
    AppError error,
    Map<String, dynamic> context,
  ) async {
    _reports.add(ErrorReport(
      error: error,
      context: context,
      timestamp: DateTime.now(),
    ));
  }

  /// Get all reports (for testing)
  List<ErrorReport> get reports => List.unmodifiable(_reports);

  /// Clear reports
  void clearReports() {
    _reports.clear();
  }
}

/// Error report data structure
class ErrorReport {
  const ErrorReport({
    required this.error,
    required this.context,
    required this.timestamp,
  });

  final AppError error;
  final Map<String, dynamic> context;
  final DateTime timestamp;
}

/// Helper for collecting error context
class ErrorContext {
  static Map<String, dynamic> collect({
    String? userId,
    String? screenName,
    String? action,
    Map<String, dynamic>? additionalData,
  }) {
    final context = <String, dynamic>{
      'timestamp': DateTime.now().toIso8601String(),
      'platform': defaultTargetPlatform.name,
    };

    if (userId != null) context['userId'] = userId;
    if (screenName != null) context['screenName'] = screenName;
    if (action != null) context['action'] = action;
    if (additionalData != null) context.addAll(additionalData);

    return context;
  }
}