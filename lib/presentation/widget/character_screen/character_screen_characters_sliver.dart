import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/data/model/characterModel.dart';
import 'package:rickandmorty/presentation/bloc/character/character_cubit.dart';
import 'package:rickandmorty/presentation/widget/character_screen/character_screen_animated_card.dart';
import 'package:rickandmorty/presentation/widget/character_screen/character_screen_empty_view.dart';
import 'package:rickandmorty/presentation/widget/character_screen/character_screen_failure_view.dart';
import 'package:rickandmorty/presentation/widget/character_screen/character_screen_layout_mode.dart';
import 'package:rickandmorty/presentation/widget/character_screen/loading_view/character_screen_loading_view.dart';

class CharacterScreenCharactersSliver extends StatelessWidget {
  final CharacterScreenLayoutMode layoutMode;
  final VoidCallback onClearSearch;

  const CharacterScreenCharactersSliver({
    super.key,
    required this.layoutMode,
    required this.onClearSearch,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterCubit, CharacterState>(
      buildWhen: (prev, current) {
        if (current is CharactersLoaded && prev is CharactersLoaded) {
          if (current.characters != prev.characters) return true;
          return false;
        }
        return true;
      },
      builder: (context, state) {
        if (state is CharacterLoading) {
          return const SliverFillRemaining(
            hasScrollBody: false,
            child: CharacterScreenLoadingView(),
          );
        }

        if (state is CharacterFailure) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: CharacterScreenFailureView(message: state.message),
          );
        }

        if (state is CharacterSearchEmpty) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: CharacterScreenEmptyView(onClearSearch: onClearSearch),
          );
        }

        if (state is CharacterNetworkError) {
          return const SliverFillRemaining(
            hasScrollBody: false,
            child: CharacterScreenFailureView(
              message: 'Check your connection, then reopen the portal.',
            ),
          );
        }

        if (state is CharacterOfflineWithCache) {
          if (layoutMode == CharacterScreenLayoutMode.grid) {
            return _buildGrid(
              context,
              state.cachedCharacters,
              state.currentPage,
            );
          }
          return _buildList(context, state.cachedCharacters, state.currentPage);
        }

        if (state is CharactersLoaded) {
          if (state.characters.isEmpty) {
            return SliverFillRemaining(
              hasScrollBody: false,
              child: CharacterScreenEmptyView(onClearSearch: onClearSearch),
            );
          }

          if (layoutMode == CharacterScreenLayoutMode.grid) {
            return _buildGrid(context, state.characters, state.currentPage);
          }

          return _buildList(context, state.characters, state.currentPage);
        }

        return const SliverFillRemaining(
          hasScrollBody: false,
          child: CharacterScreenLoadingView(),
        );
      },
    );
  }

  Widget _buildList(
    BuildContext context,
    List<Character> characters,
    int page,
  ) {
    return SliverPadding(
      key: ValueKey('list_page_$page'),
      padding: const EdgeInsets.fromLTRB(18, 8, 18, 12),
      sliver: SliverList.separated(
        itemCount: characters.length,
        separatorBuilder: (_, _) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          return CharacterScreenAnimatedCard(
            index: index,
            character: characters[index],
            layoutMode: layoutMode,
          );
        },
      ),
    );
  }

  Widget _buildGrid(
    BuildContext context,
    List<Character> characters,
    int page,
  ) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    const double minItemWidth = 200;
    int crossAxisCount = (screenWidth / minItemWidth).floor();
    if (crossAxisCount < 2) crossAxisCount = 2;

    return SliverPadding(
      key: ValueKey('grid_page_$page'),
      padding: const EdgeInsets.fromLTRB(18, 8, 18, 12),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.79,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) => CharacterScreenAnimatedCard(
            index: index,
            character: characters[index],
            layoutMode: layoutMode,
          ),
          childCount: characters.length,
        ),
      ),
    );
  }
}
