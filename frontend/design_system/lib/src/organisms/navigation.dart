import 'package:flutter/material.dart';

import '../atoms/colors.dart';
import '../atoms/icons.dart';
import '../atoms/spacing.dart';
import '../atoms/typography.dart';
import '../utils/breakpoints.dart';

/// Design System Navigation Components
class DSNavigation {
  // Private constructor to prevent instantiation
  DSNavigation._();

  /// Bottom navigation bar for the application theme
  static Widget appBottomNavBar({
    required BuildContext context,
    required List<BottomNavigationItem> items,
    required int currentIndex,
    required ValueChanged<int> onTap,
    Color? backgroundColor,
    Color? selectedItemColor,
    Color? unselectedItemColor,
    double elevation = 8,
    double iconSize = 24,
    double selectedFontSize = 12,
    double unselectedFontSize = 12,
    BottomNavigationBarType type = BottomNavigationBarType.fixed,
  }) {
    return BottomNavigationBar(
      items:
          items
              .map(
                (item) => BottomNavigationBarItem(
                  icon: Icon(item.icon),
                  activeIcon:
                      item.activeIcon != null ? Icon(item.activeIcon) : null,
                  label: item.label,
                  tooltip: item.tooltip,
                  backgroundColor: item.backgroundColor,
                ),
              )
              .toList(),
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: backgroundColor ?? Colors.white,
      selectedItemColor: selectedItemColor ?? DSColors.primaryApp,
      unselectedItemColor: unselectedItemColor ?? DSColors.textSecondary,
      selectedLabelStyle: DSTypography.appTextTheme.labelSmall?.copyWith(
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: DSTypography.appTextTheme.labelSmall,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      elevation: elevation,
      iconSize: iconSize,
      selectedFontSize: selectedFontSize,
      unselectedFontSize: unselectedFontSize,
      type: type,
    );
  }

  /// Navigation rail for the application theme (tablet/desktop)
  static Widget appNavigationRail({
    required BuildContext context,
    required List<NavigationRailItem> items,
    required int selectedIndex,
    required ValueChanged<int> onDestinationSelected,
    Widget? leading,
    Widget? trailing,
    bool extended = false,
    double minWidth = 72,
    double minExtendedWidth = 256,
    Color? backgroundColor,
    Color? selectedItemColor,
    Color? unselectedItemColor,
    NavigationRailLabelType labelType = NavigationRailLabelType.selected,
  }) {
    return NavigationRail(
      destinations:
          items
              .map(
                (item) => NavigationRailDestination(
                  icon: Icon(item.icon),
                  selectedIcon:
                      item.activeIcon != null ? Icon(item.activeIcon) : null,
                  label: Text(item.label),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
              )
              .toList(),
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      leading: leading,
      trailing: trailing,
      extended: extended,
      minWidth: minWidth,
      minExtendedWidth: minExtendedWidth,
      backgroundColor: backgroundColor,
      selectedIconTheme: IconThemeData(
        color: selectedItemColor ?? DSColors.primaryApp,
        size: 24,
      ),
      unselectedIconTheme: IconThemeData(
        color: unselectedItemColor ?? DSColors.textSecondary,
        size: 24,
      ),
      selectedLabelTextStyle: DSTypography.appTextTheme.labelMedium?.copyWith(
        color: selectedItemColor ?? DSColors.primaryApp,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelTextStyle: DSTypography.appTextTheme.labelMedium?.copyWith(
        color: unselectedItemColor ?? DSColors.textSecondary,
      ),
      labelType: labelType,
      useIndicator: true,
      indicatorColor: (selectedItemColor ?? DSColors.primaryApp).withValues(
        alpha: (0.1 * 255).toDouble(),
      ),
    );
  }

  /// Drawer for the application theme
  static Widget appDrawer({
    required BuildContext context,
    required List<DrawerItem> items,
    String? headerTitle,
    String? headerSubtitle,
    Widget? headerLeading,
    Widget? headerTrailing,
    Color? backgroundColor,
    EdgeInsets? padding,
    double width = 304,
  }) {
    final effectivePadding = padding ?? EdgeInsets.zero;

    return Drawer(
      width: width,
      backgroundColor: backgroundColor ?? Colors.white,
      child: SafeArea(
        child: Padding(
          padding: effectivePadding,
          child: Column(
            children: [
              if (headerTitle != null) ...[
                ListTile(
                  title: Text(
                    headerTitle,
                    style: DSTypography.appTextTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle:
                      headerSubtitle != null
                          ? Text(
                            headerSubtitle,
                            style: DSTypography.appTextTheme.bodyMedium
                                ?.copyWith(color: DSColors.textSecondary),
                          )
                          : null,
                  leading: headerLeading,
                  trailing: headerTrailing,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
                const Divider(),
              ],
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    final item = items[index];

                    if (item.isDivider) {
                      return const Divider();
                    }

                    if (item.isHeader) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                        child: Text(
                          item.title,
                          style: DSTypography.appTextTheme.labelSmall?.copyWith(
                            color: DSColors.textSecondary,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.2,
                          ),
                        ),
                      );
                    }

                    return ListTile(
                      title: Text(item.title),
                      subtitle:
                          item.subtitle != null ? Text(item.subtitle!) : null,
                      leading: item.icon != null ? Icon(item.icon) : null,
                      trailing: item.trailing,
                      selected: item.isSelected,
                      onTap: item.onTap,
                      selectedColor: DSColors.primaryApp,
                      selectedTileColor: DSColors.primaryApp.withValues(alpha: (0.1 * 255).toDouble()),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 0,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Tab bar for the application theme
  static Widget appTabBar({
    required BuildContext context,
    required List<String> tabs,
    required TabController tabController,
    bool isScrollable = false,
    Color? labelColor,
    Color? unselectedLabelColor,
    Color? indicatorColor,
    double indicatorWeight = 2,
    TabBarIndicatorSize indicatorSize = TabBarIndicatorSize.tab,
    EdgeInsets? padding,
    EdgeInsets? labelPadding,
  }) {
    final effectivePadding = padding ?? EdgeInsets.zero;
    final effectiveLabelPadding =
        labelPadding ??
        const EdgeInsets.symmetric(horizontal: 16, vertical: 12);

    return Padding(
      padding: effectivePadding,
      child: TabBar(
        controller: tabController,
        tabs: tabs.map((tab) => Tab(text: tab)).toList(),
        isScrollable: isScrollable,
        labelColor: labelColor ?? DSColors.primaryApp,
        unselectedLabelColor: unselectedLabelColor ?? DSColors.textSecondary,
        labelStyle: DSTypography.appTextTheme.labelMedium?.copyWith(
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: DSTypography.appTextTheme.labelMedium,
        indicatorColor: indicatorColor ?? DSColors.primaryApp,
        indicatorWeight: indicatorWeight,
        indicatorSize: indicatorSize,
        labelPadding: effectiveLabelPadding,
      ),
    );
  }

  /// Responsive navigation for the application theme
  static Widget appResponsiveNavigation({
    required BuildContext context,
    required List<NavigationItem> items,
    required int selectedIndex,
    required ValueChanged<int> onItemSelected,
    required Widget body,
    String? appTitle,
    Widget? appLogo,
    List<Widget>? appBarActions,
    Widget? floatingActionButton,
    bool extendedRail = false,
    Widget? railLeading,
    Widget? railTrailing,
    Widget? bottomNavBarTrailing,
  }) {
    final isDesktop = DSBreakpoints.isDesktop(context);
    final isTablet = DSBreakpoints.isTablet(context);

    if (isDesktop) {
      // Desktop: Navigation Rail (extended)
      return Scaffold(
        body: Row(
          children: [
            appNavigationRail(
              context: context,
              items:
                  items
                      .map(
                        (item) => NavigationRailItem(
                          icon: item.icon,
                          activeIcon: item.activeIcon,
                          label: item.label,
                        ),
                      )
                      .toList(),
              selectedIndex: selectedIndex,
              onDestinationSelected: onItemSelected,
              extended: extendedRail,
              leading: railLeading,
              trailing: railTrailing,
            ),
            const VerticalDivider(width: 1, thickness: 1),
            Expanded(
              child: Scaffold(
                appBar: AppBar(
                  title: appLogo ?? (appTitle != null ? Text(appTitle) : null),
                  actions: appBarActions,
                  backgroundColor: Colors.white,
                  foregroundColor: DSColors.textPrimary,
                  elevation: 0,
                ),
                body: body,
                floatingActionButton: floatingActionButton,
              ),
            ),
          ],
        ),
      );
    } else if (isTablet) {
      // Tablet: Navigation Rail (collapsed)
      return Scaffold(
        body: Row(
          children: [
            appNavigationRail(
              context: context,
              items:
                  items
                      .map(
                        (item) => NavigationRailItem(
                          icon: item.icon,
                          activeIcon: item.activeIcon,
                          label: item.label,
                        ),
                      )
                      .toList(),
              selectedIndex: selectedIndex,
              onDestinationSelected: onItemSelected,
              extended: false,
              leading: railLeading,
            ),
            const VerticalDivider(width: 1, thickness: 1),
            Expanded(
              child: Scaffold(
                appBar: AppBar(
                  title: appLogo ?? (appTitle != null ? Text(appTitle) : null),
                  actions: appBarActions,
                  backgroundColor: Colors.white,
                  foregroundColor: DSColors.textPrimary,
                  elevation: 0,
                ),
                body: body,
                floatingActionButton: floatingActionButton,
              ),
            ),
          ],
        ),
      );
    } else {
      // Mobile: Bottom Navigation Bar
      return Scaffold(
        appBar: AppBar(
          title: appLogo ?? (appTitle != null ? Text(appTitle) : null),
          actions: appBarActions,
          backgroundColor: Colors.white,
          foregroundColor: DSColors.textPrimary,
          elevation: 0,
        ),
        body: body,
        bottomNavigationBar: appBottomNavBar(
          context: context,
          items:
              items
                  .map(
                    (item) => BottomNavigationItem(
                      icon: item.icon,
                      activeIcon: item.activeIcon,
                      label: item.label,
                    ),
                  )
                  .toList(),
          currentIndex: selectedIndex,
          onTap: onItemSelected,
        ),
        floatingActionButton: floatingActionButton,
      );
    }
  }

  /// Mobile drawer for the landing theme
  static Widget landingMobileDrawer({
    required BuildContext context,
    required List<DrawerItem> items,
    String? headerTitle,
    Widget? headerLogo,
    Widget? actionButton,
    Color? backgroundColor,
    EdgeInsets? padding,
    double width = 304,
  }) {
    final effectivePadding = padding ?? EdgeInsets.zero;

    return Drawer(
      width: width,
      backgroundColor: backgroundColor ?? Colors.white,
      child: SafeArea(
        child: Padding(
          padding: effectivePadding,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    if (headerLogo != null) ...[
                      headerLogo,
                      DSSpacing.horizontalSpacerMD,
                    ],
                    if (headerTitle != null)
                      Expanded(
                        child: Text(
                          headerTitle,
                          style: DSTypography.landingTextTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                    IconButton(
                      icon: const Icon(DSIcons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    final item = items[index];

                    if (item.isDivider) {
                      return const Divider();
                    }

                    if (item.isHeader) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                        child: Text(
                          item.title,
                          style: DSTypography.landingTextTheme.labelSmall
                              ?.copyWith(
                                color: DSColors.textSecondary,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1.2,
                              ),
                        ),
                      );
                    }

                    return ListTile(
                      title: Text(
                        item.title,
                        style: DSTypography.landingTextTheme.titleSmall
                            ?.copyWith(
                              fontWeight:
                                  item.isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                            ),
                      ),
                      subtitle:
                          item.subtitle != null ? Text(item.subtitle!) : null,
                      leading: item.icon != null ? Icon(item.icon) : null,
                      trailing: item.trailing,
                      selected: item.isSelected,
                      onTap: item.onTap,
                      selectedColor: DSColors.primaryLanding,
                      selectedTileColor: DSColors.primaryLanding.withValues(
                        alpha: (0.1 * 255).toDouble(),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                    );
                  },
                ),
              ),
              if (actionButton != null) ...[
                const Divider(),
                Padding(padding: const EdgeInsets.all(16), child: actionButton),
              ],
            ],
          ),
        ),
      ),
    );
  }

  /// Breadcrumbs for the application theme
  static Widget appBreadcrumbs({
    required BuildContext context,
    required List<BreadcrumbItem> items,
    Widget separator = const Icon(
      Icons.chevron_right,
      size: 16,
      color: DSColors.textSecondary,
    ),
    TextStyle? textStyle,
    EdgeInsets? padding,
  }) {
    final effectivePadding =
        padding ?? const EdgeInsets.symmetric(vertical: 8, horizontal: 16);
    final effectiveTextStyle =
        textStyle ??
        DSTypography.appTextTheme.bodySmall?.copyWith(
          color: DSColors.textSecondary,
        );

    return Padding(
      padding: effectivePadding,
      child: Wrap(
        children: [
          for (int i = 0; i < items.length; i++) ...[
            if (i == items.length - 1)
              Text(
                items[i].label,
                style: effectiveTextStyle?.copyWith(
                  color: DSColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              )
            else
              InkWell(
                onTap: items[i].onTap,
                child: Text(
                  items[i].label,
                  style: effectiveTextStyle?.copyWith(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            if (i < items.length - 1)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: separator,
              ),
          ],
        ],
      ),
    );
  }
}

/// Bottom navigation item
class BottomNavigationItem {
  final IconData icon;
  final IconData? activeIcon;
  final String label;
  final String? tooltip;
  final Color? backgroundColor;

  BottomNavigationItem({
    required this.icon,
    this.activeIcon,
    required this.label,
    this.tooltip,
    this.backgroundColor,
  });
}

/// Navigation rail item
class NavigationRailItem {
  final IconData icon;
  final IconData? activeIcon;
  final String label;

  NavigationRailItem({
    required this.icon,
    this.activeIcon,
    required this.label,
  });
}

/// Drawer item
class DrawerItem {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool isSelected;
  final bool isDivider;
  final bool isHeader;

  DrawerItem({
    required this.title,
    this.subtitle,
    this.icon,
    this.trailing,
    this.onTap,
    this.isSelected = false,
    this.isDivider = false,
    this.isHeader = false,
  });

  /// Creates a divider item
  factory DrawerItem.divider() {
    return DrawerItem(title: '', isDivider: true);
  }

  /// Creates a header item
  factory DrawerItem.header(String title) {
    return DrawerItem(title: title, isHeader: true);
  }
}

/// Navigation item for responsive navigation
class NavigationItem {
  final IconData icon;
  final IconData? activeIcon;
  final String label;

  NavigationItem({required this.icon, this.activeIcon, required this.label});
}

/// Breadcrumb item
class BreadcrumbItem {
  final String label;
  final VoidCallback? onTap;

  BreadcrumbItem({required this.label, this.onTap});
}
