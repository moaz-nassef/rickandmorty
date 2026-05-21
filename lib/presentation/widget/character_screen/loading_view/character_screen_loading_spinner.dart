import 'package:flutter/material.dart';
import 'package:rickandmorty/presentation/widget/character_screen/loading_view/character_screen_loading_progress_ring.dart';
import 'package:rickandmorty/presentation/widget/character_screen/loading_view/character_screen_loading_rotating_logo.dart';

class CharacterScreenLoadingSpinner extends StatefulWidget {
  const CharacterScreenLoadingSpinner({super.key});

  @override
  State<CharacterScreenLoadingSpinner> createState() =>
      _CharacterScreenLoadingSpinnerState();
}

class _CharacterScreenLoadingSpinnerState
    extends State<CharacterScreenLoadingSpinner>
    with SingleTickerProviderStateMixin {
  late final AnimationController rotationController;

  @override
  void initState() {
    super.initState();
    rotationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 112,
      height: 112,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const CharacterScreenLoadingProgressRing(),
          CharacterScreenLoadingRotatingLogo(rotation: rotationController),
        ],
      ),
    );
  }
}
