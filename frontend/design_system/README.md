# Design System

A comprehensive Flutter design system using Material UI and atomic design pattern with responsive and adaptive components.

## Overview

This design system provides a collection of reusable UI components organized according to the atomic design methodology. It includes two themes:

- **Application Theme**: For the main application UI
- **Landing Theme**: For marketing and landing pages

## Features

- **Material Design**: Built on top of Flutter's Material Design implementation
- **Atomic Design Pattern**: Components organized as atoms, molecules, organisms, and templates
- **Responsive & Adaptive**: All components adapt to different screen sizes and platforms
- **Theming**: Consistent theming with light and dark mode support
- **Accessibility**: Components designed with accessibility in mind

## Structure

The design system follows the atomic design pattern:

- **Atoms**: Basic building blocks (colors, typography, spacing, etc.)
- **Molecules**: Simple combinations of atoms (buttons, cards, text fields, etc.)
- **Organisms**: Complex UI components (navigation, forms, lists, etc.)
- **Templates**: Page-level layouts and patterns

## Usage

### Installation

Add the design system to your Flutter project:

```yaml
dependencies:
  design_system:
    path: ../design_system
```

### Import

```dart
import 'package:design_system/design_system.dart';
```

### Theming

Apply the application theme:

```dart
MaterialApp(
  theme: AppTheme.lightTheme,
  darkTheme: AppTheme.darkTheme,
  // ...
)
```

Apply the landing theme:

```dart
MaterialApp(
  theme: LandingTheme.lightTheme,
  darkTheme: LandingTheme.darkTheme,
  // ...
)
```

### Responsive Layout

Wrap your app with the responsive wrapper:

```dart
DSResponsiveLayout.responsiveWrapper(
  context: context,
  child: MaterialApp(
    // ...
  ),
)
```

Use responsive components:

```dart
DSResponsiveLayout.responsiveBuilder(
  context: context,
  mobile: MobileView(),
  tablet: TabletView(),
  desktop: DesktopView(),
)
```

### Components

#### Atoms

```dart
// Colors
DSColors.primaryApp
DSColors.primaryLanding

// Typography
DSTypography.appTextTheme.titleLarge
DSTypography.landingTextTheme.bodyMedium

// Spacing
DSSpacing.md
DSSpacing.verticalSpacerMD

// Borders
DSBorders.borderRadiusMD
DSBorders.borderAppPrimary

// Shadows
DSShadows.elevation2
DSShadows.appCardShadow

// Icons
DSIcons.home
DSIcons.getAppIcon(DSIcons.settings)
```

#### Molecules

```dart
// Buttons
DSButtons.primaryAppButton(
  text: 'Submit',
  onPressed: () {},
)

// Text Fields
DSTextFields.appTextField(
  label: 'Email',
  hint: 'Enter your email',
)

// Cards
DSCards.appCard(
  child: Text('Card content'),
)

// Chips
DSChips.appFilterChip(
  label: 'Filter',
  selected: true,
  onSelected: (selected) {},
)

// Dialogs
DSDialogs.showAppAlertDialog(
  context: context,
  title: 'Alert',
  message: 'This is an alert message',
)
```

#### Organisms

```dart
// App Bars
DSAppBars.appStandardAppBar(
  context: context,
  title: 'App Title',
)

// Navigation
DSNavigation.appBottomNavBar(
  context: context,
  items: [/* ... */],
  currentIndex: 0,
  onTap: (index) {},
)

// Forms
DSForms.appLoginForm(
  context: context,
  emailController: _emailController,
  passwordController: _passwordController,
  onLogin: () {},
)

// Lists
DSLists.appCardListItem(
  title: 'List Item',
  subtitle: 'Description',
  onTap: () {},
)
```

#### Templates

```dart
// App Scaffold
DSAppScaffold.standard(
  context: context,
  title: 'App Title',
  body: Container(),
)

// Landing Scaffold
DSLandingScaffold.standard(
  context: context,
  title: 'Company Name',
  body: Container(),
)

// Responsive Layout
DSResponsiveLayout.responsiveTwoColumnLayout(
  context: context,
  left: LeftContent(),
  right: RightContent(),
)
```

## Dependencies

- `flutter`: The Flutter SDK
- `google_fonts`: For typography
- `flutter_svg`: For SVG support
- `device_info_plus`: For platform-specific adaptations
- `responsive_framework`: For responsive layouts
