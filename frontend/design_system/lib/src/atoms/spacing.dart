import 'package:flutter/material.dart';

import '../utils/responsive_utils.dart';

/// Design System Spacing
class DSSpacing {
  // Base spacing unit
  static const double _baseUnit = 8.0;

  // Spacing values
  static const double xxxs = _baseUnit * 0.25; // 2
  static const double xxs = _baseUnit * 0.5; // 4
  static const double xs = _baseUnit; // 8
  static const double sm = _baseUnit * 1.5; // 12
  static const double md = _baseUnit * 2; // 16
  static const double lg = _baseUnit * 3; // 24
  static const double xl = _baseUnit * 4; // 32
  static const double xxl = _baseUnit * 6; // 48
  static const double xxxl = _baseUnit * 8; // 64

  // Common padding values
  static const EdgeInsets paddingXXXS = EdgeInsets.all(xxxs);
  static const EdgeInsets paddingXXS = EdgeInsets.all(xxs);
  static const EdgeInsets paddingXS = EdgeInsets.all(xs);
  static const EdgeInsets paddingSM = EdgeInsets.all(sm);
  static const EdgeInsets paddingMD = EdgeInsets.all(md);
  static const EdgeInsets paddingLG = EdgeInsets.all(lg);
  static const EdgeInsets paddingXL = EdgeInsets.all(xl);
  static const EdgeInsets paddingXXL = EdgeInsets.all(xxl);
  static const EdgeInsets paddingXXXL = EdgeInsets.all(xxxl);

  // Horizontal padding values
  static const EdgeInsets paddingHXXXS = EdgeInsets.symmetric(horizontal: xxxs);
  static const EdgeInsets paddingHXXS = EdgeInsets.symmetric(horizontal: xxs);
  static const EdgeInsets paddingHXS = EdgeInsets.symmetric(horizontal: xs);
  static const EdgeInsets paddingHSM = EdgeInsets.symmetric(horizontal: sm);
  static const EdgeInsets paddingHMD = EdgeInsets.symmetric(horizontal: md);
  static const EdgeInsets paddingHLG = EdgeInsets.symmetric(horizontal: lg);
  static const EdgeInsets paddingHXL = EdgeInsets.symmetric(horizontal: xl);
  static const EdgeInsets paddingHXXL = EdgeInsets.symmetric(horizontal: xxl);
  static const EdgeInsets paddingHXXXL = EdgeInsets.symmetric(horizontal: xxxl);

  // Vertical padding values
  static const EdgeInsets paddingVXXXS = EdgeInsets.symmetric(vertical: xxxs);
  static const EdgeInsets paddingVXXS = EdgeInsets.symmetric(vertical: xxs);
  static const EdgeInsets paddingVXS = EdgeInsets.symmetric(vertical: xs);
  static const EdgeInsets paddingVSM = EdgeInsets.symmetric(vertical: sm);
  static const EdgeInsets paddingVMD = EdgeInsets.symmetric(vertical: md);
  static const EdgeInsets paddingVLG = EdgeInsets.symmetric(vertical: lg);
  static const EdgeInsets paddingVXL = EdgeInsets.symmetric(vertical: xl);
  static const EdgeInsets paddingVXXL = EdgeInsets.symmetric(vertical: xxl);
  static const EdgeInsets paddingVXXXL = EdgeInsets.symmetric(vertical: xxxl);

  // Page padding (responsive)
  static EdgeInsets getPagePadding(BuildContext context) {
    return ResponsiveUtils.responsivePadding(
      context,
      defaultPadding: const EdgeInsets.all(md), // Mobile
      sm: const EdgeInsets.all(lg), // Tablet
      lg: const EdgeInsets.symmetric(horizontal: xxl, vertical: xl), // Desktop
    );
  }

  // Content padding (responsive)
  static EdgeInsets getContentPadding(BuildContext context) {
    return ResponsiveUtils.responsivePadding(
      context,
      defaultPadding: const EdgeInsets.all(md), // Mobile
      sm: const EdgeInsets.all(md), // Tablet
      lg: const EdgeInsets.all(lg), // Desktop
    );
  }

  // Section padding (responsive)
  static EdgeInsets getSectionPadding(BuildContext context) {
    return ResponsiveUtils.responsivePadding(
      context,
      defaultPadding: const EdgeInsets.symmetric(vertical: xl), // Mobile
      sm: const EdgeInsets.symmetric(vertical: xxl), // Tablet
      lg: const EdgeInsets.symmetric(vertical: xxxl), // Desktop
    );
  }

  // Spacer widgets
  static const Widget horizontalSpacerXXXS = SizedBox(width: xxxs);
  static const Widget horizontalSpacerXXS = SizedBox(width: xxs);
  static const Widget horizontalSpacerXS = SizedBox(width: xs);
  static const Widget horizontalSpacerSM = SizedBox(width: sm);
  static const Widget horizontalSpacerMD = SizedBox(width: md);
  static const Widget horizontalSpacerLG = SizedBox(width: lg);
  static const Widget horizontalSpacerXL = SizedBox(width: xl);
  static const Widget horizontalSpacerXXL = SizedBox(width: xxl);
  static const Widget horizontalSpacerXXXL = SizedBox(width: xxxl);

  static const Widget verticalSpacerXXXS = SizedBox(height: xxxs);
  static const Widget verticalSpacerXXS = SizedBox(height: xxs);
  static const Widget verticalSpacerXS = SizedBox(height: xs);
  static const Widget verticalSpacerSM = SizedBox(height: sm);
  static const Widget verticalSpacerMD = SizedBox(height: md);
  static const Widget verticalSpacerLG = SizedBox(height: lg);
  static const Widget verticalSpacerXL = SizedBox(height: xl);
  static const Widget verticalSpacerXXL = SizedBox(height: xxl);
  static const Widget verticalSpacerXXXL = SizedBox(height: xxxl);

  /// Returns a responsive spacing value that scales with the screen size
  static double responsiveSpacing(
    BuildContext context, {
    required double defaultValue,
    double? sm,
    double? md,
    double? lg,
    double? xl,
  }) {
    return ResponsiveUtils.responsiveValue<double>(
      context: context,
      defaultValue: defaultValue,
      sm: sm,
      md: md,
      lg: lg,
      xl: xl,
    );
  }
}
