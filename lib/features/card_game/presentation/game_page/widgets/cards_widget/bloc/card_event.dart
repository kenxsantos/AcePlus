part of 'card_bloc.dart';

sealed class CardEvent extends Equatable {
  const CardEvent();

  @override
  List<Object> get props => [];
}

class CardRandomize extends CardEvent {}

class CardReset extends CardEvent {}

// class CardToggleFlip extends CardEvent {
//   const CardToggleFlip({required this.isFlipped});
//   final bool isFlipped;
// }

// class CardToggleExpanded extends CardEvent {
//   const CardToggleExpanded({required this.isExpanded});
//   final bool isExpanded;
// }

class CardToggelAnimate extends CardEvent {
  const CardToggelAnimate({required this.isFlipped, required this.isExtended});

  final bool isFlipped;
  final bool isExtended;
}
