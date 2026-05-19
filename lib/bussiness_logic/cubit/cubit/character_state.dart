part of 'character_cubit.dart';

@immutable
sealed class CharacterState {}

final class CharacterInitial extends CharacterState {}

final class CharacterLoading extends CharacterState {}

final class CharactersLoaded extends CharacterState {
  final List<Character> characters;

  CharactersLoaded(this.characters);
}

final class CharacterDetailsLoaded extends CharacterState {
  final Character character;

  CharacterDetailsLoaded(this.character);
}

final class CharacterFailure extends CharacterState {
  final String message;

  CharacterFailure(this.message);
}