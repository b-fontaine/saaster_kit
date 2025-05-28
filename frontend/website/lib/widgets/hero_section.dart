import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HeroSection extends StatefulWidget {
  final ScrollController scrollController;
  
  const HeroSection({
    super.key,
    required this.scrollController,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  double _parallaxOffset = 0.0;
  
  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_updateParallaxOffset);
  }
  
  @override
  void dispose() {
    widget.scrollController.removeListener(_updateParallaxOffset);
    super.dispose();
  }
  
  void _updateParallaxOffset() {
    // Calculate parallax offset based on scroll position
    // The multiplier (0.3) controls the parallax effect intensity
    final scrollOffset = widget.scrollController.offset;
    setState(() {
      _parallaxOffset = scrollOffset * 0.3;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    // Create a parallax background effect
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.8, // 80% of screen height
      width: double.infinity,
      child: Stack(
        children: [
          // Parallax background with gradient
          Positioned.fill(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight.add(Alignment(_parallaxOffset * 0.01, _parallaxOffset * 0.01)),
                  colors: [
                    DSColors.primaryLanding.withValues(alpha: 40),
                    DSColors.secondaryLanding.withValues(alpha: 20),
                  ],
                ),
              ),
            ),
          ),
          
          // Parallax decorative elements
          Positioned(
            right: -50 + (_parallaxOffset * 0.2),
            top: 50 - (_parallaxOffset * 0.1),
            child: Opacity(
              opacity: 0.1,
              child: Transform.scale(
                scale: 1.2,
                child: Image.asset('assets/images/logo.png', width: 300),
              ),
            ),
          ),
          
          // Content container
          Padding(
            padding: DSSpacing.getPagePadding(context),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Text content
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Build SaaS Applications Faster with SaaSter Kit',
                        style: DSTypography.landingTextTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: DSColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'A complete, production-ready SaaS starter kit with microservices architecture, authentication, billing, and more. Start building your next big idea today.',
                        style: DSTypography.landingTextTheme.titleMedium?.copyWith(
                          color: DSColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Row(
                        children: [
                          DSButtons.primaryLandingButton(
                            text: 'Get Started',
                            onPressed: () {
                              launchUrlString("/app", webOnlyWindowName: "_self");
                            },
                          ),
                          const SizedBox(width: 16),
                          DSButtons.secondaryLandingButton(
                            text: 'Learn More',
                            onPressed: () {
                              launchUrlString(
                                "https://github.com/b-fontaine/saaster_kit",
                                webOnlyWindowName: "_self",
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Image with parallax effect
                if (DSBreakpoints.isDesktop(context) || DSBreakpoints.isTablet(context))
                  Expanded(
                    flex: 2,
                    child: Transform.translate(
                      offset: Offset(_parallaxOffset * -0.3, 0),
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
