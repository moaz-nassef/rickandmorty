import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rickandmorty/data/model/characterModel.dart';
import 'package:rickandmorty/data/repository/character_repository.dart';

part 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {
  final CharacterRepository characterRepository;
  List<Character> allCharacters = [];

  CharacterCubit(this.characterRepository) : super(CharacterInitial());

  Future<void> getAllCharacters({bool refresh = false}) async {
    if (refresh) {
      allCharacters = [];
    }

    if (allCharacters.isEmpty) {
      emit(CharacterLoading());
    }

    try {
      allCharacters = await characterRepository.getAllCharacters();
      emit(CharactersLoaded(allCharacters));
    } catch (e) {
      if (allCharacters.isNotEmpty) {
        emit(CharactersLoaded(allCharacters));
      } else {
        emit(CharacterFailure(e.toString()));
      }
    }
  }

  void searchCharacters(String searchedCharacter) {
    final query = searchedCharacter.trim().toLowerCase();

    if (query.isEmpty) {
      emit(CharactersLoaded(allCharacters));
      return;
    }

    final filteredCharacters = allCharacters.where((character) {
      return character.name.toLowerCase().startsWith(query);
    }).toList();

    emit(CharactersLoaded(filteredCharacters));
  }

  Future<void> getCharacterById(int id) async {
    emit(CharacterLoading());

    try {
      final character = await characterRepository.getCharacterById(id);
      emit(CharacterDetailsLoaded(character));
    } catch (e) {
      emit(CharacterFailure(e.toString()));
    }
  }
}