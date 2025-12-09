import 'package:get_it/get_it.dart';
import '../../data/datasources/api/auth_api_datasource.dart';
import '../../data/datasources/api/appointments_api_datasource.dart';
import '../../data/datasources/api/finance_api_datasource.dart';
import '../../data/datasources/api/inventory_api_datasource.dart';
import '../../data/datasources/api/profile_api_datasource.dart';
import '../../data/datasources/api/settings_api_datasource.dart';
import '../../data/datasources/api/services_api_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/appointments_repository_impl.dart';
import '../../data/repositories/finance_repository_impl.dart';
import '../../data/repositories/inventory_repository_impl.dart';
import '../../data/repositories/profile_repository_impl.dart';
import '../../data/repositories/settings_repository_impl.dart';
import '../../data/repositories/services_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/appointments_repository.dart';
import '../../domain/repositories/finance_repository.dart';
import '../../domain/repositories/inventory_repository.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../domain/repositories/settings_repository.dart';
import '../../domain/repositories/services_repository.dart';
import '../../domain/usecases/auth/login_usecase.dart';
import '../../domain/usecases/auth/register_usecase.dart';
import '../../domain/usecases/auth/logout_usecase.dart';
import '../../domain/usecases/appointments/get_appointments_usecase.dart';
import '../../domain/usecases/appointments/add_appointment_usecase.dart';
import '../../domain/usecases/appointments/update_appointment_usecase.dart';
import '../../domain/usecases/appointments/delete_appointment_usecase.dart';
import '../../domain/usecases/finance/get_financial_data_usecase.dart';
import '../../domain/usecases/finance/add_financial_record_usecase.dart';
import '../../domain/usecases/finance/delete_financial_record_usecase.dart';
import '../../domain/usecases/inventory/get_inventory_items_usecase.dart';
import '../../domain/usecases/inventory/add_inventory_item_usecase.dart';
import '../../domain/usecases/inventory/update_inventory_item_usecase.dart';
import '../../domain/usecases/inventory/delete_inventory_item_usecase.dart';
import '../../domain/usecases/profile/get_profile_usecase.dart';
import '../../domain/usecases/profile/update_profile_usecase.dart';
import '../../domain/usecases/settings/get_settings_usecase.dart';
import '../../domain/usecases/settings/update_settings_usecase.dart';
import '../../domain/usecases/services/get_service_categories_usecase.dart';
import '../../domain/usecases/services/get_services_by_type_usecase.dart';
import '../../domain/usecases/services/add_service_usecase.dart';
import '../../domain/usecases/services/delete_service_usecase.dart';
import '../../ui/features/auth/bloc/auth_bloc.dart';
import '../../ui/features/appointments/bloc/appointments_bloc.dart';
import '../../ui/features/profile/bloc/profile_bloc.dart';
import '../../ui/features/services/bloc/services_bloc.dart';
import '../../ui/features/settings/bloc/settings_bloc.dart';
import '../../ui/features/finance/bloc/finance_bloc.dart';
import '../../ui/features/inventory/bloc/inventory_bloc.dart';
import '../../ui/features/facial_care/bloc/facial_care_bloc.dart';
import '../../ui/features/body_care/bloc/body_care_bloc.dart';
import '../../ui/features/hair_removal/bloc/hair_removal_bloc.dart';
import '../../ui/features/massage/bloc/massage_bloc.dart';
import '../../ui/features/spa/bloc/spa_bloc.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // Data Sources
  getIt.registerLazySingleton<AuthApiDataSource>(() => AuthApiDataSourceImpl());
  getIt.registerLazySingleton<AppointmentsApiDataSource>(() => AppointmentsApiDataSourceImpl());
  getIt.registerLazySingleton<FinanceApiDataSource>(() => FinanceApiDataSourceImpl());
  getIt.registerLazySingleton<InventoryApiDataSource>(() => InventoryApiDataSourceImpl());
  getIt.registerLazySingleton<ProfileApiDataSource>(() => ProfileApiDataSourceImpl());
  getIt.registerLazySingleton<SettingsApiDataSource>(() => SettingsApiDataSourceImpl());
  getIt.registerLazySingleton<ServicesApiDataSource>(() => ServicesApiDataSourceImpl());

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<AuthApiDataSource>()),
  );
  getIt.registerLazySingleton<AppointmentsRepository>(
    () => AppointmentsRepositoryImpl(getIt<AppointmentsApiDataSource>()),
  );
  getIt.registerLazySingleton<FinanceRepository>(
    () => FinanceRepositoryImpl(getIt<FinanceApiDataSource>()),
  );
  getIt.registerLazySingleton<InventoryRepository>(
    () => InventoryRepositoryImpl(getIt<InventoryApiDataSource>()),
  );
  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(getIt<ProfileApiDataSource>()),
  );
  getIt.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(getIt<SettingsApiDataSource>()),
  );
  getIt.registerLazySingleton<ServicesRepository>(
    () => ServicesRepositoryImpl(getIt<ServicesApiDataSource>()),
  );

  // Use Cases
  getIt.registerLazySingleton(() => LoginUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => RegisterUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => LogoutUseCase(getIt<AuthRepository>()));
  
  getIt.registerLazySingleton(() => GetAppointmentsUseCase(getIt<AppointmentsRepository>()));
  getIt.registerLazySingleton(() => AddAppointmentUseCase(getIt<AppointmentsRepository>()));
  getIt.registerLazySingleton(() => UpdateAppointmentUseCase(getIt<AppointmentsRepository>()));
  getIt.registerLazySingleton(() => DeleteAppointmentUseCase(getIt<AppointmentsRepository>()));
  
  getIt.registerLazySingleton(() => GetFinancialDataUseCase(getIt<FinanceRepository>()));
  getIt.registerLazySingleton(() => AddFinancialRecordUseCase(getIt<FinanceRepository>()));
  getIt.registerLazySingleton(() => DeleteFinancialRecordUseCase(getIt<FinanceRepository>()));
  
  getIt.registerLazySingleton(() => GetInventoryItemsUseCase(getIt<InventoryRepository>()));
  getIt.registerLazySingleton(() => AddInventoryItemUseCase(getIt<InventoryRepository>()));
  getIt.registerLazySingleton(() => UpdateInventoryItemUseCase(getIt<InventoryRepository>()));
  getIt.registerLazySingleton(() => DeleteInventoryItemUseCase(getIt<InventoryRepository>()));
  
  getIt.registerLazySingleton(() => GetProfileUseCase(getIt<ProfileRepository>()));
  getIt.registerLazySingleton(() => UpdateProfileUseCase(getIt<ProfileRepository>()));
  
  getIt.registerLazySingleton(() => GetSettingsUseCase(getIt<SettingsRepository>()));
  getIt.registerLazySingleton(() => UpdateSettingsUseCase(getIt<SettingsRepository>()));
  
  getIt.registerLazySingleton(() => GetServiceCategoriesUseCase(getIt<ServicesRepository>()));
  getIt.registerLazySingleton(() => GetServicesByTypeUseCase(getIt<ServicesRepository>()));
  getIt.registerLazySingleton(() => AddServiceUseCase(getIt<ServicesRepository>()));
  getIt.registerLazySingleton(() => DeleteServiceUseCase(getIt<ServicesRepository>()));

  // BLoCs
  getIt.registerFactory(() => AuthBloc(
    loginUseCase: getIt<LoginUseCase>(),
    registerUseCase: getIt<RegisterUseCase>(),
    logoutUseCase: getIt<LogoutUseCase>(),
  ));
  getIt.registerFactory(() => AppointmentsBloc(
    getAppointmentsUseCase: getIt<GetAppointmentsUseCase>(),
    addAppointmentUseCase: getIt<AddAppointmentUseCase>(),
    updateAppointmentUseCase: getIt<UpdateAppointmentUseCase>(),
    deleteAppointmentUseCase: getIt<DeleteAppointmentUseCase>(),
  ));
  getIt.registerFactory(() => ProfileBloc(
    getProfileUseCase: getIt<GetProfileUseCase>(),
    updateProfileUseCase: getIt<UpdateProfileUseCase>(),
  ));
  getIt.registerFactory(() => ServicesBloc(
    getServiceCategoriesUseCase: getIt<GetServiceCategoriesUseCase>(),
    getServicesByTypeUseCase: getIt<GetServicesByTypeUseCase>(),
  ));
  getIt.registerFactory(() => SettingsBloc(
    getSettingsUseCase: getIt<GetSettingsUseCase>(),
    updateSettingsUseCase: getIt<UpdateSettingsUseCase>(),
  ));
  getIt.registerFactory(() => FinanceBloc(
    getFinancialDataUseCase: getIt<GetFinancialDataUseCase>(),
    addFinancialRecordUseCase: getIt<AddFinancialRecordUseCase>(),
    deleteFinancialRecordUseCase: getIt<DeleteFinancialRecordUseCase>(),
  ));
  getIt.registerFactory(() => InventoryBloc(
    getInventoryItemsUseCase: getIt<GetInventoryItemsUseCase>(),
    addInventoryItemUseCase: getIt<AddInventoryItemUseCase>(),
    updateInventoryItemUseCase: getIt<UpdateInventoryItemUseCase>(),
    deleteInventoryItemUseCase: getIt<DeleteInventoryItemUseCase>(),
  ));
  getIt.registerFactory(() => FacialCareBloc(
    getServicesByTypeUseCase: getIt<GetServicesByTypeUseCase>(),
    addServiceUseCase: getIt<AddServiceUseCase>(),
    deleteServiceUseCase: getIt<DeleteServiceUseCase>(),
  ));
  getIt.registerFactory(() => BodyCareBloc(
    getServicesByTypeUseCase: getIt<GetServicesByTypeUseCase>(),
    addServiceUseCase: getIt<AddServiceUseCase>(),
    deleteServiceUseCase: getIt<DeleteServiceUseCase>(),
  ));
  getIt.registerFactory(() => HairRemovalBloc(
    getServicesByTypeUseCase: getIt<GetServicesByTypeUseCase>(),
    addServiceUseCase: getIt<AddServiceUseCase>(),
    deleteServiceUseCase: getIt<DeleteServiceUseCase>(),
  ));
  getIt.registerFactory(() => MassageBloc(
    getServicesByTypeUseCase: getIt<GetServicesByTypeUseCase>(),
    addServiceUseCase: getIt<AddServiceUseCase>(),
    deleteServiceUseCase: getIt<DeleteServiceUseCase>(),
  ));
  getIt.registerFactory(() => SpaBloc(
    getServicesByTypeUseCase: getIt<GetServicesByTypeUseCase>(),
    addServiceUseCase: getIt<AddServiceUseCase>(),
    deleteServiceUseCase: getIt<DeleteServiceUseCase>(),
  ));
}

