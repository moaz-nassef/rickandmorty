import 'package:flutter/material.dart';
import 'package:rickandmorty/consstant/string.dart';
import 'package:rickandmorty/data/model/characterModel.dart';
import 'package:rickandmorty/presentation/widget/character_details/body/character_details_extra_info.dart';
import 'package:rickandmorty/presentation/widget/character_details/body/character_details_info_card.dart';
import 'package:rickandmorty/presentation/widget/character_details/body/character_details_pill_row.dart';

class CharacterDetailsBody extends StatelessWidget {
  final Character character;
  final Animation<double> contentFade;
  final AnimationController staggerController;
  final Color statusColor;

  const CharacterDetailsBody({
    super.key,
    required this.character,
    required this.contentFade,
    required this.staggerController,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          _buildName(),
          const SizedBox(height: 14),
          CharacterDetailsInfoCard(
            icon: Icons.public_rounded,
            label: 'Origin',
            value: character.originName,
            delay: 0.1,
            staggerController: staggerController,
          ),
          const SizedBox(height: 10),
          CharacterDetailsInfoCard(
            icon: Icons.location_on_rounded,
            label: 'Location',
            value: character.locationName,
            delay: 0.2,
            staggerController: staggerController,
          ),
          const SizedBox(height: 20),
          CharacterDetailsPillRow(
            statusColor: statusColor,
            status: character.status,
            species: character.species,
            gender: character.gender,
            type: character.type,
            staggerController: staggerController,
          ),
          const SizedBox(height: 20),
          CharacterDetailsExtraInfo(
            episodeCount: character.episodeCount.toString(),
            type: character.type,
            staggerController: staggerController,
          ),
        ],
      ),
    );
  }

  Widget _buildName() {
    return AnimatedBuilder(
      animation: staggerController,
      builder: (context, child) {
        return Opacity(
          opacity: contentFade.value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - contentFade.value)),
            child: child,
          ),
        );
      },
      child: Column(
        children: [
          Text(
            '#${character.charid.toString().padLeft(3, '0')}',
            style: TextStyle(
              color: Mycoloer.myyellow.withOpacity(0.5),
              fontSize: 14,
              fontWeight: FontWeight.w800,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            character.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Mycoloer.mywhite,
              fontSize: 32,
              fontWeight: FontWeight.w900,
              height: 1.1,
            ),
          ),
        ],
      ),
    );
  }
}
