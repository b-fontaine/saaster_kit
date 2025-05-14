import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

import '../widgets/cta_section.dart';
import '../widgets/features_section.dart';
import '../widgets/footer_section.dart';
import '../widgets/hero_section.dart';
import '../widgets/pricing_section.dart';
import '../widgets/testimonials_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Navigation items for the app bar
    final navigationItems = [
      AppBarNavigationItem(
        label: 'Features',
        onTap: () {
          // Implement scroll to features section
        },
      ),
      AppBarNavigationItem(
        label: 'Pricing',
        onTap: () {
          // Implement scroll to pricing section
        },
      ),
      AppBarNavigationItem(
        label: 'Documentation',
        onTap: () {
          // Implement link to documentation
        },
      ),
    ];

    // Logo widget for the app bar
    final logo = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.dashboard, color: DSColors.primaryLanding, size: 32),
        const SizedBox(width: 8),
        Text(
          'SaaSter Kit',
          style: DSTypography.landingTextTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );

    // Action button for the app bar
    final actionButton = DSButtons.primaryLandingButton(
      text: 'Get Started',
      onPressed: () {
        // Implement call-to-action
      },
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      height: 44,
    );

    return DSLandingScaffold.standard(
      context: context,
      title: 'SaaSter Kit',
      logo: logo,
      navigationItems: navigationItems,
      actionButton: actionButton,
      backgroundColor: DSColors.backgroundLanding,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: const [
            HeroSection(),
            FeaturesSection(),
            PricingSection(),
            TestimonialsSection(),
            CTASection(),
            FooterSection(),
          ],
        ),
      ),
    );
  }
}
