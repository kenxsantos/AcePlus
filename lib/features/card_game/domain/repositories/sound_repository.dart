abstract class SoundRepository {
  Future<bool> getSoundState();
  Future<void> saveSoundState(bool isPlaying);
  Future<void> setupBackgroundAudio();
  Future<void> pauseBackgroundAudio();
  Future<void> resumeBackgroundAudio();
}
