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

class ChooseCard extends CardEvent {
  const ChooseCard({required this.index});
  final int index;

  @override
  List<Object> get props => [index];
}

class ResetSelectedCards extends CardEvent {}
