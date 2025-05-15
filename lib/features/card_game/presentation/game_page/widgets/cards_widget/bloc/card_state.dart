part of 'card_bloc.dart';

sealed class CardState extends Equatable {
  const CardState();

  @override
  List<Object> get props => [];
}

final class CardInitial extends CardState {}

class CardGenerated extends CardState {
  final List<int> numbers;
  final List<double> odds;
  const CardGenerated(this.numbers, this.odds);

  @override
  List<Object> get props => [numbers, odds];
}

class CardGenerateOdss extends CardState {
  final List<int> numbers;
  const CardGenerateOdss(this.numbers);

  @override
  List<Object> get props => [numbers];
}

class CardIsAnimated extends CardState {
  final bool isFlipped;
  final bool isExtended;

  const CardIsAnimated(this.isFlipped, this.isExtended);

  @override
  List<Object> get props => [isFlipped, isExtended];
}

class CardIsTapped extends CardState {
  final int index;

  const CardIsTapped(this.index);

  @override
  List<Object> get props => [index];
}

final class CardAce extends CardState {}

final class CardJoker extends CardState {}
