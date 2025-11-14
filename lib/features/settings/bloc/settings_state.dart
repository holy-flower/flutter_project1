part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class SettingsInitial extends SettingsState {}

class SettingsLoading extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final AppSettings settings;

  const SettingsLoaded({required this.settings});

  @override
  List<Object> get props => [settings];
}

class SettingsError extends SettingsState {
  final String message;

  const SettingsError(this.message);

  @override
  List<Object> get props => [message];
}

class AppSettings {
  final bool isDarkTheme;
  final bool notificationsEnabled;
  final bool biometricAuth;
  final String language;
  final String appVersion;
  final DateTime lastUpdated;

  const AppSettings({
    required this.isDarkTheme,
    required this.notificationsEnabled,
    required this.biometricAuth,
    required this.language,
    required this.appVersion,
    required this.lastUpdated,
  });

  AppSettings copyWith({
    bool? isDarkTheme,
    bool? notificationsEnabled,
    bool? biometricAuth,
    String? language,
    String? appVersion,
    DateTime? lastUpdated,
  }) {
    return AppSettings(
      isDarkTheme: isDarkTheme ?? this.isDarkTheme,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      biometricAuth: biometricAuth ?? this.biometricAuth,
      language: language ?? this.language,
      appVersion: appVersion ?? this.appVersion,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}