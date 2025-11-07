import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.allowReassignment = true;

  getIt.registerSingleton<AppState>(AppState());
}

class AppState {
  String currentScreen = '';

  void setCurrentScreen(String screen) {
    currentScreen = screen;
    print('GetIt: Обновлен экран на: $screen');
  }
}