import 'package:flutter/material.dart';
import '../atoms/colors.dart';
import '../atoms/spacing.dart';
import '../atoms/typography.dart';
import '../organisms/app_bar.dart';
import '../organisms/navigation.dart';
import '../utils/breakpoints.dart';
import '../utils/responsive_utils.dart';
import 'responsive_layout.dart';

/// Design System Landing Page Scaffold
class DSLandingScaffold {
  // Private constructor to prevent instantiation
  DSLandingScaffold._();

  /// Standard landing page scaffold
  static Widget standard({
    required BuildContext context,
    required Widget body,
    String? title,
    Widget? logo,
    List<AppBarNavigationItem>? navigationItems,
    Widget? actionButton,
    Color? backgroundColor,
    Color? appBarBackgroundColor,
    Color? appBarForegroundColor,
    double appBarElevation = 0,
    Widget? footer,
    bool extendBodyBehindAppBar = false,
    bool resizeToAvoidBottomInset = true,
  }) {
    final isDesktop = DSBreakpoints.isDesktop(context);

    // Create navigation items for the app bar and drawer
    final navItems = navigationItems ?? [];

    // Create drawer items from navigation items
    final drawerItems = navItems.map((item) => DrawerItem(
      title: item.label,
      icon: item.icon,
      onTap: item.onTap,
    )).toList();

    return Scaffold(
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      appBar: DSAppBars.landingNavAppBar(
        context: context,
        title: title ?? '',
        navigationItems: navItems,
        actionButton: actionButton,
        logo: logo,
        backgroundColor: appBarBackgroundColor ?? Colors.transparent,
        foregroundColor: appBarForegroundColor ?? DSColors.textPrimary,
        elevation: appBarElevation,
      ),
      endDrawer: !isDesktop && navItems.isNotEmpty
          ? DSNavigation.landingMobileDrawer(
              context: context,
              items: drawerItems,
              headerTitle: title,
              headerLogo: logo,
              actionButton: actionButton,
              backgroundColor: backgroundColor ?? Colors.white,
            )
          : null,
      body: Column(
        children: [
          Expanded(
            child: body,
          ),
          if (footer != null) footer,
        ],
      ),
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    );
  }

  /// Landing page hero section
  static Widget heroSection({
    required BuildContext context,
    required String title,
    required String subtitle,
    required Widget primaryAction,
    Widget? secondaryAction,
    Widget? image,
    EdgeInsets? padding,
    Color? backgroundColor,
    TextAlign titleTextAlign = TextAlign.start,
    TextAlign subtitleTextAlign = TextAlign.start,
    bool reverseOnMobile = false,
  }) {
    final effectivePadding = padding ?? DSSpacing.getPagePadding(context);

    return Container(
      color: backgroundColor,
      padding: effectivePadding,
      child: DSResponsiveLayout.responsiveTwoColumnLayout(
        context: context,
        left: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: ResponsiveUtils.responsiveTextStyle(
                context: context,
                defaultStyle: DSTypography.landingTextTheme.displaySmall!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                md: DSTypography.landingTextTheme.displaySmall!.copyWith(
                  fontSize: 52,
                  fontWeight: FontWeight.bold,
                ),
                lg: DSTypography.landingTextTheme.displayMedium!.copyWith(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                ),
              ),
              textAlign: titleTextAlign,
            ),
            DSSpacing.verticalSpacerMD,
            Text(
              subtitle,
              style: ResponsiveUtils.responsiveTextStyle(
                context: context,
                defaultStyle: DSTypography.landingTextTheme.bodyLarge!,
                md: DSTypography.landingTextTheme.bodyLarge!.copyWith(
                  fontSize: 18,
                ),
                lg: DSTypography.landingTextTheme.bodyLarge!.copyWith(
                  fontSize: 20,
                ),
              ),
              textAlign: subtitleTextAlign,
            ),
            DSSpacing.verticalSpacerXL,
            DSResponsiveLayout.responsiveRowColumn(
              context: context,
              breakpoint: 400,
              spacing: 16,
              rowMainAxisAlignment: MainAxisAlignment.start,
              children: [
                primaryAction,
                if (secondaryAction != null) secondaryAction,
              ],
            ),
          ],
        ),
        right: image ?? const SizedBox(),
        breakpoint: 900,
        spacing: 48,
        leftFlex: 1,
        rightFlex: 1,
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
    );
  }

  /// Landing page feature section
  static Widget featureSection({
    required BuildContext context,
    required String title,
    required String subtitle,
    required List<FeatureItem> features,
    EdgeInsets? padding,
    Color? backgroundColor,
    TextAlign titleTextAlign = TextAlign.center,
    TextAlign subtitleTextAlign = TextAlign.center,
    int mobileColumns = 1,
    int tabletColumns = 2,
    int desktopColumns = 3,
  }) {
    final effectivePadding = padding ?? DSSpacing.getSectionPadding(context);

    return Container(
      color: backgroundColor,
      padding: effectivePadding,
      child: Column(
        children: [
          // Section header
          Padding(
            padding: const EdgeInsets.only(bottom: 48),
            child: Column(
              children: [
                Text(
                  title,
                  style: ResponsiveUtils.responsiveTextStyle(
                    context: context,
                    defaultStyle: DSTypography.landingTextTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    md: DSTypography.landingTextTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    lg: DSTypography.landingTextTheme.headlineMedium!.copyWith(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  textAlign: titleTextAlign,
                ),
                DSSpacing.verticalSpacerMD,
                Text(
                  subtitle,
                  style: ResponsiveUtils.responsiveTextStyle(
                    context: context,
                    defaultStyle: DSTypography.landingTextTheme.bodyLarge!,
                    md: DSTypography.landingTextTheme.bodyLarge!.copyWith(
                      fontSize: 18,
                    ),
                  ),
                  textAlign: subtitleTextAlign,
                ),
              ],
            ),
          ),

          // Features grid
          DSResponsiveLayout.responsiveGrid(
            context: context,
            children: features.map((feature) => _buildFeatureItem(context, feature)).toList(),
            mobileColumns: mobileColumns,
            tabletColumns: tabletColumns,
            desktopColumns: desktopColumns,
            spacing: 24,
            runSpacing: 24,
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }

  /// Landing page testimonial section
  static Widget testimonialSection({
    required BuildContext context,
    required String title,
    required List<TestimonialItem> testimonials,
    String? subtitle,
    EdgeInsets? padding,
    Color? backgroundColor,
    TextAlign titleTextAlign = TextAlign.center,
    TextAlign subtitleTextAlign = TextAlign.center,
  }) {
    final effectivePadding = padding ?? DSSpacing.getSectionPadding(context);

    return Container(
      color: backgroundColor,
      padding: effectivePadding,
      child: Column(
        children: [
          // Section header
          Padding(
            padding: const EdgeInsets.only(bottom: 48),
            child: Column(
              children: [
                Text(
                  title,
                  style: ResponsiveUtils.responsiveTextStyle(
                    context: context,
                    defaultStyle: DSTypography.landingTextTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    md: DSTypography.landingTextTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    lg: DSTypography.landingTextTheme.headlineMedium!.copyWith(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  textAlign: titleTextAlign,
                ),
                if (subtitle != null) ...[
                  DSSpacing.verticalSpacerMD,
                  Text(
                    subtitle,
                    style: ResponsiveUtils.responsiveTextStyle(
                      context: context,
                      defaultStyle: DSTypography.landingTextTheme.bodyLarge!,
                      md: DSTypography.landingTextTheme.bodyLarge!.copyWith(
                        fontSize: 18,
                      ),
                    ),
                    textAlign: subtitleTextAlign,
                  ),
                ],
              ],
            ),
          ),

          // Testimonials
          DSBreakpoints.isMobile(context)
              ? Column(
                  children: testimonials.map((testimonial) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: _buildTestimonialItem(context, testimonial),
                    );
                  }).toList(),
                )
              : DSResponsiveLayout.responsiveGrid(
                  context: context,
                  children: testimonials.map((testimonial) => _buildTestimonialItem(context, testimonial)).toList(),
                  mobileColumns: 1,
                  tabletColumns: 2,
                  desktopColumns: 3,
                  spacing: 24,
                  runSpacing: 24,
                  padding: EdgeInsets.zero,
                ),
        ],
      ),
    );
  }

  /// Landing page pricing section
  static Widget pricingSection({
    required BuildContext context,
    required String title,
    required List<PricingItem> pricingItems,
    String? subtitle,
    EdgeInsets? padding,
    Color? backgroundColor,
    TextAlign titleTextAlign = TextAlign.center,
    TextAlign subtitleTextAlign = TextAlign.center,
  }) {
    final effectivePadding = padding ?? DSSpacing.getSectionPadding(context);

    return Container(
      color: backgroundColor,
      padding: effectivePadding,
      child: Column(
        children: [
          // Section header
          Padding(
            padding: const EdgeInsets.only(bottom: 48),
            child: Column(
              children: [
                Text(
                  title,
                  style: ResponsiveUtils.responsiveTextStyle(
                    context: context,
                    defaultStyle: DSTypography.landingTextTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    md: DSTypography.landingTextTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    lg: DSTypography.landingTextTheme.headlineMedium!.copyWith(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  textAlign: titleTextAlign,
                ),
                if (subtitle != null) ...[
                  DSSpacing.verticalSpacerMD,
                  Text(
                    subtitle,
                    style: ResponsiveUtils.responsiveTextStyle(
                      context: context,
                      defaultStyle: DSTypography.landingTextTheme.bodyLarge!,
                      md: DSTypography.landingTextTheme.bodyLarge!.copyWith(
                        fontSize: 18,
                      ),
                    ),
                    textAlign: subtitleTextAlign,
                  ),
                ],
              ],
            ),
          ),

          // Pricing cards
          DSBreakpoints.isMobile(context)
              ? Column(
                  children: pricingItems.map((pricing) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: _buildPricingItem(context, pricing),
                    );
                  }).toList(),
                )
              : DSResponsiveLayout.responsiveGrid(
                  context: context,
                  children: pricingItems.map((pricing) => _buildPricingItem(context, pricing)).toList(),
                  mobileColumns: 1,
                  tabletColumns: 2,
                  desktopColumns: 3,
                  spacing: 24,
                  runSpacing: 24,
                  padding: EdgeInsets.zero,
                ),
        ],
      ),
    );
  }

  /// Landing page call-to-action section
  static Widget ctaSection({
    required BuildContext context,
    required String title,
    required String subtitle,
    required Widget primaryAction,
    Widget? secondaryAction,
    EdgeInsets? padding,
    Color? backgroundColor,
    TextAlign titleTextAlign = TextAlign.center,
    TextAlign subtitleTextAlign = TextAlign.center,
  }) {
    final effectivePadding = padding ?? DSSpacing.getSectionPadding(context);

    return Container(
      color: backgroundColor,
      padding: effectivePadding,
      child: Column(
        children: [
          Text(
            title,
            style: ResponsiveUtils.responsiveTextStyle(
              context: context,
              defaultStyle: DSTypography.landingTextTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.bold,
              ),
              md: DSTypography.landingTextTheme.headlineMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
              lg: DSTypography.landingTextTheme.headlineMedium!.copyWith(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            textAlign: titleTextAlign,
          ),
          DSSpacing.verticalSpacerMD,
          Text(
            subtitle,
            style: ResponsiveUtils.responsiveTextStyle(
              context: context,
              defaultStyle: DSTypography.landingTextTheme.bodyLarge!,
              md: DSTypography.landingTextTheme.bodyLarge!.copyWith(
                fontSize: 18,
              ),
            ),
            textAlign: subtitleTextAlign,
          ),
          DSSpacing.verticalSpacerXL,
          DSResponsiveLayout.responsiveRowColumn(
            context: context,
            breakpoint: 400,
            spacing: 16,
            rowMainAxisAlignment: MainAxisAlignment.center,
            columnMainAxisAlignment: MainAxisAlignment.center,
            children: [
              primaryAction,
              if (secondaryAction != null) secondaryAction,
            ],
          ),
        ],
      ),
    );
  }

  /// Landing page footer
  static Widget footer({
    required BuildContext context,
    required String companyName,
    required List<FooterLink> links,
    String? copyrightText,
    Widget? logo,
    List<FooterSocialLink>? socialLinks,
    EdgeInsets? padding,
    Color? backgroundColor,
    Color? textColor,
  }) {
    final effectivePadding = padding ?? const EdgeInsets.symmetric(
      horizontal: 24,
      vertical: 48,
    );
    final effectiveTextColor = textColor ?? DSColors.textPrimary;
    final year = DateTime.now().year;
    final effectiveCopyrightText = copyrightText ?? '© $year $companyName. All rights reserved.';

    return Container(
      color: backgroundColor,
      padding: effectivePadding,
      child: Column(
        children: [
          // Footer content
          DSResponsiveLayout.responsiveRowColumn(
            context: context,
            breakpoint: 768,
            spacing: 48,
            rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
            columnMainAxisAlignment: MainAxisAlignment.start,
            columnCrossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Company info
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (logo != null) ...[
                    logo,
                    DSSpacing.verticalSpacerMD,
                  ],
                  Text(
                    companyName,
                    style: DSTypography.landingTextTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: effectiveTextColor,
                    ),
                  ),
                  if (socialLinks != null && socialLinks.isNotEmpty) ...[
                    DSSpacing.verticalSpacerMD,
                    Row(
                      children: socialLinks.map((link) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: IconButton(
                            icon: Icon(link.icon),
                            onPressed: link.onTap,
                            color: effectiveTextColor,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),

              // Links
              DSBreakpoints.isMobile(context)
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _buildFooterLinkGroups(links, effectiveTextColor),
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _buildFooterLinkGroups(links, effectiveTextColor)
                          .map((group) => Padding(
                                padding: const EdgeInsets.only(right: 48),
                                child: group,
                              ))
                          .toList(),
                    ),
            ],
          ),

          // Copyright
          DSSpacing.verticalSpacerXL,
          Text(
            effectiveCopyrightText,
            style: DSTypography.landingTextTheme.bodySmall?.copyWith(
              color: effectiveTextColor.withValues(alpha: (0.7 * 255).toDouble()),
            ),
          ),
        ],
      ),
    );
  }

  // Helper methods

  /// Build a feature item
  static Widget _buildFeatureItem(BuildContext context, FeatureItem feature) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (feature.icon != null) ...[
          Icon(
            feature.icon,
            size: 48,
            color: DSColors.primaryLanding,
          ),
          DSSpacing.verticalSpacerMD,
        ],
        Text(
          feature.title,
          style: DSTypography.landingTextTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        DSSpacing.verticalSpacerSM,
        Text(
          feature.description,
          style: DSTypography.landingTextTheme.bodyLarge,
        ),
      ],
    );
  }

  /// Build a testimonial item
  static Widget _buildTestimonialItem(BuildContext context, TestimonialItem testimonial) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: (0.1 * 255).toDouble()),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (testimonial.avatar != null) ...[
                CircleAvatar(
                  radius: 24,
                  backgroundImage: testimonial.avatar,
                ),
                DSSpacing.horizontalSpacerMD,
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      testimonial.name,
                      style: DSTypography.landingTextTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      testimonial.role,
                      style: DSTypography.landingTextTheme.bodyMedium?.copyWith(
                        color: DSColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          DSSpacing.verticalSpacerMD,
          Text(
            testimonial.quote,
            style: DSTypography.landingTextTheme.bodyLarge?.copyWith(
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  /// Build a pricing item
  static Widget _buildPricingItem(BuildContext context, PricingItem pricing) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: pricing.isPopular
            ? Border.all(color: DSColors.primaryLanding, width: 2)
            : Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: (0.1 * 255).toDouble()),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (pricing.isPopular) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: DSColors.primaryLanding,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                'Most Popular',
                style: DSTypography.landingTextTheme.labelSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            DSSpacing.verticalSpacerMD,
          ],
          Text(
            pricing.title,
            style: DSTypography.landingTextTheme.titleLarge?.copyWith(
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
                pricing.price,
                style: DSTypography.landingTextTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: DSColors.primaryLanding,
                ),
              ),
            ],
          ),
          Text(
            pricing.period,
            style: DSTypography.landingTextTheme.bodyMedium?.copyWith(
              color: DSColors.textSecondary,
            ),
          ),
          DSSpacing.verticalSpacerLG,
          ...pricing.features.map((feature) => Padding(
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
            child: pricing.isPopular
                ? ElevatedButton(
                    onPressed: pricing.onButtonPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: DSColors.primaryLanding,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      pricing.buttonText,
                      style: DSTypography.landingTextTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                : OutlinedButton(
                    onPressed: pricing.onButtonPressed,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: DSColors.primaryLanding,
                      side: const BorderSide(color: DSColors.primaryLanding, width: 2),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      pricing.buttonText,
                      style: DSTypography.landingTextTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  /// Build footer link groups
  static List<Widget> _buildFooterLinkGroups(List<FooterLink> links, Color textColor) {
    // Group links by category
    final Map<String, List<FooterLink>> groupedLinks = {};
    for (final link in links) {
      if (!groupedLinks.containsKey(link.category)) {
        groupedLinks[link.category] = [];
      }
      groupedLinks[link.category]!.add(link);
    }

    // Build a column for each category
    return groupedLinks.entries.map((entry) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            entry.key,
            style: DSTypography.landingTextTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
          DSSpacing.verticalSpacerMD,
          ...entry.value.map((link) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: InkWell(
                onTap: link.onTap,
                child: Text(
                  link.label,
                  style: DSTypography.landingTextTheme.bodyMedium?.copyWith(
                    color: textColor.withValues(alpha: (0.8 * 255).toDouble()),
                  ),
                ),
              ),
            );
          }).toList(),
          DSSpacing.verticalSpacerLG,
        ],
      );
    }).toList();
  }
}

/// Feature item for feature section
class FeatureItem {
  final String title;
  final String description;
  final IconData? icon;

  FeatureItem({
    required this.title,
    required this.description,
    this.icon,
  });
}

/// Testimonial item for testimonial section
class TestimonialItem {
  final String name;
  final String role;
  final String quote;
  final ImageProvider? avatar;

  TestimonialItem({
    required this.name,
    required this.role,
    required this.quote,
    this.avatar,
  });
}

/// Pricing item for pricing section
class PricingItem {
  final String title;
  final String price;
  final String period;
  final List<String> features;
  final VoidCallback onButtonPressed;
  final String buttonText;
  final bool isPopular;

  PricingItem({
    required this.title,
    required this.price,
    required this.period,
    required this.features,
    required this.onButtonPressed,
    this.buttonText = 'Get Started',
    this.isPopular = false,
  });
}

/// Footer link for footer section
class FooterLink {
  final String label;
  final String category;
  final VoidCallback onTap;

  FooterLink({
    required this.label,
    required this.category,
    required this.onTap,
  });
}

/// Footer social link for footer section
class FooterSocialLink {
  final IconData icon;
  final VoidCallback onTap;

  FooterSocialLink({
    required this.icon,
    required this.onTap,
  });
}
