import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:saaster/domain/domain_module.dart';
import 'package:saaster/injection.dart';
import 'package:url_launcher/url_launcher_string.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 0;

  final _navigationItems = [
    NavigationItem(
      icon: DSIcons.dashboard,
      activeIcon: DSIcons.dashboard,
      label: 'Dashboard',
    ),
    NavigationItem(
      icon: DSIcons.settings,
      activeIcon: DSIcons.settings,
      label: 'Settings',
    ),
    NavigationItem(
      icon: DSIcons.profile,
      activeIcon: DSIcons.profile,
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DSAppScaffold.responsive(
      context: context,
      title: 'SaaSter Kit',
      backgroundColor: DSColors.backgroundApp,
      appBarBackgroundColor: DSColors.primaryApp,
      appBarForegroundColor: DSColors.textOnPrimary,
      navigationItems: _navigationItems,
      selectedIndex: _selectedIndex,
      onNavigationItemSelected: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    // Different content based on selected navigation item
    switch (_selectedIndex) {
      case 0:
        return _buildDashboard();
      case 1:
        return _buildSettings();
      case 2:
        return _buildProfile();
      default:
        return _buildDashboard();
    }
  }

  Widget _buildDashboard() {
    return DSResponsiveLayout.responsiveBuilder(
      context: context,
      mobile: _buildDashboardContent(isMobile: true),
      tablet: _buildDashboardContent(isMobile: false),
      desktop: _buildDashboardContent(isMobile: false),
    );
  }

  Widget _buildDashboardContent({required bool isMobile}) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Dashboard', style: DSTypography.appTextTheme.headlineMedium),
          const SizedBox(height: 24),

          // Stats cards row
          DSResponsiveLayout.responsiveGrid(
            context: context,
            mobileColumns: 1,
            tabletColumns: 2,
            desktopColumns: 4,
            spacing: 16,
            runSpacing: 16,
            children: [
              _buildStatCard(
                title: 'Total Users',
                value: '1,234',
                icon: DSIcons.profile,
                color: DSColors.primaryApp,
              ),
              _buildStatCard(
                title: 'Active Projects',
                value: '42',
                icon: DSIcons.dashboard,
                color: DSColors.successApp,
              ),
              _buildStatCard(
                title: 'Revenue',
                value: '\$12,345',
                icon: DSIcons.star,
                color: DSColors.warningApp,
              ),
              _buildStatCard(
                title: 'Tasks',
                value: '89',
                icon: DSIcons.list,
                color: DSColors.infoApp,
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Main content card
          DSCards.appElevatedCard(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to SaaSter Kit',
                  style: DSTypography.appTextTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Your complete SaaS starter kit with all the tools you need to build and scale your SaaS application.',
                  style: DSTypography.appTextTheme.bodyLarge,
                ),
                const SizedBox(height: 24),
                DSButtons.primaryAppButton(
                  text: 'Get Started',
                  onPressed: () async {
                    if (await getIt<GetIsConnected>()()) {
                      launchUrlString(
                        "https://github.com/b-fontaine/saaster_kit",
                      );
                    } else {
                      getIt<LoginUser>()();
                    }
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Recent activity list
          DSCards.appCardWithHeader(
            title: 'Recent Activity',
            actions: [
              IconButton(icon: const Icon(DSIcons.refresh), onPressed: () {}),
            ],
            child: Column(
              children: [
                DSLists.appListItem(
                  title: 'New user registered',
                  subtitle: '2 minutes ago',
                  leading: const CircleAvatar(
                    backgroundColor: DSColors.primaryApp,
                    child: Icon(DSIcons.profile, color: Colors.white, size: 20),
                  ),
                  context: context,
                ),
                const Divider(),
                DSLists.appListItem(
                  title: 'Task completed',
                  subtitle: '1 hour ago',
                  leading: const CircleAvatar(
                    backgroundColor: DSColors.successApp,
                    child: Icon(DSIcons.check, color: Colors.white, size: 20),
                  ),
                  context: context,
                ),
                const Divider(),
                DSLists.appListItem(
                  title: 'Payment received',
                  subtitle: 'Yesterday',
                  leading: const CircleAvatar(
                    backgroundColor: DSColors.infoApp,
                    child: Icon(DSIcons.star, color: Colors.white, size: 20),
                  ),
                  context: context,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return DSCards.appElevatedCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: DSBorders.borderRadiusMD,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: DSTypography.appTextTheme.bodyMedium?.copyWith(
                    color: DSColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: DSTypography.appTextTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettings() {
    return Center(
      child: DSCards.appElevatedCard(
        padding: const EdgeInsets.all(24),
        margin: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(DSIcons.settings, size: 48, color: DSColors.primaryApp),
            const SizedBox(height: 16),
            Text(
              'Settings',
              style: DSTypography.appTextTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Settings page coming soon',
              style: DSTypography.appTextTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfile() {
    return Center(
      child: DSCards.appElevatedCard(
        padding: const EdgeInsets.all(24),
        margin: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(DSIcons.profile, size: 48, color: DSColors.primaryApp),
            const SizedBox(height: 16),
            Text(
              'Profile',
              style: DSTypography.appTextTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Profile page coming soon',
              style: DSTypography.appTextTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
