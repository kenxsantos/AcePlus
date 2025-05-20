import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'card_event.dart';
part 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  CardBloc() : super(const CardState()) {
    on<CardRandomize>(_onCardRandomize);
    on<CardToggelAnimate>(_onCardToggleAnimate);
    on<ChooseCard>(_onChooseCard);
    on<ResetSelectedCards>(_onResetSelectedCards);
  }
  Future<void> _onCardRandomize(
    CardRandomize event,
    Emitter<CardState> emit,
  ) async {
    final List<int> uniqueNumbers = [];
    while (uniqueNumbers.length < 4) {
      int number = Random().nextInt(10) + 1;
      if (!uniqueNumbers.contains(number)) {
        uniqueNumbers.add(number);
      }
    }

    List<double> odds = List.generate(4, (_) {
      double randomValue = Random().nextDouble() * 0.8 + 1.0;
      return double.parse(randomValue.toStringAsFixed(2));
    });

    emit(
      state.copyWith(
        numbers: uniqueNumbers,
        odds: odds,
        status: CardStatus.generateCard,
      ),
    );
  }

  Future<void> _onCardToggleAnimate(
    CardToggelAnimate event,
    Emitter<CardState> emit,
  ) async {
    emit(
      state.copyWith(
        isFlipped: event.isFlipped,
        isExtended: event.isExtended,
        status: CardStatus.animateCard,
      ),
    );
  }

  Future<void> _onChooseCard(ChooseCard event, Emitter<CardState> emit) async {
    final currentTapped = Set<int>.from(state.tappedIndices);

    if (currentTapped.contains(event.index)) {
      currentTapped.remove(event.index); // unselect
    } else {
      currentTapped.add(event.index); // select
    }

    emit(
      state.copyWith(tappedIndices: currentTapped, status: CardStatus.cardTap),
    );
  }

  Future<void> _onResetSelectedCards(
    ResetSelectedCards event,
    Emitter<CardState> emit,
  ) async {
    emit(state.copyWith(tappedIndices: {}));
  }
}
