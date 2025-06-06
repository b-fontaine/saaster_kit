import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final features = [
      FeatureItem(
        title: 'Enhanced Security Stack',
        description: 'SafeLine WAF integration provides advanced protection against SQL injection, XSS, DoS attacks, bot threats, and OWASP Top 10 vulnerabilities.',
        icon: Icons.shield,
      ),
      FeatureItem(
        title: 'Frontend Applications',
        description: 'Flutter-based cross-platform solutions with Material UI and atomic design pattern for web, mobile, and desktop.',
        icon: Icons.layers,
      ),
      FeatureItem(
        title: 'API Gateway & Security',
        description: 'Kong Enterprise API Gateway for routing, authentication, rate limiting, and protocol translation plus SafeLine WAF for threat detection.',
        icon: Icons.shield,
      ),
      FeatureItem(
        title: 'Identity & Access Management',
        description: 'Keycloak provides enterprise-grade authentication, authorization, and multi-tenant user management with role-based access control.',
        icon: Icons.lock,
      ),
      FeatureItem(
        title: 'Workflow Orchestration',
        description: 'Temporal delivers a reliable workflow engine for complex business logic with comprehensive monitoring and management interface.',
        icon: Icons.account_tree,
      ),
      FeatureItem(
        title: 'Microservices Architecture',
        description: 'Go-based services with hexagonal architecture, database-per-service pattern, and gRPC communication with REST API translation.',
        icon: Icons.code,
      ),
      FeatureItem(
        title: 'Complete Observability',
        description: 'Production-ready monitoring and logging with Prometheus, Grafana, and Elasticsearch for centralized logging and trace analysis.',
        icon: Icons.bar_chart,
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
            'Comprehensive Features',
            style: const TextStyle(
              fontSize: 36, // text-3xl
              fontWeight: FontWeight.bold,
              color: Color(0xFF111827), // gray-900
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'SaaSter Kit provides everything you need to build, deploy, and scale your SaaS application.',
            style: const TextStyle(
              fontSize: 20, // text-xl
              color: Color(0xFF6B7280), // gray-600
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
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5E7EB)), // gray-200
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: Icon(
              feature.icon,
              size: 32,
              color: const Color(0xFF4F46E5), // indigo-600
            ),
          ),
          Text(
            feature.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF111827), // gray-900
              height: 1.3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            feature.description,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF6B7280), // gray-600
              height: 1.5,
            ),
          ),
        ],
      ),
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
