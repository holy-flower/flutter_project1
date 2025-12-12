import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../core/utils/either.dart';
import '../../../core/errors/failures.dart';
import '../../../domain/repositories/beauty_products_repository.dart';
import 'exceptions/network_exceptions.dart';
import 'open_beauty_facts_api.dart';
import 'dio_client.dart';
import 'dto/beauty_product_dto.dart';

abstract class BeautyProductsRemoteDataSource {
  Future<Either<Failure, BeautyProductDto>> getProductByBarcode(String barcode);
  Future<Either<Failure, BeautyProductSearchDto>> searchProducts(String query, {int? pageSize});
  Future<Either<Failure, String>> getProductIngredients(String barcode);
  Future<Either<Failure, BeautyProductSearchDto>> searchByIngredient(String ingredient);
  Future<Either<Failure, ProductRating>> getProductRating(String barcode);
}

class BeautyProductsRemoteDataSourceImpl implements BeautyProductsRemoteDataSource {
  final OpenBeautyFactsApi _api;

  BeautyProductsRemoteDataSourceImpl()
      : _api = OpenBeautyFactsApi(DioClient.createOpenBeautyFactsDio());

  @override
  Future<Either<Failure, BeautyProductDto>> getProductByBarcode(String barcode) async {
    try {
      final result = await _api.getProductByBarcode(barcode);

      if (result.product == null) {
        if (kDebugMode) {
          print('Product not found. Status: ${result.status}, StatusVerbose: ${result.statusVerbose}');
        }
        return left(NetworkFailure('Продукт со штрих-кодом $barcode не найден в базе данных.'));
      }

      if (result.status != null && result.status != 'found' && result.status != '1') {
        if (kDebugMode) {
          print('Product status indicates not found. Status: ${result.status}, StatusVerbose: ${result.statusVerbose}');
        }
        return left(NetworkFailure('Продукт со штрих-кодом $barcode не найден в базе данных.'));
      }
      
      return right(result);
    } on NetworkException catch (e) {
      return left(e.toFailure());
    } on DioException catch (e) {
      if (e.error is NetworkException) {
        return left((e.error as NetworkException).toFailure());
      }
      if (e.response?.statusCode == 404) {
        return left(NetworkFailure('Продукт со штрих-кодом $barcode не найден в базе данных.'));
      }
      return left(NetworkFailure(e.message ?? 'Ошибка сети'));
    } catch (e) {
      if (kDebugMode) {
        print('Unknown error in getProductByBarcode: $e');
      }
      return left(NetworkFailure('Неизвестная ошибка: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, BeautyProductSearchDto>> searchProducts(String query, {int? pageSize}) async {
    try {
      if (kDebugMode) {
        print('Searching products with query: "$query"');
      }
      final result = await _api.searchProducts(
        query,
        1,
        'process',
        1,
        pageSize ?? 20,
      );
      if (kDebugMode) {
        print('Search result: count=${result.count}, products=${result.products?.length ?? 0}');
      }
      return right(result);
    } on NetworkException catch (e) {
      if (kDebugMode) {
        print('NetworkException: ${e.message}');
      }
      return left(e.toFailure());
    } on DioException catch (e) {
      if (e.error is NetworkException) {
        return left((e.error as NetworkException).toFailure());
      }
      if (e.response != null) {
        final statusCode = e.response!.statusCode;
        final responseData = e.response!.data;
        if (kDebugMode) {
          print('Open Beauty Facts DioException: Status=$statusCode');
          print('Response Data: $responseData');
          print('Error Type: ${e.type}');
          print('Error Message: ${e.message}');
        }
        if (statusCode == 404) {
          return left(NetworkFailure('Продукты не найдены. Попробуйте другой запрос.'));
        }
        return left(NetworkFailure('Ошибка сервера: $statusCode'));
      }
      if (kDebugMode) {
        print('DioException without response: ${e.message}');
        print('Error Type: ${e.type}');
      }
      return left(NetworkFailure(e.message ?? 'Ошибка сети'));
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('Unknown error during search: $e');
        print('Stack trace: $stackTrace');
        print('Error type: ${e.runtimeType}');
      }
      return left(NetworkFailure('Неизвестная ошибка: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, String>> getProductIngredients(String barcode) async {
    try {
      final result = await _api.getProductByBarcode(barcode);
      final ingredients = result.product?.ingredientsText ?? 
                         result.product?.ingredientsTextRu ?? 
                         '';
      return right(ingredients);
    } on NetworkException catch (e) {
      return left(e.toFailure());
    } on DioException catch (e) {
      if (e.error is NetworkException) {
        return left((e.error as NetworkException).toFailure());
      }
      return left(NetworkFailure(e.message ?? 'Ошибка сети'));
    } catch (e) {
      return left(NetworkFailure('Неизвестная ошибка: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, BeautyProductSearchDto>> searchByIngredient(String ingredient) async {
    try {
      final result = await _api.searchByIngredient(
        'ingredients',
        'contains',
        ingredient,
        'process',
        1,
      );
      return right(result);
    } on NetworkException catch (e) {
      return left(e.toFailure());
    } on DioException catch (e) {
      if (e.error is NetworkException) {
        return left((e.error as NetworkException).toFailure());
      }
      return left(NetworkFailure(e.message ?? 'Ошибка сети'));
    } catch (e) {
      return left(NetworkFailure('Неизвестная ошибка: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, ProductRating>> getProductRating(String barcode) async {
    try {
      final result = await _api.getProductByBarcode(barcode);
      final rating = ProductRating(
        nutriscoreGrade: result.product?.nutriscoreGrade,
        ecoscoreGrade: result.product?.ecoscoreGrade,
        novaGroup: result.product?.novaGroup,
      );
      return right(rating);
    } on NetworkException catch (e) {
      return left(e.toFailure());
    } on DioException catch (e) {
      if (e.error is NetworkException) {
        return left((e.error as NetworkException).toFailure());
      }
      return left(NetworkFailure(e.message ?? 'Ошибка сети'));
    } catch (e) {
      return left(NetworkFailure('Неизвестная ошибка: ${e.toString()}'));
    }
  }
}

