import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum TextFieldVariant { outlined, filled, underlined }

class CustomTextField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final String? helperText;
  final String? errorText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final bool readOnly;
  final bool enabled;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final TextFieldVariant variant;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final bool autofocus;
  final String? initialValue;
  final FormFieldValidator<String>? validator;

  const CustomTextField({
    super.key,
    this.labelText,
    this.hintText,
    this.helperText,
    this.errorText,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.variant = TextFieldVariant.outlined,
    this.prefixIcon,
    this.suffixIcon,
    this.inputFormatters,
    this.focusNode,
    this.autofocus = false,
    this.initialValue,
    this.validator,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      controller: widget.controller,
      initialValue: widget.initialValue,
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      onTap: widget.onTap,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      obscureText: _obscureText,
      readOnly: widget.readOnly,
      enabled: widget.enabled,
      maxLines: widget.obscureText ? 1 : widget.maxLines,
      minLines: widget.minLines,
      maxLength: widget.maxLength,
      inputFormatters: widget.inputFormatters,
      validator: widget.validator,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        helperText: widget.helperText,
        errorText: widget.errorText,
        prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
        suffixIcon: _buildSuffixIcon(),
        border: _getBorder(theme, false),
        enabledBorder: _getBorder(theme, false),
        focusedBorder: _getBorder(theme, true),
        errorBorder: _getErrorBorder(theme),
        focusedErrorBorder: _getErrorBorder(theme),
        filled: widget.variant == TextFieldVariant.filled,
        fillColor: widget.variant == TextFieldVariant.filled
            ? theme.colorScheme.surfaceContainerHighest.withOpacity(0.5)
            : null,
      ),
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.obscureText) {
      return IconButton(
        onPressed: () => setState(() => _obscureText = !_obscureText),
        icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
      );
    }
    return widget.suffixIcon;
  }

  InputBorder _getBorder(ThemeData theme, bool isFocused) {
    final color =
        isFocused ? theme.colorScheme.primary : theme.colorScheme.outline;

    return switch (widget.variant) {
      TextFieldVariant.outlined => OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: color),
        ),
      TextFieldVariant.filled => OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      TextFieldVariant.underlined => UnderlineInputBorder(
          borderSide: BorderSide(color: color),
        ),
    };
  }

  InputBorder _getErrorBorder(ThemeData theme) {
    final errorColor = theme.colorScheme.error;

    return switch (widget.variant) {
      TextFieldVariant.outlined => OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: errorColor),
        ),
      TextFieldVariant.filled => OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      TextFieldVariant.underlined => UnderlineInputBorder(
          borderSide: BorderSide(color: errorColor),
        ),
    };
  }
}

// Search text field with built-in search functionality
class SearchTextField extends StatefulWidget {
  final String? hintText;
  final ValueChanged<String>? onSearch;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final TextEditingController? controller;
  final bool autofocus;
  final bool showClearButton;

  const SearchTextField({
    super.key,
    this.hintText = 'Search...',
    this.onSearch,
    this.onChanged,
    this.onClear,
    this.controller,
    this.autofocus = false,
    this.showClearButton = true,
  });

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  late TextEditingController _controller;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(() {
      final hasText = _controller.text.isNotEmpty;
      if (hasText != _hasText) {
        setState(() => _hasText = hasText);
      }
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: _controller,
      hintText: widget.hintText,
      autofocus: widget.autofocus,
      prefixIcon: Icons.search,
      suffixIcon: widget.showClearButton && _hasText
          ? IconButton(
              onPressed: () {
                _controller.clear();
                widget.onClear?.call();
              },
              icon: const Icon(Icons.clear),
            )
          : null,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSearch,
      textInputAction: TextInputAction.search,
    );
  }
}

// Password field with strength indicator
class PasswordTextField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final bool showStrengthIndicator;

  const PasswordTextField({
    super.key,
    this.labelText = 'Password',
    this.hintText,
    this.controller,
    this.onChanged,
    this.validator,
    this.showStrengthIndicator = false,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  PasswordStrength _strength = PasswordStrength.weak;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          labelText: widget.labelText,
          hintText: widget.hintText,
          controller: widget.controller,
          obscureText: true,
          validator: widget.validator,
          onChanged: (value) {
            if (widget.showStrengthIndicator) {
              setState(() => _strength = _calculateStrength(value));
            }
            widget.onChanged?.call(value);
          },
        ),
        if (widget.showStrengthIndicator) ...[
          const SizedBox(height: 8),
          _buildStrengthIndicator(),
        ],
      ],
    );
  }

  Widget _buildStrengthIndicator() {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: LinearProgressIndicator(
                value: _strength.value,
                backgroundColor: theme.colorScheme.surfaceContainerHighest,
                valueColor: AlwaysStoppedAnimation<Color>(_strength.color),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          _strength.label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: _strength.color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  PasswordStrength _calculateStrength(String password) {
    if (password.isEmpty) return PasswordStrength.weak;

    int score = 0;

    // Length
    if (password.length >= 8) score++;
    if (password.length >= 12) score++;

    // Character types
    if (RegExp(r'[a-z]').hasMatch(password)) score++;
    if (RegExp(r'[A-Z]').hasMatch(password)) score++;
    if (RegExp(r'[0-9]').hasMatch(password)) score++;
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) score++;

    if (score <= 2) return PasswordStrength.weak;
    if (score <= 4) return PasswordStrength.medium;
    return PasswordStrength.strong;
  }
}

enum PasswordStrength {
  weak(0.33, Colors.red, 'Weak'),
  medium(0.66, Colors.orange, 'Medium'),
  strong(1.0, Colors.green, 'Strong');

  const PasswordStrength(this.value, this.color, this.label);
  final double value;
  final Color color;
  final String label;
}
