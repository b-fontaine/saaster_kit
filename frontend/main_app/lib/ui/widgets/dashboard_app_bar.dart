import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DashboardAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: DSColors.surfaceApp,
      elevation: 1,
      title: Text(
        'SaaSter Dashboard',
        style: DSTypography.appTextTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        _buildNavLink('Kong Admin', 'http://localhost:8001'),
        _buildNavLink('Widgetbook', 'http://localhost/widgetbook'),
        _buildNavLink('Grafana', 'http://localhost/grafana'),
        _buildNavLink('Keycloak', 'http://localhost/auth'),
        _buildNavLink('Temporal UI', 'http://localhost/temporal'),
        _buildNavLink('Safeline UI', 'https://localhost:9443'),
        DSSpacing.horizontalSpacerMD,
        const ProfileSection(),
        DSSpacing.horizontalSpacerMD,
      ],
    );
  }

  Widget _buildNavLink(String title, String url) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: DSButtons.textAppButton(
        text: title,
        onPressed: () async {
          final uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri);
          }
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: DSColors.primaryApp,
            child: Text(
              'JD',
              style: DSTypography.appTextTheme.labelMedium?.copyWith(
                color: DSColors.textOnPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          DSSpacing.horizontalSpacerXS,
          Text(
            'John Doe',
            style: DSTypography.appTextTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          DSSpacing.horizontalSpacerXS,
          const Icon(Icons.arrow_drop_down),
        ],
      ),
      itemBuilder: (context) => [
        PopupMenuItem<String>(
          value: 'profile',
          child: Row(
            children: [
              const Icon(Icons.person),
              DSSpacing.horizontalSpacerSM,
              const Text('Profile'),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'logout',
          child: Row(
            children: [
              const Icon(Icons.logout),
              DSSpacing.horizontalSpacerSM,
              const Text('Logout'),
            ],
          ),
        ),
      ],
      onSelected: (value) {
        // Do nothing as specified in requirements
      },
    );
  }
}
