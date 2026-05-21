import 'package:flutter/material.dart';
import 'package:rickandmorty/consstant/string.dart';
import 'package:rickandmorty/presentation/widget/character_details/body/character_details_stat_item.dart';

class CharacterDetailsExtraInfo extends StatelessWidget {
  final String episodeCount;
  final String type;
  final AnimationController staggerController;

  const CharacterDetailsExtraInfo({
    super.key,
    required this.episodeCount,
    required this.type,
    required this.staggerController,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: staggerController,
      builder: (context, child) {
        final curved = CurvedAnimation(
          parent: staggerController,
          curve: const Interval(0.5, 0.9, curve: Curves.easeOutCubic),
        );

        return Opacity(
          opacity: curved.value,
          child: Transform.translate(
            offset: Offset(0, 16 * (1 - curved.value)),
            child: child,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xff1e282f),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Mycoloer.myyellow.withOpacity(0.08)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CharacterDetailsStatItem(label: 'Episodes', value: episodeCount),
            Container(
              width: 1,
              height: 40,
              color: Colors.white.withOpacity(0.08),
            ),
            CharacterDetailsStatItem(
              label: 'Type',
              value: type.isNotEmpty ? type : 'Unknown',
            ),
          ],
        ),
      ),
    );
  }
}
