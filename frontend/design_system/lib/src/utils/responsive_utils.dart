import 'package:flutter/material.dart';
import 'breakpoints.dart';

/// Utility class for responsive design
class ResponsiveUtils {
  // Private constructor to prevent instantiation
  ResponsiveUtils._();

  /// Returns a responsive text style based on screen size
  static TextStyle responsiveTextStyle({
    required BuildContext context,
    required TextStyle defaultStyle,
    TextStyle? sm,
    TextStyle? md,
    TextStyle? lg,
    TextStyle? xl,
  }) {
    return responsiveValue<TextStyle>(
      context: context,
      defaultValue: defaultStyle,
      sm: sm,
      md: md,
      lg: lg,
      xl: xl,
    );
  }
  /// Returns a value based on the current breakpoint
  static T responsiveValue<T>({
    required BuildContext context,
    required T defaultValue,
    T? sm,
    T? md,
    T? lg,
    T? xl,
  }) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    if (screenWidth >= DSBreakpoints.xl && xl != null) return xl;
    if (screenWidth >= DSBreakpoints.lg && lg != null) return lg;
    if (screenWidth >= DSBreakpoints.md && md != null) return md;
    if (screenWidth >= DSBreakpoints.sm && sm != null) return sm;

    return defaultValue;
  }

  /// Returns a font size that scales with the screen size
  static double responsiveFontSize(
    BuildContext context, {
    required double defaultSize,
    double? sm,
    double? md,
    double? lg,
    double? xl,
  }) {
    return responsiveValue<double>(
      context: context,
      defaultValue: defaultSize,
      sm: sm,
      md: md,
      lg: lg,
      xl: xl,
    );
  }

  /// Returns a padding that scales with the screen size
  static EdgeInsets responsivePadding(
    BuildContext context, {
    required EdgeInsets defaultPadding,
    EdgeInsets? sm,
    EdgeInsets? md,
    EdgeInsets? lg,
    EdgeInsets? xl,
  }) {
    return responsiveValue<EdgeInsets>(
      context: context,
      defaultValue: defaultPadding,
      sm: sm,
      md: md,
      lg: lg,
      xl: xl,
    );
  }

  /// Returns a margin that scales with the screen size
  static EdgeInsets responsiveMargin(
    BuildContext context, {
    required EdgeInsets defaultMargin,
    EdgeInsets? sm,
    EdgeInsets? md,
    EdgeInsets? lg,
    EdgeInsets? xl,
  }) {
    return responsiveValue<EdgeInsets>(
      context: context,
      defaultValue: defaultMargin,
      sm: sm,
      md: md,
      lg: lg,
      xl: xl,
    );
  }

  /// Returns a width that scales with the screen size
  static double responsiveWidth(
    BuildContext context, {
    required double percentOfScreen,
    double? maxWidth,
  }) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final calculatedWidth = screenWidth * percentOfScreen;

    if (maxWidth != null && calculatedWidth > maxWidth) {
      return maxWidth;
    }

    return calculatedWidth;
  }

  /// Returns a height that scales with the screen size
  static double responsiveHeight(
    BuildContext context, {
    required double percentOfScreen,
    double? maxHeight,
  }) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final calculatedHeight = screenHeight * percentOfScreen;

    if (maxHeight != null && calculatedHeight > maxHeight) {
      return maxHeight;
    }

    return calculatedHeight;
  }

  /// Returns true if the current screen size is mobile (below md breakpoint)
  static bool isMobile(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return screenWidth < DSBreakpoints.md;
  }

  /// Returns true if the current screen size is tablet (md to lg breakpoint)
  static bool isTablet(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return screenWidth >= DSBreakpoints.md && screenWidth < DSBreakpoints.lg;
  }

  /// Returns true if the current screen size is desktop (lg breakpoint and above)
  static bool isDesktop(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return screenWidth >= DSBreakpoints.lg;
  }
}
