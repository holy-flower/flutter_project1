part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class LoadSettings extends SettingsEvent {}

class UpdateTheme extends SettingsEvent {
  final bool isDarkTheme;

  const UpdateTheme(this.isDarkTheme);

  @override
  List<Object> get props => [isDarkTheme];
}

class UpdateNotifications extends SettingsEvent {
  final bool enabled;

  const UpdateNotifications(this.enabled);

  @override
  List<Object> get props => [enabled];
}

class UpdateBiometricAuth extends SettingsEvent {
  final bool enabled;

  const UpdateBiometricAuth(this.enabled);

  @override
  List<Object> get props => [enabled];
}

class UpdateLanguage extends SettingsEvent {
  final String language;

  const UpdateLanguage(this.language);

  @override
  List<Object> get props => [language];
}