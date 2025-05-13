import 'package:widgetbook/widgetbook.dart';

import 'buttons_use_case.dart';
import 'text_fields_use_case.dart';
import 'cards_use_case.dart';
import 'chips_use_case.dart';
import 'dialogs_use_case.dart';

final buttonUseCases = [
  WidgetbookUseCase(
    name: 'App Buttons',
    builder: (context) => const AppButtonsShowcase(),
  ),
  WidgetbookUseCase(
    name: 'Landing Buttons',
    builder: (context) => const LandingButtonsShowcase(),
  ),
  WidgetbookUseCase(
    name: 'Icon Buttons',
    builder: (context) => const IconButtonsShowcase(),
  ),
];

final textFieldUseCases = [
  WidgetbookUseCase(
    name: 'App Text Fields',
    builder: (context) => const AppTextFieldsShowcase(),
  ),
  WidgetbookUseCase(
    name: 'Landing Text Fields',
    builder: (context) => const LandingTextFieldsShowcase(),
  ),
  WidgetbookUseCase(
    name: 'Special Text Fields',
    builder: (context) => const SpecialTextFieldsShowcase(),
  ),
];

final cardUseCases = [
  WidgetbookUseCase(
    name: 'App Cards',
    builder: (context) => const AppCardsShowcase(),
  ),
  WidgetbookUseCase(
    name: 'Landing Cards',
    builder: (context) => const LandingCardsShowcase(),
  ),
  WidgetbookUseCase(
    name: 'Feature Cards',
    builder: (context) => const FeatureCardsShowcase(),
  ),
];

final chipUseCases = [
  WidgetbookUseCase(
    name: 'App Chips',
    builder: (context) => const AppChipsShowcase(),
  ),
  WidgetbookUseCase(
    name: 'Landing Chips',
    builder: (context) => const LandingChipsShowcase(),
  ),
];

final dialogUseCases = [
  WidgetbookUseCase(
    name: 'App Dialogs',
    builder: (context) => const AppDialogsShowcase(),
  ),
  WidgetbookUseCase(
    name: 'Landing Dialogs',
    builder: (context) => const LandingDialogsShowcase(),
  ),
];
