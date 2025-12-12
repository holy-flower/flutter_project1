import '../../../../core/utils/either.dart';
import '../../../../core/errors/failures.dart';
import '../../repositories/beauty_products_repository.dart';

class GetProductRatingUseCase {
  final BeautyProductsRepository repository;

  GetProductRatingUseCase(this.repository);

  Future<Either<Failure, ProductRating>> call(String barcode) async {
    if (barcode.isEmpty) {
      return left(ValidationFailure('Штрих-код не может быть пустым'));
    }
    return repository.getProductRating(barcode);
  }
}

