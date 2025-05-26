import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../atoms/colors.dart';
import '../atoms/typography.dart';
import '../atoms/borders.dart';
import '../atoms/icons.dart';
import '../utils/responsive_utils.dart';

/// Design System Text Fields
class DSTextFields {
  // Private constructor to prevent instantiation
  DSTextFields._();
  
  /// Standard text field for the application theme
  static Widget appTextField({
    required String label,
    String? hint,
    String? helperText,
    String? errorText,
    TextEditingController? controller,
    FocusNode? focusNode,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    bool obscureText = false,
    bool enabled = true,
    bool autofocus = false,
    bool readOnly = false,
    int? maxLines = 1,
    int? minLines,
    int? maxLength,
    ValueChanged<String>? onChanged,
    VoidCallback? onEditingComplete,
    ValueChanged<String>? onSubmitted,
    List<TextInputFormatter>? inputFormatters,
    IconData? prefixIcon,
    IconData? suffixIcon,
    VoidCallback? onSuffixIconPressed,
    EdgeInsets? contentPadding,
    BorderRadius? borderRadius,
    BuildContext? context,
  }) {
    final effectiveContentPadding = contentPadding ?? 
        const EdgeInsets.symmetric(horizontal: 16, vertical: 16);
    final effectiveBorderRadius = borderRadius ?? DSBorders.borderRadiusMD;
    
    return TextField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      enabled: enabled,
      autofocus: autofocus,
      readOnly: readOnly,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onSubmitted: onSubmitted,
      inputFormatters: inputFormatters,
      style: context != null
          ? ResponsiveUtils.responsiveTextStyle(
              context: context,
              defaultStyle: DSTypography.appTextTheme.bodyLarge!,
              md: DSTypography.appTextTheme.bodyLarge!.copyWith(
                fontSize: 16,
              ),
            )
          : DSTypography.appTextTheme.bodyLarge,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        helperText: helperText,
        errorText: errorText,
        contentPadding: effectiveContentPadding,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon: suffixIcon != null
            ? IconButton(
                icon: Icon(suffixIcon),
                onPressed: onSuffixIconPressed,
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: effectiveBorderRadius,
          borderSide: const BorderSide(color: DSColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: effectiveBorderRadius,
          borderSide: const BorderSide(color: DSColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: effectiveBorderRadius,
          borderSide: const BorderSide(color: DSColors.primaryApp),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: effectiveBorderRadius,
          borderSide: const BorderSide(color: DSColors.errorApp),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: effectiveBorderRadius,
          borderSide: const BorderSide(color: DSColors.errorApp, width: 2),
        ),
        filled: true,
        fillColor: enabled ? Colors.white : Colors.grey[100],
      ),
    );
  }
  
  /// Password text field for the application theme
  static Widget appPasswordField({
    required String label,
    String? hint,
    String? helperText,
    String? errorText,
    TextEditingController? controller,
    FocusNode? focusNode,
    TextInputAction? textInputAction = TextInputAction.done,
    bool enabled = true,
    bool autofocus = false,
    ValueChanged<String>? onChanged,
    VoidCallback? onEditingComplete,
    ValueChanged<String>? onSubmitted,
    EdgeInsets? contentPadding,
    BorderRadius? borderRadius,
    BuildContext? context,
  }) {
    final ValueNotifier<bool> obscureText = ValueNotifier<bool>(true);
    
    return ValueListenableBuilder<bool>(
      valueListenable: obscureText,
      builder: (context, isObscured, _) {
        return appTextField(
          label: label,
          hint: hint,
          helperText: helperText,
          errorText: errorText,
          controller: controller,
          focusNode: focusNode,
          keyboardType: TextInputType.visiblePassword,
          textInputAction: textInputAction,
          obscureText: isObscured,
          enabled: enabled,
          autofocus: autofocus,
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
          onSubmitted: onSubmitted,
          contentPadding: contentPadding,
          borderRadius: borderRadius,
          context: context,
          suffixIcon: isObscured ? DSIcons.visibility : DSIcons.visibilityOff,
          onSuffixIconPressed: () {
            obscureText.value = !isObscured;
          },
        );
      },
    );
  }
  
  /// Search text field for the application theme
  static Widget appSearchField({
    String? hint = 'Search',
    TextEditingController? controller,
    FocusNode? focusNode,
    ValueChanged<String>? onChanged,
    VoidCallback? onEditingComplete,
    ValueChanged<String>? onSubmitted,
    VoidCallback? onClearPressed,
    EdgeInsets? contentPadding,
    BorderRadius? borderRadius,
    BuildContext? context,
  }) {
    final effectiveContentPadding = contentPadding ?? 
        const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
    final effectiveBorderRadius = borderRadius ?? DSBorders.borderRadiusCircular;
    
    return TextField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onSubmitted: onSubmitted,
      style: context != null
          ? ResponsiveUtils.responsiveTextStyle(
              context: context,
              defaultStyle: DSTypography.appTextTheme.bodyLarge!,
              md: DSTypography.appTextTheme.bodyLarge!.copyWith(
                fontSize: 16,
              ),
            )
          : DSTypography.appTextTheme.bodyLarge,
      decoration: InputDecoration(
        hintText: hint,
        contentPadding: effectiveContentPadding,
        prefixIcon: const Icon(DSIcons.search),
        suffixIcon: controller != null && controller.text.isNotEmpty
            ? IconButton(
                icon: const Icon(DSIcons.close),
                onPressed: () {
                  controller.clear();
                  if (onClearPressed != null) {
                    onClearPressed();
                  }
                },
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: effectiveBorderRadius,
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: effectiveBorderRadius,
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: effectiveBorderRadius,
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[100],
      ),
    );
  }
  
  /// Text area (multiline) text field for the application theme
  static Widget appTextArea({
    required String label,
    String? hint,
    String? helperText,
    String? errorText,
    TextEditingController? controller,
    FocusNode? focusNode,
    bool enabled = true,
    bool autofocus = false,
    bool readOnly = false,
    int minLines = 3,
    int maxLines = 5,
    int? maxLength,
    ValueChanged<String>? onChanged,
    EdgeInsets? contentPadding,
    BorderRadius? borderRadius,
    BuildContext? context,
  }) {
    return appTextField(
      label: label,
      hint: hint,
      helperText: helperText,
      errorText: errorText,
      controller: controller,
      focusNode: focusNode,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      enabled: enabled,
      autofocus: autofocus,
      readOnly: readOnly,
      minLines: minLines,
      maxLines: maxLines,
      maxLength: maxLength,
      onChanged: onChanged,
      contentPadding: contentPadding,
      borderRadius: borderRadius,
      context: context,
    );
  }
  
  /// Standard text field for the landing theme
  static Widget landingTextField({
    required String label,
    String? hint,
    String? helperText,
    String? errorText,
    TextEditingController? controller,
    FocusNode? focusNode,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    bool obscureText = false,
    bool enabled = true,
    bool autofocus = false,
    bool readOnly = false,
    int? maxLines = 1,
    int? minLines,
    int? maxLength,
    ValueChanged<String>? onChanged,
    VoidCallback? onEditingComplete,
    ValueChanged<String>? onSubmitted,
    List<TextInputFormatter>? inputFormatters,
    IconData? prefixIcon,
    IconData? suffixIcon,
    VoidCallback? onSuffixIconPressed,
    EdgeInsets? contentPadding,
    BorderRadius? borderRadius,
    BuildContext? context,
  }) {
    final effectiveContentPadding = contentPadding ?? 
        const EdgeInsets.symmetric(horizontal: 16, vertical: 20);
    final effectiveBorderRadius = borderRadius ?? DSBorders.borderRadiusMD;
    
    return TextField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      enabled: enabled,
      autofocus: autofocus,
      readOnly: readOnly,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onSubmitted: onSubmitted,
      inputFormatters: inputFormatters,
      style: context != null
          ? ResponsiveUtils.responsiveTextStyle(
              context: context,
              defaultStyle: DSTypography.landingTextTheme.bodyLarge!,
              md: DSTypography.landingTextTheme.bodyLarge!.copyWith(
                fontSize: 16,
              ),
            )
          : DSTypography.landingTextTheme.bodyLarge,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        helperText: helperText,
        errorText: errorText,
        contentPadding: effectiveContentPadding,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon: suffixIcon != null
            ? IconButton(
                icon: Icon(suffixIcon),
                onPressed: onSuffixIconPressed,
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: effectiveBorderRadius,
          borderSide: const BorderSide(color: DSColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: effectiveBorderRadius,
          borderSide: const BorderSide(color: DSColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: effectiveBorderRadius,
          borderSide: const BorderSide(color: DSColors.primaryLanding),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: effectiveBorderRadius,
          borderSide: const BorderSide(color: DSColors.errorLanding),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: effectiveBorderRadius,
          borderSide: const BorderSide(color: DSColors.errorLanding, width: 2),
        ),
        filled: true,
        fillColor: enabled ? Colors.white : Colors.grey[100],
      ),
    );
  }
}
