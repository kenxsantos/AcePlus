import 'package:equatable/equatable.dart';

abstract class SoundState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SoundPlaying extends SoundState {}
class SoundMuted extends SoundState {}
