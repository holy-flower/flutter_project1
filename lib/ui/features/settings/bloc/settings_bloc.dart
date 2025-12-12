import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/models/app_settings.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../domain/usecases/settings/get_settings_usecase.dart';
import '../../../../domain/usecases/settings/update_settings_usecase.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetSettingsUseCase getSettingsUseCase;
  final UpdateSettingsUseCase updateSettingsUseCase;

  SettingsBloc({
    GetSettingsUseCase? getSettingsUseCase,
    UpdateSettingsUseCase? updateSettingsUseCase,
  })  : getSettingsUseCase = getSettingsUseCase ?? getIt<GetSettingsUseCase>(),
        updateSettingsUseCase = updateSettingsUseCase ?? getIt<UpdateSettingsUseCase>(),
        super(SettingsInitial()) {
    on<LoadSettings>(_onLoadSettings);
    on<UpdateTheme>(_onUpdateTheme);
    on<UpdateNotifications>(_onUpdateNotifications);
    on<UpdateBiometricAuth>(_onUpdateBiometricAuth);
    on<UpdateLanguage>(_onUpdateLanguage);
  }

  void _onLoadSettings(LoadSettings event, Emitter<SettingsState> emit) async {
    emit(SettingsLoading());
    
    final result = await getSettingsUseCase();
    
    result.fold(
      (failure) => emit(SettingsError(failure.message)),
      (settings) => emit(SettingsLoaded(settings: settings)),
    );
  }

  void _onUpdateTheme(UpdateTheme event, Emitter<SettingsState> emit) async {
    if (state is SettingsLoaded) {
      final currentState = state as SettingsLoaded;
      final updatedSettings = currentState.settings.copyWith(
        isDarkTheme: event.isDarkTheme,
      );
      
      final result = await updateSettingsUseCase(updatedSettings);
      
      result.fold(
        (failure) => emit(SettingsError(failure.message)),
        (settings) => emit(SettingsLoaded(settings: settings)),
      );
    }
  }

  void _onUpdateNotifications(UpdateNotifications event, Emitter<SettingsState> emit) async {
    if (state is SettingsLoaded) {
      final currentState = state as SettingsLoaded;
      final updatedSettings = currentState.settings.copyWith(
        notificationsEnabled: event.enabled,
      );
      
      final result = await updateSettingsUseCase(updatedSettings);
      
      result.fold(
        (failure) => emit(SettingsError(failure.message)),
        (settings) => emit(SettingsLoaded(settings: settings)),
      );
    }
  }

  void _onUpdateBiometricAuth(UpdateBiometricAuth event, Emitter<SettingsState> emit) async {
    if (state is SettingsLoaded) {
      final currentState = state as SettingsLoaded;
      final updatedSettings = currentState.settings.copyWith(
        biometricAuth: event.enabled,
      );
      
      final result = await updateSettingsUseCase(updatedSettings);
      
      result.fold(
        (failure) => emit(SettingsError(failure.message)),
        (settings) => emit(SettingsLoaded(settings: settings)),
      );
    }
  }

  void _onUpdateLanguage(UpdateLanguage event, Emitter<SettingsState> emit) async {
    if (state is SettingsLoaded) {
      final currentState = state as SettingsLoaded;
      final updatedSettings = currentState.settings.copyWith(
        language: event.language,
      );
      
      final result = await updateSettingsUseCase(updatedSettings);
      
      result.fold(
        (failure) => emit(SettingsError(failure.message)),
        (settings) => emit(SettingsLoaded(settings: settings)),
      );
    }
  }
}





