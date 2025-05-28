import 'package:flutter/material.dart';

import '../atoms/borders.dart';
import '../atoms/colors.dart';
import '../atoms/icons.dart';
import '../atoms/spacing.dart';
import '../atoms/typography.dart';
import '../utils/responsive_utils.dart';

/// Design System Dialogs
class DSDialogs {
  // Private constructor to prevent instantiation
  DSDialogs._();

  /// Standard alert dialog for the application theme
  static Future<T?> showAppAlertDialog<T>({
    required BuildContext context,
    required String title,
    required String message,
    String? confirmButtonText,
    String? cancelButtonText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool barrierDismissible = true,
    Color? backgroundColor,
    BorderRadius? borderRadius,
  }) {
    final effectiveBorderRadius = borderRadius ?? DSBorders.borderRadiusLG;

    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: ResponsiveUtils.responsiveTextStyle(
              context: context,
              defaultStyle: DSTypography.appTextTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
              ),
              md: DSTypography.appTextTheme.titleLarge!.copyWith(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          content: Text(
            message,
            style: ResponsiveUtils.responsiveTextStyle(
              context: context,
              defaultStyle: DSTypography.appTextTheme.bodyLarge!,
              md: DSTypography.appTextTheme.bodyLarge!.copyWith(fontSize: 16),
            ),
          ),
          backgroundColor: backgroundColor ?? DSColors.surfaceApp,
          shape: RoundedRectangleBorder(borderRadius: effectiveBorderRadius),
          actions: <Widget>[
            if (cancelButtonText != null)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onCancel != null) {
                    onCancel();
                  }
                },
                child: Text(
                  cancelButtonText,
                  style: DSTypography.appTextTheme.labelLarge?.copyWith(
                    color: DSColors.textSecondary,
                  ),
                ),
              ),
            if (confirmButtonText != null)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onConfirm != null) {
                    onConfirm();
                  }
                },
                child: Text(
                  confirmButtonText,
                  style: DSTypography.appTextTheme.labelLarge?.copyWith(
                    color: DSColors.primaryApp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  /// Confirmation dialog for the application theme
  static Future<bool> showAppConfirmDialog({
    required BuildContext context,
    required String title,
    required String message,
    String confirmButtonText = 'Confirm',
    String cancelButtonText = 'Cancel',
    bool barrierDismissible = true,
    Color? backgroundColor,
    BorderRadius? borderRadius,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) async {
    final result = await showAppAlertDialog<bool>(
      context: context,
      title: title,
      message: message,
      confirmButtonText: confirmButtonText,
      cancelButtonText: cancelButtonText,
      onConfirm: onConfirm,
      onCancel: onCancel,
      barrierDismissible: barrierDismissible,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
    );

    return result ?? false;
  }

  /// Success dialog for the application theme
  static Future<void> showAppSuccessDialog({
    required BuildContext context,
    required String title,
    required String message,
    String buttonText = 'OK',
    VoidCallback? onConfirm,
    bool barrierDismissible = true,
    Color? backgroundColor,
    BorderRadius? borderRadius,
  }) {
    final effectiveBorderRadius = borderRadius ?? DSBorders.borderRadiusLG;

    return showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: backgroundColor ?? DSColors.surfaceApp,
          shape: RoundedRectangleBorder(borderRadius: effectiveBorderRadius),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(DSIcons.check, color: DSColors.successApp, size: 64),
              DSSpacing.verticalSpacerMD,
              Text(
                title,
                style: ResponsiveUtils.responsiveTextStyle(
                  context: context,
                  defaultStyle: DSTypography.appTextTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  md: DSTypography.appTextTheme.titleLarge!.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
              DSSpacing.verticalSpacerSM,
              Text(
                message,
                style: ResponsiveUtils.responsiveTextStyle(
                  context: context,
                  defaultStyle: DSTypography.appTextTheme.bodyLarge!,
                  md: DSTypography.appTextTheme.bodyLarge!.copyWith(
                    fontSize: 16,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
              DSSpacing.verticalSpacerLG,
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (onConfirm != null) {
                      onConfirm();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: DSColors.primaryApp,
                    foregroundColor: DSColors.textOnPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text(buttonText),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Error dialog for the application theme
  static Future<void> showAppErrorDialog({
    required BuildContext context,
    required String title,
    required String message,
    String buttonText = 'OK',
    VoidCallback? onConfirm,
    bool barrierDismissible = true,
    Color? backgroundColor,
    BorderRadius? borderRadius,
  }) {
    final effectiveBorderRadius = borderRadius ?? DSBorders.borderRadiusLG;

    return showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: backgroundColor ?? DSColors.surfaceApp,
          shape: RoundedRectangleBorder(borderRadius: effectiveBorderRadius),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(DSIcons.error, color: DSColors.errorApp, size: 64),
              DSSpacing.verticalSpacerMD,
              Text(
                title,
                style: ResponsiveUtils.responsiveTextStyle(
                  context: context,
                  defaultStyle: DSTypography.appTextTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  md: DSTypography.appTextTheme.titleLarge!.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
              DSSpacing.verticalSpacerSM,
              Text(
                message,
                style: ResponsiveUtils.responsiveTextStyle(
                  context: context,
                  defaultStyle: DSTypography.appTextTheme.bodyLarge!,
                  md: DSTypography.appTextTheme.bodyLarge!.copyWith(
                    fontSize: 16,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
              DSSpacing.verticalSpacerLG,
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (onConfirm != null) {
                      onConfirm();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: DSColors.errorApp,
                    foregroundColor: DSColors.textOnPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text(buttonText),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Bottom sheet for the application theme
  static Future<T?> showAppBottomSheet<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    bool isDismissible = true,
    bool enableDrag = true,
    Color? backgroundColor,
    BorderRadius? borderRadius,
    double? maxHeight,
  }) {
    final effectiveBorderRadius =
        borderRadius ??
        const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        );

    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: maxHeight ?? MediaQuery.sizeOf(context).height * 0.85,
          ),
          decoration: BoxDecoration(
            color: backgroundColor ?? DSColors.surfaceApp,
            borderRadius: effectiveBorderRadius,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              Container(
                margin: const EdgeInsets.only(top: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              if (title != null) ...[
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    title,
                    style: DSTypography.appTextTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Divider(),
              ],
              Flexible(child: SingleChildScrollView(child: child)),
            ],
          ),
        );
      },
    );
  }

  /// Full screen dialog for the application theme
  static Future<T?> showAppFullScreenDialog<T>({
    required BuildContext context,
    required Widget child,
    required String title,
    List<Widget>? actions,
    Color? backgroundColor,
    bool barrierDismissible = false,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return Dialog.fullscreen(
          backgroundColor: backgroundColor ?? DSColors.surfaceApp,
          child: Scaffold(
            appBar: AppBar(
              title: Text(title),
              leading: IconButton(
                icon: const Icon(DSIcons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
              actions: actions,
            ),
            body: child,
          ),
        );
      },
    );
  }

  /// Loading dialog for the application theme
  static Future<void> showAppLoadingDialog({
    required BuildContext context,
    String message = 'Loading...',
    bool barrierDismissible = false,
    Color? backgroundColor,
    BorderRadius? borderRadius,
  }) {
    final effectiveBorderRadius = borderRadius ?? DSBorders.borderRadiusLG;

    return showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: backgroundColor ?? DSColors.surfaceApp,
          shape: RoundedRectangleBorder(borderRadius: effectiveBorderRadius),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              DSSpacing.verticalSpacerMD,
              Text(
                message,
                style: DSTypography.appTextTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }

  /// Custom dialog for the landing theme
  static Future<T?> showLandingDialog<T>({
    required BuildContext context,
    required Widget child,
    bool barrierDismissible = true,
    Color? backgroundColor,
    BorderRadius? borderRadius,
    EdgeInsets? padding,
  }) {
    final effectiveBorderRadius = borderRadius ?? DSBorders.borderRadiusXL;
    final effectivePadding = padding ?? const EdgeInsets.all(24);

    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: backgroundColor ?? DSColors.surfaceLanding,
          shape: RoundedRectangleBorder(borderRadius: effectiveBorderRadius),
          child: Padding(padding: effectivePadding, child: child),
        );
      },
    );
  }
}
