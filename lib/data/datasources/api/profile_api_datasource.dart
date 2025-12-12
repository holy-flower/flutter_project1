import '../../../core/models/profile.dart';
import '../../../core/utils/either.dart';
import '../../../core/errors/failures.dart';

abstract class ProfileApiDataSource {
  Future<Either<Failure, Profile>> getProfile();
  Future<Either<Failure, Profile>> updateProfile(Profile profile);
}

class ProfileApiDataSourceImpl implements ProfileApiDataSource {
  Profile? _profile;

  @override
  Future<Either<Failure, Profile>> getProfile() async {
    await Future.delayed(const Duration(milliseconds: 800));
    
    if (_profile == null) {
      _profile = Profile(
        id: '1',
        name: 'Анна Козлова',
        position: 'Ведущий косметолог',
        experience: '5 лет',
        clientsCount: '1500+',
        rating: '4.9',
        specialties: [
          'Эстетическая косметология',
          'Аппаратные методики',
          'SPA-процедуры',
          'Антиэйдж терапия',
        ],
        phone: '+7 (999) 123-45-67',
        email: 'anna@beautyclinic.ru',
        schedule: 'Пн-Пт: 9:00-20:00',
        avatarUrl: null,
      );
    }
    
    return right(_profile!);
  }

  @override
  Future<Either<Failure, Profile>> updateProfile(Profile profile) async {
    _profile = profile;
    return right(profile);
  }
}



