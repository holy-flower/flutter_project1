import 'package:get_it/get_it.dart';
import '../../data/datasources/api/auth_api_datasource.dart';
import '../../data/datasources/api/profile_api_datasource.dart';
import '../../data/datasources/api/services_api_datasource.dart';
import '../../data/datasources/local/settings_local_datasource.dart';
import '../../data/datasources/local/auth_local_datasource.dart';
import '../../data/datasources/local/app_database.dart';
import '../../data/datasources/local/appointments_local_datasource.dart';
import '../../data/datasources/local/inventory_local_datasource.dart';
import '../../data/datasources/local/finance_local_datasource.dart';
import '../../data/datasources/local/services_local_datasource.dart';
import '../../data/datasources/remote/beauty_products_remote_datasource.dart';
import '../../data/datasources/remote/cosmetology_news_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/appointments_repository_impl.dart';
import '../../data/repositories/finance_repository_impl.dart';
import '../../data/repositories/inventory_repository_impl.dart';
import '../../data/repositories/profile_repository_impl.dart';
import '../../data/repositories/settings_repository_impl.dart';
import '../../data/repositories/services_repository_impl.dart';
import '../../data/repositories/beauty_products_repository_impl.dart';
import '../../data/repositories/cosmetology_news_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/appointments_repository.dart';
import '../../domain/repositories/finance_repository.dart';
import '../../domain/repositories/inventory_repository.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../domain/repositories/settings_repository.dart';
import '../../domain/repositories/services_repository.dart';
import '../../domain/repositories/beauty_products_repository.dart';
import '../../domain/repositories/cosmetology_news_repository.dart';
import '../../domain/usecases/auth/login_usecase.dart';
import '../../domain/usecases/auth/register_usecase.dart';
import '../../domain/usecases/auth/logout_usecase.dart';
import '../../domain/usecases/auth/get_current_user_usecase.dart';
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
import '../../domain/usecases/beauty_products/get_product_by_barcode_usecase.dart';
import '../../domain/usecases/beauty_products/search_products_usecase.dart';
import '../../domain/usecases/beauty_products/get_product_ingredients_usecase.dart';
import '../../domain/usecases/beauty_products/search_products_by_ingredient_usecase.dart';
import '../../domain/usecases/beauty_products/get_product_rating_usecase.dart';
import '../../domain/usecases/cosmetology_news/search_cosmetology_news_usecase.dart';
import '../../domain/usecases/cosmetology_news/get_skincare_news_usecase.dart';
import '../../domain/usecases/cosmetology_news/get_top_beauty_news_usecase.dart';
import '../../domain/usecases/cosmetology_news/get_cosmetics_news_by_date_usecase.dart';
import '../../domain/usecases/cosmetology_news/get_health_news_sources_usecase.dart';
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
import '../../ui/features/beauty_products/bloc/beauty_products_bloc.dart';
import '../../ui/features/cosmetology_news/bloc/cosmetology_news_bloc.dart';

import '../../data/datasources/local/shared_preferences_service.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // Initialize SharedPreferences
  await SharedPreferencesService.init();
  
  // Database
  getIt.registerLazySingleton<AppDatabase>(() => AppDatabase());

  // Local Data Sources
  getIt.registerLazySingleton<SettingsLocalDataSource>(
    () => SettingsLocalDataSourceImpl(),
  );
  getIt.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(),
  );
  getIt.registerLazySingleton<AppointmentsLocalDataSource>(
    () => AppointmentsLocalDataSourceImpl(getIt<AppDatabase>()),
  );
  getIt.registerLazySingleton<InventoryLocalDataSource>(
    () => InventoryLocalDataSourceImpl(getIt<AppDatabase>()),
  );
  getIt.registerLazySingleton<FinanceLocalDataSource>(
    () => FinanceLocalDataSourceImpl(getIt<AppDatabase>()),
  );
  getIt.registerLazySingleton<ServicesLocalDataSource>(
    () => ServicesLocalDataSourceImpl(getIt<AppDatabase>()),
  );

  // API Data Sources (для аутентификации)
  getIt.registerLazySingleton<AuthApiDataSource>(() => AuthApiDataSourceImpl());
  getIt.registerLazySingleton<ProfileApiDataSource>(() => ProfileApiDataSourceImpl());

  // Remote Data Sources
  getIt.registerLazySingleton<BeautyProductsRemoteDataSource>(
    () => BeautyProductsRemoteDataSourceImpl(),
  );
  getIt.registerLazySingleton<CosmetologyNewsRemoteDataSource>(
    () => CosmetologyNewsRemoteDataSourceImpl(),
  );

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      getIt<AuthApiDataSource>(),
      getIt<AuthLocalDataSource>(),
    ),
  );
  getIt.registerLazySingleton<AppointmentsRepository>(
    () => AppointmentsRepositoryImpl(getIt<AppointmentsLocalDataSource>()),
  );
  getIt.registerLazySingleton<FinanceRepository>(
    () => FinanceRepositoryImpl(getIt<FinanceLocalDataSource>()),
  );
  getIt.registerLazySingleton<InventoryRepository>(
    () => InventoryRepositoryImpl(getIt<InventoryLocalDataSource>()),
  );
  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(getIt<ProfileApiDataSource>()),
  );
  getIt.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(getIt<SettingsLocalDataSource>()),
  );
  getIt.registerLazySingleton<ServicesRepository>(
    () => ServicesRepositoryImpl(getIt<ServicesLocalDataSource>()),
  );
  getIt.registerLazySingleton<BeautyProductsRepository>(
    () => BeautyProductsRepositoryImpl(getIt<BeautyProductsRemoteDataSource>()),
  );
  getIt.registerLazySingleton<CosmetologyNewsRepository>(
    () => CosmetologyNewsRepositoryImpl(getIt<CosmetologyNewsRemoteDataSource>()),
  );

  // Use Cases
  getIt.registerLazySingleton(() => LoginUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => RegisterUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => LogoutUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => GetCurrentUserUseCase(getIt<AuthRepository>()));
  
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

  // Beauty Products Use Cases
  getIt.registerLazySingleton(() => GetProductByBarcodeUseCase(getIt<BeautyProductsRepository>()));
  getIt.registerLazySingleton(() => SearchProductsUseCase(getIt<BeautyProductsRepository>()));
  getIt.registerLazySingleton(() => GetProductIngredientsUseCase(getIt<BeautyProductsRepository>()));
  getIt.registerLazySingleton(() => SearchProductsByIngredientUseCase(getIt<BeautyProductsRepository>()));
  getIt.registerLazySingleton(() => GetProductRatingUseCase(getIt<BeautyProductsRepository>()));

  // Cosmetology News Use Cases
  getIt.registerLazySingleton(() => SearchCosmetologyNewsUseCase(getIt<CosmetologyNewsRepository>()));
  getIt.registerLazySingleton(() => GetSkincareNewsUseCase(getIt<CosmetologyNewsRepository>()));
  getIt.registerLazySingleton(() => GetTopBeautyNewsUseCase(getIt<CosmetologyNewsRepository>()));
  getIt.registerLazySingleton(() => GetCosmeticsNewsByDateUseCase(getIt<CosmetologyNewsRepository>()));
  getIt.registerLazySingleton(() => GetHealthNewsSourcesUseCase(getIt<CosmetologyNewsRepository>()));

  // BLoCs
  getIt.registerFactory(() => AuthBloc(
    loginUseCase: getIt<LoginUseCase>(),
    registerUseCase: getIt<RegisterUseCase>(),
    logoutUseCase: getIt<LogoutUseCase>(),
    getCurrentUserUseCase: getIt<GetCurrentUserUseCase>(),
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
  getIt.registerFactory(() => BeautyProductsBloc(
    getProductByBarcodeUseCase: getIt<GetProductByBarcodeUseCase>(),
    searchProductsUseCase: getIt<SearchProductsUseCase>(),
    getProductIngredientsUseCase: getIt<GetProductIngredientsUseCase>(),
    searchProductsByIngredientUseCase: getIt<SearchProductsByIngredientUseCase>(),
    getProductRatingUseCase: getIt<GetProductRatingUseCase>(),
  ));
  getIt.registerFactory(() => CosmetologyNewsBloc(
    searchCosmetologyNewsUseCase: getIt<SearchCosmetologyNewsUseCase>(),
    getSkincareNewsUseCase: getIt<GetSkincareNewsUseCase>(),
    getTopBeautyNewsUseCase: getIt<GetTopBeautyNewsUseCase>(),
    getCosmeticsNewsByDateUseCase: getIt<GetCosmeticsNewsByDateUseCase>(),
    getHealthNewsSourcesUseCase: getIt<GetHealthNewsSourcesUseCase>(),
  ));
}

