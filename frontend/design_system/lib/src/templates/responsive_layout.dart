import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../utils/breakpoints.dart';

/// Design System Responsive Layout
class DSResponsiveLayout {
  // Private constructor to prevent instantiation
  DSResponsiveLayout._();

  /// Responsive builder that provides different layouts based on screen size
  static Widget responsiveBuilder({
    required BuildContext context,
    required Widget mobile,
    Widget? tablet,
    Widget? desktop,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= DSBreakpoints.lg && desktop != null) {
      return desktop;
    }

    if (screenWidth >= DSBreakpoints.md && tablet != null) {
      return tablet;
    }

    return mobile;
  }

  /// Responsive wrapper for the entire app
  static Widget responsiveWrapper({
    required BuildContext context,
    required Widget child,
    double maxWidth = 1200,
    bool useResponsiveFramework = true,
  }) {
    if (useResponsiveFramework) {
      // In a real implementation, we would use ResponsiveFramework
      // For now, we'll use a simple container with max width
      return Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: maxWidth,
          ),
          child: child,
        ),
      );
    } else {
      return child;
    }
  }

  /// Responsive grid layout
  static Widget responsiveGrid({
    required BuildContext context,
    required List<Widget> children,
    int mobileColumns = 1,
    int tabletColumns = 2,
    int desktopColumns = 4,
    double spacing = 16,
    double runSpacing = 16,
    EdgeInsets? padding,
  }) {
    final effectivePadding = padding ?? const EdgeInsets.all(16);
    final screenWidth = MediaQuery.of(context).size.width;

    int columns;
    if (screenWidth >= DSBreakpoints.lg) {
      columns = desktopColumns;
    } else if (screenWidth >= DSBreakpoints.md) {
      columns = tabletColumns;
    } else {
      columns = mobileColumns;
    }

    return Padding(
      padding: effectivePadding,
      child: Wrap(
        spacing: spacing,
        runSpacing: runSpacing,
        children: children.map((child) {
          return SizedBox(
            width: (screenWidth - effectivePadding.horizontal - (spacing * (columns - 1))) / columns,
            child: child,
          );
        }).toList(),
      ),
    );
  }

  /// Responsive container with max width
  static Widget responsiveContainer({
    required Widget child,
    double maxWidth = 1200,
    EdgeInsets? padding,
    Alignment alignment = Alignment.center,
    Color? color,
    BoxDecoration? decoration,
  }) {
    final effectivePadding = padding ?? const EdgeInsets.symmetric(horizontal: 16);

    return Container(
      alignment: alignment,
      color: decoration == null ? color : null,
      decoration: decoration,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: maxWidth,
        ),
        padding: effectivePadding,
        child: child,
      ),
    );
  }

  /// Responsive row that converts to column on small screens
  static Widget responsiveRowColumn({
    required BuildContext context,
    required List<Widget> children,
    double breakpoint = 600,
    MainAxisAlignment rowMainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment rowCrossAxisAlignment = CrossAxisAlignment.center,
    MainAxisAlignment columnMainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment columnCrossAxisAlignment = CrossAxisAlignment.center,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    double spacing = 16,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isRow = screenWidth >= breakpoint;

    if (isRow) {
      return Row(
        mainAxisAlignment: rowMainAxisAlignment,
        crossAxisAlignment: rowCrossAxisAlignment,
        mainAxisSize: mainAxisSize,
        children: _addSpacingBetween(
          children,
          spacing: spacing,
          isHorizontal: true,
        ),
      );
    } else {
      return Column(
        mainAxisAlignment: columnMainAxisAlignment,
        crossAxisAlignment: columnCrossAxisAlignment,
        mainAxisSize: mainAxisSize,
        children: _addSpacingBetween(
          children,
          spacing: spacing,
          isHorizontal: false,
        ),
      );
    }
  }

  /// Responsive two-column layout
  static Widget responsiveTwoColumnLayout({
    required BuildContext context,
    required Widget left,
    required Widget right,
    double breakpoint = 900,
    double spacing = 32,
    double leftFlex = 1,
    double rightFlex = 1,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
    MainAxisAlignment columnMainAxisAlignment = MainAxisAlignment.start,
    EdgeInsets? padding,
  }) {
    final effectivePadding = padding ?? EdgeInsets.zero;
    final screenWidth = MediaQuery.of(context).size.width;
    final isRow = screenWidth >= breakpoint;

    return Padding(
      padding: effectivePadding,
      child: isRow
          ? Row(
              crossAxisAlignment: crossAxisAlignment,
              children: [
                Expanded(
                  flex: (leftFlex * 100).toInt(),
                  child: left,
                ),
                SizedBox(width: spacing),
                Expanded(
                  flex: (rightFlex * 100).toInt(),
                  child: right,
                ),
              ],
            )
          : Column(
              mainAxisAlignment: columnMainAxisAlignment,
              crossAxisAlignment: crossAxisAlignment,
              children: [
                left,
                SizedBox(height: spacing),
                right,
              ],
            ),
    );
  }

  /// Responsive three-column layout
  static Widget responsiveThreeColumnLayout({
    required BuildContext context,
    required Widget left,
    required Widget middle,
    required Widget right,
    double twoColumnBreakpoint = 900,
    double threeColumnBreakpoint = 1200,
    double spacing = 32,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
    MainAxisAlignment columnMainAxisAlignment = MainAxisAlignment.start,
    EdgeInsets? padding,
  }) {
    final effectivePadding = padding ?? EdgeInsets.zero;
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: effectivePadding,
      child: screenWidth >= threeColumnBreakpoint
          ? Row(
              crossAxisAlignment: crossAxisAlignment,
              children: [
                Expanded(child: left),
                SizedBox(width: spacing),
                Expanded(child: middle),
                SizedBox(width: spacing),
                Expanded(child: right),
              ],
            )
          : screenWidth >= twoColumnBreakpoint
              ? Column(
                  mainAxisAlignment: columnMainAxisAlignment,
                  crossAxisAlignment: crossAxisAlignment,
                  children: [
                    Row(
                      crossAxisAlignment: crossAxisAlignment,
                      children: [
                        Expanded(child: left),
                        SizedBox(width: spacing),
                        Expanded(child: middle),
                      ],
                    ),
                    SizedBox(height: spacing),
                    right,
                  ],
                )
              : Column(
                  mainAxisAlignment: columnMainAxisAlignment,
                  crossAxisAlignment: crossAxisAlignment,
                  children: [
                    left,
                    SizedBox(height: spacing),
                    middle,
                    SizedBox(height: spacing),
                    right,
                  ],
                ),
    );
  }

  /// Helper method to add spacing between widgets
  static List<Widget> _addSpacingBetween(
    List<Widget> children, {
    required double spacing,
    required bool isHorizontal,
  }) {
    if (children.isEmpty) return [];
    if (children.length == 1) return children;

    final result = <Widget>[];
    for (int i = 0; i < children.length; i++) {
      result.add(children[i]);
      if (i < children.length - 1) {
        result.add(
          isHorizontal
              ? SizedBox(width: spacing)
              : SizedBox(height: spacing),
        );
      }
    }
    return result;
  }
}
