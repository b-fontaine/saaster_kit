import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

class SpacingValuesShowcase extends StatelessWidget {
  const SpacingValuesShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Spacing Values',
            style: DSTypography.appTextTheme.titleLarge,
          ),
          const SizedBox(height: 24),
          SpacingItem(name: 'XXXS (2px)', value: DSSpacing.xxxs),
          SpacingItem(name: 'XXS (4px)', value: DSSpacing.xxs),
          SpacingItem(name: 'XS (8px)', value: DSSpacing.xs),
          SpacingItem(name: 'SM (12px)', value: DSSpacing.sm),
          SpacingItem(name: 'MD (16px)', value: DSSpacing.md),
          SpacingItem(name: 'LG (24px)', value: DSSpacing.lg),
          SpacingItem(name: 'XL (32px)', value: DSSpacing.xl),
          SpacingItem(name: 'XXL (48px)', value: DSSpacing.xxl),
          SpacingItem(name: 'XXXL (64px)', value: DSSpacing.xxxl),
          const SizedBox(height: 32),
          Text(
            'Responsive Spacing',
            style: DSTypography.appTextTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Current Breakpoint: ${DSBreakpoints.getBreakpoint(context)}',
                  style: DSTypography.appTextTheme.titleMedium,
                ),
                const SizedBox(height: 16),
                Text(
                  'Page Padding:',
                  style: DSTypography.appTextTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: DSSpacing.getPagePadding(context),
                  decoration: BoxDecoration(
                    color: DSColors.primaryApp.withValues(alpha: (0.1 * 255).toDouble()),
                    border: Border.all(
                      color: DSColors.primaryApp,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const SizedBox(height: 100),
                ),
                const SizedBox(height: 16),
                Text(
                  'Content Padding:',
                  style: DSTypography.appTextTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: DSSpacing.getContentPadding(context),
                  decoration: BoxDecoration(
                    color: DSColors.secondaryApp.withValues(alpha: (0.1 * 255).toDouble()),
                    border: Border.all(
                      color: DSColors.secondaryApp,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const SizedBox(height: 100),
                ),
                const SizedBox(height: 16),
                Text(
                  'Section Padding:',
                  style: DSTypography.appTextTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: DSSpacing.getSectionPadding(context),
                  decoration: BoxDecoration(
                    color: DSColors.accentApp.withValues(alpha: (0.1 * 255).toDouble()),
                    border: Border.all(
                      color: DSColors.accentApp,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const SizedBox(height: 100),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpacingItem(String name, double value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
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
              height: 24,
              width: value,
              color: DSColors.primaryApp,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 8),
              child: Text(
                '${value.toInt()}px',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
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

class SpacingWidgetsShowcase extends StatelessWidget {
  const SpacingWidgetsShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Horizontal Spacers',
            style: DSTypography.appTextTheme.titleLarge,
          ),
          const SizedBox(height: 24),
          HorizontalSpacerItem(name: 'horizontalSpacerXXXS', spacer: DSSpacing.horizontalSpacerXXXS),
          HorizontalSpacerItem(name: 'horizontalSpacerXXS', spacer: DSSpacing.horizontalSpacerXXS),
          HorizontalSpacerItem(name: 'horizontalSpacerXS', spacer: DSSpacing.horizontalSpacerXS),
          HorizontalSpacerItem(name: 'horizontalSpacerSM', spacer: DSSpacing.horizontalSpacerSM),
          HorizontalSpacerItem(name: 'horizontalSpacerMD', spacer: DSSpacing.horizontalSpacerMD),
          HorizontalSpacerItem(name: 'horizontalSpacerLG', spacer: DSSpacing.horizontalSpacerLG),
          HorizontalSpacerItem(name: 'horizontalSpacerXL', spacer: DSSpacing.horizontalSpacerXL),
          HorizontalSpacerItem(name: 'horizontalSpacerXXL', spacer: DSSpacing.horizontalSpacerXXL),
          HorizontalSpacerItem(name: 'horizontalSpacerXXXL', spacer: DSSpacing.horizontalSpacerXXXL),
          const SizedBox(height: 32),
          Text(
            'Vertical Spacers',
            style: DSTypography.appTextTheme.titleLarge,
          ),
          const SizedBox(height: 24),
          VerticalSpacerItem(name: 'verticalSpacerXXXS', spacer: DSSpacing.verticalSpacerXXXS),
          VerticalSpacerItem(name: 'verticalSpacerXXS', spacer: DSSpacing.verticalSpacerXXS),
          VerticalSpacerItem(name: 'verticalSpacerXS', spacer: DSSpacing.verticalSpacerXS),
          VerticalSpacerItem(name: 'verticalSpacerSM', spacer: DSSpacing.verticalSpacerSM),
          VerticalSpacerItem(name: 'verticalSpacerMD', spacer: DSSpacing.verticalSpacerMD),
          VerticalSpacerItem(name: 'verticalSpacerLG', spacer: DSSpacing.verticalSpacerLG),
          VerticalSpacerItem(name: 'verticalSpacerXL', spacer: DSSpacing.verticalSpacerXL),
          VerticalSpacerItem(name: 'verticalSpacerXXL', spacer: DSSpacing.verticalSpacerXXL),
          VerticalSpacerItem(name: 'verticalSpacerXXXL', spacer: DSSpacing.verticalSpacerXXXL),
          const SizedBox(height: 32),
          Text(
            'Padding Presets',
            style: DSTypography.appTextTheme.titleLarge,
          ),
          const SizedBox(height: 24),
          PaddingItem(name: 'paddingXXXS', padding: DSSpacing.paddingXXXS),
          PaddingItem(name: 'paddingXXS', padding: DSSpacing.paddingXXS),
          PaddingItem(name: 'paddingXS', padding: DSSpacing.paddingXS),
          PaddingItem(name: 'paddingSM', padding: DSSpacing.paddingSM),
          PaddingItem(name: 'paddingMD', padding: DSSpacing.paddingMD),
          PaddingItem(name: 'paddingLG', padding: DSSpacing.paddingLG),
          PaddingItem(name: 'paddingXL', padding: DSSpacing.paddingXL),
          PaddingItem(name: 'paddingXXL', padding: DSSpacing.paddingXXL),
          PaddingItem(name: 'paddingXXXL', padding: DSSpacing.paddingXXXL),
          const SizedBox(height: 16),
          PaddingItem(name: 'paddingHMD', padding: DSSpacing.paddingHMD),
          PaddingItem(name: 'paddingVMD', padding: DSSpacing.paddingVMD),
        ],
      ),
    );
  }

  Widget _buildHorizontalSpacerItem(String name, Widget spacer) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
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
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 24,
                  color: DSColors.primaryApp,
                ),
                spacer,
                Container(
                  width: 50,
                  height: 24,
                  color: DSColors.primaryApp,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalSpacerItem(String name, Widget spacer) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 150,
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
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 24,
                    color: DSColors.primaryApp,
                  ),
                  spacer,
                  Container(
                    width: double.infinity,
                    height: 24,
                    color: DSColors.primaryApp,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaddingItem(String name, EdgeInsets padding) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
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
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Container(
              padding: padding,
              decoration: BoxDecoration(
                color: DSColors.primaryApp.withValues(alpha: (0.1 * 255).toDouble()),
                border: Border.all(
                  color: DSColors.primaryApp,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const SizedBox(
                width: double.infinity,
                height: 50,
                child: Center(
                  child: Text(
                    'Content',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Top: ${padding.top}, Right: ${padding.right}, Bottom: ${padding.bottom}, Left: ${padding.left}',
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class SpacingItem extends StatelessWidget {
  final String name;
  final double value;

  const SpacingItem({
    super.key,
    required this.name,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
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
              height: 24,
              width: value,
              color: DSColors.primaryApp,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 8),
              child: Text(
                '${value.toInt()}px',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
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

class HorizontalSpacerItem extends StatelessWidget {
  final String name;
  final Widget spacer;

  const HorizontalSpacerItem({
    super.key,
    required this.name,
    required this.spacer,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
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
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 24,
                  color: DSColors.primaryApp,
                ),
                spacer,
                Container(
                  width: 50,
                  height: 24,
                  color: DSColors.primaryApp,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class VerticalSpacerItem extends StatelessWidget {
  final String name;
  final Widget spacer;

  const VerticalSpacerItem({
    super.key,
    required this.name,
    required this.spacer,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 150,
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
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 24,
                    color: DSColors.primaryApp,
                  ),
                  spacer,
                  Container(
                    width: double.infinity,
                    height: 24,
                    color: DSColors.primaryApp,
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

class PaddingItem extends StatelessWidget {
  final String name;
  final EdgeInsets padding;

  const PaddingItem({
    super.key,
    required this.name,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
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
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Container(
              padding: padding,
              decoration: BoxDecoration(
                color: DSColors.primaryApp.withValues(alpha: (0.1 * 255).toDouble()),
                border: Border.all(
                  color: DSColors.primaryApp,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const SizedBox(
                width: double.infinity,
                height: 50,
                child: Center(
                  child: Text(
                    'Content',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Top: ${padding.top}, Right: ${padding.right}, Bottom: ${padding.bottom}, Left: ${padding.left}',
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
