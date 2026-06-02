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
  final bool isLoadingPage;
  final String? errorMessage;

  CharactersLoaded(
    this.characters, {
    this.currentPage = 1,
    this.totalPages = 1,
    this.isLoadingPage = false,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
        characters,
        currentPage,
        totalPages,
        isLoadingPage,
        errorMessage,
      ];
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
