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
          _buildSpacingItem('XXXS (2px)', DSSpacing.xxxs),
          _buildSpacingItem('XXS (4px)', DSSpacing.xxs),
          _buildSpacingItem('XS (8px)', DSSpacing.xs),
          _buildSpacingItem('SM (12px)', DSSpacing.sm),
          _buildSpacingItem('MD (16px)', DSSpacing.md),
          _buildSpacingItem('LG (24px)', DSSpacing.lg),
          _buildSpacingItem('XL (32px)', DSSpacing.xl),
          _buildSpacingItem('XXL (48px)', DSSpacing.xxl),
          _buildSpacingItem('XXXL (64px)', DSSpacing.xxxl),
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
                    color: DSColors.primaryApp.withOpacity(0.1),
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
                    color: DSColors.secondaryApp.withOpacity(0.1),
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
                    color: DSColors.accentApp.withOpacity(0.1),
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
          _buildHorizontalSpacerItem('horizontalSpacerXXXS', DSSpacing.horizontalSpacerXXXS),
          _buildHorizontalSpacerItem('horizontalSpacerXXS', DSSpacing.horizontalSpacerXXS),
          _buildHorizontalSpacerItem('horizontalSpacerXS', DSSpacing.horizontalSpacerXS),
          _buildHorizontalSpacerItem('horizontalSpacerSM', DSSpacing.horizontalSpacerSM),
          _buildHorizontalSpacerItem('horizontalSpacerMD', DSSpacing.horizontalSpacerMD),
          _buildHorizontalSpacerItem('horizontalSpacerLG', DSSpacing.horizontalSpacerLG),
          _buildHorizontalSpacerItem('horizontalSpacerXL', DSSpacing.horizontalSpacerXL),
          _buildHorizontalSpacerItem('horizontalSpacerXXL', DSSpacing.horizontalSpacerXXL),
          _buildHorizontalSpacerItem('horizontalSpacerXXXL', DSSpacing.horizontalSpacerXXXL),
          const SizedBox(height: 32),
          Text(
            'Vertical Spacers',
            style: DSTypography.appTextTheme.titleLarge,
          ),
          const SizedBox(height: 24),
          _buildVerticalSpacerItem('verticalSpacerXXXS', DSSpacing.verticalSpacerXXXS),
          _buildVerticalSpacerItem('verticalSpacerXXS', DSSpacing.verticalSpacerXXS),
          _buildVerticalSpacerItem('verticalSpacerXS', DSSpacing.verticalSpacerXS),
          _buildVerticalSpacerItem('verticalSpacerSM', DSSpacing.verticalSpacerSM),
          _buildVerticalSpacerItem('verticalSpacerMD', DSSpacing.verticalSpacerMD),
          _buildVerticalSpacerItem('verticalSpacerLG', DSSpacing.verticalSpacerLG),
          _buildVerticalSpacerItem('verticalSpacerXL', DSSpacing.verticalSpacerXL),
          _buildVerticalSpacerItem('verticalSpacerXXL', DSSpacing.verticalSpacerXXL),
          _buildVerticalSpacerItem('verticalSpacerXXXL', DSSpacing.verticalSpacerXXXL),
          const SizedBox(height: 32),
          Text(
            'Padding Presets',
            style: DSTypography.appTextTheme.titleLarge,
          ),
          const SizedBox(height: 24),
          _buildPaddingItem('paddingXXXS', DSSpacing.paddingXXXS),
          _buildPaddingItem('paddingXXS', DSSpacing.paddingXXS),
          _buildPaddingItem('paddingXS', DSSpacing.paddingXS),
          _buildPaddingItem('paddingSM', DSSpacing.paddingSM),
          _buildPaddingItem('paddingMD', DSSpacing.paddingMD),
          _buildPaddingItem('paddingLG', DSSpacing.paddingLG),
          _buildPaddingItem('paddingXL', DSSpacing.paddingXL),
          _buildPaddingItem('paddingXXL', DSSpacing.paddingXXL),
          _buildPaddingItem('paddingXXXL', DSSpacing.paddingXXXL),
          const SizedBox(height: 16),
          _buildPaddingItem('paddingHMD', DSSpacing.paddingHMD),
          _buildPaddingItem('paddingVMD', DSSpacing.paddingVMD),
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
                color: DSColors.primaryApp.withOpacity(0.1),
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
