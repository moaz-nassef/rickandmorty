import 'dart:async';
import 'package:dio/dio.dart';
import 'package:rickandmorty/data/API_services/character_web_service.dart';
import 'package:rickandmorty/data/model/characterModel.dart';

class NetworkException implements Exception {
  NetworkException();
}

class NotFoundException implements Exception {
  final String message;
  NotFoundException(this.message);
}

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
      } on DioException catch (e) {
        // Network errors: timeout, connection error, unknown
        if (e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout ||
            e.type == DioExceptionType.connectionError ||
            e.type == DioExceptionType.unknown) {
          throw NetworkException();
        }
        // 404 Not Found
        if (e.type == DioExceptionType.badResponse &&
            e.response?.statusCode == 404) {
          throw NotFoundException('Character not found');
        }
        // Other Dio errors will be retried
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
      } catch (e) {
        // Other exceptions (non-Dio) will be retried
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