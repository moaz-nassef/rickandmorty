import 'package:flutter/material.dart';
import 'package:rickandmorty/consstant/string.dart';
import 'package:rickandmorty/data/model/characterModel.dart';

class CharacterScreenCardCharacterImage extends StatelessWidget {
  final Character character;

  const CharacterScreenCardCharacterImage({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'character-image-${character.charid}',
      child: ClipOval(
        child: Image.network(
          character.image,
          width: 116,
          height: 136,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) {
            return const ColoredBox(
              color: Color(0xff243037),
              child: Icon(
                Icons.person_rounded,
                color: Mycoloer.mywhite,
                size: 44,
              ),
            );
          },
        ),
      ),
    );
  }
}
