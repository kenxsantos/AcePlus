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
        int number = Random().nextInt(10) + 1; // Generates numbers from 1 to 10
        if (!uniqueNumbers.contains(number)) {
          uniqueNumbers.add(number);
        }
      }
      emit(CardGenerated(uniqueNumbers));
    });

    on<CardToggelAnimate>((event, emit) {
      emit(CardIsAnimated(event.isFlipped, event.isExtended));
    });
  }
}
