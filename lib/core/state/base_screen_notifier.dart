import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screen_state.dart';

/// Base state notifier for screens with common functionality
abstract class BaseScreenNotifier<T> extends StateNotifier<ScreenState> {
  BaseScreenNotifier() : super(const ScreenInitial());

  /// Load data with loading state management
  Future<void> loadData() async {
    if (state is! ScreenRefreshing) {
      state = const ScreenLoading();
    }
    
    try {
      final data = await fetchData();
      if (data != null) {
        state = ScreenSuccess(data);
      } else {
        state = const ScreenEmpty(
          message: 'No data available',
        );
      }
    } catch (error) {
      state = ScreenError(
        message: _getErrorMessage(error),
        onRetry: loadData,
      );
    }
  }

  /// Refresh data with refreshing state
  Future<void> refreshData() async {
    final currentData = state is ScreenSuccess<T> 
        ? (state as ScreenSuccess<T>).data 
        : null;
    
    state = ScreenRefreshing(currentData: currentData);
    
    try {
      final data = await fetchData();
      if (data != null) {
        state = ScreenSuccess(data);
      } else {
        state = const ScreenEmpty(
          message: 'No data available',
        );
      }
    } catch (error) {
      state = ScreenError(
        message: _getErrorMessage(error),
        onRetry: loadData,
      );
    }
  }

  /// Set loading state with optional message
  void setLoading([String? message]) {
    state = ScreenLoading(message: message);
  }

  /// Set success state with data
  void setSuccess(T data) {
    state = ScreenSuccess(data);
  }

  /// Set error state
  void setError(String message, {VoidCallback? onRetry}) {
    state = ScreenError(
      message: message,
      onRetry: onRetry ?? loadData,
    );
  }

  /// Set empty state
  void setEmpty({String? message, VoidCallback? onAction, String? actionText}) {
    state = ScreenEmpty(
      message: message,
      onAction: onAction,
      actionText: actionText,
    );
  }

  /// Abstract method to fetch data - must be implemented by subclasses
  Future<T?> fetchData();

  /// Convert error to user-friendly message
  String _getErrorMessage(dynamic error) {
    if (error is Exception) {
      return error.toString().replaceFirst('Exception: ', '');
    }
    return error.toString();
  }

  /// Check if currently in loading state
  bool get isLoading => state is ScreenLoading || state is ScreenRefreshing;

  /// Check if currently has data
  bool get hasData => state is ScreenSuccess<T>;

  /// Get current data if available
  T? get currentData {
    final currentState = state;
    if (currentState is ScreenSuccess<T>) {
      return currentState.data;
    }
    if (currentState is ScreenRefreshing<T>) {
      return currentState.currentData;
    }
    return null;
  }
}

/// Simple screen notifier for screens that don't need data loading
class SimpleScreenNotifier extends StateNotifier<ScreenState> {
  SimpleScreenNotifier() : super(const ScreenInitial());

  void setLoading([String? message]) {
    state = ScreenLoading(message: message);
  }

  void setSuccess() {
    state = const ScreenSuccess(null);
  }

  void setError(String message, {VoidCallback? onRetry}) {
    state = ScreenError(
      message: message,
      onRetry: onRetry,
    );
  }

  void reset() {
    state = const ScreenInitial();
  }
}