import 'package:flutter/material.dart';

class PortalBackground extends StatefulWidget {
  final Widget child;

  const PortalBackground({super.key, required this.child});

  @override
  State<PortalBackground> createState() => _PortalBackgroundState();
}

class _PortalBackgroundState extends State<PortalBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 9),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.disableAnimationsOf(context)) {
      return _PortalBackgroundContent(progress: 0.5, child: widget.child);
    }

    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return _PortalBackgroundContent(
            progress: Curves.easeInOutSine.transform(_controller.value),
            child: widget.child,
          );
        },
      ),
    );
  }
}

class _PortalBackgroundContent extends StatelessWidget {
  final double progress;
  final Widget child;

  const _PortalBackgroundContent({required this.progress, required this.child});

  @override
  Widget build(BuildContext context) {
    final drift = (progress - 0.5) * 56;

    return Stack(
      fit: StackFit.expand,
      children: [
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xff101a21), Color(0xff17282b), Color(0xff0d151c)],
            ),
          ),
        ),
        Positioned(
          top: -110 + drift,
          right: -80 - drift,
          child: _PortalGlow(
            size: 270,
            color: const Color(0xff8ff542).withValues(alpha: 0.14),
          ),
        ),
        Positioned(
          bottom: -145 - drift,
          left: -105 + drift,
          child: _PortalGlow(
            size: 330,
            color: const Color(0xff29c9c0).withValues(alpha: 0.10),
          ),
        ),
        child,
      ],
    );
  }
}

class _PortalGlow extends StatelessWidget {
  final double size;
  final Color color;

  const _PortalGlow({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [color, color.withValues(alpha: 0)]),
      ),
    );
  }
}
