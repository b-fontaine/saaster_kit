import 'package:flutter/material.dart';

import '../atoms/borders.dart';
import '../atoms/colors.dart';
import '../atoms/typography.dart';
import 'theme_extensions.dart';

/// Landing Page Theme - Updated to match websitejs Tailwind color scheme
class LandingTheme {
  // Private constructor to prevent instantiation
  LandingTheme._();

  /// Light theme for the landing page - Updated with websitejs color consistency
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: DSColors.primaryLanding, // Now indigo-600 to match websitejs
        onPrimary: DSColors.textOnPrimary,
        secondary: DSColors.secondaryLanding,
        onSecondary: DSColors.textOnSecondary,
        error: DSColors.errorLanding,
        onError: Colors.white,
        surface: DSColors.surfaceLanding,
        onSurface: DSColors.textPrimary,
        // Additional color scheme properties for better websitejs alignment
        surfaceContainerHighest: DSColors.gray50,
        outline: DSColors.gray200,
        outlineVariant: DSColors.gray300,
      ),
      textTheme: DSTypography.landingTextTheme,
      primaryColor: DSColors.primaryLanding,
      primarySwatch: DSColors.landingPrimarySwatch,
      scaffoldBackgroundColor: DSColors.backgroundLanding,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: DSColors.textPrimary,
        elevation: 0,
        shadowColor: Colors.transparent,
        centerTitle: false,
        titleTextStyle: DSTypography.landingTextTheme.titleLarge?.copyWith(
          color: DSColors.textPrimary,
          fontWeight: FontWeight.w500,
        ),
      ),
      cardTheme: CardThemeData(
        color: DSColors.surfaceLanding,
        elevation: 3,
        shadowColor: DSColors.shadow,
        shape: RoundedRectangleBorder(borderRadius: DSBorders.borderRadiusLG),
        margin: const EdgeInsets.all(8),
        // Enhanced shadow for better websitejs parity
        surfaceTintColor: Colors.transparent,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: DSColors.primaryLanding, // indigo-600
          foregroundColor: DSColors.textOnPrimary,
          elevation: 2,
          shadowColor: DSColors.shadow,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: DSBorders.borderRadiusMD),
          textStyle: DSTypography.landingTextTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          // Enhanced hover effects for websitejs parity
          surfaceTintColor: Colors.transparent,
        ).copyWith(
          overlayColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.hovered)) {
                return DSColors.primaryLanding.withValues(alpha: 0.1);
              }
              return null;
            },
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: DSColors.primaryLanding, // indigo-600
          side: const BorderSide(color: DSColors.primaryLanding, width: 2),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: DSBorders.borderRadiusMD),
          textStyle: DSTypography.landingTextTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          // Enhanced hover effects for websitejs parity
          surfaceTintColor: Colors.transparent,
        ).copyWith(
          overlayColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.hovered)) {
                return DSColors.primaryLanding.withValues(alpha: 0.05);
              }
              return null;
            },
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: DSColors.primaryLanding,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: DSBorders.borderRadiusMD),
          textStyle: DSTypography.landingTextTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: DSBorders.inputBorderLanding,
        enabledBorder: DSBorders.inputBorderLanding,
        focusedBorder: DSBorders.inputBorderLandingFocused,
        errorBorder: OutlineInputBorder(
          borderRadius: DSBorders.borderRadiusMD,
          borderSide: const BorderSide(color: DSColors.errorLanding),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: DSBorders.borderRadiusMD,
          borderSide: const BorderSide(color: DSColors.errorLanding, width: 2),
        ),
        hintStyle: DSTypography.landingTextTheme.bodyMedium?.copyWith(
          color: DSColors.textDisabled,
        ),
        labelStyle: DSTypography.landingTextTheme.bodyMedium,
        errorStyle: DSTypography.landingTextTheme.bodySmall?.copyWith(
          color: DSColors.errorLanding,
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: Colors.white,
        disabledColor: Colors.grey[200],
        selectedColor: DSColors.primaryLanding.withValues(alpha: (0.1 * 255).toDouble()),
        secondarySelectedColor: DSColors.primaryLanding,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        labelStyle: DSTypography.landingTextTheme.bodySmall,
        secondaryLabelStyle: DSTypography.landingTextTheme.bodySmall?.copyWith(
          color: DSColors.textOnPrimary,
        ),
        brightness: Brightness.light,
        shape: RoundedRectangleBorder(
          borderRadius: DSBorders.borderRadiusCircular,
          side: const BorderSide(color: DSColors.divider),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: DSColors.divider,
        thickness: 1,
        space: 1,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: DSColors.primaryLanding,
        foregroundColor: DSColors.textOnPrimary,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: DSBorders.borderRadiusCircular,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: DSColors.primaryLanding,
        unselectedItemColor: DSColors.textSecondary,
        selectedLabelStyle: DSTypography.landingTextTheme.labelSmall,
        unselectedLabelStyle: DSTypography.landingTextTheme.labelSmall,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: DSColors.primaryLanding,
        unselectedLabelColor: DSColors.textSecondary,
        labelStyle: DSTypography.landingTextTheme.labelMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: DSTypography.landingTextTheme.labelMedium,
        indicatorColor: DSColors.primaryLanding,
        indicatorSize: TabBarIndicatorSize.tab,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: DSColors.surfaceLanding,
        elevation: 24,
        shape: RoundedRectangleBorder(borderRadius: DSBorders.borderRadiusLG),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.grey[800],
        contentTextStyle: DSTypography.landingTextTheme.bodyMedium?.copyWith(
          color: Colors.white,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: DSBorders.borderRadiusMD),
      ),
      extensions: const [LandingThemeExtension.light],
    );
  }

  /// Dark theme for the landing page - Updated with websitejs color consistency
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: DSColors.primaryLanding, // indigo-600 consistent with light theme
        onPrimary: DSColors.textOnPrimary,
        secondary: DSColors.secondaryLanding,
        onSecondary: DSColors.textOnSecondary,
        error: DSColors.errorLanding,
        onError: Colors.white,
        surface: DSColors.gray900, // Use design system gray-900
        onSurface: Colors.white,
        // Additional color scheme properties for better websitejs alignment
        surfaceContainerHighest: DSColors.gray800,
        outline: DSColors.gray700,
        outlineVariant: DSColors.gray600,
      ),
      textTheme: DSTypography.landingTextTheme.apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
      ),
      primaryColor: DSColors.primaryLanding,
      primarySwatch: DSColors.landingPrimarySwatch,
      scaffoldBackgroundColor: DSColors.gray900, // Use design system gray-900
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        shadowColor: Colors.transparent,
        centerTitle: false,
        titleTextStyle: DSTypography.landingTextTheme.titleLarge?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      cardTheme: CardThemeData(
        color: DSColors.gray800, // Use design system gray-800
        elevation: 3,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: DSBorders.borderRadiusLG),
        margin: const EdgeInsets.all(8),
        // Enhanced shadow for better websitejs parity
        surfaceTintColor: Colors.transparent,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: DSColors.primaryLanding, // indigo-600
          foregroundColor: DSColors.textOnPrimary,
          elevation: 2,
          shadowColor: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: DSBorders.borderRadiusMD),
          textStyle: DSTypography.landingTextTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          // Enhanced hover effects for websitejs parity
          surfaceTintColor: Colors.transparent,
        ).copyWith(
          overlayColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.hovered)) {
                return DSColors.primaryLanding.withValues(alpha: 0.1);
              }
              return null;
            },
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: DSColors.primaryLanding, // indigo-600
          side: const BorderSide(color: DSColors.primaryLanding, width: 2),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: DSBorders.borderRadiusMD),
          textStyle: DSTypography.landingTextTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          // Enhanced hover effects for websitejs parity
          surfaceTintColor: Colors.transparent,
        ).copyWith(
          overlayColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.hovered)) {
                return DSColors.primaryLanding.withValues(alpha: 0.05);
              }
              return null;
            },
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: DSColors.primaryLanding,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: DSBorders.borderRadiusMD),
          textStyle: DSTypography.landingTextTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: DSColors.gray800, // Use design system gray-800
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: DSBorders.borderRadiusMD,
          borderSide: BorderSide(color: DSColors.gray600), // Use design system gray-600
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: DSBorders.borderRadiusMD,
          borderSide: BorderSide(color: DSColors.gray600), // Use design system gray-600
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: DSBorders.borderRadiusMD,
          borderSide: const BorderSide(color: DSColors.primaryLanding),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: DSBorders.borderRadiusMD,
          borderSide: const BorderSide(color: DSColors.errorLanding),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: DSBorders.borderRadiusMD,
          borderSide: const BorderSide(color: DSColors.errorLanding, width: 2),
        ),
        hintStyle: DSTypography.landingTextTheme.bodyMedium?.copyWith(
          color: Colors.grey[400],
        ),
        labelStyle: DSTypography.landingTextTheme.bodyMedium?.copyWith(
          color: Colors.white,
        ),
        errorStyle: DSTypography.landingTextTheme.bodySmall?.copyWith(
          color: DSColors.errorLanding,
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: DSColors.gray800, // Use design system gray-800
        disabledColor: DSColors.gray900, // Use design system gray-900
        selectedColor: DSColors.primaryLanding.withValues(alpha: (0.3 * 255).toDouble()),
        secondarySelectedColor: DSColors.primaryLanding,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        labelStyle: DSTypography.landingTextTheme.bodySmall?.copyWith(
          color: Colors.white,
        ),
        secondaryLabelStyle: DSTypography.landingTextTheme.bodySmall?.copyWith(
          color: DSColors.textOnPrimary,
        ),
        brightness: Brightness.dark,
        shape: RoundedRectangleBorder(
          borderRadius: DSBorders.borderRadiusCircular,
          side: BorderSide(color: DSColors.gray600), // Use design system gray-600
        ),
      ),
      dividerTheme: DividerThemeData(
        color: DSColors.gray600, // Use design system gray-600
        thickness: 1,
        space: 1,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: DSColors.primaryLanding,
        foregroundColor: DSColors.textOnPrimary,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: DSBorders.borderRadiusCircular,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: DSColors.gray800, // Use design system gray-800
        selectedItemColor: DSColors.primaryLanding,
        unselectedItemColor: Colors.grey[400],
        selectedLabelStyle: DSTypography.landingTextTheme.labelSmall,
        unselectedLabelStyle: DSTypography.landingTextTheme.labelSmall,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: DSColors.primaryLanding,
        unselectedLabelColor: Colors.grey[400],
        labelStyle: DSTypography.landingTextTheme.labelMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: DSTypography.landingTextTheme.labelMedium,
        indicatorColor: DSColors.primaryLanding,
        indicatorSize: TabBarIndicatorSize.tab,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: DSColors.gray800, // Use design system gray-800
        elevation: 24,
        shape: RoundedRectangleBorder(borderRadius: DSBorders.borderRadiusLG),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.grey[900],
        contentTextStyle: DSTypography.landingTextTheme.bodyMedium?.copyWith(
          color: Colors.white,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: DSBorders.borderRadiusMD),
      ),
      extensions: const [LandingThemeExtension.dark],
    );
  }
}
