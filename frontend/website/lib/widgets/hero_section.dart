import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'continuous_animation.dart';
import 'hover_animated_widget.dart';
import 'parallax_background.dart';

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
          // Parallax background with white color and SVG patterns
          Positioned.fill(
            child: ParallaxBackground(
              svgAssets: const [
                'assets/images/svg/geometric_shapes.svg',
                'assets/images/svg/dots_grid.svg',
              ],
              scrollController: widget.scrollController,
              parallaxSpeeds: const [-0.05, -0.02],
              opacityLevels: const [0.05, 0.03],
              colorFilters: const [Colors.white, Colors.white],
            ),
          ),
          
          // Animated decorative elements
          Positioned(
            right: -50 + (_parallaxOffset * 0.2),
            top: 50 - (_parallaxOffset * 0.1),
            child: ContinuousAnimationWidget(
              animationType: ContinuousAnimationType.float,
              amplitude: 5.0,
              duration: const Duration(seconds: 4),
              child: Opacity(
                opacity: 0.05, // Reduced opacity for better contrast on white
                child: Transform.scale(
                  scale: 1.2,
                  child: Image.asset('assets/images/logo.png', width: 300),
                ),
              ),
            ),
          ),
          
          // Additional floating tech elements
          Positioned(
            left: 50 + (_parallaxOffset * 0.15),
            bottom: 100 - (_parallaxOffset * 0.1),
            child: ContinuousAnimationWidget(
              animationType: ContinuousAnimationType.rotate,
              amplitude: 3.0,
              duration: const Duration(seconds: 6),
              child: Opacity(
                opacity: 0.04,
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: SvgPicture.asset('assets/images/svg/tech_elements.svg'),
                ),
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
                          ContinuousAnimationWidget(
                            animationType: ContinuousAnimationType.pulse,
                            amplitude: 2.0,
                            duration: const Duration(seconds: 3),
                            child: ScaleOnHover(
                              hoverScale: 1.05,
                              child: DSButtons.primaryLandingButton(
                                text: 'Get Started',
                                onPressed: () {
                                  launchUrlString("/app", webOnlyWindowName: "_self");
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          ScaleOnHover(
                            hoverScale: 1.05,
                            child: DSButtons.secondaryLandingButton(
                              text: 'Learn More',
                              onPressed: () {
                                launchUrlString(
                                  "https://github.com/b-fontaine/saaster_kit",
                                  webOnlyWindowName: "_self",
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Image with parallax and floating effect
                if (DSBreakpoints.isDesktop(context) || DSBreakpoints.isTablet(context))
                  Expanded(
                    flex: 2,
                    child: Transform.translate(
                      offset: Offset(_parallaxOffset * -0.3, 0),
                      child: ContinuousAnimationWidget(
                        animationType: ContinuousAnimationType.breathe,
                        amplitude: 3.0,
                        duration: const Duration(seconds: 5),
                        child: ScaleOnHover(
                          hoverScale: 1.03,
                          addShadowOnHover: true,
                          child: Image.asset(
                            'assets/images/logo.png',
                            fit: BoxFit.contain,
                          ),
                        ),
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
