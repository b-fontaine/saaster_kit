import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

/// Showcase for basic form fields
class BasicFormFieldsShowcase extends StatefulWidget {
  const BasicFormFieldsShowcase({super.key});

  @override
  State<BasicFormFieldsShowcase> createState() => _BasicFormFieldsShowcaseState();
}

class _BasicFormFieldsShowcaseState extends State<BasicFormFieldsShowcase> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _dropdownValue;
  bool _checkboxValue = false;
  String _radioGroupValue = 'option1';
  bool _switchValue = false;
  DateTime? _selectedDate;

  @override
  void dispose() {
    _textController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Basic Form Fields',
              style: DSTypography.appTextTheme.titleLarge,
            ),
            const SizedBox(height: 24),
            
            // Text Form Field
            DSForms.appTextFormField(
              label: 'Text Input',
              hint: 'Enter some text',
              helperText: 'This is a standard text input field',
              controller: _textController,
              context: context,
            ),
            
            // Text Form Field with Error
            DSForms.appTextFormField(
              label: 'Text Input with Error',
              hint: 'Enter some text',
              errorText: 'This field is required',
              isRequired: true,
              context: context,
            ),
            
            // Password Form Field
            DSForms.appPasswordFormField(
              label: 'Password',
              hint: 'Enter your password',
              helperText: 'Your password should be at least 8 characters',
              controller: _passwordController,
              isRequired: true,
              context: context,
            ),
            
            // Dropdown Form Field
            DSForms.appDropdownFormField<String>(
              label: 'Dropdown',
              value: _dropdownValue,
              hint: 'Select an option',
              items: const [
                DropdownMenuItem(value: 'option1', child: Text('Option 1')),
                DropdownMenuItem(value: 'option2', child: Text('Option 2')),
                DropdownMenuItem(value: 'option3', child: Text('Option 3')),
              ],
              onChanged: (value) {
                setState(() {
                  _dropdownValue = value;
                });
              },
            ),
            
            // Checkbox Form Field
            DSForms.appCheckboxFormField(
              label: 'Checkbox option',
              value: _checkboxValue,
              onChanged: (value) {
                setState(() {
                  _checkboxValue = value ?? false;
                });
              },
              helperText: 'This is a checkbox form field',
            ),
            
            // Radio Group Form Field
            DSForms.appRadioGroupFormField<String>(
              label: 'Radio Group',
              groupValue: _radioGroupValue,
              options: [
                RadioOption(label: 'Option 1', value: 'option1'),
                RadioOption(label: 'Option 2', value: 'option2'),
                RadioOption(label: 'Option 3', value: 'option3'),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _radioGroupValue = value;
                  });
                }
              },
              helperText: 'Select one option',
            ),
            
            // Switch Form Field
            DSForms.appSwitchFormField(
              label: 'Switch option',
              value: _switchValue,
              onChanged: (value) {
                setState(() {
                  _switchValue = value;
                });
              },
              helperText: 'This is a switch form field',
            ),
            
            // Date Picker Form Field
            DSForms.appDatePickerFormField(
              label: 'Date',
              selectedDate: _selectedDate,
              onDateSelected: (date) {
                setState(() {
                  _selectedDate = date;
                });
              },
              helperText: 'Select a date',
              context: context,
            ),
          ],
        ),
      ),
    );
  }
}

/// Showcase for form sections and layouts
class FormSectionsShowcase extends StatelessWidget {
  const FormSectionsShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Form Sections and Layouts',
              style: DSTypography.appTextTheme.titleLarge,
            ),
            const SizedBox(height: 24),
            
            // Form Section
            DSForms.appFormSection(
              title: 'Personal Information',
              subtitle: 'Please provide your personal details',
              fields: [
                DSForms.appTextFormField(
                  label: 'Full Name',
                  hint: 'Enter your full name',
                  isRequired: true,
                  context: context,
                ),
                DSForms.appTextFormField(
                  label: 'Email',
                  hint: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  isRequired: true,
                  context: context,
                ),
                DSForms.appTextFormField(
                  label: 'Phone Number',
                  hint: 'Enter your phone number',
                  keyboardType: TextInputType.phone,
                  context: context,
                ),
              ],
            ),
            
            // Another Form Section
            DSForms.appFormSection(
              title: 'Address',
              fields: [
                DSForms.appTextFormField(
                  label: 'Street Address',
                  hint: 'Enter your street address',
                  context: context,
                ),
                DSForms.appTextFormField(
                  label: 'City',
                  hint: 'Enter your city',
                  context: context,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: DSForms.appTextFormField(
                        label: 'State',
                        hint: 'Enter state',
                        context: context,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: DSForms.appTextFormField(
                        label: 'Zip Code',
                        hint: 'Enter zip code',
                        keyboardType: TextInputType.number,
                        context: context,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            
            // Form Actions
            DSForms.appFormActions(
              actions: [
                DSButtons.secondaryAppButton(
                  text: 'Cancel',
                  onPressed: () {},
                ),
                DSButtons.primaryAppButton(
                  text: 'Submit',
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Showcase for login and registration forms
class AuthFormsShowcase extends StatefulWidget {
  const AuthFormsShowcase({super.key});

  @override
  State<AuthFormsShowcase> createState() => _AuthFormsShowcaseState();
}

class _AuthFormsShowcaseState extends State<AuthFormsShowcase> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _termsAccepted = false;
  bool _isLoginView = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Authentication Forms',
              style: DSTypography.appTextTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                DSButtons.textAppButton(
                  text: 'Login Form',
                  onPressed: () {
                    setState(() {
                      _isLoginView = true;
                    });
                  },
                ),
                DSButtons.textAppButton(
                  text: 'Registration Form',
                  onPressed: () {
                    setState(() {
                      _isLoginView = false;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            if (_isLoginView)
              // Login Form
              DSForms.appLoginForm(
                context: context,
                emailController: _emailController,
                passwordController: _passwordController,
                onLogin: () {},
                onForgotPassword: () {},
              )
            else
              // Registration Form
              DSForms.appRegistrationForm(
                context: context,
                nameController: _nameController,
                emailController: _emailController,
                passwordController: _passwordController,
                confirmPasswordController: _confirmPasswordController,
                onRegister: () {},
                termsAccepted: _termsAccepted,
                onTermsChanged: (value) {
                  setState(() {
                    _termsAccepted = value ?? false;
                  });
                },
              ),
          ],
        ),
      ),
    );
  }
}

/// Showcase for form field variants
class FormFieldVariantsShowcase extends StatefulWidget {
  const FormFieldVariantsShowcase({super.key});

  @override
  State<FormFieldVariantsShowcase> createState() => _FormFieldVariantsShowcaseState();
}

class _FormFieldVariantsShowcaseState extends State<FormFieldVariantsShowcase> {
  String _horizontalRadioValue = 'option1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Form Field Variants',
              style: DSTypography.appTextTheme.titleLarge,
            ),
            const SizedBox(height: 24),
            
            // Text Form Field with Prefix Icon
            DSForms.appTextFormField(
              label: 'Email',
              hint: 'Enter your email',
              prefixIcon: DSIcons.email,
              keyboardType: TextInputType.emailAddress,
              context: context,
            ),
            
            // Text Form Field with Suffix Icon
            DSForms.appTextFormField(
              label: 'Search',
              hint: 'Search...',
              suffixIcon: DSIcons.search,
              context: context,
            ),
            
            // Disabled Text Form Field
            DSForms.appTextFormField(
              label: 'Disabled Field',
              hint: 'This field is disabled',
              enabled: false,
              context: context,
            ),
            
            // Read-only Text Form Field
            DSForms.appTextFormField(
              label: 'Read-only Field',
              hint: 'This field is read-only',
              readOnly: true,
              controller: TextEditingController(text: 'Read-only content'),
              context: context,
            ),
            
            // Multiline Text Form Field
            DSForms.appTextFormField(
              label: 'Multiline Input',
              hint: 'Enter multiple lines of text',
              maxLines: 3,
              context: context,
            ),
            
            // Horizontal Radio Group
            DSForms.appRadioGroupFormField<String>(
              label: 'Horizontal Radio Group',
              groupValue: _horizontalRadioValue,
              options: [
                RadioOption(label: 'Option 1', value: 'option1'),
                RadioOption(label: 'Option 2', value: 'option2'),
                RadioOption(label: 'Option 3', value: 'option3'),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _horizontalRadioValue = value;
                  });
                }
              },
              direction: Axis.horizontal,
              spacing: 16,
            ),
            
            // Disabled Checkbox
            DSForms.appCheckboxFormField(
              label: 'Disabled Checkbox',
              value: true,
              onChanged: null,
              enabled: false,
            ),
            
            // Custom Color Switch
            DSForms.appSwitchFormField(
              label: 'Custom Color Switch',
              value: true,
              onChanged: (value) {},
              activeColor: DSColors.secondaryApp,
              activeTrackColor: DSColors.secondaryApp.withOpacity(0.4),
            ),
          ],
        ),
      ),
    );
  }
}

/// Showcase for form validation
class FormValidationShowcase extends StatefulWidget {
  const FormValidationShowcase({super.key});

  @override
  State<FormValidationShowcase> createState() => _FormValidationShowcaseState();
}

class _FormValidationShowcaseState extends State<FormValidationShowcase> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  String? _nameError;
  String? _emailError;
  String? _passwordError;
  String? _dropdownError;
  String? _checkboxError;
  
  String? _dropdownValue;
  bool _checkboxValue = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateForm() {
    // Reset errors
    setState(() {
      _nameError = null;
      _emailError = null;
      _passwordError = null;
      _dropdownError = null;
      _checkboxError = null;
    });
    
    // Validate fields
    bool isValid = true;
    
    if (_nameController.text.isEmpty) {
      setState(() {
        _nameError = 'Name is required';
      });
      isValid = false;
    }
    
    if (_emailController.text.isEmpty) {
      setState(() {
        _emailError = 'Email is required';
      });
      isValid = false;
    } else if (!_emailController.text.contains('@')) {
      setState(() {
        _emailError = 'Please enter a valid email address';
      });
      isValid = false;
    }
    
    if (_passwordController.text.isEmpty) {
      setState(() {
        _passwordError = 'Password is required';
      });
      isValid = false;
    } else if (_passwordController.text.length < 8) {
      setState(() {
        _passwordError = 'Password must be at least 8 characters';
      });
      isValid = false;
    }
    
    if (_dropdownValue == null) {
      setState(() {
        _dropdownError = 'Please select an option';
      });
      isValid = false;
    }
    
    if (!_checkboxValue) {
      setState(() {
        _checkboxError = 'You must accept the terms';
      });
      isValid = false;
    }
    
    if (isValid) {
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Form submitted successfully!'),
          backgroundColor: DSColors.successApp,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Form Validation',
                style: DSTypography.appTextTheme.titleLarge,
              ),
              const SizedBox(height: 24),
              
              DSForms.appTextFormField(
                label: 'Full Name',
                hint: 'Enter your full name',
                controller: _nameController,
                errorText: _nameError,
                isRequired: true,
                context: context,
              ),
              
              DSForms.appTextFormField(
                label: 'Email',
                hint: 'Enter your email',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                errorText: _emailError,
                isRequired: true,
                context: context,
              ),
              
              DSForms.appPasswordFormField(
                label: 'Password',
                hint: 'Enter your password',
                controller: _passwordController,
                errorText: _passwordError,
                helperText: 'Password must be at least 8 characters',
                isRequired: true,
                context: context,
              ),
              
              DSForms.appDropdownFormField<String>(
                label: 'Country',
                value: _dropdownValue,
                hint: 'Select your country',
                items: const [
                  DropdownMenuItem(value: 'us', child: Text('United States')),
                  DropdownMenuItem(value: 'ca', child: Text('Canada')),
                  DropdownMenuItem(value: 'uk', child: Text('United Kingdom')),
                  DropdownMenuItem(value: 'au', child: Text('Australia')),
                ],
                onChanged: (value) {
                  setState(() {
                    _dropdownValue = value;
                  });
                },
                errorText: _dropdownError,
                isRequired: true,
              ),
              
              DSForms.appCheckboxFormField(
                label: 'I agree to the Terms and Conditions',
                value: _checkboxValue,
                onChanged: (value) {
                  setState(() {
                    _checkboxValue = value ?? false;
                  });
                },
                errorText: _checkboxError,
                isRequired: true,
              ),
              
              DSForms.appFormActions(
                actions: [
                  DSButtons.secondaryAppButton(
                    text: 'Reset',
                    onPressed: () {
                      setState(() {
                        _nameController.clear();
                        _emailController.clear();
                        _passwordController.clear();
                        _dropdownValue = null;
                        _checkboxValue = false;
                        _nameError = null;
                        _emailError = null;
                        _passwordError = null;
                        _dropdownError = null;
                        _checkboxError = null;
                      });
                    },
                  ),
                  DSButtons.primaryAppButton(
                    text: 'Submit',
                    onPressed: _validateForm,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
