import 'package:flutter_project1/core/errors/failures.dart';
import 'package:flutter_project1/core/models/profile.dart';
import 'package:flutter_project1/core/utils/either.dart';
import 'package:flutter_project1/domain/repositories/profile_repository.dart';

class UpdateProfileUseCase {
  final ProfileRepository repository;

  UpdateProfileUseCase(this.repository);

  Future<Either<Failure, Profile>> call(Profile profile) async {
    if (profile.name.isEmpty) {
      return Either.left(const ValidationFailure('Имя не может быть пустым'));
    }
    return await repository.updateProfile(profile);
  }
}


