import '../../domain/repositories/settings_repository.dart';
import '../../core/models/app_settings.dart';
import '../../core/errors/failures.dart';
import '../../core/utils/either.dart';
import '../datasources/api/settings_api_datasource.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsApiDataSource dataSource;

  SettingsRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, AppSettings>> getSettings() async {
    return await dataSource.getSettings();
  }

  @override
  Future<Either<Failure, AppSettings>> updateSettings(AppSettings settings) async {
    return await dataSource.updateSettings(settings);
  }
}


