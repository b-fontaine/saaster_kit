import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class AppTextFieldsShowcase extends StatelessWidget {
  const AppTextFieldsShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('App Text Fields', style: DSTypography.appTextTheme.titleLarge),
          const SizedBox(height: 24),

          // Standard Text Field
          _buildTextFieldSection(
            'Standard Text Field',
            DSTextFields.appTextField(
              label: 'Label',
              hint: 'Hint text',
              helperText: 'Helper text',
              context: context,
            ),
          ),

          // Text Field with Prefix Icon
          _buildTextFieldSection(
            'Text Field with Prefix Icon',
            DSTextFields.appTextField(
              label: 'Email',
              hint: 'Enter your email',
              prefixIcon: DSIcons.email,
              context: context,
            ),
          ),

          // Text Field with Suffix Icon
          _buildTextFieldSection(
            'Text Field with Suffix Icon',
            DSTextFields.appTextField(
              label: 'Search',
              hint: 'Search...',
              suffixIcon: DSIcons.search,
              context: context,
            ),
          ),

          // Text Field with Error
          _buildTextFieldSection(
            'Text Field with Error',
            DSTextFields.appTextField(
              label: 'Username',
              hint: 'Enter your username',
              errorText: 'Username is required',
              context: context,
            ),
          ),

          // Disabled Text Field
          _buildTextFieldSection(
            'Disabled Text Field',
            DSTextFields.appTextField(
              label: 'Disabled',
              hint: 'This field is disabled',
              enabled: false,
              context: context,
            ),
          ),

          // Read-only Text Field
          _buildTextFieldSection(
            'Read-only Text Field',
            DSTextFields.appTextField(
              label: 'Read-only',
              hint: 'This field is read-only',
              readOnly: true,
              controller: TextEditingController(text: 'Read-only content'),
              context: context,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFieldSection(String title, Widget textField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: DSTypography.appTextTheme.titleMedium),
          const SizedBox(height: 16),
          textField,
        ],
      ),
    );
  }
}

class LandingTextFieldsShowcase extends StatelessWidget {
  const LandingTextFieldsShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Landing Text Fields',
            style: DSTypography.landingTextTheme.titleLarge,
          ),
          const SizedBox(height: 24),

          // Standard Text Field
          _buildTextFieldSection(
            'Standard Text Field',
            DSTextFields.landingTextField(
              label: 'Label',
              hint: 'Hint text',
              helperText: 'Helper text',
              context: context,
            ),
          ),

          // Text Field with Prefix Icon
          _buildTextFieldSection(
            'Text Field with Prefix Icon',
            DSTextFields.landingTextField(
              label: 'Email',
              hint: 'Enter your email',
              prefixIcon: DSIcons.email,
              context: context,
            ),
          ),

          // Text Field with Suffix Icon
          _buildTextFieldSection(
            'Text Field with Suffix Icon',
            DSTextFields.landingTextField(
              label: 'Search',
              hint: 'Search...',
              suffixIcon: DSIcons.search,
              context: context,
            ),
          ),

          // Text Field with Error
          _buildTextFieldSection(
            'Text Field with Error',
            DSTextFields.landingTextField(
              label: 'Username',
              hint: 'Enter your username',
              errorText: 'Username is required',
              context: context,
            ),
          ),

          // Disabled Text Field
          _buildTextFieldSection(
            'Disabled Text Field',
            DSTextFields.landingTextField(
              label: 'Disabled',
              hint: 'This field is disabled',
              enabled: false,
              context: context,
            ),
          ),

          // Read-only Text Field
          _buildTextFieldSection(
            'Read-only Text Field',
            DSTextFields.landingTextField(
              label: 'Read-only',
              hint: 'This field is read-only',
              readOnly: true,
              controller: TextEditingController(text: 'Read-only content'),
              context: context,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFieldSection(String title, Widget textField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: DSTypography.landingTextTheme.titleMedium),
          const SizedBox(height: 16),
          textField,
        ],
      ),
    );
  }
}

class SpecialTextFieldsShowcase extends StatelessWidget {
  const SpecialTextFieldsShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Special Text Fields',
            style: DSTypography.appTextTheme.titleLarge,
          ),
          const SizedBox(height: 24),

          // Password Field
          _buildTextFieldSection(
            'Password Field',
            DSTextFields.appPasswordField(
              label: 'Password',
              hint: 'Enter your password',
              context: context,
            ),
          ),

          // Search Field
          _buildTextFieldSection(
            'Search Field',
            DSTextFields.appSearchField(hint: 'Search...', context: context),
          ),

          // Text Area
          _buildTextFieldSection(
            'Text Area',
            DSTextFields.appTextArea(
              label: 'Description',
              hint: 'Enter a description',
              minLines: 3,
              maxLines: 5,
              context: context,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFieldSection(String title, Widget textField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: DSTypography.appTextTheme.titleMedium),
          const SizedBox(height: 16),
          textField,
        ],
      ),
    );
  }
}
