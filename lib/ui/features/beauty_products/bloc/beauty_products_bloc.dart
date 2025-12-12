import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../domain/entities/beauty_product.dart';
import '../../../../domain/repositories/beauty_products_repository.dart';
import '../../../../domain/usecases/beauty_products/get_product_by_barcode_usecase.dart';
import '../../../../domain/usecases/beauty_products/search_products_usecase.dart';
import '../../../../domain/usecases/beauty_products/get_product_ingredients_usecase.dart';
import '../../../../domain/usecases/beauty_products/search_products_by_ingredient_usecase.dart';
import '../../../../domain/usecases/beauty_products/get_product_rating_usecase.dart';

part 'beauty_products_event.dart';
part 'beauty_products_state.dart';

class BeautyProductsBloc extends Bloc<BeautyProductsEvent, BeautyProductsState> {
  final GetProductByBarcodeUseCase getProductByBarcodeUseCase;
  final SearchProductsUseCase searchProductsUseCase;
  final GetProductIngredientsUseCase getProductIngredientsUseCase;
  final SearchProductsByIngredientUseCase searchProductsByIngredientUseCase;
  final GetProductRatingUseCase getProductRatingUseCase;

  BeautyProductsBloc({
    required this.getProductByBarcodeUseCase,
    required this.searchProductsUseCase,
    required this.getProductIngredientsUseCase,
    required this.searchProductsByIngredientUseCase,
    required this.getProductRatingUseCase,
  }) : super(BeautyProductsInitial()) {
    on<GetProductByBarcodeEvent>(_onGetProductByBarcode);
    on<SearchProductsEvent>(_onSearchProducts);
    on<GetProductIngredientsEvent>(_onGetProductIngredients);
    on<SearchProductsByIngredientEvent>(_onSearchProductsByIngredient);
    on<GetProductRatingEvent>(_onGetProductRating);
  }

  Future<void> _onGetProductByBarcode(
    GetProductByBarcodeEvent event,
    Emitter<BeautyProductsState> emit,
  ) async {
    emit(BeautyProductsLoading());
    final result = await getProductByBarcodeUseCase(event.barcode);
    result.fold(
      (failure) => emit(BeautyProductsError(failure.message)),
      (product) => emit(BeautyProductsLoaded(product: product)),
    );
  }

  Future<void> _onSearchProducts(
    SearchProductsEvent event,
    Emitter<BeautyProductsState> emit,
  ) async {
    emit(BeautyProductsLoading());
    final result = await searchProductsUseCase(event.query, pageSize: event.pageSize);
    result.fold(
      (failure) => emit(BeautyProductsError(failure.message)),
      (searchResult) => emit(BeautyProductsSearchLoaded(searchResult: searchResult)),
    );
  }

  Future<void> _onGetProductIngredients(
    GetProductIngredientsEvent event,
    Emitter<BeautyProductsState> emit,
  ) async {
    emit(BeautyProductsLoading());
    final result = await getProductIngredientsUseCase(event.barcode);
    result.fold(
      (failure) => emit(BeautyProductsError(failure.message)),
      (ingredients) => emit(BeautyProductsIngredientsLoaded(ingredients: ingredients)),
    );
  }

  Future<void> _onSearchProductsByIngredient(
    SearchProductsByIngredientEvent event,
    Emitter<BeautyProductsState> emit,
  ) async {
    emit(BeautyProductsLoading());
    final result = await searchProductsByIngredientUseCase(event.ingredient);
    result.fold(
      (failure) => emit(BeautyProductsError(failure.message)),
      (searchResult) => emit(BeautyProductsSearchLoaded(searchResult: searchResult)),
    );
  }

  Future<void> _onGetProductRating(
    GetProductRatingEvent event,
    Emitter<BeautyProductsState> emit,
  ) async {
    emit(BeautyProductsLoading());
    final result = await getProductRatingUseCase(event.barcode);
    result.fold(
      (failure) => emit(BeautyProductsError(failure.message)),
      (rating) => emit(BeautyProductsRatingLoaded(rating: rating)),
    );
  }
}

