import 'package:widgetbook/widgetbook.dart';

import 'app_bar_use_case.dart';
import 'forms_use_case.dart';
import 'lists_use_case.dart';
import 'navigation_use_case.dart';

final appBarUseCases = [
  WidgetbookUseCase(
    name: 'Standard App Bar',
    builder: (context) => const StandardAppBarShowcase(),
  ),
  WidgetbookUseCase(
    name: 'Transparent App Bar',
    builder: (context) => const TransparentAppBarShowcase(),
  ),
  WidgetbookUseCase(
    name: 'Search App Bar',
    builder: (context) => const SearchAppBarShowcase(),
  ),
  WidgetbookUseCase(
    name: 'Sliver App Bar',
    builder: (context) => const SliverAppBarShowcase(),
  ),
  WidgetbookUseCase(
    name: 'Landing App Bar',
    builder: (context) => const LandingAppBarShowcase(),
  ),
  WidgetbookUseCase(
    name: 'Landing Nav App Bar',
    builder: (context) => const LandingNavAppBarShowcase(),
  ),
];

final formUseCases = [
  WidgetbookUseCase(
    name: 'Basic Form Fields',
    builder: (context) => const BasicFormFieldsShowcase(),
  ),
  WidgetbookUseCase(
    name: 'Form Sections',
    builder: (context) => const FormSectionsShowcase(),
  ),
  WidgetbookUseCase(
    name: 'Authentication Forms',
    builder: (context) => const AuthFormsShowcase(),
  ),
  WidgetbookUseCase(
    name: 'Form Field Variants',
    builder: (context) => const FormFieldVariantsShowcase(),
  ),
  WidgetbookUseCase(
    name: 'Form Validation',
    builder: (context) => const FormValidationShowcase(),
  ),
];

final listUseCases = [
  WidgetbookUseCase(
    name: 'Basic List Items',
    builder: (context) => const BasicListItemsShowcase(),
  ),
  WidgetbookUseCase(
    name: 'Sectioned Lists',
    builder: (context) => const SectionedListsShowcase(),
  ),
  WidgetbookUseCase(
    name: 'Grid Lists',
    builder: (context) => const GridListsShowcase(),
  ),
  WidgetbookUseCase(
    name: 'Horizontal Lists',
    builder: (context) => const HorizontalListsShowcase(),
  ),
  WidgetbookUseCase(
    name: 'Special Lists',
    builder: (context) => const SpecialListsShowcase(),
  ),
  WidgetbookUseCase(
    name: 'Expandable Lists',
    builder: (context) => const ExpandableListsShowcase(),
  ),
];

final navigationUseCases = [
  WidgetbookUseCase(
    name: 'Bottom Navigation Bar',
    builder: (context) => const BottomNavBarShowcase(),
  ),
  WidgetbookUseCase(
    name: 'Navigation Rail',
    builder: (context) => const NavigationRailShowcase(),
  ),
  WidgetbookUseCase(
    name: 'Drawer',
    builder: (context) => const DrawerShowcase(),
  ),
  WidgetbookUseCase(
    name: 'Tab Bar',
    builder: (context) => const TabBarShowcase(),
  ),
  WidgetbookUseCase(
    name: 'Responsive Navigation',
    builder: (context) => const ResponsiveNavigationShowcase(),
  ),
  WidgetbookUseCase(
    name: 'Breadcrumbs',
    builder: (context) => const BreadcrumbsShowcase(),
  ),
];
