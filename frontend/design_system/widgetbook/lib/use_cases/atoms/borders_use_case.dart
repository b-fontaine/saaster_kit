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
          BorderRadiusItem(name: 'XS (2px)', borderRadius: DSBorders.borderRadiusXS),
          BorderRadiusItem(name: 'SM (4px)', borderRadius: DSBorders.borderRadiusSM),
          BorderRadiusItem(name: 'MD (8px)', borderRadius: DSBorders.borderRadiusMD),
          BorderRadiusItem(name: 'LG (12px)', borderRadius: DSBorders.borderRadiusLG),
          BorderRadiusItem(name: 'XL (16px)', borderRadius: DSBorders.borderRadiusXL),
          BorderRadiusItem(name: 'XXL (24px)', borderRadius: DSBorders.borderRadiusXXL),
          BorderRadiusItem(name: 'Circular', borderRadius: DSBorders.borderRadiusCircular),
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
          BorderWidthItem(name: 'Thin (0.5px)', width: DSBorders.borderWidthThin),
          BorderWidthItem(name: 'Regular (1px)', width: DSBorders.borderWidthRegular),
          BorderWidthItem(name: 'Thick (2px)', width: DSBorders.borderWidthThick),
          BorderWidthItem(name: 'Heavy (4px)', width: DSBorders.borderWidthHeavy),
          const SizedBox(height: 32),
          Text(
            'App Theme Borders',
            style: DSTypography.appTextTheme.titleLarge,
          ),
          const SizedBox(height: 24),
          BorderItem(name: 'Border App', border: DSBorders.borderApp),
          BorderItem(name: 'Border App Thick', border: DSBorders.borderAppThick),
          BorderItem(name: 'Border App Primary', border: DSBorders.borderAppPrimary),
          BorderItem(name: 'Border App Secondary', border: DSBorders.borderAppSecondary),
          BorderItem(name: 'Border App Error', border: DSBorders.borderAppError),
          const SizedBox(height: 32),
          Text(
            'Landing Theme Borders',
            style: DSTypography.appTextTheme.titleLarge,
          ),
          const SizedBox(height: 24),
          BorderItem(name: 'Border Landing', border: DSBorders.borderLanding),
          BorderItem(name: 'Border Landing Thick', border: DSBorders.borderLandingThick),
          BorderItem(name: 'Border Landing Primary', border: DSBorders.borderLandingPrimary),
          BorderItem(name: 'Border Landing Secondary', border: DSBorders.borderLandingSecondary),
          BorderItem(name: 'Border Landing Error', border: DSBorders.borderLandingError),
          const SizedBox(height: 32),
          Text(
            'Input Borders',
            style: DSTypography.appTextTheme.titleLarge,
          ),
          const SizedBox(height: 24),
          InputBorderItem(name: 'Input Border App', border: DSBorders.inputBorderApp),
          InputBorderItem(name: 'Input Border App Focused', border: DSBorders.inputBorderAppFocused),
          InputBorderItem(name: 'Input Border Landing', border: DSBorders.inputBorderLanding),
          InputBorderItem(name: 'Input Border Landing Focused', border: DSBorders.inputBorderLandingFocused),
          const SizedBox(height: 32),
          Text(
            'Dividers',
            style: DSTypography.appTextTheme.titleLarge,
          ),
          const SizedBox(height: 24),
          DividerItem(name: 'Divider Thin', divider: DSBorders.dividerThin),
          DividerItem(name: 'Divider Regular', divider: DSBorders.dividerRegular),
          DividerItem(name: 'Divider Thick', divider: DSBorders.dividerThick),
        ],
      ),
    );
  }
}

class BorderRadiusItem extends StatelessWidget {
  final String name;
  final BorderRadius borderRadius;

  const BorderRadiusItem({
    super.key,
    required this.name,
    required this.borderRadius,
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

class BorderWidthItem extends StatelessWidget {
  final String name;
  final double width;

  const BorderWidthItem({
    super.key,
    required this.name,
    required this.width,
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
}

class BorderItem extends StatelessWidget {
  final String name;
  final Border border;

  const BorderItem({
    super.key,
    required this.name,
    required this.border,
  });

  @override
  Widget build(BuildContext context) {
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
}

class InputBorderItem extends StatelessWidget {
  final String name;
  final OutlineInputBorder border;

  const InputBorderItem({
    super.key,
    required this.name,
    required this.border,
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
}

class DividerItem extends StatelessWidget {
  final String name;
  final Divider divider;

  const DividerItem({
    super.key,
    required this.name,
    required this.divider,
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
