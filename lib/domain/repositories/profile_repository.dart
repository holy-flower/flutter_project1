import '../../core/models/profile.dart';
import '../../core/errors/failures.dart';
import '../../core/utils/either.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Profile>> getProfile();
  Future<Either<Failure, Profile>> updateProfile(Profile profile);
}

