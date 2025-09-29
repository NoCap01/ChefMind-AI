import 'dart:async';
import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Memory optimizer to prevent memory leaks and optimize memory usage
class MemoryOptimizer {
  static final MemoryOptimizer _instance = MemoryOptimizer._internal();
  factory MemoryOptimizer() => _instance;
  MemoryOptimizer._internal();

  final Set<StreamSubscription> _subscriptions = {};
  final Set<Timer> _timers = {};
  final Set<ChangeNotifier> _notifiers = {};
  final Map<String, WeakReference<Object>> _weakReferences = {};

  /// Register a subscription for automatic cleanup
  void registerSubscription(StreamSubscription subscription) {
    _subscriptions.add(subscription);
  }

  /// Register a timer for automatic cleanup
  void registerTimer(Timer timer) {
    _timers.add(timer);
  }

  /// Register a notifier for automatic cleanup
  void registerNotifier(ChangeNotifier notifier) {
    _notifiers.add(notifier);
  }

  /// Store weak reference to prevent memory leaks
  void storeWeakReference(String key, Object object) {
    _weakReferences[key] = WeakReference(object);
  }

  /// Get object from weak reference
  T? getWeakReference<T>(String key) {
    final ref = _weakReferences[key];
    return ref?.target as T?;
  }

  /// Clean up all registered resources
  void cleanup() {
    // Cancel all subscriptions
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }
    _subscriptions.clear();

    // Cancel all timers
    for (final timer in _timers) {
      timer.cancel();
    }
    _timers.clear();

    // Dispose all notifiers
    for (final notifier in _notifiers) {
      notifier.dispose();
    }
    _notifiers.clear();

    // Clear weak references
    _weakReferences.clear();
  }

  /// Clean up expired weak references
  void cleanupExpiredReferences() {
    _weakReferences.removeWhere((key, ref) => ref.target == null);
  }

  /// Get memory usage statistics
  Map<String, int> getMemoryStats() {
    return {
      'subscriptions': _subscriptions.length,
      'timers': _timers.length,
      'notifiers': _notifiers.length,
      'weakReferences': _weakReferences.length,
    };
  }
}

/// Mixin for automatic memory management
mixin MemoryOptimizedMixin<T extends StatefulWidget> on State<T> {
  final MemoryOptimizer _memoryOptimizer = MemoryOptimizer();
  final List<StreamSubscription> _localSubscriptions = [];
  final List<Timer> _localTimers = [];
  final List<ChangeNotifier> _localNotifiers = [];

  /// Register subscription with automatic cleanup
  void addSubscription(StreamSubscription subscription) {
    _localSubscriptions.add(subscription);
    _memoryOptimizer.registerSubscription(subscription);
  }

  /// Register timer with automatic cleanup
  void addTimer(Timer timer) {
    _localTimers.add(timer);
    _memoryOptimizer.registerTimer(timer);
  }

  /// Register notifier with automatic cleanup
  void addNotifier(ChangeNotifier notifier) {
    _localNotifiers.add(notifier);
    _memoryOptimizer.registerNotifier(notifier);
  }

  @override
  void dispose() {
    // Clean up local resources
    for (final subscription in _localSubscriptions) {
      subscription.cancel();
    }
    for (final timer in _localTimers) {
      timer.cancel();
    }
    for (final notifier in _localNotifiers) {
      notifier.dispose();
    }

    _localSubscriptions.clear();
    _localTimers.clear();
    _localNotifiers.clear();

    super.dispose();
  }
}

/// Memory-efficient image cache
class OptimizedImageCache {
  static const int _maxCacheSize = 50 * 1024 * 1024; // 50MB
  static const int _maxCacheItems = 100;

  final Map<String, Uint8List> _cache = {};
  final Map<String, DateTime> _accessTimes = {};
  int _currentCacheSize = 0;

  /// Cache image data
  void cacheImage(String key, Uint8List data) {
    if (data.length > _maxCacheSize ~/ 4) {
      // Don't cache very large images
      return;
    }

    _enforceMaxCacheSize();

    _cache[key] = data;
    _accessTimes[key] = DateTime.now();
    _currentCacheSize += data.length;
  }

  /// Get cached image data
  Uint8List? getCachedImage(String key) {
    final data = _cache[key];
    if (data != null) {
      _accessTimes[key] = DateTime.now(); // Update access time
    }
    return data;
  }

  /// Enforce cache size limits
  void _enforceMaxCacheSize() {
    while (
        _currentCacheSize > _maxCacheSize || _cache.length > _maxCacheItems) {
      // Remove least recently used item
      final oldestEntry = _accessTimes.entries
          .reduce((a, b) => a.value.isBefore(b.value) ? a : b);

      final data = _cache.remove(oldestEntry.key);
      _accessTimes.remove(oldestEntry.key);

      if (data != null) {
        _currentCacheSize -= data.length;
      }
    }
  }

  /// Clear cache
  void clear() {
    _cache.clear();
    _accessTimes.clear();
    _currentCacheSize = 0;
  }

  /// Get cache statistics
  Map<String, dynamic> getStats() {
    return {
      'itemCount': _cache.length,
      'sizeBytes': _currentCacheSize,
      'sizeMB': (_currentCacheSize / (1024 * 1024)).toStringAsFixed(2),
      'maxSizeMB': (_maxCacheSize / (1024 * 1024)).toStringAsFixed(2),
    };
  }
}

/// Memory-efficient list widget
class MemoryOptimizedListView<T> extends StatefulWidget {
  final List<T> items;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final ScrollController? controller;
  final int visibleItemsBuffer;
  final double? itemHeight;

  const MemoryOptimizedListView({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.controller,
    this.visibleItemsBuffer = 5,
    this.itemHeight,
  });

  @override
  State<MemoryOptimizedListView<T>> createState() =>
      _MemoryOptimizedListViewState<T>();
}

class _MemoryOptimizedListViewState<T> extends State<MemoryOptimizedListView<T>>
    with MemoryOptimizedMixin {
  late ScrollController _scrollController;
  final Map<int, Widget> _builtWidgets = {};
  int _firstVisibleIndex = 0;
  int _lastVisibleIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.controller ?? ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (widget.itemHeight == null) return;

    final scrollOffset = _scrollController.offset;
    final viewportHeight = _scrollController.position.viewportDimension;

    _firstVisibleIndex =
        (scrollOffset / widget.itemHeight!).floor() - widget.visibleItemsBuffer;
    _lastVisibleIndex =
        ((scrollOffset + viewportHeight) / widget.itemHeight!).ceil() +
            widget.visibleItemsBuffer;

    _firstVisibleIndex = _firstVisibleIndex.clamp(0, widget.items.length - 1);
    _lastVisibleIndex = _lastVisibleIndex.clamp(0, widget.items.length - 1);

    // Clean up widgets outside visible range
    _builtWidgets.removeWhere((index, widget) =>
        index < _firstVisibleIndex || index > _lastVisibleIndex);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: widget.items.length,
      itemExtent: widget.itemHeight,
      itemBuilder: (context, index) {
        // Use cached widget if available and in visible range
        if (_builtWidgets.containsKey(index) &&
            index >= _firstVisibleIndex &&
            index <= _lastVisibleIndex) {
          return _builtWidgets[index]!;
        }

        // Build new widget only if in visible range
        if (index >= _firstVisibleIndex && index <= _lastVisibleIndex) {
          final widget =
              this.widget.itemBuilder(context, this.widget.items[index], index);
          _builtWidgets[index] = widget;
          return widget;
        }

        // Return empty container for non-visible items
        return SizedBox(height: widget.itemHeight);
      },
    );
  }

  @override
  void dispose() {
    _builtWidgets.clear();
    if (widget.controller == null) {
      _scrollController.dispose();
    }
    super.dispose();
  }
}

/// Utility for monitoring memory usage
class MemoryMonitor {
  static Timer? _monitorTimer;
  static final List<int> _memoryHistory = [];
  static const int _maxHistorySize = 100;

  /// Start monitoring memory usage
  static void startMonitoring(
      {Duration interval = const Duration(seconds: 30)}) {
    _monitorTimer?.cancel();
    _monitorTimer = Timer.periodic(interval, (timer) {
      _recordMemoryUsage();
    });
  }

  /// Stop monitoring
  static void stopMonitoring() {
    _monitorTimer?.cancel();
    _monitorTimer = null;
  }

  /// Record current memory usage
  static void _recordMemoryUsage() {
    // This would need platform-specific implementation
    // For now, we'll just maintain the structure
    final memoryUsage = 0; // Placeholder

    _memoryHistory.add(memoryUsage);
    if (_memoryHistory.length > _maxHistorySize) {
      _memoryHistory.removeAt(0);
    }

    if (kDebugMode && memoryUsage > 0) {
      debugPrint(
          'Memory usage: ${(memoryUsage / (1024 * 1024)).toStringAsFixed(2)} MB');
    }
  }

  /// Get memory usage statistics
  static Map<String, dynamic> getMemoryStats() {
    if (_memoryHistory.isEmpty) {
      return {'message': 'No memory data available'};
    }

    final current = _memoryHistory.last;
    final average =
        _memoryHistory.reduce((a, b) => a + b) / _memoryHistory.length;
    final max = _memoryHistory.reduce((a, b) => a > b ? a : b);
    final min = _memoryHistory.reduce((a, b) => a < b ? a : b);

    return {
      'currentMB': (current / (1024 * 1024)).toStringAsFixed(2),
      'averageMB': (average / (1024 * 1024)).toStringAsFixed(2),
      'maxMB': (max / (1024 * 1024)).toStringAsFixed(2),
      'minMB': (min / (1024 * 1024)).toStringAsFixed(2),
      'samples': _memoryHistory.length,
    };
  }
}
