import 'package:flutter/material.dart';

class CharacterScreenLoadingScaleAnimation extends StatelessWidget {
  final Widget child;

  const CharacterScreenLoadingScaleAnimation({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: .75, end: 1),
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Transform.scale(scale: value, child: child);
      },
      child: child,
    );
  }
}
