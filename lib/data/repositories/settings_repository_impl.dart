import '../../domain/repositories/settings_repository.dart';
import '../../core/models/app_settings.dart';
import '../../core/errors/failures.dart';
import '../../core/utils/either.dart';
import '../datasources/local/settings_local_datasource.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource localDataSource;

  SettingsRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, AppSettings>> getSettings() async {
    return await localDataSource.getSettings();
  }

  @override
  Future<Either<Failure, AppSettings>> updateSettings(AppSettings settings) async {
    return await localDataSource.saveSettings(settings);
  }
}



