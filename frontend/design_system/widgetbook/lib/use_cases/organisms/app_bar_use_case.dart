import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

/// Showcase for the standard app bar
class StandardAppBarShowcase extends StatelessWidget {
  const StandardAppBarShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Standard App Bar
          _buildAppBarSection(
            'Standard App Bar',
            DSAppBars.appStandardAppBar(
              context: context,
              title: 'Standard App Bar',
            ),
          ),

          // Standard App Bar with Actions
          _buildAppBarSection(
            'With Actions',
            DSAppBars.appStandardAppBar(
              context: context,
              title: 'With Actions',
              actions: [
                IconButton(
                  icon: const Icon(DSIcons.notifications),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(DSIcons.settings),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          // Standard App Bar with Leading Icon
          _buildAppBarSection(
            'With Leading Icon',
            DSAppBars.appStandardAppBar(
              context: context,
              title: 'With Leading Icon',
              leading: IconButton(
                icon: const Icon(DSIcons.menu),
                onPressed: () {},
              ),
            ),
          ),

          // Standard App Bar with Center Title
          _buildAppBarSection(
            'With Center Title',
            DSAppBars.appStandardAppBar(
              context: context,
              title: 'Centered Title',
              centerTitle: true,
            ),
          ),

          // Standard App Bar with Custom Colors
          _buildAppBarSection(
            'With Custom Colors',
            DSAppBars.appStandardAppBar(
              context: context,
              title: 'Custom Colors',
              backgroundColor: DSColors.secondaryApp,
              foregroundColor: Colors.white,
            ),
          ),

          // Standard App Bar with Elevation
          _buildAppBarSection(
            'With Elevation',
            DSAppBars.appStandardAppBar(
              context: context,
              title: 'With Elevation',
              elevation: 4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBarSection(String title, PreferredSizeWidget appBar) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(title, style: DSTypography.appTextTheme.titleMedium),
        ),
        SizedBox(height: 56, child: appBar),
        const Divider(),
      ],
    );
  }
}

/// Showcase for the transparent app bar
class TransparentAppBarShowcase extends StatelessWidget {
  const TransparentAppBarShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Transparent App Bar
          _buildAppBarSection(
            'Transparent App Bar',
            DSAppBars.appTransparentAppBar(
              context: context,
              title: 'Transparent App Bar',
            ),
          ),

          // Transparent App Bar with Actions
          _buildAppBarSection(
            'With Actions',
            DSAppBars.appTransparentAppBar(
              context: context,
              title: 'With Actions',
              actions: [
                IconButton(
                  icon: const Icon(DSIcons.notifications),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(DSIcons.settings),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          // Transparent App Bar with Leading Icon
          _buildAppBarSection(
            'With Leading Icon',
            DSAppBars.appTransparentAppBar(
              context: context,
              title: 'With Leading Icon',
              leading: IconButton(
                icon: const Icon(DSIcons.menu),
                onPressed: () {},
              ),
            ),
          ),

          // Transparent App Bar with Center Title
          _buildAppBarSection(
            'With Center Title',
            DSAppBars.appTransparentAppBar(
              context: context,
              title: 'Centered Title',
              centerTitle: true,
            ),
          ),

          // Transparent App Bar with Custom Foreground Color
          _buildAppBarSection(
            'With Custom Foreground Color',
            DSAppBars.appTransparentAppBar(
              context: context,
              title: 'Custom Foreground',
              foregroundColor: DSColors.primaryApp,
            ),
          ),

          // Transparent App Bar without Title
          _buildAppBarSection(
            'Without Title',
            DSAppBars.appTransparentAppBar(
              context: context,
              actions: [
                IconButton(
                  icon: const Icon(DSIcons.notifications),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBarSection(String title, PreferredSizeWidget appBar) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(title, style: DSTypography.appTextTheme.titleMedium),
        ),
        Container(
          height: 56,
          color: Colors.grey.withOpacity(
            0.1,
          ), // Background to show transparency
          child: appBar,
        ),
        const Divider(),
      ],
    );
  }
}

/// Showcase for the search app bar
class SearchAppBarShowcase extends StatefulWidget {
  const SearchAppBarShowcase({super.key});

  @override
  State<SearchAppBarShowcase> createState() => _SearchAppBarShowcaseState();
}

class _SearchAppBarShowcaseState extends State<SearchAppBarShowcase> {
  final TextEditingController _searchController1 = TextEditingController();
  final TextEditingController _searchController2 = TextEditingController();
  final TextEditingController _searchController3 = TextEditingController();
  final TextEditingController _searchController4 = TextEditingController();

  @override
  void dispose() {
    _searchController1.dispose();
    _searchController2.dispose();
    _searchController3.dispose();
    _searchController4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Search App Bar
          _buildAppBarSection(
            'Search App Bar',
            DSAppBars.appSearchAppBar(
              context: context,
              searchController: _searchController1,
              onSubmitted: (value) {},
            ),
          ),

          // Search App Bar with Actions
          _buildAppBarSection(
            'With Actions',
            DSAppBars.appSearchAppBar(
              context: context,
              searchController: _searchController2,
              onSubmitted: (value) {},
              actions: [
                IconButton(icon: const Icon(DSIcons.filter), onPressed: () {}),
              ],
            ),
          ),

          // Search App Bar with Custom Hint
          _buildAppBarSection(
            'With Custom Hint',
            DSAppBars.appSearchAppBar(
              context: context,
              searchController: _searchController3,
              onSubmitted: (value) {},
              hintText: 'Search products...',
            ),
          ),

          // Search App Bar with Custom Colors
          _buildAppBarSection(
            'With Custom Colors',
            DSAppBars.appSearchAppBar(
              context: context,
              searchController: _searchController4,
              onSubmitted: (value) {},
              backgroundColor: DSColors.secondaryApp,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBarSection(String title, PreferredSizeWidget appBar) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(title, style: DSTypography.appTextTheme.titleMedium),
        ),
        SizedBox(height: 56, child: appBar),
        const Divider(),
      ],
    );
  }
}

/// Showcase for the sliver app bar
class SliverAppBarShowcase extends StatelessWidget {
  const SliverAppBarShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Sliver App Bar Examples',
              style: DSTypography.appTextTheme.titleLarge,
            ),
          ),
          Expanded(
            child: DefaultTabController(
              length: 4,
              child: Column(
                children: [
                  TabBar(
                    tabs: const [
                      Tab(text: 'Standard'),
                      Tab(text: 'With Subtitle'),
                      Tab(text: 'Floating'),
                      Tab(text: 'Custom'),
                    ],
                    labelColor: DSColors.primaryApp,
                    unselectedLabelColor: DSColors.textSecondary,
                    indicatorColor: DSColors.primaryApp,
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        // Standard Sliver App Bar
                        _buildSliverAppBarExample(
                          context,
                          title: 'Standard Sliver App Bar',
                          subtitle: null,
                          floating: false,
                          snap: false,
                        ),

                        // Sliver App Bar with Subtitle
                        _buildSliverAppBarExample(
                          context,
                          title: 'Sliver App Bar with Subtitle',
                          subtitle: 'This is a subtitle',
                          floating: false,
                          snap: false,
                        ),

                        // Floating Sliver App Bar
                        _buildSliverAppBarExample(
                          context,
                          title: 'Floating Sliver App Bar',
                          subtitle: null,
                          floating: true,
                          snap: true,
                        ),

                        // Custom Sliver App Bar
                        _buildSliverAppBarExample(
                          context,
                          title: 'Custom Sliver App Bar',
                          subtitle: null,
                          floating: false,
                          snap: false,
                          backgroundColor: DSColors.secondaryApp,
                          foregroundColor: Colors.white,
                          expandedHeight: 250,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBarExample(
    BuildContext context, {
    required String title,
    String? subtitle,
    bool floating = false,
    bool snap = false,
    Color? backgroundColor,
    Color? foregroundColor,
    double expandedHeight = 200,
  }) {
    return CustomScrollView(
      slivers: [
        DSAppBars.appSliverAppBar(
          context: context,
          title: title,
          subtitle: subtitle,
          actions: [
            IconButton(icon: const Icon(DSIcons.settings), onPressed: () {}),
          ],
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          expandedHeight: expandedHeight,
          floating: floating,
          snap: snap,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return ListTile(
              title: Text('Item ${index + 1}'),
              subtitle: Text('Description for item ${index + 1}'),
              leading: const Icon(DSIcons.tablet),
            );
          }, childCount: 30),
        ),
      ],
    );
  }
}

/// Showcase for the landing app bar
class LandingAppBarShowcase extends StatelessWidget {
  const LandingAppBarShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Landing App Bar
          _buildAppBarSection(
            'Landing App Bar',
            DSAppBars.landingAppBar(context: context, title: 'Landing App Bar'),
          ),

          // Landing App Bar with Actions
          _buildAppBarSection(
            'With Actions',
            DSAppBars.landingAppBar(
              context: context,
              title: 'With Actions',
              actions: [
                TextButton(onPressed: () {}, child: const Text('Sign In')),
                TextButton(onPressed: () {}, child: const Text('Sign Up')),
              ],
            ),
          ),

          // Landing App Bar with Leading Icon
          _buildAppBarSection(
            'With Leading Icon',
            DSAppBars.landingAppBar(
              context: context,
              title: 'With Leading Icon',
              leading: IconButton(
                icon: const Icon(DSIcons.menu),
                onPressed: () {},
              ),
            ),
          ),

          // Landing App Bar with Center Title
          _buildAppBarSection(
            'With Center Title',
            DSAppBars.landingAppBar(
              context: context,
              title: 'Centered Title',
              centerTitle: true,
            ),
          ),

          // Landing App Bar with Background Color
          _buildAppBarSection(
            'With Background Color',
            DSAppBars.landingAppBar(
              context: context,
              title: 'With Background',
              backgroundColor: DSColors.primaryLanding.withOpacity(0.1),
            ),
          ),

          // Landing App Bar with Custom Colors
          _buildAppBarSection(
            'With Custom Colors',
            DSAppBars.landingAppBar(
              context: context,
              title: 'Custom Colors',
              backgroundColor: DSColors.primaryLanding,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBarSection(String title, PreferredSizeWidget appBar) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(title, style: DSTypography.appTextTheme.titleMedium),
        ),
        Container(
          height: 56,
          color: Colors.grey.withOpacity(
            0.1,
          ), // Background to show transparency
          child: appBar,
        ),
        const Divider(),
      ],
    );
  }
}

/// Showcase for the landing nav app bar
class LandingNavAppBarShowcase extends StatelessWidget {
  const LandingNavAppBarShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    // Create navigation items
    final List<AppBarNavigationItem> navigationItems = [
      AppBarNavigationItem(label: 'Home', onTap: () {}, isActive: true),
      AppBarNavigationItem(label: 'Features', onTap: () {}),
      AppBarNavigationItem(label: 'Pricing', onTap: () {}),
      AppBarNavigationItem(label: 'About', onTap: () {}),
      AppBarNavigationItem(label: 'Contact', onTap: () {}),
    ];

    return Scaffold(
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: DSColors.primaryLanding),
              child: Text(
                'Navigation',
                style: DSTypography.landingTextTheme.titleLarge?.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
            ...navigationItems.map(
              (item) => ListTile(
                title: Text(item.label),
                selected: item.isActive,
                onTap: item.onTap,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Landing Nav App Bar
          _buildAppBarSection(
            'Landing Nav App Bar',
            DSAppBars.landingNavAppBar(
              context: context,
              title: 'Company Name',
              navigationItems: navigationItems,
              actionButton: ElevatedButton(
                onPressed: () {},
                child: const Text('Get Started'),
              ),
            ),
          ),

          // Landing Nav App Bar with Logo
          _buildAppBarSection(
            'With Logo',
            DSAppBars.landingNavAppBar(
              context: context,
              title: 'Company Name',
              navigationItems: navigationItems,
              logo: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(DSIcons.star, color: DSColors.primaryLanding, size: 32),
                  const SizedBox(width: 8),
                  Text(
                    'Brand',
                    style: DSTypography.landingTextTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              actionButton: ElevatedButton(
                onPressed: () {},
                child: const Text('Sign Up'),
              ),
            ),
          ),

          // Landing Nav App Bar with Background Color
          _buildAppBarSection(
            'With Background Color',
            DSAppBars.landingNavAppBar(
              context: context,
              title: 'Company Name',
              navigationItems: navigationItems,
              backgroundColor: DSColors.primaryLanding,
              foregroundColor: Colors.white,
              actionButton: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white),
                ),
                child: const Text('Get Started'),
              ),
            ),
          ),

          // Landing Nav App Bar with Elevation
          _buildAppBarSection(
            'With Elevation',
            DSAppBars.landingNavAppBar(
              context: context,
              title: 'Company Name',
              navigationItems: navigationItems,
              elevation: 4,
              actionButton: ElevatedButton(
                onPressed: () {},
                child: const Text('Get Started'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBarSection(String title, PreferredSizeWidget appBar) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(title, style: DSTypography.appTextTheme.titleMedium),
        ),
        Container(
          height: 80,
          color: Colors.grey.withOpacity(
            0.1,
          ), // Background to show transparency
          child: appBar,
        ),
        const Divider(),
      ],
    );
  }
}
