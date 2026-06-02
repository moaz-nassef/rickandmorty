import 'package:flutter/material.dart';
import 'package:rickandmorty/consstant/string.dart';
import 'package:rickandmorty/data/model/characterModel.dart';
import 'package:rickandmorty/presentation/widget/character_screen/card/character_screen_card_character_image.dart';
import 'package:rickandmorty/presentation/widget/character_screen/card/character_screen_card_content.dart';
import 'package:rickandmorty/presentation/widget/character_screen/card/character_screen_card_portal_clipper.dart';

class CharacterScreenCard extends StatelessWidget {
  final Character character;

  const CharacterScreenCard({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CharacterScreenCardPortalClipper(),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              CharacterDetailScreen,
              arguments: character.charid,
            );
          },
          child: Ink(
            height: 150,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xffefffe4),
                  Color(0xffc8f55b),
                  Color(0xff67bd4b),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .25),
                  blurRadius: 20,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                  right: -34,
                  top: -44,
                  child: Container(
                    width: 138,
                    height: 138,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withValues(alpha: .34),
                        width: 18,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 18,
                  top: 18,
                  bottom: 18,
                  child: CharacterScreenCardCharacterImage(
                    character: character,
                  ),
                ),
                Positioned.fill(
                  right: 132,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    clipBehavior: Clip.hardEdge,
                    child: CharacterScreenCardContent(character: character),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
