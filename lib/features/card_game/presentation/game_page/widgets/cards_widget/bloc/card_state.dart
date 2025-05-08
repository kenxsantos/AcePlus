part of 'card_bloc.dart';

sealed class CardState extends Equatable {
  const CardState();

  @override
  List<Object> get props => [];
}

final class CardInitial extends CardState {}

final class CardGenerated extends CardState {
  final List<int> numbers;
  const CardGenerated(this.numbers);
}

final class CardResetValue extends CardState {}

final class CardIsFlipped extends CardState {
  const CardIsFlipped({required this.isFlipped});

  final bool isFlipped;
}

final class CardIsExtended extends CardState {
  const CardIsExtended({required this.isExtended});

  final bool isExtended;
}

final class CardAce extends CardState {}

final class CardJoker extends CardState {}
