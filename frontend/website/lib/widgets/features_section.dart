import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';
import 'animated_section.dart';
import 'parallax_background.dart';

class FeaturesSection extends StatelessWidget {
  final ScrollController? scrollController;
  
  const FeaturesSection({
    super.key,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final features = [
      FeatureItem(
        title: 'Microservices Architecture',
        description: 'Built with Go, hexagonal architecture, CQRS pattern, and gRPC endpoints for scalable, maintainable services.',
        icon: Icons.architecture,
      ),
      FeatureItem(
        title: 'Authentication & Authorization',
        description: 'Integrated Keycloak for secure OAuth2/OIDC authentication and fine-grained authorization.',
        icon: Icons.security,
      ),
      FeatureItem(
        title: 'API Gateway',
        description: 'Kong API Gateway with OAuth2 token validation and seamless REST-to-gRPC mapping.',
        icon: Icons.api,
      ),
      FeatureItem(
        title: 'Workflow Orchestration',
        description: 'Temporal for reliable, scalable workflow orchestration with built-in error handling.',
        icon: Icons.account_tree,
      ),
      FeatureItem(
        title: 'Observability',
        description: 'Comprehensive monitoring with Prometheus, Grafana, and Elasticsearch for logs.',
        icon: Icons.analytics,
      ),
      FeatureItem(
        title: 'Flutter Frontend',
        description: 'Beautiful, responsive UI with Material Design and atomic design patterns.',
        icon: Icons.smartphone,
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
          // Parallax background with tech-themed SVG patterns
          Positioned.fill(
            child: ParallaxBackground(
              svgAssets: const [
                'assets/images/svg/tech_elements.svg',
                'assets/images/svg/dots_grid.svg',
              ],
              scrollController: scrollController ?? PrimaryScrollController.of(context),
              parallaxSpeeds: const [-0.03, -0.01],
              opacityLevels: const [0.03, 0.02],
              colorFilters: const [Colors.white, Colors.white],
            ),
          ),
          
          // Content container
          Container(
            padding: DSSpacing.getPagePadding(context),
            color: Colors.white.withOpacity(0.85),
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            AnimatedSection(
              animationType: AnimationType.fade,
              duration: const Duration(milliseconds: 400),
              delay: const Duration(milliseconds: 200),
              child: Text(
                'Key Features',
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
                'Everything you need to build a production-ready SaaS application',
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
                children: features.asMap().entries.map((entry) {
                  final index = entry.key;
                  final feature = entry.value;
                  return AnimatedSection(
                    animationType: AnimationType.fadeSlide,
                    slideDirection: SlideDirection.up,
                    duration: const Duration(milliseconds: 400),
                    delay: Duration(milliseconds: 500 + (index * 100)),
                    child: _buildFeatureCard(context, feature),
                  );
                }).toList(),
                mobileColumns: 1,
                tabletColumns: 2,
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

  Widget _buildFeatureCard(BuildContext context, FeatureItem feature) {
    return DSCards.landingFeatureCard(
      title: feature.title,
      description: feature.description,
      icon: feature.icon,
      context: context,
    );
  }
}

class FeatureItem {
  final String title;
  final String description;
  final IconData icon;

  FeatureItem({
    required this.title,
    required this.description,
    required this.icon,
  });
}
