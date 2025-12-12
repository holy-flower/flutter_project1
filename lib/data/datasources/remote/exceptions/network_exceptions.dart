import '../../../../core/errors/failures.dart';

abstract class NetworkException implements Exception {
  final String message;
  const NetworkException(this.message);
  
  Failure toFailure();
}

class TimeoutException extends NetworkException {
  const TimeoutException([super.message = 'Превышено время ожидания запроса']);
  
  @override
  Failure toFailure() => NetworkFailure(message);
}

class BadRequestException extends NetworkException {
  const BadRequestException([super.message = 'Некорректный запрос']);
  
  @override
  Failure toFailure() => NetworkFailure(message);
}

class UnauthorizedException extends NetworkException {
  const UnauthorizedException([super.message = 'Требуется авторизация']);
  
  @override
  Failure toFailure() => NetworkFailure(message);
}

class ServerException extends NetworkException {
  const ServerException([super.message = 'Ошибка сервера']);
  
  @override
  Failure toFailure() => ServerFailure(message);
}

class NoInternetException extends NetworkException {
  const NoInternetException([super.message = 'Нет подключения к интернету']);
  
  @override
  Failure toFailure() => NetworkFailure(message);
}

class UnknownNetworkException extends NetworkException {
  const UnknownNetworkException([super.message = 'Неизвестная ошибка сети']);
  
  @override
  Failure toFailure() => NetworkFailure(message);
}

