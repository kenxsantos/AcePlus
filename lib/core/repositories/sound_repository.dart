import 'package:aceplus/core/datasource/sound_data_source.dart';

class SoundRepository {
  final SoundDataSource soundDataSource;

  SoundRepository({required this.soundDataSource});

  Future<bool> getSoundState() => soundDataSource.getSoundState();

  Future<void> saveSoundState(bool isPlaying) =>
      soundDataSource.saveSoundState(isPlaying);
}
