import 'dart:async';
import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PerformanceOptimizer {
  static final PerformanceOptimizer _instance =
      PerformanceOptimizer._internal();
  factory PerformanceOptimizer() => _instance;
  PerformanceOptimizer._internal();

  // Debouncing for search and input operations
  final Map<String, Timer> _debounceTimers = {};

  void debounce(String key, Duration delay, VoidCallback callback) {
    _debounceTimers[key]?.cancel();
    _debounceTimers[key] = Timer(delay, callback);
  }

  // Throttling for scroll and gesture operations
  final Map<String, DateTime> _lastThrottleTime = {};

  bool shouldThrottle(String key, Duration throttleDuration) {
    final now = DateTime.now();
    final lastTime = _lastThrottleTime[key];

    if (lastTime == null || now.difference(lastTime) >= throttleDuration) {
      _lastThrottleTime[key] = now;
      return false;
    }
    return true;
  }

  // Memory-efficient list management
  static const int maxListSize = 1000;

  List<T> optimizeList<T>(List<T> list) {
    if (list.length <= maxListSize) return list;

    // Keep most recent items
    return list.sublist(list.length - maxListSize);
  }

  // Image loading optimization
  Widget optimizedImage(
    String imageUrl, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    Widget? placeholder,
    Widget? errorWidget,
  }) {
    return Image.network(
      imageUrl,
      width: width,
      height: height,
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return placeholder ?? const CircularProgressIndicator();
      },
      errorBuilder: (context, error, stackTrace) {
        return errorWidget ?? const Icon(Icons.error);
      },
      // Optimize memory usage
      cacheWidth: width?.toInt(),
      cacheHeight: height?.toInt(),
    );
  }

  // Lazy loading helper
  Widget lazyBuilder({
    required IndexedWidgetBuilder itemBuilder,
    required int itemCount,
    ScrollController? controller,
    Axis scrollDirection = Axis.vertical,
  }) {
    return ListView.builder(
      controller: controller,
      scrollDirection: scrollDirection,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        // Add performance monitoring
        return _PerformanceWrapper(
          key: ValueKey('item_$index'),
          child: itemBuilder(context, index),
        );
      },
      // Optimize for performance
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: true,
      addSemanticIndexes: true,
    );
  }

  // State management optimization
  bool shouldRebuild<T>(T oldValue, T newValue) {
    if (oldValue == newValue) return false;

    // For collections, do deep comparison only if necessary
    if (oldValue is List && newValue is List) {
      return !listEquals(oldValue, newValue);
    }

    if (oldValue is Map && newValue is Map) {
      return !mapEquals(oldValue, newValue);
    }

    return true;
  }

  // Batch operations for better performance
  Future<List<T>> batchProcess<T, R>(
    List<T> items,
    Future<R> Function(T) processor, {
    int batchSize = 10,
    Duration delay = const Duration(milliseconds: 10),
  }) async {
    final results = <T>[];

    for (int i = 0; i < items.length; i += batchSize) {
      final batch = items.sublist(
        i,
        (i + batchSize > items.length) ? items.length : i + batchSize,
      );

      // Process batch
      for (final item in batch) {
        await processor(item);
        results.add(item);
      }

      // Small delay to prevent blocking UI
      if (i + batchSize < items.length) {
        await Future.delayed(delay);
      }
    }

    return results;
  }

  // Memory cleanup
  void cleanup() {
    for (final timer in _debounceTimers.values) {
      timer.cancel();
    }
    _debounceTimers.clear();
    _lastThrottleTime.clear();
  }

  // Performance monitoring widget
  Widget performanceWrapper({
    required Widget child,
    String? name,
  }) {
    return _PerformanceWrapper(
      name: name,
      child: child,
    );
  }
}

class _PerformanceWrapper extends StatefulWidget {
  final Widget child;
  final String? name;

  const _PerformanceWrapper({
    super.key,
    required this.child,
    this.name,
  });

  @override
  State<_PerformanceWrapper> createState() => _PerformanceWrapperState();
}

class _PerformanceWrapperState extends State<_PerformanceWrapper> {
  late final Stopwatch _buildStopwatch;
  int _buildCount = 0;

  @override
  void initState() {
    super.initState();
    _buildStopwatch = Stopwatch();
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      _buildStopwatch.start();
      _buildCount++;
    }

    final child = widget.child;

    if (kDebugMode) {
      _buildStopwatch.stop();

      if (_buildStopwatch.elapsedMilliseconds > 16) {
        // More than one frame
        print(
            'Performance Warning: ${widget.name ?? 'Widget'} took ${_buildStopwatch.elapsedMilliseconds}ms to build (build #$_buildCount)');
      }

      _buildStopwatch.reset();
    }

    return child;
  }
}

// Mixin for optimized state management
mixin PerformanceOptimizedState<T extends StatefulWidget> on State<T> {
  final PerformanceOptimizer _optimizer = PerformanceOptimizer();

  @override
  void dispose() {
    _optimizer.cleanup();
    super.dispose();
  }

  void debounce(String key, Duration delay, VoidCallback callback) {
    _optimizer.debounce(key, delay, callback);
  }

  bool shouldThrottle(String key, Duration throttleDuration) {
    return _optimizer.shouldThrottle(key, throttleDuration);
  }
}

// Performance-optimized ListView
class OptimizedListView extends StatelessWidget {
  final List<Widget> children;
  final ScrollController? controller;
  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  const OptimizedListView({
    super.key,
    required this.children,
    this.controller,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller,
      scrollDirection: scrollDirection,
      shrinkWrap: shrinkWrap,
      physics: physics,
      itemCount: children.length,
      itemBuilder: (context, index) {
        return RepaintBoundary(
          child: children[index],
        );
      },
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: false, // We're adding them manually
      addSemanticIndexes: true,
    );
  }
}
