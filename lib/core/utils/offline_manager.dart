import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

/// Manager for handling offline scenarios and graceful degradation
class OfflineManager {
  static final OfflineManager _instance = OfflineManager._internal();
  factory OfflineManager() => _instance;
  OfflineManager._internal();

  final Connectivity _connectivity = Connectivity();
  final StreamController<bool> _connectivityController =
      StreamController<bool>.broadcast();

  bool _isOnline = true;
  bool _isInitialized = false;
  Timer? _connectivityTimer;

  static const String _offlineDataDirectory = 'offline_data';
  static const String _pendingOperationsFile = 'pending_operations.json';

  /// Stream of connectivity changes
  Stream<bool> get connectivityStream => _connectivityController.stream;

  /// Current connectivity status
  bool get isOnline => _isOnline;

  /// Initialize offline manager
  Future<void> initialize() async {
    if (_isInitialized) return;

    // Check initial connectivity
    await _checkConnectivity();

    // Listen to connectivity changes
    _connectivity.onConnectivityChanged.listen(_onConnectivityChanged);

    // Set up periodic connectivity checks
    _connectivityTimer = Timer.periodic(
      const Duration(seconds: 30),
      (_) => _checkConnectivity(),
    );

    _isInitialized = true;

    if (kDebugMode) {
      print('🌐 OfflineManager initialized. Online: $_isOnline');
    }
  }

  /// Dispose resources
  void dispose() {
    _connectivityTimer?.cancel();
    _connectivityController.close();
  }

  /// Check current connectivity
  Future<void> _checkConnectivity() async {
    try {
      final connectivityResult = await _connectivity.checkConnectivity();
      final wasOnline = _isOnline;

      _isOnline = connectivityResult != ConnectivityResult.none;

      // Additional check with actual network request
      if (_isOnline) {
        _isOnline = await _performConnectivityTest();
      }

      if (wasOnline != _isOnline) {
        _connectivityController.add(_isOnline);

        if (kDebugMode) {
          print('🌐 Connectivity changed: ${_isOnline ? 'Online' : 'Offline'}');
        }

        // Process pending operations when coming back online
        if (_isOnline && !wasOnline) {
          _processPendingOperations();
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print('⚠️ Connectivity check failed: $error');
      }
    }
  }

  /// Handle connectivity changes
  void _onConnectivityChanged(List<ConnectivityResult> results) {
    _checkConnectivity();
  }

  /// Perform actual connectivity test
  Future<bool> _performConnectivityTest() async {
    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 5));
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (error) {
      return false;
    }
  }

  /// Execute operation with offline fallback
  Future<T> executeWithOfflineFallback<T>(
    Future<T> Function() onlineOperation,
    Future<T> Function() offlineOperation, {
    String? operationName,
  }) async {
    if (_isOnline) {
      try {
        return await onlineOperation();
      } catch (error) {
        if (kDebugMode && operationName != null) {
          print(
              '⚠️ Online operation $operationName failed, trying offline fallback');
        }

        // If online operation fails, try offline fallback
        return await offlineOperation();
      }
    } else {
      if (kDebugMode && operationName != null) {
        print('📱 Executing $operationName in offline mode');
      }

      return await offlineOperation();
    }
  }

  /// Cache data for offline use
  Future<void> cacheData(String key, Map<String, dynamic> data) async {
    try {
      final offlineDir = await _getOfflineDataDirectory();
      final cacheFile = File('${offlineDir.path}/$key.json');

      final cacheData = {
        'key': key,
        'data': data,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'version': '1.0',
      };

      await cacheFile.writeAsString(
        const JsonEncoder.withIndent('  ').convert(cacheData),
      );

      if (kDebugMode) {
        print('💾 Cached data for offline use: $key');
      }
    } catch (error) {
      if (kDebugMode) {
        print('⚠️ Failed to cache data: $error');
      }
    }
  }

  /// Retrieve cached data
  Future<Map<String, dynamic>?> getCachedData(String key) async {
    try {
      final offlineDir = await _getOfflineDataDirectory();
      final cacheFile = File('${offlineDir.path}/$key.json');

      if (!await cacheFile.exists()) {
        return null;
      }

      final content = await cacheFile.readAsString();
      final cacheData = jsonDecode(content) as Map<String, dynamic>;

      if (kDebugMode) {
        print('📱 Retrieved cached data: $key');
      }

      return cacheData['data'] as Map<String, dynamic>;
    } catch (error) {
      if (kDebugMode) {
        print('⚠️ Failed to retrieve cached data: $error');
      }
      return null;
    }
  }

  /// Check if cached data exists and is valid
  Future<bool> hasCachedData(String key, {Duration? maxAge}) async {
    try {
      final offlineDir = await _getOfflineDataDirectory();
      final cacheFile = File('${offlineDir.path}/$key.json');

      if (!await cacheFile.exists()) {
        return false;
      }

      if (maxAge != null) {
        final content = await cacheFile.readAsString();
        final cacheData = jsonDecode(content) as Map<String, dynamic>;
        final timestamp = DateTime.fromMillisecondsSinceEpoch(
          cacheData['timestamp'] as int,
        );

        if (DateTime.now().difference(timestamp) > maxAge) {
          return false;
        }
      }

      return true;
    } catch (error) {
      return false;
    }
  }

  /// Queue operation for when online
  Future<void> queuePendingOperation(PendingOperation operation) async {
    try {
      final operations = await _getPendingOperations();
      operations.add(operation);
      await _savePendingOperations(operations);

      if (kDebugMode) {
        print('📝 Queued pending operation: ${operation.type}');
      }
    } catch (error) {
      if (kDebugMode) {
        print('⚠️ Failed to queue pending operation: $error');
      }
    }
  }

  /// Process pending operations when online
  Future<void> _processPendingOperations() async {
    try {
      final operations = await _getPendingOperations();

      if (operations.isEmpty) return;

      if (kDebugMode) {
        print('🔄 Processing ${operations.length} pending operations');
      }

      final processedOperations = <PendingOperation>[];

      for (final operation in operations) {
        try {
          await _executePendingOperation(operation);
          processedOperations.add(operation);

          if (kDebugMode) {
            print('✅ Processed pending operation: ${operation.type}');
          }
        } catch (error) {
          if (kDebugMode) {
            print(
                '❌ Failed to process pending operation: ${operation.type} - $error');
          }

          // Keep failed operations for retry
          if (operation.retryCount < operation.maxRetries) {
            operation.retryCount++;
          } else {
            processedOperations.add(operation); // Remove after max retries
          }
        }
      }

      // Remove processed operations
      operations.removeWhere((op) => processedOperations.contains(op));
      await _savePendingOperations(operations);
    } catch (error) {
      if (kDebugMode) {
        print('⚠️ Failed to process pending operations: $error');
      }
    }
  }

  /// Execute a pending operation
  Future<void> _executePendingOperation(PendingOperation operation) async {
    // This would be implemented based on operation type
    // For now, we'll just simulate processing
    await Future.delayed(const Duration(milliseconds: 100));
  }

  /// Get pending operations
  Future<List<PendingOperation>> _getPendingOperations() async {
    try {
      final offlineDir = await _getOfflineDataDirectory();
      final operationsFile = File('${offlineDir.path}/$_pendingOperationsFile');

      if (!await operationsFile.exists()) {
        return [];
      }

      final content = await operationsFile.readAsString();
      final data = jsonDecode(content) as Map<String, dynamic>;
      final operationsData = data['operations'] as List<dynamic>;

      return operationsData
          .map((op) => PendingOperation.fromJson(op as Map<String, dynamic>))
          .toList();
    } catch (error) {
      if (kDebugMode) {
        print('⚠️ Failed to get pending operations: $error');
      }
      return [];
    }
  }

  /// Save pending operations
  Future<void> _savePendingOperations(List<PendingOperation> operations) async {
    try {
      final offlineDir = await _getOfflineDataDirectory();
      final operationsFile = File('${offlineDir.path}/$_pendingOperationsFile');

      final data = {
        'operations': operations.map((op) => op.toJson()).toList(),
        'lastUpdated': DateTime.now().millisecondsSinceEpoch,
      };

      await operationsFile.writeAsString(
        const JsonEncoder.withIndent('  ').convert(data),
      );
    } catch (error) {
      if (kDebugMode) {
        print('⚠️ Failed to save pending operations: $error');
      }
    }
  }

  /// Get offline data directory
  Future<Directory> _getOfflineDataDirectory() async {
    final appDir = await getApplicationDocumentsDirectory();
    final offlineDir = Directory('${appDir.path}/$_offlineDataDirectory');

    if (!await offlineDir.exists()) {
      await offlineDir.create(recursive: true);
    }

    return offlineDir;
  }

  /// Clear all cached data
  Future<void> clearCache() async {
    try {
      final offlineDir = await _getOfflineDataDirectory();

      if (await offlineDir.exists()) {
        await offlineDir.delete(recursive: true);
        await offlineDir.create(recursive: true);
      }

      if (kDebugMode) {
        print('🗑️ Cleared offline cache');
      }
    } catch (error) {
      if (kDebugMode) {
        print('⚠️ Failed to clear cache: $error');
      }
    }
  }

  /// Get cache statistics
  Future<CacheStatistics> getCacheStatistics() async {
    try {
      final offlineDir = await _getOfflineDataDirectory();

      if (!await offlineDir.exists()) {
        return const CacheStatistics(
          totalFiles: 0,
          totalSize: 0,
          oldestFile: null,
          newestFile: null,
        );
      }

      final files = offlineDir.listSync().whereType<File>().toList();
      int totalSize = 0;
      DateTime? oldestFile;
      DateTime? newestFile;

      for (final file in files) {
        final stat = await file.stat();
        totalSize += stat.size;

        if (oldestFile == null || stat.modified.isBefore(oldestFile)) {
          oldestFile = stat.modified;
        }

        if (newestFile == null || stat.modified.isAfter(newestFile)) {
          newestFile = stat.modified;
        }
      }

      return CacheStatistics(
        totalFiles: files.length,
        totalSize: totalSize,
        oldestFile: oldestFile,
        newestFile: newestFile,
      );
    } catch (error) {
      return const CacheStatistics(
        totalFiles: 0,
        totalSize: 0,
        oldestFile: null,
        newestFile: null,
      );
    }
  }
}

/// Pending operation for offline queue
class PendingOperation {
  PendingOperation({
    required this.id,
    required this.type,
    required this.data,
    required this.timestamp,
    this.retryCount = 0,
    this.maxRetries = 3,
  });

  final String id;
  final String type;
  final Map<String, dynamic> data;
  final DateTime timestamp;
  int retryCount;
  final int maxRetries;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'data': data,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'retryCount': retryCount,
      'maxRetries': maxRetries,
    };
  }

  factory PendingOperation.fromJson(Map<String, dynamic> json) {
    return PendingOperation(
      id: json['id'] as String,
      type: json['type'] as String,
      data: json['data'] as Map<String, dynamic>,
      timestamp: DateTime.fromMillisecondsSinceEpoch(json['timestamp'] as int),
      retryCount: json['retryCount'] as int? ?? 0,
      maxRetries: json['maxRetries'] as int? ?? 3,
    );
  }
}

/// Cache statistics
class CacheStatistics {
  const CacheStatistics({
    required this.totalFiles,
    required this.totalSize,
    required this.oldestFile,
    required this.newestFile,
  });

  final int totalFiles;
  final int totalSize;
  final DateTime? oldestFile;
  final DateTime? newestFile;

  String get formattedSize {
    if (totalSize < 1024) return '${totalSize}B';
    if (totalSize < 1024 * 1024)
      return '${(totalSize / 1024).toStringAsFixed(1)}KB';
    return '${(totalSize / (1024 * 1024)).toStringAsFixed(1)}MB';
  }
}

/// Mixin for adding offline capabilities
mixin OfflineMixin {
  final OfflineManager _offlineManager = OfflineManager();

  /// Execute with offline fallback
  Future<T> withOfflineFallback<T>(
    Future<T> Function() onlineOperation,
    Future<T> Function() offlineOperation, {
    String? operationName,
  }) {
    return _offlineManager.executeWithOfflineFallback(
      onlineOperation,
      offlineOperation,
      operationName: operationName,
    );
  }

  /// Cache data for offline use
  Future<void> cacheForOffline(String key, Map<String, dynamic> data) {
    return _offlineManager.cacheData(key, data);
  }

  /// Get cached data
  Future<Map<String, dynamic>?> getCached(String key) {
    return _offlineManager.getCachedData(key);
  }

  /// Check if online
  bool get isOnline => _offlineManager.isOnline;

  /// Listen to connectivity changes
  Stream<bool> get connectivityStream => _offlineManager.connectivityStream;
}
