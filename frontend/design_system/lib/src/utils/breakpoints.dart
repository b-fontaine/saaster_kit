import 'package:flutter/material.dart';

/// Defines the breakpoints for responsive design
class DSBreakpoints {
  /// Extra small screens (mobile phones)
  static const double xs = 0;
  
  /// Small screens (large phones, small tablets)
  static const double sm = 600;
  
  /// Medium screens (tablets)
  static const double md = 960;
  
  /// Large screens (desktops)
  static const double lg = 1280;
  
  /// Extra large screens (large desktops)
  static const double xl = 1920;

  /// Returns the current breakpoint based on screen width
  static String getBreakpoint(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    
    if (width < sm) return 'xs';
    if (width < md) return 'sm';
    if (width < lg) return 'md';
    if (width < xl) return 'lg';
    return 'xl';
  }

  /// Returns true if the current screen width is less than or equal to the small breakpoint
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < md;
  }

  /// Returns true if the current screen width is between medium and large breakpoints
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= md && width < lg;
  }

  /// Returns true if the current screen width is greater than or equal to the large breakpoint
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= lg;
  }
}
