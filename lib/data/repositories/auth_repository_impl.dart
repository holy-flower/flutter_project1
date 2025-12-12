import '../../domain/repositories/auth_repository.dart';
import '../../core/models/user.dart';
import '../../core/errors/failures.dart';
import '../../core/utils/either.dart';
import '../datasources/api/auth_api_datasource.dart';
import '../datasources/local/auth_local_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiDataSource apiDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl(this.apiDataSource, this.localDataSource);

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    final result = await apiDataSource.login(email, password);
    
    return result.fold(
      (failure) => left(failure),
      (user) async {
        // Сохраняем все данные аутентификации в безопасное хранилище
        await localDataSource.saveUser(user);
        await localDataSource.saveUserLogin(email); // Сохраняем логин (email)
        await localDataSource.saveUserPassword(password); // Сохраняем пароль для будущей авторизации
        await localDataSource.saveToken('token_${user.id}'); // Access токен
        await localDataSource.saveRefreshToken('refresh_token_${user.id}'); // Refresh токен
        return right(user);
      },
    );
  }

  @override
  Future<Either<Failure, User>> register(String email, String password) async {
    final result = await apiDataSource.register(email, password);
    
    return result.fold(
      (failure) => left(failure),
      (user) async {
        // Сохраняем все данные аутентификации в безопасное хранилище
        await localDataSource.saveUser(user);
        await localDataSource.saveUserLogin(email); // Сохраняем логин (email)
        await localDataSource.saveUserPassword(password); // Сохраняем пароль для будущей авторизации
        await localDataSource.saveToken('token_${user.id}'); // Access токен (в реальном приложении приходит с сервера)
        await localDataSource.saveRefreshToken('refresh_token_${user.id}'); // Refresh токен (в реальном приложении приходит с сервера)
        return right(user);
      },
    );
  }

  @override
  Future<Either<Failure, void>> logout() async {
    final result = await apiDataSource.logout();
    
    return result.fold(
      (failure) => left(failure),
      (_) async {
        await localDataSource.clearAll();
        return right(null);
      },
    );
  }

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    return await localDataSource.getUser();
  }
}



