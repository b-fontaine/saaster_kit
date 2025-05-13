import 'package:widgetbook/widgetbook.dart';

import 'colors_use_case.dart';
import 'typography_use_case.dart';
import 'spacing_use_case.dart';
import 'borders_use_case.dart';
import 'shadows_use_case.dart';
import 'icons_use_case.dart';

final colorUseCases = [
  WidgetbookUseCase(
    name: 'App Colors',
    builder: (context) => const AppColorsShowcase(),
  ),
  WidgetbookUseCase(
    name: 'Landing Colors',
    builder: (context) => const LandingColorsShowcase(),
  ),
];

final typographyUseCases = [
  WidgetbookUseCase(
    name: 'App Typography',
    builder: (context) => const AppTypographyShowcase(),
  ),
  WidgetbookUseCase(
    name: 'Landing Typography',
    builder: (context) => const LandingTypographyShowcase(),
  ),
];

final spacingUseCases = [
  WidgetbookUseCase(
    name: 'Spacing Values',
    builder: (context) => const SpacingValuesShowcase(),
  ),
  WidgetbookUseCase(
    name: 'Spacing Widgets',
    builder: (context) => const SpacingWidgetsShowcase(),
  ),
];

final borderUseCases = [
  WidgetbookUseCase(
    name: 'Border Radius',
    builder: (context) => const BorderRadiusShowcase(),
  ),
  WidgetbookUseCase(
    name: 'Border Styles',
    builder: (context) => const BorderStylesShowcase(),
  ),
];

final shadowUseCases = [
  WidgetbookUseCase(
    name: 'Elevation Shadows',
    builder: (context) => const ElevationShadowsShowcase(),
  ),
  WidgetbookUseCase(
    name: 'Component Shadows',
    builder: (context) => const ComponentShadowsShowcase(),
  ),
];

final iconUseCases = [
  WidgetbookUseCase(
    name: 'Icon Gallery',
    builder: (context) => const IconGalleryShowcase(),
  ),
  WidgetbookUseCase(
    name: 'Icon Sizes',
    builder: (context) => const IconSizesShowcase(),
  ),
];
