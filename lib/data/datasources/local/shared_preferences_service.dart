import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static SharedPreferences? get instance => _prefs;

  static bool get isInitialized => _prefs != null;

  static SharedPreferences get requiredInstance {
    if (_prefs == null) {
      throw StateError(
        'SharedPreferencesService не инициализирован'
      );
    }
    return _prefs!;
  }
}

