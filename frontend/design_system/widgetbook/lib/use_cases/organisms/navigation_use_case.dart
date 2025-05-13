import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// Showcase for bottom navigation bar
class BottomNavBarShowcase extends StatefulWidget {
  const BottomNavBarShowcase({super.key});

  @override
  State<BottomNavBarShowcase> createState() => _BottomNavBarShowcaseState();
}

class _BottomNavBarShowcaseState extends State<BottomNavBarShowcase> {
  int _currentIndex = 0;

  final List<BottomNavigationItem> _items = [
    BottomNavigationItem(
      icon: DSIcons.home,
      activeIcon: DSIcons.home,
      label: 'Home',
    ),
    BottomNavigationItem(
      icon: DSIcons.search,
      activeIcon: DSIcons.search,
      label: 'Search',
    ),
    BottomNavigationItem(
      icon: DSIcons.favorite,
      activeIcon: DSIcons.favorite,
      label: 'Favorites',
    ),
    BottomNavigationItem(
      icon: DSIcons.profile,
      activeIcon: DSIcons.profile,
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bottom Navigation Bar',
              style: DSTypography.appTextTheme.titleLarge,
            ),
            const SizedBox(height: 24),

            // Standard Bottom Navigation Bar
            _buildSectionTitle('Standard Bottom Navigation Bar'),
            _buildBottomNavBarExample(
              DSNavigation.appBottomNavBar(
                context: context,
                items: _items,
                currentIndex: _currentIndex,
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
            const SizedBox(height: 32),

            // Bottom Navigation Bar with Custom Colors
            _buildSectionTitle('Custom Colors'),
            _buildBottomNavBarExample(
              DSNavigation.appBottomNavBar(
                context: context,
                items: _items,
                currentIndex: _currentIndex,
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                backgroundColor: DSColors.primaryApp,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.white.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 32),

            // Bottom Navigation Bar with Shifting Type
            _buildSectionTitle('Shifting Type'),
            _buildBottomNavBarExample(
              DSNavigation.appBottomNavBar(
                context: context,
                items: [
                  BottomNavigationItem(
                    icon: DSIcons.home,
                    activeIcon: DSIcons.home,
                    label: 'Home',
                    backgroundColor: DSColors.primaryApp,
                  ),
                  BottomNavigationItem(
                    icon: DSIcons.search,
                    activeIcon: DSIcons.search,
                    label: 'Search',
                    backgroundColor: DSColors.secondaryApp,
                  ),
                  BottomNavigationItem(
                    icon: DSIcons.favorite,
                    activeIcon: DSIcons.favorite,
                    label: 'Favorites',
                    backgroundColor: DSColors.accentApp,
                  ),
                  BottomNavigationItem(
                    icon: DSIcons.profile,
                    activeIcon: DSIcons.profile,
                    label: 'Profile',
                    backgroundColor: DSColors.successApp,
                  ),
                ],
                currentIndex: _currentIndex,
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                type: BottomNavigationBarType.shifting,
              ),
            ),
            const SizedBox(height: 32),

            // Bottom Navigation Bar with Custom Icon Size
            _buildSectionTitle('Custom Icon Size'),
            _buildBottomNavBarExample(
              DSNavigation.appBottomNavBar(
                context: context,
                items: _items,
                currentIndex: _currentIndex,
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                iconSize: 32,
                selectedFontSize: 14,
                unselectedFontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(title, style: DSTypography.appTextTheme.titleMedium),
    );
  }

  Widget _buildBottomNavBarExample(Widget bottomNavBar) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: DSColors.divider),
        borderRadius: DSBorders.borderRadiusMD,
      ),
      child: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.only(
                topLeft: DSBorders.borderRadiusMD.topLeft,
                topRight: DSBorders.borderRadiusMD.topRight,
              ),
            ),
            child: Center(
              child: Text(
                'Content for tab ${_currentIndex + 1}',
                style: DSTypography.appTextTheme.titleMedium,
              ),
            ),
          ),
          SizedBox(height: 56, child: bottomNavBar),
        ],
      ),
    );
  }
}

/// Showcase for navigation rail
class NavigationRailShowcase extends StatefulWidget {
  const NavigationRailShowcase({super.key});

  @override
  State<NavigationRailShowcase> createState() => _NavigationRailShowcaseState();
}

class _NavigationRailShowcaseState extends State<NavigationRailShowcase> {
  int _selectedIndex = 0;
  bool _isExtended = false;

  final List<NavigationRailItem> _items = [
    NavigationRailItem(
      icon: DSIcons.home,
      activeIcon: DSIcons.home,
      label: 'Home',
    ),
    NavigationRailItem(
      icon: DSIcons.search,
      activeIcon: DSIcons.search,
      label: 'Search',
    ),
    NavigationRailItem(
      icon: DSIcons.favorite,
      activeIcon: DSIcons.favorite,
      label: 'Favorites',
    ),
    NavigationRailItem(
      icon: DSIcons.profile,
      activeIcon: DSIcons.profile,
      label: 'Profile',
    ),
    NavigationRailItem(
      icon: DSIcons.settings,
      activeIcon: DSIcons.settings,
      label: 'Settings',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Navigation Rail',
                  style: DSTypography.appTextTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      'Extended:',
                      style: DSTypography.appTextTheme.bodyLarge,
                    ),
                    const SizedBox(width: 8),
                    Switch(
                      value: _isExtended,
                      onChanged: (value) {
                        setState(() {
                          _isExtended = value;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: DSColors.divider),
                borderRadius: DSBorders.borderRadiusMD,
                color: Colors.white,
              ),
              margin: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Navigation Rail
                  DSNavigation.appNavigationRail(
                    context: context,
                    items: _items,
                    selectedIndex: _selectedIndex,
                    onDestinationSelected: (index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    extended: _isExtended,
                    leading: FloatingActionButton(
                      onPressed: () {},
                      child: const Icon(DSIcons.add),
                    ),
                  ),

                  // Content Area
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _items[_selectedIndex].activeIcon ??
                                _items[_selectedIndex].icon,
                            size: 48,
                            color: DSColors.primaryApp,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _items[_selectedIndex].label,
                            style: DSTypography.appTextTheme.titleLarge,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Content for ${_items[_selectedIndex].label}',
                            style: DSTypography.appTextTheme.bodyLarge,
                          ),
                        ],
                      ),
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
}

/// Showcase for drawer navigation
class DrawerShowcase extends StatefulWidget {
  const DrawerShowcase({super.key});

  @override
  State<DrawerShowcase> createState() => _DrawerShowcaseState();
}

class _DrawerShowcaseState extends State<DrawerShowcase> {
  int _selectedIndex = 0;
  bool _showAppDrawer = true;

  final List<DrawerItem> _appDrawerItems = [
    DrawerItem(
      title: 'Home',
      icon: DSIcons.home,
      onTap: () {},
      isSelected: true,
    ),
    DrawerItem(
      title: 'Inbox',
      icon: DSIcons.email,
      subtitle: '3 new messages',
      onTap: () {},
    ),
    DrawerItem(title: 'Favorites', icon: DSIcons.favorite, onTap: () {}),
    DrawerItem.divider(),
    DrawerItem.header('Settings'),
    DrawerItem(title: 'Account', icon: DSIcons.profile, onTap: () {}),
    DrawerItem(title: 'Preferences', icon: DSIcons.settings, onTap: () {}),
    DrawerItem(title: 'Help & Feedback', icon: DSIcons.help, onTap: () {}),
  ];

  final List<DrawerItem> _landingDrawerItems = [
    DrawerItem(title: 'Home', onTap: () {}, isSelected: true),
    DrawerItem(title: 'Features', onTap: () {}),
    DrawerItem(title: 'Pricing', onTap: () {}),
    DrawerItem(title: 'About', onTap: () {}),
    DrawerItem.divider(),
    DrawerItem.header('Resources'),
    DrawerItem(title: 'Documentation', icon: DSIcons.bookmark, onTap: () {}),
    DrawerItem(title: 'Blog', icon: DSIcons.download, onTap: () {}),
    DrawerItem(title: 'Support', icon: DSIcons.help, onTap: () {}),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Drawer Navigation',
                  style: DSTypography.appTextTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      'Drawer Type:',
                      style: DSTypography.appTextTheme.bodyLarge,
                    ),
                    const SizedBox(width: 8),
                    SegmentedButton<bool>(
                      segments: const [
                        ButtonSegment<bool>(value: true, label: Text('App')),
                        ButtonSegment<bool>(
                          value: false,
                          label: Text('Landing'),
                        ),
                      ],
                      selected: {_showAppDrawer},
                      onSelectionChanged: (Set<bool> newSelection) {
                        setState(() {
                          _showAppDrawer = newSelection.first;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: DSColors.divider),
                borderRadius: DSBorders.borderRadiusMD,
                color: Colors.white,
              ),
              margin: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Drawer
                  SizedBox(
                    width: 304,
                    child:
                        _showAppDrawer
                            ? DSNavigation.appDrawer(
                              context: context,
                              items: _appDrawerItems,
                              headerTitle: 'App Name',
                              headerSubtitle: 'user@example.com',
                              headerLeading: const CircleAvatar(
                                backgroundColor: DSColors.primaryApp,
                                child: Icon(
                                  DSIcons.profile,
                                  color: Colors.white,
                                ),
                              ),
                            )
                            : DSNavigation.landingMobileDrawer(
                              context: context,
                              items: _landingDrawerItems,
                              headerTitle: 'Company Name',
                              headerLogo: Icon(
                                DSIcons.star,
                                color: DSColors.primaryLanding,
                                size: 32,
                              ),
                              actionButton: SizedBox(
                                width: double.infinity,
                                child: DSButtons.primaryLandingButton(
                                  text: 'Get Started',
                                  onPressed: () {},
                                ),
                              ),
                            ),
                  ),

                  // Content Area
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Main Content Area',
                            style: DSTypography.appTextTheme.titleLarge,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'This is where your app content would appear',
                            style: DSTypography.appTextTheme.bodyLarge,
                          ),
                        ],
                      ),
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
}

/// Showcase for tab bar navigation
class TabBarShowcase extends StatefulWidget {
  const TabBarShowcase({super.key});

  @override
  State<TabBarShowcase> createState() => _TabBarShowcaseState();
}

class _TabBarShowcaseState extends State<TabBarShowcase> {
  late TabController _tabController;
  late TabController _scrollableTabController;

  final List<String> _tabs = ['Home', 'Explore', 'Notifications', 'Messages'];
  final List<String> _scrollableTabs = [
    'For You',
    'Following',
    'Technology',
    'Design',
    'Development',
    'Business',
    'Science',
    'Health',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _tabs.length,
      vsync: const _TabSynchronizer(),
    );
    _scrollableTabController = TabController(
      length: _scrollableTabs.length,
      vsync: const _TabSynchronizer(),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollableTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tab Bar Navigation',
              style: DSTypography.appTextTheme.titleLarge,
            ),
            const SizedBox(height: 24),

            // Standard Tab Bar
            _buildSectionTitle('Standard Tab Bar'),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: DSColors.divider),
                borderRadius: DSBorders.borderRadiusMD,
              ),
              child: Column(
                children: [
                  DSNavigation.appTabBar(
                    context: context,
                    tabs: _tabs,
                    tabController: _tabController,
                  ),
                  SizedBox(
                    height: 200,
                    child: TabBarView(
                      controller: _tabController,
                      children:
                          _tabs
                              .map(
                                (tab) => Center(
                                  child: Text(
                                    '$tab Content',
                                    style:
                                        DSTypography.appTextTheme.titleMedium,
                                  ),
                                ),
                              )
                              .toList(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Scrollable Tab Bar
            _buildSectionTitle('Scrollable Tab Bar'),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: DSColors.divider),
                borderRadius: DSBorders.borderRadiusMD,
              ),
              child: Column(
                children: [
                  DSNavigation.appTabBar(
                    context: context,
                    tabs: _scrollableTabs,
                    tabController: _scrollableTabController,
                    isScrollable: true,
                  ),
                  SizedBox(
                    height: 200,
                    child: TabBarView(
                      controller: _scrollableTabController,
                      children:
                          _scrollableTabs
                              .map(
                                (tab) => Center(
                                  child: Text(
                                    '$tab Content',
                                    style:
                                        DSTypography.appTextTheme.titleMedium,
                                  ),
                                ),
                              )
                              .toList(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Custom Tab Bar
            _buildSectionTitle('Custom Tab Bar'),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: DSColors.divider),
                borderRadius: DSBorders.borderRadiusMD,
              ),
              child: Column(
                children: [
                  DSNavigation.appTabBar(
                    context: context,
                    tabs: _tabs,
                    tabController: _tabController,
                    labelColor: DSColors.secondaryApp,
                    unselectedLabelColor: DSColors.textSecondary,
                    indicatorColor: DSColors.secondaryApp,
                    indicatorWeight: 4,
                    indicatorSize: TabBarIndicatorSize.label,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  SizedBox(
                    height: 200,
                    child: TabBarView(
                      controller: _tabController,
                      children:
                          _tabs
                              .map(
                                (tab) => Center(
                                  child: Text(
                                    '$tab Content',
                                    style:
                                        DSTypography.appTextTheme.titleMedium,
                                  ),
                                ),
                              )
                              .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(title, style: DSTypography.appTextTheme.titleMedium),
    );
  }
}

/// Showcase for responsive navigation
class ResponsiveNavigationShowcase extends StatefulWidget {
  const ResponsiveNavigationShowcase({super.key});

  @override
  State<ResponsiveNavigationShowcase> createState() =>
      _ResponsiveNavigationShowcaseState();
}

class _ResponsiveNavigationShowcaseState
    extends State<ResponsiveNavigationShowcase> {
  int _selectedIndex = 0;
  bool _extendedRail = false;

  final List<NavigationItem> _items = [
    NavigationItem(icon: DSIcons.home, activeIcon: DSIcons.home, label: 'Home'),
    NavigationItem(
      icon: DSIcons.search,
      activeIcon: DSIcons.search,
      label: 'Search',
    ),
    NavigationItem(
      icon: DSIcons.favorite,
      activeIcon: DSIcons.favorite,
      label: 'Favorites',
    ),
    NavigationItem(
      icon: DSIcons.profile,
      activeIcon: DSIcons.profile,
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Responsive Navigation',
                  style: DSTypography.appTextTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'Resize the window to see how navigation adapts to different screen sizes',
                  style: DSTypography.appTextTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      'Extended Rail (Desktop only):',
                      style: DSTypography.appTextTheme.bodyLarge,
                    ),
                    const SizedBox(width: 8),
                    Switch(
                      value: _extendedRail,
                      onChanged: (value) {
                        setState(() {
                          _extendedRail = value;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          Expanded(
            child: DSNavigation.appResponsiveNavigation(
              context: context,
              items: _items,
              selectedIndex: _selectedIndex,
              onItemSelected: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              appTitle: 'App Name',
              appBarActions: [
                IconButton(
                  icon: const Icon(DSIcons.notifications),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(DSIcons.settings),
                  onPressed: () {},
                ),
              ],
              extendedRail: _extendedRail,
              railLeading: FloatingActionButton(
                onPressed: () {},
                child: const Icon(DSIcons.add),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _items[_selectedIndex].activeIcon ??
                          _items[_selectedIndex].icon,
                      size: 48,
                      color: DSColors.primaryApp,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _items[_selectedIndex].label,
                      style: DSTypography.appTextTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Content for ${_items[_selectedIndex].label}',
                      style: DSTypography.appTextTheme.bodyLarge,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Current Breakpoint: ${DSBreakpoints.getBreakpoint(context)}',
                      style: DSTypography.appTextTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {},
                child: const Icon(DSIcons.add),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Showcase for breadcrumbs navigation
class BreadcrumbsShowcase extends StatelessWidget {
  const BreadcrumbsShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Breadcrumbs Navigation',
              style: DSTypography.appTextTheme.titleLarge,
            ),
            const SizedBox(height: 24),

            // Standard Breadcrumbs
            _buildSectionTitle('Standard Breadcrumbs'),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: DSColors.divider),
                borderRadius: DSBorders.borderRadiusMD,
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DSNavigation.appBreadcrumbs(
                    context: context,
                    items: [
                      BreadcrumbItem(label: 'Home', onTap: () {}),
                      BreadcrumbItem(label: 'Products', onTap: () {}),
                      BreadcrumbItem(label: 'Category', onTap: () {}),
                      BreadcrumbItem(label: 'Product Name'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),
                  Text(
                    'Product Name',
                    style: DSTypography.appTextTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Product description and details would appear here.',
                    style: DSTypography.appTextTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Custom Breadcrumbs
            _buildSectionTitle('Custom Breadcrumbs'),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: DSColors.divider),
                borderRadius: DSBorders.borderRadiusMD,
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DSNavigation.appBreadcrumbs(
                    context: context,
                    items: [
                      BreadcrumbItem(label: 'Dashboard', onTap: () {}),
                      BreadcrumbItem(label: 'Users', onTap: () {}),
                      BreadcrumbItem(label: 'User Profile'),
                    ],
                    separator: const Icon(
                      DSIcons.arrowForward,
                      size: 12,
                      color: DSColors.textSecondary,
                    ),
                    textStyle: DSTypography.appTextTheme.bodyMedium?.copyWith(
                      color: DSColors.primaryApp,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),
                  Text(
                    'User Profile',
                    style: DSTypography.appTextTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'User profile information would appear here.',
                    style: DSTypography.appTextTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(title, style: DSTypography.appTextTheme.titleMedium),
    );
  }
}

/// Helper class for tab controller
class _TabSynchronizer extends TickerProvider {
  const _TabSynchronizer();

  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
}
