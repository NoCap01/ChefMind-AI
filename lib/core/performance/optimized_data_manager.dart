import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../domain/entities/recipe.dart';

/// Optimized data manager with caching, pagination, and efficient search
class OptimizedDataManager<T> {
  final Map<String, T> _cache = {};
  final Map<String, DateTime> _cacheTimestamps = {};
  final Map<String, List<T>> _paginatedCache = {};
  final Duration _cacheExpiry;
  final int _maxCacheSize;

  // Search index for O(1) lookups
  final Map<String, Set<String>> _searchIndex = {};
  final Map<String, Set<String>> _tagIndex = {};

  OptimizedDataManager({
    Duration cacheExpiry = const Duration(minutes: 30),
    int maxCacheSize = 1000,
  })  : _cacheExpiry = cacheExpiry,
        _maxCacheSize = maxCacheSize;

  /// Get item by ID with O(1) complexity
  T? getById(String id) {
    if (_isExpired(id)) {
      _cache.remove(id);
      _cacheTimestamps.remove(id);
      return null;
    }
    return _cache[id];
  }

  /// Cache item with automatic cleanup
  void cache(String id, T item) {
    _enforceMaxCacheSize();
    _cache[id] = item;
    _cacheTimestamps[id] = DateTime.now();
    _updateSearchIndex(id, item);
  }

  /// Batch cache multiple items efficiently
  void batchCache(Map<String, T> items) {
    for (final entry in items.entries) {
      cache(entry.key, entry.value);
    }
  }

  /// Get paginated data with O(1) complexity for cached pages
  List<T>? getPaginatedData(String key, int page, int pageSize) {
    final cacheKey = '${key}_${page}_$pageSize';
    if (_paginatedCache.containsKey(cacheKey)) {
      return _paginatedCache[cacheKey];
    }
    return null;
  }

  /// Cache paginated data
  void cachePaginatedData(String key, int page, int pageSize, List<T> data) {
    final cacheKey = '${key}_${page}_$pageSize';
    _paginatedCache[cacheKey] = data;
  }

  /// Efficient search using pre-built index - O(1) for exact matches
  Set<String> searchByIndex(String query) {
    final lowerQuery = query.toLowerCase();
    return _searchIndex[lowerQuery] ?? {};
  }

  /// Search by tags with O(1) complexity
  Set<String> searchByTags(List<String> tags) {
    if (tags.isEmpty) return {};

    Set<String>? result;
    for (final tag in tags) {
      final tagResults = _tagIndex[tag.toLowerCase()] ?? {};
      if (result == null) {
        result = Set.from(tagResults);
      } else {
        result = result.intersection(tagResults);
      }
    }
    return result ?? {};
  }

  /// Update search index for efficient searching
  void _updateSearchIndex(String id, T item) {
    // This should be overridden by specific implementations
    // to build appropriate search indices
  }

  /// Check if cache entry is expired
  bool _isExpired(String id) {
    final timestamp = _cacheTimestamps[id];
    if (timestamp == null) return true;
    return DateTime.now().difference(timestamp) > _cacheExpiry;
  }

  /// Enforce maximum cache size using LRU eviction
  void _enforceMaxCacheSize() {
    if (_cache.length >= _maxCacheSize) {
      // Remove oldest entries (LRU)
      final sortedEntries = _cacheTimestamps.entries.toList()
        ..sort((a, b) => a.value.compareTo(b.value));

      final toRemove = sortedEntries.take(_maxCacheSize ~/ 4).map((e) => e.key);
      for (final key in toRemove) {
        _cache.remove(key);
        _cacheTimestamps.remove(key);
        _removeFromSearchIndex(key);
      }
    }
  }

  /// Remove item from search index
  void _removeFromSearchIndex(String id) {
    for (final set in _searchIndex.values) {
      set.remove(id);
    }
    for (final set in _tagIndex.values) {
      set.remove(id);
    }
  }

  /// Clear all caches
  void clearCache() {
    _cache.clear();
    _cacheTimestamps.clear();
    _paginatedCache.clear();
    _searchIndex.clear();
    _tagIndex.clear();
  }

  /// Get cache statistics
  Map<String, dynamic> getCacheStats() {
    return {
      'cacheSize': _cache.length,
      'paginatedCacheSize': _paginatedCache.length,
      'searchIndexSize': _searchIndex.length,
      'tagIndexSize': _tagIndex.length,
      'maxCacheSize': _maxCacheSize,
    };
  }
}

/// Specialized data manager for recipes
class RecipeDataManager extends OptimizedDataManager<Recipe> {
  RecipeDataManager()
      : super(
          cacheExpiry: const Duration(hours: 2),
          maxCacheSize: 500,
        );

  @override
  void _updateSearchIndex(String id, Recipe item) {
    final recipe = item;
    try {
      // Index by title
      final title = recipe.title.toLowerCase();
      if (title.isNotEmpty) {
        _addToIndex(_searchIndex, title, id);
        // Also index individual words
        for (final word in title.split(' ')) {
          if (word.length > 2) {
            _addToIndex(_searchIndex, word, id);
          }
        }
      }

      // Index by ingredients
      for (final ingredient in recipe.ingredients) {
        final name = ingredient.name.toLowerCase();
        if (name.isNotEmpty) {
          _addToIndex(_searchIndex, name, id);
        }
      }

      // Index by tags
      for (final tag in recipe.tags) {
        final tagStr = tag.toLowerCase();
        _addToIndex(_tagIndex, tagStr, id);
      }

      // Index by cuisine
      final cuisine = recipe.metadata.cuisine?.toLowerCase() ?? '';
      if (cuisine.isNotEmpty) {
        _addToIndex(_searchIndex, cuisine, id);
      }
    } catch (e) {
      debugPrint('Error updating search index: $e');
    }
  }

  void _addToIndex(Map<String, Set<String>> index, String key, String id) {
    index.putIfAbsent(key, () => <String>{}).add(id);
  }
}

/// Memory-efficient pagination controller
class OptimizedPaginationController<T> extends ChangeNotifier {
  final Future<List<T>> Function(int offset, int limit) _loadFunction;
  final int _pageSize;
  final OptimizedDataManager<T>? _dataManager;

  final List<T> _items = [];
  final Set<int> _loadedPages = {};
  bool _isLoading = false;
  bool _hasMore = true;
  String? _error;

  OptimizedPaginationController({
    required Future<List<T>> Function(int offset, int limit) loadFunction,
    int pageSize = 20,
    OptimizedDataManager<T>? dataManager,
  })  : _loadFunction = loadFunction,
        _pageSize = pageSize,
        _dataManager = dataManager;

  List<T> get items => List.unmodifiable(_items);
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;
  String? get error => _error;
  int get totalItems => _items.length;

  /// Load specific page with caching
  Future<void> loadPage(int page) async {
    if (_loadedPages.contains(page) || _isLoading) return;

    // Check cache first
    final cachedData = _dataManager?.getPaginatedData('items', page, _pageSize);
    if (cachedData != null) {
      _insertPageData(page, cachedData);
      return;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final offset = page * _pageSize;
      final newItems = await _loadFunction(offset, _pageSize);

      // Cache the data
      _dataManager?.cachePaginatedData('items', page, _pageSize, newItems);

      _insertPageData(page, newItems);
      _loadedPages.add(page);

      if (newItems.length < _pageSize) {
        _hasMore = false;
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Insert page data at correct position
  void _insertPageData(int page, List<T> pageData) {
    final startIndex = page * _pageSize;

    // Extend list if necessary
    while (_items.length < startIndex) {
      _items.add(null as T); // Placeholder
    }

    // Insert or replace data
    for (int i = 0; i < pageData.length; i++) {
      final index = startIndex + i;
      if (index < _items.length) {
        _items[index] = pageData[i];
      } else {
        _items.add(pageData[i]);
      }
    }
  }

  /// Load initial data
  Future<void> loadInitial() async {
    _items.clear();
    _loadedPages.clear();
    _hasMore = true;
    await loadPage(0);
  }

  /// Load more data (next page)
  Future<void> loadMore() async {
    if (!_hasMore || _isLoading) return;

    final nextPage = _loadedPages.isEmpty ? 0 : _loadedPages.length;
    await loadPage(nextPage);
  }

  /// Refresh all data
  Future<void> refresh() async {
    _dataManager?.clearCache();
    _items.clear();
    _loadedPages.clear();
    _hasMore = true;
    await loadInitial();
  }

  /// Preload next page for smooth scrolling
  void preloadNext() {
    if (_hasMore && !_isLoading) {
      final nextPage = _loadedPages.length;
      loadPage(nextPage);
    }
  }

  /// Check if we should load more items based on scroll position
  bool shouldLoadMore(int currentIndex) {
    return currentIndex >= _items.length - 5 && _hasMore && !_isLoading;
  }

  @override
  void dispose() {
    _dataManager?.clearCache();
    super.dispose();
  }
}
