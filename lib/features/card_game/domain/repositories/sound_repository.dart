abstract class SoundRepository {
  Future<bool> getSoundState();
  Future<void> saveSoundState(bool isPlaying);
}
