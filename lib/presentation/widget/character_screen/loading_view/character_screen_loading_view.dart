import 'package:flutter/material.dart';
import 'package:rickandmorty/presentation/widget/character_screen/loading_view/character_screen_loading_scale_animation.dart';
import 'package:rickandmorty/presentation/widget/character_screen/loading_view/character_screen_loading_spinner.dart';

class CharacterScreenLoadingView extends StatelessWidget {
  const CharacterScreenLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CharacterScreenLoadingScaleAnimation(
            child: CharacterScreenLoadingSpinner(),
          ),
          SizedBox(height: 18),
          Text(
            'Opening the portal...',
            style: TextStyle(
              color: Color(0xffE5E8EB),
              fontSize: 15,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.4,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Finding characters across dimensions',
            style: TextStyle(color: Color(0xffE5E8EB), fontSize: 12),
          ),
        ],
      ),
    );
  }
}
