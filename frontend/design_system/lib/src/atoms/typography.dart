import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/responsive_utils.dart';

/// Design System Typography
class DSTypography {
  // App Theme Typography
  static final TextTheme appTextTheme = TextTheme(
    displayLarge: GoogleFonts.roboto(
      fontSize: 96,
      fontWeight: FontWeight.w300,
      letterSpacing: -1.5,
    ),
    displayMedium: GoogleFonts.roboto(
      fontSize: 60,
      fontWeight: FontWeight.w300,
      letterSpacing: -0.5,
    ),
    displaySmall: GoogleFonts.roboto(
      fontSize: 48,
      fontWeight: FontWeight.w400,
    ),
    headlineLarge: GoogleFonts.roboto(
      fontSize: 40,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
    ),
    headlineMedium: GoogleFonts.roboto(
      fontSize: 34,
      fontWeight: FontWeight.w400,
    ),
    headlineSmall: GoogleFonts.roboto(
      fontSize: 24,
      fontWeight: FontWeight.w400,
    ),
    titleLarge: GoogleFonts.roboto(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
    ),
    titleMedium: GoogleFonts.roboto(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
    ),
    titleSmall: GoogleFonts.roboto(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
    ),
    bodyLarge: GoogleFonts.roboto(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
    ),
    bodyMedium: GoogleFonts.roboto(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
    ),
    bodySmall: GoogleFonts.roboto(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
    ),
    labelLarge: GoogleFonts.roboto(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.25,
    ),
    labelMedium: GoogleFonts.roboto(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
    ),
    labelSmall: GoogleFonts.roboto(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      letterSpacing: 1.5,
    ),
  );

  // Landing Theme Typography - using system default fonts to match websitejs
  static final TextTheme landingTextTheme = TextTheme(
    displayLarge: const TextStyle(
      fontSize: 96,
      fontWeight: FontWeight.w300,
      letterSpacing: -1.5,
    ),
    displayMedium: const TextStyle(
      fontSize: 60,
      fontWeight: FontWeight.w300,
      letterSpacing: -0.5,
    ),
    displaySmall: const TextStyle(
      fontSize: 48,
      fontWeight: FontWeight.w400,
    ),
    headlineLarge: const TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
    ),
    headlineMedium: const TextStyle(
      fontSize: 34,
      fontWeight: FontWeight.w400,
    ),
    headlineSmall: const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
    ),
    titleLarge: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
    ),
    titleMedium: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
    ),
    titleSmall: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
    ),
    bodyLarge: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
    ),
    bodyMedium: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
    ),
    bodySmall: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
    ),
    labelLarge: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.25,
    ),
    labelMedium: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
    ),
    labelSmall: const TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      letterSpacing: 1.5,
    ),
  );

  /// Returns a responsive text style that scales with the screen size
  /// Updated to align with Tailwind's responsive typography system
  static TextStyle responsiveTextStyle(
    BuildContext context, {
    required TextStyle defaultStyle,
    TextStyle? sm,
    TextStyle? md,
    TextStyle? lg,
    TextStyle? xl,
  }) {
    return ResponsiveUtils.responsiveValue<TextStyle>(
      context: context,
      defaultValue: defaultStyle,
      sm: sm,
      md: md,
      lg: lg,
      xl: xl,
    );
  }
  
  /// Tailwind-inspired text size utilities to match websitejs - using system default fonts
  static TextStyle textXs(BuildContext context) => const TextStyle(fontSize: 12, letterSpacing: 0.05);
  static TextStyle textSm(BuildContext context) => const TextStyle(fontSize: 14, letterSpacing: 0.025);
  static TextStyle textBase(BuildContext context) => const TextStyle(fontSize: 16);
  static TextStyle textLg(BuildContext context) => const TextStyle(fontSize: 18, letterSpacing: -0.025);
  static TextStyle textXl(BuildContext context) => const TextStyle(fontSize: 20, letterSpacing: -0.025);
  static TextStyle text2Xl(BuildContext context) => const TextStyle(fontSize: 24, letterSpacing: -0.025);
  static TextStyle text3Xl(BuildContext context) => const TextStyle(fontSize: 30, letterSpacing: -0.025);
  static TextStyle text4Xl(BuildContext context) => const TextStyle(fontSize: 36, letterSpacing: -0.025);
  static TextStyle text5Xl(BuildContext context) => const TextStyle(fontSize: 48, letterSpacing: -0.025);
  static TextStyle text6Xl(BuildContext context) => const TextStyle(fontSize: 60, letterSpacing: -0.025);
}
