import 'package:flutter/material.dart';

class CharacterScreenHeaderBrandingRow extends StatelessWidget {
  const CharacterScreenHeaderBrandingRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const RadialGradient(
              colors: [
                Color(0xffb7ff3c),
                Color(0xff2aa84a),
                Color(0xff102b22),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xff9dff35).withValues(alpha: .42),
                blurRadius: 24,
                spreadRadius: 2,
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Image.asset(
              'asset/images/iconsremo.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: SizedBox(
            height: 50,
            child: Image.asset(
              'asset/images/name.png',
              fit: BoxFit.contain,
              alignment: Alignment.centerLeft,
            ),
          ),
        ),
      ],
    );
  }
}
