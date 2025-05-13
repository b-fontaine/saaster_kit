import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class AppChipsShowcase extends StatelessWidget {
  const AppChipsShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('App Chips', style: DSTypography.appTextTheme.titleLarge),
          const SizedBox(height: 24),

          // Standard Chip
          _buildChipSection(
            'Standard Chip',
            DSChips.appChip(label: 'Standard Chip'),
          ),

          // Action Chip
          _buildChipSection(
            'Action Chip',
            DSChips.appActionChip(label: 'Action Chip', onPressed: () {}),
          ),

          // Chip with Icon
          _buildChipSection(
            'Chip with Icon',
            DSChips.appChip(label: 'Chip with Icon', leadingIcon: DSIcons.star),
          ),

          // Chip with Delete Button
          _buildChipSection(
            'Chip with Delete Button',
            DSChips.appChip(label: 'Deletable Chip', onDeleted: () {}),
          ),
        ],
      ),
    );
  }

  Widget _buildChipSection(String title, Widget chipContent) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: DSTypography.appTextTheme.titleMedium),
          const SizedBox(height: 16),
          chipContent,
        ],
      ),
    );
  }
}

class LandingChipsShowcase extends StatelessWidget {
  const LandingChipsShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Landing Chips',
            style: DSTypography.landingTextTheme.titleLarge,
          ),
          const SizedBox(height: 24),

          // Standard Chip
          _buildChipSection(
            'Standard Chip',
            DSChips.landingTagChip(label: 'Standard Chip'),
          ),
        ],
      ),
    );
  }

  Widget _buildChipSection(String title, Widget chipContent) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: DSTypography.landingTextTheme.titleMedium),
          const SizedBox(height: 16),
          chipContent,
        ],
      ),
    );
  }
}
