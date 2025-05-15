import 'package:shared_preferences/shared_preferences.dart';

class SoundDataSource {
  Future<bool> getSoundState() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isPlaying') ?? true;
  }

  Future<void> saveSoundState(bool isPlaying) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isPlaying', isPlaying);
  }
}
