import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/bussiness_logic/cubit/cubit/character_cubit.dart';
import 'package:rickandmorty/presentation/widget/character_screen/character_screen_animated_card.dart';
import 'package:rickandmorty/presentation/widget/character_screen/character_screen_empty_view.dart';
import 'package:rickandmorty/presentation/widget/character_screen/character_screen_failure_view.dart';
import 'package:rickandmorty/presentation/widget/character_screen/character_screen_layout_mode.dart';
import 'package:rickandmorty/presentation/widget/character_screen/loading_view/character_screen_loading_view.dart';

class CharacterScreenCharactersSliver extends StatelessWidget {
  final CharacterScreenLayoutMode layoutMode;

  const CharacterScreenCharactersSliver({super.key, required this.layoutMode});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterCubit, CharacterState>(
      builder: (context, state) {
        // أثناء التحميل
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

        // في حالة نجاح تحميل البيانات
        if (state is CharactersLoaded) {
          if (state.characters.isEmpty) {
            return const SliverFillRemaining(
              hasScrollBody: false,
              child: CharacterScreenEmptyView(),
            );
          }

          if (layoutMode == CharacterScreenLayoutMode.grid) {
            final screenWidth = MediaQuery.of(context).size.width;

            const double minItemWidth = 200;

            int crossAxisCount = (screenWidth / minItemWidth).floor();

            if (crossAxisCount < 2) {
              crossAxisCount = 2;
            }

            const double childAspectRatio = 0.79;

            return SliverPadding(
              padding: const EdgeInsets.fromLTRB(18, 8, 18, 88),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: childAspectRatio,
                ),
                delegate: SliverChildBuilderDelegate((context, index) {
                  return CharacterScreenAnimatedCard(
                    index: index,
                    character: state.characters[index],
                    layoutMode: layoutMode,
                  );
                }, childCount: state.characters.length),
              ),
            );
          }

          return SliverPadding(
            padding: const EdgeInsets.fromLTRB(18, 8, 18, 88),
            sliver: SliverList.separated(
              itemCount: state.characters.length,
              separatorBuilder: (_, _) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                return CharacterScreenAnimatedCard(
                  index: index,
                  character: state.characters[index],
                  layoutMode: layoutMode,
                );
              },
            ),
          );
        }

        return const SliverFillRemaining(
          hasScrollBody: false,
          child: CharacterScreenLoadingView(),
        );
      },
    );
  }
}
