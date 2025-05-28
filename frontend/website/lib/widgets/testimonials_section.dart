import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'animated_section.dart';
import 'parallax_background.dart';

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
        quote:
            'SaaSter Kit saved us months of development time. We were able to focus on our core business logic instead of infrastructure.',
        author: 'Sarah Johnson',
        role: 'CTO, TechStart Inc.',
        avatarUrl: 'assets/images/avatar_1.jpeg',
      ),
      Testimonial(
        quote:
            'The microservices architecture is incredibly well-designed. It made scaling our application so much easier than we anticipated.',
        author: 'Michael Chen',
        role: 'Lead Developer, ScaleUp Solutions',
        avatarUrl: 'assets/images/avatar_2.jpeg',
      ),
      Testimonial(
        quote:
            'We evaluated several SaaS starter kits, and SaaSter Kit was by far the most complete and well-documented solution.',
        author: 'Emily Rodriguez',
        role: 'Product Manager, InnovateCorp',
        avatarUrl: 'assets/images/avatar_3.jpeg',
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
    );
  }

  Widget _buildTestimonialCard(BuildContext context, Testimonial testimonial) {
    return DSCards.landingCard(
      padding: DSSpacing.paddingLG,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            DSIcons.formatQuote,
            size: 40,
            color: DSColors.primaryLanding.withValues(alpha: (0.2 * 255).toDouble()),
          ),
          const SizedBox(height: 16),
          Text(
            testimonial.quote,
            style: DSTypography.landingTextTheme.bodyLarge?.copyWith(
              fontStyle: FontStyle.italic,
              color: DSColors.textPrimary,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              CircleAvatar(backgroundImage: AssetImage(testimonial.avatarUrl)),
              const SizedBox(width: 16),
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
                    const SizedBox(height: 4),
                    Text(
                      testimonial.role,
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
    );
  }
}

class Testimonial {
  final String quote;
  final String author;
  final String role;
  final String avatarUrl;

  Testimonial({
    required this.quote,
    required this.author,
    required this.role,
    required this.avatarUrl,
  });
}
