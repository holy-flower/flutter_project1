import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.allowReassignment = true;

  getIt.registerFactory<AppState>(
          () => AppState('user'),
      instanceName: 'user_factory'
  );

  getIt.registerFactory<AppState>(
          () => AppState('admin'),
      instanceName: 'admin_factory'
  );
}

void factoryExample() {
  final userState1 = getIt.get<AppState>(instanceName: 'user_factory');
  final userState2 = getIt.get<AppState>(instanceName: 'user_factory');

  final adminState1 = getIt.get<AppState>(instanceName: 'admin_factory');
  final adminState2 = getIt.get<AppState>(instanceName: 'admin_factory');

  userState1.state = 'user_1';
  userState2.state = 'user_2';
  adminState1.state = 'admin_1';
  adminState2.state = 'admin_2';

  userState1.updateState();
  userState2.updateState();
  adminState1.updateState();
  adminState2.updateState();

  print('userState1 и userState2 одинаковые? ${userState1 == userState2}');
  print('adminState1 и adminState2 одинаковые? ${adminState1 == adminState2}');
}

class AppState {
  final String type;
  String state = 'active';

  AppState(this.type);

  void updateState() {
    print('[$type] Состояние обновлено: $state');
  }
}

