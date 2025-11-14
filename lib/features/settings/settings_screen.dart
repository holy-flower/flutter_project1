import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/settings_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsBloc()..add(LoadSettings()),
      child: Scaffold(
        body: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            if (state is SettingsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SettingsError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<SettingsBloc>().add(LoadSettings());
                      },
                      child: const Text('Повторить'),
                    ),
                  ],
                ),
              );
            } else if (state is SettingsLoaded) {
              return _buildSettingsContent(context, state.settings);
            } else {
              return const Center(child: Text('Загрузка настроек...'));
            }
          },
        ),
      ),
    );
  }

  Widget _buildSettingsContent(BuildContext context, AppSettings settings) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Внешний вид',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Темная тема'),
                      Switch(
                        value: settings.isDarkTheme,
                        onChanged: (value) {
                          context.read<SettingsBloc>().add(UpdateTheme(value));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Уведомления',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Push-уведомления'),
                      Switch(
                        value: settings.notificationsEnabled,
                        onChanged: (value) {
                          context.read<SettingsBloc>().add(UpdateNotifications(value));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Безопасность',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Биометрическая аутентификация'),
                      Switch(
                        value: settings.biometricAuth,
                        onChanged: (value) {
                          context.read<SettingsBloc>().add(UpdateBiometricAuth(value));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildSettingsItem(
                    context,
                    'Язык',
                    settings.language,
                    Icons.language,
                        () => _showLanguageDialog(context, settings),
                  ),
                  const Divider(),
                  _buildSettingsItem(
                    context,
                    'Политика конфиденциальности',
                    '',
                    Icons.privacy_tip,
                        () => _showPrivacyPolicy(context),
                  ),
                  const Divider(),
                  _buildSettingsItem(
                    context,
                    'Условия использования',
                    '',
                    Icons.description,
                        () => _showTermsOfUse(context),
                  ),
                  const Divider(),
                  _buildSettingsItem(
                    context,
                    'О приложении',
                    'Версия ${settings.appVersion}',
                    Icons.info,
                        () => _showAboutDialog(context, settings),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          Card(
            color: Colors.red[50],
            child: ListTile(
              leading: Icon(Icons.restore, color: Colors.red[700]),
              title: Text(
                'Сбросить настройки',
                style: TextStyle(
                  color: Colors.red[700],
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.red[700]),
              onTap: () => _showResetConfirmationDialog(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(
      BuildContext context,
      String title,
      String subtitle,
      IconData icon,
      VoidCallback onTap,
      ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: subtitle.isNotEmpty ? Text(subtitle) : null,
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }

  void _showLanguageDialog(BuildContext context, AppSettings settings) {
    final languages = ['Русский', 'English', 'Español', 'Deutsch'];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Выберите язык'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: languages.map((language) =>
                RadioListTile<String>(
                  title: Text(language),
                  value: language,
                  groupValue: settings.language,
                  onChanged: (value) {
                    if (value != null) {
                      context.read<SettingsBloc>().add(UpdateLanguage(value));
                      Navigator.pop(context);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Язык изменен на $value'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  },
                )
            ).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Отмена'),
            ),
          ],
        );
      },
    );
  }

  void _showPrivacyPolicy(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Политика конфиденциальности'),
        content: const SingleChildScrollView(
          child: Text(
            'Здесь будет отображаться политика конфиденциальности приложения BeautyClinic Pro. '
                'Мы серьезно относимся к защите ваших персональных данных и соблюдаем все требования законодательства.',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Закрыть'),
          ),
        ],
      ),
    );
  }

  void _showTermsOfUse(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Условия использования'),
        content: const SingleChildScrollView(
          child: Text(
            'Условия использования приложения BeautyClinic Pro. '
                'Используя данное приложение, вы соглашаетесь с нашими условиями и правилами.',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Закрыть'),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context, AppSettings settings) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('О приложении'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'BeautyClinic Pro',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text('Версия: ${settings.appVersion}'),
              const SizedBox(height: 8),
              Text('Последнее обновление: ${_formatDate(settings.lastUpdated)}'),
              const SizedBox(height: 16),
              const Text(
                'Профессиональное приложение для управления косметологическим салоном. '
                    'Разработано с использованием Flutter и BLoC архитектуры.',
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Закрыть'),
          ),
        ],
      ),
    );
  }

  void _showResetConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Сброс настроек'),
        content: const Text('Вы уверены, что хотите сбросить все настройки к значениям по умолчанию?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<SettingsBloc>().add(LoadSettings());
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Настройки сброшены'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Сбросить', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}.${date.month}.${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}