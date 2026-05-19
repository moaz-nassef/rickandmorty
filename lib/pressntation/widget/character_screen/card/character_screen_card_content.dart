import 'package:flutter/material.dart';
import 'package:rickandmorty/data/model/characterModel.dart';
import 'package:rickandmorty/pressntation/widget/character_screen/card/character_screen_card_status_color.dart';
import 'package:rickandmorty/pressntation/widget/character_screen/character_screen_info_pill.dart';

class CharacterScreenCardContent extends StatelessWidget {
  final Character character;

  const CharacterScreenCardContent({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    final statusColor = characterScreenCardStatusColor(character.status);

    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 18, 0, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '#${character.charid.toString().padLeft(3, '0')}',
            style: TextStyle(
              color: const Color(0xff17261d).withValues(alpha: .65),
              fontSize: 13,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            character.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xff132318),
              fontSize: 23,
              fontWeight: FontWeight.w900,
              height: 1.02,
            ),
          ),
          const Spacer(),
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
    );
  }
}
