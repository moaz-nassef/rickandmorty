import 'package:flutter/material.dart';
import 'package:rickandmorty/data/model/characterModel.dart';
import 'package:rickandmorty/presentation/widget/character_details/body/character_details_body.dart';
import 'package:rickandmorty/presentation/widget/character_details/header/character_details_header.dart';

class CharacterDetailsContent extends StatelessWidget {
  final Character character;
  final Animation<double> imageScale;
  final Animation<double> contentFade;
  final AnimationController staggerController;
  final Color statusColor;

  const CharacterDetailsContent({
    super.key,
    required this.character,
    required this.imageScale,
    required this.contentFade,
    required this.staggerController,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          CharacterDetailsHeader(
            character: character,
            imageScale: imageScale,
            contentFade: contentFade,
            staggerController: staggerController,
            statusColor: statusColor,
          ),
          CharacterDetailsBody(
            character: character,
            contentFade: contentFade,
            staggerController: staggerController,
            statusColor: statusColor,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
