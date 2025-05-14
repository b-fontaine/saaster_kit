import 'package:design_system/design_system.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';

class TestimonialsSection extends StatelessWidget {
  const TestimonialsSection({super.key});

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

    return Container(
      padding: DSSpacing.getPagePadding(context),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 60),
          Text(
            'What Our Customers Say',
            style: DSTypography.landingTextTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: DSColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60),
          DSResponsiveLayout.responsiveGrid(
            context: context,
            children:
                testimonials
                    .map(
                      (testimonial) =>
                          _buildTestimonialCard(context, testimonial),
                    )
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

  Widget _buildTestimonialCard(BuildContext context, Testimonial testimonial) {
    return DSCards.landingCard(
      padding: DSSpacing.paddingLG,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            DSIcons.formatQuote,
            size: 40,
            color: DSColors.primaryLanding.withOpacity(0.2),
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
