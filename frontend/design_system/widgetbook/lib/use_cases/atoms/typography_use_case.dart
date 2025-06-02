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
          TypographyItem(
            name: 'Display Large',
            style: DSTypography.appTextTheme.displayLarge!,
            text: 'The quick brown fox jumps over the lazy dog',
          ),
          TypographyItem(
            name: 'Display Medium',
            style: DSTypography.appTextTheme.displayMedium!,
            text: 'The quick brown fox jumps over the lazy dog',
          ),
          TypographyItem(
            name: 'Display Small',
            style: DSTypography.appTextTheme.displaySmall!,
            text: 'The quick brown fox jumps over the lazy dog',
          ),
          TypographyItem(
            name: 'Headline Large',
            style: DSTypography.appTextTheme.headlineLarge!,
            text: 'The quick brown fox jumps over the lazy dog',
          ),
          TypographyItem(
            name: 'Headline Medium',
            style: DSTypography.appTextTheme.headlineMedium!,
            text: 'The quick brown fox jumps over the lazy dog',
          ),
          TypographyItem(
            name: 'Headline Small',
            style: DSTypography.appTextTheme.headlineSmall!,
            text: 'The quick brown fox jumps over the lazy dog',
          ),
          TypographyItem(
            name: 'Title Large',
            style: DSTypography.appTextTheme.titleLarge!,
            text: 'The quick brown fox jumps over the lazy dog',
          ),
          TypographyItem(
            name: 'Title Medium',
            style: DSTypography.appTextTheme.titleMedium!,
            text: 'The quick brown fox jumps over the lazy dog',
          ),
          TypographyItem(
            name: 'Title Small',
            style: DSTypography.appTextTheme.titleSmall!,
            text: 'The quick brown fox jumps over the lazy dog',
          ),
          TypographyItem(
            name: 'Body Large',
            style: DSTypography.appTextTheme.bodyLarge!,
            text: 'The quick brown fox jumps over the lazy dog',
          ),
          TypographyItem(
            name: 'Body Medium',
            style: DSTypography.appTextTheme.bodyMedium!,
            text: 'The quick brown fox jumps over the lazy dog',
          ),
          TypographyItem(
            name: 'Body Small',
            style: DSTypography.appTextTheme.bodySmall!,
            text: 'The quick brown fox jumps over the lazy dog',
          ),
          TypographyItem(
            name: 'Label Large',
            style: DSTypography.appTextTheme.labelLarge!,
            text: 'The quick brown fox jumps over the lazy dog',
          ),
          TypographyItem(
            name: 'Label Medium',
            style: DSTypography.appTextTheme.labelMedium!,
            text: 'The quick brown fox jumps over the lazy dog',
          ),
          TypographyItem(
            name: 'Label Small',
            style: DSTypography.appTextTheme.labelSmall!,
            text: 'The quick brown fox jumps over the lazy dog',
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
          TypographyItem(
            name: 'Display Large',
            style: DSTypography.landingTextTheme.displayLarge!,
            text: 'The quick brown fox jumps over the lazy dog',
          ),
          TypographyItem(
            name: 'Display Medium',
            style: DSTypography.landingTextTheme.displayMedium!,
            text: 'The quick brown fox jumps over the lazy dog',
          ),
          TypographyItem(
            name: 'Display Small',
            style: DSTypography.landingTextTheme.displaySmall!,
            text: 'The quick brown fox jumps over the lazy dog',
          ),
          TypographyItem(
            name: 'Headline Large',
            style: DSTypography.landingTextTheme.headlineLarge!,
            text: 'The quick brown fox jumps over the lazy dog',
          ),
          TypographyItem(
            name: 'Headline Medium',
            style: DSTypography.landingTextTheme.headlineMedium!,
            text: 'The quick brown fox jumps over the lazy dog',
          ),
          TypographyItem(
            name: 'Headline Small',
            style: DSTypography.landingTextTheme.headlineSmall!,
            text: 'The quick brown fox jumps over the lazy dog',
          ),
          TypographyItem(
            name: 'Title Large',
            style: DSTypography.landingTextTheme.titleLarge!,
            text: 'The quick brown fox jumps over the lazy dog',
          ),
          TypographyItem(
            name: 'Title Medium',
            style: DSTypography.landingTextTheme.titleMedium!,
            text: 'The quick brown fox jumps over the lazy dog',
          ),
          TypographyItem(
            name: 'Title Small',
            style: DSTypography.landingTextTheme.titleSmall!,
            text: 'The quick brown fox jumps over the lazy dog',
          ),
          TypographyItem(
            name: 'Body Large',
            style: DSTypography.landingTextTheme.bodyLarge!,
            text: 'The quick brown fox jumps over the lazy dog',
          ),
          TypographyItem(
            name: 'Body Medium',
            style: DSTypography.landingTextTheme.bodyMedium!,
            text: 'The quick brown fox jumps over the lazy dog',
          ),
          TypographyItem(
            name: 'Body Small',
            style: DSTypography.landingTextTheme.bodySmall!,
            text: 'The quick brown fox jumps over the lazy dog',
          ),
          TypographyItem(
            name: 'Label Large',
            style: DSTypography.landingTextTheme.labelLarge!,
            text: 'The quick brown fox jumps over the lazy dog',
          ),
          TypographyItem(
            name: 'Label Medium',
            style: DSTypography.landingTextTheme.labelMedium!,
            text: 'The quick brown fox jumps over the lazy dog',
          ),
          TypographyItem(
            name: 'Label Small',
            style: DSTypography.landingTextTheme.labelSmall!,
            text: 'The quick brown fox jumps over the lazy dog',
          ),
        ],
      ),
    );
  }


}

class TypographyItem extends StatelessWidget {
  final String name;
  final TextStyle style;
  final String text;

  const TypographyItem({
    super.key,
    required this.name,
    required this.style,
    required this.text,
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
