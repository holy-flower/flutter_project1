import '../../core/models/app_settings.dart';
import '../../core/errors/failures.dart';
import '../../core/utils/either.dart';

abstract class SettingsRepository {
  Future<Either<Failure, AppSettings>> getSettings();
  Future<Either<Failure, AppSettings>> updateSettings(AppSettings settings);
}

