import 'package:flutter/material.dart';
import '../atoms/colors.dart';
import '../atoms/typography.dart';
import '../atoms/spacing.dart';
import '../atoms/icons.dart';
import '../atoms/shadows.dart';
import '../utils/responsive_utils.dart';
import '../utils/breakpoints.dart';

/// Design System App Bars
class DSAppBars {
  // Private constructor to prevent instantiation
  DSAppBars._();

  /// Standard app bar for the application theme
  static PreferredSizeWidget appStandardAppBar({
    required BuildContext context,
    required String title,
    List<Widget>? actions,
    Widget? leading,
    bool centerTitle = false,
    Color? backgroundColor,
    Color? foregroundColor,
    double elevation = 0,
    PreferredSizeWidget? bottom,
    double? toolbarHeight,
    bool automaticallyImplyLeading = true,
  }) {
    return AppBar(
      title: Text(
        title,
        style: ResponsiveUtils.responsiveTextStyle(
          context: context,
          defaultStyle: DSTypography.appTextTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.w500,
          ),
          md: DSTypography.appTextTheme.titleLarge!.copyWith(
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      centerTitle: centerTitle,
      backgroundColor: backgroundColor ?? DSColors.primaryApp,
      foregroundColor: foregroundColor ?? DSColors.textOnPrimary,
      elevation: elevation,
      actions: actions,
      leading: leading,
      bottom: bottom,
      toolbarHeight: toolbarHeight,
      automaticallyImplyLeading: automaticallyImplyLeading,
    );
  }

  /// Transparent app bar for the application theme
  static PreferredSizeWidget appTransparentAppBar({
    required BuildContext context,
    String? title,
    List<Widget>? actions,
    Widget? leading,
    bool centerTitle = false,
    Color? foregroundColor,
    PreferredSizeWidget? bottom,
    double? toolbarHeight,
    bool automaticallyImplyLeading = true,
  }) {
    return AppBar(
      title: title != null
          ? Text(
              title,
              style: ResponsiveUtils.responsiveTextStyle(
                context: context,
                defaultStyle: DSTypography.appTextTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                md: DSTypography.appTextTheme.titleLarge!.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          : null,
      centerTitle: centerTitle,
      backgroundColor: Colors.transparent,
      foregroundColor: foregroundColor ?? DSColors.textPrimary,
      elevation: 0,
      actions: actions,
      leading: leading,
      bottom: bottom,
      toolbarHeight: toolbarHeight,
      automaticallyImplyLeading: automaticallyImplyLeading,
    );
  }

  /// Search app bar for the application theme
  static PreferredSizeWidget appSearchAppBar({
    required BuildContext context,
    required TextEditingController searchController,
    required ValueChanged<String> onSubmitted,
    ValueChanged<String>? onChanged,
    VoidCallback? onClear,
    String hintText = 'Search',
    List<Widget>? actions,
    Widget? leading,
    Color? backgroundColor,
    Color? foregroundColor,
    double elevation = 0,
    PreferredSizeWidget? bottom,
    double? toolbarHeight,
    bool automaticallyImplyLeading = true,
  }) {
    return AppBar(
      title: TextField(
        controller: searchController,
        onSubmitted: onSubmitted,
        onChanged: onChanged,
        style: DSTypography.appTextTheme.bodyLarge?.copyWith(
          color: foregroundColor ?? DSColors.textOnPrimary,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: DSTypography.appTextTheme.bodyLarge?.copyWith(
            color: (foregroundColor ?? DSColors.textOnPrimary).withValues(alpha: (0.7 * 255).toDouble()),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          prefixIcon: Icon(
            DSIcons.search,
            color: foregroundColor ?? DSColors.textOnPrimary,
          ),
          suffixIcon: searchController.text.isNotEmpty
              ? IconButton(
                  icon: Icon(
                    DSIcons.close,
                    color: foregroundColor ?? DSColors.textOnPrimary,
                  ),
                  onPressed: () {
                    searchController.clear();
                    if (onClear != null) {
                      onClear();
                    }
                  },
                )
              : null,
        ),
      ),
      backgroundColor: backgroundColor ?? DSColors.primaryApp,
      foregroundColor: foregroundColor ?? DSColors.textOnPrimary,
      elevation: elevation,
      actions: actions,
      leading: leading,
      bottom: bottom,
      toolbarHeight: toolbarHeight,
      automaticallyImplyLeading: automaticallyImplyLeading,
    );
  }

  /// Sliver app bar for the application theme
  static Widget appSliverAppBar({
    required BuildContext context,
    required String title,
    String? subtitle,
    List<Widget>? actions,
    Widget? leading,
    bool centerTitle = false,
    Color? backgroundColor,
    Color? foregroundColor,
    double expandedHeight = 200,
    Widget? flexibleSpace,
    bool pinned = true,
    bool floating = false,
    bool snap = false,
    PreferredSizeWidget? bottom,
  }) {
    return SliverAppBar(
      title: Text(
        title,
        style: ResponsiveUtils.responsiveTextStyle(
          context: context,
          defaultStyle: DSTypography.appTextTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.w500,
          ),
          md: DSTypography.appTextTheme.titleLarge!.copyWith(
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      centerTitle: centerTitle,
      backgroundColor: backgroundColor ?? DSColors.primaryApp,
      foregroundColor: foregroundColor ?? DSColors.textOnPrimary,
      expandedHeight: expandedHeight,
      flexibleSpace: flexibleSpace ?? FlexibleSpaceBar(
        title: subtitle != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: DSTypography.appTextTheme.titleLarge?.copyWith(
                      color: DSColors.textOnPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: DSTypography.appTextTheme.bodySmall?.copyWith(
                      color: DSColors.textOnPrimary.withValues(alpha: (0.8 * 255).toDouble()),
                    ),
                  ),
                ],
              )
            : null,
        background: Container(
          color: backgroundColor ?? DSColors.primaryApp,
        ),
        centerTitle: centerTitle,
      ),
      pinned: pinned,
      floating: floating,
      snap: snap,
      actions: actions,
      leading: leading,
      bottom: bottom,
    );
  }

  /// Landing page app bar for the landing theme
  static PreferredSizeWidget landingAppBar({
    required BuildContext context,
    required String title,
    List<Widget>? actions,
    Widget? leading,
    bool centerTitle = false,
    Color? backgroundColor,
    Color? foregroundColor,
    double elevation = 0,
    PreferredSizeWidget? bottom,
    double? toolbarHeight,
    bool automaticallyImplyLeading = true,
  }) {
    final isDesktop = DSBreakpoints.isDesktop(context);

    return AppBar(
      title: Text(
        title,
        style: ResponsiveUtils.responsiveTextStyle(
          context: context,
          defaultStyle: DSTypography.landingTextTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.w600,
          ),
          md: DSTypography.landingTextTheme.titleLarge!.copyWith(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
          lg: DSTypography.landingTextTheme.titleLarge!.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      centerTitle: centerTitle,
      backgroundColor: backgroundColor ?? Colors.transparent,
      foregroundColor: foregroundColor ?? DSColors.textPrimary,
      elevation: elevation,
      actions: isDesktop ? actions : null,
      leading: leading,
      bottom: bottom,
      toolbarHeight: toolbarHeight ?? (isDesktop ? 80 : 56),
      automaticallyImplyLeading: automaticallyImplyLeading,
    );
  }

  /// Responsive landing page app bar with navigation for the landing theme
  static PreferredSizeWidget landingNavAppBar({
    required BuildContext context,
    required String title,
    required List<AppBarNavigationItem> navigationItems,
    Widget? actionButton,
    Widget? logo,
    Color? backgroundColor,
    Color? foregroundColor,
    double elevation = 0,
    double? toolbarHeight,
  }) {
    final isDesktop = DSBreakpoints.isDesktop(context);
    final isTablet = DSBreakpoints.isTablet(context);

    if (isDesktop) {
      return AppBar(
        title: logo ?? Text(
          title,
          style: DSTypography.landingTextTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: backgroundColor ?? DSColors.surfaceLanding.withValues(alpha: (0.9 * 255).toDouble()),
        foregroundColor: foregroundColor ?? DSColors.textPrimary,
        elevation: elevation == 0 ? 4 : elevation,
        shadowColor: Colors.black,
        toolbarHeight: toolbarHeight ?? 80,
        centerTitle: false,
        actions: [
          Row(
            children: [
              ...navigationItems.map((item) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextButton(
                  onPressed: item.onTap,
                  child: Text(
                    item.label,
                    style: DSTypography.landingTextTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              )),
              if (actionButton != null) ...[
                DSSpacing.horizontalSpacerMD,
                actionButton,
                DSSpacing.horizontalSpacerMD,
              ],
            ],
          ),
        ],
      );
    } else {
      return AppBar(
        title: logo ?? Text(
          title,
          style: DSTypography.landingTextTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: backgroundColor ?? DSColors.surfaceLanding.withValues(alpha: (0.9 * 255).toDouble()),
        foregroundColor: foregroundColor ?? DSColors.textPrimary,
        elevation: elevation == 0 ? 4 : elevation,
        shadowColor: Colors.black,
        toolbarHeight: toolbarHeight ?? 56,
        centerTitle: false,
        actions: [
          if (isTablet && actionButton != null) actionButton,
          IconButton(
            icon: const Icon(DSIcons.menu),
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
          ),
        ],
      );
    }
  }
}

/// Navigation item for app bars
class AppBarNavigationItem {
  final String label;
  final VoidCallback onTap;
  final bool isActive;
  final IconData? icon;
  final IconData? activeIcon;

  const AppBarNavigationItem({
    required this.label,
    required this.onTap,
    this.isActive = false,
    this.icon,
    this.activeIcon,
  });
}
