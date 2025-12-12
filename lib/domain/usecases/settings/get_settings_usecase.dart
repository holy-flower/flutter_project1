import 'package:flutter_project1/core/errors/failures.dart';
import 'package:flutter_project1/core/models/app_settings.dart';
import 'package:flutter_project1/core/utils/either.dart';
import 'package:flutter_project1/domain/repositories/settings_repository.dart';

class GetSettingsUseCase {
  final SettingsRepository repository;

  GetSettingsUseCase(this.repository);

  Future<Either<Failure, AppSettings>> call() async {
    return await repository.getSettings();
  }
}





