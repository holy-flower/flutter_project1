import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/config/api_config.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final uriString = options.uri.toString();
    final baseUrlString = options.baseUrl;
    
    if (baseUrlString.contains('newsapi.org') || uriString.contains('newsapi.org')) {
      options.headers['X-Api-Key'] = ApiConfig.newsApiKey;
      if (kDebugMode) {
        print('Added API Key to NewsAPI request: ${ApiConfig.newsApiKey.substring(0, 8)}...');
        print('Full URL: ${options.uri}');
        print('Headers: ${options.headers}');
      }
    }
    super.onRequest(options, handler);
  }
}

