import 'package:flutter_project1/core/errors/failures.dart';
import 'package:flutter_project1/core/models/profile.dart';
import 'package:flutter_project1/core/utils/either.dart';
import 'package:flutter_project1/domain/repositories/profile_repository.dart';

class GetProfileUseCase {
  final ProfileRepository repository;

  GetProfileUseCase(this.repository);

  Future<Either<Failure, Profile>> call() async {
    return await repository.getProfile();
  }
}


