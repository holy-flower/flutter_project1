import 'package:flutter_project1/core/errors/failures.dart';
import 'package:flutter_project1/core/models/user.dart';
import 'package:flutter_project1/core/utils/either.dart';
import 'package:flutter_project1/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<Either<Failure, User>> call(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      return Either.left(const ValidationFailure('Заполните все поля'));
    }
    if (password.length < 6) {
      return Either.left(const ValidationFailure('Пароль должен содержать минимум 6 символов'));
    }
    return await repository.register(email, password);
  }
}


