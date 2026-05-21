import 'package:flutter/material.dart';
import 'package:rickandmorty/presentation/widget/character_screen/loading_view/character_screen_loading_scale_animation.dart';
import 'package:rickandmorty/presentation/widget/character_screen/loading_view/character_screen_loading_spinner.dart';

class CharacterScreenLoadingView extends StatelessWidget {
  const CharacterScreenLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CharacterScreenLoadingScaleAnimation(
        child: CharacterScreenLoadingSpinner(),
      ),
    );
  }
}
