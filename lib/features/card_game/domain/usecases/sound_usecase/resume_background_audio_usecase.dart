import '../../repositories/sound_repository.dart';

class ResumeBackgroundAudioUsecase {
  final SoundRepository repository;

  ResumeBackgroundAudioUsecase(this.repository);

  Future<void> call() async {
    repository.resumeBackgroundAudio();
  }
}