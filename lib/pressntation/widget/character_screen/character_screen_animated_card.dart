import 'package:flutter/material.dart';
import 'package:rickandmorty/data/model/characterModel.dart';
import 'package:rickandmorty/pressntation/widget/character_screen/card/character_screen_card.dart';

class CharacterScreenAnimatedCard extends StatelessWidget {
  final int index;
  final Character character;

  const CharacterScreenAnimatedCard({
    super.key,
    required this.index,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 420 + (index % 8) * 70),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 32 * (1 - value)),
            child: child,
          ),
        );
      },
      child: CharacterScreenCard(character: character),
    );
  }
}
