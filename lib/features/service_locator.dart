import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.allowReassignment = true;

  getIt.registerSingleton<AppState>(AppState(), instanceName: 'user');
  getIt.registerSingleton<AppState>(AppState(), instanceName: 'admin');
}

class AppState {
  String state = 'active';

  void updateState() {
    print('Состояние обновлено: $state');
  }
}

