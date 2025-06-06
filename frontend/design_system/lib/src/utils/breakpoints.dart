import 'package:flutter/material.dart';

/// Defines the breakpoints for responsive design - Updated to match Tailwind CSS
class DSBreakpoints {
  /// Extra small screens (mobile phones)
  static const double xs = 0;
  
  /// Small screens (large phones, small tablets) - Tailwind sm: 640px
  static const double sm = 640;
  
  /// Medium screens (tablets) - Tailwind md: 768px
  static const double md = 768;
  
  /// Large screens (desktops) - Tailwind lg: 1024px
  static const double lg = 1024;
  
  /// Extra large screens (large desktops) - Tailwind xl: 1280px
  static const double xl = 1280;

  /// Returns the current breakpoint based on screen width
  static String getBreakpoint(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    
    if (width < sm) return 'xs';
    if (width < md) return 'sm';
    if (width < lg) return 'md';
    if (width < xl) return 'lg';
    return 'xl';
  }

  /// Returns true if the current screen width is less than or equal to the small breakpoint
  static bool isMobile(BuildContext context) {
    return MediaQuery.sizeOf(context).width < md;
  }

  /// Returns true if the current screen width is between medium and large breakpoints
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width >= md && width < lg;
  }

  /// Returns true if the current screen width is greater than or equal to the large breakpoint
  static bool isDesktop(BuildContext context) {
    return MediaQuery.sizeOf(context).width >= lg;
  }
}
