import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final footerSections = [
      FooterLinkSection(
        title: 'Product',
        links: [
          FooterLink(title: 'Features', url: '#'),
          FooterLink(title: 'Pricing', url: '#'),
          FooterLink(title: 'Documentation', url: '#'),
          FooterLink(title: 'Roadmap', url: '#'),
        ],
      ),
      FooterLinkSection(
        title: 'Company',
        links: [
          FooterLink(title: 'About Us', url: '#'),
          FooterLink(title: 'Blog', url: '#'),
          FooterLink(title: 'Careers', url: '#'),
          FooterLink(title: 'Contact', url: '#'),
        ],
      ),
      FooterLinkSection(
        title: 'Resources',
        links: [
          FooterLink(title: 'Community', url: '#'),
          FooterLink(title: 'Help Center', url: '#'),
          FooterLink(title: 'Status', url: '#'),
          FooterLink(title: 'GitHub', url: '#'),
        ],
      ),
      FooterLinkSection(
        title: 'Legal',
        links: [
          FooterLink(title: 'Terms of Service', url: '#'),
          FooterLink(title: 'Privacy Policy', url: '#'),
          FooterLink(title: 'Cookie Policy', url: '#'),
        ],
      ),
    ];

    return Container(
      padding: DSSpacing.getPagePadding(context),
      color: const Color(0xFF1A1A1A),
      child: Column(
        children: [
          const SizedBox(height: 60),
          DSResponsiveLayout.responsiveRowColumn(
            context: context,
            breakpoint: 768,
            spacing: 40,
            rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
            columnMainAxisAlignment: MainAxisAlignment.start,
            columnCrossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Company info
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(DSIcons.dashboard, color: DSColors.primaryLanding, size: 32),
                      const SizedBox(width: 8),
                      Text(
                        'SaaSter Kit',
                        style: DSTypography.landingTextTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 300,
                    child: Text(
                      'A complete, production-ready SaaS starter kit with microservices architecture.',
                      style: DSTypography.landingTextTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: (0.7 * 255).toDouble()),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      _buildSocialIcon(Icons.flutter_dash),
                      const SizedBox(width: 16),
                      _buildSocialIcon(Icons.code),
                      const SizedBox(width: 16),
                      _buildSocialIcon(Icons.cloud),
                    ],
                  ),
                ],
              ),
              // Footer links
              ...footerSections.map((section) => _buildFooterLinkSection(section)),
            ],
          ),
          const SizedBox(height: 60),
          const Divider(color: Color(0xFF333333)),
          const SizedBox(height: 24),
          Text(
            '© ${DateTime.now().year} SaaSter Kit. All rights reserved.',
            style: DSTypography.landingTextTheme.bodySmall?.copyWith(
              color: Colors.white.withValues(alpha: (0.5 * 255).toDouble()),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: (0.1 * 255).toDouble()),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 20,
      ),
    );
  }

  Widget _buildFooterLinkSection(FooterLinkSection section) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          section.title,
          style: DSTypography.landingTextTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        ...section.links.map((link) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                link.title,
                style: DSTypography.landingTextTheme.bodyMedium?.copyWith(
                  color: Colors.white.withValues(alpha: (0.7 * 255).toDouble()),
                ),
              ),
            )),
      ],
    );
  }
}

class FooterLinkSection {
  final String title;
  final List<FooterLink> links;

  FooterLinkSection({
    required this.title,
    required this.links,
  });
}

class FooterLink {
  final String title;
  final String url;

  FooterLink({
    required this.title,
    required this.url,
  });
}
