import 'package:flutter/material.dart';
import 'package:rickandmorty/consstant/string.dart';
import 'package:rickandmorty/data/model/characterModel.dart';
import 'package:rickandmorty/pressntation/widget/character_screen/card/character_screen_card_status_color.dart';
import 'package:rickandmorty/pressntation/widget/character_screen/character_screen_info_pill.dart';

class CharacterScreenGridCard extends StatelessWidget {
  final Character character;

  const CharacterScreenGridCard({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    final statusColor = characterScreenCardStatusColor(character.status);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () {
            Navigator.pushNamed(
              context,
              CharacterDetailScreen,
              arguments: character,
            );
          },
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xfff8ffe9),
                  Color(0xffd8fb72),
                  Color(0xff6cc24a),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.18),
                  blurRadius: 18,
                  offset: const Offset(0, 10),
                ),
              ],
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.35),
                width: 1.2,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // رقم الشخصية
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '#${character.charid.toString().padLeft(3, '0')}',
                      style: TextStyle(
                        color: const Color(0xff17261d).withValues(alpha: 0.65),
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Hero(
                    tag: 'character-image-${character.charid}',
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        color: const Color(0xff243037),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.20),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(22),
                        child: Image.network(
                          character.image,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) {
                            return const Center(
                              child: Icon(
                                Icons.person_rounded,
                                color: Mycoloer.mywhite,
                                size: 42,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // اسم الشخصية
                  Text(
                    character.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xff132318),
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      height: 1.15,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      CharacterScreenInfoPill(
                        label: character.status,
                        color: statusColor,
                      ),
                      CharacterScreenInfoPill(
                        label: character.species,
                        color: const Color(0xff243037),
                      ),
                      CharacterScreenInfoPill(
                        label: character.gender,
                        color: const Color(0xff243037),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
