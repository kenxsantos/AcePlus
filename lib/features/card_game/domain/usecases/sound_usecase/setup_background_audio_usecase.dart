import '../../repositories/sound_repository.dart';

class SetupBackgroundAudioUsecase {
  final SoundRepository repository;

  SetupBackgroundAudioUsecase(this.repository);

  Future<void> call() async {
    repository.setupBackgroundAudio();
  }
}