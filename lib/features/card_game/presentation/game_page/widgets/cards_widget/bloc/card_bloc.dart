import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'card_event.dart';
part 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  CardBloc() : super(CardInitial()) {
    on<CardRandomize>((event, emit) {
      List<int> uniqueNumbers = [];
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

      emit(CardGenerated(uniqueNumbers, odds));
    });

    on<CardToggelAnimate>((event, emit) {
      emit(CardIsAnimated(event.isFlipped, event.isExtended));
    });

    on<ChooseCard>((event, emit) {
      emit(CardIsTapped(event.index));
    });
  }
}
