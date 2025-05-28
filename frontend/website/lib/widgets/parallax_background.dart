import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A widget that creates a parallax effect with SVG backgrounds.
///
/// This widget uses a [ScrollController] to create a parallax effect with
/// SVG assets. It can be configured with different speeds, positions, and
/// opacity levels for each SVG layer.
class ParallaxBackground extends StatefulWidget {
  /// The SVG asset paths to display in the background.
  final List<String> svgAssets;
  
  /// The scroll controller to listen to for parallax effects.
  final ScrollController scrollController;
  
  /// The parallax speeds for each SVG asset. Must match the length of [svgAssets].
  /// Values represent the multiplier for the scroll position.
  /// Positive values move the asset in the same direction as the scroll,
  /// negative values move in the opposite direction.
  final List<double> parallaxSpeeds;
  
  /// The opacity levels for each SVG asset. Must match the length of [svgAssets].
  final List<double> opacityLevels;
  
  /// The blend modes for each SVG asset. Must match the length of [svgAssets].
  final List<BlendMode>? blendModes;
  
  /// Whether to clip the SVG assets to the bounds of the widget.
  final bool clipContent;
  
  /// The color to apply to the SVG assets. If null, the original colors are used.
  final List<Color>? colorFilters;

  const ParallaxBackground({
    super.key,
    required this.svgAssets,
    required this.scrollController,
    required this.parallaxSpeeds,
    this.opacityLevels = const [],
    this.blendModes,
    this.clipContent = true,
    this.colorFilters,
  }) : assert(svgAssets.length == parallaxSpeeds.length,
            'svgAssets and parallaxSpeeds must have the same length'),
       assert(opacityLevels.isEmpty || opacityLevels.length == svgAssets.length,
            'If provided, opacityLevels must have the same length as svgAssets'),
       assert(blendModes == null || blendModes.length == svgAssets.length,
            'If provided, blendModes must have the same length as svgAssets'),
       assert(colorFilters == null || colorFilters.length == svgAssets.length,
            'If provided, colorFilters must have the same length as svgAssets');

  @override
  State<ParallaxBackground> createState() => _ParallaxBackgroundState();
}

class _ParallaxBackgroundState extends State<ParallaxBackground> {
  List<double> _parallaxOffsets = [];
  
  @override
  void initState() {
    super.initState();
    _parallaxOffsets = List.filled(widget.svgAssets.length, 0.0);
    widget.scrollController.addListener(_updateParallaxOffsets);
  }
  
  @override
  void dispose() {
    widget.scrollController.removeListener(_updateParallaxOffsets);
    super.dispose();
  }
  
  void _updateParallaxOffsets() {
    final scrollOffset = widget.scrollController.offset;
    setState(() {
      for (int i = 0; i < widget.parallaxSpeeds.length; i++) {
        _parallaxOffsets[i] = scrollOffset * widget.parallaxSpeeds[i];
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(widget.svgAssets.length, (index) {
        return Positioned.fill(
          child: Transform.translate(
            offset: Offset(0, _parallaxOffsets[index]),
            child: Opacity(
              opacity: widget.opacityLevels.isNotEmpty 
                  ? widget.opacityLevels[index] 
                  : 1.0,
              child: ClipRect(
                clipBehavior: widget.clipContent 
                    ? Clip.hardEdge 
                    : Clip.none,
                child: SvgPicture.asset(
                  widget.svgAssets[index],
                  fit: BoxFit.cover,
                  colorFilter: widget.colorFilters != null 
                      ? ColorFilter.mode(
                          widget.colorFilters![index], 
                          widget.blendModes?[index] ?? BlendMode.srcIn,
                        )
                      : null,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

/// A widget that creates a parallax section with content.
///
/// This widget combines a [ParallaxBackground] with content to create
/// a section with a parallax effect.
class ParallaxSection extends StatelessWidget {
  /// The SVG asset paths to display in the background.
  final List<String> svgAssets;
  
  /// The scroll controller to listen to for parallax effects.
  final ScrollController scrollController;
  
  /// The parallax speeds for each SVG asset. Must match the length of [svgAssets].
  final List<double> parallaxSpeeds;
  
  /// The opacity levels for each SVG asset. Must match the length of [svgAssets].
  final List<double> opacityLevels;
  
  /// The content to display on top of the parallax background.
  final Widget content;
  
  /// The height of the section. If null, the section will size to its content.
  final double? height;
  
  /// The width of the section. Defaults to double.infinity.
  final double width;
  
  /// The padding to apply to the content.
  final EdgeInsetsGeometry contentPadding;
  
  /// The background color of the section.
  final Color backgroundColor;
  
  /// The blend modes for each SVG asset. Must match the length of [svgAssets].
  final List<BlendMode>? blendModes;
  
  /// The color filters to apply to the SVG assets.
  final List<Color>? colorFilters;

  const ParallaxSection({
    super.key,
    required this.svgAssets,
    required this.scrollController,
    required this.parallaxSpeeds,
    required this.content,
    this.opacityLevels = const [],
    this.height,
    this.width = double.infinity,
    this.contentPadding = EdgeInsets.zero,
    this.backgroundColor = Colors.transparent,
    this.blendModes,
    this.colorFilters,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      color: backgroundColor,
      child: Stack(
        children: [
          // Parallax background
          ParallaxBackground(
            svgAssets: svgAssets,
            scrollController: scrollController,
            parallaxSpeeds: parallaxSpeeds,
            opacityLevels: opacityLevels,
            blendModes: blendModes,
            colorFilters: colorFilters,
          ),
          
          // Content
          Padding(
            padding: contentPadding,
            child: content,
          ),
        ],
      ),
    );
  }
}

/// A widget that creates a floating animation effect.
///
/// This widget creates a continuous floating animation that moves
/// the child widget up and down slightly.
class FloatingAnimation extends StatefulWidget {
  /// The child widget to animate.
  final Widget child;
  
  /// The amplitude of the floating animation.
  final double amplitude;
  
  /// The speed of the floating animation.
  final Duration duration;
  
  /// The curve to use for the animation.
  final Curve curve;

  const FloatingAnimation({
    super.key,
    required this.child,
    this.amplitude = 10.0,
    this.duration = const Duration(seconds: 3),
    this.curve = Curves.easeInOut,
  });

  @override
  State<FloatingAnimation> createState() => _FloatingAnimationState();
}

class _FloatingAnimationState extends State<FloatingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat(reverse: true);
    
    _animation = Tween<double>(
      begin: -widget.amplitude / 2,
      end: widget.amplitude / 2,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
