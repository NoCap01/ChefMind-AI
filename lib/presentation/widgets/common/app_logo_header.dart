import 'package:flutter/material.dart';

/// App logo header widget for splash screens, about pages, etc.
class AppLogoHeader extends StatelessWidget {
  final double logoSize;
  final bool showAppName;
  final String? subtitle;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;

  const AppLogoHeader({
    super.key,
    this.logoSize = 80,
    this.showAppName = true,
    this.subtitle,
    this.titleStyle,
    this.subtitleStyle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Logo with gradient background
        Container(
          padding: EdgeInsets.all(logoSize * 0.2),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF6366F1), // Indigo 500
                Color(0xFF8B5CF6), // Violet 500
              ],
            ),
            borderRadius: BorderRadius.circular(logoSize * 0.3),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6366F1).withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Image.asset(
            'assets/icons/app_icon_1024.png',
            width: logoSize,
            height: logoSize,
            color: Colors.white,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.restaurant_menu,
                size: logoSize,
                color: Colors.white,
              );
            },
          ),
        ),

        if (showAppName) ...[
          const SizedBox(height: 16),
          Text(
            'ChefMind AI',
            style: titleStyle ??
                theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1E293B), // Slate 800
                ),
          ),
        ],

        if (subtitle != null) ...[
          const SizedBox(height: 8),
          Text(
            subtitle!,
            style: subtitleStyle ??
                theme.textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF64748B), // Slate 500
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}
