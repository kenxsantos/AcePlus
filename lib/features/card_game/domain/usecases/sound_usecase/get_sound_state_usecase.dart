import '../../repositories/sound_repository.dart';

class GetSoundStateUsecase {
  final SoundRepository repository;

  GetSoundStateUsecase(this.repository);

  Future<bool> call() {
    return repository.getSoundState();
  }
}