import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      print('REQUEST[${options.method}] => URL: ${options.uri}');
      print('Base URL: ${options.baseUrl}');
      print('Path: ${options.path}');
      if (options.queryParameters.isNotEmpty) {
        print('Query Parameters: ${options.queryParameters}');
      }
      if (options.headers.isNotEmpty) {
        final safeHeaders = Map<String, dynamic>.from(options.headers);
        if (safeHeaders.containsKey('X-Api-Key')) {
          final key = safeHeaders['X-Api-Key'] as String;
          safeHeaders['X-Api-Key'] = key.length > 8 ? '${key.substring(0, 8)}...' : '***';
        }
        print('Headers: $safeHeaders');
      }
      if (options.data != null) {
        print('Body: ${options.data}');
      }
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      print('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
      if (response.data != null) {
        print('Data: ${response.data}');
      }
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      print('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
      print('Message: ${err.message}');
      if (err.response?.data != null) {
        print('Error Data: ${err.response?.data}');
      }
    }
    super.onError(err, handler);
  }
}

