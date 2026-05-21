import 'package:rickandmorty/data/API_services/character_web_service.dart';
import 'package:rickandmorty/data/model/characterModel.dart';

class CharacterRepository {
  final CharacterWebService characterWebService;

  CharacterRepository(this.characterWebService);

  Future<CharacterPageResponse> getCharactersPage(int page) async {
    return await characterWebService.getCharactersPage(page);
  }

  Future<Character> getCharacterById(int id) async {
    return await characterWebService.getCharacterById(id);
  }
}
