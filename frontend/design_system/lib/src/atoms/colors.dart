import 'package:flutter/material.dart';

/// Design System Colors
class DSColors {
  // App Theme Colors
  static const Color primaryApp = Color(0xFF2196F3); // Blue
  static const Color secondaryApp = Color(0xFF03DAC6); // Teal
  static const Color accentApp = Color(0xFFFF4081); // Pink
  static const Color backgroundApp = Color(0xFFF5F5F5); // Light Grey
  static const Color surfaceApp = Colors.white;
  static const Color errorApp = Color(0xFFB00020); // Red
  static const Color successApp = Color(0xFF4CAF50); // Green
  static const Color warningApp = Color(0xFFFFC107); // Amber
  static const Color infoApp = Color(0xFF2196F3); // Blue

  // Landing Theme Colors
  static const Color primaryLanding = Color(0xFF6200EE); // Deep Purple
  static const Color secondaryLanding = Color(0xFF03DAC6); // Teal
  static const Color accentLanding = Color(0xFFFF9800); // Orange
  static const Color backgroundLanding = Color(0xFFFFFFFF); // White
  static const Color surfaceLanding = Colors.white;
  static const Color errorLanding = Color(0xFFB00020); // Red
  static const Color successLanding = Color(0xFF4CAF50); // Green
  static const Color warningLanding = Color(0xFFFFC107); // Amber
  static const Color infoLanding = Color(0xFF2196F3); // Blue

  // Text Colors
  static const Color textPrimary = Color(0xFF212121); // Almost Black
  static const Color textSecondary = Color(0xFF757575); // Medium Grey
  static const Color textDisabled = Color(0xFFBDBDBD); // Light Grey
  static const Color textOnPrimary = Colors.white;
  static const Color textOnSecondary = Colors.black;

  // Common Colors
  static const Color divider = Color(0xFFE0E0E0); // Very Light Grey
  static const Color shadow = Color(0x40000000); // Black with opacity
  static const Color overlay = Color(0x80000000); // Black with opacity

  // Icon Colors - App Theme
  static const Color appIconPrimary = primaryApp;
  static const Color appIconSecondary = secondaryApp;
  static const Color appIconDefault = textPrimary;
  static const Color appIconDisabled = textDisabled;
  static const Color appIconOnPrimary = textOnPrimary;
  static const Color appIconError = errorApp;
  static const Color appIconSuccess = successApp;
  static const Color appIconWarning = warningApp;
  static const Color appIconInfo = infoApp;

  // Icon Colors - Landing Theme
  static const Color landingIconPrimary = primaryLanding;
  static const Color landingIconSecondary = secondaryLanding;
  static const Color landingIconDefault = textPrimary;
  static const Color landingIconDisabled = textDisabled;
  static const Color landingIconOnPrimary = textOnPrimary;
  static const Color landingIconError = errorLanding;
  static const Color landingIconSuccess = successLanding;
  static const Color landingIconWarning = warningLanding;
  static const Color landingIconInfo = infoLanding;

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryApp, Color(0xFF64B5F6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient landingGradient = LinearGradient(
    colors: [primaryLanding, Color(0xFF9C27B0)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Color Palette - Shades of primary colors
  static const MaterialColor appPrimarySwatch = MaterialColor(
    0xFF2196F3,
    <int, Color>{
      50: Color(0xFFE3F2FD),
      100: Color(0xFFBBDEFB),
      200: Color(0xFF90CAF9),
      300: Color(0xFF64B5F6),
      400: Color(0xFF42A5F5),
      500: Color(0xFF2196F3),
      600: Color(0xFF1E88E5),
      700: Color(0xFF1976D2),
      800: Color(0xFF1565C0),
      900: Color(0xFF0D47A1),
    },
  );

  static const MaterialColor landingPrimarySwatch = MaterialColor(
    0xFF6200EE,
    <int, Color>{
      50: Color(0xFFF3E5F5),
      100: Color(0xFFE1BEE7),
      200: Color(0xFFCE93D8),
      300: Color(0xFFBA68C8),
      400: Color(0xFFAB47BC),
      500: Color(0xFF9C27B0),
      600: Color(0xFF8E24AA),
      700: Color(0xFF7B1FA2),
      800: Color(0xFF6A1B9A),
      900: Color(0xFF4A148C),
    },
  );
}
