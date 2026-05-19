import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/bussiness_logic/cubit/cubit/character_cubit.dart';
import 'package:rickandmorty/consstant/string.dart';
import 'package:rickandmorty/data/API_services/character_web_service.dart';
import 'package:rickandmorty/data/repository/character_repository.dart';
import 'package:rickandmorty/pressntation/screens/Character_Screen.dart';
import 'package:rickandmorty/pressntation/screens/Character_details.dart';

class AppRoutes {
  late final CharacterRepository characterRepository;
  late final CharacterCubit characterCubit;

  AppRoutes() {
    characterRepository = CharacterRepository(CharacterWebService());
    characterCubit = CharacterCubit(characterRepository);
  }

  Route? generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case AllcharacterScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: characterCubit..getAllCharacters(),
            child: const CharacterScreen(),
          ),
        );
      case CharacterDetailScreen:
        return MaterialPageRoute(
          builder: (_) => const CharacterDetailsScreen(),
        );
      default:
        return null;
    }
  }
}
