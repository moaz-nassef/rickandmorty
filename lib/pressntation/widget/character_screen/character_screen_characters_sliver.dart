import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/bussiness_logic/cubit/cubit/character_cubit.dart';
import 'package:rickandmorty/pressntation/widget/character_screen/character_screen_animated_card.dart';
import 'package:rickandmorty/pressntation/widget/character_screen/character_screen_empty_view.dart';
import 'package:rickandmorty/pressntation/widget/character_screen/character_screen_failure_view.dart';
import 'package:rickandmorty/pressntation/widget/character_screen/loading_view/character_screen_loading_view.dart';

class CharacterScreenCharactersSliver extends StatelessWidget {
  const CharacterScreenCharactersSliver({super.key});

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

        // في حالة حدوث خطأ
        if (state is CharacterFailure) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: CharacterScreenFailureView(
              message: state.message,
            ),
          );
        }

        // في حالة نجاح تحميل البيانات
        if (state is CharactersLoaded) {
          // إذا القائمة فارغة
          if (state.characters.isEmpty) {
            return const SliverFillRemaining(
              hasScrollBody: false,
              child: CharacterScreenEmptyView(),
            );
          }

          // عرض قائمة الشخصيات
          return SliverPadding(
            padding: const EdgeInsets.fromLTRB(18, 8, 18, 28),
            sliver: SliverList.separated(
              itemCount: state.characters.length,
              separatorBuilder: (_, _) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                return CharacterScreenAnimatedCard(
                  index: index,
                  character: state.characters[index],
                );
              },
            ),
          );
        }

        // الحالة الافتراضية (CharacterInitial)
        return const SliverFillRemaining(
          hasScrollBody: false,
          child: CharacterScreenLoadingView(),
        );
      },
    );
  }
}