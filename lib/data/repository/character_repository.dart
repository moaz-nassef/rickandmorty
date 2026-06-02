import 'dart:async';
import 'package:rickandmorty/data/API_services/character_web_service.dart';
import 'package:rickandmorty/data/model/characterModel.dart';

class CharactersPageResult {
  final List<Character> characters;
  final int totalPages;
  final bool fromCache;

  CharactersPageResult({
    required this.characters,
    required this.totalPages,
    this.fromCache = false,
  });
}

class CharacterRepository {
  final CharacterWebService _characterWebService;
  final Map<int, List<Character>> _pageCache = {};
  int _totalPages = 1;
  static const int _maxRetries = 3;

  CharacterRepository(this._characterWebService);

  bool isPageCached(int page) => _pageCache.containsKey(page);
  int get totalPages => _totalPages;
  Set<int> get cachedPages => Set.unmodifiable(_pageCache.keys);

  List<Character>? pageCharacters(int page) => _pageCache[page];

  Future<CharactersPageResult> getCharactersPage(int page) async {
    if (_pageCache.containsKey(page)) {
      return CharactersPageResult(
        characters: List.from(_pageCache[page]!),
        totalPages: _totalPages,
        fromCache: true,
      );
    }
    return _fetchAndCachePage(page);
  }

  Future<CharactersPageResult> _fetchAndCachePage(int page) async {
  for (int attempt = 0; attempt < _maxRetries; attempt++) {
    try {
      final result = await _characterWebService.getCharactersPage(page);
      _pageCache[page] = List.from(result.characters);
      _totalPages = result.totalPages;
      return CharactersPageResult(
        characters: List.from(result.characters),
        totalPages: result.totalPages,
      );
    } catch (e) {
      await Future.delayed(Duration(seconds: 2 * (attempt + 1)));

      if (attempt == _maxRetries - 1) {
        if (_pageCache.isNotEmpty) {
          final fallback = _pageCache.entries.first;
          return CharactersPageResult(
            characters: List.from(fallback.value),
            totalPages: _totalPages,
            fromCache: true,
          );
        }
        rethrow;
      }
    }
  }
  throw Exception('Failed to load page $page');
}

  Future<Character> getCharacterById(int id) async {
    final cached =
        _pageCache.values.expand((list) => list).where((c) => c.charid == id);
    if (cached.isNotEmpty) return cached.first;

    try {
      return await _characterWebService.getCharacterById(id);
    } catch (e) {
      rethrow;
    }
  }

  bool hasCachedCharacter(int id) {
    return _pageCache.values
        .expand((list) => list)
        .any((c) => c.charid == id);
  }

  void dispose() {
    _pageCache.clear();
  }
}
