import 'package:aceplus/features/card_game/data/datasource/sound_data_source.dart';
import 'package:aceplus/features/card_game/domain/repositories/setting_repository.dart';

class SettingRepositoryImpl implements SettingRepository {
  final SoundDataSource soundDataSource;

  SettingRepositoryImpl({required this.soundDataSource});

  @override
  Future<void> setBackgroundVolume(double volume) =>
      soundDataSource.setBackgroundVolume(volume);

  @override
  Future<double> getBackgroundVolume() =>
      soundDataSource.getBackgroundVolume();
}
