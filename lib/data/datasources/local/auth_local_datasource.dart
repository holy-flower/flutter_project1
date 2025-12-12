import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import '../../../core/models/user.dart';
import '../../../core/utils/either.dart';
import '../../../core/errors/failures.dart';

abstract class AuthLocalDataSource {
  Future<Either<Failure, void>> saveToken(String token);
  Future<Either<Failure, String?>> getToken();
  Future<Either<Failure, void>> deleteToken();
  Future<Either<Failure, void>> saveRefreshToken(String refreshToken);
  Future<Either<Failure, String?>> getRefreshToken();
  Future<Either<Failure, void>> deleteRefreshToken();
  Future<Either<Failure, void>> saveUserLogin(String login);
  Future<Either<Failure, String?>> getUserLogin();
  Future<Either<Failure, void>> deleteUserLogin();
  Future<Either<Failure, void>> saveUserPassword(String password);
  Future<Either<Failure, String?>> getUserPassword();
  Future<Either<Failure, void>> deleteUserPassword();
  Future<Either<Failure, void>> saveUser(User user);
  Future<Either<Failure, User?>> getUser();
  Future<Either<Failure, void>> deleteUser();
  Future<Either<Failure, void>> clearAll();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FlutterSecureStorage _storage;
  static const String _tokenKey = 'auth_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userLoginKey = 'user_login';
  static const String _userPasswordKey = 'user_password';
  static const String _userKey = 'current_user';

  AuthLocalDataSourceImpl({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage(
            aOptions: AndroidOptions(
              encryptedSharedPreferences: true,
            ),
            iOptions: IOSOptions(
              accessibility: KeychainAccessibility.first_unlock_this_device,
            ),
          );

  @override
  Future<Either<Failure, void>> saveToken(String token) async {
    try {
      await _storage.write(key: _tokenKey, value: token);
      return right(null);
    } catch (e) {
      return left(CacheFailure('Ошибка сохранения токена: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, String?>> getToken() async {
    try {
      final token = await _storage.read(key: _tokenKey);
      return right(token);
    } catch (e) {
      return left(CacheFailure('Ошибка загрузки токена: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteToken() async {
    try {
      await _storage.delete(key: _tokenKey);
      return right(null);
    } catch (e) {
      return left(CacheFailure('Ошибка удаления токена: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> saveRefreshToken(String refreshToken) async {
    try {
      await _storage.write(key: _refreshTokenKey, value: refreshToken);
      return right(null);
    } catch (e) {
      return left(CacheFailure('Ошибка сохранения refresh токена: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, String?>> getRefreshToken() async {
    try {
      final refreshToken = await _storage.read(key: _refreshTokenKey);
      return right(refreshToken);
    } catch (e) {
      return left(CacheFailure('Ошибка загрузки refresh токена: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteRefreshToken() async {
    try {
      await _storage.delete(key: _refreshTokenKey);
      return right(null);
    } catch (e) {
      return left(CacheFailure('Ошибка удаления refresh токена: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> saveUserLogin(String login) async {
    try {
      await _storage.write(key: _userLoginKey, value: login);
      return right(null);
    } catch (e) {
      return left(CacheFailure('Ошибка сохранения логина: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, String?>> getUserLogin() async {
    try {
      final login = await _storage.read(key: _userLoginKey);
      return right(login);
    } catch (e) {
      return left(CacheFailure('Ошибка загрузки логина: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteUserLogin() async {
    try {
      await _storage.delete(key: _userLoginKey);
      return right(null);
    } catch (e) {
      return left(CacheFailure('Ошибка удаления логина: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> saveUserPassword(String password) async {
    try {
      await _storage.write(key: _userPasswordKey, value: password);
      return right(null);
    } catch (e) {
      return left(CacheFailure('Ошибка сохранения пароля: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, String?>> getUserPassword() async {
    try {
      final password = await _storage.read(key: _userPasswordKey);
      return right(password);
    } catch (e) {
      return left(CacheFailure('Ошибка загрузки пароля: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteUserPassword() async {
    try {
      await _storage.delete(key: _userPasswordKey);
      return right(null);
    } catch (e) {
      return left(CacheFailure('Ошибка удаления пароля: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> saveUser(User user) async {
    try {
      final userJson = jsonEncode(user.toJson());
      await _storage.write(key: _userKey, value: userJson);
      return right(null);
    } catch (e) {
      return left(CacheFailure('Ошибка сохранения пользователя: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, User?>> getUser() async {
    try {
      final userJson = await _storage.read(key: _userKey);
      if (userJson == null) {
        return right(null);
      }
      final json = jsonDecode(userJson) as Map<String, dynamic>;
      final user = User.fromJson(json);
      return right(user);
    } catch (e) {
      return left(CacheFailure('Ошибка загрузки пользователя: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteUser() async {
    try {
      await _storage.delete(key: _userKey);
      return right(null);
    } catch (e) {
      return left(CacheFailure('Ошибка удаления пользователя: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> clearAll() async {
    try {
      await _storage.deleteAll();
      return right(null);
    } catch (e) {
      return left(CacheFailure('Ошибка очистки хранилища: ${e.toString()}'));
    }
  }
}

