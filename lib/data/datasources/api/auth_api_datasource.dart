import '../../../core/models/user.dart';
import '../../../core/utils/either.dart';
import '../../../core/errors/failures.dart';
import 'dto/auth_dto.dart';
import 'mappers/auth_mapper.dart';

abstract class AuthApiDataSource {
  Future<Either<Failure, User>> login(String email, String password);
  Future<Either<Failure, User>> register(String email, String password);
  Future<Either<Failure, void>> logout();
}

class AuthApiDataSourceImpl implements AuthApiDataSource {
  User? _currentUser;

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    
    if (email.isEmpty || password.isEmpty) {
      return left(const ValidationFailure('Заполните все поля'));
    }

    final dto = AuthDto(email: email, password: password);
    final user = AuthMapper.toDomain(dto);
    _currentUser = user;
    
    return right(user);
  }

  @override
  Future<Either<Failure, User>> register(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    
    if (email.isEmpty || password.isEmpty) {
      return left(const ValidationFailure('Заполните все поля'));
    }
    
    if (password.length < 6) {
      return left(const ValidationFailure('Пароль должен содержать минимум 6 символов'));
    }

    final dto = AuthDto(email: email, password: password);
    final user = AuthMapper.toDomain(dto);
    _currentUser = user;
    
    return right(user);
  }

  @override
  Future<Either<Failure, void>> logout() async {
    _currentUser = null;
    return right(null);
  }

  User? getCurrentUser() => _currentUser;
}



