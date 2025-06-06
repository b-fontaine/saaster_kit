import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';
import 'package:lucide_icons/lucide_icons.dart';

/// Features section that exactly matches the websitejs Features component
class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  static const List<_FeatureData> _features = [
    _FeatureData(
      title: 'Enhanced Security Stack',
      description: 'SafeLine WAF integration provides advanced protection against SQL injection, XSS, DoS attacks, bot threats, and OWASP Top 10 vulnerabilities.',
      icon: LucideIcons.shield,
    ),
    _FeatureData(
      title: 'Frontend Applications',
      description: 'Flutter-based cross-platform solutions with Material UI and atomic design pattern for web, mobile, and desktop.',
      icon: LucideIcons.layers,
    ),
    _FeatureData(
      title: 'API Gateway & Security',
      description: 'Kong Enterprise API Gateway for routing, authentication, rate limiting, and protocol translation plus SafeLine WAF for threat detection.',
      icon: LucideIcons.shield,
    ),
    _FeatureData(
      title: 'Identity & Access Management',
      description: 'Keycloak provides enterprise-grade authentication, authorization, and multi-tenant user management with role-based access control.',
      icon: LucideIcons.lock,
    ),
    _FeatureData(
      title: 'Workflow Orchestration',
      description: 'Temporal delivers a reliable workflow engine for complex business logic with comprehensive monitoring and management interface.',
      icon: LucideIcons.workflow,
    ),
    _FeatureData(
      title: 'Microservices Architecture',
      description: 'Go-based services with hexagonal architecture, database-per-service pattern, and gRPC communication with REST API translation.',
      icon: LucideIcons.code,
    ),
    _FeatureData(
      title: 'Complete Observability',
      description: 'Production-ready monitoring and logging with Prometheus, Grafana, and Elasticsearch for centralized logging and trace analysis.',
      icon: LucideIcons.barChart3,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // section id="features" className="py-16 bg-white"
    return Container(
      color: Colors.white, // bg-white
      child: DSResponsiveLayout.responsiveContainer(
        maxWidth: 1280, // max-w-7xl
        padding: ResponsiveUtils.responsivePadding(
          context,
          defaultPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 64), // px-4 py-16
          sm: const EdgeInsets.symmetric(horizontal: 24, vertical: 64), // sm:px-6 py-16
          lg: const EdgeInsets.symmetric(horizontal: 32, vertical: 64), // lg:px-8 py-16
        ),
        child: const Column(
          children: [
            _FeaturesHeader(),
            SizedBox(height: 64), // mb-16 equivalent
            _FeaturesGrid(),
          ],
        ),
      ),
    );
  }
}

// Separate widget classes for better performance and reusability
class _FeaturesHeader extends StatelessWidget {
  const _FeaturesHeader();

  @override
  Widget build(BuildContext context) {
    // div className="text-center mb-16"
    return Column(
      children: [
        // h2 className="text-3xl font-bold text-gray-900 mb-4"
        Text(
          'Comprehensive Features',
          style: DSTypography.text3Xl(context).copyWith(
            fontWeight: FontWeight.bold, // font-bold
            color: DSColors.gray900, // text-gray-900
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16), // mb-4
        // p className="text-xl text-gray-600 max-w-3xl mx-auto"
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 768), // max-w-3xl
          child: Text(
            'SaaSter Kit provides everything you need to build, deploy, and scale your SaaS application.',
            style: DSTypography.textXl(context).copyWith(
              color: DSColors.gray600, // text-gray-600
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class _FeaturesGrid extends StatelessWidget {
  const _FeaturesGrid();

  @override
  Widget build(BuildContext context) {
    // div className="grid md:grid-cols-2 lg:grid-cols-3 gap-8"
    return ResponsiveUtils.responsiveValue<Widget>(
      context: context,
      defaultValue: Column(
        children: FeaturesSection._features
            .map((feature) => Padding(
                  padding: const EdgeInsets.only(bottom: 32), // gap-8
                  child: _FeatureCard(feature: feature),
                ))
            .toList(),
      ),
      md: Wrap(
        spacing: 32, // gap-8
        runSpacing: 32,
        children: FeaturesSection._features
            .map((feature) => SizedBox(
                  width: (MediaQuery.of(context).size.width - 96) / 2, // 2 columns on md
                  child: _FeatureCard(feature: feature),
                ))
            .toList(),
      ),
      lg: Wrap(
        spacing: 32, // gap-8
        runSpacing: 32,
        children: FeaturesSection._features
            .map((feature) => SizedBox(
                  width: (MediaQuery.of(context).size.width - 128) / 3, // 3 columns on lg
                  child: _FeatureCard(feature: feature),
                ))
            .toList(),
      ),
    );
  }
}

class _FeatureCard extends StatefulWidget {
  final _FeatureData feature;

  const _FeatureCard({required this.feature});

  @override
  State<_FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<_FeatureCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    // div className="bg-white rounded-lg p-6 border border-gray-200 shadow-sm hover:shadow-md transition-shadow"
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200), // transition-shadow
        padding: const EdgeInsets.all(24), // p-6
        decoration: BoxDecoration(
          color: Colors.white, // bg-white
          borderRadius: BorderRadius.circular(8), // rounded-lg
          border: Border.all(color: DSColors.gray200), // border-gray-200
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: _isHovered ? 0.1 : 0.05), // shadow-sm hover:shadow-md
              blurRadius: _isHovered ? 6 : 4,
              offset: Offset(0, _isHovered ? 2 : 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // div className="mb-4"
            Container(
              margin: const EdgeInsets.only(bottom: 16), // mb-4
              child: Icon(
                widget.feature.icon,
                size: 32, // h-8 w-8 equivalent
                color: DSColors.primaryLanding, // text-indigo-600
              ),
            ),
            // h3 className="text-xl font-semibold mb-2 text-gray-900"
            Text(
              widget.feature.title,
              style: DSTypography.textXl(context).copyWith(
                fontWeight: FontWeight.w600, // font-semibold
                color: DSColors.gray900, // text-gray-900
              ),
            ),
            const SizedBox(height: 8), // mb-2
            // p className="text-gray-600"
            Text(
              widget.feature.description,
              style: DSTypography.textBase(context).copyWith(
                color: DSColors.gray600, // text-gray-600
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureData {
  final String title;
  final String description;
  final IconData icon;

  const _FeatureData({
    required this.title,
    required this.description,
    required this.icon,
  });
}
