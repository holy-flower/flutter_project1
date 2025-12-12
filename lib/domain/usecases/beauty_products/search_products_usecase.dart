import '../../../../core/utils/either.dart';
import '../../../../core/errors/failures.dart';
import '../../repositories/beauty_products_repository.dart';
import '../../entities/beauty_product.dart';

class SearchProductsUseCase {
  final BeautyProductsRepository repository;

  SearchProductsUseCase(this.repository);

  Future<Either<Failure, BeautyProductSearchResult>> call(String query, {int? pageSize}) async {
    if (query.isEmpty) {
      return left(ValidationFailure('Поисковый запрос не может быть пустым'));
    }
    return repository.searchProducts(query, pageSize: pageSize);
  }
}

