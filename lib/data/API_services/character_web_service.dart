import 'package:dio/dio.dart';
import 'package:rickandmorty/consstant/string.dart';
import 'package:rickandmorty/data/model/characterModel.dart';

class CharacterPageResponse {
  final List<Character> characters;
  final int totalPages;
  final int currentPage;

  CharacterPageResponse({
    required this.characters,
    required this.totalPages,
    required this.currentPage,
  });
}

class CharacterWebService {
  late final Dio dio;

  CharacterWebService() {
    final options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    );

    dio = Dio(options);
  }

  Future<Character> getCharacterById(int id) async {
    try {
      final response = await dio.get('/character/$id');
      return Character.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<CharacterPageResponse> getCharactersPage(int page) async {
    try {
      final response = await dio.get('/character', queryParameters: {'page': page});
      final data = response.data as Map<String, dynamic>;
      final info = data['info'] as Map<String, dynamic>;
      final results = data['results'] as List<dynamic>;

      final characters = results
          .map((c) => Character.fromJson(c as Map<String, dynamic>))
          .toList();

      return CharacterPageResponse(
        characters: characters,
        totalPages: info['pages'] as int,
        currentPage: page,
      );
    } catch (e) {
      rethrow;
    }
  }
}
