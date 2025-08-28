import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_colors.dart';
import 'app_typography.dart';
import 'design_tokens.dart';

/// Material 3 theme configuration for ChefMind AI
class AppTheme {
  AppTheme._();

  /// Light theme configuration
  static ThemeData get lightTheme {
    final colorScheme = AppColors.lightColorScheme;

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: AppTypography.textTheme,
      
      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: DesignTokens.elevationNone,
        scrolledUnderElevation: DesignTokens.elevationSm,
        centerTitle: true,
        titleTextStyle: AppTypography.appBarTitle.copyWith(
          color: colorScheme.onSurface,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(DesignTokens.radiusLg),
          ),
        ),
      ),

      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: DesignTokens.elevationSm,
          shadowColor: colorScheme.shadow,
          shape: RoundedRectangleBorder(
            borderRadius: DesignTokens.radiusLarge,
          ),
          padding: DesignTokens.buttonPadding,
          minimumSize: const Size(0, DesignTokens.buttonHeight),
          textStyle: AppTypography.buttonText,
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: DesignTokens.radiusLarge,
          ),
          padding: DesignTokens.buttonPadding,
          minimumSize: const Size(0, DesignTokens.buttonHeight),
          textStyle: AppTypography.buttonText,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          side: BorderSide(color: colorScheme.outline),
          shape: RoundedRectangleBorder(
            borderRadius: DesignTokens.radiusLarge,
          ),
          padding: DesignTokens.buttonPadding,
          minimumSize: const Size(0, DesignTokens.buttonHeight),
          textStyle: AppTypography.buttonText,
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: DesignTokens.radiusLarge,
          ),
          padding: DesignTokens.buttonPadding,
          minimumSize: const Size(0, DesignTokens.buttonHeight),
          textStyle: AppTypography.buttonText,
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        elevation: DesignTokens.elevationSm,
        shadowColor: colorScheme.shadow,
        surfaceTintColor: colorScheme.surfaceTint,
        shape: RoundedRectangleBorder(
          borderRadius: DesignTokens.radiusExtraLarge,
        ),
        color: colorScheme.surface,
        margin: const EdgeInsets.all(DesignTokens.spacingSm),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        border: OutlineInputBorder(
          borderRadius: DesignTokens.radiusLarge,
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: DesignTokens.radiusLarge,
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: DesignTokens.radiusLarge,
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: DesignTokens.radiusLarge,
          borderSide: BorderSide(color: colorScheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: DesignTokens.radiusLarge,
          borderSide: BorderSide(color: colorScheme.error, width: 2),
        ),
        contentPadding: DesignTokens.inputPadding,
        hintStyle: AppTypography.hintText.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
        labelStyle: (AppTypography.textTheme.labelLarge ?? AppTypography.chipText).copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
        errorStyle: AppTypography.errorText.copyWith(
          color: colorScheme.error,
        ),
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: colorScheme.surfaceContainerHighest,
        selectedColor: colorScheme.secondaryContainer,
        disabledColor: colorScheme.onSurface.withValues(alpha: 0.12),
        deleteIconColor: colorScheme.onSurfaceVariant,
        labelStyle: AppTypography.chipText.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
        secondaryLabelStyle: AppTypography.chipText.copyWith(
          color: colorScheme.onSecondaryContainer,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusFull),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: DesignTokens.spacingMd,
          vertical: DesignTokens.spacingSm,
        ),
      ),

      // Bottom Navigation Theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.onSurfaceVariant,
        type: BottomNavigationBarType.fixed,
        elevation: DesignTokens.elevationMd,
        selectedLabelStyle: AppTypography.tabLabel.copyWith(
          color: colorScheme.primary,
        ),
        unselectedLabelStyle: AppTypography.tabLabel.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
      ),

      // Navigation Bar Theme (Material 3)
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        indicatorColor: colorScheme.secondaryContainer,
        elevation: DesignTokens.elevationSm,
        height: DesignTokens.bottomNavHeight,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppTypography.tabLabel.copyWith(color: colorScheme.onSurface);
          }
          return AppTypography.tabLabel.copyWith(color: colorScheme.onSurfaceVariant);
        }),
      ),

      // Floating Action Button Theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primaryContainer,
        foregroundColor: colorScheme.onPrimaryContainer,
        elevation: DesignTokens.elevationMd,
        shape: RoundedRectangleBorder(
          borderRadius: DesignTokens.radiusExtraLarge,
        ),
      ),

      // Dialog Theme
      dialogTheme: DialogThemeData(
        backgroundColor: colorScheme.surface,
        surfaceTintColor: colorScheme.surfaceTint,
        elevation: DesignTokens.elevation3xl,
        shape: RoundedRectangleBorder(
          borderRadius: DesignTokens.radiusRounded,
        ),
        titleTextStyle: AppTypography.textTheme.headlineSmall?.copyWith(
          color: colorScheme.onSurface,
        ),
        contentTextStyle: AppTypography.textTheme.bodyMedium?.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
      ),

      // Snackbar Theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colorScheme.inverseSurface,
        contentTextStyle: AppTypography.textTheme.bodyMedium?.copyWith(
          color: colorScheme.onInverseSurface,
        ),
        actionTextColor: colorScheme.inversePrimary,
        shape: RoundedRectangleBorder(
          borderRadius: DesignTokens.radiusLarge,
        ),
        behavior: SnackBarBehavior.floating,
        elevation: DesignTokens.elevationMd,
      ),

      // List Tile Theme
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: DesignTokens.spacingLg,
          vertical: DesignTokens.spacingSm,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: DesignTokens.radiusLarge,
        ),
        titleTextStyle: AppTypography.textTheme.titleMedium?.copyWith(
          color: colorScheme.onSurface,
        ),
        subtitleTextStyle: AppTypography.textTheme.bodyMedium?.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
      ),

      // Divider Theme
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant,
        thickness: 1,
        space: DesignTokens.spacingLg,
      ),

      // Switch Theme
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.onPrimary;
          }
          return colorScheme.outline;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }
          return colorScheme.surfaceContainerHighest;
        }),
      ),

      // Slider Theme
      sliderTheme: SliderThemeData(
        activeTrackColor: colorScheme.primary,
        inactiveTrackColor: colorScheme.surfaceContainerHighest,
        thumbColor: colorScheme.primary,
        overlayColor: colorScheme.primary.withValues(alpha: 0.12),
        valueIndicatorColor: colorScheme.primary,
        valueIndicatorTextStyle: AppTypography.textTheme.labelSmall?.copyWith(
          color: colorScheme.onPrimary,
        ),
      ),
    );
  }

  /// Dark theme configuration
  static ThemeData get darkTheme {
    final colorScheme = AppColors.darkColorScheme;

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: AppTypography.textTheme.apply(
        bodyColor: colorScheme.onSurface,
        displayColor: colorScheme.onSurface,
      ),
      
      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: DesignTokens.elevationNone,
        scrolledUnderElevation: DesignTokens.elevationSm,
        centerTitle: true,
        titleTextStyle: AppTypography.appBarTitle.copyWith(
          color: colorScheme.onSurface,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(DesignTokens.radiusLg),
          ),
        ),
      ),

      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: DesignTokens.elevationSm,
          shadowColor: colorScheme.shadow,
          shape: RoundedRectangleBorder(
            borderRadius: DesignTokens.radiusLarge,
          ),
          padding: DesignTokens.buttonPadding,
          minimumSize: const Size(0, DesignTokens.buttonHeight),
          textStyle: AppTypography.buttonText,
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: DesignTokens.radiusLarge,
          ),
          padding: DesignTokens.buttonPadding,
          minimumSize: const Size(0, DesignTokens.buttonHeight),
          textStyle: AppTypography.buttonText,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          side: BorderSide(color: colorScheme.outline),
          shape: RoundedRectangleBorder(
            borderRadius: DesignTokens.radiusLarge,
          ),
          padding: DesignTokens.buttonPadding,
          minimumSize: const Size(0, DesignTokens.buttonHeight),
          textStyle: AppTypography.buttonText,
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: DesignTokens.radiusLarge,
          ),
          padding: DesignTokens.buttonPadding,
          minimumSize: const Size(0, DesignTokens.buttonHeight),
          textStyle: AppTypography.buttonText,
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        elevation: DesignTokens.elevationSm,
        shadowColor: colorScheme.shadow,
        surfaceTintColor: colorScheme.surfaceTint,
        shape: RoundedRectangleBorder(
          borderRadius: DesignTokens.radiusExtraLarge,
        ),
        color: colorScheme.surface,
        margin: const EdgeInsets.all(DesignTokens.spacingSm),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        border: OutlineInputBorder(
          borderRadius: DesignTokens.radiusLarge,
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: DesignTokens.radiusLarge,
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: DesignTokens.radiusLarge,
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: DesignTokens.radiusLarge,
          borderSide: BorderSide(color: colorScheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: DesignTokens.radiusLarge,
          borderSide: BorderSide(color: colorScheme.error, width: 2),
        ),
        contentPadding: DesignTokens.inputPadding,
        hintStyle: AppTypography.hintText.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
        labelStyle: (AppTypography.textTheme.labelLarge ?? AppTypography.chipText).copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
        errorStyle: AppTypography.errorText.copyWith(
          color: colorScheme.error,
        ),
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: colorScheme.surfaceContainerHighest,
        selectedColor: colorScheme.secondaryContainer,
        disabledColor: colorScheme.onSurface.withValues(alpha: 0.12),
        deleteIconColor: colorScheme.onSurfaceVariant,
        labelStyle: AppTypography.chipText.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
        secondaryLabelStyle: AppTypography.chipText.copyWith(
          color: colorScheme.onSecondaryContainer,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusFull),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: DesignTokens.spacingMd,
          vertical: DesignTokens.spacingSm,
        ),
      ),

      // Bottom Navigation Theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.onSurfaceVariant,
        type: BottomNavigationBarType.fixed,
        elevation: DesignTokens.elevationMd,
        selectedLabelStyle: AppTypography.tabLabel.copyWith(
          color: colorScheme.primary,
        ),
        unselectedLabelStyle: AppTypography.tabLabel.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
      ),

      // Navigation Bar Theme (Material 3)
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        indicatorColor: colorScheme.secondaryContainer,
        elevation: DesignTokens.elevationSm,
        height: DesignTokens.bottomNavHeight,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppTypography.tabLabel.copyWith(color: colorScheme.onSurface);
          }
          return AppTypography.tabLabel.copyWith(color: colorScheme.onSurfaceVariant);
        }),
      ),

      // Floating Action Button Theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primaryContainer,
        foregroundColor: colorScheme.onPrimaryContainer,
        elevation: DesignTokens.elevationMd,
        shape: RoundedRectangleBorder(
          borderRadius: DesignTokens.radiusExtraLarge,
        ),
      ),

      // Dialog Theme
      dialogTheme: DialogThemeData(
        backgroundColor: colorScheme.surface,
        surfaceTintColor: colorScheme.surfaceTint,
        elevation: DesignTokens.elevation3xl,
        shape: RoundedRectangleBorder(
          borderRadius: DesignTokens.radiusRounded,
        ),
        titleTextStyle: AppTypography.textTheme.headlineSmall?.copyWith(
          color: colorScheme.onSurface,
        ),
        contentTextStyle: AppTypography.textTheme.bodyMedium?.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
      ),

      // Snackbar Theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colorScheme.inverseSurface,
        contentTextStyle: AppTypography.textTheme.bodyMedium?.copyWith(
          color: colorScheme.onInverseSurface,
        ),
        actionTextColor: colorScheme.inversePrimary,
        shape: RoundedRectangleBorder(
          borderRadius: DesignTokens.radiusLarge,
        ),
        behavior: SnackBarBehavior.floating,
        elevation: DesignTokens.elevationMd,
      ),

      // List Tile Theme
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: DesignTokens.spacingLg,
          vertical: DesignTokens.spacingSm,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: DesignTokens.radiusLarge,
        ),
        titleTextStyle: AppTypography.textTheme.titleMedium?.copyWith(
          color: colorScheme.onSurface,
        ),
        subtitleTextStyle: AppTypography.textTheme.bodyMedium?.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
      ),

      // Divider Theme
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant,
        thickness: 1,
        space: DesignTokens.spacingLg,
      ),

      // Switch Theme
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.onPrimary;
          }
          return colorScheme.outline;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }
          return colorScheme.surfaceContainerHighest;
        }),
      ),

      // Slider Theme
      sliderTheme: SliderThemeData(
        activeTrackColor: colorScheme.primary,
        inactiveTrackColor: colorScheme.surfaceContainerHighest,
        thumbColor: colorScheme.primary,
        overlayColor: colorScheme.primary.withValues(alpha: 0.12),
        valueIndicatorColor: colorScheme.primary,
        valueIndicatorTextStyle: AppTypography.textTheme.labelSmall?.copyWith(
          color: colorScheme.onPrimary,
        ),
      ),
    );
  }

  /// Get theme based on brightness
  static ThemeData getTheme(Brightness brightness) {
    return brightness == Brightness.light ? lightTheme : darkTheme;
  }

  /// Check if current theme is dark
  static bool isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  /// Get responsive padding based on screen size
  static EdgeInsets getResponsivePadding(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > DesignTokens.breakpointTablet) {
      return const EdgeInsets.all(DesignTokens.spacing3xl);
    } else if (screenWidth > DesignTokens.breakpointMobile) {
      return const EdgeInsets.all(DesignTokens.spacing2xl);
    } else {
      return DesignTokens.screenPadding;
    }
  }
}

/// Theme mode provider for state management
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);

/// Dynamic color support provider
final dynamicColorProvider = StateProvider<bool>((ref) => true);
