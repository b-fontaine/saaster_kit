import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class CTASection extends StatelessWidget {
  const CTASection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: DSSpacing.getPagePadding(context),
      decoration: BoxDecoration(gradient: DSColors.landingGradient),
      child: Column(
        children: [
          const SizedBox(height: 80),
          Text(
            'Ready to Build Your SaaS?',
            style: DSTypography.landingTextTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Text(
            'Start building your next big idea with SaaSter Kit today.',
            style: DSTypography.landingTextTheme.titleMedium?.copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DSButtons.primaryLandingButton(
                text: 'Get Started',
                onPressed: () {
                  // Implement primary CTA
                },
              ),
              const SizedBox(width: 16),
              DSButtons.secondaryLandingButton(
                text: 'View Documentation',
                onPressed: () {
                  // Implement secondary CTA
                },
              ),
            ],
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
