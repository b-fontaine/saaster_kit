# Design System Widgetbook

A comprehensive showcase and documentation of the design system components using Widgetbook.

## Overview

This Widgetbook provides an interactive way to explore, test, and document all the components in the design system. It follows the atomic design pattern, organizing components into:

- **Atoms**: Basic building blocks (colors, typography, spacing, etc.)
- **Molecules**: Simple combinations of atoms (buttons, cards, text fields, etc.)
- **Organisms**: Complex UI components (navigation, forms, lists, etc.)
- **Templates**: Page-level layouts and patterns

## Features

- **Interactive Component Gallery**: Browse and interact with all design system components
- **Theme Switching**: Toggle between application and landing themes
- **Responsive Testing**: Preview components at different screen sizes
- **Accessibility Testing**: Test components with different text scales
- **Component Documentation**: View usage examples and code snippets

## Getting Started

### Running the Widgetbook

1. Navigate to the widgetbook directory:
   ```bash
   cd frontend/design_system/widgetbook
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the Widgetbook:
   ```bash
   flutter run -d chrome
   ```

### Structure

The Widgetbook is organized according to the atomic design pattern:

```
lib/
├── main.dart                # Entry point
├── use_cases/               # Component showcases
│   ├── atoms/               # Basic building blocks
│   ├── molecules/           # Simple components
│   ├── organisms/           # Complex components
│   └── templates/           # Layout patterns
```

## Adding New Components

To add a new component to the Widgetbook:

1. Create a new use case file in the appropriate directory
2. Add the component showcase to the corresponding index file
3. Update the main.dart file if needed

Example:

```dart
// lib/use_cases/molecules/my_component_use_case.dart
import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

class MyComponentShowcase extends StatelessWidget {
  const MyComponentShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Component',
            style: DSTypography.appTextTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          // Component showcase
        ],
      ),
    );
  }
}
```

Then add it to the index file:

```dart
// lib/use_cases/molecules/molecules.dart
final myComponentUseCases = [
  WidgetbookUseCase(
    name: 'My Component',
    builder: (context) => const MyComponentShowcase(),
  ),
];
```

## Addons

The Widgetbook includes several addons to enhance the development experience:

- **Theme Addon**: Switch between different themes
- **Device Frame Addon**: Preview components on different devices
- **Text Scale Addon**: Test components with different text scales
- **Localization Addon**: Test components with different locales
- **Grid Addon**: Visualize layout grids
- **Inspector Addon**: Inspect widget properties

## Dependencies

- `flutter`: The Flutter SDK
- `design_system`: The design system package
- `widgetbook`: For component showcasing
- `widgetbook_annotation`: For code generation
- `google_fonts`: For typography
- `flutter_svg`: For SVG support
- `device_info_plus`: For platform-specific adaptations
- `responsive_framework`: For responsive layouts