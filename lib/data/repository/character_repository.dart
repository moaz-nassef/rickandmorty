import 'package:rickandmorty/data/API_services/character_web_service.dart';
import 'package:rickandmorty/data/model/characterModel.dart';

class CharacterRepository {
  final CharacterWebService characterWebService;

  CharacterRepository(this.characterWebService);

  Future<List<Character>> getAllCharacters() async {
    return await characterWebService.getAllCharacters();
  }

  Future<Character> getCharacterById(int id) async {
    return await characterWebService.getCharacterById(id);
  }
}
