import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Custom page transitions for the ChefMind AI application
/// 
/// This file contains various page transition animations used throughout
/// the app for smooth navigation experiences.
class PageTransitions {
  PageTransitions._();

  /// Slide transition from bottom (modal style)
  static Page<T> slideFromBottomTransition<T extends Object?>(
    Widget child,
    GoRouterState state, {
    String? name,
    Object? arguments,
    String? restorationId,
  }) {
    return ChefMindTransitionPage<T>(
      key: state.pageKey,
      name: name,
      arguments: arguments,
      restorationId: restorationId,
      child: child,
      transitionDuration: const Duration(milliseconds: 300),
      reverseTransitionDuration: const Duration(milliseconds: 250),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeInOutCubic;

        final tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  /// Slide transition from right (standard navigation)
  static Page<T> slideFromRightTransition<T extends Object?>(
    Widget child,
    GoRouterState state, {
    String? name,
    Object? arguments,
    String? restorationId,
  }) {
    return ChefMindTransitionPage<T>(
      key: state.pageKey,
      name: name,
      arguments: arguments,
      restorationId: restorationId,
      child: child,
      transitionDuration: const Duration(milliseconds: 300),
      reverseTransitionDuration: const Duration(milliseconds: 250),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOutCubic;

        final tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  /// Fade transition with scale (elegant modal)
  static Page<T> fadeWithScaleTransition<T extends Object?>(
    Widget child,
    GoRouterState state, {
    String? name,
    Object? arguments,
    String? restorationId,
  }) {
    return ChefMindTransitionPage<T>(
      key: state.pageKey,
      name: name,
      arguments: arguments,
      restorationId: restorationId,
      child: child,
      transitionDuration: const Duration(milliseconds: 350),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const curve = Curves.easeInOutCubic;

        final fadeAnimation = animation.drive(
          CurveTween(curve: curve),
        );

        final scaleAnimation = animation.drive(
          Tween(begin: 0.8, end: 1.0).chain(
            CurveTween(curve: curve),
          ),
        );

        return FadeTransition(
          opacity: fadeAnimation,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: child,
          ),
        );
      },
    );
  }

  /// Hero transition for recipe details
  static Page<T> heroTransition<T extends Object?>(
    Widget child,
    GoRouterState state, {
    String? name,
    Object? arguments,
    String? restorationId,
    String? heroTag,
  }) {
    return ChefMindTransitionPage<T>(
      key: state.pageKey,
      name: name,
      arguments: arguments,
      restorationId: restorationId,
      child: child,
      transitionDuration: const Duration(milliseconds: 400),
      reverseTransitionDuration: const Duration(milliseconds: 350),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const curve = Curves.easeInOutCubic;

        final fadeAnimation = animation.drive(
          Tween(begin: 0.0, end: 1.0).chain(
            CurveTween(curve: curve),
          ),
        );

        final scaleAnimation = animation.drive(
          Tween(begin: 0.9, end: 1.0).chain(
            CurveTween(curve: curve),
          ),
        );

        return FadeTransition(
          opacity: fadeAnimation,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: child,
          ),
        );
      },
    );
  }

  /// Shared axis transition (Material Design)
  static Page<T> sharedAxisTransition<T extends Object?>(
    Widget child,
    GoRouterState state, {
    String? name,
    Object? arguments,
    String? restorationId,
    SharedAxisTransitionType transitionType = SharedAxisTransitionType.horizontal,
  }) {
    return ChefMindTransitionPage<T>(
      key: state.pageKey,
      name: name,
      arguments: arguments,
      restorationId: restorationId,
      child: child,
      transitionDuration: const Duration(milliseconds: 300),
      reverseTransitionDuration: const Duration(milliseconds: 250),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return _buildSharedAxisTransition(
          child,
          animation,
          secondaryAnimation,
          transitionType,
        );
      },
    );
  }

  /// Build shared axis transition based on type
  static Widget _buildSharedAxisTransition(
    Widget child,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    SharedAxisTransitionType transitionType,
  ) {
    const curve = Curves.easeInOutCubic;

    switch (transitionType) {
      case SharedAxisTransitionType.horizontal:
        final primarySlideAnimation = animation.drive(
          Tween(begin: const Offset(1.0, 0.0), end: Offset.zero).chain(
            CurveTween(curve: curve),
          ),
        );
        final secondarySlideAnimation = secondaryAnimation.drive(
          Tween(begin: Offset.zero, end: const Offset(-1.0, 0.0)).chain(
            CurveTween(curve: curve),
          ),
        );

        return SlideTransition(
          position: primarySlideAnimation,
          child: SlideTransition(
            position: secondarySlideAnimation,
            child: child,
          ),
        );

      case SharedAxisTransitionType.vertical:
        final primarySlideAnimation = animation.drive(
          Tween(begin: const Offset(0.0, 1.0), end: Offset.zero).chain(
            CurveTween(curve: curve),
          ),
        );
        final secondarySlideAnimation = secondaryAnimation.drive(
          Tween(begin: Offset.zero, end: const Offset(0.0, -1.0)).chain(
            CurveTween(curve: curve),
          ),
        );

        return SlideTransition(
          position: primarySlideAnimation,
          child: SlideTransition(
            position: secondarySlideAnimation,
            child: child,
          ),
        );

      case SharedAxisTransitionType.scaled:
        final primaryScaleAnimation = animation.drive(
          Tween(begin: 0.8, end: 1.0).chain(
            CurveTween(curve: curve),
          ),
        );
        final secondaryScaleAnimation = secondaryAnimation.drive(
          Tween(begin: 1.0, end: 1.1).chain(
            CurveTween(curve: curve),
          ),
        );

        final primaryFadeAnimation = animation.drive(
          CurveTween(curve: curve),
        );
        final secondaryFadeAnimation = secondaryAnimation.drive(
          Tween(begin: 1.0, end: 0.0).chain(
            CurveTween(curve: curve),
          ),
        );

        return FadeTransition(
          opacity: primaryFadeAnimation,
          child: ScaleTransition(
            scale: primaryScaleAnimation,
            child: FadeTransition(
              opacity: secondaryFadeAnimation,
              child: ScaleTransition(
                scale: secondaryScaleAnimation,
                child: child,
              ),
            ),
          ),
        );
    }
  }

  /// No transition (instant)
  static Page<T> noTransition<T extends Object?>(
    Widget child,
    GoRouterState state, {
    String? name,
    Object? arguments,
    String? restorationId,
  }) {
    return ChefMindNoTransitionPage<T>(
      key: state.pageKey,
      name: name,
      arguments: arguments,
      restorationId: restorationId,
      child: child,
    );
  }
}

/// Enum for shared axis transition types
enum SharedAxisTransitionType {
  horizontal,
  vertical,
  scaled,
}

/// Custom transition page for more control over transitions
class ChefMindTransitionPage<T> extends Page<T> {
  const ChefMindTransitionPage({
    required this.child,
    required this.transitionsBuilder,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.reverseTransitionDuration = const Duration(milliseconds: 300),
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  });

  final Widget child;
  final Widget Function(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) transitionsBuilder;
  final Duration transitionDuration;
  final Duration reverseTransitionDuration;

  @override
  Route<T> createRoute(BuildContext context) {
    return PageRouteBuilder<T>(
      settings: this,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionDuration: transitionDuration,
      reverseTransitionDuration: reverseTransitionDuration,
      transitionsBuilder: transitionsBuilder,
    );
  }
}

/// No transition page for instant navigation
class ChefMindNoTransitionPage<T> extends Page<T> {
  const ChefMindNoTransitionPage({
    required this.child,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  });

  final Widget child;

  @override
  Route<T> createRoute(BuildContext context) {
    return PageRouteBuilder<T>(
      settings: this,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    );
  }
}