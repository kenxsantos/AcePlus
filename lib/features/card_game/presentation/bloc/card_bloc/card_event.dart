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
  final double amount;

  const PlaceBet(this.index, this.amount);
}

class ResetSelectedCards extends CardEvent {}
