import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class AppDialogsShowcase extends StatelessWidget {
  const AppDialogsShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('App Dialogs', style: DSTypography.appTextTheme.titleLarge),
          const SizedBox(height: 24),

          // Alert Dialog
          _buildDialogSection(
            'Alert Dialog',
            DSButtons.primaryAppButton(
              text: 'Show Alert Dialog',
              onPressed: () {
                DSDialogs.showAppFullScreenDialog(
                  context: context,
                  title: 'Alert Dialog',
                  actions: [
                    DSButtons.textAppButton(
                      text: 'Cancel',
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    DSButtons.primaryAppButton(
                      text: 'OK',
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                  child: Center(
                    child: Text('This is an alert dialog with a message.'),
                  ),
                );
              },
            ),
          ),

          // Confirmation Dialog
          _buildDialogSection(
            'Confirmation Dialog',
            DSButtons.primaryAppButton(
              text: 'Show Confirmation Dialog',
              onPressed: () {
                DSDialogs.showAppConfirmDialog(
                  context: context,
                  title: 'Confirmation',
                  message: 'Are you sure you want to proceed with this action?',
                  confirmButtonText: 'Confirm',
                  cancelButtonText: 'Cancel',
                  onConfirm: () => Navigator.of(context).pop(true),
                  onCancel: () => Navigator.of(context).pop(false),
                );
              },
            ),
          ),

          // Information Dialog
          _buildDialogSection(
            'Success Dialog',
            DSButtons.primaryAppButton(
              text: 'Show Information Dialog',
              onPressed: () {
                DSDialogs.showAppSuccessDialog(
                  context: context,
                  title: 'Information',
                  message:
                      'This is an information dialog with some details that you should know.',
                  buttonText: 'Got it',
                  onConfirm: () => Navigator.of(context).pop(),
                );
              },
            ),
          ),

          // Error Dialog
          _buildDialogSection(
            'Error Dialog',
            DSButtons.primaryAppButton(
              text: 'Show Error Dialog',
              onPressed: () {
                DSDialogs.showAppErrorDialog(
                  context: context,
                  title: 'Error',
                  message:
                      'An error occurred while processing your request. Please try again later.',
                  buttonText: 'OK',
                  onConfirm: () => Navigator.of(context).pop(),
                );
              },
            ),
          ),

          // Custom Dialog
          _buildDialogSection(
            'Bottom Sheet Dialog',
            DSButtons.primaryAppButton(
              text: 'Show Custom Dialog',
              onPressed: () {
                DSDialogs.showAppBottomSheet(
                  context: context,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          DSIcons.star,
                          size: 48,
                          color: DSColors.primaryApp,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Custom Dialog',
                          style: DSTypography.appTextTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'This is a custom dialog with custom content and styling.',
                          style: DSTypography.appTextTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        DSButtons.primaryAppButton(
                          text: 'Close',
                          onPressed: () => Navigator.of(context).pop(),
                          isFullWidth: true,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDialogSection(String title, Widget button) {
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

class LandingDialogsShowcase extends StatelessWidget {
  const LandingDialogsShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Landing Dialogs',
            style: DSTypography.landingTextTheme.titleLarge,
          ),
          const SizedBox(height: 24),

          // Custom Dialog
          _buildDialogSection(
            'Custom Dialog',
            DSButtons.primaryLandingButton(
              text: 'Show Custom Dialog',
              onPressed: () {
                DSDialogs.showLandingDialog(
                  context: context,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          DSIcons.star,
                          size: 48,
                          color: DSColors.primaryLanding,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Custom Dialog',
                          style: DSTypography.landingTextTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'This is a custom dialog with custom content and styling.',
                          style: DSTypography.landingTextTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        DSButtons.primaryLandingButton(
                          text: 'Close',
                          onPressed: () => Navigator.of(context).pop(),
                          isFullWidth: true,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDialogSection(String title, Widget button) {
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
