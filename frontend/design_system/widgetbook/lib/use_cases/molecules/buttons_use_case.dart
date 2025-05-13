import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class AppButtonsShowcase extends StatelessWidget {
  const AppButtonsShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('App Buttons', style: DSTypography.appTextTheme.titleLarge),
          const SizedBox(height: 24),

          // Primary Button
          _buildButtonSection(
            'Primary Button',
            DSButtons.primaryAppButton(
              text: 'Primary Button',
              onPressed: () {},
            ),
          ),

          // Secondary Button
          _buildButtonSection(
            'Secondary Button',
            DSButtons.secondaryAppButton(
              text: 'Secondary Button',
              onPressed: () {},
            ),
          ),

          // Text Button
          _buildButtonSection(
            'Text Button',
            DSButtons.textAppButton(text: 'Text Button', onPressed: () {}),
          ),

          // Loading Button
          _buildButtonSection(
            'Loading Button',
            DSButtons.primaryAppButton(
              text: 'Loading Button',
              onPressed: () {},
              isLoading: true,
            ),
          ),

          // Full Width Button
          _buildButtonSection(
            'Full Width Button',
            DSButtons.primaryAppButton(
              text: 'Full Width Button',
              onPressed: () {},
              isFullWidth: true,
            ),
          ),

          // Button with Leading Icon
          _buildButtonSection(
            'Button with Leading Icon',
            DSButtons.primaryAppButton(
              text: 'Button with Icon',
              onPressed: () {},
              leadingIcon: DSIcons.add,
            ),
          ),

          // Button with Trailing Icon
          _buildButtonSection(
            'Button with Trailing Icon',
            DSButtons.primaryAppButton(
              text: 'Button with Icon',
              onPressed: () {},
              trailingIcon: DSIcons.arrowForward,
            ),
          ),

          // Disabled Button
          _buildButtonSection(
            'Disabled Button',
            DSButtons.primaryAppButton(
              text: 'Disabled Button',
              onPressed: () => {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonSection(String title, Widget button) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: DSTypography.appTextTheme.titleMedium),
          const SizedBox(height: 16),
          button,
        ],
      ),
    );
  }
}

class LandingButtonsShowcase extends StatelessWidget {
  const LandingButtonsShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Landing Buttons',
            style: DSTypography.landingTextTheme.titleLarge,
          ),
          const SizedBox(height: 24),

          // Primary Button
          _buildButtonSection(
            'Primary Button',
            DSButtons.primaryLandingButton(
              text: 'Primary Button',
              onPressed: () {},
            ),
          ),

          // Secondary Button
          _buildButtonSection(
            'Secondary Button',
            DSButtons.secondaryLandingButton(
              text: 'Secondary Button',
              onPressed: () {},
            ),
          ),

          // Loading Button
          _buildButtonSection(
            'Loading Button',
            DSButtons.primaryLandingButton(
              text: 'Loading Button',
              onPressed: () {},
              isLoading: true,
            ),
          ),

          // Full Width Button
          _buildButtonSection(
            'Full Width Button',
            DSButtons.primaryLandingButton(
              text: 'Full Width Button',
              onPressed: () {},
              isFullWidth: true,
            ),
          ),

          // Button with Leading Icon
          _buildButtonSection(
            'Button with Leading Icon',
            DSButtons.primaryLandingButton(
              text: 'Button with Icon',
              onPressed: () {},
              leadingIcon: DSIcons.add,
            ),
          ),

          // Button with Trailing Icon
          _buildButtonSection(
            'Button with Trailing Icon',
            DSButtons.primaryLandingButton(
              text: 'Button with Icon',
              onPressed: () {},
              trailingIcon: DSIcons.arrowForward,
            ),
          ),

          // Disabled Button
          _buildButtonSection(
            'Disabled Button',
            DSButtons.primaryLandingButton(
              text: 'Disabled Button',
              onPressed: () => {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonSection(String title, Widget button) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: DSTypography.landingTextTheme.titleMedium),
          const SizedBox(height: 16),
          button,
        ],
      ),
    );
  }
}

class IconButtonsShowcase extends StatelessWidget {
  const IconButtonsShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Icon Buttons', style: DSTypography.appTextTheme.titleLarge),
          const SizedBox(height: 24),

          // App Icon Button
          _buildButtonSection(
            'App Icon Button',
            DSButtons.iconAppButton(icon: DSIcons.add, onPressed: () {}),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonSection(String title, Widget button) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: DSTypography.appTextTheme.titleMedium),
          const SizedBox(height: 16),
          Center(child: button),
        ],
      ),
    );
  }
}
