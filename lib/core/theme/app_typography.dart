import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Typography system for ChefMind AI following Material 3 guidelines
class AppTypography {
  AppTypography._();

  // Font families
  static const String primaryFontFamily = 'Poppins';
  static const String secondaryFontFamily = 'Inter';

  /// Material 3 Text Theme with custom fonts
  static TextTheme get textTheme => TextTheme(
        // Display styles - for large, prominent text
        displayLarge: GoogleFonts.poppins(
          fontSize: 57,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.25,
          height: 1.12,
        ),
        displayMedium: GoogleFonts.poppins(
          fontSize: 45,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          height: 1.16,
        ),
        displaySmall: GoogleFonts.poppins(
          fontSize: 36,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          height: 1.22,
        ),

        // Headline styles - for section headers
        headlineLarge: GoogleFonts.poppins(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          letterSpacing: 0,
          height: 1.25,
        ),
        headlineMedium: GoogleFonts.poppins(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          letterSpacing: 0,
          height: 1.29,
        ),
        headlineSmall: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          letterSpacing: 0,
          height: 1.33,
        ),

        // Title styles - for card titles and prominent labels
        titleLarge: GoogleFonts.poppins(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          letterSpacing: 0,
          height: 1.27,
        ),
        titleMedium: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.15,
          height: 1.50,
        ),
        titleSmall: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.1,
          height: 1.43,
        ),

        // Label styles - for buttons and small labels
        labelLarge: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          height: 1.43,
        ),
        labelMedium: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          height: 1.33,
        ),
        labelSmall: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          height: 1.45,
        ),

        // Body styles - for main content
        bodyLarge: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
          height: 1.50,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
          height: 1.43,
        ),
        bodySmall: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
          height: 1.33,
        ),
      );

  // Custom text styles for specific use cases
  static TextStyle get recipeTitle => GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        height: 1.3,
      );

  static TextStyle get recipeSubtitle => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        height: 1.4,
      );

  static TextStyle get ingredientText => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        height: 1.5,
      );

  static TextStyle get instructionText => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
        height: 1.6,
      );

  static TextStyle get timerText => GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        height: 1.2,
      );

  static TextStyle get nutritionLabel => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.4,
        height: 1.3,
      );

  static TextStyle get nutritionValue => GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        height: 1.2,
      );

  static TextStyle get chipText => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.4,
        height: 1.2,
      );

  static TextStyle get buttonText => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        height: 1.2,
      );

  static TextStyle get buttonTextLarge => GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        height: 1.2,
      );

  static TextStyle get appBarTitle => GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        height: 1.2,
      );

  static TextStyle get tabLabel => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.4,
        height: 1.2,
      );

  static TextStyle get cardTitle => GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        height: 1.3,
      );

  static TextStyle get cardSubtitle => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        height: 1.4,
      );

  static TextStyle get errorText => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        height: 1.3,
      );

  static TextStyle get hintText => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        height: 1.4,
      );

  static TextStyle get captionText => GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        height: 1.4,
      );

  // Responsive text styles
  static TextStyle getResponsiveTitle(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 768) {
      return textTheme.headlineLarge!;
    } else if (screenWidth > 480) {
      return textTheme.headlineMedium!;
    } else {
      return textTheme.headlineSmall!;
    }
  }

  static TextStyle getResponsiveBody(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 768) {
      return textTheme.bodyLarge!;
    } else {
      return textTheme.bodyMedium!;
    }
  }

  // Text style modifiers
  static TextStyle withColor(TextStyle style, Color color) {
    return style.copyWith(color: color);
  }

  static TextStyle withOpacity(TextStyle style, double opacity) {
    return style.copyWith(color: style.color?.withValues(alpha: opacity));
  }

  static TextStyle withWeight(TextStyle style, FontWeight weight) {
    return style.copyWith(fontWeight: weight);
  }

  static TextStyle withSize(TextStyle style, double size) {
    return style.copyWith(fontSize: size);
  }
}