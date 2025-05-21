import 'package:aceplus/features/card_game/domain/usecases/sound_usecase/get_sound_state_usecase.dart';
import 'package:aceplus/features/card_game/domain/usecases/sound_usecase/pause_background_audio_usecase.dart';
import 'package:aceplus/features/card_game/domain/usecases/sound_usecase/resume_background_audio_usecase.dart';
import 'package:aceplus/features/card_game/domain/usecases/sound_usecase/save_sound_state_usecase.dart';
import 'package:aceplus/features/card_game/domain/usecases/sound_usecase/setup_background_audio_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'sound_event.dart';
import 'sound_state.dart';

class SoundBloc extends Bloc<SoundEvent, SoundState> {
  final SaveSoundStateUsecase saveSoundStateUsecase;
  final GetSoundStateUsecase getSoundStateUsecase;
  final SetupBackgroundAudioUsecase setupBackgroundAudioUsecase;
  final PauseBackgroundAudioUsecase pauseBackgroundAudioUsecase;
  final ResumeBackgroundAudioUsecase resumeBackgroundAudioUsecase;

  SoundBloc({
    required this.saveSoundStateUsecase,
    required this.getSoundStateUsecase,
    required this.setupBackgroundAudioUsecase,
    required this.pauseBackgroundAudioUsecase,
    required this.resumeBackgroundAudioUsecase,
  }) : super(SoundPlaying()) {
    on<LoadSoundState>(_onLoadSoundState);
    on<ToggleSound>(_onToggleSound);
    setupBackgroundAudioUsecase();
  }

  void _onLoadSoundState(LoadSoundState event, Emitter<SoundState> emit) async {
    final isPlaying = await getSoundStateUsecase();
    if (isPlaying) {
      resumeBackgroundAudioUsecase();
      emit(SoundPlaying());
    } else {
      pauseBackgroundAudioUsecase();
      emit(SoundMuted());
    }
  }

  void _onToggleSound(ToggleSound event, Emitter<SoundState> emit) async {
    final isPlaying = state is SoundMuted;
    await saveSoundStateUsecase(isPlaying);

    if (isPlaying) {
      resumeBackgroundAudioUsecase();
      emit(SoundPlaying());
    } else {
      pauseBackgroundAudioUsecase();
      emit(SoundMuted());
    }
  }
}
