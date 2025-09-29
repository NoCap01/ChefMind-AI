import 'dart:async';
import 'dart:io';
import 'app_error.dart';
import 'error_logger.dart';

/// Central error handler for the application
class ErrorHandler {
  static final ErrorHandler _instance = ErrorHandler._internal();
  factory ErrorHandler() => _instance;
  ErrorHandler._internal();

  final ErrorLogger _logger = ErrorLogger();

  /// Handle any error and convert it to AppError
  AppError handleError(dynamic error, [StackTrace? stackTrace]) {
    final appError = _convertToAppError(error, stackTrace);

    if (appError.shouldLog) {
      _logger.logError(appError);
    }

    return appError;
  }

  /// Convert any error to AppError
  AppError _convertToAppError(dynamic error, [StackTrace? stackTrace]) {
    if (error is AppError) {
      return error;
    }

    if (error is SocketException) {
      return NetworkError(
        message: error.message,
        code: 'connection_error',
        details: error.toString(),
        stackTrace: stackTrace,
      );
    }

    if (error is TimeoutException) {
      return NetworkError(
        message: 'Connection timed out',
        code: 'connection_timeout',
        details: error.toString(),
        stackTrace: stackTrace,
      );
    }

    if (error is HttpException) {
      return ApiError(
        message: error.message,
        code: 'http_error',
        details: error.toString(),
        stackTrace: stackTrace,
      );
    }

    if (error is FormatException) {
      return ParsingError(
        message: error.message,
        code: 'format_error',
        details: error.toString(),
        stackTrace: stackTrace,
      );
    }

    if (error is ArgumentError) {
      return ValidationError(
        message: error.message ?? 'Invalid argument',
        code: 'invalid_argument',
        details: error.toString(),
        stackTrace: stackTrace,
      );
    }

    // Default to unknown error
    return UnknownError(
      message: error.toString(),
      details: 'Original error type: ${error.runtimeType}',
      stackTrace: stackTrace,
    );
  }

  /// Handle errors in async operations
  static Future<T> handleAsync<T>(Future<T> Function() operation) async {
    try {
      return await operation();
    } catch (error, stackTrace) {
      throw ErrorHandler().handleError(error, stackTrace);
    }
  }

  /// Handle errors in sync operations
  static T handleSync<T>(T Function() operation) {
    try {
      return operation();
    } catch (error, stackTrace) {
      throw ErrorHandler().handleError(error, stackTrace);
    }
  }

  /// Handle errors with custom error mapping
  static Future<T> handleAsyncWithMapping<T>(
    Future<T> Function() operation,
    AppError Function(dynamic error, StackTrace? stackTrace)? errorMapper,
  ) async {
    try {
      return await operation();
    } catch (error, stackTrace) {
      if (errorMapper != null) {
        final mappedError = errorMapper(error, stackTrace);
        if (mappedError.shouldLog) {
          ErrorHandler()._logger.logError(mappedError);
        }
        throw mappedError;
      }
      throw ErrorHandler().handleError(error, stackTrace);
    }
  }

  /// Get error logger instance
  ErrorLogger get logger => _logger;
}

/// Extension to make error handling easier
extension ErrorHandlerExtension on Future {
  /// Handle errors in this future
  Future<T> handleErrors<T>() async {
    return ErrorHandler.handleAsync(() => this as Future<T>);
  }

  /// Handle errors with custom mapping
  Future<T> handleErrorsWithMapping<T>(
    AppError Function(dynamic error, StackTrace? stackTrace) errorMapper,
  ) async {
    return ErrorHandler.handleAsyncWithMapping(
      () => this as Future<T>,
      errorMapper,
    );
  }
}
