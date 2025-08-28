import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/design_tokens.dart';

/// A reusable ingredient chip widget with selection states and animation effects
class IngredientChip extends StatefulWidget {
  const IngredientChip({
    super.key,
    required this.label,
    this.isSelected = false,
    this.isAvailable = true,
    this.quantity,
    this.unit,
    this.category,
    this.onTap,
    this.onLongPress,
    this.showCheckmark = true,
    this.backgroundColor,
    this.selectedColor,
    this.textColor,
    this.icon,
    this.trailing,
  });

  final String label;
  final bool isSelected;
  final bool isAvailable;
  final String? quantity;
  final String? unit;
  final String? category;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool showCheckmark;
  final Color? backgroundColor;
  final Color? selectedColor;
  final Color? textColor;
  final IconData? icon;
  final Widget? trailing;

  @override
  State<IngredientChip> createState() => _IngredientChipState();
}

class _IngredientChipState extends State<IngredientChip>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<Color?> _colorAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: DesignTokens.animationNormal,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: DesignTokens.curveEaseInOut,
    ));

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.1,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: DesignTokens.curveElastic,
    ));

    // Initialize color animation based on current selection state
    if (widget.isSelected) {
      _animationController.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(IngredientChip oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // Animate selection state changes
    if (widget.isSelected != oldWidget.isSelected) {
      if (widget.isSelected) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
  }

  Color _getCategoryColor(String? category) {
    if (category == null) return AppColors.herbGreen;
    
    switch (category.toLowerCase()) {
      case 'protein':
      case 'meat':
      case 'fish':
        return AppColors.spiceRed;
      case 'vegetable':
      case 'vegetables':
        return AppColors.freshGreen;
      case 'fruit':
      case 'fruits':
        return AppColors.warningAmber;
      case 'dairy':
        return AppColors.secondary;
      case 'grain':
      case 'grains':
      case 'carbs':
        return AppColors.grainBrown;
      case 'spice':
      case 'spices':
      case 'herb':
      case 'herbs':
        return AppColors.herbGreen;
      default:
        return AppColors.herbGreen;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    // Determine colors based on state
    final categoryColor = _getCategoryColor(widget.category);
    final backgroundColor = widget.isSelected
        ? (widget.selectedColor ?? categoryColor)
        : (widget.backgroundColor ?? colorScheme.surfaceContainerHighest);
    
    final textColor = widget.isSelected
        ? Colors.white
        : (widget.textColor ?? colorScheme.onSurfaceVariant);

    final opacity = widget.isAvailable ? 1.0 : 0.6;

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _isPressed ? 0.95 : _scaleAnimation.value,
          child: Transform.rotate(
            angle: widget.isSelected ? _rotationAnimation.value : 0,
            child: Opacity(
              opacity: opacity,
              child: GestureDetector(
                onTapDown: _handleTapDown,
                onTapUp: _handleTapUp,
                onTapCancel: _handleTapCancel,
                onTap: widget.isAvailable ? widget.onTap : null,
                onLongPress: widget.isAvailable ? widget.onLongPress : null,
                child: AnimatedContainer(
                  duration: DesignTokens.animationFast,
                  curve: DesignTokens.curveEaseInOut,
                  height: DesignTokens.ingredientChipHeight,
                  padding: const EdgeInsets.symmetric(
                    horizontal: DesignTokens.spacingMd,
                    vertical: DesignTokens.spacingSm,
                  ),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(DesignTokens.radiusFull),
                    border: Border.all(
                      color: widget.isSelected
                          ? categoryColor
                          : colorScheme.outline.withValues(alpha: 0.3),
                      width: widget.isSelected ? 2 : 1,
                    ),
                    boxShadow: widget.isSelected
                        ? [
                            BoxShadow(
                              color: categoryColor.withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Leading icon
                      if (widget.icon != null) ...[
                        Icon(
                          widget.icon,
                          size: DesignTokens.iconSm,
                          color: textColor,
                        ),
                        const SizedBox(width: DesignTokens.spacingXs),
                      ],

                      // Checkmark for selected state
                      if (widget.showCheckmark && widget.isSelected) ...[
                        Icon(
                          Icons.check_circle,
                          size: DesignTokens.iconSm,
                          color: textColor,
                        )
                            .animate()
                            .scale(
                              duration: DesignTokens.animationFast,
                              curve: DesignTokens.curveElastic,
                            )
                            .fadeIn(),
                        const SizedBox(width: DesignTokens.spacingXs),
                      ],

                      // Main label
                      Flexible(
                        child: Text(
                          widget.label,
                          style: AppTypography.chipText.copyWith(
                            color: textColor,
                            fontWeight: widget.isSelected
                                ? FontWeight.w600
                                : FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      // Quantity and unit
                      if (widget.quantity != null) ...[
                        const SizedBox(width: DesignTokens.spacingXs),
                        Text(
                          '${widget.quantity}${widget.unit ?? ''}',
                          style: AppTypography.chipText.copyWith(
                            color: textColor.withValues(alpha: 0.8),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],

                      // Trailing widget
                      if (widget.trailing != null) ...[
                        const SizedBox(width: DesignTokens.spacingXs),
                        widget.trailing!,
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// A specialized ingredient chip for shopping lists
class ShoppingIngredientChip extends StatelessWidget {
  const ShoppingIngredientChip({
    super.key,
    required this.label,
    this.quantity,
    this.unit,
    this.category,
    this.isChecked = false,
    this.onToggle,
    this.onTap,
  });

  final String label;
  final String? quantity;
  final String? unit;
  final String? category;
  final bool isChecked;
  final ValueChanged<bool>? onToggle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return IngredientChip(
      label: label,
      quantity: quantity,
      unit: unit,
      category: category,
      isSelected: isChecked,
      onTap: () {
        onToggle?.call(!isChecked);
        onTap?.call();
      },
      icon: isChecked ? Icons.shopping_cart : Icons.shopping_cart_outlined,
      showCheckmark: false,
    );
  }
}

/// A specialized ingredient chip for recipe ingredients
class RecipeIngredientChip extends StatelessWidget {
  const RecipeIngredientChip({
    super.key,
    required this.label,
    this.quantity,
    this.unit,
    this.category,
    this.isAvailable = true,
    this.isOptional = false,
    this.onTap,
    this.onLongPress,
  });

  final String label;
  final String? quantity;
  final String? unit;
  final String? category;
  final bool isAvailable;
  final bool isOptional;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return IngredientChip(
      label: label,
      quantity: quantity,
      unit: unit,
      category: category,
      isAvailable: isAvailable,
      onTap: onTap,
      onLongPress: onLongPress,
      showCheckmark: false,
      trailing: isOptional
          ? Text(
              'optional',
              style: AppTypography.captionText.copyWith(
                color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                fontStyle: FontStyle.italic,
              ),
            )
          : null,
    );
  }
}

/// A filter chip for ingredient categories
class CategoryFilterChip extends StatelessWidget {
  const CategoryFilterChip({
    super.key,
    required this.label,
    required this.category,
    this.isSelected = false,
    this.count,
    this.onTap,
  });

  final String label;
  final String category;
  final bool isSelected;
  final int? count;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return IngredientChip(
      label: label,
      category: category,
      isSelected: isSelected,
      onTap: onTap,
      showCheckmark: false,
      trailing: count != null
          ? Container(
              padding: const EdgeInsets.symmetric(
                horizontal: DesignTokens.spacingXs,
                vertical: 1,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withValues(alpha: 0.3)
                    : Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(DesignTokens.radiusFull),
              ),
              child: Text(
                count.toString(),
                style: AppTypography.captionText.copyWith(
                  color: isSelected
                      ? Colors.white
                      : Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          : null,
    );
  }
}