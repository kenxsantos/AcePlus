import 'package:equatable/equatable.dart';

abstract class SoundEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ToggleSound extends SoundEvent {}
class LoadSoundState extends SoundEvent {}
