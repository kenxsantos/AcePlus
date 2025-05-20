import 'package:aceplus/features/card_game/data/repositories/sound_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:audioplayers/audioplayers.dart';
import 'sound_event.dart';
import 'sound_state.dart';

class SoundBloc extends Bloc<SoundEvent, SoundState> {
  final SoundRepository soundRepository;
  final AudioPlayer _player = AudioPlayer();

  SoundBloc({required this.soundRepository}) : super(SoundPlaying()) {
    on<LoadSoundState>(_onLoadSoundState);
    on<ToggleSound>(_onToggleSound);
    _setupAudio();
  }

  Future<void> _setupAudio() async {
    await _player.setReleaseMode(ReleaseMode.loop);
    await _player.play(AssetSource('sounds/jazz_music_bg.MP3'));
  }

  void _onLoadSoundState(LoadSoundState event, Emitter<SoundState> emit) async {
    final isPlaying = await soundRepository.getSoundState();
    if (isPlaying) {
      _player.resume();
      emit(SoundPlaying());
    } else {
      _player.pause();
      emit(SoundMuted());
    }
  }

  void _onToggleSound(ToggleSound event, Emitter<SoundState> emit) async {
    final isPlaying = state is SoundMuted;
    await soundRepository.saveSoundState(isPlaying);

    if (isPlaying) {
      _player.resume();
      emit(SoundPlaying());
    } else {
      _player.pause();
      emit(SoundMuted());
    }
  }
}
