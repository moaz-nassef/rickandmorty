import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/presentation/bloc/character/character_cubit.dart';
import 'package:rickandmorty/consstant/string.dart';
import 'package:rickandmorty/presentation/widget/shared/app_interaction_feedback.dart';

class CharacterScreenHeaderSearchField extends StatelessWidget {
  final TextEditingController searchController;

  const CharacterScreenHeaderSearchField({
    super.key,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      cursorColor: Mycoloer.myyellow,
      style: const TextStyle(
        color: Mycoloer.mywhite,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      onChanged: context.read<CharacterCubit>().searchCharacters,
      decoration: InputDecoration(
        hintText: 'Search characters',
        hintStyle: TextStyle(
          color: Mycoloer.mywhite.withValues(alpha: .46),
          fontWeight: FontWeight.w500,
        ),
        prefixIcon: const Icon(Icons.search_rounded, color: Mycoloer.myyellow),
        suffixIcon: ValueListenableBuilder<TextEditingValue>(
          valueListenable: searchController,
          builder: (context, value, _) {
            if (value.text.isEmpty) {
              return const SizedBox.shrink();
            }

            return IconButton(
              tooltip: 'Clear',
              icon: const Icon(Icons.close_rounded, color: Mycoloer.mywhite),
              onPressed: () {
                AppInteractionFeedback.tap();
                searchController.clear();
                context.read<CharacterCubit>().searchCharacters('');
              },
            );
          },
        ),
        filled: true,
        fillColor: const Color(0xff243037),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
            color: Mycoloer.mywhite.withValues(alpha: .08),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Mycoloer.myyellow, width: 1.3),
        ),
      ),
    );
  }
}
