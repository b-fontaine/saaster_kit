import 'package:flutter/material.dart';
import 'colors.dart';

/// Design System Borders
class DSBorders {
  // Border Radius
  static const double radiusXS = 2.0;
  static const double radiusSM = 4.0;
  static const double radiusMD = 8.0;
  static const double radiusLG = 12.0;
  static const double radiusXL = 16.0;
  static const double radiusXXL = 24.0;
  static const double radiusCircular = 999.0;
  
  // Border Radius - Shapes
  static final BorderRadius borderRadiusXS = BorderRadius.circular(radiusXS);
  static final BorderRadius borderRadiusSM = BorderRadius.circular(radiusSM);
  static final BorderRadius borderRadiusMD = BorderRadius.circular(radiusMD);
  static final BorderRadius borderRadiusLG = BorderRadius.circular(radiusLG);
  static final BorderRadius borderRadiusXL = BorderRadius.circular(radiusXL);
  static final BorderRadius borderRadiusXXL = BorderRadius.circular(radiusXXL);
  static final BorderRadius borderRadiusCircular = BorderRadius.circular(radiusCircular);
  
  // Border Width
  static const double borderWidthThin = 0.5;
  static const double borderWidthRegular = 1.0;
  static const double borderWidthThick = 2.0;
  static const double borderWidthHeavy = 4.0;
  
  // App Theme Borders
  static final Border borderApp = Border.all(
    color: DSColors.divider,
    width: borderWidthRegular,
  );
  
  static final Border borderAppThick = Border.all(
    color: DSColors.divider,
    width: borderWidthThick,
  );
  
  static final Border borderAppPrimary = Border.all(
    color: DSColors.primaryApp,
    width: borderWidthRegular,
  );
  
  static final Border borderAppSecondary = Border.all(
    color: DSColors.secondaryApp,
    width: borderWidthRegular,
  );
  
  static final Border borderAppError = Border.all(
    color: DSColors.errorApp,
    width: borderWidthRegular,
  );
  
  // Landing Theme Borders
  static final Border borderLanding = Border.all(
    color: DSColors.divider,
    width: borderWidthRegular,
  );
  
  static final Border borderLandingThick = Border.all(
    color: DSColors.divider,
    width: borderWidthThick,
  );
  
  static final Border borderLandingPrimary = Border.all(
    color: DSColors.primaryLanding,
    width: borderWidthRegular,
  );
  
  static final Border borderLandingSecondary = Border.all(
    color: DSColors.secondaryLanding,
    width: borderWidthRegular,
  );
  
  static final Border borderLandingError = Border.all(
    color: DSColors.errorLanding,
    width: borderWidthRegular,
  );
  
  // Border Side
  static const BorderSide borderSideApp = BorderSide(
    color: DSColors.divider,
    width: borderWidthRegular,
  );
  
  static const BorderSide borderSideAppPrimary = BorderSide(
    color: DSColors.primaryApp,
    width: borderWidthRegular,
  );
  
  static const BorderSide borderSideLanding = BorderSide(
    color: DSColors.divider,
    width: borderWidthRegular,
  );
  
  static const BorderSide borderSideLandingPrimary = BorderSide(
    color: DSColors.primaryLanding,
    width: borderWidthRegular,
  );
  
  // Input Borders
  static final OutlineInputBorder inputBorderApp = OutlineInputBorder(
    borderRadius: borderRadiusMD,
    borderSide: borderSideApp,
  );
  
  static final OutlineInputBorder inputBorderAppFocused = OutlineInputBorder(
    borderRadius: borderRadiusMD,
    borderSide: borderSideAppPrimary,
  );
  
  static final OutlineInputBorder inputBorderLanding = OutlineInputBorder(
    borderRadius: borderRadiusMD,
    borderSide: borderSideLanding,
  );
  
  static final OutlineInputBorder inputBorderLandingFocused = OutlineInputBorder(
    borderRadius: borderRadiusMD,
    borderSide: borderSideLandingPrimary,
  );
  
  // Dividers
  static const Divider dividerThin = Divider(
    thickness: borderWidthThin,
    color: DSColors.divider,
  );
  
  static const Divider dividerRegular = Divider(
    thickness: borderWidthRegular,
    color: DSColors.divider,
  );
  
  static const Divider dividerThick = Divider(
    thickness: borderWidthThick,
    color: DSColors.divider,
  );
}
