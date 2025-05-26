import 'package:flutter/material.dart';

/// Design System Shadows
class DSShadows {
  // Elevation levels
  static const List<BoxShadow> elevation0 = [];
  
  static const List<BoxShadow> elevation1 = [
    BoxShadow(
      color: Color(0x1A000000),
      blurRadius: 3,
      offset: Offset(0, 1),
    ),
  ];
  
  static const List<BoxShadow> elevation2 = [
    BoxShadow(
      color: Color(0x1F000000),
      blurRadius: 5,
      offset: Offset(0, 2),
    ),
  ];
  
  static const List<BoxShadow> elevation3 = [
    BoxShadow(
      color: Color(0x24000000),
      blurRadius: 8,
      offset: Offset(0, 3),
    ),
  ];
  
  static const List<BoxShadow> elevation4 = [
    BoxShadow(
      color: Color(0x29000000),
      blurRadius: 10,
      offset: Offset(0, 4),
    ),
  ];
  
  static const List<BoxShadow> elevation6 = [
    BoxShadow(
      color: Color(0x29000000),
      blurRadius: 12,
      offset: Offset(0, 6),
    ),
  ];
  
  static const List<BoxShadow> elevation8 = [
    BoxShadow(
      color: Color(0x29000000),
      blurRadius: 14,
      offset: Offset(0, 8),
    ),
  ];
  
  static const List<BoxShadow> elevation12 = [
    BoxShadow(
      color: Color(0x33000000),
      blurRadius: 16,
      offset: Offset(0, 12),
    ),
  ];
  
  static const List<BoxShadow> elevation16 = [
    BoxShadow(
      color: Color(0x33000000),
      blurRadius: 24,
      offset: Offset(0, 16),
    ),
  ];
  
  static const List<BoxShadow> elevation24 = [
    BoxShadow(
      color: Color(0x38000000),
      blurRadius: 32,
      offset: Offset(0, 24),
    ),
  ];
  
  // App Theme Specific Shadows
  static const List<BoxShadow> appCardShadow = elevation2;
  static const List<BoxShadow> appButtonShadow = elevation2;
  static const List<BoxShadow> appDialogShadow = elevation24;
  static const List<BoxShadow> appNavBarShadow = elevation4;
  static const List<BoxShadow> appFloatingActionButtonShadow = elevation6;
  
  // Landing Theme Specific Shadows
  static const List<BoxShadow> landingCardShadow = elevation3;
  static const List<BoxShadow> landingButtonShadow = elevation2;
  static const List<BoxShadow> landingDialogShadow = elevation24;
  static const List<BoxShadow> landingNavBarShadow = elevation4;
  static const List<BoxShadow> landingHeroShadow = elevation8;
  
  // Special Effects
  static const List<BoxShadow> hoverEffect = [
    BoxShadow(
      color: Color(0x33000000),
      blurRadius: 8,
      offset: Offset(0, 4),
    ),
  ];
  
  static const List<BoxShadow> focusEffect = [
    BoxShadow(
      color: Color(0x4D2196F3), // Primary color with opacity
      blurRadius: 4,
      spreadRadius: 2,
      offset: Offset(0, 0),
    ),
  ];
  
  static const List<BoxShadow> landingHoverEffect = [
    BoxShadow(
      color: Color(0x336200EE), // Landing primary color with opacity
      blurRadius: 12,
      spreadRadius: 2,
      offset: Offset(0, 6),
    ),
  ];
  
  // Get shadow by elevation level
  static List<BoxShadow> getShadowByElevation(int elevation) {
    switch (elevation) {
      case 0:
        return elevation0;
      case 1:
        return elevation1;
      case 2:
        return elevation2;
      case 3:
        return elevation3;
      case 4:
        return elevation4;
      case 6:
        return elevation6;
      case 8:
        return elevation8;
      case 12:
        return elevation12;
      case 16:
        return elevation16;
      case 24:
        return elevation24;
      default:
        return elevation0;
    }
  }
}
