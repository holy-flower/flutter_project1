import '../../domain/repositories/auth_repository.dart';
import '../../core/models/user.dart';
import '../../core/errors/failures.dart';
import '../../core/utils/either.dart';
import '../datasources/api/auth_api_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiDataSource dataSource;

  AuthRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    return await dataSource.login(email, password);
  }

  @override
  Future<Either<Failure, User>> register(String email, String password) async {
    return await dataSource.register(email, password);
  }

  @override
  Future<Either<Failure, void>> logout() async {
    return await dataSource.logout();
  }

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    if (dataSource is AuthApiDataSourceImpl) {
      final currentUser = (dataSource as AuthApiDataSourceImpl).getCurrentUser();
      return Either.right(currentUser);
    }
    return Either.left(const CacheFailure('Текущий пользователь не найден'));
  }
}


