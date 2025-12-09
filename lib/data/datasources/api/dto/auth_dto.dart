class AuthDto {
  final String email;
  final String password;

  AuthDto({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
  };

  factory AuthDto.fromJson(Map<String, dynamic> json) => AuthDto(
    email: json['email'] as String,
    password: json['password'] as String,
  );
}


