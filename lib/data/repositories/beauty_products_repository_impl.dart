import '../../core/utils/either.dart';
import '../../core/errors/failures.dart';
import '../../domain/repositories/beauty_products_repository.dart';
import '../../domain/entities/beauty_product.dart';
import '../datasources/remote/beauty_products_remote_datasource.dart';
import '../datasources/remote/mappers/beauty_product_mapper.dart';

class BeautyProductsRepositoryImpl implements BeautyProductsRepository {
  final BeautyProductsRemoteDataSource remoteDataSource;

  BeautyProductsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, BeautyProduct>> getProductByBarcode(String barcode) async {
    final result = await remoteDataSource.getProductByBarcode(barcode);
    return result.fold(
      (failure) => left(failure),
      (dto) {
        try {
          return right(dto.toDomain());
        } catch (e) {
          return left(NetworkFailure('Ошибка при обработке данных продукта: ${e.toString()}'));
        }
      },
    );
  }

  @override
  Future<Either<Failure, BeautyProductSearchResult>> searchProducts(String query, {int? pageSize}) async {
    final result = await remoteDataSource.searchProducts(query, pageSize: pageSize);
    return result.map((dto) => dto.toDomain());
  }

  @override
  Future<Either<Failure, String>> getProductIngredients(String barcode) async {
    return await remoteDataSource.getProductIngredients(barcode);
  }

  @override
  Future<Either<Failure, BeautyProductSearchResult>> searchByIngredient(String ingredient) async {
    final result = await remoteDataSource.searchByIngredient(ingredient);
    return result.map((dto) => dto.toDomain());
  }

  @override
  Future<Either<Failure, ProductRating>> getProductRating(String barcode) async {
    return await remoteDataSource.getProductRating(barcode);
  }
}

