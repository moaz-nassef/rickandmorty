import 'package:flutter/material.dart';
import 'package:rickandmorty/consstant/string.dart';
import 'package:rickandmorty/data/model/characterModel.dart';
import 'package:rickandmorty/presentation/widget/character_screen/card/character_screen_card.dart';
import 'package:rickandmorty/presentation/widget/character_screen/card/character_screen_grid_card.dart';
import 'package:rickandmorty/presentation/widget/character_screen/character_screen_layout_mode.dart';
import 'package:rickandmorty/presentation/widget/shared/character_preview_modal.dart';

class CharacterScreenAnimatedCard extends StatefulWidget {
  final int index;
  final Character character;
  final CharacterScreenLayoutMode layoutMode;

  const CharacterScreenAnimatedCard({
    super.key,
    required this.index,
    required this.character,
    this.layoutMode = CharacterScreenLayoutMode.list,
  });

  @override
  State<CharacterScreenAnimatedCard> createState() =>
      _CharacterScreenAnimatedCardState();
}

class _CharacterScreenAnimatedCardState
    extends State<CharacterScreenAnimatedCard>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final card = widget.layoutMode == CharacterScreenLayoutMode.grid
        ? CharacterScreenGridCard(character: widget.character)
        : CharacterScreenCard(character: widget.character);

    return RepaintBoundary(
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            CharacterDetailScreen,
            arguments: widget.character.charid,
          );
        },
        onLongPressStart: (_) {
          showCharacterPreview(context, widget.character);
        },
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration:
              Duration(milliseconds: 420 + (widget.index % 8) * 70),
          curve: Curves.easeOutCubic,
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, 32 * (1 - value)),
                child: child,
              ),
            );
          },
          child: card,
        ),
      ),
    );
  }
}
