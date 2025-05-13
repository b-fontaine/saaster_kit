import 'package:design_system/design_system.dart';
import 'package:design_system_widgetbook/use_cases/organisms/organisms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:widgetbook/widgetbook.dart';

// Import atom use cases
import 'use_cases/atoms/borders_use_case.dart';
import 'use_cases/atoms/colors_use_case.dart';
import 'use_cases/atoms/icons_use_case.dart';
import 'use_cases/atoms/shadows_use_case.dart';
import 'use_cases/atoms/spacing_use_case.dart';
import 'use_cases/atoms/typography_use_case.dart';
// Import molecule use cases
import 'use_cases/molecules/buttons_use_case.dart';
import 'use_cases/molecules/cards_use_case.dart';
import 'use_cases/molecules/chips_use_case.dart';
import 'use_cases/molecules/dialogs_use_case.dart';
import 'use_cases/molecules/text_fields_use_case.dart';

void main() {
  runApp(const DesignSystemWidgetbook());
}

class DesignSystemWidgetbook extends StatelessWidget {
  const DesignSystemWidgetbook({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      directories: [
        // Atoms
        WidgetbookCategory(
          name: 'Atoms',
          children: [
            WidgetbookComponent(
              name: 'Colors',
              useCases: [
                WidgetbookUseCase(
                  name: 'App Colors',
                  builder: (context) => const AppColorsShowcase(),
                ),
                WidgetbookUseCase(
                  name: 'Landing Colors',
                  builder: (context) => const LandingColorsShowcase(),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'Typography',
              useCases: [
                WidgetbookUseCase(
                  name: 'App Typography',
                  builder: (context) => const AppTypographyShowcase(),
                ),
                WidgetbookUseCase(
                  name: 'Landing Typography',
                  builder: (context) => const LandingTypographyShowcase(),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'Spacing',
              useCases: [
                WidgetbookUseCase(
                  name: 'Spacing Values',
                  builder: (context) => const SpacingValuesShowcase(),
                ),
                WidgetbookUseCase(
                  name: 'Spacing Widgets',
                  builder: (context) => const SpacingWidgetsShowcase(),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'Borders',
              useCases: [
                WidgetbookUseCase(
                  name: 'Border Radius',
                  builder: (context) => const BorderRadiusShowcase(),
                ),
                WidgetbookUseCase(
                  name: 'Border Styles',
                  builder: (context) => const BorderStylesShowcase(),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'Shadows',
              useCases: [
                WidgetbookUseCase(
                  name: 'Elevation Shadows',
                  builder: (context) => const ElevationShadowsShowcase(),
                ),
                WidgetbookUseCase(
                  name: 'Component Shadows',
                  builder: (context) => const ComponentShadowsShowcase(),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'Icons',
              useCases: [
                WidgetbookUseCase(
                  name: 'Icon Gallery',
                  builder: (context) => const IconGalleryShowcase(),
                ),
                WidgetbookUseCase(
                  name: 'Icon Sizes',
                  builder: (context) => const IconSizesShowcase(),
                ),
              ],
            ),
          ],
        ),

        // Molecules
        WidgetbookCategory(
          name: 'Molecules',
          children: [
            WidgetbookComponent(
              name: 'Buttons',
              useCases: [
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
              ],
            ),
            WidgetbookComponent(
              name: 'Text Fields',
              useCases: [
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
              ],
            ),
            WidgetbookComponent(
              name: 'Cards',
              useCases: [
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
              ],
            ),
            WidgetbookComponent(
              name: 'Chips',
              useCases: [
                WidgetbookUseCase(
                  name: 'App Chips',
                  builder: (context) => const AppChipsShowcase(),
                ),
                WidgetbookUseCase(
                  name: 'Landing Chips',
                  builder: (context) => const LandingChipsShowcase(),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'Dialogs',
              useCases: [
                WidgetbookUseCase(
                  name: 'App Dialogs',
                  builder: (context) => const AppDialogsShowcase(),
                ),
                WidgetbookUseCase(
                  name: 'Landing Dialogs',
                  builder: (context) => const LandingDialogsShowcase(),
                ),
              ],
            ),
          ],
        ),

        // Organisms
        WidgetbookCategory(
          name: 'Organisms',
          children: [
            WidgetbookComponent(name: 'App Bars', useCases: appBarUseCases),
            WidgetbookComponent(name: 'Forms', useCases: formUseCases),
            WidgetbookComponent(name: 'Lists', useCases: listUseCases),
            WidgetbookComponent(name: 'Navigation', useCases: navigationUseCases),
          ],
        ),
      ],
      addons: [
        // Theme addon for switching between themes
        MaterialThemeAddon(
          themes: [
            WidgetbookTheme(name: 'App Light', data: AppTheme.lightTheme),
            WidgetbookTheme(name: 'App Dark', data: AppTheme.darkTheme),
            WidgetbookTheme(
              name: 'Landing Light',
              data: LandingTheme.lightTheme,
            ),
            WidgetbookTheme(name: 'Landing Dark', data: LandingTheme.darkTheme),
          ],
        ),
        // Device frame addon for responsive testing
        DeviceFrameAddon(
          devices: [
            Devices.ios.iPhone13,
            Devices.ios.iPadPro11Inches,
            Devices.macOS.macBookPro,
          ],
        ),
        // Text scale addon for accessibility testing
        TextScaleAddon(scales: [1.0, 1.2, 1.5, 2.0]),
        // Localization addon
        LocalizationAddon(
          locales: const [Locale('en', 'US'), Locale('fr', 'FR')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        ),
        // Grid addon for layout debugging
        GridAddon(),
        // Inspector addon for widget inspection
        InspectorAddon(),
      ],
      appBuilder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en', 'US'), Locale('fr', 'FR')],
          home: child,
        );
      },
    );
  }
}
