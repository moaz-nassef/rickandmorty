import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:rickandmorty/data/model/characterModel.dart';
import 'package:rickandmorty/data/repository/character_repository.dart';

part 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {
  final CharacterRepository characterRepository;
  Timer? _debounceTimer;
  bool _isLoadingPage = false;
  bool _isInitialLoad = true;

  CharacterCubit(this.characterRepository) : super(CharacterInitial());

  Set<int> get cachedPages => characterRepository.cachedPages;
  List<Character>? pageCharacters(int page) =>
      characterRepository.pageCharacters(page);

  Future<void> loadPage(int page) async {
    if (_isLoadingPage) return;
    if (page < 1) return;
    if (_isInitialLoad && page == _currentPage && state is CharactersLoaded) {
      return;
    }

    _isLoadingPage = true;

    if (characterRepository.isPageCached(page)) {
      final cached = await characterRepository.getCharactersPage(page);
      _isLoadingPage = false;
      _isInitialLoad = false;
      emit(CharactersLoaded(
        cached.characters,
        currentPage: page,
        totalPages: cached.totalPages,
      ));
      _prefetchNext(page);
      return;
    }

    final hasCache = characterRepository.cachedPages.isNotEmpty;
    final previousState = state;
    final previousPage = _currentPage;

    if (!hasCache) {
      emit(CharacterLoading());
    } else if (previousState is CharactersLoaded) {
      emit(CharactersLoaded(
        previousState.characters,
        currentPage: previousState.currentPage,
        totalPages: previousState.totalPages,
        isLoadingPage: true,
      ));
    }

    try {
      final result = await characterRepository.getCharactersPage(page);
      _isLoadingPage = false;
      _isInitialLoad = false;
      
      // Handle empty list case
      if (result.characters.isEmpty) {
        emit(CharacterSearchEmpty());
        return;
      }
      
      emit(CharactersLoaded(
        result.characters,
        currentPage: page,
        totalPages: result.totalPages,
      ));
      _prefetchNext(page);
    } on NetworkException {
      _isLoadingPage = false;
      _isInitialLoad = false;
      
      if (hasCache) {
        // We have cached data, show offline with cache
        final pages = characterRepository.cachedPages.toList()..sort();
        if (pages.isNotEmpty) {
          // Check if the requested page is cached
          if (characterRepository.isPageCached(page)) {
            final cached = await characterRepository.getCharactersPage(page);
            emit(CharacterOfflineWithCache(
              cachedCharacters: cached.characters,
              currentPage: page,
              totalPages: cached.totalPages,
            ));
          } else {
            // Page not cached, show first available cached page
            final fallback = await characterRepository.getCharactersPage(pages.first);
            emit(CharacterOfflineWithCache(
              cachedCharacters: fallback.characters,
              currentPage: pages.first,
              totalPages: fallback.totalPages,
            ));
          }
        } else {
          emit(CharacterNetworkError());
        }
      } else {
        emit(CharacterNetworkError());
      }
    } on NotFoundException {
      _isLoadingPage = false;
      _isInitialLoad = false;
      emit(CharacterSearchEmpty());
    } catch (e) {
      _isLoadingPage = false;
      _isInitialLoad = false;

      if (!hasCache) {
        emit(CharacterFailure(e.toString()));
      } else if (previousState is CharactersLoaded) {
        emit(CharactersLoaded(
          previousState.characters,
          currentPage: previousPage,
          totalPages: characterRepository.totalPages,
          errorMessage: e.toString(),
        ));
      } else {
        final pages = characterRepository.cachedPages.toList()..sort();
        if (pages.isNotEmpty) {
          final fallback =
              await characterRepository.getCharactersPage(pages.first);
          emit(CharactersLoaded(
            fallback.characters,
            currentPage: pages.first,
            totalPages: fallback.totalPages,
            errorMessage: e.toString(),
          ));
        } else {
          emit(CharacterFailure(e.toString()));
        }
      }
    }
  }

  int get _totalPages => characterRepository.totalPages;

  int get _currentPage {
    if (state is CharactersLoaded) {
      return (state as CharactersLoaded).currentPage;
    }
    if (state is CharacterOfflineWithCache) {
      return (state as CharacterOfflineWithCache).currentPage;
    }
    return 1;
  }

  void nextPage() {
    final next = _currentPage + 1;
    if (next <= _totalPages) loadPage(next);
  }

  void previousPage() {
    final prev = _currentPage - 1;
    if (prev >= 1) loadPage(prev);
  }

  Future<void> _prefetchNext(int page) async {
    final next = page + 1;
    if (next > characterRepository.totalPages) return;
    if (!characterRepository.isPageCached(next)) {
      try {
        await characterRepository.getCharactersPage(next);
      } catch (_) {}
    }
  }

  void searchCharacters(String searchedCharacter) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      final query = searchedCharacter.trim().toLowerCase();

      if (query.isEmpty) {
        final cached = characterRepository.pageCharacters(_currentPage);
        if (cached != null) {
          emit(CharactersLoaded(
            List.from(cached),
            currentPage: _currentPage,
            totalPages: characterRepository.totalPages,
          ));
        }
        return;
      }

      final allChars = characterRepository.cachedPages
          .expand<Character>(
              (p) => characterRepository.pageCharacters(p) ?? <Character>[])
          .toList();
      final filtered = allChars
          .where((c) => c.name.toLowerCase().contains(query))
          .toList();

      if (filtered.isEmpty) {
        emit(CharacterSearchEmpty());
      } else {
        emit(CharactersLoaded(filtered, currentPage: 1, totalPages: 1));
      }
    });
  }

  Character? findCharacterById(int id) {
    for (final page in characterRepository.cachedPages) {
      final chars = characterRepository.pageCharacters(page);
      if (chars == null) continue;
      try {
        return chars.firstWhere((c) => c.charid == id);
      } catch (_) {}
    }
    return null;
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
    characterRepository.dispose();
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