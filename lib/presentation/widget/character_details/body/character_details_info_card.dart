import 'package:flutter/material.dart';
import 'package:rickandmorty/consstant/string.dart';

class CharacterDetailsInfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final double delay;
  final AnimationController staggerController;

  const CharacterDetailsInfoCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.delay,
    required this.staggerController,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: staggerController,
      builder: (context, child) {
        final curved = CurvedAnimation(
          parent: staggerController,
          curve: Interval(delay, delay + 0.4, curve: Curves.easeOutCubic),
        );

        return Opacity(
          opacity: curved.value,
          child: Transform.translate(
            offset: Offset(24 * (1 - curved.value), 0),
            child: child,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xff1e282f),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white.withOpacity(0.06)),
        ),
        child: Row(
          children: [
            Icon(icon, color: Mycoloer.myyellow, size: 22),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Mycoloer.mywhite.withOpacity(0.4),
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    color: Mycoloer.mywhite,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
