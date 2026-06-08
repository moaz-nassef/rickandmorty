import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rickandmorty/consstant/string.dart';
import 'package:rickandmorty/data/model/characterModel.dart';
import 'package:rickandmorty/presentation/widget/character_screen/card/character_screen_card_status_color.dart';
import 'package:rickandmorty/presentation/widget/character_screen/character_screen_info_pill.dart';
import 'package:rickandmorty/presentation/widget/shared/shimmer_placeholder.dart';

class CharacterScreenGridCard extends StatelessWidget {
  final Character character;

  const CharacterScreenGridCard({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    final statusColor = characterScreenCardStatusColor(character.status);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(28),
        child: InkWell(
          borderRadius: BorderRadius.circular(28),
          splashColor: Colors.white.withValues(alpha: 0.15),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xfffbfff4),
                  Color(0xffd9ff75),
                  Color(0xff69c249),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.12),
                  blurRadius: 18,
                  offset: const Offset(0, 10),
                ),
              ],
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.35),
                width: 1.3,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.22),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        '#${character.charid.toString().padLeft(3, '0')}',
                        style: TextStyle(
                          color: const Color(0xff17261d).withValues(alpha: .72),
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 1),
                  Expanded(
                    child: Hero(
                      tag: 'character-image-${character.charid}',
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: const Color(0xff243037),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: CachedNetworkImage(
                              imageUrl: character.image,
                              fit: BoxFit.cover,
                              placeholder: (_, _) => const ShimmerPlaceholder(
                                borderRadius: BorderRadius.all(Radius.circular(24)),
                              ),
                              errorWidget: (_, _, _) => const ColoredBox(
                                color: Color(0xff243037),
                                child: Center(
                                  child: Icon(
                                    Icons.person_rounded,
                                    color: Mycoloer.mywhite,
                                    size: 44,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    character.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xff122417),
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 5),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Wrap(
                      spacing: 1,
                      runSpacing: 1,
                      alignment: WrapAlignment.center,
                      children: [
                        CharacterScreenInfoPill(
                          label: character.status,
                          color: statusColor,
                        ),
                        const SizedBox(width: 3),
                        CharacterScreenInfoPill(
                          label: character.species,
                          color: const Color(0xff243037),
                        ),
                        const SizedBox(width: 3),
                        CharacterScreenInfoPill(
                          label: character.gender,
                          color: const Color(0xff243037),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 3),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
