import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rickandmorty/consstant/string.dart';
import 'package:rickandmorty/data/model/characterModel.dart';
import 'package:rickandmorty/presentation/widget/shared/shimmer_placeholder.dart';

class CharacterScreenCardCharacterImage extends StatelessWidget {
  final Character character;

  const CharacterScreenCardCharacterImage({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'character-image-${character.charid}',
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: CachedNetworkImage(
          imageUrl: character.image,
          width: 114,
          height: 114,
          fit: BoxFit.cover,
          placeholder: (_, _) => const ShimmerPlaceholder(
            width: 114,
            height: 114,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          errorWidget: (_, _, _) => const ColoredBox(
            color: Color(0xff243037),
            child: Icon(
              Icons.person_rounded,
              color: Mycoloer.mywhite,
              size: 44,
            ),
          ),
        ),
      ),
    );
  }
}
