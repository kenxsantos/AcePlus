abstract class SettingRepository {
  Future<void> setBackgroundVolume(double volume);
  Future<double> getBackgroundVolume();
}