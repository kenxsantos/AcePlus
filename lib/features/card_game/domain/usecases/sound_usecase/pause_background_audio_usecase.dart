import '../../repositories/sound_repository.dart';

class PauseBackgroundAudioUsecase {
  final SoundRepository repository;

  PauseBackgroundAudioUsecase(this.repository);

  Future<void> call() async {
    repository.pauseBackgroundAudio();
  }
}