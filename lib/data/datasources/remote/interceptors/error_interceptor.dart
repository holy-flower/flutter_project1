import 'package:dio/dio.dart';

import '../exceptions/network_exceptions.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    late NetworkException exception;
    
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        exception = const TimeoutException();
        break;
      
      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode;
        if (statusCode == null) {
          exception = const ServerException();
        } else if (statusCode >= 400 && statusCode < 500) {
          if (statusCode == 401) {
            final errorData = err.response?.data;
            String message = 'Требуется авторизация';
            if (errorData != null && errorData is Map) {
              final apiMessage = errorData['message']?.toString() ?? 
                                errorData['code']?.toString();
              if (apiMessage != null) {
                message = 'Ошибка авторизации: $apiMessage. Проверьте API ключ в api_config.dart';
              }
            }
            exception = UnauthorizedException(message);
          } else if (statusCode == 429) {
            exception = UnknownNetworkException('Превышен лимит запросов. Попробуйте позже.');
          } else {
            final errorData = err.response?.data;
            String errorMessage = 'Некорректный запрос';
            if (errorData != null && errorData is Map) {
              errorMessage = errorData['message']?.toString() ?? 
                           errorData['error']?.toString() ?? 
                           errorMessage;
            }
            exception = BadRequestException(errorMessage);
          }
        } else {
          exception = ServerException(
            err.response?.data?['message']?.toString() ?? 'Ошибка сервера'
          );
        }
        break;
      
      case DioExceptionType.connectionError:
        exception = const NoInternetException();
        break;
      
      default:
        exception = UnknownNetworkException(err.message ?? 'Неизвестная ошибка сети');
        break;
    }
    
    handler.reject(DioException(
      requestOptions: err.requestOptions,
      error: exception,
      type: err.type,
      response: err.response,
    ));
  }
}

