part of 'card_bloc.dart';

sealed class CardEvent extends Equatable {
  const CardEvent();

  @override
  List<Object> get props => [];
}

class CardRandomize extends CardEvent {}

class CardToggelAnimate extends CardEvent {
  const CardToggelAnimate({required this.isFlipped, required this.isExtended});

  final bool isFlipped;
  final bool isExtended;
}
