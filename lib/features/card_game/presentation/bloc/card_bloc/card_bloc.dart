import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'card_event.dart';
part 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  CardBloc() : super(const CardState()) {
    on<CardRandomize>(_onCardRandomize);
    on<CardToggelAnimate>(_onCardToggleAnimate);
    on<PlaceBet>(_onPlaceBet);
    on<ResetSelectedCards>(_onResetSelectedCards);
    on<SetBetAmountForLastSelectedCard>(_onSetBetAmount);
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

  Future<void> _onPlaceBet(PlaceBet event, Emitter<CardState> emit) async {
    final currentBets = Map<int, double>.from(state.bets);

    if (currentBets.containsKey(event.index)) {
      currentBets.remove(event.index);
      emit(
        state.copyWith(
          bets: currentBets,
          lastSelectedCardIndex: null,
          status: CardStatus.cardTap,
        ),
      );
    } else {
      currentBets[event.index] = 1;
      emit(
        state.copyWith(
          bets: currentBets,
          lastSelectedCardIndex: event.index,
          status: CardStatus.cardTap,
        ),
      );
    }
  }

  Future<void> _onSetBetAmount(
    SetBetAmountForLastSelectedCard event,
    Emitter<CardState> emit,
  ) async {
    final currentBets = Map<int, double>.from(state.bets);
    final calculate = Map<int, double>.from(state.bets);
    final selectedIndex = state.lastSelectedCardIndex;

    if (selectedIndex != null && currentBets.containsKey(selectedIndex)) {
      currentBets[selectedIndex] = event.amount;

      final odds = state.odds[selectedIndex];
      final calculatedBet = event.amount * odds;
      calculate[selectedIndex] = double.parse(calculatedBet.toStringAsFixed(2));

      emit(
        state.copyWith(
          bets: currentBets,
          totalAmount: calculate,
          status: CardStatus.cardTap,
        ),
      );
      print(
        "Bet for card $selectedIndex: ${event.amount} x ${state.odds[selectedIndex]} = $calculatedBet",
      );
    }
  }

  Future<void> _onResetSelectedCards(
    ResetSelectedCards event,
    Emitter<CardState> emit,
  ) async {
    emit(state.copyWith(bets: {}, selectedAmount: 0, totalAmount: {}));
  }
}
