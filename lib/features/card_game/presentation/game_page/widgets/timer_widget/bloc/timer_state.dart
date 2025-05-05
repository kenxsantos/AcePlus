part of 'timer_bloc.dart';

enum TimerStatus {
  initial,
  inProgress,
  starting,
  completed,
  showing,
  showed,
  chooseCard,
  error,
}

extension TimerStatusX on TimerStatus {
  bool get isInitial => this == TimerStatus.initial;
  bool get isInProgress => this == TimerStatus.inProgress;
  bool get isStarting => this == TimerStatus.starting;
  bool get isCompleted => this == TimerStatus.completed;
  bool get isShowing => this == TimerStatus.showing;
  bool get isShowed => this == TimerStatus.showed;
  bool get isChooseCard => this == TimerStatus.chooseCard;
  bool get isError => this == TimerStatus.error;
}

class TimerState extends Equatable {
  const TimerState({
    this.status = TimerStatus.initial,
    required this.duration,
    this.text = '',
  });
  final int duration;
  final TimerStatus status;
  final String text;

  @override
  List<Object?> get props => [duration, status, text];

  TimerState copyWith({int? duration, TimerStatus? status, String? text}) {
    return TimerState(
      duration: duration ?? this.duration,
      status: status ?? this.status,
      text: text ?? this.text,
    );
  }
}
