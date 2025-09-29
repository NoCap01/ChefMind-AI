import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'performance_config.dart';

class PerformanceMonitor {
  static final PerformanceMonitor _instance = PerformanceMonitor._internal();
  factory PerformanceMonitor() => _instance;
  PerformanceMonitor._internal();

  final Map<String, Stopwatch> _activeTimers = {};
  final List<PerformanceMetric> _metrics = [];
  Timer? _memoryMonitorTimer;

  bool _isMonitoring = false;

  void startMonitoring() {
    if (_isMonitoring) return;

    _isMonitoring = true;
    _startMemoryMonitoring();

    if (kDebugMode) {
      print('Performance monitoring started');
    }
  }

  void stopMonitoring() {
    _isMonitoring = false;
    _memoryMonitorTimer?.cancel();

    if (kDebugMode) {
      print('Performance monitoring stopped');
    }
  }

  void startTimer(String operation) {
    _activeTimers[operation] = Stopwatch()..start();
  }

  void endTimer(String operation, {Map<String, dynamic>? metadata}) {
    final timer = _activeTimers.remove(operation);
    if (timer != null) {
      timer.stop();
      _recordMetric(PerformanceMetric(
        operation: operation,
        duration: timer.elapsedMilliseconds,
        timestamp: DateTime.now(),
        metadata: metadata,
      ));
    }
  }

  Future<T> measureAsync<T>(
    String operation,
    Future<T> Function() function, {
    Map<String, dynamic>? metadata,
  }) async {
    startTimer(operation);
    try {
      return await function();
    } finally {
      endTimer(operation, metadata: metadata);
    }
  }

  T measureSync<T>(
    String operation,
    T Function() function, {
    Map<String, dynamic>? metadata,
  }) {
    startTimer(operation);
    try {
      return function();
    } finally {
      endTimer(operation, metadata: metadata);
    }
  }

  void recordCustomMetric(String name, num value,
      {Map<String, dynamic>? metadata}) {
    _recordMetric(PerformanceMetric(
      operation: name,
      duration: value.toInt(),
      timestamp: DateTime.now(),
      metadata: metadata,
    ));
  }

  void _startMemoryMonitoring() {
    _memoryMonitorTimer =
        Timer.periodic(const Duration(minutes: 1), (timer) async {
      final memoryUsage = await _getCurrentMemoryUsage();
      if (memoryUsage > 0) {
        recordCustomMetric('memory_usage', memoryUsage, metadata: {
          'unit': 'bytes',
          'mb': (memoryUsage / (1024 * 1024)).toStringAsFixed(2),
        });
      }
    });
  }

  Future<int> _getCurrentMemoryUsage() async {
    if (kIsWeb) return 0;

    try {
      return ProcessInfo.currentRss;
    } catch (e) {
      return 0;
    }
  }

  void _recordMetric(PerformanceMetric metric) {
    _metrics.add(metric);

    // Keep only last 1000 metrics to prevent memory issues
    if (_metrics.length > 1000) {
      _metrics.removeRange(0, _metrics.length - 1000);
    }

    if (kDebugMode) {
      print('Performance: ${metric.operation} took ${metric.duration}ms');
    }

    // Send to analytics in production
    _sendToAnalytics(metric);
  }

  void _sendToAnalytics(PerformanceMetric metric) {
    // In a real app, this would send to your analytics service
    // For now, we'll just log critical performance issues

    if (metric.duration > _getCriticalThreshold(metric.operation)) {
      if (kDebugMode) {
        print(
            'PERFORMANCE WARNING: ${metric.operation} took ${metric.duration}ms (threshold exceeded)');
      }
    }
  }

  int _getCriticalThreshold(String operation) {
    return PerformanceConfig.getThreshold(operation);
  }

  List<PerformanceMetric> getMetrics({String? operation}) {
    if (operation != null) {
      return _metrics.where((m) => m.operation == operation).toList();
    }
    return List.from(_metrics);
  }

  Map<String, dynamic> getPerformanceSummary() {
    if (_metrics.isEmpty) {
      return {'message': 'No performance data available'};
    }

    final operationGroups = <String, List<PerformanceMetric>>{};
    for (final metric in _metrics) {
      operationGroups.putIfAbsent(metric.operation, () => []).add(metric);
    }

    final summary = <String, dynamic>{};

    for (final entry in operationGroups.entries) {
      final durations = entry.value.map((m) => m.duration).toList();
      durations.sort();

      summary[entry.key] = {
        'count': durations.length,
        'average': durations.reduce((a, b) => a + b) / durations.length,
        'median': durations[durations.length ~/ 2],
        'min': durations.first,
        'max': durations.last,
        'p95': durations[(durations.length * 0.95).floor()],
      };
    }

    return summary;
  }

  void clearMetrics() {
    _metrics.clear();
  }
}

class PerformanceMetric {
  final String operation;
  final int duration;
  final DateTime timestamp;
  final Map<String, dynamic>? metadata;

  PerformanceMetric({
    required this.operation,
    required this.duration,
    required this.timestamp,
    this.metadata,
  });

  Map<String, dynamic> toJson() => {
        'operation': operation,
        'duration': duration,
        'timestamp': timestamp.toIso8601String(),
        'metadata': metadata,
      };
}
