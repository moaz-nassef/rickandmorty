import 'package:dio/dio.dart';
import 'package:rickandmorty/consstant/string.dart';
import 'package:rickandmorty/data/model/characterModel.dart';

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

  Future<({List<Character> characters, int totalPages})> getCharactersPage(
    int page,
  ) async {
    try {
      final response = await dio.get(
        '/character',
        queryParameters: {'page': page},
      );
      final data = response.data as Map<String, dynamic>;
      final info = data['info'] as Map<String, dynamic>;
      final results = data['results'] as List<dynamic>;

      final characters = results
          .map((c) => Character.fromJson(c as Map<String, dynamic>))
          .toList();
      final totalPages = info['pages'] as int;

      return (characters: characters, totalPages: totalPages);
    } catch (e) {
      rethrow;
    }
  }
}
