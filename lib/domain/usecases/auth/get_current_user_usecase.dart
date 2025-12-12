import '../../../core/errors/failures.dart';
import '../../../core/models/user.dart';
import '../../../core/utils/either.dart';
import '../../repositories/auth_repository.dart';

class GetCurrentUserUseCase {
  final AuthRepository repository;

  GetCurrentUserUseCase(this.repository);

  Future<Either<Failure, User?>> call() async {
    return await repository.getCurrentUser();
  }
}

