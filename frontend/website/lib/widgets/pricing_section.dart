import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

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

    return Container(
      padding: DSSpacing.getPagePadding(context),
      color: DSColors.backgroundLanding.withOpacity(0.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 60),
          Text(
            'Adapted for Every Need',
            style: DSTypography.landingTextTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: DSColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Choose the plan that fits your needs',
            style: DSTypography.landingTextTheme.titleMedium?.copyWith(
              color: DSColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60),
          DSResponsiveLayout.responsiveGrid(
            context: context,
            children:
                pricingPlans
                    .map((plan) => _buildPricingCard(context, plan))
                    .toList(),
            mobileColumns: 1,
            tabletColumns: 3,
            desktopColumns: 3,
            spacing: 24,
            runSpacing: 24,
          ),
          const SizedBox(height: 60),
        ],
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
