import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'animated_section.dart';

class CTASection extends StatelessWidget {
  const CTASection({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSection(
      animationType: AnimationType.fadeSlide,
      slideDirection: SlideDirection.up,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
      delay: const Duration(milliseconds: 100),
      child: Container(
        padding: DSSpacing.getPagePadding(context),
        decoration: BoxDecoration(gradient: DSColors.landingGradient),
        child: Column(
          children: [
            const SizedBox(height: 80),
            AnimatedSection(
              animationType: AnimationType.fade,
              duration: const Duration(milliseconds: 500),
              delay: const Duration(milliseconds: 200),
              child: Text(
                'Ready to Build Your SaaS?',
                style: DSTypography.landingTextTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24),
            AnimatedSection(
              animationType: AnimationType.fade,
              duration: const Duration(milliseconds: 500),
              delay: const Duration(milliseconds: 300),
              child: Text(
                'Start building your next big idea with SaaSter Kit today.',
                style: DSTypography.landingTextTheme.titleMedium?.copyWith(
                  color: Colors.white.withValues(alpha: (0.9 * 255).toDouble()),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 40),
            AnimatedSection(
              animationType: AnimationType.fadeScale,
              duration: const Duration(milliseconds: 500),
              delay: const Duration(milliseconds: 400),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DSButtons.primaryLandingButton(
                    text: 'Get Started',
                    onPressed: () {
                      // Implement primary CTA
                    },
                  ),
                  const SizedBox(width: 16),
                  // Custom button with white background for better contrast on gradient
                  Container(
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: (0.1 * 255).toDouble()),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        // Implement secondary CTA
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: DSColors.primaryLanding,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'View Documentation',
                        style: DSTypography.landingTextTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: DSColors.primaryLanding,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
