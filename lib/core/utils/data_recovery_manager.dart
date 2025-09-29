import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import '../errors/app_error.dart';
import '../errors/error_handler.dart';

/// Data recovery and backup manager
class DataRecoveryManager {
  static final DataRecoveryManager _instance = DataRecoveryManager._internal();
  factory DataRecoveryManager() => _instance;
  DataRecoveryManager._internal();

  static const String _backupDirectory = 'backups';
  static const String _recoveryDirectory = 'recovery';
  static const int _maxBackups = 10;

  /// Create a backup of data
  Future<String> createBackup(
    String dataType,
    Map<String, dynamic> data, {
    String? customName,
  }) async {
    try {
      final backupDir = await _getBackupDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final fileName = customName ?? '${dataType}_$timestamp.json';
      final backupFile = File('${backupDir.path}/$fileName');

      final backupData = {
        'dataType': dataType,
        'timestamp': timestamp,
        'version': '1.0',
        'data': data,
      };

      await backupFile.writeAsString(
        const JsonEncoder.withIndent('  ').convert(backupData),
      );

      // Clean up old backups
      await _cleanupOldBackups(dataType);

      if (kDebugMode) {
        print('✅ Created backup: $fileName');
      }

      return fileName;
    } catch (error, stackTrace) {
      throw StorageError(
        message: 'Failed to create backup for $dataType',
        code: 'backup_creation_failed',
        details: error.toString(),
        stackTrace: stackTrace,
      );
    }
  }

  /// List available backups for a data type
  Future<List<BackupInfo>> listBackups(String dataType) async {
    try {
      final backupDir = await _getBackupDirectory();
      final files = backupDir
          .listSync()
          .whereType<File>()
          .where((file) => file.path.contains('${dataType}_'))
          .toList();

      final backups = <BackupInfo>[];

      for (final file in files) {
        try {
          final content = await file.readAsString();
          final data = jsonDecode(content) as Map<String, dynamic>;

          backups.add(BackupInfo(
            fileName: file.path.split('/').last,
            dataType: data['dataType'] as String,
            timestamp:
                DateTime.fromMillisecondsSinceEpoch(data['timestamp'] as int),
            version: data['version'] as String,
            filePath: file.path,
            size: await file.length(),
          ));
        } catch (e) {
          // Skip corrupted backup files
          if (kDebugMode) {
            print('⚠️ Skipping corrupted backup file: ${file.path}');
          }
        }
      }

      // Sort by timestamp (newest first)
      backups.sort((a, b) => b.timestamp.compareTo(a.timestamp));

      return backups;
    } catch (error, stackTrace) {
      throw StorageError(
        message: 'Failed to list backups for $dataType',
        code: 'backup_list_failed',
        details: error.toString(),
        stackTrace: stackTrace,
      );
    }
  }

  /// Restore data from backup
  Future<Map<String, dynamic>> restoreFromBackup(String fileName) async {
    try {
      final backupDir = await _getBackupDirectory();
      final backupFile = File('${backupDir.path}/$fileName');

      if (!await backupFile.exists()) {
        throw StorageError(
          message: 'Backup file not found: $fileName',
          code: 'backup_not_found',
        );
      }

      final content = await backupFile.readAsString();
      final backupData = jsonDecode(content) as Map<String, dynamic>;

      if (kDebugMode) {
        print('✅ Restored data from backup: $fileName');
      }

      return backupData['data'] as Map<String, dynamic>;
    } catch (error, stackTrace) {
      throw StorageError(
        message: 'Failed to restore from backup: $fileName',
        code: 'backup_restore_failed',
        details: error.toString(),
        stackTrace: stackTrace,
      );
    }
  }

  /// Create recovery point for critical operations
  Future<String> createRecoveryPoint(
    String operationType,
    Map<String, dynamic> beforeState,
  ) async {
    try {
      final recoveryDir = await _getRecoveryDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final fileName = '${operationType}_recovery_$timestamp.json';
      final recoveryFile = File('${recoveryDir.path}/$fileName');

      final recoveryData = {
        'operationType': operationType,
        'timestamp': timestamp,
        'beforeState': beforeState,
        'status': 'created',
      };

      await recoveryFile.writeAsString(
        const JsonEncoder.withIndent('  ').convert(recoveryData),
      );

      if (kDebugMode) {
        print('✅ Created recovery point: $fileName');
      }

      return fileName;
    } catch (error, stackTrace) {
      throw StorageError(
        message: 'Failed to create recovery point for $operationType',
        code: 'recovery_point_creation_failed',
        details: error.toString(),
        stackTrace: stackTrace,
      );
    }
  }

  /// Mark recovery point as completed
  Future<void> completeRecoveryPoint(String fileName) async {
    try {
      final recoveryDir = await _getRecoveryDirectory();
      final recoveryFile = File('${recoveryDir.path}/$fileName');

      if (await recoveryFile.exists()) {
        final content = await recoveryFile.readAsString();
        final recoveryData = jsonDecode(content) as Map<String, dynamic>;
        recoveryData['status'] = 'completed';
        recoveryData['completedAt'] = DateTime.now().millisecondsSinceEpoch;

        await recoveryFile.writeAsString(
          const JsonEncoder.withIndent('  ').convert(recoveryData),
        );

        if (kDebugMode) {
          print('✅ Completed recovery point: $fileName');
        }
      }
    } catch (error) {
      // Don't throw errors for recovery point completion
      if (kDebugMode) {
        print('⚠️ Failed to complete recovery point: $error');
      }
    }
  }

  /// Recover from failed operation
  Future<Map<String, dynamic>> recoverFromFailedOperation(
      String fileName) async {
    try {
      final recoveryDir = await _getRecoveryDirectory();
      final recoveryFile = File('${recoveryDir.path}/$fileName');

      if (!await recoveryFile.exists()) {
        throw StorageError(
          message: 'Recovery point not found: $fileName',
          code: 'recovery_point_not_found',
        );
      }

      final content = await recoveryFile.readAsString();
      final recoveryData = jsonDecode(content) as Map<String, dynamic>;

      if (recoveryData['status'] == 'completed') {
        throw StorageError(
          message: 'Recovery point already completed: $fileName',
          code: 'recovery_point_completed',
        );
      }

      if (kDebugMode) {
        print('✅ Recovered from failed operation: $fileName');
      }

      return recoveryData['beforeState'] as Map<String, dynamic>;
    } catch (error, stackTrace) {
      throw StorageError(
        message: 'Failed to recover from operation: $fileName',
        code: 'recovery_failed',
        details: error.toString(),
        stackTrace: stackTrace,
      );
    }
  }

  /// List pending recovery points
  Future<List<RecoveryPointInfo>> listPendingRecoveryPoints() async {
    try {
      final recoveryDir = await _getRecoveryDirectory();
      final files = recoveryDir
          .listSync()
          .whereType<File>()
          .where((file) => file.path.endsWith('_recovery_*.json'))
          .toList();

      final recoveryPoints = <RecoveryPointInfo>[];

      for (final file in files) {
        try {
          final content = await file.readAsString();
          final data = jsonDecode(content) as Map<String, dynamic>;

          if (data['status'] != 'completed') {
            recoveryPoints.add(RecoveryPointInfo(
              fileName: file.path.split('/').last,
              operationType: data['operationType'] as String,
              timestamp:
                  DateTime.fromMillisecondsSinceEpoch(data['timestamp'] as int),
              status: data['status'] as String,
              filePath: file.path,
            ));
          }
        } catch (e) {
          // Skip corrupted recovery files
          if (kDebugMode) {
            print('⚠️ Skipping corrupted recovery file: ${file.path}');
          }
        }
      }

      // Sort by timestamp (newest first)
      recoveryPoints.sort((a, b) => b.timestamp.compareTo(a.timestamp));

      return recoveryPoints;
    } catch (error, stackTrace) {
      throw StorageError(
        message: 'Failed to list recovery points',
        code: 'recovery_list_failed',
        details: error.toString(),
        stackTrace: stackTrace,
      );
    }
  }

  /// Clean up old backups
  Future<void> _cleanupOldBackups(String dataType) async {
    try {
      final backups = await listBackups(dataType);

      if (backups.length > _maxBackups) {
        final toDelete = backups.skip(_maxBackups);

        for (final backup in toDelete) {
          final file = File(backup.filePath);
          if (await file.exists()) {
            await file.delete();
            if (kDebugMode) {
              print('🗑️ Deleted old backup: ${backup.fileName}');
            }
          }
        }
      }
    } catch (error) {
      // Don't throw errors for cleanup
      if (kDebugMode) {
        print('⚠️ Failed to cleanup old backups: $error');
      }
    }
  }

  /// Get backup directory
  Future<Directory> _getBackupDirectory() async {
    final appDir = await getApplicationDocumentsDirectory();
    final backupDir = Directory('${appDir.path}/$_backupDirectory');

    if (!await backupDir.exists()) {
      await backupDir.create(recursive: true);
    }

    return backupDir;
  }

  /// Get recovery directory
  Future<Directory> _getRecoveryDirectory() async {
    final appDir = await getApplicationDocumentsDirectory();
    final recoveryDir = Directory('${appDir.path}/$_recoveryDirectory');

    if (!await recoveryDir.exists()) {
      await recoveryDir.create(recursive: true);
    }

    return recoveryDir;
  }

  /// Execute operation with automatic backup and recovery
  Future<T> executeWithRecovery<T>(
    String operationType,
    Future<T> Function() operation,
    Map<String, dynamic> Function() getBeforeState,
  ) async {
    String? recoveryPointId;

    try {
      // Create recovery point
      final beforeState = getBeforeState();
      recoveryPointId = await createRecoveryPoint(operationType, beforeState);

      // Execute operation
      final result = await operation();

      // Mark recovery point as completed
      await completeRecoveryPoint(recoveryPointId);

      return result;
    } catch (error, stackTrace) {
      if (kDebugMode) {
        print(
            '❌ Operation $operationType failed, recovery point available: $recoveryPointId');
      }

      throw ErrorHandler().handleError(error, stackTrace);
    }
  }
}

/// Information about a backup
class BackupInfo {
  const BackupInfo({
    required this.fileName,
    required this.dataType,
    required this.timestamp,
    required this.version,
    required this.filePath,
    required this.size,
  });

  final String fileName;
  final String dataType;
  final DateTime timestamp;
  final String version;
  final String filePath;
  final int size;

  String get formattedSize {
    if (size < 1024) return '${size}B';
    if (size < 1024 * 1024) return '${(size / 1024).toStringAsFixed(1)}KB';
    return '${(size / (1024 * 1024)).toStringAsFixed(1)}MB';
  }
}

/// Information about a recovery point
class RecoveryPointInfo {
  const RecoveryPointInfo({
    required this.fileName,
    required this.operationType,
    required this.timestamp,
    required this.status,
    required this.filePath,
  });

  final String fileName;
  final String operationType;
  final DateTime timestamp;
  final String status;
  final String filePath;
}

/// Mixin for adding data recovery capabilities
mixin DataRecoveryMixin {
  final DataRecoveryManager _recoveryManager = DataRecoveryManager();

  /// Execute with automatic backup
  Future<T> withBackup<T>(
    String dataType,
    Future<T> Function() operation,
    Map<String, dynamic> Function() getData,
  ) async {
    await _recoveryManager.createBackup(dataType, getData());
    return await operation();
  }

  /// Execute with recovery point
  Future<T> withRecovery<T>(
    String operationType,
    Future<T> Function() operation,
    Map<String, dynamic> Function() getBeforeState,
  ) {
    return _recoveryManager.executeWithRecovery(
      operationType,
      operation,
      getBeforeState,
    );
  }
}
