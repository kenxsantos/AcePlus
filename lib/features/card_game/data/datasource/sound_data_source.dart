import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SoundDataSource {
  final AudioPlayer _player = AudioPlayer();
  static const _isPlaying = 'isPlaying';
  static const _volumeKey = 'bgmVolume';

  Future<bool> getSoundState() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isPlaying) ?? true;
  }

  Future<void> saveSoundState(bool isPlaying) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isPlaying, isPlaying);
  }

  Future<void> setupBackgroundAudio() async {
    await _player.setReleaseMode(ReleaseMode.loop);
    await _player.setSource(AssetSource('sounds/jazz_music_bg.MP3'));
    final isPlaying = await getSoundState();

    if(isPlaying) {
      await _player.resume();
    } else {
      await _player.pause();
    }
  }

  Future<void> resumeBackgroundAudio() async {
    await _player.resume();
  }

  Future<void> pauseBackgroundAudio() async {
    await _player.pause();
  }

  Future<void> setBackgroundVolume(double volume) async {
    final normalizedVolume = (volume / 100).clamp(0.0, 1.0);
    await _player.setVolume(normalizedVolume);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_volumeKey, normalizedVolume);
  }

  Future<double> getBackgroundVolume() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getDouble(_volumeKey) ?? 1.0) * 100;
  }
}
