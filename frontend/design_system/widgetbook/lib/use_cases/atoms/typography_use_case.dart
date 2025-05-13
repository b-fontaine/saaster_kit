import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

class AppTypographyShowcase extends StatelessWidget {
  const AppTypographyShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'App Typography',
            style: DSTypography.appTextTheme.titleLarge,
          ),
          const SizedBox(height: 24),
          _buildTypographyItem(
            'Display Large',
            DSTypography.appTextTheme.displayLarge!,
            'The quick brown fox jumps over the lazy dog',
          ),
          _buildTypographyItem(
            'Display Medium',
            DSTypography.appTextTheme.displayMedium!,
            'The quick brown fox jumps over the lazy dog',
          ),
          _buildTypographyItem(
            'Display Small',
            DSTypography.appTextTheme.displaySmall!,
            'The quick brown fox jumps over the lazy dog',
          ),
          _buildTypographyItem(
            'Headline Large',
            DSTypography.appTextTheme.headlineLarge!,
            'The quick brown fox jumps over the lazy dog',
          ),
          _buildTypographyItem(
            'Headline Medium',
            DSTypography.appTextTheme.headlineMedium!,
            'The quick brown fox jumps over the lazy dog',
          ),
          _buildTypographyItem(
            'Headline Small',
            DSTypography.appTextTheme.headlineSmall!,
            'The quick brown fox jumps over the lazy dog',
          ),
          _buildTypographyItem(
            'Title Large',
            DSTypography.appTextTheme.titleLarge!,
            'The quick brown fox jumps over the lazy dog',
          ),
          _buildTypographyItem(
            'Title Medium',
            DSTypography.appTextTheme.titleMedium!,
            'The quick brown fox jumps over the lazy dog',
          ),
          _buildTypographyItem(
            'Title Small',
            DSTypography.appTextTheme.titleSmall!,
            'The quick brown fox jumps over the lazy dog',
          ),
          _buildTypographyItem(
            'Body Large',
            DSTypography.appTextTheme.bodyLarge!,
            'The quick brown fox jumps over the lazy dog',
          ),
          _buildTypographyItem(
            'Body Medium',
            DSTypography.appTextTheme.bodyMedium!,
            'The quick brown fox jumps over the lazy dog',
          ),
          _buildTypographyItem(
            'Body Small',
            DSTypography.appTextTheme.bodySmall!,
            'The quick brown fox jumps over the lazy dog',
          ),
          _buildTypographyItem(
            'Label Large',
            DSTypography.appTextTheme.labelLarge!,
            'The quick brown fox jumps over the lazy dog',
          ),
          _buildTypographyItem(
            'Label Medium',
            DSTypography.appTextTheme.labelMedium!,
            'The quick brown fox jumps over the lazy dog',
          ),
          _buildTypographyItem(
            'Label Small',
            DSTypography.appTextTheme.labelSmall!,
            'The quick brown fox jumps over the lazy dog',
          ),
        ],
      ),
    );
  }

  Widget _buildTypographyItem(String name, TextStyle style, String text) {
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
          Text(text, style: style),
          const SizedBox(height: 8),
          Text(
            'Font: ${style.fontFamily}, Size: ${style.fontSize?.toStringAsFixed(1)}, Weight: ${style.fontWeight}, Letter Spacing: ${style.letterSpacing}',
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

class LandingTypographyShowcase extends StatelessWidget {
  const LandingTypographyShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Landing Typography',
            style: DSTypography.landingTextTheme.titleLarge,
          ),
          const SizedBox(height: 24),
          _buildTypographyItem(
            'Display Large',
            DSTypography.landingTextTheme.displayLarge!,
            'The quick brown fox jumps over the lazy dog',
          ),
          _buildTypographyItem(
            'Display Medium',
            DSTypography.landingTextTheme.displayMedium!,
            'The quick brown fox jumps over the lazy dog',
          ),
          _buildTypographyItem(
            'Display Small',
            DSTypography.landingTextTheme.displaySmall!,
            'The quick brown fox jumps over the lazy dog',
          ),
          _buildTypographyItem(
            'Headline Large',
            DSTypography.landingTextTheme.headlineLarge!,
            'The quick brown fox jumps over the lazy dog',
          ),
          _buildTypographyItem(
            'Headline Medium',
            DSTypography.landingTextTheme.headlineMedium!,
            'The quick brown fox jumps over the lazy dog',
          ),
          _buildTypographyItem(
            'Headline Small',
            DSTypography.landingTextTheme.headlineSmall!,
            'The quick brown fox jumps over the lazy dog',
          ),
          _buildTypographyItem(
            'Title Large',
            DSTypography.landingTextTheme.titleLarge!,
            'The quick brown fox jumps over the lazy dog',
          ),
          _buildTypographyItem(
            'Title Medium',
            DSTypography.landingTextTheme.titleMedium!,
            'The quick brown fox jumps over the lazy dog',
          ),
          _buildTypographyItem(
            'Title Small',
            DSTypography.landingTextTheme.titleSmall!,
            'The quick brown fox jumps over the lazy dog',
          ),
          _buildTypographyItem(
            'Body Large',
            DSTypography.landingTextTheme.bodyLarge!,
            'The quick brown fox jumps over the lazy dog',
          ),
          _buildTypographyItem(
            'Body Medium',
            DSTypography.landingTextTheme.bodyMedium!,
            'The quick brown fox jumps over the lazy dog',
          ),
          _buildTypographyItem(
            'Body Small',
            DSTypography.landingTextTheme.bodySmall!,
            'The quick brown fox jumps over the lazy dog',
          ),
          _buildTypographyItem(
            'Label Large',
            DSTypography.landingTextTheme.labelLarge!,
            'The quick brown fox jumps over the lazy dog',
          ),
          _buildTypographyItem(
            'Label Medium',
            DSTypography.landingTextTheme.labelMedium!,
            'The quick brown fox jumps over the lazy dog',
          ),
          _buildTypographyItem(
            'Label Small',
            DSTypography.landingTextTheme.labelSmall!,
            'The quick brown fox jumps over the lazy dog',
          ),
        ],
      ),
    );
  }

  Widget _buildTypographyItem(String name, TextStyle style, String text) {
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
          Text(text, style: style),
          const SizedBox(height: 8),
          Text(
            'Font: ${style.fontFamily}, Size: ${style.fontSize?.toStringAsFixed(1)}, Weight: ${style.fontWeight}, Letter Spacing: ${style.letterSpacing}',
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
