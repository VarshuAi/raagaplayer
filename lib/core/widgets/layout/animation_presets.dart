import 'package:flutter/material.dart';
import '../../motion/curves.dart';
import '../../motion/durations.dart';
import '../../services/haptic_service.dart';

// Shrink-on-press premium tap feedback
class AnimatedTap extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double scaleFactor;

  const AnimatedTap({
    super.key,
    required this.child,
    required this.onTap,
    this.scaleFactor = 0.95,
  });

  @override
  State<AnimatedTap> createState() => _AnimatedTapState();
}

class _AnimatedTapState extends State<AnimatedTap> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppDurations.fast,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: widget.scaleFactor).animate(
      CurvedAnimation(parent: _controller, curve: AppCurves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    if (widget.onTap != null) {
      _controller.forward();
      HapticService.selection();
    }
  }

  void _onTapUp(TapUpDetails details) {
    if (widget.onTap != null) {
      _controller.reverse();
      widget.onTap!();
    }
  }

  void _onTapCancel() {
    if (widget.onTap != null) {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      behavior: HitTestBehavior.opaque,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: widget.child,
      ),
    );
  }
}

// Fade in and slide up entrance reveal
class FadeInWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Offset offset;

  const FadeInWidget({
    super.key,
    required this.child,
    this.duration = AppDurations.slow,
    this.offset = const Offset(0.0, 16.0),
  });

  @override
  State<FadeInWidget> createState() => _FadeInWidgetState();
}

class _FadeInWidgetState extends State<FadeInWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: AppCurves.easeInOut),
    );
    _slideAnimation = Tween<Offset>(begin: widget.offset, end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: AppCurves.fluid),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: Transform.translate(
            offset: _slideAnimation.value,
            child: widget.child,
          ),
        );
      },
    );
  }
}

// Pop-in scale animation
class ScaleInWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const ScaleInWidget({
    super.key,
    required this.child,
    this.duration = AppDurations.slow,
  });

  @override
  State<ScaleInWidget> createState() => _ScaleInWidgetState();
}

class _ScaleInWidgetState extends State<ScaleInWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: AppCurves.overshoot),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: widget.child,
    );
  }
}
