import 'package:flutter/material.dart';
import '../atoms/colors.dart';

/// Custom theme extensions for the application theme
class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  final Color success;
  final Color warning;
  final Color info;
  final Color overlay;
  final LinearGradient primaryGradient;
  
  const AppThemeExtension({
    required this.success,
    required this.warning,
    required this.info,
    required this.overlay,
    required this.primaryGradient,
  });
  
  @override
  ThemeExtension<AppThemeExtension> copyWith({
    Color? success,
    Color? warning,
    Color? info,
    Color? overlay,
    LinearGradient? primaryGradient,
  }) {
    return AppThemeExtension(
      success: success ?? this.success,
      warning: warning ?? this.warning,
      info: info ?? this.info,
      overlay: overlay ?? this.overlay,
      primaryGradient: primaryGradient ?? this.primaryGradient,
    );
  }
  
  @override
  ThemeExtension<AppThemeExtension> lerp(
    covariant ThemeExtension<AppThemeExtension>? other,
    double t,
  ) {
    if (other is! AppThemeExtension) {
      return this;
    }
    
    return AppThemeExtension(
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      info: Color.lerp(info, other.info, t)!,
      overlay: Color.lerp(overlay, other.overlay, t)!,
      primaryGradient: LinearGradient.lerp(primaryGradient, other.primaryGradient, t)!,
    );
  }
  
  static const light = AppThemeExtension(
    success: DSColors.successApp,
    warning: DSColors.warningApp,
    info: DSColors.infoApp,
    overlay: DSColors.overlay,
    primaryGradient: DSColors.primaryGradient,
  );
  
  static const dark = AppThemeExtension(
    success: Color(0xFF81C784), // Lighter green for dark theme
    warning: Color(0xFFFFD54F), // Lighter amber for dark theme
    info: Color(0xFF64B5F6), // Lighter blue for dark theme
    overlay: Color(0xB3000000), // Darker overlay for dark theme
    primaryGradient: DSColors.primaryGradient,
  );
}

/// Custom theme extensions for the landing theme
class LandingThemeExtension extends ThemeExtension<LandingThemeExtension> {
  final Color success;
  final Color warning;
  final Color info;
  final Color overlay;
  final LinearGradient primaryGradient;
  
  const LandingThemeExtension({
    required this.success,
    required this.warning,
    required this.info,
    required this.overlay,
    required this.primaryGradient,
  });
  
  @override
  ThemeExtension<LandingThemeExtension> copyWith({
    Color? success,
    Color? warning,
    Color? info,
    Color? overlay,
    LinearGradient? primaryGradient,
  }) {
    return LandingThemeExtension(
      success: success ?? this.success,
      warning: warning ?? this.warning,
      info: info ?? this.info,
      overlay: overlay ?? this.overlay,
      primaryGradient: primaryGradient ?? this.primaryGradient,
    );
  }
  
  @override
  ThemeExtension<LandingThemeExtension> lerp(
    covariant ThemeExtension<LandingThemeExtension>? other,
    double t,
  ) {
    if (other is! LandingThemeExtension) {
      return this;
    }
    
    return LandingThemeExtension(
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      info: Color.lerp(info, other.info, t)!,
      overlay: Color.lerp(overlay, other.overlay, t)!,
      primaryGradient: LinearGradient.lerp(primaryGradient, other.primaryGradient, t)!,
    );
  }
  
  static const light = LandingThemeExtension(
    success: DSColors.successLanding,
    warning: DSColors.warningLanding,
    info: DSColors.infoLanding,
    overlay: DSColors.overlay,
    primaryGradient: DSColors.landingGradient,
  );
  
  static const dark = LandingThemeExtension(
    success: Color(0xFF81C784), // Lighter green for dark theme
    warning: Color(0xFFFFD54F), // Lighter amber for dark theme
    info: Color(0xFF64B5F6), // Lighter blue for dark theme
    overlay: Color(0xB3000000), // Darker overlay for dark theme
    primaryGradient: DSColors.landingGradient,
  );
}
