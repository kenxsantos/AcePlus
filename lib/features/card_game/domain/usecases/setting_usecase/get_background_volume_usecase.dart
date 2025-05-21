import '../../repositories/setting_repository.dart';

class GetBackgroundVolumeUsecase {
  final SettingRepository repository;

  GetBackgroundVolumeUsecase(this.repository);

  Future<double> call() => repository.getBackgroundVolume();
}