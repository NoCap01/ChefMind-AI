import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Manager for implementing lazy loading strategies across the app
class LazyLoadingManager {
  static const int _defaultPageSize = 20;
  static const int _preloadThreshold = 5;

  /// Lazy load items with pagination
  static Stream<List<T>> lazyLoadItems<T>({
    required Future<List<T>> Function(int offset, int limit) loadFunction,
    int pageSize = _defaultPageSize,
    int preloadThreshold = _preloadThreshold,
  }) async* {
    final List<T> allItems = [];
    int currentOffset = 0;
    bool hasMore = true;

    while (hasMore) {
      try {
        final newItems = await loadFunction(currentOffset, pageSize);

        if (newItems.isEmpty || newItems.length < pageSize) {
          hasMore = false;
        }

        allItems.addAll(newItems);
        currentOffset += newItems.length;

        yield List.from(allItems);

        // If we're close to the end, preload more
        if (hasMore && allItems.length - currentOffset <= preloadThreshold) {
          continue;
        } else {
          break;
        }
      } catch (e) {
        debugPrint('LazyLoadingManager error: $e');
        hasMore = false;
        yield List.from(allItems);
      }
    }
  }

  /// Create a paginated controller for infinite scrolling
  static PaginatedController<T> createPaginatedController<T>({
    required Future<List<T>> Function(int offset, int limit) loadFunction,
    int pageSize = _defaultPageSize,
  }) {
    return PaginatedController<T>(
      loadFunction: loadFunction,
      pageSize: pageSize,
    );
  }
}

/// Controller for paginated data loading
class PaginatedController<T> extends ChangeNotifier {
  final Future<List<T>> Function(int offset, int limit) loadFunction;
  final int pageSize;

  PaginatedController({
    required this.loadFunction,
    this.pageSize = LazyLoadingManager._defaultPageSize,
  });

  final List<T> _items = [];
  bool _isLoading = false;
  bool _hasMore = true;
  String? _error;

  List<T> get items => List.unmodifiable(_items);
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;
  String? get error => _error;
  bool get isEmpty => _items.isEmpty && !_isLoading;

  /// Load the first page
  Future<void> loadInitial() async {
    if (_isLoading) return;

    _isLoading = true;
    _error = null;
    _items.clear();
    notifyListeners();

    try {
      final newItems = await loadFunction(0, pageSize);
      _items.addAll(newItems);
      _hasMore = newItems.length == pageSize;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Load the next page
  Future<void> loadMore() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final newItems = await loadFunction(_items.length, pageSize);
      _items.addAll(newItems);
      _hasMore = newItems.length == pageSize;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Refresh all data
  Future<void> refresh() async {
    _hasMore = true;
    await loadInitial();
  }

  /// Check if we should load more items based on scroll position
  bool shouldLoadMore(int currentIndex) {
    return currentIndex >= _items.length - LazyLoadingManager._preloadThreshold;
  }
}

/// Mixin for widgets that need lazy loading functionality
mixin LazyLoadingMixin<T extends StatefulWidget> on State<T> {
  PaginatedController? _controller;

  PaginatedController<E> createLazyController<E>({
    required Future<List<E>> Function(int offset, int limit) loadFunction,
    int pageSize = LazyLoadingManager._defaultPageSize,
  }) {
    _controller?.dispose();
    _controller = LazyLoadingManager.createPaginatedController<E>(
      loadFunction: loadFunction,
      pageSize: pageSize,
    );
    return _controller as PaginatedController<E>;
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
