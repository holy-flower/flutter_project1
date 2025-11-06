import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<AppState>(AppState());
}

class AppState {
  String get state => 'active';
  String get appName => 'Салон Красоты "BeautyClinic"';

  void updateState() {
  }
}

