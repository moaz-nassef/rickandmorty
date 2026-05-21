import 'package:flutter/material.dart';
import 'package:rickandmorty/consstant/string.dart';
import 'package:rickandmorty/presentation/widget/character_screen/character_screen_layout_mode.dart';

class CharacterScreenViewToggleButton extends StatelessWidget {
  final CharacterScreenLayoutMode layoutMode;
  final ValueChanged<CharacterScreenLayoutMode> onLayoutModeChanged;

  const CharacterScreenViewToggleButton({
    super.key,
    required this.layoutMode,
    required this.onLayoutModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isGrid = layoutMode == CharacterScreenLayoutMode.grid;

    return FloatingActionButton(
      backgroundColor: Mycoloer.myyellow,
      foregroundColor: const Color(0xff132318),
      tooltip: isGrid ? 'List view' : 'Grid view',
      onPressed: () {
        onLayoutModeChanged(
          isGrid
              ? CharacterScreenLayoutMode.list
              : CharacterScreenLayoutMode.grid,
        );
      },
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 220),
        transitionBuilder: (child, animation) {
          return RotationTransition(
            turns: Tween<double>(begin: .85, end: 1).animate(animation),
            child: FadeTransition(opacity: animation, child: child),
          );
        },
        child: Icon(
          isGrid ? Icons.view_list_rounded : Icons.grid_view_rounded,
          key: ValueKey(isGrid),
        ),
      ),
    );
  }
}
