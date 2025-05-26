import 'package:flutter/material.dart';
import '../atoms/colors.dart';
import '../atoms/typography.dart';
import '../atoms/spacing.dart';
import '../atoms/borders.dart';
import '../atoms/shadows.dart';
import '../utils/responsive_utils.dart';

/// Design System Lists
class DSLists {
  // Private constructor to prevent instantiation
  DSLists._();
  
  /// Standard list item for the application theme
  static Widget appListItem({
    required String title,
    String? subtitle,
    Widget? leading,
    Widget? trailing,
    VoidCallback? onTap,
    bool selected = false,
    EdgeInsets? contentPadding,
    Color? backgroundColor,
    BorderRadius? borderRadius,
    Border? border,
    BuildContext? context,
  }) {
    final effectiveContentPadding = contentPadding ?? 
        const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
    final effectiveBorderRadius = borderRadius ?? BorderRadius.zero;
    
    return Material(
      color: backgroundColor ?? (selected ? DSColors.primaryApp.withOpacity(0.1) : Colors.transparent),
      borderRadius: effectiveBorderRadius,
      child: InkWell(
        onTap: onTap,
        borderRadius: effectiveBorderRadius,
        child: Container(
          padding: effectiveContentPadding,
          decoration: BoxDecoration(
            borderRadius: effectiveBorderRadius,
            border: border,
          ),
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
                              defaultStyle: DSTypography.appTextTheme.titleSmall!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: selected ? DSColors.primaryApp : DSColors.textPrimary,
                              ),
                              md: DSTypography.appTextTheme.titleSmall!.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: selected ? DSColors.primaryApp : DSColors.textPrimary,
                              ),
                            )
                          : DSTypography.appTextTheme.titleSmall!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: selected ? DSColors.primaryApp : DSColors.textPrimary,
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
              if (trailing != null) ...[
                DSSpacing.horizontalSpacerMD,
                trailing,
              ],
            ],
          ),
        ),
      ),
    );
  }
  
  /// Card list item for the application theme
  static Widget appCardListItem({
    required String title,
    String? subtitle,
    Widget? leading,
    Widget? trailing,
    VoidCallback? onTap,
    bool selected = false,
    EdgeInsets? contentPadding,
    EdgeInsets? margin,
    Color? backgroundColor,
    BorderRadius? borderRadius,
    List<BoxShadow>? boxShadow,
    BuildContext? context,
  }) {
    final effectiveContentPadding = contentPadding ?? 
        const EdgeInsets.all(16);
    final effectiveMargin = margin ?? 
        const EdgeInsets.symmetric(vertical: 4, horizontal: 16);
    final effectiveBorderRadius = borderRadius ?? DSBorders.borderRadiusMD;
    final effectiveBoxShadow = boxShadow ?? DSShadows.elevation1;
    
    return Container(
      margin: effectiveMargin,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: effectiveBorderRadius,
        boxShadow: effectiveBoxShadow,
      ),
      child: appListItem(
        title: title,
        subtitle: subtitle,
        leading: leading,
        trailing: trailing,
        onTap: onTap,
        selected: selected,
        contentPadding: effectiveContentPadding,
        borderRadius: effectiveBorderRadius,
        context: context,
      ),
    );
  }
  
  /// Sectioned list for the application theme
  static Widget appSectionedList({
    required List<ListSection> sections,
    ScrollPhysics? physics,
    EdgeInsets? padding,
    bool shrinkWrap = false,
    ScrollController? controller,
    bool showDividers = true,
    BuildContext? context,
  }) {
    final effectivePadding = padding ?? EdgeInsets.zero;
    
    return ListView.builder(
      physics: physics,
      padding: effectivePadding,
      shrinkWrap: shrinkWrap,
      controller: controller,
      itemCount: sections.length,
      itemBuilder: (context, index) {
        final section = sections[index];
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (section.title != null) ...[
              Padding(
                padding: section.titlePadding ?? const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text(
                  section.title!,
                  style: ResponsiveUtils.responsiveTextStyle(
                    context: context,
                    defaultStyle: DSTypography.appTextTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    md: DSTypography.appTextTheme.titleMedium!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
            ...section.items.map((item) => Column(
              children: [
                item,
                if (showDividers && section.items.last != item)
                  const Divider(indent: 16, endIndent: 16),
              ],
            )).toList(),
            if (index < sections.length - 1)
              DSSpacing.verticalSpacerMD,
          ],
        );
      },
    );
  }
  
  /// Grid list for the application theme
  static Widget appGridList({
    required List<Widget> items,
    required int crossAxisCount,
    double mainAxisSpacing = 8,
    double crossAxisSpacing = 8,
    EdgeInsets? padding,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    ScrollController? controller,
    double? childAspectRatio,
  }) {
    final effectivePadding = padding ?? const EdgeInsets.all(16);
    
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: mainAxisSpacing,
        crossAxisSpacing: crossAxisSpacing,
        childAspectRatio: childAspectRatio ?? 1.0,
      ),
      padding: effectivePadding,
      physics: physics,
      shrinkWrap: shrinkWrap,
      controller: controller,
      itemCount: items.length,
      itemBuilder: (context, index) => items[index],
    );
  }
  
  /// Responsive grid list for the application theme
  static Widget appResponsiveGridList({
    required BuildContext context,
    required List<Widget> items,
    required Map<String, int> breakpointCounts,
    double mainAxisSpacing = 8,
    double crossAxisSpacing = 8,
    EdgeInsets? padding,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    ScrollController? controller,
    double? childAspectRatio,
  }) {
    final width = MediaQuery.sizeOf(context).width;
    int crossAxisCount = breakpointCounts['xs'] ?? 1;
    
    if (width >= 1280 && breakpointCounts.containsKey('lg')) {
      crossAxisCount = breakpointCounts['lg']!;
    } else if (width >= 960 && breakpointCounts.containsKey('md')) {
      crossAxisCount = breakpointCounts['md']!;
    } else if (width >= 600 && breakpointCounts.containsKey('sm')) {
      crossAxisCount = breakpointCounts['sm']!;
    }
    
    return appGridList(
      items: items,
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: mainAxisSpacing,
      crossAxisSpacing: crossAxisSpacing,
      padding: padding,
      physics: physics,
      shrinkWrap: shrinkWrap,
      controller: controller,
      childAspectRatio: childAspectRatio,
    );
  }
  
  /// Horizontal list for the application theme
  static Widget appHorizontalList({
    required List<Widget> items,
    double spacing = 16,
    EdgeInsets? padding,
    ScrollPhysics? physics,
    ScrollController? controller,
    double? itemWidth,
    double? itemHeight,
  }) {
    final effectivePadding = padding ?? const EdgeInsets.symmetric(horizontal: 16);
    
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: physics ?? const BouncingScrollPhysics(),
      controller: controller,
      padding: effectivePadding,
      child: Row(
        children: [
          for (int i = 0; i < items.length; i++) ...[
            if (itemWidth != null || itemHeight != null)
              SizedBox(
                width: itemWidth,
                height: itemHeight,
                child: items[i],
              )
            else
              items[i],
            if (i < items.length - 1) SizedBox(width: spacing),
          ],
        ],
      ),
    );
  }
  
  /// List with pull-to-refresh for the application theme
  static Widget appRefreshableList({
    required BuildContext context,
    required List<Widget> items,
    required Future<void> Function() onRefresh,
    ScrollPhysics? physics,
    EdgeInsets? padding,
    bool shrinkWrap = false,
    ScrollController? controller,
    bool showDividers = true,
    Widget? emptyWidget,
    Widget? loadingWidget,
    bool isLoading = false,
  }) {
    final effectivePadding = padding ?? const EdgeInsets.symmetric(vertical: 8);
    
    if (isLoading && loadingWidget != null) {
      return loadingWidget;
    }
    
    if (items.isEmpty && emptyWidget != null) {
      return emptyWidget;
    }
    
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: DSColors.primaryApp,
      child: ListView.separated(
        physics: physics ?? const AlwaysScrollableScrollPhysics(),
        padding: effectivePadding,
        shrinkWrap: shrinkWrap,
        controller: controller,
        itemCount: items.length,
        separatorBuilder: (context, index) => showDividers
            ? const Divider(indent: 16, endIndent: 16)
            : const SizedBox(height: 0),
        itemBuilder: (context, index) => items[index],
      ),
    );
  }
  
  /// Infinite scrolling list for the application theme
  static Widget appInfiniteList({
    required BuildContext context,
    required List<Widget> items,
    required Future<void> Function() onLoadMore,
    required bool hasMoreItems,
    ScrollPhysics? physics,
    EdgeInsets? padding,
    bool shrinkWrap = false,
    ScrollController? controller,
    bool showDividers = true,
    Widget? emptyWidget,
    Widget? loadingWidget,
    bool isLoading = false,
    int loadMoreThreshold = 3,
  }) {
    final effectivePadding = padding ?? const EdgeInsets.symmetric(vertical: 8);
    final effectiveController = controller ?? ScrollController();
    
    if (isLoading && items.isEmpty && loadingWidget != null) {
      return loadingWidget;
    }
    
    if (items.isEmpty && emptyWidget != null) {
      return emptyWidget;
    }
    
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
            hasMoreItems && !isLoading) {
          onLoadMore();
        } else if (!hasMoreItems && !isLoading && 
            items.length > loadMoreThreshold &&
            scrollInfo.metrics.pixels > 
            scrollInfo.metrics.maxScrollExtent - 200) {
          // Pre-load when approaching the end
          onLoadMore();
        }
        return false;
      },
      child: ListView.separated(
        physics: physics,
        padding: effectivePadding,
        shrinkWrap: shrinkWrap,
        controller: effectiveController,
        itemCount: items.length + (hasMoreItems ? 1 : 0),
        separatorBuilder: (context, index) => showDividers
            ? const Divider(indent: 16, endIndent: 16)
            : const SizedBox(height: 0),
        itemBuilder: (context, index) {
          if (index == items.length && hasMoreItems) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return index < items.length ? items[index] : const SizedBox();
        },
      ),
    );
  }
  
  /// Expandable list item for the application theme
  static Widget appExpandableListItem({
    required String title,
    required Widget content,
    String? subtitle,
    Widget? leading,
    bool initiallyExpanded = false,
    EdgeInsets? headerPadding,
    EdgeInsets? contentPadding,
    Color? backgroundColor,
    BorderRadius? borderRadius,
    BuildContext? context,
  }) {
    final effectiveHeaderPadding = headerPadding ?? 
        const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
    final effectiveContentPadding = contentPadding ?? 
        const EdgeInsets.fromLTRB(16, 0, 16, 16);
    final effectiveBorderRadius = borderRadius ?? DSBorders.borderRadiusMD;
    
    return ExpansionTile(
      title: Text(
        title,
        style: context != null
            ? ResponsiveUtils.responsiveTextStyle(
                context: context,
                defaultStyle: DSTypography.appTextTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                md: DSTypography.appTextTheme.titleSmall!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              )
            : DSTypography.appTextTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.w500,
              ),
      ),
      subtitle: subtitle != null
          ? Text(
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
            )
          : null,
      leading: leading,
      initiallyExpanded: initiallyExpanded,
      tilePadding: effectiveHeaderPadding,
      childrenPadding: effectiveContentPadding,
      backgroundColor: backgroundColor,
      collapsedBackgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: effectiveBorderRadius,
      ),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: effectiveBorderRadius,
      ),
      children: [content],
    );
  }
  
  /// Reorderable list for the application theme
  static Widget appReorderableList({
    required BuildContext context,
    required List<Widget> items,
    required void Function(int oldIndex, int newIndex) onReorder,
    ScrollPhysics? physics,
    EdgeInsets? padding,
    bool shrinkWrap = false,
    ScrollController? controller,
    bool showDividers = true,
  }) {
    final effectivePadding = padding ?? const EdgeInsets.symmetric(vertical: 8);
    
    return ReorderableListView.builder(
      physics: physics,
      padding: effectivePadding,
      shrinkWrap: shrinkWrap,
      scrollController: controller,
      itemCount: items.length,
      onReorder: onReorder,
      proxyDecorator: (Widget child, int index, Animation<double> animation) {
        return AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget? child) {
            return Material(
              elevation: 2,
              color: Colors.transparent,
              shadowColor: DSColors.shadow,
              child: child,
            );
          },
          child: child,
        );
      },
      itemBuilder: (context, index) {
        return Column(
          key: ValueKey(items[index]),
          children: [
            items[index],
            if (showDividers && index < items.length - 1)
              const Divider(indent: 16, endIndent: 16),
          ],
        );
      },
    );
  }
}

/// Section for sectioned list
class ListSection {
  final String? title;
  final List<Widget> items;
  final EdgeInsets? titlePadding;
  
  ListSection({
    this.title,
    required this.items,
    this.titlePadding,
  });
}
