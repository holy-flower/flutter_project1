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

void checkRegistrationExamples() {
  final isUserRegistered = GetIt.I.isRegistered<AppState>(instanceName: 'user_factory');
  final isAdminRegistered = GetIt.instance.isRegistered<AppState>(instanceName: 'admin_factory');
  final isMainRegistered = GetIt.I.isRegistered<AppState>();

  print('User factory зарегистрирован: $isUserRegistered');
  print('Admin factory зарегистрирован: $isAdminRegistered');
  print('Main AppState зарегистрирован: $isMainRegistered');

  final isNotRegistered = GetIt.I.isRegistered<AppState>(instanceName: 'not_existing');
  print('Несуществующий объект: $isNotRegistered');
}

class AppState {
  final String type;
  String state = 'active';

  AppState(this.type);

  void updateState() {
    print('[$type] Состояние обновлено: $state');
  }
}

