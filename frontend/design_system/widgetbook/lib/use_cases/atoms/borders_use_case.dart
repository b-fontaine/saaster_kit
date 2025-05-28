import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

class BorderRadiusShowcase extends StatelessWidget {
  const BorderRadiusShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Border Radius',
            style: DSTypography.appTextTheme.titleLarge,
          ),
          const SizedBox(height: 24),
          _buildBorderRadiusItem('XS (2px)', DSBorders.borderRadiusXS),
          _buildBorderRadiusItem('SM (4px)', DSBorders.borderRadiusSM),
          _buildBorderRadiusItem('MD (8px)', DSBorders.borderRadiusMD),
          _buildBorderRadiusItem('LG (12px)', DSBorders.borderRadiusLG),
          _buildBorderRadiusItem('XL (16px)', DSBorders.borderRadiusXL),
          _buildBorderRadiusItem('XXL (24px)', DSBorders.borderRadiusXXL),
          _buildBorderRadiusItem('Circular', DSBorders.borderRadiusCircular),
        ],
      ),
    );
  }

  Widget _buildBorderRadiusItem(String name, BorderRadius borderRadius) {
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
          const SizedBox(width: 24),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: DSColors.primaryApp.withValues(alpha: (0.2 * 255).toDouble()),
              border: Border.all(
                color: DSColors.primaryApp,
                width: 2,
              ),
              borderRadius: borderRadius,
            ),
          ),
        ],
      ),
    );
  }
}

class BorderStylesShowcase extends StatelessWidget {
  const BorderStylesShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Border Width',
            style: DSTypography.appTextTheme.titleLarge,
          ),
          const SizedBox(height: 24),
          _buildBorderWidthItem('Thin (0.5px)', DSBorders.borderWidthThin),
          _buildBorderWidthItem('Regular (1px)', DSBorders.borderWidthRegular),
          _buildBorderWidthItem('Thick (2px)', DSBorders.borderWidthThick),
          _buildBorderWidthItem('Heavy (4px)', DSBorders.borderWidthHeavy),
          const SizedBox(height: 32),
          Text(
            'App Theme Borders',
            style: DSTypography.appTextTheme.titleLarge,
          ),
          const SizedBox(height: 24),
          _buildBorderItem('Border App', DSBorders.borderApp),
          _buildBorderItem('Border App Thick', DSBorders.borderAppThick),
          _buildBorderItem('Border App Primary', DSBorders.borderAppPrimary),
          _buildBorderItem('Border App Secondary', DSBorders.borderAppSecondary),
          _buildBorderItem('Border App Error', DSBorders.borderAppError),
          const SizedBox(height: 32),
          Text(
            'Landing Theme Borders',
            style: DSTypography.appTextTheme.titleLarge,
          ),
          const SizedBox(height: 24),
          _buildBorderItem('Border Landing', DSBorders.borderLanding),
          _buildBorderItem('Border Landing Thick', DSBorders.borderLandingThick),
          _buildBorderItem('Border Landing Primary', DSBorders.borderLandingPrimary),
          _buildBorderItem('Border Landing Secondary', DSBorders.borderLandingSecondary),
          _buildBorderItem('Border Landing Error', DSBorders.borderLandingError),
          const SizedBox(height: 32),
          Text(
            'Input Borders',
            style: DSTypography.appTextTheme.titleLarge,
          ),
          const SizedBox(height: 24),
          _buildInputBorderItem('Input Border App', DSBorders.inputBorderApp),
          _buildInputBorderItem('Input Border App Focused', DSBorders.inputBorderAppFocused),
          _buildInputBorderItem('Input Border Landing', DSBorders.inputBorderLanding),
          _buildInputBorderItem('Input Border Landing Focused', DSBorders.inputBorderLandingFocused),
          const SizedBox(height: 32),
          Text(
            'Dividers',
            style: DSTypography.appTextTheme.titleLarge,
          ),
          const SizedBox(height: 24),
          _buildDividerItem('Divider Thin', DSBorders.dividerThin),
          _buildDividerItem('Divider Regular', DSBorders.dividerRegular),
          _buildDividerItem('Divider Thick', DSBorders.dividerThick),
        ],
      ),
    );
  }

  Widget _buildBorderWidthItem(String name, double width) {
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
          const SizedBox(width: 24),
          Expanded(
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(
                  color: DSColors.primaryApp,
                  width: width,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBorderItem(String name, Border border) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 160,
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
              height: 50,
              decoration: BoxDecoration(
                border: border,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputBorderItem(String name, OutlineInputBorder border) {
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
          TextField(
            decoration: InputDecoration(
              labelText: 'Input Field',
              border: border,
              enabledBorder: border,
              focusedBorder: border,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDividerItem(String name, Divider divider) {
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
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: divider,
          ),
          Text(
            'Thickness: ${divider.thickness}, Color: ${divider.color}',
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
