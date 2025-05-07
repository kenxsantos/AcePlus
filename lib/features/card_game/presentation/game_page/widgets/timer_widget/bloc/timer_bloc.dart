import 'dart:async';
import 'package:aceplus/features/card_game/data/datasource/timer_data_source.dart';
import 'package:aceplus/shared/utils/strings.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  static const int _duration = 10;
  final TimerDataSource _ticker;
  StreamSubscription<int>? _tickerSubscription;
  TimerBloc({required TimerDataSource ticker})
    : _ticker = ticker,
      super(TimerState(duration: _duration)) {
    on<TimerStarted>(_onStarted);
    on<TimerStarting>(_onStarting);
    on<TimerTicked>(_onTicked);
    on<ShowCards>(_onShowCards);
    // on<CloseCards>(_onClosedCards);
  }
  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  void _onStarting(TimerStarting event, Emitter<TimerState> emit) {
    print("STARTING CARDS");
    try {
      final inProgressState = state.copyWith(
        status: TimerStatus.starting,
        duration: event.duration,
        text: Str().starting,
      );
      emit(inProgressState);
      _tickerSubscription?.cancel();
      _tickerSubscription = _ticker
          .tick(ticks: event.duration)
          .listen((duration) => add(TimerTicked(duration: duration)));
    } catch (e) {
      final errorState = state.copyWith(status: TimerStatus.error);
      emit(errorState);
    }
  }

  void _onStarted(TimerStarted event, Emitter<TimerState> emit) {
    print("STARTED CARDS");
    try {
      final inProgressState = state.copyWith(
        status: TimerStatus.inProgress,
        duration: event.duration,
        text: Str().chooseCard,
      );
      emit(inProgressState);
      _tickerSubscription?.cancel();
      _tickerSubscription = _ticker
          .tick(ticks: event.duration)
          .listen((duration) => add(TimerTicked(duration: duration)));
    } catch (e) {
      final errorState = state.copyWith(status: TimerStatus.error);
      emit(errorState);
    }
  }

  void _onTicked(TimerTicked event, Emitter<TimerState> emit) {
    print("TIMER TICKED");
    if (event.duration > 0) {
      emit(state.copyWith(duration: event.duration));
    } else if (event.duration == 0 && state.status == TimerStatus.inProgress) {
      emit(
        state.copyWith(status: TimerStatus.showCards, duration: event.duration),
      );
    } else if (event.duration == 0 && state.status == TimerStatus.showing) {
      emit(
        state.copyWith(
          status: TimerStatus.closeCards,
          duration: event.duration,
        ),
      );
    } else if (state.status == TimerStatus.closeCards) {
      emit(
        state.copyWith(status: TimerStatus.completed, duration: event.duration),
      );
    } else {
      emit(state.copyWith(status: TimerStatus.completed));
    }
  }

  void _onShowCards(ShowCards event, Emitter<TimerState> emit) {
    print("SHOWING CARDS");
    try {
      final showCardState = state.copyWith(
        status: TimerStatus.showing,
        text: Str().showingCard,
      );
      emit(showCardState);
      _tickerSubscription?.cancel();
      _tickerSubscription = _ticker
          .tick(ticks: event.duration)
          .listen((duration) => add(TimerTicked(duration: duration)));
    } catch (e) {
      final errorState = state.copyWith(status: TimerStatus.error);
      emit(errorState);
    }
  }
}
