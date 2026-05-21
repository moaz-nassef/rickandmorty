import 'package:flutter/material.dart';

class CharacterScreenLoadingRotatingLogo extends StatelessWidget {
  final Animation<double> rotation;

  const CharacterScreenLoadingRotatingLogo({
    super.key,
    required this.rotation,
  });

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: rotation,
      child: Image.asset(
        'asset/images/loding1.png',
        width: 68,
        height: 68,
        fit: BoxFit.contain,
      ),
    );
  }
}
