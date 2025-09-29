import 'package:flutter/foundation.dart';

/// Base screen state that all screens can use
@immutable
abstract class ScreenState {
  const ScreenState();
}

/// Initial state when screen is first loaded
class ScreenInitial extends ScreenState {
  const ScreenInitial();
}

/// Loading state with optional message
class ScreenLoading extends ScreenState {
  final String? message;
  
  const ScreenLoading({this.message});
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScreenLoading &&
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => message.hashCode;
}

/// Success state with data
class ScreenSuccess<T> extends ScreenState {
  final T data;
  
  const ScreenSuccess(this.data);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScreenSuccess<T> &&
          runtimeType == other.runtimeType &&
          data == other.data;

  @override
  int get hashCode => data.hashCode;
}

/// Error state with error message and optional retry callback
class ScreenError extends ScreenState {
  final String message;
  final String? details;
  final VoidCallback? onRetry;
  
  const ScreenError({
    required this.message,
    this.details,
    this.onRetry,
  });
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScreenError &&
          runtimeType == other.runtimeType &&
          message == other.message &&
          details == other.details;

  @override
  int get hashCode => Object.hash(message, details);
}

/// Empty state when there's no data to display
class ScreenEmpty extends ScreenState {
  final String? message;
  final VoidCallback? onAction;
  final String? actionText;
  
  const ScreenEmpty({
    this.message,
    this.onAction,
    this.actionText,
  });
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScreenEmpty &&
          runtimeType == other.runtimeType &&
          message == other.message &&
          actionText == other.actionText;

  @override
  int get hashCode => Object.hash(message, actionText);
}

/// Refreshing state for pull-to-refresh
class ScreenRefreshing<T> extends ScreenState {
  final T? currentData;
  
  const ScreenRefreshing({this.currentData});
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScreenRefreshing<T> &&
          runtimeType == other.runtimeType &&
          currentData == other.currentData;

  @override
  int get hashCode => currentData.hashCode;
}