import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../core/utils/either.dart';
import '../../../core/errors/failures.dart';
import '../../../core/config/api_config.dart';
import 'exceptions/network_exceptions.dart';
import 'newsapi.dart';
import 'dio_client.dart';
import 'dto/news_article_dto.dart';

abstract class CosmetologyNewsRemoteDataSource {
  Future<Either<Failure, NewsResponseDto>> searchCosmetologyNews();
  Future<Either<Failure, NewsResponseDto>> getSkincareNews();
  Future<Either<Failure, NewsResponseDto>> getTopBeautyNews();
  Future<Either<Failure, NewsResponseDto>> getCosmeticsNewsByDate(String fromDate, String toDate);
  Future<Either<Failure, NewsSourcesResponseDto>> getHealthNewsSources();
}

class CosmetologyNewsRemoteDataSourceImpl implements CosmetologyNewsRemoteDataSource {
  final NewsApi _api;

  CosmetologyNewsRemoteDataSourceImpl()
      : _api = NewsApi(DioClient.createNewsApiDio());

  @override
  Future<Either<Failure, NewsResponseDto>> searchCosmetologyNews() async {
    try {
      final result = await _api.searchNews(
        'косметология',
        'ru',
        'publishedAt',
      );
      if (result.status != 'ok') {
        return left(NetworkFailure('Ошибка API: ${result.status}'));
      }
      return right(result);
    } on NetworkException catch (e) {
      return left(e.toFailure());
    } on DioException catch (e) {
      if (e.error is NetworkException) {
        return left((e.error as NetworkException).toFailure());
      }
      if (e.response != null) {
        final statusCode = e.response!.statusCode;
        final errorData = e.response!.data;
        if (statusCode == 401) {
          if (kDebugMode) {
            print('NewsAPI 401 Unauthorized. API Key used: ${ApiConfig.newsApiKey.substring(0, 8)}...');
          }
          return left(NetworkFailure('Ошибка авторизации NewsAPI. Проверьте API ключ в api_config.dart'));
        }
        if (errorData != null && errorData is Map) {
          final message = errorData['message'] ?? errorData['code'];
          return left(NetworkFailure('NewsAPI ошибка: $message'));
        }
        return left(NetworkFailure('Ошибка сервера: $statusCode'));
      }
      return left(NetworkFailure(e.message ?? 'Ошибка сети'));
    } catch (e) {
      return left(NetworkFailure('Неизвестная ошибка: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, NewsResponseDto>> getSkincareNews() async {
    try {
      final result = await _api.searchNews(
        'skincare',
        'ru',
        'relevancy',
      );
      if (result.status != 'ok') {
        return left(NetworkFailure('Ошибка API: ${result.status}'));
      }
      return right(result);
    } on NetworkException catch (e) {
      return left(e.toFailure());
    } on DioException catch (e) {
      if (e.error is NetworkException) {
        return left((e.error as NetworkException).toFailure());
      }
      if (e.response != null) {
        final statusCode = e.response!.statusCode;
        if (statusCode == 401) {
          return left(NetworkFailure('Ошибка авторизации NewsAPI. Проверьте API ключ.'));
        }
        final errorData = e.response!.data;
        if (errorData != null && errorData is Map) {
          final message = errorData['message'] ?? errorData['code'];
          return left(NetworkFailure('NewsAPI ошибка: $message'));
        }
      }
      return left(NetworkFailure(e.message ?? 'Ошибка сети'));
    } catch (e) {
      return left(NetworkFailure('Неизвестная ошибка: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, NewsResponseDto>> getTopBeautyNews() async {
    try {
      final result = await _api.getTopHeadlines(
        'health',
        'beauty',
        'ru',
      );
      return right(result);
    } on NetworkException catch (e) {
      return left(e.toFailure());
    } on DioException catch (e) {
      if (e.error is NetworkException) {
        return left((e.error as NetworkException).toFailure());
      }
      if (e.response?.statusCode == 401) {
        return left(NetworkFailure('Ошибка авторизации. Проверьте API ключ NewsAPI.'));
      }
      return left(NetworkFailure(e.message ?? 'Ошибка сети'));
    } catch (e) {
      return left(NetworkFailure('Неизвестная ошибка: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, NewsResponseDto>> getCosmeticsNewsByDate(String fromDate, String toDate) async {
    try {
      final fromDateTime = DateTime.tryParse(fromDate);
      final toDateTime = DateTime.tryParse(toDate);
      final now = DateTime.now();
      final oneMonthAgo = now.subtract(const Duration(days: 30));
      
      if (fromDateTime != null && fromDateTime.isBefore(oneMonthAgo)) {
        return left(NetworkFailure(
          'Бесплатный тариф NewsAPI позволяет искать новости только за последние 30 дней. '
          'Выберите даты не ранее ${oneMonthAgo.toIso8601String().split('T')[0]}'
        ));
      }
      
      if (fromDateTime != null && toDateTime != null && fromDateTime.isAfter(toDateTime)) {
        return left(NetworkFailure('Дата начала не может быть позже даты окончания'));
      }
      
      final result = await _api.getNewsByDate(
        'cosmetics',
        fromDate,
        toDate,
        'publishedAt',
      );
      
      if (result.status != 'ok') {
        return left(NetworkFailure('Ошибка API: ${result.status}'));
      }
      
      return right(result);
    } on NetworkException catch (e) {
      return left(e.toFailure());
    } on DioException catch (e) {
      if (e.error is NetworkException) {
        return left((e.error as NetworkException).toFailure());
      }
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        return left(NetworkFailure(
          'Превышено время ожидания запроса. NewsAPI может быть перегружен. '
          'Попробуйте уменьшить диапазон дат или повторить запрос позже.'
        ));
      }
      if (e.response?.statusCode == 401) {
        return left(NetworkFailure('Ошибка авторизации. Проверьте API ключ NewsAPI.'));
      }
      if (e.response?.statusCode == 429) {
        return left(NetworkFailure('Превышен лимит запросов NewsAPI. Попробуйте позже.'));
      }
      return left(NetworkFailure(e.message ?? 'Ошибка сети'));
    } catch (e) {
      return left(NetworkFailure('Неизвестная ошибка: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, NewsSourcesResponseDto>> getHealthNewsSources() async {
    try {
      final result = await _api.getSources(
        'health',
        'ru',
      );
      return right(result);
    } on NetworkException catch (e) {
      return left(e.toFailure());
    } on DioException catch (e) {
      if (e.error is NetworkException) {
        return left((e.error as NetworkException).toFailure());
      }
      if (e.response?.statusCode == 401) {
        return left(NetworkFailure('Ошибка авторизации. Проверьте API ключ NewsAPI.'));
      }
      return left(NetworkFailure(e.message ?? 'Ошибка сети'));
    } catch (e) {
      return left(NetworkFailure('Неизвестная ошибка: ${e.toString()}'));
    }
  }
}

