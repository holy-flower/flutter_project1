import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsInitial()) {
    on<LoadSettings>(_onLoadSettings);
    on<UpdateTheme>(_onUpdateTheme);
    on<UpdateNotifications>(_onUpdateNotifications);
    on<UpdateBiometricAuth>(_onUpdateBiometricAuth);
    on<UpdateLanguage>(_onUpdateLanguage);
  }

  void _onLoadSettings(LoadSettings event, Emitter<SettingsState> emit) async {
    try {
      emit(SettingsLoading());

      await Future.delayed(const Duration(milliseconds: 300));

      final settings = AppSettings(
        isDarkTheme: false,
        notificationsEnabled: true,
        biometricAuth: false,
        language: 'Русский',
        appVersion: '1.0.0',
        lastUpdated: DateTime.now(),
      );

      emit(SettingsLoaded(settings: settings));
    } catch (e) {
      emit(SettingsError('Не удалось загрузить настройки: $e'));
    }
  }

  void _onUpdateTheme(UpdateTheme event, Emitter<SettingsState> emit) {
    if (state is SettingsLoaded) {
      final currentState = state as SettingsLoaded;
      final updatedSettings = currentState.settings.copyWith(
        isDarkTheme: event.isDarkTheme,
      );

      emit(SettingsLoaded(settings: updatedSettings));
    }
  }

  void _onUpdateNotifications(UpdateNotifications event, Emitter<SettingsState> emit) {
    if (state is SettingsLoaded) {
      final currentState = state as SettingsLoaded;
      final updatedSettings = currentState.settings.copyWith(
        notificationsEnabled: event.enabled,
      );

      emit(SettingsLoaded(settings: updatedSettings));
    }
  }

  void _onUpdateBiometricAuth(UpdateBiometricAuth event, Emitter<SettingsState> emit) {
    if (state is SettingsLoaded) {
      final currentState = state as SettingsLoaded;
      final updatedSettings = currentState.settings.copyWith(
        biometricAuth: event.enabled,
      );

      emit(SettingsLoaded(settings: updatedSettings));
    }
  }

  void _onUpdateLanguage(UpdateLanguage event, Emitter<SettingsState> emit) {
    if (state is SettingsLoaded) {
      final currentState = state as SettingsLoaded;
      final updatedSettings = currentState.settings.copyWith(
        language: event.language,
      );

      emit(SettingsLoaded(settings: updatedSettings));
    }
  }
}