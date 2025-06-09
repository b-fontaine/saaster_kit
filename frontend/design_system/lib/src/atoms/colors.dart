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

  // Landing Theme Colors - Updated to match websitejs
  static const Color primaryLanding = Color(0xFF4F46E5); // Indigo-600 to match websitejs
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
  
  // Additional colors to match websitejs Tailwind classes
  static const Color gray50 = Color(0xFFF9FAFB); // gray-50
  static const Color gray100 = Color(0xFFF3F4F6); // gray-100
  static const Color gray200 = Color(0xFFE5E7EB); // gray-200
  static const Color gray300 = Color(0xFFD1D5DB); // gray-300
  static const Color gray400 = Color(0xFF9CA3AF); // gray-400
  static const Color gray500 = Color(0xFF6B7280); // gray-500
  static const Color gray600 = Color(0xFF4B5563); // gray-600
  static const Color gray700 = Color(0xFF374151); // gray-700
  static const Color gray800 = Color(0xFF1F2937); // gray-800
  static const Color gray900 = Color(0xFF111827); // gray-900

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

  // Landing gradient updated to match websitejs hero gradient
  static const LinearGradient landingGradient = LinearGradient(
    colors: [Color(0xFF4F46E5), Color(0xFF7C3AED)], // indigo-600 to violet-600
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

  // Updated to match websitejs indigo color palette
  static const MaterialColor landingPrimarySwatch = MaterialColor(
    0xFF4F46E5,
    <int, Color>{
      50: Color(0xFFEEF2FF),
      100: Color(0xFFE0E7FF),
      200: Color(0xFFC7D2FE),
      300: Color(0xFFA5B4FC),
      400: Color(0xFF818CF8),
      500: Color(0xFF6366F1),
      600: Color(0xFF4F46E5),
      700: Color(0xFF4338CA),
      800: Color(0xFF3730A3),
      900: Color(0xFF312E81),
    },
  );
}
