import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/models/profile.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../domain/usecases/profile/get_profile_usecase.dart';
import '../../../../domain/usecases/profile/update_profile_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  final UpdateProfileUseCase updateProfileUseCase;

  ProfileBloc({
    GetProfileUseCase? getProfileUseCase,
    UpdateProfileUseCase? updateProfileUseCase,
  })  : getProfileUseCase = getProfileUseCase ?? getIt<GetProfileUseCase>(),
        updateProfileUseCase = updateProfileUseCase ?? getIt<UpdateProfileUseCase>(),
        super(ProfileInitial()) {
    on<LoadProfile>(_onLoadProfile);
    on<UpdateProfile>(_onUpdateProfile);
    on<UpdateSpecialties>(_onUpdateSpecialties);
    on<UpdateProfileImage>(_onUpdateProfileImage);
  }

  void _onLoadProfile(LoadProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    
    final result = await getProfileUseCase();
    
    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (profile) => emit(ProfileLoaded(profile: profile)),
    );
  }

  void _onUpdateProfile(UpdateProfile event, Emitter<ProfileState> emit) async {
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
      
      final result = await updateProfileUseCase(updatedProfile);
      
      result.fold(
        (failure) => emit(ProfileError(failure.message)),
        (profile) => emit(ProfileLoaded(profile: profile)),
      );
    }
  }

  void _onUpdateProfileImage(UpdateProfileImage event, Emitter<ProfileState> emit) async {
    if (state is ProfileLoaded) {
      final currentState = state as ProfileLoaded;
      final updatedProfile = currentState.profile.copyWith(
        avatarUrl: event.imageUrl,
      );
      
      final result = await updateProfileUseCase(updatedProfile);
      
      result.fold(
        (failure) => emit(ProfileError(failure.message)),
        (profile) => emit(ProfileLoaded(profile: profile)),
      );
    }
  }

  void _onUpdateSpecialties(UpdateSpecialties event, Emitter<ProfileState> emit) async {
    if (state is ProfileLoaded) {
      final currentState = state as ProfileLoaded;
      final updatedProfile = currentState.profile.copyWith(
        specialties: event.specialties,
      );
      
      final result = await updateProfileUseCase(updatedProfile);
      
      result.fold(
        (failure) => emit(ProfileError(failure.message)),
        (profile) => emit(ProfileLoaded(profile: profile)),
      );
    }
  }
}





