import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String? username;
  final String? name;

  const User({
    required this.id,
    required this.email,
    this.username,
    this.name,
  });

  User copyWith({
    String? id,
    String? email,
    String? username,
    String? name,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
      name: name ?? this.name,
    );
  }

  @override
  List<Object?> get props => [id, email, username, name];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'name': name,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      username: json['username'] as String?,
      name: json['name'] as String?,
    );
  }
}


