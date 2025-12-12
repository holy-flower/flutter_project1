import '../../../core/utils/either.dart';
import '../../../core/errors/failures.dart';
import '../entities/beauty_product.dart';

abstract class BeautyProductsRepository {
  Future<Either<Failure, BeautyProduct>> getProductByBarcode(String barcode);
  Future<Either<Failure, BeautyProductSearchResult>> searchProducts(String query, {int? pageSize});
  Future<Either<Failure, String>> getProductIngredients(String barcode);
  Future<Either<Failure, BeautyProductSearchResult>> searchByIngredient(String ingredient);
  Future<Either<Failure, ProductRating>> getProductRating(String barcode);
}

class ProductRating {
  final String? nutriscoreGrade;
  final String? ecoscoreGrade;
  final int? novaGroup;

  ProductRating({
    this.nutriscoreGrade,
    this.ecoscoreGrade,
    this.novaGroup,
  });
}

