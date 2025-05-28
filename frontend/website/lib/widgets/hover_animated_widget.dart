import 'package:flutter/material.dart';

/// A widget that animates when hovered.
///
/// This widget detects mouse hover and applies animations accordingly.
class HoverAnimatedWidget extends StatefulWidget {
  /// The child widget to animate.
  final Widget child;
  
  /// Builder function that returns a widget based on the hover state.
  final Widget Function(BuildContext context, bool isHovered) builder;
  
  /// The duration of the hover animation.
  final Duration duration;
  
  /// The curve to use for the animation.
  final Curve curve;

  const HoverAnimatedWidget({
    super.key,
    required this.child,
    required this.builder,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.easeOutCubic,
  });

  @override
  State<HoverAnimatedWidget> createState() => _HoverAnimatedWidgetState();
}

class _HoverAnimatedWidgetState extends State<HoverAnimatedWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: widget.duration,
        curve: widget.curve,
        child: widget.builder(context, _isHovered),
      ),
    );
  }
}

/// A widget that applies a scale effect on hover.
class ScaleOnHover extends StatelessWidget {
  /// The child widget to animate.
  final Widget child;
  
  /// The scale factor to apply when hovered.
  final double hoverScale;
  
  /// The duration of the hover animation.
  final Duration duration;
  
  /// The curve to use for the animation.
  final Curve curve;
  
  /// Whether to add a shadow effect on hover.
  final bool addShadowOnHover;
  
  /// The shadow elevation to apply when hovered.
  final double hoverElevation;

  const ScaleOnHover({
    super.key,
    required this.child,
    this.hoverScale = 1.05,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.easeOutCubic,
    this.addShadowOnHover = true,
    this.hoverElevation = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return HoverAnimatedWidget(
      duration: duration,
      curve: curve,
      builder: (context, isHovered) {
        return Transform.scale(
          scale: isHovered ? hoverScale : 1.0,
          child: Container(
            decoration: addShadowOnHover && isHovered
                ? BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: (0.2 * 255).toDouble()),
                        blurRadius: hoverElevation,
                        spreadRadius: 1,
                      ),
                    ],
                  )
                : null,
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}

/// A widget that applies a color transition effect on hover.
class ColorTransitionOnHover extends StatelessWidget {
  /// The child widget to animate.
  final Widget child;
  
  /// Builder function that returns a widget based on the hover state.
  final Widget Function(BuildContext context, bool isHovered) builder;
  
  /// The duration of the hover animation.
  final Duration duration;
  
  /// The curve to use for the animation.
  final Curve curve;

  const ColorTransitionOnHover({
    super.key,
    required this.child,
    required this.builder,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.easeOutCubic,
  });

  @override
  Widget build(BuildContext context) {
    return HoverAnimatedWidget(
      duration: duration,
      curve: curve,
      builder: builder,
      child: child,
    );
  }
}
