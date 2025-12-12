import 'package:flutter_project1/core/errors/failures.dart';
import 'package:flutter_project1/core/models/app_settings.dart';
import 'package:flutter_project1/core/utils/either.dart';
import 'package:flutter_project1/domain/repositories/settings_repository.dart';

class UpdateSettingsUseCase {
  final SettingsRepository repository;

  UpdateSettingsUseCase(this.repository);

  Future<Either<Failure, AppSettings>> call(AppSettings settings) async {
    return await repository.updateSettings(settings);
  }
}





