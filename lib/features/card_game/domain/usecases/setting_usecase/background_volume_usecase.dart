import '../../repositories/setting_repository.dart';

class BackgroundVolumeUsecase {
  final SettingRepository repository;

  BackgroundVolumeUsecase(this.repository);

  Future<void> call(double volume) async {
    await repository.setBackgroundVolume(volume);
  }
}