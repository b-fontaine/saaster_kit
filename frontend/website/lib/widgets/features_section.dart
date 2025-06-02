import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/cupertino.dart';

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

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

    return Container(
      padding: DSSpacing.getPagePadding(context),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          Text(
            'Key Features',
            style: DSTypography.landingTextTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: DSColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Everything you need to build a production-ready SaaS application',
            style: DSTypography.landingTextTheme.titleMedium?.copyWith(
              color: DSColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60),
          DSResponsiveLayout.responsiveGrid(
            context: context,
            children: features.map((feature) => FeatureCard(feature: feature)).toList(),
            mobileColumns: 1,
            tabletColumns: 2,
            desktopColumns: 3,
            spacing: 24,
            runSpacing: 24,
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }


}

class FeatureCard extends StatelessWidget {
  final FeatureItem feature;

  const FeatureCard({
    super.key,
    required this.feature,
  });

  @override
  Widget build(BuildContext context) {
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

  const FeatureItem({
    required this.title,
    required this.description,
    required this.icon,
  });
}
