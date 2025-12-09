import '../../domain/repositories/profile_repository.dart';
import '../../core/models/profile.dart';
import '../../core/errors/failures.dart';
import '../../core/utils/either.dart';
import '../datasources/api/profile_api_datasource.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileApiDataSource dataSource;

  ProfileRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, Profile>> getProfile() async {
    return await dataSource.getProfile();
  }

  @override
  Future<Either<Failure, Profile>> updateProfile(Profile profile) async {
    return await dataSource.updateProfile(profile);
  }
}


