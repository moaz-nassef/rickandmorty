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
  int currentPage = 1;
  int totalPages = 1;
  Timer? _debounceTimer;

  CharacterCubit(this.characterRepository) : super(CharacterInitial());

  Future<void> getAllCharacters({bool refresh = false, int page = 1}) async {
    if (refresh) {
      allCharacters = [];
    }

    emit(CharacterLoading());

    try {
      final response = await characterRepository.getCharactersPage(page);
      currentPage = response.currentPage;
      totalPages = response.totalPages;
      allCharacters = response.characters;

      emit(CharactersLoaded(
        allCharacters,
        currentPage: currentPage,
        totalPages: totalPages,
      ));
    } catch (e) {
      if (allCharacters.isNotEmpty) {
        emit(CharactersLoaded(
          allCharacters,
          currentPage: currentPage,
          totalPages: totalPages,
        ));
      } else {
        emit(CharacterFailure(e.toString()));
      }
    }
  }

  Future<void> goToPage(int page) async {
    if (page < 1 || page > totalPages) return;

    emit(CharacterLoading());

    try {
      final response = await characterRepository.getCharactersPage(page);
      currentPage = response.currentPage;
      totalPages = response.totalPages;
      allCharacters = response.characters;

      emit(CharactersLoaded(
        allCharacters,
        currentPage: currentPage,
        totalPages: totalPages,
      ));
    } catch (e) {
      emit(CharactersLoaded(
        allCharacters,
        currentPage: currentPage,
        totalPages: totalPages,
      ));
    }
  }

  void searchCharacters(String searchedCharacter) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      final query = searchedCharacter.trim().toLowerCase();

      if (query.isEmpty) {
        emit(CharactersLoaded(
          allCharacters,
          currentPage: currentPage,
          totalPages: totalPages,
        ));
        return;
      }

      final filteredCharacters = allCharacters.where((character) {
        return character.name.toLowerCase().contains(query);
      }).toList();

      emit(CharactersLoaded(
        filteredCharacters,
        currentPage: currentPage,
        totalPages: totalPages,
      ));
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
