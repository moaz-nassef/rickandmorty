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

  Future<List<Character>> getAllCharacters() async {
    try {
      final response = await dio.get('/character');
      final data = response.data as Map<String, dynamic>;
      final results = data['results'] as List<dynamic>;

      return results
          .map(
            (character) =>
                Character.fromJson(character as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
