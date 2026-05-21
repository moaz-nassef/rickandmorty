part of 'character_cubit.dart';

@immutable
sealed class CharacterState extends Equatable {}

final class CharacterInitial extends CharacterState {
  @override
  List<Object?> get props => [];
}

final class CharacterLoading extends CharacterState {
  @override
  List<Object?> get props => [];
}

final class CharactersLoaded extends CharacterState {
  final List<Character> characters;
  final int currentPage;
  final int totalPages;

  CharactersLoaded(this.characters, {required this.currentPage, required this.totalPages});

  @override
  List<Object?> get props => [characters, currentPage, totalPages];
}

final class CharacterDetailsLoaded extends CharacterState {
  final Character character;

  CharacterDetailsLoaded(this.character);

  @override
  List<Object?> get props => [character];
}

final class CharacterFailure extends CharacterState {
  final String message;

  CharacterFailure(this.message);

  @override
  List<Object?> get props => [message];
}
