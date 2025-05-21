import '../../repositories/sound_repository.dart';

class SaveSoundStateUsecase {
  final SoundRepository repository;

  SaveSoundStateUsecase(this.repository);

  Future<void> call(bool isPlaying) async {
    await repository.saveSoundState(isPlaying);
  }
}