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
      print("Generated numbers: $uniqueNumbers");
    });

    on<CardReset>((event, emit) {
      emit(CardResetValue());
      print("Cards have been reset.");
    });

    on<CardToggelAnimate>((event, emit) {
      print(
        "Received CardToggleFlip event: ${event.isFlipped} - CardToggleExtended event: ${event.isExtended}",
      );
      emit(
        CardIsAnimated(
          isFlipped: event.isFlipped,
          isExtended: event.isExtended,
        ),
      );
    });

    // on<CardToggleFlip>((event, emit) {
    //   print("Received CardToggleFlip event: ${event.isFlipped}");

    //   emit(CardIsFlipped(isFlipped: event.isFlipped));

    //   print("Emitted CardIsFlipped with value: ${event.isFlipped}");
    // });

    // on<CardToggleExpanded>((event, emit) {
    //   print("Received CardIsExpanded event: ${event.isExpanded}");

    //   emit(CardIsExpanded(isExpanded: event.isExpanded));
    //   print("Emitted CardIsFlipped with value: ${event.isExpanded}");

    //   print("CardIsExpanded: ${event.isExpanded}");
  }
}
