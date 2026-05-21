import 'package:flutter/material.dart';

class CharacterScreenLoadingProgressRing extends StatelessWidget {
  const CharacterScreenLoadingProgressRing({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 104,
      height: 104,
      child: CircularProgressIndicator(
        strokeWidth: 7,
        color: Color.fromARGB(255, 23, 255, 7),
        backgroundColor: Color(0xff243037),
      ),
    );
  }
}
