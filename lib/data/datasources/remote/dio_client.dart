import 'package:dio/dio.dart';
import '../../../core/config/api_config.dart';
import 'interceptors/logging_interceptor.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/error_interceptor.dart';

class DioClient {
  static Dio createOpenBeautyFactsDio() {
    final dio = Dio(BaseOptions(
      baseUrl: ApiConfig.openBeautyFactsBaseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    dio.interceptors.addAll([
      LoggingInterceptor(),
      ErrorInterceptor(),
    ]);

    return dio;
  }

  static Dio createNewsApiDio() {
    final dio = Dio(BaseOptions(
      baseUrl: ApiConfig.newsApiBaseUrl,
      connectTimeout: const Duration(seconds: 60), // Увеличено для запросов по датам
      receiveTimeout: const Duration(seconds: 60), // Увеличено для запросов по датам
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    dio.interceptors.addAll([
      AuthInterceptor(),
      LoggingInterceptor(),
      ErrorInterceptor(),
    ]);

    return dio;
  }
}

