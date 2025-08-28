import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/design_tokens.dart';

/// A reusable loading indicator with cooking-themed animations
class LoadingIndicator extends StatefulWidget {
  const LoadingIndicator({
    super.key,
    this.message,
    this.size = LoadingSize.medium,
    this.type = LoadingType.cooking,
    this.showMessage = true,
    this.color,
    this.backgroundColor,
  });

  final String? message;
  final LoadingSize size;
  final LoadingType type;
  final bool showMessage;
  final Color? color;
  final Color? backgroundColor;

  @override
  State<LoadingIndicator> createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _rotationController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _rotationController,
      curve: Curves.linear,
    ));

    _pulseController.repeat(reverse: true);
    _rotationController.repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  double get _indicatorSize {
    switch (widget.size) {
      case LoadingSize.small:
        return 32.0;
      case LoadingSize.medium:
        return 48.0;
      case LoadingSize.large:
        return 64.0;
      case LoadingSize.extraLarge:
        return 96.0;
    }
  }

  String get _defaultMessage {
    switch (widget.type) {
      case LoadingType.cooking:
        return 'Cooking up something delicious...';
      case LoadingType.searching:
        return 'Searching for recipes...';
      case LoadingType.generating:
        return 'Generating your recipe...';
      case LoadingType.analyzing:
        return 'Analyzing ingredients...';
      case LoadingType.uploading:
        return 'Uploading your creation...';
      case LoadingType.processing:
        return 'Processing your request...';
    }
  }

  Widget _buildLottieIndicator() {
    String animationPath;
    switch (widget.type) {
      case LoadingType.cooking:
        animationPath = 'assets/animations/cooking_pot.json';
        break;
      case LoadingType.searching:
        animationPath = 'assets/animations/search_ingredients.json';
        break;
      case LoadingType.generating:
        animationPath = 'assets/animations/recipe_generation.json';
        break;
      case LoadingType.analyzing:
        animationPath = 'assets/animations/ingredient_analysis.json';
        break;
      case LoadingType.uploading:
        animationPath = 'assets/animations/upload_recipe.json';
        break;
      case LoadingType.processing:
        animationPath = 'assets/animations/food_processing.json';
        break;
    }

    return Lottie.asset(
      animationPath,
      width: _indicatorSize,
      height: _indicatorSize,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        // Fallback to custom animated indicator if Lottie fails
        return _buildFallbackIndicator();
      },
    );
  }

  Widget _buildFallbackIndicator() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final primaryColor = widget.color ?? colorScheme.primary;

    switch (widget.type) {
      case LoadingType.cooking:
        return AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _pulseAnimation.value,
              child: Icon(
                Icons.restaurant,
                size: _indicatorSize,
                color: primaryColor,
              ),
            );
          },
        );

      case LoadingType.searching:
        return AnimatedBuilder(
          animation: _rotationAnimation,
          builder: (context, child) {
            return Transform.rotate(
              angle: _rotationAnimation.value * 2 * 3.14159,
              child: Icon(
                Icons.search,
                size: _indicatorSize,
                color: primaryColor,
              ),
            );
          },
        );

      case LoadingType.generating:
        return AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _pulseAnimation.value,
              child: Icon(
                Icons.auto_awesome,
                size: _indicatorSize,
                color: primaryColor,
              ),
            );
          },
        );

      case LoadingType.analyzing:
        return AnimatedBuilder(
          animation: _rotationAnimation,
          builder: (context, child) {
            return Transform.rotate(
              angle: _rotationAnimation.value * 2 * 3.14159,
              child: Icon(
                Icons.analytics,
                size: _indicatorSize,
                color: primaryColor,
              ),
            );
          },
        );

      case LoadingType.uploading:
        return AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _pulseAnimation.value,
              child: Icon(
                Icons.cloud_upload,
                size: _indicatorSize,
                color: primaryColor,
              ),
            );
          },
        );

      case LoadingType.processing:
        return AnimatedBuilder(
          animation: _rotationAnimation,
          builder: (context, child) {
            return Transform.rotate(
              angle: _rotationAnimation.value * 2 * 3.14159,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: primaryColor,
              ),
            );
          },
        );
    }
  }

  Widget _buildProgressIndicator() {
    // Try Lottie first, fallback to custom indicator
    return _buildLottieIndicator();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final message = widget.message ?? _defaultMessage;

    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacing2xl),
      decoration: widget.backgroundColor != null
          ? BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: DesignTokens.radiusLarge,
            )
          : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildProgressIndicator(),
          
          if (widget.showMessage && message.isNotEmpty) ...[
            const SizedBox(height: DesignTokens.spacingLg),
            Text(
              message,
              style: AppTypography.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            )
                .animate()
                .fadeIn(duration: DesignTokens.animationNormal)
                .slideY(begin: 0.3, end: 0),
          ],
        ],
      ),
    );
  }
}

/// Enumeration for different loading indicator sizes
enum LoadingSize {
  small,
  medium,
  large,
  extraLarge,
}

/// Enumeration for different loading types with appropriate animations
enum LoadingType {
  cooking,
  searching,
  generating,
  analyzing,
  uploading,
  processing,
}

/// A full-screen loading overlay
class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
    this.message,
    this.type = LoadingType.cooking,
    this.backgroundColor,
  });

  final bool isLoading;
  final Widget child;
  final String? message;
  final LoadingType type;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: backgroundColor ?? 
                   colorScheme.surface.withValues(alpha: 0.8),
            child: Center(
              child: LoadingIndicator(
                message: message,
                type: type,
                size: LoadingSize.large,
                backgroundColor: colorScheme.surface,
              ),
            ),
          )
              .animate()
              .fadeIn(duration: DesignTokens.animationFast),
      ],
    );
  }
}

/// A compact loading indicator for buttons
class ButtonLoadingIndicator extends StatelessWidget {
  const ButtonLoadingIndicator({
    super.key,
    this.color,
    this.size = 16.0,
  });

  final Color? color;
  final double size;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: color ?? colorScheme.onPrimary,
      ),
    );
  }
}

/// A skeleton loading placeholder for content
class SkeletonLoader extends StatefulWidget {
  const SkeletonLoader({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
  });

  final double width;
  final double height;
  final BorderRadius? borderRadius;

  @override
  State<SkeletonLoader> createState() => _SkeletonLoaderState();
}

class _SkeletonLoaderState extends State<SkeletonLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: -1.0,
      end: 2.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius ?? DesignTokens.radiusLarge,
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [
                (_animation.value - 1).clamp(0.0, 1.0),
                _animation.value.clamp(0.0, 1.0),
                (_animation.value + 1).clamp(0.0, 1.0),
              ],
              colors: [
                colorScheme.surfaceContainerHighest,
                colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                colorScheme.surfaceContainerHighest,
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Recipe card skeleton loader
class RecipeCardSkeleton extends StatelessWidget {
  const RecipeCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: DesignTokens.recipeCardWidth,
      height: DesignTokens.recipeCardHeight,
      padding: DesignTokens.cardPadding,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: DesignTokens.radiusExtraLarge,
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image skeleton
          Expanded(
            flex: 3,
            child: SkeletonLoader(
              width: double.infinity,
              height: double.infinity,
              borderRadius: DesignTokens.radiusLarge,
            ),
          ),
          
          const SizedBox(height: DesignTokens.spacingMd),
          
          // Title skeleton
          const SkeletonLoader(
            width: double.infinity,
            height: 16,
          ),
          
          const SizedBox(height: DesignTokens.spacingSm),
          
          // Subtitle skeleton
          const SkeletonLoader(
            width: 120,
            height: 12,
          ),
          
          const SizedBox(height: DesignTokens.spacingMd),
          
          // Meta info skeleton
          Row(
            children: [
              const SkeletonLoader(
                width: 60,
                height: 12,
              ),
              const SizedBox(width: DesignTokens.spacingMd),
              const SkeletonLoader(
                width: 40,
                height: 12,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Ingredient list skeleton loader
class IngredientListSkeleton extends StatelessWidget {
  const IngredientListSkeleton({
    super.key,
    this.itemCount = 5,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        itemCount,
        (index) => Padding(
          padding: const EdgeInsets.only(bottom: DesignTokens.spacingSm),
          child: Row(
            children: [
              const SkeletonLoader(
                width: 24,
                height: 24,
                borderRadius: BorderRadius.all(
                  Radius.circular(DesignTokens.radiusFull),
                ),
              ),
              const SizedBox(width: DesignTokens.spacingMd),
              Expanded(
                child: SkeletonLoader(
                  width: double.infinity,
                  height: 16,
                  borderRadius: DesignTokens.radiusSmall,
                ),
              ),
              const SizedBox(width: DesignTokens.spacingMd),
              const SkeletonLoader(
                width: 60,
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}