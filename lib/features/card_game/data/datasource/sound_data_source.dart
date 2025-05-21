import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SoundDataSource {
  final AudioPlayer _player = AudioPlayer();

  Future<bool> getSoundState() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isPlaying') ?? true;
  }

  Future<void> saveSoundState(bool isPlaying) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isPlaying', isPlaying);
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
}
