import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'animated_section.dart';
import 'parallax_background.dart';
import 'hover_animated_widget.dart';
import 'continuous_animation.dart';

class TestimonialsSection extends StatelessWidget {
  final ScrollController? scrollController;
  
  const TestimonialsSection({
    super.key,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final testimonials = [
      Testimonial(
        quote: 'SaaSter Kit saved us months of development time. The architecture is solid and the documentation is excellent.',
        author: 'Jane Smith',
        company: 'Tech Innovators',
      ),
      Testimonial(
        quote: 'The multi-tenant architecture and security features are exactly what we needed for our enterprise clients.',
        author: 'John Doe',
        company: 'Enterprise Solutions',
      ),
      Testimonial(
        quote: 'We launched our SaaS product in record time thanks to SaaSter Kit. Highly recommended!',
        author: 'Alex Johnson',
        company: 'Startup Accelerator',
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
          // Parallax background with wave patterns
          Positioned.fill(
            child: ParallaxBackground(
              svgAssets: const [
                'assets/images/svg/wave_patterns.svg',
                'assets/images/svg/dots_grid.svg',
              ],
              scrollController: scrollController ?? PrimaryScrollController.of(context),
              parallaxSpeeds: const [-0.04, -0.02],
              opacityLevels: const [0.03, 0.02],
              colorFilters: const [Colors.white, Colors.white],
            ),
          ),
          
          // Content container
          Container(
            padding: DSSpacing.getPagePadding(context),
            color: Colors.white.withOpacity(0.9),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                AnimatedSection(
                  animationType: AnimationType.fade,
                  duration: const Duration(milliseconds: 400),
                  delay: const Duration(milliseconds: 200),
                  child: Text(
                    'What Our Customers Say',
                    style: DSTypography.landingTextTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: DSColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 60),
                AnimatedSection(
                  animationType: AnimationType.fadeSlide,
                  slideDirection: SlideDirection.up,
                  duration: const Duration(milliseconds: 500),
                  delay: const Duration(milliseconds: 300),
                  child: DSResponsiveLayout.responsiveGrid(
                    context: context,
                    children: testimonials.asMap().entries.map((entry) {
                      final index = entry.key;
                      final testimonial = entry.value;
                      return AnimatedSection(
                        animationType: AnimationType.fadeSlide,
                        slideDirection: SlideDirection.up,
                        duration: const Duration(milliseconds: 400),
                        delay: Duration(milliseconds: 400 + (index * 150)),
                        child: _buildTestimonialCard(context, testimonial),
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
        ],
      ),
    );
  }

  Widget _buildTestimonialCard(BuildContext context, Testimonial testimonial) {
    return ScaleOnHover(
      hoverScale: 1.03,
      addShadowOnHover: true,
      child: DSCards.landingCard(
        padding: DSSpacing.paddingLG,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          )
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ContinuousAnimationWidget(
              animationType: ContinuousAnimationType.breathe,
              amplitude: 2.0,
              duration: const Duration(seconds: 4),
              child: Icon(
                DSIcons.formatQuote,
                size: 40,
                color: DSColors.primaryLanding.withOpacity(0.2),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              testimonial.quote,
              style: DSTypography.landingTextTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: DSColors.primaryLanding.withOpacity(0.1),
                  child: Icon(
                    DSIcons.profile,
                    color: DSColors.primaryLanding,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        testimonial.author,
                        style: DSTypography.landingTextTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        testimonial.company,
                        style: DSTypography.landingTextTheme.bodySmall?.copyWith(
                          color: DSColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Testimonial {
  final String quote;
  final String author;
  final String company;

  Testimonial({
    required this.quote,
    required this.author,
    required this.company,
  });
}
