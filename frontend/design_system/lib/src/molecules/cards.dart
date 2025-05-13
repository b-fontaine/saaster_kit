import 'package:flutter/material.dart';
import '../atoms/colors.dart';
import '../atoms/typography.dart';
import '../atoms/borders.dart';
import '../atoms/shadows.dart';
import '../atoms/spacing.dart';
import '../utils/responsive_utils.dart';

/// Design System Cards
class DSCards {
  // Private constructor to prevent instantiation
  DSCards._();
  
  /// Standard card for the application theme
  static Widget appCard({
    required Widget child,
    EdgeInsets? padding,
    EdgeInsets? margin,
    Color? backgroundColor,
    BorderRadius? borderRadius,
    List<BoxShadow>? boxShadow,
    Border? border,
    double? width,
    double? height,
    VoidCallback? onTap,
  }) {
    final effectivePadding = padding ?? DSSpacing.paddingMD;
    final effectiveMargin = margin ?? const EdgeInsets.all(0);
    final effectiveBorderRadius = borderRadius ?? DSBorders.borderRadiusMD;
    final effectiveBoxShadow = boxShadow ?? DSShadows.appCardShadow;
    
    final card = Container(
      width: width,
      height: height,
      padding: effectivePadding,
      margin: effectiveMargin,
      decoration: BoxDecoration(
        color: backgroundColor ?? DSColors.surfaceApp,
        borderRadius: effectiveBorderRadius,
        boxShadow: effectiveBoxShadow,
        border: border,
      ),
      child: child,
    );
    
    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: effectiveBorderRadius,
        child: card,
      );
    }
    
    return card;
  }
  
  /// Elevated card for the application theme
  static Widget appElevatedCard({
    required Widget child,
    EdgeInsets? padding,
    EdgeInsets? margin,
    Color? backgroundColor,
    BorderRadius? borderRadius,
    int elevation = 4,
    double? width,
    double? height,
    VoidCallback? onTap,
  }) {
    return appCard(
      child: child,
      padding: padding,
      margin: margin,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
      boxShadow: DSShadows.getShadowByElevation(elevation),
      width: width,
      height: height,
      onTap: onTap,
    );
  }
  
  /// Outlined card for the application theme
  static Widget appOutlinedCard({
    required Widget child,
    EdgeInsets? padding,
    EdgeInsets? margin,
    Color? backgroundColor,
    BorderRadius? borderRadius,
    Border? border,
    double? width,
    double? height,
    VoidCallback? onTap,
  }) {
    return appCard(
      child: child,
      padding: padding,
      margin: margin,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
      boxShadow: DSShadows.elevation0,
      border: border ?? DSBorders.borderApp,
      width: width,
      height: height,
      onTap: onTap,
    );
  }
  
  /// Card with header for the application theme
  static Widget appCardWithHeader({
    required String title,
    required Widget child,
    String? subtitle,
    Widget? leading,
    List<Widget>? actions,
    EdgeInsets? contentPadding,
    EdgeInsets? headerPadding,
    EdgeInsets? margin,
    Color? backgroundColor,
    BorderRadius? borderRadius,
    List<BoxShadow>? boxShadow,
    Border? border,
    double? width,
    VoidCallback? onTap,
    BuildContext? context,
  }) {
    final effectiveContentPadding = contentPadding ?? DSSpacing.paddingMD;
    final effectiveHeaderPadding = headerPadding ?? 
        const EdgeInsets.fromLTRB(16, 16, 16, 0);
    
    return appCard(
      padding: const EdgeInsets.all(0),
      margin: margin,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
      boxShadow: boxShadow,
      border: border,
      width: width,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: effectiveHeaderPadding,
            child: Row(
              children: [
                if (leading != null) ...[
                  leading,
                  DSSpacing.horizontalSpacerMD,
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: context != null
                            ? ResponsiveUtils.responsiveTextStyle(
                                context: context,
                                defaultStyle: DSTypography.appTextTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                                md: DSTypography.appTextTheme.titleMedium!.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            : DSTypography.appTextTheme.titleMedium!.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                      ),
                      if (subtitle != null) ...[
                        DSSpacing.verticalSpacerXXS,
                        Text(
                          subtitle,
                          style: context != null
                              ? ResponsiveUtils.responsiveTextStyle(
                                  context: context,
                                  defaultStyle: DSTypography.appTextTheme.bodyMedium!.copyWith(
                                    color: DSColors.textSecondary,
                                  ),
                                  md: DSTypography.appTextTheme.bodyMedium!.copyWith(
                                    fontSize: 14,
                                    color: DSColors.textSecondary,
                                  ),
                                )
                              : DSTypography.appTextTheme.bodyMedium!.copyWith(
                                  color: DSColors.textSecondary,
                                ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (actions != null) ...actions,
              ],
            ),
          ),
          Padding(
            padding: effectiveContentPadding,
            child: child,
          ),
        ],
      ),
    );
  }
  
  /// Standard card for the landing theme
  static Widget landingCard({
    required Widget child,
    EdgeInsets? padding,
    EdgeInsets? margin,
    Color? backgroundColor,
    BorderRadius? borderRadius,
    List<BoxShadow>? boxShadow,
    Border? border,
    double? width,
    double? height,
    VoidCallback? onTap,
  }) {
    final effectivePadding = padding ?? DSSpacing.paddingLG;
    final effectiveMargin = margin ?? const EdgeInsets.all(0);
    final effectiveBorderRadius = borderRadius ?? DSBorders.borderRadiusLG;
    final effectiveBoxShadow = boxShadow ?? DSShadows.landingCardShadow;
    
    final card = Container(
      width: width,
      height: height,
      padding: effectivePadding,
      margin: effectiveMargin,
      decoration: BoxDecoration(
        color: backgroundColor ?? DSColors.surfaceLanding,
        borderRadius: effectiveBorderRadius,
        boxShadow: effectiveBoxShadow,
        border: border,
      ),
      child: child,
    );
    
    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: effectiveBorderRadius,
        child: card,
      );
    }
    
    return card;
  }
  
  /// Feature card for the landing theme
  static Widget landingFeatureCard({
    required String title,
    required String description,
    required IconData icon,
    EdgeInsets? padding,
    EdgeInsets? margin,
    Color? backgroundColor,
    BorderRadius? borderRadius,
    List<BoxShadow>? boxShadow,
    Border? border,
    double? width,
    VoidCallback? onTap,
    BuildContext? context,
  }) {
    final effectivePadding = padding ?? DSSpacing.paddingLG;
    
    return landingCard(
      padding: effectivePadding,
      margin: margin,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
      boxShadow: boxShadow,
      border: border,
      width: width,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 48,
            color: DSColors.primaryLanding,
          ),
          DSSpacing.verticalSpacerMD,
          Text(
            title,
            style: context != null
                ? ResponsiveUtils.responsiveTextStyle(
                    context: context,
                    defaultStyle: DSTypography.landingTextTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    md: DSTypography.landingTextTheme.titleLarge!.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                : DSTypography.landingTextTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
          ),
          DSSpacing.verticalSpacerSM,
          Text(
            description,
            style: context != null
                ? ResponsiveUtils.responsiveTextStyle(
                    context: context,
                    defaultStyle: DSTypography.landingTextTheme.bodyLarge!,
                    md: DSTypography.landingTextTheme.bodyLarge!.copyWith(
                      fontSize: 16,
                    ),
                  )
                : DSTypography.landingTextTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
  
  /// Pricing card for the landing theme
  static Widget landingPricingCard({
    required String title,
    required String price,
    required String period,
    required List<String> features,
    required VoidCallback onButtonPressed,
    String buttonText = 'Get Started',
    bool isPopular = false,
    EdgeInsets? padding,
    EdgeInsets? margin,
    Color? backgroundColor,
    BorderRadius? borderRadius,
    List<BoxShadow>? boxShadow,
    Border? border,
    double? width,
    BuildContext? context,
  }) {
    final effectivePadding = padding ?? DSSpacing.paddingLG;
    final effectiveBorderRadius = borderRadius ?? DSBorders.borderRadiusLG;
    
    return Container(
      width: width,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor ?? DSColors.surfaceLanding,
        borderRadius: effectiveBorderRadius,
        boxShadow: boxShadow ?? DSShadows.landingCardShadow,
        border: isPopular
            ? Border.all(color: DSColors.primaryLanding, width: 2)
            : border,
      ),
      child: Column(
        children: [
          if (isPopular)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: DSColors.primaryLanding,
                borderRadius: BorderRadius.only(
                  topLeft: effectiveBorderRadius.topLeft,
                  topRight: effectiveBorderRadius.topRight,
                ),
              ),
              child: Text(
                'Most Popular',
                textAlign: TextAlign.center,
                style: DSTypography.landingTextTheme.labelMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          Padding(
            padding: effectivePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: context != null
                      ? ResponsiveUtils.responsiveTextStyle(
                          context: context,
                          defaultStyle: DSTypography.landingTextTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          md: DSTypography.landingTextTheme.titleLarge!.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      : DSTypography.landingTextTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  textAlign: TextAlign.center,
                ),
                DSSpacing.verticalSpacerMD,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '\$',
                      style: DSTypography.landingTextTheme.titleLarge,
                    ),
                    Text(
                      price,
                      style: context != null
                          ? ResponsiveUtils.responsiveTextStyle(
                              context: context,
                              defaultStyle: DSTypography.landingTextTheme.displayMedium!.copyWith(
                                fontWeight: FontWeight.w700,
                                color: DSColors.primaryLanding,
                              ),
                              md: DSTypography.landingTextTheme.displayMedium!.copyWith(
                                fontSize: 64,
                                fontWeight: FontWeight.w700,
                                color: DSColors.primaryLanding,
                              ),
                            )
                          : DSTypography.landingTextTheme.displayMedium!.copyWith(
                              fontWeight: FontWeight.w700,
                              color: DSColors.primaryLanding,
                            ),
                    ),
                  ],
                ),
                Text(
                  period,
                  style: DSTypography.landingTextTheme.bodyMedium?.copyWith(
                    color: DSColors.textSecondary,
                  ),
                ),
                DSSpacing.verticalSpacerLG,
                ...features.map((feature) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: DSColors.successLanding,
                        size: 20,
                      ),
                      DSSpacing.horizontalSpacerSM,
                      Expanded(
                        child: Text(
                          feature,
                          style: DSTypography.landingTextTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                )),
                DSSpacing.verticalSpacerLG,
                SizedBox(
                  width: double.infinity,
                  child: isPopular
                      ? ElevatedButton(
                          onPressed: onButtonPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: DSColors.primaryLanding,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: DSBorders.borderRadiusMD,
                            ),
                          ),
                          child: Text(
                            buttonText,
                            style: DSTypography.landingTextTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      : OutlinedButton(
                          onPressed: onButtonPressed,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: DSColors.primaryLanding,
                            side: const BorderSide(color: DSColors.primaryLanding, width: 2),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: DSBorders.borderRadiusMD,
                            ),
                          ),
                          child: Text(
                            buttonText,
                            style: DSTypography.landingTextTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
