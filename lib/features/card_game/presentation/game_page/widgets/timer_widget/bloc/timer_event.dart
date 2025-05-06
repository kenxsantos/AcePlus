part of 'timer_bloc.dart';

class TimerEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class TimerStarted extends TimerEvent {
  TimerStarted({required this.duration});
  final int duration;
}

class TimerStarting extends TimerEvent {
  TimerStarting({required this.duration});
  final int duration;
}

class ShowCards extends TimerEvent {
  ShowCards({required this.duration});
  final int duration;
}

class TimerTicked extends TimerEvent {
  TimerTicked({required this.duration});
  final int duration;
}
