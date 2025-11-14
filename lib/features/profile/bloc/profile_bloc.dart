import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<LoadProfile>(_onLoadProfile);
    on<UpdateProfile>(_onUpdateProfile);
    on<UpdateSpecialties>(_onUpdateSpecialties);
    on<UpdateProfileImage>(_onUpdateProfileImage);
  }

  void _onLoadProfile(LoadProfile event, Emitter<ProfileState> emit) async {
    try {
      emit(ProfileLoading());
      await Future.delayed(const Duration(milliseconds: 800));
      final profile = Profile(
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

      emit(ProfileLoaded(profile: profile));
    } catch (e) {
      emit(ProfileError('Не удалось загрузить профиль: $e'));
    }
  }

  void _onUpdateProfile(UpdateProfile event, Emitter<ProfileState> emit) {
    if (state is ProfileLoaded) {
      final currentState = state as ProfileLoaded;
      final updatedProfile = currentState.profile.copyWith(
        name: event.name ?? currentState.profile.name,
        position: event.position ?? currentState.profile.position,
        phone: event.phone ?? currentState.profile.phone,
        email: event.email ?? currentState.profile.email,
        schedule: event.schedule ?? currentState.profile.schedule,
        specialties: event.specialties ?? currentState.profile.specialties,
      );
      emit(ProfileLoaded(profile: updatedProfile));
    }
  }

  void _onUpdateProfileImage(UpdateProfileImage event, Emitter<ProfileState> emit) {
    if (state is ProfileLoaded) {
      final currentState = state as ProfileLoaded;
      final updatedProfile = currentState.profile.copyWith(
        avatarUrl: event.imageUrl,
      );
      emit(ProfileLoaded(profile: updatedProfile));
    }
  }

  void _onUpdateSpecialties(UpdateSpecialties event, Emitter<ProfileState> emit) {
    if (state is ProfileLoaded) {
      final currentState = state as ProfileLoaded;
      final updatedProfile = currentState.profile.copyWith(
        specialties: event.specialties,
      );

      emit(ProfileLoaded(profile: updatedProfile));
    }
  }
}