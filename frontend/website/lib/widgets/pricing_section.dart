import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'animated_section.dart';

class PricingSection extends StatelessWidget {
  const PricingSection({super.key});

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
      child: Container(
        padding: DSSpacing.getPagePadding(context),
        color: DSColors.backgroundLanding.withValues(alpha: (0.5 * 255).toDouble()),
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
    return DSCards.landingPricingCard(
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
