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


