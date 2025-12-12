import 'dart:convert';
import '../../../core/models/app_settings.dart';
import '../../../core/utils/either.dart';
import '../../../core/errors/failures.dart';
import 'shared_preferences_service.dart';

abstract class SettingsLocalDataSource {
  Future<Either<Failure, AppSettings>> getSettings();
  Future<Either<Failure, AppSettings>> saveSettings(AppSettings settings);
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  static const String _settingsKey = 'app_settings';

  @override
  Future<Either<Failure, AppSettings>> getSettings() async {
    try {
      final prefs = SharedPreferencesService.requiredInstance;
      final settingsJson = prefs.getString(_settingsKey);

      if (settingsJson == null) {
        final defaultSettings = AppSettings(
          isDarkTheme: false,
          notificationsEnabled: true,
          biometricAuth: false,
          language: 'Русский',
          appVersion: '1.0.0',
          lastUpdated: DateTime.now(),
        );
        await saveSettings(defaultSettings);
        return right(defaultSettings);
      }

      final json = jsonDecode(settingsJson) as Map<String, dynamic>;
      final settings = AppSettings.fromJson(json);
      return right(settings);
    } catch (e) {
      return left(CacheFailure('Ошибка загрузки настроек: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, AppSettings>> saveSettings(AppSettings settings) async {
    try {
      final prefs = SharedPreferencesService.requiredInstance;
      final settingsJson = jsonEncode(settings.toJson());
      await prefs.setString(_settingsKey, settingsJson);
      return right(settings);
    } catch (e) {
      return left(CacheFailure('Ошибка сохранения настроек: ${e.toString()}'));
    }
  }
}

