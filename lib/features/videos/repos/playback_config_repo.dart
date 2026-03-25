import 'package:shared_preferences/shared_preferences.dart';

class PlaybackConfigRepository {
  static const String _autoPlay = "autoplay";
  static const String _muted = "muted";

  final SharedPreferences _preferences;

  PlaybackConfigRepository(this._preferences);

  Future<void> setMuted(bool value) async {
    await _preferences.setBool(_muted, value);
  }

  Future<void> setAutoplay(bool value) async {
    await _preferences.setBool(_autoPlay, value);
  }

  bool isMuted() {
    return _preferences.getBool(_muted) ?? false;
  }

  bool isAutoplay() {
    return _preferences.getBool(_autoPlay) ?? false;
  }
}
