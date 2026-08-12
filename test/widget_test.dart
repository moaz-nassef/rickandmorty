import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rickandmorty/data/API_services/character_web_service.dart';
import 'package:rickandmorty/data/model/characterModel.dart';
import 'package:rickandmorty/data/repository/character_repository.dart';
import 'package:rickandmorty/presentation/bloc/character/character_cubit.dart';
import 'package:rickandmorty/presentation/screens/Character_Screen.dart';

void main() {
  testWidgets('renders the character discovery screen', (tester) async {
    final cubit = _createCubit();
    await cubit.loadPage(1);

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(value: cubit, child: const CharacterScreen()),
      ),
    );

    expect(find.text('Search characters'), findsOneWidget);

    await cubit.close();
  });

  testWidgets('shows no results and restores the list after clearing search', (
    tester,
  ) async {
    final cubit = _createCubit();
    await cubit.loadPage(1);

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(value: cubit, child: const CharacterScreen()),
      ),
    );

    await tester.enterText(find.byType(TextField), 'Birdperson');
    await tester.pump(const Duration(milliseconds: 350));

    expect(find.text('No portal match found'), findsOneWidget);
    expect(find.text('Opening the portal...'), findsNothing);

    await tester.tap(find.byKey(const Key('clear_search_button')));
    await tester.pump();

    expect(find.text('Rick Sanchez'), findsOneWidget);
    await cubit.close();
  });
}

CharacterCubit _createCubit() {
  return CharacterCubit(CharacterRepository(_TestCharacterWebService()));
}

class _TestCharacterWebService extends CharacterWebService {
  @override
  Future<({List<Character> characters, int totalPages})> getCharactersPage(
    int page,
  ) async {
    return (
      characters: [
        Character(
          charid: 1,
          name: 'Rick Sanchez',
          status: 'Alive',
          species: 'Human',
          type: '-',
          gender: 'Male',
          image: '',
          originName: 'Earth',
          locationName: 'Earth',
          episodeCount: 1,
        ),
      ],
      totalPages: 1,
    );
  }
}
