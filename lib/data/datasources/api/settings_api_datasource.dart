import '../../../core/models/app_settings.dart';
import '../../../core/utils/either.dart';
import '../../../core/errors/failures.dart';

abstract class SettingsApiDataSource {
  Future<Either<Failure, AppSettings>> getSettings();
  Future<Either<Failure, AppSettings>> updateSettings(AppSettings settings);
}

class SettingsApiDataSourceImpl implements SettingsApiDataSource {
  AppSettings? _settings;

  @override
  Future<Either<Failure, AppSettings>> getSettings() async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    if (_settings == null) {
      _settings = AppSettings(
        isDarkTheme: false,
        notificationsEnabled: true,
        biometricAuth: false,
        language: 'Русский',
        appVersion: '1.0.0',
        lastUpdated: DateTime.now(),
      );
    }
    
    return right(_settings!);
  }

  @override
  Future<Either<Failure, AppSettings>> updateSettings(AppSettings settings) async {
    _settings = settings;
    return right(settings);
  }
}



