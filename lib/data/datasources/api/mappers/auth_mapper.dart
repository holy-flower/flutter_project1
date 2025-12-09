import '../../../../core/models/user.dart';
import '../dto/auth_dto.dart';

class AuthMapper {
  static User toDomain(AuthDto dto) {
    return User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      email: dto.email,
      username: dto.email.split('@').first,
    );
  }

  static AuthDto toDto(User user) {
    return AuthDto(
      email: user.email,
      password: '', // Password is not stored in User model
    );
  }
}


