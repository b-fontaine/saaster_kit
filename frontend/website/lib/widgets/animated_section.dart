import 'package:flutter/material.dart';

/// A widget that animates its child when it becomes visible in the viewport.
/// 
/// This widget uses an [AnimationController] to create fade and slide animations
/// that trigger when the widget becomes visible in the viewport.
class AnimatedSection extends StatefulWidget {
  /// The child widget to animate.
  final Widget child;
  
  /// The type of animation to apply.
  final AnimationType animationType;
  
  /// The direction of the slide animation if [animationType] includes sliding.
  final SlideDirection slideDirection;
  
  /// The duration of the animation.
  final Duration duration;
  
  /// The delay before starting the animation.
  final Duration delay;
  
  /// The curve to use for the animation.
  final Curve curve;

  const AnimatedSection({
    super.key,
    required this.child,
    this.animationType = AnimationType.fadeSlide,
    this.slideDirection = SlideDirection.up,
    this.duration = const Duration(milliseconds: 500),
    this.delay = Duration.zero,
    this.curve = Curves.easeOutCubic,
  });

  @override
  State<AnimatedSection> createState() => _AnimatedSectionState();
}

class _AnimatedSectionState extends State<AnimatedSection> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _rotateAnimation;
  late Animation<double> _bounceAnimation;
  late Animation<double> _shimmerAnimation;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));
    
    _slideAnimation = Tween<Offset>(
      begin: _getBeginOffset(),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));
    
    _rotateAnimation = Tween<double>(
      begin: -0.1,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));
    
    _bounceAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));
    
    _shimmerAnimation = Tween<double>(
      begin: -1.0,
      end: 2.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));
    
    // Add post-frame callback to check visibility
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkVisibility();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Offset _getBeginOffset() {
    switch (widget.slideDirection) {
      case SlideDirection.up:
        return const Offset(0, 0.25);
      case SlideDirection.down:
        return const Offset(0, -0.25);
      case SlideDirection.left:
        return const Offset(0.25, 0);
      case SlideDirection.right:
        return const Offset(-0.25, 0);
    }
  }

  void _checkVisibility() {
    // Simple visibility check based on viewport
    // In a real implementation, you might want to use a more sophisticated
    // approach like VisibilityDetector or IntersectionObserver
    
    if (!_isVisible) {
      setState(() {
        _isVisible = true;
      });
      
      Future.delayed(widget.delay, () {
        if (mounted) {
          _controller.forward();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Listen to scroll notifications to check visibility on scroll
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        _checkVisibility();
        return false;
      },
      child: _buildAnimatedWidget(),
    );
  }

  Widget _buildAnimatedWidget() {
    switch (widget.animationType) {
      case AnimationType.fade:
        return FadeTransition(
          opacity: _fadeAnimation,
          child: widget.child,
        );
      case AnimationType.slide:
        return SlideTransition(
          position: _slideAnimation,
          child: widget.child,
        );
      case AnimationType.fadeSlide:
        return FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: widget.child,
          ),
        );
      case AnimationType.scale:
        return ScaleTransition(
          scale: _fadeAnimation,
          child: widget.child,
        );
      case AnimationType.fadeScale:
        return FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _fadeAnimation,
            child: widget.child,
          ),
        );
      case AnimationType.bounce:
        return AnimatedBuilder(
          animation: _bounceAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: 0.9 + (_bounceAnimation.value * 0.1),
              child: child,
            );
          },
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: widget.child,
          ),
        );
      case AnimationType.elastic:
        return AnimatedBuilder(
          animation: _bounceAnimation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, 20 * (1 - _bounceAnimation.value)),
              child: child,
            );
          },
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: widget.child,
          ),
        );
      case AnimationType.rotate:
        return AnimatedBuilder(
          animation: _rotateAnimation,
          builder: (context, child) {
            return Transform.rotate(
              angle: _rotateAnimation.value,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: child,
              ),
            );
          },
          child: widget.child,
        );
      case AnimationType.shimmer:
        return AnimatedBuilder(
          animation: _shimmerAnimation,
          builder: (context, child) {
            return ShaderMask(
              shaderCallback: (bounds) {
                return LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withValues(alpha: 50),
                    Colors.white,
                    Colors.white.withValues(alpha: 50),
                  ],
                  stops: [
                    0.0,
                    _shimmerAnimation.value,
                    1.0,
                  ],
                ).createShader(bounds);
              },
              child: child,
            );
          },
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: widget.child,
          ),
        );
    }
  }
}

/// The type of animation to apply to the section.
enum AnimationType {
  /// Fade in animation.
  fade,
  
  /// Slide animation.
  slide,
  
  /// Combined fade and slide animation.
  fadeSlide,
  
  /// Scale animation.
  scale,
  
  /// Combined fade and scale animation.
  fadeScale,
  
  /// Bounce animation.
  bounce,
  
  /// Elastic animation.
  elastic,
  
  /// Rotate animation.
  rotate,
  
  /// Shimmer animation.
  shimmer,
}

/// The direction of the slide animation.
enum SlideDirection {
  /// Slide from bottom to top.
  up,
  
  /// Slide from top to bottom.
  down,
  
  /// Slide from right to left.
  left,
  
  /// Slide from left to right.
  right,
}

/// A more advanced animated section that uses scroll position to trigger animations.
/// 
/// This widget provides more control over when animations are triggered based on
/// the scroll position of a parent ScrollView.
class ScrollAnimatedSection extends StatefulWidget {
  /// The child widget to animate.
  final Widget child;
  
  /// The type of animation to apply.
  final AnimationType animationType;
  
  /// The direction of the slide animation if [animationType] includes sliding.
  final SlideDirection slideDirection;
  
  /// The duration of the animation.
  final Duration duration;
  
  /// The curve to use for the animation.
  final Curve curve;
  
  /// The scroll controller to listen to.
  final ScrollController scrollController;
  
  /// The threshold at which the animation should trigger (0.0 to 1.0).
  /// 
  /// A value of 0.8 means the animation will trigger when the widget is 80%
  /// visible in the viewport.
  final double visibilityThreshold;

  const ScrollAnimatedSection({
    super.key,
    required this.child,
    required this.scrollController,
    this.animationType = AnimationType.fadeSlide,
    this.slideDirection = SlideDirection.up,
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.easeOutCubic,
    this.visibilityThreshold = 0.1,
  });

  @override
  State<ScrollAnimatedSection> createState() => _ScrollAnimatedSectionState();
}

class _ScrollAnimatedSectionState extends State<ScrollAnimatedSection> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  final GlobalKey _key = GlobalKey();
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));
    
    _slideAnimation = Tween<Offset>(
      begin: _getBeginOffset(),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));
    
    widget.scrollController.addListener(_checkPosition);
    
    // Check position after layout
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkPosition();
    });
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_checkPosition);
    _controller.dispose();
    super.dispose();
  }

  Offset _getBeginOffset() {
    switch (widget.slideDirection) {
      case SlideDirection.up:
        return const Offset(0, 0.25);
      case SlideDirection.down:
        return const Offset(0, -0.25);
      case SlideDirection.left:
        return const Offset(0.25, 0);
      case SlideDirection.right:
        return const Offset(-0.25, 0);
    }
  }

  void _checkPosition() {
    if (_hasAnimated) return;
    
    final RenderObject? renderObject = _key.currentContext?.findRenderObject();
    if (renderObject == null || !renderObject.attached) return;
    
    final RenderBox box = renderObject as RenderBox;
    final position = box.localToGlobal(Offset.zero);
    
    // Get the visible height of the widget
    final size = box.size;
    final screenHeight = MediaQuery.sizeOf(context).height;
    
    // Calculate how much of the widget is visible
    final visibleTop = position.dy < 0 ? 0 : position.dy;
    final visibleBottom = position.dy + size.height > screenHeight 
        ? screenHeight 
        : position.dy + size.height;
    
    final visibleHeight = visibleBottom - visibleTop;
    final visiblePercentage = visibleHeight / size.height;
    
    if (visiblePercentage >= widget.visibilityThreshold) {
      _hasAnimated = true;
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget animatedChild;
    
    switch (widget.animationType) {
      case AnimationType.fade:
        animatedChild = FadeTransition(
          opacity: _fadeAnimation,
          child: widget.child,
        );
        break;
      case AnimationType.slide:
        animatedChild = SlideTransition(
          position: _slideAnimation,
          child: widget.child,
        );
        break;
      case AnimationType.fadeSlide:
        animatedChild = FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: widget.child,
          ),
        );
        break;
      case AnimationType.scale:
        animatedChild = ScaleTransition(
          scale: _fadeAnimation,
          child: widget.child,
        );
        break;
      case AnimationType.fadeScale:
        animatedChild = FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _fadeAnimation,
            child: widget.child,
          ),
        );
        break;
    }
    
    return Container(
      key: _key,
      child: animatedChild,
    );
  }
}
