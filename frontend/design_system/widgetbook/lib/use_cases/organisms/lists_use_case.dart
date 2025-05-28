import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

/// Showcase for basic list items
class BasicListItemsShowcase extends StatelessWidget {
  const BasicListItemsShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Basic List Items',
              style: DSTypography.appTextTheme.titleLarge,
            ),
            const SizedBox(height: 24),

            // Standard List Item
            _buildSectionTitle('Standard List Item'),
            DSLists.appListItem(
              title: 'Standard List Item',
              subtitle: 'This is a subtitle',
              leading: const Icon(DSIcons.tablet),
              trailing: const Icon(DSIcons.arrowForward),
              onTap: () {},
              context: context,
            ),
            const SizedBox(height: 16),

            // Selected List Item
            _buildSectionTitle('Selected List Item'),
            DSLists.appListItem(
              title: 'Selected List Item',
              subtitle: 'This item is selected',
              leading: const Icon(DSIcons.check),
              trailing: const Icon(DSIcons.arrowForward),
              onTap: () {},
              selected: true,
              context: context,
            ),
            const SizedBox(height: 16),

            // List Item with Custom Background
            _buildSectionTitle('List Item with Custom Background'),
            DSLists.appListItem(
              title: 'Custom Background',
              subtitle: 'This item has a custom background color',
              leading: const Icon(DSIcons.star),
              trailing: const Icon(DSIcons.arrowForward),
              onTap: () {},
              backgroundColor: DSColors.secondaryApp.withValues(alpha: (0.1 * 255).toDouble()),
              context: context,
            ),
            const SizedBox(height: 16),

            // List Item with Border
            _buildSectionTitle('List Item with Border'),
            DSLists.appListItem(
              title: 'Bordered List Item',
              subtitle: 'This item has a border',
              leading: const Icon(DSIcons.tablet),
              trailing: const Icon(DSIcons.arrowForward),
              onTap: () {},
              border: Border.all(color: DSColors.divider),
              borderRadius: DSBorders.borderRadiusMD,
              context: context,
            ),
            const SizedBox(height: 16),

            // List Item with Custom Padding
            _buildSectionTitle('List Item with Custom Padding'),
            DSLists.appListItem(
              title: 'Custom Padding',
              subtitle: 'This item has custom padding',
              leading: const Icon(DSIcons.bookmark),
              trailing: const Icon(DSIcons.arrowForward),
              onTap: () {},
              contentPadding: const EdgeInsets.all(24),
              context: context,
            ),
            const SizedBox(height: 16),

            // Card List Item
            _buildSectionTitle('Card List Item'),
            DSLists.appCardListItem(
              title: 'Card List Item',
              subtitle: 'This is a card-style list item',
              leading: const Icon(DSIcons.bookmark),
              trailing: const Icon(DSIcons.arrowForward),
              onTap: () {},
              context: context,
            ),
            const SizedBox(height: 16),

            // Selected Card List Item
            _buildSectionTitle('Selected Card List Item'),
            DSLists.appCardListItem(
              title: 'Selected Card List Item',
              subtitle: 'This card item is selected',
              leading: const Icon(DSIcons.check),
              trailing: const Icon(DSIcons.arrowForward),
              onTap: () {},
              selected: true,
              context: context,
            ),
            const SizedBox(height: 16),

            // Card List Item with Custom Shadow
            _buildSectionTitle('Card List Item with Custom Shadow'),
            DSLists.appCardListItem(
              title: 'Custom Shadow',
              subtitle: 'This card has a custom shadow',
              leading: const Icon(DSIcons.bookmark),
              trailing: const Icon(DSIcons.arrowForward),
              onTap: () {},
              boxShadow: DSShadows.elevation3,
              context: context,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(title, style: DSTypography.appTextTheme.titleMedium),
    );
  }
}

/// Showcase for sectioned lists
class SectionedListsShowcase extends StatelessWidget {
  const SectionedListsShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Sectioned Lists',
              style: DSTypography.appTextTheme.titleLarge,
            ),
          ),

          Expanded(
            child: DSLists.appSectionedList(
              sections: [
                ListSection(
                  title: 'Today',
                  items: [
                    DSLists.appListItem(
                      title: 'Meeting with Client',
                      subtitle: '10:00 AM - 11:30 AM',
                      leading: const Icon(DSIcons.calendar),
                      onTap: () {},
                      context: context,
                    ),
                    DSLists.appListItem(
                      title: 'Project Review',
                      subtitle: '2:00 PM - 3:00 PM',
                      leading: const Icon(DSIcons.calendar),
                      onTap: () {},
                      context: context,
                    ),
                  ],
                ),
                ListSection(
                  title: 'Tomorrow',
                  items: [
                    DSLists.appListItem(
                      title: 'Team Standup',
                      subtitle: '9:30 AM - 10:00 AM',
                      leading: const Icon(DSIcons.calendar),
                      onTap: () {},
                      context: context,
                    ),
                    DSLists.appListItem(
                      title: 'Design Review',
                      subtitle: '1:00 PM - 2:00 PM',
                      leading: const Icon(DSIcons.calendar),
                      onTap: () {},
                      context: context,
                    ),
                    DSLists.appListItem(
                      title: 'Client Call',
                      subtitle: '4:00 PM - 4:30 PM',
                      leading: const Icon(DSIcons.calendar),
                      onTap: () {},
                      context: context,
                    ),
                  ],
                ),
                ListSection(
                  title: 'Next Week',
                  items: [
                    DSLists.appListItem(
                      title: 'Product Launch',
                      subtitle: 'Monday, 10:00 AM',
                      leading: const Icon(DSIcons.calendar),
                      onTap: () {},
                      context: context,
                    ),
                    DSLists.appListItem(
                      title: 'Quarterly Review',
                      subtitle: 'Wednesday, 2:00 PM',
                      leading: const Icon(DSIcons.calendar),
                      onTap: () {},
                      context: context,
                    ),
                  ],
                ),
              ],
              context: context,
            ),
          ),
        ],
      ),
    );
  }
}

/// Showcase for grid lists
class GridListsShowcase extends StatelessWidget {
  const GridListsShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    // Create a list of grid items
    final List<Widget> gridItems = List.generate(
      12,
      (index) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: DSBorders.borderRadiusMD,
          boxShadow: DSShadows.elevation1,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(DSIcons.bookmark, size: 32, color: DSColors.primaryApp),
            const SizedBox(height: 8),
            Text(
              'Item ${index + 1}',
              style: DSTypography.appTextTheme.titleSmall,
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Grid Lists',
              style: DSTypography.appTextTheme.titleLarge,
            ),
          ),

          Expanded(
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  TabBar(
                    tabs: const [
                      Tab(text: 'Fixed Grid'),
                      Tab(text: 'Responsive Grid'),
                    ],
                    labelColor: DSColors.primaryApp,
                    unselectedLabelColor: DSColors.textSecondary,
                    indicatorColor: DSColors.primaryApp,
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        // Fixed Grid
                        DSLists.appGridList(
                          items: gridItems,
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          padding: const EdgeInsets.all(16),
                        ),

                        // Responsive Grid
                        DSLists.appResponsiveGridList(
                          context: context,
                          items: gridItems,
                          breakpointCounts: {
                            'xs': 1,
                            'sm': 2,
                            'md': 3,
                            'lg': 4,
                          },
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          padding: const EdgeInsets.all(16),
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
}

/// Showcase for horizontal lists
class HorizontalListsShowcase extends StatelessWidget {
  const HorizontalListsShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    // Create a list of horizontal items
    final List<Widget> horizontalItems = List.generate(
      10,
      (index) => Container(
        width: 160,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: DSBorders.borderRadiusMD,
          boxShadow: DSShadows.elevation1,
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(DSIcons.bookmark, size: 32, color: DSColors.primaryApp),
            const SizedBox(height: 8),
            Text(
              'Item ${index + 1}',
              style: DSTypography.appTextTheme.titleSmall,
            ),
            const SizedBox(height: 4),
            Text(
              'Description',
              style: DSTypography.appTextTheme.bodySmall?.copyWith(
                color: DSColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );

    // Create a list of card items
    final List<Widget> cardItems = List.generate(
      10,
      (index) => DSLists.appCardListItem(
        title: 'Card ${index + 1}',
        subtitle: 'Card description',
        leading: const Icon(DSIcons.bookmark),
        margin: const EdgeInsets.all(0),
        context: context,
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Horizontal Lists',
              style: DSTypography.appTextTheme.titleLarge,
            ),
            const SizedBox(height: 24),

            // Standard Horizontal List
            _buildSectionTitle('Standard Horizontal List'),
            SizedBox(
              height: 150,
              child: DSLists.appHorizontalList(
                items: horizontalItems,
                spacing: 16,
              ),
            ),
            const SizedBox(height: 32),

            // Horizontal List with Fixed Item Width
            _buildSectionTitle('Horizontal List with Fixed Item Width'),
            SizedBox(
              height: 200,
              child: DSLists.appHorizontalList(
                items: horizontalItems,
                spacing: 16,
                itemWidth: 200,
              ),
            ),
            const SizedBox(height: 32),

            // Horizontal List with Card Items
            _buildSectionTitle('Horizontal List with Card Items'),
            SizedBox(
              height: 100,
              child: DSLists.appHorizontalList(
                items: cardItems,
                spacing: 16,
                itemWidth: 300,
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

/// Showcase for special list types
class SpecialListsShowcase extends StatefulWidget {
  const SpecialListsShowcase({super.key});

  @override
  State<SpecialListsShowcase> createState() => _SpecialListsShowcaseState();
}

class _SpecialListsShowcaseState extends State<SpecialListsShowcase> {
  List<String> _items = List.generate(15, (index) => 'Item ${index + 1}');
  bool _isLoading = false;
  bool _hasMoreItems = true;
  int _currentPage = 1;
  final int _itemsPerPage = 5;

  Future<void> _onRefresh() async {
    // Simulate network request
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _items = List.generate(15, (index) => 'Refreshed Item ${index + 1}');
      _isLoading = false;
      _currentPage = 1;
      _hasMoreItems = true;
    });
  }

  Future<void> _onLoadMore() async {
    if (_isLoading) return;

    // Simulate network request
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      if (_currentPage < 3) {
        _items.addAll(
          List.generate(
            _itemsPerPage,
            (index) => 'Page ${_currentPage + 1} - Item ${index + 1}',
          ),
        );
        _currentPage++;
      } else {
        _hasMoreItems = false;
      }
      _isLoading = false;
    });
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      final item = _items.removeAt(oldIndex);
      _items.insert(newIndex, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Special Lists',
              style: DSTypography.appTextTheme.titleLarge,
            ),
          ),

          Expanded(
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  TabBar(
                    tabs: const [
                      Tab(text: 'Refreshable'),
                      Tab(text: 'Infinite'),
                      Tab(text: 'Reorderable'),
                    ],
                    labelColor: DSColors.primaryApp,
                    unselectedLabelColor: DSColors.textSecondary,
                    indicatorColor: DSColors.primaryApp,
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        // Refreshable List
                        DSLists.appRefreshableList(
                          context: context,
                          items:
                              _items
                                  .map(
                                    (item) => DSLists.appListItem(
                                      title: item,
                                      subtitle: 'Pull to refresh',
                                      leading: const Icon(DSIcons.bookmark),
                                      onTap: () {},
                                      context: context,
                                    ),
                                  )
                                  .toList(),
                          onRefresh: _onRefresh,
                          isLoading: _isLoading,
                          emptyWidget: const Center(
                            child: Text('No items available'),
                          ),
                          loadingWidget: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),

                        // Infinite List
                        DSLists.appInfiniteList(
                          context: context,
                          items:
                              _items
                                  .map(
                                    (item) => DSLists.appListItem(
                                      title: item,
                                      subtitle: 'Scroll to load more',
                                      leading: const Icon(DSIcons.bookmark),
                                      onTap: () {},
                                      context: context,
                                    ),
                                  )
                                  .toList(),
                          onLoadMore: _onLoadMore,
                          hasMoreItems: _hasMoreItems,
                          isLoading: _isLoading,
                          emptyWidget: const Center(
                            child: Text('No items available'),
                          ),
                          loadingWidget: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),

                        // Reorderable List
                        DSLists.appReorderableList(
                          context: context,
                          items:
                              _items
                                  .map(
                                    (item) => DSLists.appListItem(
                                      title: item,
                                      subtitle: 'Drag to reorder',
                                      leading: const Icon(DSIcons.arrowBack),
                                      trailing: const Icon(DSIcons.arrowUp),
                                      onTap: () {},
                                      context: context,
                                    ),
                                  )
                                  .toList(),
                          onReorder: _onReorder,
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
}

/// Showcase for expandable list items
class ExpandableListsShowcase extends StatelessWidget {
  const ExpandableListsShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Expandable Lists',
              style: DSTypography.appTextTheme.titleLarge,
            ),
            const SizedBox(height: 24),

            // Standard Expandable List Item
            DSLists.appExpandableListItem(
              title: 'Basic Expandable Item',
              subtitle: 'Tap to expand',
              leading: const Icon(DSIcons.dashboard),
              content: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'This is the expanded content of the list item. It can contain any widget.',
                  style: DSTypography.appTextTheme.bodyMedium,
                ),
              ),
              context: context,
            ),
            const SizedBox(height: 16),

            // Initially Expanded List Item
            DSLists.appExpandableListItem(
              title: 'Initially Expanded Item',
              subtitle: 'This item starts expanded',
              leading: const Icon(DSIcons.dashboard),
              initiallyExpanded: true,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'This item is initially expanded when the page loads.',
                    style: DSTypography.appTextTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  DSButtons.primaryAppButton(
                    text: 'Action Button',
                    onPressed: () {},
                  ),
                ],
              ),
              context: context,
            ),
            const SizedBox(height: 16),

            // Expandable Item with Custom Background
            DSLists.appExpandableListItem(
              title: 'Custom Background',
              subtitle: 'With custom background color',
              leading: const Icon(DSIcons.dashboard),
              backgroundColor: DSColors.secondaryApp.withValues(alpha: (0.1 * 255).toDouble()),
              content: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'This expandable item has a custom background color.',
                  style: DSTypography.appTextTheme.bodyMedium,
                ),
              ),
              context: context,
            ),
            const SizedBox(height: 16),

            // Expandable Item with Complex Content
            DSLists.appExpandableListItem(
              title: 'Complex Content',
              subtitle: 'With nested list items',
              leading: const Icon(DSIcons.dashboard),
              content: Column(
                children: [
                  DSLists.appListItem(
                    title: 'Nested Item 1',
                    leading: const Icon(DSIcons.bookmark),
                    onTap: () {},
                    context: context,
                  ),
                  const Divider(),
                  DSLists.appListItem(
                    title: 'Nested Item 2',
                    leading: const Icon(DSIcons.bookmark),
                    onTap: () {},
                    context: context,
                  ),
                  const Divider(),
                  DSLists.appListItem(
                    title: 'Nested Item 3',
                    leading: const Icon(DSIcons.bookmark),
                    onTap: () {},
                    context: context,
                  ),
                ],
              ),
              context: context,
            ),
            const SizedBox(height: 16),

            // Expandable Item with Custom Border Radius
            DSLists.appExpandableListItem(
              title: 'Custom Border Radius',
              subtitle: 'With rounded corners',
              leading: const Icon(DSIcons.dashboard),
              borderRadius: DSBorders.borderRadiusXL,
              backgroundColor: Colors.white,
              content: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'This expandable item has custom border radius.',
                  style: DSTypography.appTextTheme.bodyMedium,
                ),
              ),
              context: context,
            ),
          ],
        ),
      ),
    );
  }
}
