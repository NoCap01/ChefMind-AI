import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

/// Specialized image cache manager for recipe images and other app images
class ImageCacheManager {
  static ImageCacheManager? _instance;
  static ImageCacheManager get instance => _instance ??= ImageCacheManager._();

  ImageCacheManager._();

  Directory? _cacheDirectory;
  final Map<String, ImageCacheEntry> _memoryCache = {};
  static const int _maxMemoryCacheSize = 50;
  static const int _maxDiskCacheSize = 100 * 1024 * 1024; // 100MB
  static const Duration _defaultTtl = Duration(days: 7);

  /// Initialize the image cache manager
  Future<void> initialize() async {
    if (_cacheDirectory == null) {
      final appDir = await getApplicationDocumentsDirectory();
      _cacheDirectory = Directory('${appDir.path}/image_cache');
      if (!await _cacheDirectory!.exists()) {
        await _cacheDirectory!.create(recursive: true);
      }
    }
  }

  /// Get cached image or load from network
  Future<ImageProvider?> getImage(
    String url, {
    Duration? ttl,
    Size? targetSize,
  }) async {
    await initialize();

    final cacheKey = _generateCacheKey(url, targetSize);

    // Check memory cache first
    final memoryEntry = _memoryCache[cacheKey];
    if (memoryEntry != null && !memoryEntry.isExpired) {
      return memoryEntry.imageProvider;
    }

    // Check disk cache
    final diskImage = await _getDiskCachedImage(cacheKey);
    if (diskImage != null) {
      _memoryCache[cacheKey] = ImageCacheEntry(
        imageProvider: diskImage,
        timestamp: DateTime.now(),
        ttl: ttl ?? _defaultTtl,
      );
      return diskImage;
    }

    // Load from network and cache
    try {
      final imageProvider = NetworkImage(url);

      // Pre-cache the image
      final imageStream = imageProvider.resolve(const ImageConfiguration());
      final completer = Completer<ImageProvider>();

      imageStream.addListener(ImageStreamListener((info, _) async {
        // Save to disk cache
        await _saveToDiskCache(cacheKey, info.image, ttl ?? _defaultTtl);

        // Add to memory cache
        _memoryCache[cacheKey] = ImageCacheEntry(
          imageProvider: imageProvider,
          timestamp: DateTime.now(),
          ttl: ttl ?? _defaultTtl,
        );

        _cleanupMemoryCache();
        completer.complete(imageProvider);
      }));

      return await completer.future;
    } catch (e) {
      debugPrint('Failed to load image: $e');
      return null;
    }
  }

  /// Preload images for better performance
  Future<void> preloadImages(List<String> urls, {Size? targetSize}) async {
    final futures = urls.map((url) => getImage(url, targetSize: targetSize));
    await Future.wait(futures);
  }

  /// Get optimized image widget with lazy loading
  Widget buildOptimizedImage(
    String? imageUrl, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    Widget? placeholder,
    Widget? errorWidget,
    Duration? cacheTtl,
  }) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return errorWidget ?? _buildDefaultPlaceholder();
    }

    return FutureBuilder<ImageProvider?>(
      future: getImage(
        imageUrl,
        ttl: cacheTtl,
        targetSize:
            width != null && height != null ? Size(width, height) : null,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return placeholder ?? _buildLoadingPlaceholder();
        }

        if (snapshot.hasError || snapshot.data == null) {
          return errorWidget ?? _buildErrorPlaceholder();
        }

        return Image(
          image: snapshot.data!,
          width: width,
          height: height,
          fit: fit,
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
            if (wasSynchronouslyLoaded) return child;

            return AnimatedOpacity(
              opacity: frame == null ? 0 : 1,
              duration: const Duration(milliseconds: 300),
              child: child,
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return errorWidget ?? _buildErrorPlaceholder();
          },
        );
      },
    );
  }

  /// Clear specific image from cache
  Future<void> removeImage(String url, {Size? targetSize}) async {
    await initialize();

    final cacheKey = _generateCacheKey(url, targetSize);

    // Remove from memory cache
    _memoryCache.remove(cacheKey);

    // Remove from disk cache
    final file = File('${_cacheDirectory!.path}/$cacheKey');
    if (await file.exists()) {
      await file.delete();
    }
  }

  /// Clear all cached images
  Future<void> clearCache() async {
    await initialize();

    // Clear memory cache
    _memoryCache.clear();

    // Clear disk cache
    if (await _cacheDirectory!.exists()) {
      await for (final file in _cacheDirectory!.list()) {
        if (file is File) {
          await file.delete();
        }
      }
    }
  }

  /// Get cache size information
  Future<CacheInfo> getCacheInfo() async {
    await initialize();

    int diskSize = 0;
    int fileCount = 0;

    if (await _cacheDirectory!.exists()) {
      await for (final file in _cacheDirectory!.list()) {
        if (file is File) {
          final stat = await file.stat();
          diskSize += stat.size;
          fileCount++;
        }
      }
    }

    return CacheInfo(
      memoryEntries: _memoryCache.length,
      diskEntries: fileCount,
      diskSizeBytes: diskSize,
    );
  }

  /// Cleanup expired entries
  Future<void> cleanup() async {
    await initialize();

    // Cleanup memory cache
    final expiredKeys = _memoryCache.entries
        .where((entry) => entry.value.isExpired)
        .map((entry) => entry.key)
        .toList();

    for (final key in expiredKeys) {
      _memoryCache.remove(key);
    }

    // Cleanup disk cache
    if (await _cacheDirectory!.exists()) {
      await for (final file in _cacheDirectory!.list()) {
        if (file is File) {
          final stat = await file.stat();
          final age = DateTime.now().difference(stat.modified);
          if (age > _defaultTtl) {
            await file.delete();
          }
        }
      }
    }

    // Cleanup if disk cache is too large
    await _cleanupDiskCache();
  }

  /// Private helper methods
  String _generateCacheKey(String url, Size? targetSize) {
    final key = targetSize != null
        ? '${url}_${targetSize.width}x${targetSize.height}'
        : url;
    return md5.convert(utf8.encode(key)).toString();
  }

  Future<ImageProvider?> _getDiskCachedImage(String cacheKey) async {
    final file = File('${_cacheDirectory!.path}/$cacheKey');
    if (await file.exists()) {
      final stat = await file.stat();
      final age = DateTime.now().difference(stat.modified);

      if (age <= _defaultTtl) {
        return FileImage(file);
      } else {
        await file.delete();
      }
    }
    return null;
  }

  Future<void> _saveToDiskCache(
      String cacheKey, ui.Image image, Duration ttl) async {
    try {
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData != null) {
        final file = File('${_cacheDirectory!.path}/$cacheKey');
        await file.writeAsBytes(byteData.buffer.asUint8List());
      }
    } catch (e) {
      debugPrint('Failed to save image to disk cache: $e');
    }
  }

  void _cleanupMemoryCache() {
    if (_memoryCache.length > _maxMemoryCacheSize) {
      final sortedEntries = _memoryCache.entries.toList()
        ..sort((a, b) => a.value.timestamp.compareTo(b.value.timestamp));

      final entriesToRemove =
          sortedEntries.take(_memoryCache.length - _maxMemoryCacheSize);
      for (final entry in entriesToRemove) {
        _memoryCache.remove(entry.key);
      }
    }
  }

  Future<void> _cleanupDiskCache() async {
    final info = await getCacheInfo();
    if (info.diskSizeBytes > _maxDiskCacheSize) {
      final files = <FileSystemEntity>[];
      await for (final file in _cacheDirectory!.list()) {
        if (file is File) {
          files.add(file);
        }
      }

      // Sort by last modified (oldest first)
      files.sort((a, b) {
        final aStat = a.statSync();
        final bStat = b.statSync();
        return aStat.modified.compareTo(bStat.modified);
      });

      int currentSize = info.diskSizeBytes;
      for (final file in files) {
        if (currentSize <= _maxDiskCacheSize * 0.8)
          break; // Keep 80% of max size

        final stat = file.statSync();
        currentSize -= stat.size;
        await file.delete();
      }
    }
  }

  Widget _buildLoadingPlaceholder() {
    return Container(
      color: Colors.grey[300],
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildErrorPlaceholder() {
    return Container(
      color: Colors.grey[300],
      child: const Icon(
        Icons.error_outline,
        color: Colors.grey,
        size: 32,
      ),
    );
  }

  Widget _buildDefaultPlaceholder() {
    return Container(
      color: Colors.grey[300],
      child: const Icon(
        Icons.image_not_supported,
        color: Colors.grey,
        size: 32,
      ),
    );
  }
}

/// Image cache entry
class ImageCacheEntry {
  final ImageProvider imageProvider;
  final DateTime timestamp;
  final Duration ttl;

  ImageCacheEntry({
    required this.imageProvider,
    required this.timestamp,
    required this.ttl,
  });

  bool get isExpired => DateTime.now().isAfter(timestamp.add(ttl));
}

/// Cache information
class CacheInfo {
  final int memoryEntries;
  final int diskEntries;
  final int diskSizeBytes;

  CacheInfo({
    required this.memoryEntries,
    required this.diskEntries,
    required this.diskSizeBytes,
  });

  String get diskSizeFormatted {
    if (diskSizeBytes < 1024) return '${diskSizeBytes}B';
    if (diskSizeBytes < 1024 * 1024)
      return '${(diskSizeBytes / 1024).toStringAsFixed(1)}KB';
    return '${(diskSizeBytes / (1024 * 1024)).toStringAsFixed(1)}MB';
  }

  @override
  String toString() {
    return 'CacheInfo(memory: $memoryEntries, disk: $diskEntries, size: $diskSizeFormatted)';
  }
}
