import 'package:flutter/material.dart';

enum ButtonVariant { filled, outlined, text, elevated }

enum ButtonSize { small, medium, large }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final ButtonSize size;
  final IconData? icon;
  final bool isExpanded;
  final bool isLoading;
  final Color? color;
  final Color? textColor;
  final double? borderRadius;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = ButtonVariant.filled,
    this.size = ButtonSize.medium,
    this.icon,
    this.isExpanded = false,
    this.isLoading = false,
    this.color,
    this.textColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget button = switch (variant) {
      ButtonVariant.filled => _buildFilledButton(context, theme),
      ButtonVariant.outlined => _buildOutlinedButton(context, theme),
      ButtonVariant.text => _buildTextButton(context, theme),
      ButtonVariant.elevated => _buildElevatedButton(context, theme),
    };

    if (isExpanded) {
      button = SizedBox(width: double.infinity, child: button);
    }

    return button;
  }

  Widget _buildFilledButton(BuildContext context, ThemeData theme) {
    return FilledButton.icon(
      onPressed: isLoading ? null : onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: color ?? theme.colorScheme.primary,
        foregroundColor: textColor ?? theme.colorScheme.onPrimary,
        padding: _getPadding(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8),
        ),
      ),
      icon: _getIcon(context),
      label: _getLabel(context),
    );
  }

  Widget _buildOutlinedButton(BuildContext context, ThemeData theme) {
    return OutlinedButton.icon(
      onPressed: isLoading ? null : onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: textColor ?? color ?? theme.colorScheme.primary,
        padding: _getPadding(),
        side: BorderSide(color: color ?? theme.colorScheme.primary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8),
        ),
      ),
      icon: _getIcon(context),
      label: _getLabel(context),
    );
  }

  Widget _buildTextButton(BuildContext context, ThemeData theme) {
    return TextButton.icon(
      onPressed: isLoading ? null : onPressed,
      style: TextButton.styleFrom(
        foregroundColor: textColor ?? color ?? theme.colorScheme.primary,
        padding: _getPadding(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8),
        ),
      ),
      icon: _getIcon(context),
      label: _getLabel(context),
    );
  }

  Widget _buildElevatedButton(BuildContext context, ThemeData theme) {
    return ElevatedButton.icon(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? theme.colorScheme.surface,
        foregroundColor: textColor ?? theme.colorScheme.onSurface,
        padding: _getPadding(),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8),
        ),
      ),
      icon: _getIcon(context),
      label: _getLabel(context),
    );
  }

  Widget _getIcon(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        width: _getIconSize(),
        height: _getIconSize(),
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            textColor ?? Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      );
    }

    return Icon(icon, size: _getIconSize());
  }

  Widget _getLabel(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: _getFontSize(), fontWeight: FontWeight.w600),
    );
  }

  EdgeInsets _getPadding() {
    return switch (size) {
      ButtonSize.small => const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      ButtonSize.medium => const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      ButtonSize.large => const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 12,
      ),
    };
  }

  double _getFontSize() {
    return switch (size) {
      ButtonSize.small => 12,
      ButtonSize.medium => 14,
      ButtonSize.large => 16,
    };
  }

  double _getIconSize() {
    return switch (size) {
      ButtonSize.small => 16,
      ButtonSize.medium => 18,
      ButtonSize.large => 20,
    };
  }
}

// Icon-only button variant
class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final ButtonSize size;
  final Color? color;
  final Color? iconColor;
  final String? tooltip;

  const CustomIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.variant = ButtonVariant.filled,
    this.size = ButtonSize.medium,
    this.color,
    this.iconColor,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconSize = _getIconSize();

    Widget button = switch (variant) {
      ButtonVariant.filled => IconButton.filled(
        onPressed: onPressed,
        icon: Icon(icon, size: iconSize),
        style: IconButton.styleFrom(
          backgroundColor: color ?? theme.colorScheme.primary,
          foregroundColor: iconColor ?? theme.colorScheme.onPrimary,
        ),
      ),
      ButtonVariant.outlined => IconButton.outlined(
        onPressed: onPressed,
        icon: Icon(icon, size: iconSize),
        style: IconButton.styleFrom(
          foregroundColor: iconColor ?? color ?? theme.colorScheme.primary,
          side: BorderSide(color: color ?? theme.colorScheme.primary),
        ),
      ),
      ButtonVariant.text => IconButton(
        onPressed: onPressed,
        icon: Icon(icon, size: iconSize),
        style: IconButton.styleFrom(
          foregroundColor: iconColor ?? color ?? theme.colorScheme.primary,
        ),
      ),
      ButtonVariant.elevated => IconButton(
        onPressed: onPressed,
        icon: Icon(icon, size: iconSize),
        style: IconButton.styleFrom(
          backgroundColor: color ?? theme.colorScheme.surface,
          foregroundColor: iconColor ?? theme.colorScheme.onSurface,
          elevation: 2,
        ),
      ),
    };

    if (tooltip != null) {
      button = Tooltip(message: tooltip!, child: button);
    }

    return button;
  }

  double _getIconSize() {
    return switch (size) {
      ButtonSize.small => 16,
      ButtonSize.medium => 20,
      ButtonSize.large => 24,
    };
  }
}
