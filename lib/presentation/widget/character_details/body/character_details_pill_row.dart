import 'package:flutter/material.dart';
import 'package:rickandmorty/presentation/widget/character_details/body/character_details_pill.dart';

class CharacterDetailsPillRow extends StatelessWidget {
  final Color statusColor;
  final String status;
  final String species;
  final String gender;
  final String type;
  final AnimationController staggerController;

  const CharacterDetailsPillRow({
    super.key,
    required this.statusColor,
    required this.status,
    required this.species,
    required this.gender,
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
          curve: const Interval(0.35, 0.75, curve: Curves.easeOutCubic),
        );

        return Opacity(
          opacity: curved.value,
          child: Transform.translate(
            offset: Offset(0, 16 * (1 - curved.value)),
            child: child,
          ),
        );
      },
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        alignment: WrapAlignment.center,
        children: [
          CharacterDetailsPill(
            label: status.isNotEmpty ? status : 'Unknown',
            color: statusColor,
          ),
          CharacterDetailsPill(
            label: species.isNotEmpty ? species : 'Unknown',
            color: const Color(0xff4a5c6b),
          ),
          CharacterDetailsPill(
            label: gender.isNotEmpty ? gender : 'Unknown',
            color: const Color(0xff4a5c6b),
          ),
          CharacterDetailsPill(
            label: type.isNotEmpty ? type : 'Unknown',
            color: const Color(0xff3d4d5a),
          ),
        ],
      ),
    );
  }
}
