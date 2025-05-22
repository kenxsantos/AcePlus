import 'package:equatable/equatable.dart';

class SettingState extends Equatable {
  final double volume;

  const SettingState({required this.volume});

  SettingState copyWith({double? volume}) {
    return SettingState(volume: volume ?? this.volume);
  }

  @override
  List<Object?> get props => [volume];
}
