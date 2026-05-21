import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rickandmorty/data/model/characterModel.dart';
import 'package:rickandmorty/data/repository/character_repository.dart';

part 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {
  final CharacterRepository characterRepository;
  List<Character> allCharacters = [];
  Timer? _debounceTimer;

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
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      final query = searchedCharacter.trim().toLowerCase();

      if (query.isEmpty) {
        emit(CharactersLoaded(allCharacters));
        return;
      }

      final filteredCharacters = allCharacters.where((character) {
        return character.name.toLowerCase().contains(query);
      }).toList();

      emit(CharactersLoaded(filteredCharacters));
    });
  }

  Character? findCharacterById(int id) {
    try {
      return allCharacters.firstWhere((c) => c.charid == id);
    } catch (_) {
      return null;
    }
  }

  void loadCharacterById(int id) {
    final character = findCharacterById(id);
    if (character != null) {
      emit(CharacterDetailsLoaded(character));
    } else {
      emit(CharacterFailure('Character #$id not found'));
    }
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
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
