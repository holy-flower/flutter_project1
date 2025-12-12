import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/beauty_products_bloc.dart';
import '../../../../core/di/injection_container.dart';

class ProductsSearchScreen extends StatelessWidget {
  const ProductsSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<BeautyProductsBloc>(),
      child: const ProductsSearchView(),
    );
  }
}

class ProductsSearchView extends StatefulWidget {
  const ProductsSearchView({super.key});

  @override
  State<ProductsSearchView> createState() => _ProductsSearchViewState();
}

class _ProductsSearchViewState extends State<ProductsSearchView> {
  final _searchController = TextEditingController();
  final _barcodeController = TextEditingController();
  final _ingredientController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    _barcodeController.dispose();
    _ingredientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Поиск косметических продуктов'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Поиск по названию/бренду',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                context.read<BeautyProductsBloc>().add(
                      SearchProductsEvent(_searchController.text),
                    );
              },
              child: const Text('Поиск продуктов'),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _barcodeController,
              decoration: const InputDecoration(
                labelText: 'Штрих-код продукта',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<BeautyProductsBloc>().add(
                            GetProductByBarcodeEvent(_barcodeController.text),
                          );
                    },
                    child: const Text('Получить продукт'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_barcodeController.text.isNotEmpty) {
                        context.read<BeautyProductsBloc>().add(
                              GetProductIngredientsEvent(_barcodeController.text),
                            );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[100],
                    ),
                    child: const Text('Ингредиенты'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_barcodeController.text.isNotEmpty) {
                        context.read<BeautyProductsBloc>().add(
                              GetProductRatingEvent(_barcodeController.text),
                            );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[100],
                    ),
                    child: const Text('Рейтинг'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _ingredientController,
              decoration: const InputDecoration(
                labelText: 'Ингредиент',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                context.read<BeautyProductsBloc>().add(
                      SearchProductsByIngredientEvent(_ingredientController.text),
                    );
              },
              child: const Text('Поиск по ингредиенту'),
            ),
            const SizedBox(height: 24),

            BlocBuilder<BeautyProductsBloc, BeautyProductsState>(
              builder: (context, state) {
                if (state is BeautyProductsLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is BeautyProductsError) {
                  return Card(
                    color: Colors.red[50],
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          const Icon(Icons.error_outline, color: Colors.red),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              state.message,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                if (state is BeautyProductsLoaded) {
                  final product = state.product;
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (product.productName.isNotEmpty)
                            Text(
                              product.productName,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          else
                            const Text(
                              'Название не указано',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          const SizedBox(height: 8),
                          if (product.brands.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Text('Бренд: ${product.brands}'),
                            ),
                          if (product.categories.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Text('Категории: ${product.categories}'),
                            ),
                          if (product.ingredientsText.isNotEmpty) ...[
                            const SizedBox(height: 8),
                            const Text(
                              'Ингредиенты:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(product.ingredientsText),
                          ],
                          if (product.barcode.isNotEmpty) ...[
                            const SizedBox(height: 8),
                            Text('Штрих-код: ${product.barcode}'),
                          ],
                          // Рейтинги качества продукта
                          // Отображаем секцию, если есть хотя бы один рейтинг
                          if ((product.nutriscoreGrade != null && product.nutriscoreGrade!.isNotEmpty) || 
                              (product.ecoscoreGrade != null && product.ecoscoreGrade!.isNotEmpty) || 
                              product.novaGroup != null) ...[
                            const SizedBox(height: 16),
                            const Divider(),
                            const SizedBox(height: 8),
                            const Text(
                              'Рейтинги качества:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Nutri-Score
                            if (product.nutriscoreGrade != null && product.nutriscoreGrade!.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.blue[100],
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.blue[300]!),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.star, size: 20, color: Colors.blue),
                                      const SizedBox(width: 8),
                                      const Text(
                                        'Nutri-Score: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      Text(
                                        product.nutriscoreGrade!,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            // Eco-Score
                            if (product.ecoscoreGrade != null && product.ecoscoreGrade!.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.green[100],
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.green[300]!),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.eco, size: 20, color: Colors.green),
                                      const SizedBox(width: 8),
                                      const Text(
                                        'Eco-Score: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.green,
                                        ),
                                      ),
                                      Text(
                                        product.ecoscoreGrade!,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            // Nova Group
                            if (product.novaGroup != null)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.orange[100],
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.orange[300]!),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.info_outline, size: 20, color: Colors.orange),
                                      const SizedBox(width: 8),
                                      const Text(
                                        'Nova Group: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.orange,
                                        ),
                                      ),
                                      Text(
                                        '${product.novaGroup}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.orange,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ],
                      ),
                    ),
                  );
                }
                if (state is BeautyProductsSearchLoaded) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Найдено: ${state.searchResult.count} продуктов'),
                      const SizedBox(height: 8),
                      ...state.searchResult.products.take(5).map((product) => Card(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: ListTile(
                              title: Text(product.productName),
                              subtitle: Text(product.brands),
                            ),
                          )),
                    ],
                  );
                }
                if (state is BeautyProductsIngredientsLoaded) {
                  return Card(
                    color: Colors.blue[50],
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.science, color: Colors.blue),
                              SizedBox(width: 8),
                              Text(
                                'Ингредиенты продукта:',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(state.ingredients),
                        ],
                      ),
                    ),
                  );
                }
                if (state is BeautyProductsRatingLoaded) {
                  final rating = state.rating;
                  return Card(
                    color: Colors.green[50],
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.star, color: Colors.green),
                              SizedBox(width: 8),
                              Text(
                                'Рейтинги качества:',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          if (rating.nutriscoreGrade != null && rating.nutriscoreGrade!.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.blue[100],
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.blue[300]!),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.star, size: 20, color: Colors.blue),
                                    const SizedBox(width: 8),
                                    const Text(
                                      'Nutri-Score: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    Text(
                                      rating.nutriscoreGrade!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          if (rating.ecoscoreGrade != null && rating.ecoscoreGrade!.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.green[100],
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.green[300]!),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.eco, size: 20, color: Colors.green),
                                    const SizedBox(width: 8),
                                    const Text(
                                      'Eco-Score: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.green,
                                      ),
                                    ),
                                    Text(
                                      rating.ecoscoreGrade!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          if (rating.novaGroup != null)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.orange[100],
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.orange[300]!),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.info_outline, size: 20, color: Colors.orange),
                                    const SizedBox(width: 8),
                                    const Text(
                                      'Nova Group: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.orange,
                                      ),
                                    ),
                                    Text(
                                      '${rating.novaGroup}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.orange,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          if (rating.nutriscoreGrade == null && 
                              rating.ecoscoreGrade == null && 
                              rating.novaGroup == null)
                            const Text(
                              'Рейтинги для данного продукта не найдены',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                        ],
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}

