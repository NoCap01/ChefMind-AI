import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';
import 'app_error.dart';

/// Error logging service
class ErrorLogger {
  static final ErrorLogger _instance = ErrorLogger._internal();
  factory ErrorLogger() => _instance;
  ErrorLogger._internal();

  final List<ErrorLogEntry> _errorLog = [];
  final int _maxLogEntries = 1000;

  /// Log an error
  void logError(AppError error) {
    final entry = ErrorLogEntry(
      error: error,
      timestamp: DateTime.now(),
    );

    _errorLog.add(entry);

    // Keep log size manageable
    if (_errorLog.length > _maxLogEntries) {
      _errorLog.removeAt(0);
    }

    // Log to console in debug mode
    if (kDebugMode) {
      _logToConsole(entry);
    }

    // Log to system in release mode
    if (kReleaseMode) {
      _logToSystem(entry);
    }
  }

  /// Log to console (debug mode)
  void _logToConsole(ErrorLogEntry entry) {
    final error = entry.error;
    final timestamp = entry.timestamp.toIso8601String();
    
    print('🔴 ERROR [$timestamp] ${error.severity.name.toUpperCase()}');
    print('Code: ${error.code}');
    print('Message: ${error.message}');
    if (error.details != null) {
      print('Details: ${error.details}');
    }
    if (error.stackTrace != null) {
      print('Stack trace:');
      print(error.stackTrace);
    }
    print('---');
  }

  /// Log to system (release mode)
  void _logToSystem(ErrorLogEntry entry) {
    final error = entry.error;
    
    developer.log(
      error.message,
      name: 'ChefMindAI',
      error: error,
      stackTrace: error.stackTrace,
      level: _getSeverityLevel(error.severity),
    );
  }

  /// Convert error severity to log level
  int _getSeverityLevel(ErrorSeverity severity) {
    switch (severity) {
      case ErrorSeverity.info:
        return 800; // INFO
      case ErrorSeverity.warning:
        return 900; // WARNING
      case ErrorSeverity.error:
        return 1000; // SEVERE
      case ErrorSeverity.critical:
        return 1200; // SHOUT
    }
  }

  /// Get recent errors
  List<ErrorLogEntry> getRecentErrors({int limit = 50}) {
    final startIndex = _errorLog.length > limit ? _errorLog.length - limit : 0;
    return _errorLog.sublist(startIndex);
  }

  /// Get errors by severity
  List<ErrorLogEntry> getErrorsBySeverity(ErrorSeverity severity) {
    return _errorLog.where((entry) => entry.error.severity == severity).toList();
  }

  /// Get errors by code
  List<ErrorLogEntry> getErrorsByCode(String code) {
    return _errorLog.where((entry) => entry.error.code == code).toList();
  }

  /// Clear error log
  void clearLog() {
    _errorLog.clear();
  }

  /// Get error statistics
  ErrorStatistics getStatistics() {
    final now = DateTime.now();
    final last24Hours = now.subtract(const Duration(hours: 24));
    final lastWeek = now.subtract(const Duration(days: 7));

    final recent24h = _errorLog.where((e) => e.timestamp.isAfter(last24Hours));
    final recentWeek = _errorLog.where((e) => e.timestamp.isAfter(lastWeek));

    final severityCounts = <ErrorSeverity, int>{};
    final codeCounts = <String, int>{};

    for (final entry in _errorLog) {
      severityCounts[entry.error.severity] = 
          (severityCounts[entry.error.severity] ?? 0) + 1;
      codeCounts[entry.error.code] = 
          (codeCounts[entry.error.code] ?? 0) + 1;
    }

    return ErrorStatistics(
      totalErrors: _errorLog.length,
      errorsLast24Hours: recent24h.length,
      errorsLastWeek: recentWeek.length,
      severityCounts: severityCounts,
      codeCounts: codeCounts,
    );
  }
}

/// Error log entry
class ErrorLogEntry {
  const ErrorLogEntry({
    required this.error,
    required this.timestamp,
  });

  final AppError error;
  final DateTime timestamp;
}

/// Error statistics
class ErrorStatistics {
  const ErrorStatistics({
    required this.totalErrors,
    required this.errorsLast24Hours,
    required this.errorsLastWeek,
    required this.severityCounts,
    required this.codeCounts,
  });

  final int totalErrors;
  final int errorsLast24Hours;
  final int errorsLastWeek;
  final Map<ErrorSeverity, int> severityCounts;
  final Map<String, int> codeCounts;
}