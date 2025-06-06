import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:design_system/design_system.dart';
import 'package:lucide_icons/lucide_icons.dart';

/// Custom header widget that exactly matches the websitejs Header component
class CustomHeader extends StatefulWidget {
  final ScrollController? scrollController;
  
  const CustomHeader({
    super.key,
    this.scrollController,
  });

  @override
  State<CustomHeader> createState() => _CustomHeaderState();
}

class _CustomHeaderState extends State<CustomHeader> {
  bool isMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= DSBreakpoints.md; // Updated to use design system breakpoints

    return Material(
      elevation: 1,
      shadowColor: DSColors.shadow,
      child: Container(
        color: Colors.white, // bg-white
        // Sticky positioning equivalent
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05), // shadow-sm
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: DSResponsiveLayout.responsiveContainer(
                maxWidth: 1280, // max-w-7xl
                padding: ResponsiveUtils.responsivePadding(
                  context,
                  defaultPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16), // px-4 py-4
                  sm: const EdgeInsets.symmetric(horizontal: 24, vertical: 16), // sm:px-6 py-4
                  lg: const EdgeInsets.symmetric(horizontal: 32, vertical: 16), // lg:px-8 py-4
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // justify-between
                  children: [
                    // Logo section
                    _LogoSection(),

                    // Desktop navigation
                    if (isDesktop)
                      _DesktopNavigation(
                        onFeaturesPressed: () => _scrollToSection('features'),
                        onHowToUsePressed: () => _scrollToSection('how-to-use'),
                      )
                    else
                      _MobileMenuButton(
                        isOpen: isMenuOpen,
                        onPressed: () {
                          setState(() {
                            isMenuOpen = !isMenuOpen;
                          });
                        },
                      ),
                  ],
                ),
              ),
            ),

            // Mobile menu dropdown
            if (!isDesktop && isMenuOpen)
              _MobileMenu(
                onFeaturesPressed: () {
                  setState(() => isMenuOpen = false);
                  _scrollToSection('features');
                },
                onHowToUsePressed: () {
                  setState(() => isMenuOpen = false);
                  _scrollToSection('how-to-use');
                },
                onGitHubPressed: () {
                  setState(() => isMenuOpen = false);
                },
              ),
          ],
        ),
      ),
    );
  }

  void _scrollToSection(String sectionId) {
    if (widget.scrollController != null) {
      // Calculate approximate scroll positions based on section order
      double targetOffset = 0;
      switch (sectionId) {
        case 'features':
          targetOffset = 600; // Approximate height of hero section
          break;
        case 'how-to-use':
          targetOffset = 1200; // Approximate height of hero + features
          break;
      }
      
      widget.scrollController!.animateTo(
        targetOffset,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }
}

// Separate widget classes for better performance and reusability
class _LogoSection extends StatelessWidget {
  const _LogoSection();

  @override
  Widget build(BuildContext context) {
    return Text(
      'SaaSter Kit',
      style: DSTypography.text2Xl(context).copyWith(
        fontWeight: FontWeight.bold, // font-bold
        color: DSColors.primaryLanding, // text-indigo-600
      ),
    );
  }
}

class _DesktopNavigation extends StatelessWidget {
  final VoidCallback onFeaturesPressed;
  final VoidCallback onHowToUsePressed;

  const _DesktopNavigation({
    required this.onFeaturesPressed,
    required this.onHowToUsePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _NavigationLink(
          text: 'Features',
          onTap: onFeaturesPressed,
        ),
        const SizedBox(width: 32), // space-x-8
        _NavigationLink(
          text: 'How to Use',
          onTap: onHowToUsePressed,
        ),
        const SizedBox(width: 32), // space-x-8
        const _GitHubLink(),
      ],
    );
  }
}

class _NavigationLink extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const _NavigationLink({
    required this.text,
    required this.onTap,
  });

  @override
  State<_NavigationLink> createState() => _NavigationLinkState();
}

class _NavigationLinkState extends State<_NavigationLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200), // transition-colors
          style: DSTypography.textBase(context).copyWith(
            color: _isHovered ? DSColors.primaryLanding : DSColors.gray700, // text-gray-700 hover:text-indigo-600
          ),
          child: Text(widget.text),
        ),
      ),
    );
  }
}

class _GitHubLink extends StatefulWidget {
  const _GitHubLink();

  @override
  State<_GitHubLink> createState() => _GitHubLinkState();
}

class _GitHubLinkState extends State<_GitHubLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          launchUrlString(
            "https://github.com/b-fontaine/saaster_kit",
            webOnlyWindowName: "_blank",
          );
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                LucideIcons.github, // Exact match for lucide-react Github
                size: 18,
                color: _isHovered ? DSColors.primaryLanding : DSColors.gray700,
              ),
            ),
            const SizedBox(width: 4), // mr-1
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: DSTypography.textBase(context).copyWith(
                color: _isHovered ? DSColors.primaryLanding : DSColors.gray700,
              ),
              child: const Text('GitHub'),
            ),
          ],
        ),
      ),
    );
  }
}

class _MobileMenuButton extends StatefulWidget {
  final bool isOpen;
  final VoidCallback onPressed;

  const _MobileMenuButton({
    required this.isOpen,
    required this.onPressed,
  });

  @override
  State<_MobileMenuButton> createState() => _MobileMenuButtonState();
}

class _MobileMenuButtonState extends State<_MobileMenuButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: IconButton(
        onPressed: widget.onPressed,
        icon: Icon(
          widget.isOpen ? Icons.close : Icons.menu,
          size: 24,
          color: _isHovered ? DSColors.primaryLanding : DSColors.gray700,
        ),
        splashColor: DSColors.primaryLanding.withValues(alpha: 0.1),
        highlightColor: DSColors.primaryLanding.withValues(alpha: 0.1),
      ),
    );
  }
}

class _MobileMenu extends StatelessWidget {
  final VoidCallback onFeaturesPressed;
  final VoidCallback onHowToUsePressed;
  final VoidCallback onGitHubPressed;

  const _MobileMenu({
    required this.onFeaturesPressed,
    required this.onHowToUsePressed,
    required this.onGitHubPressed,
  });

  @override
  Widget build(BuildContext context) {
    return DSResponsiveLayout.responsiveContainer(
      maxWidth: 1280, // max-w-7xl
      padding: ResponsiveUtils.responsivePadding(
        context,
        defaultPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // px-4 py-2 pb-4
        sm: const EdgeInsets.symmetric(horizontal: 24, vertical: 8), // sm:px-6 py-2 pb-4
        lg: const EdgeInsets.symmetric(horizontal: 32, vertical: 8), // lg:px-8 py-2 pb-4
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _MobileNavigationLink(
            text: 'Features',
            onTap: onFeaturesPressed,
          ),
          _MobileNavigationLink(
            text: 'How to Use',
            onTap: onHowToUsePressed,
          ),
          _MobileGitHubLink(onTap: onGitHubPressed),
        ],
      ),
    );
  }
}

class _MobileNavigationLink extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _MobileNavigationLink({
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 8), // py-2
        child: Text(
          text,
          style: DSTypography.textBase(context).copyWith(
            color: DSColors.gray700, // text-gray-700
          ),
        ),
      ),
    );
  }
}

class _MobileGitHubLink extends StatelessWidget {
  final VoidCallback onTap;

  const _MobileGitHubLink({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
        launchUrlString(
          "https://github.com/b-fontaine/saaster_kit",
          webOnlyWindowName: "_blank",
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 8), // py-2
        child: Row(
          children: [
            Icon(
              LucideIcons.github, // Exact match for lucide-react Github
              size: 18,
              color: DSColors.gray700, // text-gray-700
            ),
            const SizedBox(width: 4), // mr-1
            Text(
              'GitHub',
              style: DSTypography.textBase(context).copyWith(
                color: DSColors.gray700, // text-gray-700
              ),
            ),
          ],
        ),
      ),
    );
  }
}
