import '../../../../core/utils/either.dart';
import '../../../../core/errors/failures.dart';
import '../../repositories/beauty_products_repository.dart';
import '../../entities/beauty_product.dart';

class GetProductByBarcodeUseCase {
  final BeautyProductsRepository repository;

  GetProductByBarcodeUseCase(this.repository);

  Future<Either<Failure, BeautyProduct>> call(String barcode) async {
    if (barcode.isEmpty) {
      return left(ValidationFailure('Штрих-код не может быть пустым'));
    }
    return repository.getProductByBarcode(barcode);
  }
}

