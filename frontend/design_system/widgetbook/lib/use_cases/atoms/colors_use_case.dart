import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

class AppColorsShowcase extends StatelessWidget {
  const AppColorsShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'App Theme Colors',
            style: DSTypography.appTextTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          _buildColorGrid([
            _ColorItem('Primary', DSColors.primaryApp),
            _ColorItem('Secondary', DSColors.secondaryApp),
            _ColorItem('Accent', DSColors.accentApp),
            _ColorItem('Background', DSColors.backgroundApp),
            _ColorItem('Surface', DSColors.surfaceApp),
            _ColorItem('Error', DSColors.errorApp),
            _ColorItem('Success', DSColors.successApp),
            _ColorItem('Warning', DSColors.warningApp),
            _ColorItem('Info', DSColors.infoApp),
          ]),
          const SizedBox(height: 32),
          Text(
            'Text Colors',
            style: DSTypography.appTextTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          _buildColorGrid([
            _ColorItem('Text Primary', DSColors.textPrimary),
            _ColorItem('Text Secondary', DSColors.textSecondary),
            _ColorItem('Text Disabled', DSColors.textDisabled),
            _ColorItem('Text On Primary', DSColors.textOnPrimary),
            _ColorItem('Text On Secondary', DSColors.textOnSecondary),
          ]),
          const SizedBox(height: 32),
          Text(
            'Common Colors',
            style: DSTypography.appTextTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          _buildColorGrid([
            _ColorItem('Divider', DSColors.divider),
            _ColorItem('Shadow', DSColors.shadow),
            _ColorItem('Overlay', DSColors.overlay),
          ]),
          const SizedBox(height: 32),
          Text(
            'Primary Swatch',
            style: DSTypography.appTextTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          _buildColorGrid([
            _ColorItem('50', DSColors.appPrimarySwatch[50]!),
            _ColorItem('100', DSColors.appPrimarySwatch[100]!),
            _ColorItem('200', DSColors.appPrimarySwatch[200]!),
            _ColorItem('300', DSColors.appPrimarySwatch[300]!),
            _ColorItem('400', DSColors.appPrimarySwatch[400]!),
            _ColorItem('500', DSColors.appPrimarySwatch[500]!),
            _ColorItem('600', DSColors.appPrimarySwatch[600]!),
            _ColorItem('700', DSColors.appPrimarySwatch[700]!),
            _ColorItem('800', DSColors.appPrimarySwatch[800]!),
            _ColorItem('900', DSColors.appPrimarySwatch[900]!),
          ]),
        ],
      ),
    );
  }

  Widget _buildColorGrid(List<_ColorItem> colors) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: colors.length,
      itemBuilder: (context, index) {
        final color = colors[index];
        return _ColorCard(
          name: color.name,
          color: color.color,
        );
      },
    );
  }
}

class LandingColorsShowcase extends StatelessWidget {
  const LandingColorsShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Landing Theme Colors',
            style: DSTypography.appTextTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          _buildColorGrid([
            _ColorItem('Primary', DSColors.primaryLanding),
            _ColorItem('Secondary', DSColors.secondaryLanding),
            _ColorItem('Accent', DSColors.accentLanding),
            _ColorItem('Background', DSColors.backgroundLanding),
            _ColorItem('Surface', DSColors.surfaceLanding),
            _ColorItem('Error', DSColors.errorLanding),
            _ColorItem('Success', DSColors.successLanding),
            _ColorItem('Warning', DSColors.warningLanding),
            _ColorItem('Info', DSColors.infoLanding),
          ]),
          const SizedBox(height: 32),
          Text(
            'Primary Swatch',
            style: DSTypography.appTextTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          _buildColorGrid([
            _ColorItem('50', DSColors.landingPrimarySwatch[50]!),
            _ColorItem('100', DSColors.landingPrimarySwatch[100]!),
            _ColorItem('200', DSColors.landingPrimarySwatch[200]!),
            _ColorItem('300', DSColors.landingPrimarySwatch[300]!),
            _ColorItem('400', DSColors.landingPrimarySwatch[400]!),
            _ColorItem('500', DSColors.landingPrimarySwatch[500]!),
            _ColorItem('600', DSColors.landingPrimarySwatch[600]!),
            _ColorItem('700', DSColors.landingPrimarySwatch[700]!),
            _ColorItem('800', DSColors.landingPrimarySwatch[800]!),
            _ColorItem('900', DSColors.landingPrimarySwatch[900]!),
          ]),
          const SizedBox(height: 32),
          Text(
            'Gradients',
            style: DSTypography.appTextTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _GradientCard(
                  name: 'Primary Gradient',
                  gradient: DSColors.primaryGradient,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _GradientCard(
                  name: 'Landing Gradient',
                  gradient: DSColors.landingGradient,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildColorGrid(List<_ColorItem> colors) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: colors.length,
      itemBuilder: (context, index) {
        final color = colors[index];
        return _ColorCard(
          name: color.name,
          color: color.color,
        );
      },
    );
  }
}

class _ColorItem {
  final String name;
  final Color color;

  _ColorItem(this.name, this.color);
}

class _ColorCard extends StatelessWidget {
  final String name;
  final Color color;

  const _ColorCard({
    required this.name,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = _getContrastColor(color);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '#${color.toARGB32().toRadixString(16).substring(2).toUpperCase()}',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Color _getContrastColor(Color backgroundColor) {
    // Calculate the perceived brightness of the background color
    final brightness = backgroundColor.computeLuminance();
    
    // Return white for dark backgrounds, black for light backgrounds
    return brightness > 0.5 ? Colors.black : Colors.white;
  }
}

class _GradientCard extends StatelessWidget {
  final String name;
  final LinearGradient gradient;

  const _GradientCard({
    required this.name,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 100,
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
