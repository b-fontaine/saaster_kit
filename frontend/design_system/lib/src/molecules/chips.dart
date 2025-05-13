import 'package:flutter/material.dart';
import '../atoms/colors.dart';
import '../atoms/typography.dart';
import '../atoms/borders.dart';
import '../atoms/spacing.dart';
import '../atoms/icons.dart';

/// Design System Chips
class DSChips {
  // Private constructor to prevent instantiation
  DSChips._();
  
  /// Standard chip for the application theme
  static Widget appChip({
    required String label,
    VoidCallback? onTap,
    VoidCallback? onDeleted,
    Color? backgroundColor,
    Color? labelColor,
    Color? deleteIconColor,
    IconData? leadingIcon,
    Color? leadingIconColor,
    EdgeInsets? padding,
    BorderRadius? borderRadius,
    Border? border,
  }) {
    final effectivePadding = padding ?? const EdgeInsets.symmetric(horizontal: 4, vertical: 0);
    final effectiveBorderRadius = borderRadius ?? DSBorders.borderRadiusCircular;
    
    return RawChip(
      label: Text(label),
      labelStyle: DSTypography.appTextTheme.bodySmall?.copyWith(
        color: labelColor ?? DSColors.textPrimary,
      ),
      padding: effectivePadding,
      backgroundColor: backgroundColor ?? Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: effectiveBorderRadius,
        side: border?.top ?? const BorderSide(color: DSColors.divider),
      ),
      onPressed: onTap,
      deleteIcon: Icon(
        DSIcons.close,
        size: 18,
        color: deleteIconColor ?? DSColors.textSecondary,
      ),
      onDeleted: onDeleted,
      avatar: leadingIcon != null
          ? Icon(
              leadingIcon,
              size: 18,
              color: leadingIconColor ?? DSColors.primaryApp,
            )
          : null,
    );
  }
  
  /// Filter chip for the application theme
  static Widget appFilterChip({
    required String label,
    required bool selected,
    required ValueChanged<bool> onSelected,
    Color? backgroundColor,
    Color? selectedBackgroundColor,
    Color? labelColor,
    Color? selectedLabelColor,
    IconData? leadingIcon,
    Color? leadingIconColor,
    Color? selectedLeadingIconColor,
    EdgeInsets? padding,
    BorderRadius? borderRadius,
    Border? border,
  }) {
    final effectivePadding = padding ?? const EdgeInsets.symmetric(horizontal: 4, vertical: 0);
    final effectiveBorderRadius = borderRadius ?? DSBorders.borderRadiusCircular;
    
    return FilterChip(
      label: Text(label),
      labelStyle: DSTypography.appTextTheme.bodySmall?.copyWith(
        color: selected
            ? selectedLabelColor ?? DSColors.primaryApp
            : labelColor ?? DSColors.textPrimary,
      ),
      padding: effectivePadding,
      backgroundColor: backgroundColor ?? Colors.white,
      selectedColor: selectedBackgroundColor ?? DSColors.primaryApp.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: effectiveBorderRadius,
        side: border?.top ?? BorderSide(
          color: selected ? DSColors.primaryApp : DSColors.divider,
        ),
      ),
      onSelected: onSelected,
      selected: selected,
      avatar: leadingIcon != null
          ? Icon(
              leadingIcon,
              size: 18,
              color: selected
                  ? selectedLeadingIconColor ?? DSColors.primaryApp
                  : leadingIconColor ?? DSColors.textSecondary,
            )
          : null,
      checkmarkColor: DSColors.primaryApp,
    );
  }
  
  /// Choice chip for the application theme
  static Widget appChoiceChip({
    required String label,
    required bool selected,
    required ValueChanged<bool> onSelected,
    Color? backgroundColor,
    Color? selectedBackgroundColor,
    Color? labelColor,
    Color? selectedLabelColor,
    EdgeInsets? padding,
    BorderRadius? borderRadius,
    Border? border,
  }) {
    final effectivePadding = padding ?? const EdgeInsets.symmetric(horizontal: 8, vertical: 0);
    final effectiveBorderRadius = borderRadius ?? DSBorders.borderRadiusCircular;
    
    return ChoiceChip(
      label: Text(label),
      labelStyle: DSTypography.appTextTheme.bodySmall?.copyWith(
        color: selected
            ? selectedLabelColor ?? Colors.white
            : labelColor ?? DSColors.textPrimary,
      ),
      padding: effectivePadding,
      backgroundColor: backgroundColor ?? Colors.white,
      selectedColor: selectedBackgroundColor ?? DSColors.primaryApp,
      shape: RoundedRectangleBorder(
        borderRadius: effectiveBorderRadius,
        side: border?.top ?? BorderSide(
          color: selected ? DSColors.primaryApp : DSColors.divider,
        ),
      ),
      onSelected: onSelected,
      selected: selected,
    );
  }
  
  /// Action chip for the application theme
  static Widget appActionChip({
    required String label,
    required VoidCallback onPressed,
    IconData? leadingIcon,
    Color? backgroundColor,
    Color? labelColor,
    Color? iconColor,
    EdgeInsets? padding,
    BorderRadius? borderRadius,
    Border? border,
  }) {
    final effectivePadding = padding ?? const EdgeInsets.symmetric(horizontal: 8, vertical: 0);
    final effectiveBorderRadius = borderRadius ?? DSBorders.borderRadiusCircular;
    
    return ActionChip(
      label: Text(label),
      labelStyle: DSTypography.appTextTheme.bodySmall?.copyWith(
        color: labelColor ?? DSColors.textPrimary,
      ),
      padding: effectivePadding,
      backgroundColor: backgroundColor ?? Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: effectiveBorderRadius,
        side: border?.top ?? const BorderSide(color: DSColors.divider),
      ),
      onPressed: onPressed,
      avatar: leadingIcon != null
          ? Icon(
              leadingIcon,
              size: 18,
              color: iconColor ?? DSColors.primaryApp,
            )
          : null,
    );
  }
  
  /// Tag chip for the landing theme
  static Widget landingTagChip({
    required String label,
    VoidCallback? onTap,
    Color? backgroundColor,
    Color? labelColor,
    EdgeInsets? padding,
    BorderRadius? borderRadius,
    Border? border,
  }) {
    final effectivePadding = padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
    final effectiveBorderRadius = borderRadius ?? DSBorders.borderRadiusCircular;
    
    return InkWell(
      onTap: onTap,
      borderRadius: effectiveBorderRadius,
      child: Container(
        padding: effectivePadding,
        decoration: BoxDecoration(
          color: backgroundColor ?? DSColors.primaryLanding.withOpacity(0.1),
          borderRadius: effectiveBorderRadius,
          border: border,
        ),
        child: Text(
          label,
          style: DSTypography.landingTextTheme.bodySmall?.copyWith(
            color: labelColor ?? DSColors.primaryLanding,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
  
  /// Category chip for the landing theme
  static Widget landingCategoryChip({
    required String label,
    required bool selected,
    required ValueChanged<bool> onSelected,
    Color? backgroundColor,
    Color? selectedBackgroundColor,
    Color? labelColor,
    Color? selectedLabelColor,
    EdgeInsets? padding,
    BorderRadius? borderRadius,
    Border? border,
  }) {
    final effectivePadding = padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
    final effectiveBorderRadius = borderRadius ?? DSBorders.borderRadiusCircular;
    
    return InkWell(
      onTap: () => onSelected(!selected),
      borderRadius: effectiveBorderRadius,
      child: Container(
        padding: effectivePadding,
        decoration: BoxDecoration(
          color: selected
              ? selectedBackgroundColor ?? DSColors.primaryLanding
              : backgroundColor ?? Colors.white,
          borderRadius: effectiveBorderRadius,
          border: border ?? Border.all(
            color: selected ? DSColors.primaryLanding : DSColors.divider,
            width: selected ? 2 : 1,
          ),
        ),
        child: Text(
          label,
          style: DSTypography.landingTextTheme.bodyMedium?.copyWith(
            color: selected
                ? selectedLabelColor ?? Colors.white
                : labelColor ?? DSColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
  
  /// Horizontal chip list for the application theme
  static Widget appChipList({
    required List<Widget> chips,
    double spacing = 8,
    EdgeInsets? padding,
    ScrollPhysics? physics,
  }) {
    final effectivePadding = padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
    
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: physics ?? const BouncingScrollPhysics(),
      padding: effectivePadding,
      child: Row(
        children: [
          for (int i = 0; i < chips.length; i++) ...[
            chips[i],
            if (i < chips.length - 1) SizedBox(width: spacing),
          ],
        ],
      ),
    );
  }
  
  /// Wrap chip list for the application theme
  static Widget appChipWrap({
    required List<Widget> chips,
    double spacing = 8,
    double runSpacing = 8,
    EdgeInsets? padding,
    WrapAlignment alignment = WrapAlignment.start,
  }) {
    final effectivePadding = padding ?? const EdgeInsets.all(0);
    
    return Padding(
      padding: effectivePadding,
      child: Wrap(
        spacing: spacing,
        runSpacing: runSpacing,
        alignment: alignment,
        children: chips,
      ),
    );
  }
}
