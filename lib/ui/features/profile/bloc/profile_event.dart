part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadProfile extends ProfileEvent {}

class UpdateProfile extends ProfileEvent {
  final String? name;
  final String? position;
  final String? phone;
  final String? email;
  final String? schedule;
  final List<String>? specialties;

  const UpdateProfile({
    this.name,
    this.position,
    this.phone,
    this.email,
    this.schedule,
    this.specialties,
  });

  @override
  List<Object> get props => [
    if (name != null) name!,
    if (position != null) position!,
    if (phone != null) phone!,
    if (email != null) email!,
    if (schedule != null) schedule!,
    if (specialties != null) specialties!,
  ];
}

class UpdateProfileImage extends ProfileEvent {
  final String imageUrl;
  const UpdateProfileImage(this.imageUrl);
  @override
  List<Object> get props => [imageUrl];
}

class UpdateSpecialties extends ProfileEvent {
  final List<String> specialties;

  const UpdateSpecialties(this.specialties);

  @override
  List<Object> get props => [specialties];
}


