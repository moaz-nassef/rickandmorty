import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rickandmorty/data/model/characterModel.dart';
import 'package:rickandmorty/presentation/widget/character_screen/card/character_screen_card_status_color.dart';
import 'package:rickandmorty/presentation/widget/shared/shimmer_placeholder.dart';

class CharacterScreenCard extends StatelessWidget {
  final Character character;

  const CharacterScreenCard({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    final statusColor = characterScreenCardStatusColor(character.status);

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: const Color(0xff17272c).withValues(alpha: 0.92),
        border: Border.all(color: Colors.white.withValues(alpha: 0.09)),
        boxShadow: [
          BoxShadow(
            color: statusColor.withValues(alpha: 0.12),
            blurRadius: 28,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: SizedBox(
        height: 164,
        child: Stack(
          children: [
            Positioned(
              top: -54,
              right: -40,
              child: _PortalHalo(color: statusColor, size: 188),
            ),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 16, 132, 16),
                child: _CharacterSummary(
                  character: character,
                  statusColor: statusColor,
                ),
              ),
            ),
            Positioned(
              top: 14,
              right: 14,
              bottom: 14,
              child: _CharacterPortrait(character: character, size: 132),
            ),
          ],
        ),
      ),
    );
  }
}

class _CharacterSummary extends StatelessWidget {
  final Character character;
  final Color statusColor;

  const _CharacterSummary({required this.character, required this.statusColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '#${character.charid.toString().padLeft(3, '0')}',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.48),
                fontSize: 11,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(width: 8),
            _StatusLabel(label: character.status, color: statusColor),
          ],
        ),
        const Spacer(),
        Text(
          character.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 21,
            fontWeight: FontWeight.w900,
            height: 1.04,
          ),
        ),
        const SizedBox(height: 9),
        Text(
          '${character.species}  |  ${character.gender}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.65),
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 14,
              color: const Color(0xffb7ff3c).withValues(alpha: 0.9),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                character.locationName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.48),
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _StatusLabel extends StatelessWidget {
  final String label;
  final Color color;

  const _StatusLabel({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.13),
        borderRadius: BorderRadius.circular(99),
        border: Border.all(color: color.withValues(alpha: 0.42)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 4),
          Text(
            label.toUpperCase(),
            style: TextStyle(
              color: color,
              fontSize: 9,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.7,
            ),
          ),
        ],
      ),
    );
  }
}

class _CharacterPortrait extends StatelessWidget {
  final Character character;
  final double size;

  const _CharacterPortrait({required this.character, required this.size});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'character-image-${character.charid}',
      child: Container(
        width: size,
        height: size,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withValues(alpha: 0.22)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x55000000),
              blurRadius: 16,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: CachedNetworkImage(
            imageUrl: character.image,
            fit: BoxFit.cover,
            placeholder: (_, _) => const ShimmerPlaceholder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            errorWidget: (_, _, _) => const ColoredBox(
              color: Color(0xff243037),
              child: Icon(Icons.person_rounded, color: Colors.white, size: 44),
            ),
          ),
        ),
      ),
    );
  }
}

class _PortalHalo extends StatelessWidget {
  final Color color;
  final double size;

  const _PortalHalo({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color.withValues(alpha: 0.2), width: 20),
        boxShadow: [
          BoxShadow(color: color.withValues(alpha: 0.14), blurRadius: 28),
        ],
      ),
    );
  }
}
