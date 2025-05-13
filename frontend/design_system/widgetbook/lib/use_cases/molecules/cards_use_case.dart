import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class AppCardsShowcase extends StatelessWidget {
  const AppCardsShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('App Cards', style: DSTypography.appTextTheme.titleLarge),
          const SizedBox(height: 24),

          // Standard Card
          _buildCardSection(
            'Standard Card',
            DSCards.appCard(
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text('Standard Card Content'),
              ),
            ),
          ),

          // Elevated Card
          _buildCardSection(
            'Elevated Card',
            DSCards.appElevatedCard(
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text('Elevated Card Content'),
              ),
            ),
          ),

          // Outlined Card
          _buildCardSection(
            'Outlined Card',
            DSCards.appOutlinedCard(
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text('Outlined Card Content'),
              ),
            ),
          ),

          // Interactive Card
          _buildCardSection(
            'Interactive Card',
            DSCards.appCard(
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text('Interactive Card (Tap me)'),
              ),
            ),
          ),

          // Card with Custom Background
          _buildCardSection(
            'Card with Custom Background',
            DSCards.appCard(
              backgroundColor: DSColors.primaryApp.withOpacity(0.1),
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text('Card with Custom Background'),
              ),
            ),
          ),

          // Card with Custom Border Radius
          _buildCardSection(
            'Card with Custom Border Radius',
            DSCards.appCard(
              borderRadius: DSBorders.borderRadiusXL,
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text('Card with Custom Border Radius'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardSection(String title, Widget card) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: DSTypography.appTextTheme.titleMedium),
          const SizedBox(height: 16),
          card,
        ],
      ),
    );
  }
}

class LandingCardsShowcase extends StatelessWidget {
  const LandingCardsShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Landing Cards',
            style: DSTypography.landingTextTheme.titleLarge,
          ),
          const SizedBox(height: 24),

          // Standard Card
          _buildCardSection(
            'Standard Card',
            DSCards.landingCard(
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text('Standard Card Content'),
              ),
            ),
          ),

          // Interactive Card
          _buildCardSection(
            'Interactive Card',
            DSCards.landingCard(
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text('Interactive Card (Tap me)'),
              ),
            ),
          ),

          // Card with Custom Background
          _buildCardSection(
            'Card with Custom Background',
            DSCards.landingCard(
              backgroundColor: DSColors.primaryLanding.withOpacity(0.1),
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text('Card with Custom Background'),
              ),
            ),
          ),

          // Card with Custom Border Radius
          _buildCardSection(
            'Card with Custom Border Radius',
            DSCards.landingCard(
              borderRadius: DSBorders.borderRadiusXXL,
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text('Card with Custom Border Radius'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardSection(String title, Widget card) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: DSTypography.landingTextTheme.titleMedium),
          const SizedBox(height: 16),
          card,
        ],
      ),
    );
  }
}

class FeatureCardsShowcase extends StatelessWidget {
  const FeatureCardsShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Feature Cards', style: DSTypography.appTextTheme.titleLarge),
          const SizedBox(height: 24),

          // Landing Feature Card
          _buildCardSection(
            'Landing Feature Card',
            DSCards.landingFeatureCard(
              title: 'Feature Title',
              description:
                  'This is a description of the feature. It explains what the feature does and why it is useful.',
              icon: DSIcons.star,
              context: context,
            ),
          ),

          // Landing Feature Card with Action
          _buildCardSection(
            'Landing Feature Card with Action',
            DSCards.landingFeatureCard(
              title: 'Feature Title',
              description:
                  'This is a description of the feature. It explains what the feature does and why it is useful.',
              icon: DSIcons.star,
              context: context,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardSection(String title, Widget card) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: DSTypography.appTextTheme.titleMedium),
          const SizedBox(height: 16),
          card,
        ],
      ),
    );
  }
}
