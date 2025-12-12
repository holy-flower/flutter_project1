import '../../../../core/utils/either.dart';
import '../../../../core/errors/failures.dart';
import '../../repositories/beauty_products_repository.dart';
import '../../entities/beauty_product.dart';

class SearchProductsByIngredientUseCase {
  final BeautyProductsRepository repository;

  SearchProductsByIngredientUseCase(this.repository);

  Future<Either<Failure, BeautyProductSearchResult>> call(String ingredient) async {
    if (ingredient.isEmpty) {
      return left(ValidationFailure('Название ингредиента не может быть пустым'));
    }
    return repository.searchByIngredient(ingredient);
  }
}

