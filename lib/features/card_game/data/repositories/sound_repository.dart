import 'package:aceplus/features/card_game/data/datasource/sound_data_source.dart';
import 'package:aceplus/features/card_game/domain/repositories/sound_repository.dart';

class SoundRepositoryImpl implements SoundRepository {
  final SoundDataSource soundDataSource;

  SoundRepositoryImpl({required this.soundDataSource});

  @override
  Future<bool> getSoundState() => soundDataSource.getSoundState();

  @override
  Future<void> saveSoundState(bool isPlaying) =>
      soundDataSource.saveSoundState(isPlaying);

  @override
  Future<void> setupBackgroundAudio() => soundDataSource.setupBackgroundAudio();

  @override
  Future<void> resumeBackgroundAudio() =>
      soundDataSource.resumeBackgroundAudio();

  @override
  Future<void> pauseBackgroundAudio() => soundDataSource.pauseBackgroundAudio();
}
