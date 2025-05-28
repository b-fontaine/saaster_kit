import 'package:flutter/material.dart';

/// A widget that creates a continuous animation effect.
///
/// This widget creates a continuous animation that repeats indefinitely,
/// useful for creating subtle background animations or attention-grabbing effects.
class ContinuousAnimationWidget extends StatefulWidget {
  /// The child widget to animate.
  final Widget child;
  
  /// The type of continuous animation to apply.
  final ContinuousAnimationType animationType;
  
  /// The duration of one complete animation cycle.
  final Duration duration;
  
  /// The amplitude of the animation effect.
  final double amplitude;
  
  /// The curve to use for the animation.
  final Curve curve;

  const ContinuousAnimationWidget({
    super.key,
    required this.child,
    this.animationType = ContinuousAnimationType.float,
    this.duration = const Duration(seconds: 2),
    this.amplitude = 10.0,
    this.curve = Curves.easeInOut,
  });

  @override
  State<ContinuousAnimationWidget> createState() => _ContinuousAnimationWidgetState();
}

class _ContinuousAnimationWidgetState extends State<ContinuousAnimationWidget>
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
      begin: 0.0,
      end: 1.0,
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
        switch (widget.animationType) {
          case ContinuousAnimationType.float:
            return Transform.translate(
              offset: Offset(0, widget.amplitude * (_animation.value - 0.5)),
              child: child,
            );
          case ContinuousAnimationType.pulse:
            final scale = 1.0 + (widget.amplitude / 100) * (_animation.value - 0.5);
            return Transform.scale(
              scale: scale,
              child: child,
            );
          case ContinuousAnimationType.rotate:
            final angle = (widget.amplitude / 100) * (_animation.value - 0.5);
            return Transform.rotate(
              angle: angle,
              child: child,
            );
          case ContinuousAnimationType.breathe:
            final opacity = 0.7 + 0.3 * _animation.value;
            final scale = 0.95 + 0.05 * _animation.value;
            return Opacity(
              opacity: opacity,
              child: Transform.scale(
                scale: scale,
                child: child,
              ),
            );
        }
      },
      child: widget.child,
    );
  }
}

/// The type of continuous animation to apply.
enum ContinuousAnimationType {
  /// Floating up and down animation.
  float,
  
  /// Pulsing scale animation.
  pulse,
  
  /// Subtle rotation animation.
  rotate,
  
  /// Breathing effect (opacity + scale).
  breathe,
}
