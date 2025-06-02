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
          ShadowItem(name: 'Elevation 0', shadows: DSShadows.elevation0),
          ShadowItem(name: 'Elevation 1', shadows: DSShadows.elevation1),
          ShadowItem(name: 'Elevation 2', shadows: DSShadows.elevation2),
          ShadowItem(name: 'Elevation 3', shadows: DSShadows.elevation3),
          ShadowItem(name: 'Elevation 4', shadows: DSShadows.elevation4),
          ShadowItem(name: 'Elevation 6', shadows: DSShadows.elevation6),
          ShadowItem(name: 'Elevation 8', shadows: DSShadows.elevation8),
          ShadowItem(name: 'Elevation 12', shadows: DSShadows.elevation12),
          ShadowItem(name: 'Elevation 16', shadows: DSShadows.elevation16),
          ShadowItem(name: 'Elevation 24', shadows: DSShadows.elevation24),
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

class ShadowItem extends StatelessWidget {
  final String name;
  final List<BoxShadow> shadows;

  const ShadowItem({
    super.key,
    required this.name,
    required this.shadows,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
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
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: shadows,
              ),
              child: const Center(
                child: Text(
                  'Shadow Preview',
                  style: TextStyle(
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

class ComponentShadowItem extends StatelessWidget {
  final String name;
  final List<BoxShadow> shadows;

  const ComponentShadowItem({
    super.key,
    required this.name,
    required this.shadows,
  });

  @override
  Widget build(BuildContext context) {
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
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: shadows,
            ),
            child: const Center(
              child: Text(
                'Component Shadow Preview',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
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
          ComponentShadowItem(name: 'Card Shadow', shadows: DSShadows.appCardShadow),
          ComponentShadowItem(name: 'Button Shadow', shadows: DSShadows.appButtonShadow),
          ComponentShadowItem(name: 'Dialog Shadow', shadows: DSShadows.appDialogShadow),
          ComponentShadowItem(name: 'Nav Bar Shadow', shadows: DSShadows.appNavBarShadow),
          ComponentShadowItem(name: 'FAB Shadow', shadows: DSShadows.appFloatingActionButtonShadow),
          const SizedBox(height: 32),
          Text(
            'Landing Theme Component Shadows',
            style: DSTypography.appTextTheme.titleLarge,
          ),
          const SizedBox(height: 24),
          ComponentShadowItem(name: 'Card Shadow', shadows: DSShadows.landingCardShadow),
          ComponentShadowItem(name: 'Button Shadow', shadows: DSShadows.landingButtonShadow),
          ComponentShadowItem(name: 'Dialog Shadow', shadows: DSShadows.landingDialogShadow),
          ComponentShadowItem(name: 'Nav Bar Shadow', shadows: DSShadows.landingNavBarShadow),
          ComponentShadowItem(name: 'Hero Shadow', shadows: DSShadows.landingHeroShadow),
          const SizedBox(height: 32),
          Text(
            'Special Effects',
            style: DSTypography.appTextTheme.titleLarge,
          ),
          const SizedBox(height: 24),
          ComponentShadowItem(name: 'Hover Effect', shadows: DSShadows.hoverEffect),
          ComponentShadowItem(name: 'Focus Effect', shadows: DSShadows.focusEffect),
          ComponentShadowItem(name: 'Landing Hover Effect', shadows: DSShadows.landingHoverEffect),
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
