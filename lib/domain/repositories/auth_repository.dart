import '../../core/models/user.dart';
import '../../core/errors/failures.dart';
import '../../core/utils/either.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(String email, String password);
  Future<Either<Failure, User>> register(String email, String password);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, User?>> getCurrentUser();
}

