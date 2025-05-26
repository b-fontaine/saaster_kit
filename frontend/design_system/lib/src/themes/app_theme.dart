import 'package:flutter/material.dart';

import '../atoms/borders.dart';
import '../atoms/colors.dart';
import '../atoms/typography.dart';
import 'theme_extensions.dart';

/// Application Theme
class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();

  /// Light theme for the application
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: DSColors.primaryApp,
        onPrimary: DSColors.textOnPrimary,
        secondary: DSColors.secondaryApp,
        onSecondary: DSColors.textOnSecondary,
        error: DSColors.errorApp,
        onError: Colors.white,
        surface: DSColors.surfaceApp,
        onSurface: DSColors.textPrimary,
      ),
      textTheme: DSTypography.appTextTheme,
      primaryColor: DSColors.primaryApp,
      primarySwatch: DSColors.appPrimarySwatch,
      scaffoldBackgroundColor: DSColors.backgroundApp,
      appBarTheme: AppBarTheme(
        backgroundColor: DSColors.primaryApp,
        foregroundColor: DSColors.textOnPrimary,
        elevation: 0,
        shadowColor: Colors.transparent,
        centerTitle: false,
        titleTextStyle: DSTypography.appTextTheme.titleLarge?.copyWith(
          color: DSColors.textOnPrimary,
          fontWeight: FontWeight.w500,
        ),
      ),
      cardTheme: CardThemeData(
        color: DSColors.surfaceApp,
        elevation: 2,
        shadowColor: DSColors.shadow,
        shape: RoundedRectangleBorder(borderRadius: DSBorders.borderRadiusMD),
        margin: const EdgeInsets.all(8),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: DSColors.primaryApp,
          foregroundColor: DSColors.textOnPrimary,
          elevation: 2,
          shadowColor: DSColors.shadow,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: DSBorders.borderRadiusMD),
          textStyle: DSTypography.appTextTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: DSColors.primaryApp,
          side: const BorderSide(color: DSColors.primaryApp),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: DSBorders.borderRadiusMD),
          textStyle: DSTypography.appTextTheme.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: DSColors.primaryApp,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: DSBorders.borderRadiusMD),
          textStyle: DSTypography.appTextTheme.labelLarge,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        border: DSBorders.inputBorderApp,
        enabledBorder: DSBorders.inputBorderApp,
        focusedBorder: DSBorders.inputBorderAppFocused,
        errorBorder: OutlineInputBorder(
          borderRadius: DSBorders.borderRadiusMD,
          borderSide: const BorderSide(color: DSColors.errorApp),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: DSBorders.borderRadiusMD,
          borderSide: const BorderSide(color: DSColors.errorApp, width: 2),
        ),
        hintStyle: DSTypography.appTextTheme.bodyMedium?.copyWith(
          color: DSColors.textDisabled,
        ),
        labelStyle: DSTypography.appTextTheme.bodyMedium,
        errorStyle: DSTypography.appTextTheme.bodySmall?.copyWith(
          color: DSColors.errorApp,
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: Colors.white,
        disabledColor: Colors.grey[200],
        selectedColor: DSColors.primaryApp.withValues(alpha: (0.1 * 255).toDouble()),
        secondarySelectedColor: DSColors.primaryApp,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        labelStyle: DSTypography.appTextTheme.bodySmall,
        secondaryLabelStyle: DSTypography.appTextTheme.bodySmall?.copyWith(
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
        backgroundColor: DSColors.primaryApp,
        foregroundColor: DSColors.textOnPrimary,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: DSBorders.borderRadiusCircular,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: DSColors.primaryApp,
        unselectedItemColor: DSColors.textSecondary,
        selectedLabelStyle: DSTypography.appTextTheme.labelSmall,
        unselectedLabelStyle: DSTypography.appTextTheme.labelSmall,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: DSColors.primaryApp,
        unselectedLabelColor: DSColors.textSecondary,
        labelStyle: DSTypography.appTextTheme.labelMedium?.copyWith(
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: DSTypography.appTextTheme.labelMedium,
        indicatorColor: DSColors.primaryApp,
        indicatorSize: TabBarIndicatorSize.tab,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: DSColors.surfaceApp,
        elevation: 24,
        shape: RoundedRectangleBorder(borderRadius: DSBorders.borderRadiusLG),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.grey[800],
        contentTextStyle: DSTypography.appTextTheme.bodyMedium?.copyWith(
          color: Colors.white,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: DSBorders.borderRadiusMD),
      ),
      extensions: const [AppThemeExtension.light],
    );
  }

  /// Dark theme for the application
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: DSColors.primaryApp,
        onPrimary: DSColors.textOnPrimary,
        secondary: DSColors.secondaryApp,
        onSecondary: DSColors.textOnSecondary,
        error: DSColors.errorApp,
        onError: Colors.white,
        surface: const Color(0xFF1E1E1E), // Dark surface
        onSurface: Colors.white,
      ),
      textTheme: DSTypography.appTextTheme.apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
      ),
      primaryColor: DSColors.primaryApp,
      primarySwatch: DSColors.appPrimarySwatch,
      scaffoldBackgroundColor: const Color(0xFF121212),
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFF1E1E1E),
        foregroundColor: Colors.white,
        elevation: 0,
        shadowColor: Colors.transparent,
        centerTitle: false,
        titleTextStyle: DSTypography.appTextTheme.titleLarge?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      cardTheme: CardThemeData(
        color: const Color(0xFF1E1E1E),
        elevation: 2,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: DSBorders.borderRadiusMD),
        margin: const EdgeInsets.all(8),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: DSColors.primaryApp,
          foregroundColor: DSColors.textOnPrimary,
          elevation: 2,
          shadowColor: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: DSBorders.borderRadiusMD),
          textStyle: DSTypography.appTextTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: DSColors.primaryApp,
          side: const BorderSide(color: DSColors.primaryApp),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: DSBorders.borderRadiusMD),
          textStyle: DSTypography.appTextTheme.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: DSColors.primaryApp,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: DSBorders.borderRadiusMD),
          textStyle: DSTypography.appTextTheme.labelLarge,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF2C2C2C),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: DSBorders.borderRadiusMD,
          borderSide: const BorderSide(color: Color(0xFF424242)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: DSBorders.borderRadiusMD,
          borderSide: const BorderSide(color: Color(0xFF424242)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: DSBorders.borderRadiusMD,
          borderSide: const BorderSide(color: DSColors.primaryApp),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: DSBorders.borderRadiusMD,
          borderSide: const BorderSide(color: DSColors.errorApp),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: DSBorders.borderRadiusMD,
          borderSide: const BorderSide(color: DSColors.errorApp, width: 2),
        ),
        hintStyle: DSTypography.appTextTheme.bodyMedium?.copyWith(
          color: Colors.grey[400],
        ),
        labelStyle: DSTypography.appTextTheme.bodyMedium?.copyWith(
          color: Colors.white,
        ),
        errorStyle: DSTypography.appTextTheme.bodySmall?.copyWith(
          color: DSColors.errorApp,
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: const Color(0xFF2C2C2C),
        disabledColor: const Color(0xFF1E1E1E),
        selectedColor: DSColors.primaryApp.withValues(alpha: (0.3 * 255).toDouble()),
        secondarySelectedColor: DSColors.primaryApp,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        labelStyle: DSTypography.appTextTheme.bodySmall?.copyWith(
          color: Colors.white,
        ),
        secondaryLabelStyle: DSTypography.appTextTheme.bodySmall?.copyWith(
          color: DSColors.textOnPrimary,
        ),
        brightness: Brightness.dark,
        shape: RoundedRectangleBorder(
          borderRadius: DSBorders.borderRadiusCircular,
          side: const BorderSide(color: Color(0xFF424242)),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: Color(0xFF424242),
        thickness: 1,
        space: 1,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: DSColors.primaryApp,
        foregroundColor: DSColors.textOnPrimary,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: DSBorders.borderRadiusCircular,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: const Color(0xFF1E1E1E),
        selectedItemColor: DSColors.primaryApp,
        unselectedItemColor: Colors.grey[400],
        selectedLabelStyle: DSTypography.appTextTheme.labelSmall,
        unselectedLabelStyle: DSTypography.appTextTheme.labelSmall,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: DSColors.primaryApp,
        unselectedLabelColor: Colors.grey[400],
        labelStyle: DSTypography.appTextTheme.labelMedium?.copyWith(
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: DSTypography.appTextTheme.labelMedium,
        indicatorColor: DSColors.primaryApp,
        indicatorSize: TabBarIndicatorSize.tab,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 24,
        shape: RoundedRectangleBorder(borderRadius: DSBorders.borderRadiusLG),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.grey[900],
        contentTextStyle: DSTypography.appTextTheme.bodyMedium?.copyWith(
          color: Colors.white,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: DSBorders.borderRadiusMD),
      ),
      extensions: const [AppThemeExtension.dark],
    );
  }
}
