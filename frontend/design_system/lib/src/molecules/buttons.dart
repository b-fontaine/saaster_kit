import 'package:flutter/material.dart';
import '../atoms/colors.dart';
import '../atoms/typography.dart';
import '../atoms/borders.dart';
import '../atoms/spacing.dart';
import '../utils/responsive_utils.dart';

/// Design System Buttons
class DSButtons {
  // Private constructor to prevent instantiation
  DSButtons._();
  
  /// Primary button for the application theme
  static Widget primaryAppButton({
    required String text,
    required VoidCallback onPressed,
    bool isLoading = false,
    bool isFullWidth = false,
    IconData? leadingIcon,
    IconData? trailingIcon,
    EdgeInsets? padding,
    double? minWidth,
    double? height,
    BorderRadius? borderRadius,
    BuildContext? context,
  }) {
    final effectivePadding = padding ?? 
        const EdgeInsets.symmetric(horizontal: 24, vertical: 16);
    final effectiveBorderRadius = borderRadius ?? DSBorders.borderRadiusMD;
    final effectiveHeight = height ?? 48;
    
    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: effectiveHeight,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: DSColors.primaryApp,
          foregroundColor: DSColors.textOnPrimary,
          padding: effectivePadding,
          elevation: 2,
          shadowColor: DSColors.shadow,
          shape: RoundedRectangleBorder(
            borderRadius: effectiveBorderRadius,
          ),
          minimumSize: minWidth != null ? Size(minWidth, effectiveHeight) : null,
        ),
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 2,
                ),
              )
            : _buildButtonContent(
                text: text,
                leadingIcon: leadingIcon,
                trailingIcon: trailingIcon,
                textStyle: context != null
                    ? ResponsiveUtils.responsiveValue<TextStyle>(
                        context: context,
                        defaultValue: DSTypography.appTextTheme.labelLarge!,
                        md: DSTypography.appTextTheme.labelLarge!.copyWith(
                          fontSize: 16,
                        ),
                      )
                    : DSTypography.appTextTheme.labelLarge!,
              ),
      ),
    );
  }
  
  /// Secondary (outlined) button for the application theme
  static Widget secondaryAppButton({
    required String text,
    required VoidCallback onPressed,
    bool isLoading = false,
    bool isFullWidth = false,
    IconData? leadingIcon,
    IconData? trailingIcon,
    EdgeInsets? padding,
    double? minWidth,
    double? height,
    BorderRadius? borderRadius,
    BuildContext? context,
  }) {
    final effectivePadding = padding ?? 
        const EdgeInsets.symmetric(horizontal: 24, vertical: 16);
    final effectiveBorderRadius = borderRadius ?? DSBorders.borderRadiusMD;
    final effectiveHeight = height ?? 48;
    
    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: effectiveHeight,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: DSColors.primaryApp,
          side: const BorderSide(color: DSColors.primaryApp, width: 2),
          padding: effectivePadding,
          shape: RoundedRectangleBorder(
            borderRadius: effectiveBorderRadius,
          ),
          minimumSize: minWidth != null ? Size(minWidth, effectiveHeight) : null,
        ),
        child: isLoading
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(DSColors.primaryApp),
                  strokeWidth: 2,
                ),
              )
            : _buildButtonContent(
                text: text,
                leadingIcon: leadingIcon,
                trailingIcon: trailingIcon,
                textStyle: context != null
                    ? ResponsiveUtils.responsiveValue<TextStyle>(
                        context: context,
                        defaultValue: DSTypography.appTextTheme.labelLarge!,
                        md: DSTypography.appTextTheme.labelLarge!.copyWith(
                          fontSize: 16,
                        ),
                      )
                    : DSTypography.appTextTheme.labelLarge!,
              ),
      ),
    );
  }
  
  /// Text button for the application theme
  static Widget textAppButton({
    required String text,
    required VoidCallback onPressed,
    bool isLoading = false,
    IconData? leadingIcon,
    IconData? trailingIcon,
    EdgeInsets? padding,
    BuildContext? context,
  }) {
    final effectivePadding = padding ?? 
        const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
    
    return TextButton(
      onPressed: isLoading ? null : onPressed,
      style: TextButton.styleFrom(
        foregroundColor: DSColors.primaryApp,
        padding: effectivePadding,
      ),
      child: isLoading
          ? SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(DSColors.primaryApp),
                strokeWidth: 2,
              ),
            )
          : _buildButtonContent(
              text: text,
              leadingIcon: leadingIcon,
              trailingIcon: trailingIcon,
              textStyle: context != null
                  ? ResponsiveUtils.responsiveValue<TextStyle>(
                      context: context,
                      defaultValue: DSTypography.appTextTheme.labelLarge!,
                      md: DSTypography.appTextTheme.labelLarge!.copyWith(
                        fontSize: 16,
                      ),
                    )
                  : DSTypography.appTextTheme.labelLarge!,
            ),
    );
  }
  
  /// Icon button for the application theme
  static Widget iconAppButton({
    required IconData icon,
    required VoidCallback onPressed,
    Color? color,
    double size = 24,
    EdgeInsets? padding,
    String? tooltip,
  }) {
    final effectivePadding = padding ?? const EdgeInsets.all(8);
    
    return IconButton(
      icon: Icon(icon, size: size),
      onPressed: onPressed,
      color: color ?? DSColors.primaryApp,
      padding: effectivePadding,
      tooltip: tooltip,
    );
  }
  
  /// Floating action button for the application theme
  static Widget floatingAppButton({
    required IconData icon,
    required VoidCallback onPressed,
    String? tooltip,
    bool mini = false,
    Color? backgroundColor,
    Color? foregroundColor,
  }) {
    return FloatingActionButton(
      onPressed: onPressed,
      tooltip: tooltip,
      mini: mini,
      backgroundColor: backgroundColor ?? DSColors.primaryApp,
      foregroundColor: foregroundColor ?? DSColors.textOnPrimary,
      elevation: 6,
      child: Icon(icon),
    );
  }
  
  /// Primary button for the landing theme
  static Widget primaryLandingButton({
    required String text,
    required VoidCallback onPressed,
    bool isLoading = false,
    bool isFullWidth = false,
    IconData? leadingIcon,
    IconData? trailingIcon,
    EdgeInsets? padding,
    double? minWidth,
    double? height,
    BorderRadius? borderRadius,
    BuildContext? context,
  }) {
    final effectivePadding = padding ?? 
        const EdgeInsets.symmetric(horizontal: 32, vertical: 20);
    final effectiveBorderRadius = borderRadius ?? DSBorders.borderRadiusMD;
    final effectiveHeight = height ?? 56;
    
    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: effectiveHeight,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: DSColors.primaryLanding,
          foregroundColor: DSColors.textOnPrimary,
          padding: effectivePadding,
          elevation: 2,
          shadowColor: DSColors.shadow,
          shape: RoundedRectangleBorder(
            borderRadius: effectiveBorderRadius,
          ),
          minimumSize: minWidth != null ? Size(minWidth, effectiveHeight) : null,
        ),
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 2,
                ),
              )
            : _buildButtonContent(
                text: text,
                leadingIcon: leadingIcon,
                trailingIcon: trailingIcon,
                textStyle: context != null
                    ? ResponsiveUtils.responsiveValue<TextStyle>(
                        context: context,
                        defaultValue: DSTypography.landingTextTheme.labelLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        md: DSTypography.landingTextTheme.labelLarge!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    : DSTypography.landingTextTheme.labelLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
              ),
      ),
    );
  }
  
  /// Secondary (outlined) button for the landing theme
  static Widget secondaryLandingButton({
    required String text,
    required VoidCallback onPressed,
    bool isLoading = false,
    bool isFullWidth = false,
    IconData? leadingIcon,
    IconData? trailingIcon,
    EdgeInsets? padding,
    double? minWidth,
    double? height,
    BorderRadius? borderRadius,
    BuildContext? context,
  }) {
    final effectivePadding = padding ?? 
        const EdgeInsets.symmetric(horizontal: 32, vertical: 20);
    final effectiveBorderRadius = borderRadius ?? DSBorders.borderRadiusMD;
    final effectiveHeight = height ?? 56;
    
    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: effectiveHeight,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: DSColors.primaryLanding,
          side: const BorderSide(color: DSColors.primaryLanding, width: 2),
          padding: effectivePadding,
          shape: RoundedRectangleBorder(
            borderRadius: effectiveBorderRadius,
          ),
          minimumSize: minWidth != null ? Size(minWidth, effectiveHeight) : null,
        ),
        child: isLoading
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(DSColors.primaryLanding),
                  strokeWidth: 2,
                ),
              )
            : _buildButtonContent(
                text: text,
                leadingIcon: leadingIcon,
                trailingIcon: trailingIcon,
                textStyle: context != null
                    ? ResponsiveUtils.responsiveValue<TextStyle>(
                        context: context,
                        defaultValue: DSTypography.landingTextTheme.labelLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        md: DSTypography.landingTextTheme.labelLarge!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    : DSTypography.landingTextTheme.labelLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
              ),
      ),
    );
  }
  
  /// Helper method to build button content with icons
  static Widget _buildButtonContent({
    required String text,
    IconData? leadingIcon,
    IconData? trailingIcon,
    required TextStyle textStyle,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (leadingIcon != null) ...[
          Icon(leadingIcon, size: 20),
          DSSpacing.horizontalSpacerXS,
        ],
        Text(
          text,
          style: textStyle,
        ),
        if (trailingIcon != null) ...[
          DSSpacing.horizontalSpacerXS,
          Icon(trailingIcon, size: 20),
        ],
      ],
    );
  }
}
