import '../../../../core/utils/either.dart';
import '../../../../core/errors/failures.dart';
import '../../repositories/beauty_products_repository.dart';

class GetProductIngredientsUseCase {
  final BeautyProductsRepository repository;

  GetProductIngredientsUseCase(this.repository);

  Future<Either<Failure, String>> call(String barcode) async {
    if (barcode.isEmpty) {
      return left(ValidationFailure('Штрих-код не может быть пустым'));
    }
    return repository.getProductIngredients(barcode);
  }
}

