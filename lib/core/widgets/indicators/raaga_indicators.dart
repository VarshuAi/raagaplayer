import 'package:flutter/material.dart';
import '../../design_tokens/radius.dart';
import '../../extensions/context_extensions.dart';

class RaagaProgressIndicator extends StatelessWidget {
  final double? value;

  const RaagaProgressIndicator({
    super.key,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: value,
      minHeight: 4,
      borderRadius: BorderRadius.circular(2),
      valueColor: AlwaysStoppedAnimation<Color>(context.colorScheme.primary),
      backgroundColor: context.colorScheme.onSurface.withOpacity(0.08),
    );
  }
}

class RaagaCircularIndicator extends StatelessWidget {
  const RaagaCircularIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      strokeWidth: 3,
      valueColor: AlwaysStoppedAnimation<Color>(context.colorScheme.primary),
    );
  }
}

// Premium skeletal shimmer loader effect
class RaagaShimmer extends StatefulWidget {
  final double width;
  final double height;
  final double? radius;

  const RaagaShimmer({
    super.key,
    required this.width,
    required this.height,
    this.radius,
  });

  @override
  State<RaagaShimmer> createState() => _RaagaShimmerState();
}

class _RaagaShimmerState extends State<RaagaShimmer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation1;
  late Animation<Color?> _colorAnimation2;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _colorAnimation1 = ColorTween(
      begin: const Color(0xFF1D1F24),
      end: const Color(0xFF2E323D),
    ).animate(_controller);

    _colorAnimation2 = ColorTween(
      begin: const Color(0xFF2E323D),
      end: const Color(0xFF1D1F24),
    ).animate(_controller);
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
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.radius ?? AppRadius.card),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                _colorAnimation1.value ?? const Color(0xFF1D1F24),
                _colorAnimation2.value ?? const Color(0xFF2E323D),
              ],
            ),
          ),
        );
      },
    );
  }
}

class RaagaLoadingSkeleton extends StatelessWidget {
  const RaagaLoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const RaagaShimmer(width: 48, height: 48, radius: 8),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RaagaShimmer(width: context.screenWidth * 0.5, height: 16, radius: 4),
              const SizedBox(height: 8),
              RaagaShimmer(width: context.screenWidth * 0.3, height: 12, radius: 4),
            ],
          ),
        ),
      ],
    );
  }
}
