import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'animated_section.dart';
import 'parallax_background.dart';
import 'hover_animated_widget.dart';
import 'continuous_animation.dart';

class PricingSection extends StatelessWidget {
  final ScrollController? scrollController;
  
  const PricingSection({
    super.key,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final pricingPlans = [
      PricingPlan(
        title: 'Community',
        price: 'Free',
        period: 'Forever',
        features: [
          'Core microservices architecture',
          'Basic authentication',
          'API Gateway',
          'Single tenant deployment',
          'Community support',
        ],
        isPopular: false,
      ),
      PricingPlan(
        title: 'Enterprise',
        price: 'Custom',
        period: 'Contact us',
        features: [
          'Everything in Community',
          'Custom integrations',
          'White-label options',
          'Advanced security features',
          'Priority support',
          'Dedicated account manager',
        ],
        isPopular: true,
      ),
    ];

    return AnimatedSection(
      animationType: AnimationType.fadeSlide,
      slideDirection: SlideDirection.up,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
      delay: const Duration(milliseconds: 100),
      child: Stack(
        children: [
          // Parallax background with geometric patterns
          Positioned.fill(
            child: ParallaxBackground(
              svgAssets: const [
                'assets/images/svg/geometric_shapes.svg',
                'assets/images/svg/wave_patterns.svg',
              ],
              scrollController: scrollController ?? PrimaryScrollController.of(context),
              parallaxSpeeds: const [-0.02, -0.04],
              opacityLevels: const [0.04, 0.03],
              colorFilters: const [Colors.white, Colors.white],
            ),
          ),
          
          // Content container
          Container(
            padding: DSSpacing.getPagePadding(context),
            color: DSColors.backgroundLanding.withValues(alpha: (0.7 * 255).toDouble()),
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
            AnimatedSection(
              animationType: AnimationType.fade,
              duration: const Duration(milliseconds: 400),
              delay: const Duration(milliseconds: 200),
              child: Text(
                'Adapted for Every Need',
                style: DSTypography.landingTextTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: DSColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            AnimatedSection(
              animationType: AnimationType.fade,
              duration: const Duration(milliseconds: 400),
              delay: const Duration(milliseconds: 300),
              child: Text(
                'Choose the plan that fits your needs',
                style: DSTypography.landingTextTheme.titleMedium?.copyWith(
                  color: DSColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 60),
            AnimatedSection(
              animationType: AnimationType.fadeSlide,
              slideDirection: SlideDirection.up,
              duration: const Duration(milliseconds: 500),
              delay: const Duration(milliseconds: 400),
              child: DSResponsiveLayout.responsiveGrid(
                context: context,
                children: pricingPlans.asMap().entries.map((entry) {
                  final index = entry.key;
                  final plan = entry.value;
                  return AnimatedSection(
                    animationType: AnimationType.fadeScale,
                    duration: const Duration(milliseconds: 400),
                    delay: Duration(milliseconds: 500 + (index * 150)),
                    child: _buildPricingCard(context, plan),
                  );
                }).toList(),
                mobileColumns: 1,
                tabletColumns: 3,
                desktopColumns: 3,
                spacing: 24,
                runSpacing: 24,
              ),
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  Widget _buildPricingCard(BuildContext context, PricingPlan plan) {
    return ScaleOnHover(
      hoverScale: 1.02,
      addShadowOnHover: true,
      hoverElevation: 8.0,
      child: DSCards.landingPricingCard(
        title: plan.title,
        price: plan.price,
        period: plan.period,
        features: plan.features,
        onButtonPressed: () {
          // Implement pricing action
        },
        buttonText: plan.title == 'Enterprise' ? 'Contact Us' : 'Get Started',
        isPopular: plan.isPopular,
        context: context,
        // Add more pronounced shadow for popular plan
        boxShadow: plan.isPopular 
            ? [
                BoxShadow(
                  color: DSColors.primaryLanding.withValues(alpha: (0.2 * 255).toDouble()),
                  blurRadius: 15,
                  spreadRadius: 1,
                  offset: const Offset(0, 4),
                )
              ]
            : null,
      ),
    );
  }
}

class PricingPlan {
  final String title;
  final String price;
  final String period;
  final List<String> features;
  final bool isPopular;

  PricingPlan({
    required this.title,
    required this.price,
    required this.period,
    required this.features,
    required this.isPopular,
  });
}
