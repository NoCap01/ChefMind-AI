import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Optimized state management utilities to reduce unnecessary rebuilds
class StateOptimization {
  /// Create a debounced provider that only updates after a delay
  static StateNotifierProvider<DebouncedNotifier<T>, T> debouncedProvider<T>(
    T initialValue, {
    Duration delay = const Duration(milliseconds: 300),
  }) {
    return StateNotifierProvider<DebouncedNotifier<T>, T>(
      (ref) => DebouncedNotifier<T>(initialValue, delay: delay),
    );
  }

  /// Create a throttled provider that limits update frequency
  static StateNotifierProvider<ThrottledNotifier<T>, T> throttledProvider<T>(
    T initialValue, {
    Duration throttleDuration = const Duration(milliseconds: 100),
  }) {
    return StateNotifierProvider<ThrottledNotifier<T>, T>(
      (ref) => ThrottledNotifier<T>(initialValue,
          throttleDuration: throttleDuration),
    );
  }

  /// Create a memoized provider that caches results
  static Provider<T> memoizedProvider<T>(
    T Function() compute, {
    List<Object?> dependencies = const [],
  }) {
    return Provider<T>((ref) {
      // Watch dependencies to invalidate cache when they change
      for (final dep in dependencies) {
        if (dep is ProviderBase) {
          ref.watch(dep);
        }
      }
      return compute();
    });
  }
}

/// Debounced state notifier that delays updates
class DebouncedNotifier<T> extends StateNotifier<T> {
  final Duration delay;
  Timer? _debounceTimer;

  DebouncedNotifier(super.initialState,
      {this.delay = const Duration(milliseconds: 300)});

  void updateDebounced(T newState) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(delay, () {
      if (mounted) {
        state = newState;
      }
    });
  }

  void updateImmediate(T newState) {
    _debounceTimer?.cancel();
    state = newState;
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}

/// Throttled state notifier that limits update frequency
class ThrottledNotifier<T> extends StateNotifier<T> {
  final Duration throttleDuration;
  DateTime? _lastUpdate;
  Timer? _throttleTimer;
  T? _pendingState;

  ThrottledNotifier(super.initialState,
      {this.throttleDuration = const Duration(milliseconds: 100)});

  void updateThrottled(T newState) {
    final now = DateTime.now();

    if (_lastUpdate == null ||
        now.difference(_lastUpdate!) >= throttleDuration) {
      // Update immediately
      state = newState;
      _lastUpdate = now;
      _pendingState = null;
    } else {
      // Schedule update
      _pendingState = newState;
      _throttleTimer?.cancel();

      final remainingTime = throttleDuration - now.difference(_lastUpdate!);
      _throttleTimer = Timer(remainingTime, () {
        if (mounted && _pendingState != null) {
          state = _pendingState as T;
          _lastUpdate = DateTime.now();
          _pendingState = null;
        }
      });
    }
  }

  void updateImmediate(T newState) {
    _throttleTimer?.cancel();
    _pendingState = null;
    state = newState;
    _lastUpdate = DateTime.now();
  }

  @override
  void dispose() {
    _throttleTimer?.cancel();
    super.dispose();
  }
}

/// Mixin for widgets that need performance optimizations
mixin PerformanceOptimizationMixin<T extends StatefulWidget> on State<T> {
  final Map<String, dynamic> _memoizedResults = {};
  final Map<String, List<Object?>> _memoizedDependencies = {};

  /// Memoize expensive computations
  R memoize<R>(String key, R Function() computation,
      [List<Object?> dependencies = const []]) {
    final currentDeps = _memoizedDependencies[key];

    // Check if dependencies have changed
    if (currentDeps == null || !listEquals(currentDeps, dependencies)) {
      _memoizedResults[key] = computation();
      _memoizedDependencies[key] = List.from(dependencies);
    }

    return _memoizedResults[key] as R;
  }

  /// Clear memoized results
  void clearMemoization([String? key]) {
    if (key != null) {
      _memoizedResults.remove(key);
      _memoizedDependencies.remove(key);
    } else {
      _memoizedResults.clear();
      _memoizedDependencies.clear();
    }
  }

  @override
  void dispose() {
    _memoizedResults.clear();
    _memoizedDependencies.clear();
    super.dispose();
  }
}

/// Optimized list view that only builds visible items
class OptimizedListView<T> extends StatefulWidget {
  final List<T> items;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final double? itemHeight;
  final EdgeInsets? padding;
  final ScrollController? controller;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final void Function(int index)? onItemVisible;

  const OptimizedListView({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.itemHeight,
    this.padding,
    this.controller,
    this.shrinkWrap = false,
    this.physics,
    this.onItemVisible,
  });

  @override
  State<OptimizedListView<T>> createState() => _OptimizedListViewState<T>();
}

class _OptimizedListViewState<T> extends State<OptimizedListView<T>> {
  late ScrollController _scrollController;
  final Set<int> _visibleItems = {};

  @override
  void initState() {
    super.initState();
    _scrollController = widget.controller ?? ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _scrollController.dispose();
    } else {
      _scrollController.removeListener(_onScroll);
    }
    super.dispose();
  }

  void _onScroll() {
    if (widget.onItemVisible == null || widget.itemHeight == null) return;

    final scrollOffset = _scrollController.offset;
    final viewportHeight = _scrollController.position.viewportDimension;

    final firstVisibleIndex = (scrollOffset / widget.itemHeight!).floor();
    final lastVisibleIndex =
        ((scrollOffset + viewportHeight) / widget.itemHeight!).ceil();

    for (int i = firstVisibleIndex;
        i <= lastVisibleIndex && i < widget.items.length;
        i++) {
      if (i >= 0 && !_visibleItems.contains(i)) {
        _visibleItems.add(i);
        widget.onItemVisible!(i);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.itemHeight != null) {
      return ListView.builder(
        controller: _scrollController,
        padding: widget.padding,
        shrinkWrap: widget.shrinkWrap,
        physics: widget.physics,
        itemCount: widget.items.length,
        itemExtent: widget.itemHeight,
        itemBuilder: (context, index) {
          return widget.itemBuilder(context, widget.items[index], index);
        },
      );
    }

    return ListView.builder(
      controller: _scrollController,
      padding: widget.padding,
      shrinkWrap: widget.shrinkWrap,
      physics: widget.physics,
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        return widget.itemBuilder(context, widget.items[index], index);
      },
    );
  }
}

/// Widget that rebuilds only when specific dependencies change
class SelectiveBuilder extends StatefulWidget {
  final Widget Function(BuildContext context) builder;
  final List<Listenable> dependencies;

  const SelectiveBuilder({
    super.key,
    required this.builder,
    required this.dependencies,
  });

  @override
  State<SelectiveBuilder> createState() => _SelectiveBuilderState();
}

class _SelectiveBuilderState extends State<SelectiveBuilder> {
  @override
  void initState() {
    super.initState();
    for (final dependency in widget.dependencies) {
      dependency.addListener(_onDependencyChanged);
    }
  }

  @override
  void dispose() {
    for (final dependency in widget.dependencies) {
      dependency.removeListener(_onDependencyChanged);
    }
    super.dispose();
  }

  void _onDependencyChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }
}

/// Performance monitoring widget
class PerformanceMonitor extends StatefulWidget {
  final Widget child;
  final String? name;
  final void Function(Duration buildTime)? onBuildComplete;

  const PerformanceMonitor({
    super.key,
    required this.child,
    this.name,
    this.onBuildComplete,
  });

  @override
  State<PerformanceMonitor> createState() => _PerformanceMonitorState();
}

class _PerformanceMonitorState extends State<PerformanceMonitor> {
  late Stopwatch _stopwatch;

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch()..start();
  }

  @override
  Widget build(BuildContext context) {
    _stopwatch.reset();
    _stopwatch.start();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _stopwatch.stop();
      final buildTime = _stopwatch.elapsed;

      if (kDebugMode) {
        final name = widget.name ?? 'Widget';
        debugPrint('$name build time: ${buildTime.inMilliseconds}ms');
      }

      widget.onBuildComplete?.call(buildTime);
    });

    return widget.child;
  }
}

/// Utility class for performance measurements
class PerformanceUtils {
  static final Map<String, Stopwatch> _timers = {};

  /// Start timing an operation
  static void startTimer(String name) {
    _timers[name] = Stopwatch()..start();
  }

  /// Stop timing and get duration
  static Duration stopTimer(String name) {
    final timer = _timers.remove(name);
    if (timer != null) {
      timer.stop();
      return timer.elapsed;
    }
    return Duration.zero;
  }

  /// Measure execution time of a function
  static Future<T> measureAsync<T>(
      String name, Future<T> Function() operation) async {
    startTimer(name);
    try {
      final result = await operation();
      final duration = stopTimer(name);
      if (kDebugMode) {
        debugPrint('$name took ${duration.inMilliseconds}ms');
      }
      return result;
    } catch (e) {
      stopTimer(name);
      rethrow;
    }
  }

  /// Measure execution time of a synchronous function
  static T measureSync<T>(String name, T Function() operation) {
    startTimer(name);
    try {
      final result = operation();
      final duration = stopTimer(name);
      if (kDebugMode) {
        debugPrint('$name took ${duration.inMilliseconds}ms');
      }
      return result;
    } catch (e) {
      stopTimer(name);
      rethrow;
    }
  }
}
