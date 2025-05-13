import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

class ElevationShadowsShowcase extends StatelessWidget {
  const ElevationShadowsShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Elevation Shadows',
            style: DSTypography.appTextTheme.titleLarge,
          ),
          const SizedBox(height: 24),
          _buildShadowItem('Elevation 0', DSShadows.elevation0),
          _buildShadowItem('Elevation 1', DSShadows.elevation1),
          _buildShadowItem('Elevation 2', DSShadows.elevation2),
          _buildShadowItem('Elevation 3', DSShadows.elevation3),
          _buildShadowItem('Elevation 4', DSShadows.elevation4),
          _buildShadowItem('Elevation 6', DSShadows.elevation6),
          _buildShadowItem('Elevation 8', DSShadows.elevation8),
          _buildShadowItem('Elevation 12', DSShadows.elevation12),
          _buildShadowItem('Elevation 16', DSShadows.elevation16),
          _buildShadowItem('Elevation 24', DSShadows.elevation24),
        ],
      ),
    );
  }

  Widget _buildShadowItem(String name, List<BoxShadow> shadows) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: shadows,
              ),
              child: Center(
                child: Text(
                  shadows.isEmpty ? 'No Shadow' : 'Shadow',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ComponentShadowsShowcase extends StatelessWidget {
  const ComponentShadowsShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'App Theme Component Shadows',
            style: DSTypography.appTextTheme.titleLarge,
          ),
          const SizedBox(height: 24),
          _buildComponentShadowItem('Card Shadow', DSShadows.appCardShadow),
          _buildComponentShadowItem('Button Shadow', DSShadows.appButtonShadow),
          _buildComponentShadowItem('Dialog Shadow', DSShadows.appDialogShadow),
          _buildComponentShadowItem('Nav Bar Shadow', DSShadows.appNavBarShadow),
          _buildComponentShadowItem('FAB Shadow', DSShadows.appFloatingActionButtonShadow),
          const SizedBox(height: 32),
          Text(
            'Landing Theme Component Shadows',
            style: DSTypography.appTextTheme.titleLarge,
          ),
          const SizedBox(height: 24),
          _buildComponentShadowItem('Card Shadow', DSShadows.landingCardShadow),
          _buildComponentShadowItem('Button Shadow', DSShadows.landingButtonShadow),
          _buildComponentShadowItem('Dialog Shadow', DSShadows.landingDialogShadow),
          _buildComponentShadowItem('Nav Bar Shadow', DSShadows.landingNavBarShadow),
          _buildComponentShadowItem('Hero Shadow', DSShadows.landingHeroShadow),
          const SizedBox(height: 32),
          Text(
            'Special Effects',
            style: DSTypography.appTextTheme.titleLarge,
          ),
          const SizedBox(height: 24),
          _buildComponentShadowItem('Hover Effect', DSShadows.hoverEffect),
          _buildComponentShadowItem('Focus Effect', DSShadows.focusEffect),
          _buildComponentShadowItem('Landing Hover Effect', DSShadows.landingHoverEffect),
        ],
      ),
    );
  }

  Widget _buildComponentShadowItem(String name, List<BoxShadow> shadows) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: shadows,
            ),
            child: Center(
              child: Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _getShadowDescription(shadows),
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  String _getShadowDescription(List<BoxShadow> shadows) {
    if (shadows.isEmpty) {
      return 'No shadow';
    }
    
    final shadow = shadows.first;
    return 'Color: ${shadow.color}, Blur: ${shadow.blurRadius}, Offset: (${shadow.offset.dx}, ${shadow.offset.dy})';
  }
}
