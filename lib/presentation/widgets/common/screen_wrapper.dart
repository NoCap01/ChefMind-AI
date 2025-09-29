import 'package:flutter/material.dart';
import '../../../core/state/screen_state.dart';
import 'loading_widget.dart';
import 'error_widget.dart';

/// A wrapper widget that handles different screen states
class ScreenWrapper<T> extends StatelessWidget {
  final ScreenState state;
  final Widget Function(T data) successBuilder;
  final Widget Function()? loadingBuilder;
  final Widget Function(String message, VoidCallback? onRetry)? errorBuilder;
  final Widget Function(String? message, VoidCallback? onAction, String? actionText)? emptyBuilder;
  final bool enablePullToRefresh;
  final Future<void> Function()? onRefresh;
  final String? appBarTitle;
  final List<Widget>? appBarActions;
  final Widget? floatingActionButton;
  final bool showAppBar;

  const ScreenWrapper({
    super.key,
    required this.state,
    required this.successBuilder,
    this.loadingBuilder,
    this.errorBuilder,
    this.emptyBuilder,
    this.enablePullToRefresh = false,
    this.onRefresh,
    this.appBarTitle,
    this.appBarActions,
    this.floatingActionButton,
    this.showAppBar = true,
  });

  @override
  Widget build(BuildContext context) {
    Widget body = _buildBody();

    // Wrap with pull-to-refresh if enabled
    if (enablePullToRefresh && onRefresh != null) {
      body = RefreshIndicator(
        onRefresh: onRefresh!,
        child: body,
      );
    }

    return Scaffold(
      appBar: showAppBar ? _buildAppBar(context) : null,
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }

  PreferredSizeWidget? _buildAppBar(BuildContext context) {
    if (!showAppBar) return null;
    
    return AppBar(
      title: appBarTitle != null ? Text(appBarTitle!) : null,
      actions: appBarActions,
      elevation: 0,
    );
  }

  Widget _buildBody() {
    return switch (state) {
      ScreenInitial() => _buildLoading(),
      ScreenLoading(message: final message) => _buildLoading(message),
      ScreenSuccess<T>(data: final data) => successBuilder(data),
      ScreenError(message: final message, onRetry: final onRetry) => _buildError(message, onRetry),
      ScreenEmpty(message: final message, onAction: final onAction, actionText: final actionText) => 
        _buildEmpty(message, onAction, actionText),
      ScreenRefreshing<T>(currentData: final currentData) => 
        currentData != null ? successBuilder(currentData) : _buildLoading('Refreshing...'),
      _ => _buildError('Unknown state', null),
    };
  }

  Widget _buildLoading([String? message]) {
    if (loadingBuilder != null) {
      return loadingBuilder!();
    }
    return LoadingWidget(message: message);
  }

  Widget _buildError(String message, VoidCallback? onRetry) {
    if (errorBuilder != null) {
      return errorBuilder!(message, onRetry);
    }
    return ErrorDisplayWidget(
      error: message,
      onRetry: onRetry,
    );
  }

  Widget _buildEmpty(String? message, VoidCallback? onAction, String? actionText) {
    if (emptyBuilder != null) {
      return emptyBuilder!(message, onAction, actionText);
    }
    return _buildDefaultEmpty(message, onAction, actionText);
  }

  Widget _buildDefaultEmpty(String? message, VoidCallback? onAction, String? actionText) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inbox_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              message ?? 'No data available',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            if (onAction != null) ...[
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: onAction,
                icon: const Icon(Icons.add),
                label: Text(actionText ?? 'Add Item'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// A simpler wrapper for screens that don't need complex state management
class SimpleScreenWrapper extends StatelessWidget {
  final Widget child;
  final String? title;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final bool enablePullToRefresh;
  final Future<void> Function()? onRefresh;
  final bool showAppBar;

  const SimpleScreenWrapper({
    super.key,
    required this.child,
    this.title,
    this.actions,
    this.floatingActionButton,
    this.enablePullToRefresh = false,
    this.onRefresh,
    this.showAppBar = true,
  });

  @override
  Widget build(BuildContext context) {
    Widget body = child;

    // Wrap with pull-to-refresh if enabled
    if (enablePullToRefresh && onRefresh != null) {
      body = RefreshIndicator(
        onRefresh: onRefresh!,
        child: body,
      );
    }

    return Scaffold(
      appBar: showAppBar && title != null
          ? AppBar(
              title: Text(title!),
              actions: actions,
              elevation: 0,
            )
          : null,
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}