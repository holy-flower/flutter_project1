

import 'package:flutter_project1/core/errors/failures.dart';
import 'package:flutter_project1/core/models/user.dart';
import 'package:flutter_project1/core/utils/either.dart';
import 'package:flutter_project1/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, User>> call(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      return Either.left(const ValidationFailure('Заполните все поля'));
    }
    return await repository.login(email, password);
  }
}


