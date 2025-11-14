part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final Profile profile;

  const ProfileLoaded({required this.profile});

  @override
  List<Object> get props => [profile];
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object> get props => [message];
}

class Profile {
  final String name;
  final String position;
  final String experience;
  final String clientsCount;
  final String rating;
  final List<String> specialties;
  final String phone;
  final String email;
  final String schedule;
  final String? avatarUrl;

  const Profile({
    required this.name,
    required this.position,
    required this.experience,
    required this.clientsCount,
    required this.rating,
    required this.specialties,
    required this.phone,
    required this.email,
    required this.schedule,
    this.avatarUrl,
  });

  Profile copyWith({
    String? name,
    String? position,
    String? experience,
    String? clientsCount,
    String? rating,
    List<String>? specialties,
    String? phone,
    String? email,
    String? schedule,
    String? avatarUrl,
  }) {
    return Profile(
      name: name ?? this.name,
      position: position ?? this.position,
      experience: experience ?? this.experience,
      clientsCount: clientsCount ?? this.clientsCount,
      rating: rating ?? this.rating,
      specialties: specialties ?? this.specialties,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      schedule: schedule ?? this.schedule,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }
}