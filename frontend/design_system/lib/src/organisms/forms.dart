import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../atoms/colors.dart';
import '../atoms/typography.dart';
import '../atoms/spacing.dart';
import '../atoms/icons.dart';
import '../molecules/text_fields.dart';
import '../molecules/buttons.dart';

/// Design System Forms
class DSForms {
  // Private constructor to prevent instantiation
  DSForms._();

  /// Form field with label and optional helper text
  static Widget appFormField({
    required String label,
    required Widget field,
    String? helperText,
    String? errorText,
    bool isRequired = false,
    EdgeInsets? padding,
  }) {
    final effectivePadding = padding ?? const EdgeInsets.only(bottom: 16);

    return Padding(
      padding: effectivePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                label,
                style: DSTypography.appTextTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (isRequired) ...[
                const SizedBox(width: 4),
                Text(
                  '*',
                  style: DSTypography.appTextTheme.bodyMedium?.copyWith(
                    color: DSColors.errorApp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ],
          ),
          DSSpacing.verticalSpacerXS,
          field,
          if (errorText != null) ...[
            DSSpacing.verticalSpacerXXS,
            Text(
              errorText,
              style: DSTypography.appTextTheme.bodySmall?.copyWith(
                color: DSColors.errorApp,
              ),
            ),
          ] else if (helperText != null) ...[
            DSSpacing.verticalSpacerXXS,
            Text(
              helperText,
              style: DSTypography.appTextTheme.bodySmall?.copyWith(
                color: DSColors.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Text input form field
  static Widget appTextFormField({
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
    bool isRequired = false,
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
    EdgeInsets? padding,
    BorderRadius? borderRadius,
    BuildContext? context,
  }) {
    return appFormField(
      label: label,
      helperText: helperText,
      errorText: errorText,
      isRequired: isRequired,
      padding: padding,
      field: DSTextFields.appTextField(
        label: '',
        hint: hint,
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
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        onSuffixIconPressed: onSuffixIconPressed,
        contentPadding: contentPadding,
        borderRadius: borderRadius,
        context: context,
      ),
    );
  }

  /// Password input form field
  static Widget appPasswordFormField({
    required String label,
    String? hint,
    String? helperText,
    String? errorText,
    TextEditingController? controller,
    FocusNode? focusNode,
    TextInputAction? textInputAction = TextInputAction.done,
    bool enabled = true,
    bool autofocus = false,
    bool isRequired = false,
    ValueChanged<String>? onChanged,
    VoidCallback? onEditingComplete,
    ValueChanged<String>? onSubmitted,
    EdgeInsets? contentPadding,
    EdgeInsets? padding,
    BorderRadius? borderRadius,
    BuildContext? context,
  }) {
    final ValueNotifier<bool> obscureText = ValueNotifier<bool>(true);

    return appFormField(
      label: label,
      helperText: helperText,
      errorText: errorText,
      isRequired: isRequired,
      padding: padding,
      field: ValueListenableBuilder<bool>(
        valueListenable: obscureText,
        builder: (context, isObscured, _) {
          return DSTextFields.appTextField(
            label: '',
            hint: hint,
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
      ),
    );
  }

  /// Dropdown form field
  static Widget appDropdownFormField<T>({
    required String label,
    required T? value,
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T?> onChanged,
    String? helperText,
    String? errorText,
    bool isRequired = false,
    bool enabled = true,
    String? hint,
    EdgeInsets? padding,
    EdgeInsets? contentPadding,
    BorderRadius? borderRadius,
  }) {
    final effectiveContentPadding = contentPadding ??
        const EdgeInsets.symmetric(horizontal: 16, vertical: 0);
    final effectiveBorderRadius = borderRadius ?? BorderRadius.circular(8);

    return appFormField(
      label: label,
      helperText: helperText,
      errorText: errorText,
      isRequired: isRequired,
      padding: padding,
      field: Container(
        decoration: BoxDecoration(
          color: enabled ? Colors.white : Colors.grey[100],
          borderRadius: effectiveBorderRadius,
          border: Border.all(
            color: errorText != null ? DSColors.errorApp : DSColors.divider,
          ),
        ),
        child: Padding(
          padding: effectiveContentPadding,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              items: items,
              onChanged: enabled ? onChanged : null,
              isExpanded: true,
              hint: hint != null ? Text(hint) : null,
              icon: const Icon(DSIcons.arrowDown),
              style: DSTypography.appTextTheme.bodyLarge,
              dropdownColor: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  /// Checkbox form field
  static Widget appCheckboxFormField({
    required String label,
    required bool value,
    ValueChanged<bool?>? onChanged,
    String? helperText,
    String? errorText,
    bool isRequired = false,
    bool enabled = true,
    EdgeInsets? padding,
    Color? activeColor,
  }) {
    return appFormField(
      label: '',
      helperText: helperText,
      errorText: errorText,
      isRequired: isRequired,
      padding: padding,
      field: Row(
        children: [
          Checkbox(
            value: value,
            onChanged: (enabled && onChanged != null) ? onChanged : null,
            activeColor: activeColor ?? DSColors.primaryApp,
          ),
          Expanded(
            child: GestureDetector(
              onTap: (enabled && onChanged != null) ? () => onChanged(!value) : null,
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      label,
                      style: DSTypography.appTextTheme.bodyMedium?.copyWith(
                        color: enabled ? DSColors.textPrimary : DSColors.textDisabled,
                      ),
                    ),
                  ),
                  if (isRequired) ...[
                    const SizedBox(width: 4),
                    Text(
                      '*',
                      style: DSTypography.appTextTheme.bodyMedium?.copyWith(
                        color: DSColors.errorApp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Radio button form field
  static Widget appRadioFormField<T>({
    required String label,
    required T value,
    required T groupValue,
    ValueChanged<T?>? onChanged,
    String? helperText,
    String? errorText,
    bool isRequired = false,
    bool enabled = true,
    EdgeInsets? padding,
    Color? activeColor,
  }) {
    return appFormField(
      label: '',
      helperText: helperText,
      errorText: errorText,
      isRequired: isRequired,
      padding: padding,
      field: Row(
        children: [
          Radio<T>(
            value: value,
            groupValue: groupValue,
            onChanged: (enabled && onChanged != null) ? onChanged : null,
            activeColor: activeColor ?? DSColors.primaryApp,
          ),
          Expanded(
            child: GestureDetector(
              onTap: (enabled && onChanged != null) ? () => onChanged(value) : null,
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      label,
                      style: DSTypography.appTextTheme.bodyMedium?.copyWith(
                        color: enabled ? DSColors.textPrimary : DSColors.textDisabled,
                      ),
                    ),
                  ),
                  if (isRequired) ...[
                    const SizedBox(width: 4),
                    Text(
                      '*',
                      style: DSTypography.appTextTheme.bodyMedium?.copyWith(
                        color: DSColors.errorApp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Radio group form field
  static Widget appRadioGroupFormField<T>({
    required String label,
    required T groupValue,
    required List<RadioOption<T>> options,
    ValueChanged<T?>? onChanged,
    String? helperText,
    String? errorText,
    bool isRequired = false,
    bool enabled = true,
    EdgeInsets? padding,
    Color? activeColor,
    Axis direction = Axis.vertical,
    double spacing = 8,
  }) {
    return appFormField(
      label: label,
      helperText: helperText,
      errorText: errorText,
      isRequired: isRequired,
      padding: padding,
      field: direction == Axis.vertical
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < options.length; i++) ...[
                  appRadioFormField<T>(
                    label: options[i].label,
                    value: options[i].value,
                    groupValue: groupValue,
                    onChanged: onChanged,
                    enabled: enabled && (options[i].enabled ?? true),
                    activeColor: activeColor,
                    padding: EdgeInsets.only(
                      bottom: i < options.length - 1 ? spacing : 0,
                    ),
                  ),
                ],
              ],
            )
          : Wrap(
              spacing: spacing,
              children: options.map((option) => SizedBox(
                child: appRadioFormField<T>(
                  label: option.label,
                  value: option.value,
                  groupValue: groupValue,
                  onChanged: onChanged,
                  enabled: enabled && (option.enabled ?? true),
                  activeColor: activeColor,
                  padding: EdgeInsets.zero,
                ),
              )).toList(),
            ),
    );
  }

  /// Switch form field
  static Widget appSwitchFormField({
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
    String? helperText,
    String? errorText,
    bool isRequired = false,
    bool enabled = true,
    EdgeInsets? padding,
    Color? activeColor,
    Color? activeTrackColor,
  }) {
    return appFormField(
      label: '',
      helperText: helperText,
      errorText: errorText,
      isRequired: isRequired,
      padding: padding,
      field: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    label,
                    style: DSTypography.appTextTheme.bodyMedium?.copyWith(
                      color: enabled ? DSColors.textPrimary : DSColors.textDisabled,
                    ),
                  ),
                ),
                if (isRequired) ...[
                  const SizedBox(width: 4),
                  Text(
                    '*',
                    style: DSTypography.appTextTheme.bodyMedium?.copyWith(
                      color: DSColors.errorApp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: enabled ? onChanged : null,
            activeColor: activeColor ?? DSColors.primaryApp,
            activeTrackColor: activeTrackColor ?? DSColors.primaryApp.withValues(alpha: (0.4 * 255).toDouble()),
          ),
        ],
      ),
    );
  }

  /// Date picker form field
  static Widget appDatePickerFormField({
    required String label,
    required DateTime? selectedDate,
    required ValueChanged<DateTime> onDateSelected,
    String? helperText,
    String? errorText,
    bool isRequired = false,
    bool enabled = true,
    EdgeInsets? padding,
    EdgeInsets? contentPadding,
    BorderRadius? borderRadius,
    DateTime? firstDate,
    DateTime? lastDate,
    String dateFormat = 'MM/dd/yyyy',
    BuildContext? context,
  }) {
    final effectiveContentPadding = contentPadding ??
        const EdgeInsets.symmetric(horizontal: 16, vertical: 16);
    final effectiveBorderRadius = borderRadius ?? BorderRadius.circular(8);

    String formattedDate = '';
    if (selectedDate != null) {
      // Simple date formatting based on the format string
      // In a real app, you would use intl package for proper formatting
      formattedDate = dateFormat
          .replaceAll('MM', selectedDate.month.toString().padLeft(2, '0'))
          .replaceAll('dd', selectedDate.day.toString().padLeft(2, '0'))
          .replaceAll('yyyy', selectedDate.year.toString());
    }

    return appFormField(
      label: label,
      helperText: helperText,
      errorText: errorText,
      isRequired: isRequired,
      padding: padding,
      field: InkWell(
        onTap: enabled && context != null
            ? () async {
                final DateTime now = DateTime.now();
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: selectedDate ?? now,
                  firstDate: firstDate ?? DateTime(1900),
                  lastDate: lastDate ?? DateTime(now.year + 100),
                );
                if (picked != null && picked != selectedDate) {
                  onDateSelected(picked);
                }
              }
            : null,
        borderRadius: effectiveBorderRadius,
        child: Container(
          padding: effectiveContentPadding,
          decoration: BoxDecoration(
            color: enabled ? Colors.white : Colors.grey[100],
            borderRadius: effectiveBorderRadius,
            border: Border.all(
              color: errorText != null ? DSColors.errorApp : DSColors.divider,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  formattedDate.isEmpty ? 'Select date' : formattedDate,
                  style: DSTypography.appTextTheme.bodyLarge?.copyWith(
                    color: formattedDate.isEmpty
                        ? DSColors.textDisabled
                        : DSColors.textPrimary,
                  ),
                ),
              ),
              Icon(
                DSIcons.calendar,
                color: enabled ? DSColors.textSecondary : DSColors.textDisabled,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Form section with title
  static Widget appFormSection({
    required String title,
    required List<Widget> fields,
    String? subtitle,
    EdgeInsets? padding,
    EdgeInsets? contentPadding,
  }) {
    final effectivePadding = padding ?? const EdgeInsets.only(bottom: 24);
    final effectiveContentPadding = contentPadding ?? const EdgeInsets.only(top: 16);

    return Padding(
      padding: effectivePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: DSTypography.appTextTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          if (subtitle != null) ...[
            DSSpacing.verticalSpacerXXS,
            Text(
              subtitle,
              style: DSTypography.appTextTheme.bodyMedium?.copyWith(
                color: DSColors.textSecondary,
              ),
            ),
          ],
          Padding(
            padding: effectiveContentPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: fields,
            ),
          ),
        ],
      ),
    );
  }

  /// Form actions (buttons) container
  static Widget appFormActions({
    required List<Widget> actions,
    EdgeInsets? padding,
    MainAxisAlignment alignment = MainAxisAlignment.end,
    double spacing = 16,
  }) {
    final effectivePadding = padding ?? const EdgeInsets.only(top: 24);

    return Padding(
      padding: effectivePadding,
      child: Row(
        mainAxisAlignment: alignment,
        children: [
          for (int i = 0; i < actions.length; i++) ...[
            actions[i],
            if (i < actions.length - 1) SizedBox(width: spacing),
          ],
        ],
      ),
    );
  }

  /// Login form
  static Widget appLoginForm({
    required BuildContext context,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required VoidCallback onLogin,
    String? emailError,
    String? passwordError,
    bool isLoading = false,
    VoidCallback? onForgotPassword,
    String loginButtonText = 'Log In',
    String forgotPasswordText = 'Forgot Password?',
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        appTextFormField(
          label: 'Email',
          hint: 'Enter your email',
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          errorText: emailError,
          isRequired: true,
          context: context,
        ),
        appPasswordFormField(
          label: 'Password',
          hint: 'Enter your password',
          controller: passwordController,
          errorText: passwordError,
          isRequired: true,
          context: context,
        ),
        if (onForgotPassword != null) ...[
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: onForgotPassword,
              child: Text(forgotPasswordText),
            ),
          ),
        ],
        DSSpacing.verticalSpacerMD,
        SizedBox(
          width: double.infinity,
          child: DSButtons.primaryAppButton(
            text: loginButtonText,
            onPressed: onLogin,
            isLoading: isLoading,
            isFullWidth: true,
            context: context,
          ),
        ),
      ],
    );
  }

  /// Registration form
  static Widget appRegistrationForm({
    required BuildContext context,
    required TextEditingController nameController,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required TextEditingController confirmPasswordController,
    required VoidCallback onRegister,
    String? nameError,
    String? emailError,
    String? passwordError,
    String? confirmPasswordError,
    bool isLoading = false,
    bool termsAccepted = false,
    ValueChanged<bool?>? onTermsChanged,
    VoidCallback? onTermsLinkTap,
    String registerButtonText = 'Register',
    String termsText = 'I agree to the Terms and Conditions',
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        appTextFormField(
          label: 'Full Name',
          hint: 'Enter your full name',
          controller: nameController,
          textInputAction: TextInputAction.next,
          errorText: nameError,
          isRequired: true,
          context: context,
        ),
        appTextFormField(
          label: 'Email',
          hint: 'Enter your email',
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          errorText: emailError,
          isRequired: true,
          context: context,
        ),
        appPasswordFormField(
          label: 'Password',
          hint: 'Enter your password',
          controller: passwordController,
          textInputAction: TextInputAction.next,
          errorText: passwordError,
          isRequired: true,
          context: context,
        ),
        appPasswordFormField(
          label: 'Confirm Password',
          hint: 'Confirm your password',
          controller: confirmPasswordController,
          errorText: confirmPasswordError,
          isRequired: true,
          context: context,
        ),
        if (onTermsChanged != null) ...[
          DSSpacing.verticalSpacerSM,
          appCheckboxFormField(
            label: termsText,
            value: termsAccepted,
            onChanged: onTermsChanged,
            isRequired: true,
          ),
        ],
        DSSpacing.verticalSpacerLG,
        SizedBox(
          width: double.infinity,
          child: DSButtons.primaryAppButton(
            text: registerButtonText,
            onPressed: onRegister,
            isLoading: isLoading,
            isFullWidth: true,
            context: context,
          ),
        ),
      ],
    );
  }
}

/// Radio option for radio group form field
class RadioOption<T> {
  final String label;
  final T value;
  final bool? enabled;

  RadioOption({
    required this.label,
    required this.value,
    this.enabled,
  });
}
