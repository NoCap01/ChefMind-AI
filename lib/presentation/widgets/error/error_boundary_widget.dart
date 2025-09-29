import 'package:flutter/material.dart';
import '../../../core/errors/app_error.dart';
import '../../../core/errors/error_handler.dart';
import 'error_display_widget.dart';

/// Widget that catches and handles errors in its child tree
class ErrorBoundary extends StatefulWidget {
  const ErrorBoundary({
    super.key,
    required this.child,
    this.onError,
    this.fallbackBuilder,
    this.showErrorDetails = false,
  });

  final Widget child;
  final void Function(AppError error)? onError;
  final Widget Function(AppError error, VoidCallback retry)? fallbackBuilder;
  final bool showErrorDetails;

  @override
  State<ErrorBoundary> createState() => _ErrorBoundaryState();
}

class _ErrorBoundaryState extends State<ErrorBoundary> {
  AppError? _error;

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      if (widget.fallbackBuilder != null) {
        return widget.fallbackBuilder!(_error!, _retry);
      }
      
      return ErrorDisplayWidget(
        error: _error!,
        onRetry: _error!.isRetryable ? _retry : null,
        showDetails: widget.showErrorDetails,
      );
    }

    return ErrorCatcher(
      onError: _handleError,
      child: widget.child,
    );
  }

  void _handleError(AppError error) {
    setState(() {
      _error = error;
    });
    
    widget.onError?.call(error);
  }

  void _retry() {
    setState(() {
      _error = null;
    });
  }
}

/// Widget that catches errors in its child tree
class ErrorCatcher extends StatefulWidget {
  const ErrorCatcher({
    super.key,
    required this.child,
    required this.onError,
  });

  final Widget child;
  final void Function(AppError error) onError;

  @override
  State<ErrorCatcher> createState() => _ErrorCatcherState();
}

class _ErrorCatcherState extends State<ErrorCatcher> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void initState() {
    super.initState();
    
    // Set up error handling for the widget tree
    FlutterError.onError = (FlutterErrorDetails details) {
      final error = ErrorHandler().handleError(
        details.exception,
        details.stack,
      );
      widget.onError(error);
    };
  }
}

/// Mixin for handling errors in StatefulWidgets
mixin ErrorHandlerMixin<T extends StatefulWidget> on State<T> {
  AppError? _currentError;

  AppError? get currentError => _currentError;

  /// Handle an error and update the UI
  void handleError(dynamic error, [StackTrace? stackTrace]) {
    final appError = ErrorHandler().handleError(error, stackTrace);
    setState(() {
      _currentError = appError;
    });
    onError(appError);
  }

  /// Clear the current error
  void clearError() {
    setState(() {
      _currentError = null;
    });
  }

  /// Called when an error occurs
  void onError(AppError error) {
    // Override in subclasses to handle errors
  }

  /// Execute an async operation with error handling
  Future<T?> executeWithErrorHandling<T>(
    Future<T> Function() operation, {
    bool clearErrorOnSuccess = true,
  }) async {
    try {
      final result = await operation();
      if (clearErrorOnSuccess) {
        clearError();
      }
      return result;
    } catch (error, stackTrace) {
      handleError(error, stackTrace);
      return null;
    }
  }

  /// Execute a sync operation with error handling
  T? executeSyncWithErrorHandling<T>(
    T Function() operation, {
    bool clearErrorOnSuccess = true,
  }) {
    try {
      final result = operation();
      if (clearErrorOnSuccess) {
        clearError();
      }
      return result;
    } catch (error, stackTrace) {
      handleError(error, stackTrace);
      return null;
    }
  }
}

/// Widget builder that includes error handling
class SafeBuilder extends StatelessWidget {
  const SafeBuilder({
    super.key,
    required this.builder,
    this.onError,
    this.fallback,
  });

  final Widget Function(BuildContext context) builder;
  final void Function(AppError error)? onError;
  final Widget? fallback;

  @override
  Widget build(BuildContext context) {
    try {
      return builder(context);
    } catch (error, stackTrace) {
      final appError = ErrorHandler().handleError(error, stackTrace);
      onError?.call(appError);
      
      return fallback ?? CompactErrorWidget(error: appError);
    }
  }
}

/// Future builder with error handling
class SafeFutureBuilder<T> extends StatelessWidget {
  const SafeFutureBuilder({
    super.key,
    required this.future,
    required this.builder,
    this.onError,
    this.loadingWidget,
    this.errorWidget,
  });

  final Future<T> future;
  final Widget Function(BuildContext context, T data) builder;
  final void Function(AppError error)? onError;
  final Widget? loadingWidget;
  final Widget Function(AppError error)? errorWidget;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return loadingWidget ?? const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          final appError = ErrorHandler().handleError(
            snapshot.error,
            snapshot.stackTrace,
          );
          onError?.call(appError);
          
          return errorWidget?.call(appError) ?? 
                 CompactErrorWidget(error: appError);
        }

        if (snapshot.hasData) {
          return builder(context, snapshot.data as T);
        }

        return const SizedBox.shrink();
      },
    );
  }
}

/// Stream builder with error handling
class SafeStreamBuilder<T> extends StatelessWidget {
  const SafeStreamBuilder({
    super.key,
    required this.stream,
    required this.builder,
    this.onError,
    this.loadingWidget,
    this.errorWidget,
  });

  final Stream<T> stream;
  final Widget Function(BuildContext context, T data) builder;
  final void Function(AppError error)? onError;
  final Widget? loadingWidget;
  final Widget Function(AppError error)? errorWidget;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return loadingWidget ?? const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          final appError = ErrorHandler().handleError(
            snapshot.error,
            snapshot.stackTrace,
          );
          onError?.call(appError);
          
          return errorWidget?.call(appError) ?? 
                 CompactErrorWidget(error: appError);
        }

        if (snapshot.hasData) {
          return builder(context, snapshot.data as T);
        }

        return const SizedBox.shrink();
      },
    );
  }
}