import 'package:flutter/material.dart';
import 'package:rickandmorty/consstant/string.dart';

class CharacterDetailsStatItem extends StatelessWidget {
  final String label;
  final String value;

  const CharacterDetailsStatItem({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Mycoloer.myyellow,
            fontSize: 24,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            color: Mycoloer.mywhite.withOpacity(0.4),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
