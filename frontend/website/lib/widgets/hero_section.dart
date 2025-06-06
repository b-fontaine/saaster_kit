import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:url_launcher/url_launcher_string.dart';

/// Custom hero section that exactly matches the websitejs Hero component
class HeroSection extends StatelessWidget {
  final ScrollController? scrollController;

  const HeroSection({super.key, this.scrollController});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveUtils.responsiveValue<bool>(
      context: context,
      defaultValue: false,
      md: true,
    );

    return Container(
      decoration: const BoxDecoration(
        gradient:
            DSColors.landingGradient, // Updated to use design system gradient
      ),
      child: DSResponsiveLayout.responsiveContainer(
        maxWidth: 1280, // max-w-7xl
        padding: ResponsiveUtils.responsivePadding(
          context,
          defaultPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 64,
          ), // px-4 py-16
          sm: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 64,
          ), // sm:px-6 py-16
          lg: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 96,
          ), // lg:px-8 md:py-24
        ),
        child: isDesktop ? const _DesktopLayout() : const _MobileLayout(),
      ),
    );
  }
}

// Separate widget classes for better performance and reusability
class _DesktopLayout extends StatelessWidget {
  const _DesktopLayout();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center, // items-center
      children: [
        const Expanded(child: _LeftContent()),
        const SizedBox(width: 32), // gap-8
        const Expanded(child: _RightContent()),
      ],
    );
  }
}

class _MobileLayout extends StatelessWidget {
  const _MobileLayout();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _LeftContent(),
        SizedBox(height: 32),
        // Hide code preview on mobile (hidden md:block)
      ],
    );
  }
}

class _LeftContent extends StatelessWidget {
  const _LeftContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _HeroTitle(),
        const SizedBox(height: 16), // mb-4
        const _HeroDescription(),
        const SizedBox(height: 32), // mb-8
        const _ActionButtons(),
      ],
    );
  }
}

class _HeroTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Launch Your SaaS Faster with SaaSter Kit',
      style: ResponsiveUtils.responsiveValue<TextStyle>(
        context: context,
        defaultValue: DSTypography.text4Xl(context).copyWith(
          // text-4xl
          fontWeight: FontWeight.bold, // font-bold
          color: Colors.white, // text-white
          height: 1.1, // Tighter line height for headings
        ),
        md: DSTypography.text5Xl(context).copyWith(
          // md:text-5xl
          fontWeight: FontWeight.bold,
          color: Colors.white,
          height: 1.1,
        ),
      ),
    );
  }
}

class _HeroDescription extends StatelessWidget {
  const _HeroDescription();

  @override
  Widget build(BuildContext context) {
    return Text(
      'A complete, production-ready starter kit for building modern SaaS applications. Focus on your business logic, we\'ve handled the infrastructure.',
      style: DSTypography.textXl(context).copyWith(
        // text-xl
        color: const Color(0xFFE0E7FF), // text-indigo-100
        height: 1.5,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  const _ActionButtons();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16, // gap-4
      runSpacing: 16,
      children: [const _PrimaryButton(), _SecondaryButton()],
    );
  }
}

class _PrimaryButton extends StatefulWidget {
  const _PrimaryButton();

  @override
  State<_PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<_PrimaryButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200), // transition-colors
        child: ElevatedButton.icon(
          onPressed: () {
            launchUrlString(
              "https://github.com/b-fontaine/saaster_kit",
              webOnlyWindowName: "_blank",
            );
          },
          icon: const Icon(LucideIcons.github, size: 20), // Github size={20}
          label: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: const Text('Fork on GitHub'),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor:
                _isHovered
                    ? DSColors.gray100
                    : Colors.white, // bg-white hover:bg-gray-100
            foregroundColor: DSColors.primaryLanding, // text-indigo-600
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ), // px-6 py-4
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // rounded-lg
            ),
            elevation: 8, // shadow-lg
            shadowColor: Colors.black.withValues(alpha: 0.25),
            textStyle: DSTypography.textBase(context).copyWith(
              fontWeight: FontWeight.w500, // font-medium
            ),
          ),
        ),
      ),
    );
  }
}

class _SecondaryButton extends StatefulWidget {
  @override
  State<_SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<_SecondaryButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200), // transition-colors
        child: OutlinedButton(
          onPressed: () {
            // Scroll to features section functionality would be implemented here
            // This matches the href="#features" behavior from websitejs
          },
          style: OutlinedButton.styleFrom(
            backgroundColor:
                _isHovered
                    ? Colors.white
                    : Colors.transparent, // bg-transparent hover:bg-white
            foregroundColor:
                _isHovered
                    ? DSColors.primaryLanding
                    : Colors.white, // text-white hover:text-indigo-600
            side: const BorderSide(
              color: Colors.white,
              width: 2,
            ), // border-2 border-white
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ), // px-6 py-4
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // rounded-lg
            ),
            textStyle: DSTypography.textBase(context).copyWith(
              fontWeight: FontWeight.w500, // font-medium
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: const Text('Explore Features'),
          ),
        ),
      ),
    );
  }
}

class _RightContent extends StatelessWidget {
  const _RightContent();

  @override
  Widget build(BuildContext context) {
    // div className="hidden md:block" - only shown on desktop
    return const _CodePreview();
  }
}

class _CodePreview extends StatelessWidget {
  const _CodePreview();

  @override
  Widget build(BuildContext context) {
    // div className="bg-white/10 backdrop-blur-sm rounded-xl p-6 shadow-xl border border-white/20"
    return Container(
      padding: const EdgeInsets.all(24), // p-6
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1), // bg-white/10
        borderRadius: BorderRadius.circular(12), // rounded-xl
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2), // border-white/20
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25), // shadow-xl
            blurRadius: 25,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // pre className="text-indigo-100 overflow-x-auto"
          Text(
            '# Get started in seconds\n\$ git clone your-fork-url\n\$ docker compose -p saaster up -d\n# Ready to customize and deploy!',
            style: DSTypography.textSm(context).copyWith(
              color: const Color(0xFFE0E7FF), // text-indigo-100
              fontFamily: 'monospace',
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
