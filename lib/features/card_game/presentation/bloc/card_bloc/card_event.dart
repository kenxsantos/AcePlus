part of 'card_bloc.dart';

sealed class CardEvent extends Equatable {
  const CardEvent();

  @override
  List<Object> get props => [];
}

class CardRandomize extends CardEvent {}

class CardOddsRandomize extends CardEvent {}

class CardToggelAnimate extends CardEvent {
  const CardToggelAnimate({required this.isFlipped, required this.isExtended});

  final bool isFlipped;
  final bool isExtended;
}

class PlaceBet extends CardEvent {
  final int index;

  const PlaceBet({required this.index});
}

class SetBetAmountForLastSelectedCard extends CardEvent {
  final double amount;

  const SetBetAmountForLastSelectedCard(this.amount);
}

class ResetSelectedCards extends CardEvent {}
