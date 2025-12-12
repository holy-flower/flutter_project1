import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../domain/entities/news_article.dart';
import '../../../../domain/usecases/cosmetology_news/search_cosmetology_news_usecase.dart';
import '../../../../domain/usecases/cosmetology_news/get_skincare_news_usecase.dart';
import '../../../../domain/usecases/cosmetology_news/get_top_beauty_news_usecase.dart';
import '../../../../domain/usecases/cosmetology_news/get_cosmetics_news_by_date_usecase.dart';
import '../../../../domain/usecases/cosmetology_news/get_health_news_sources_usecase.dart';

part 'cosmetology_news_event.dart';
part 'cosmetology_news_state.dart';

class CosmetologyNewsBloc extends Bloc<CosmetologyNewsEvent, CosmetologyNewsState> {
  final SearchCosmetologyNewsUseCase searchCosmetologyNewsUseCase;
  final GetSkincareNewsUseCase getSkincareNewsUseCase;
  final GetTopBeautyNewsUseCase getTopBeautyNewsUseCase;
  final GetCosmeticsNewsByDateUseCase getCosmeticsNewsByDateUseCase;
  final GetHealthNewsSourcesUseCase getHealthNewsSourcesUseCase;

  CosmetologyNewsBloc({
    required this.searchCosmetologyNewsUseCase,
    required this.getSkincareNewsUseCase,
    required this.getTopBeautyNewsUseCase,
    required this.getCosmeticsNewsByDateUseCase,
    required this.getHealthNewsSourcesUseCase,
  }) : super(CosmetologyNewsInitial()) {
    on<SearchCosmetologyNewsEvent>(_onSearchCosmetologyNews);
    on<GetSkincareNewsEvent>(_onGetSkincareNews);
    on<GetTopBeautyNewsEvent>(_onGetTopBeautyNews);
    on<GetCosmeticsNewsByDateEvent>(_onGetCosmeticsNewsByDate);
    on<GetHealthNewsSourcesEvent>(_onGetHealthNewsSources);
  }

  Future<void> _onSearchCosmetologyNews(
    SearchCosmetologyNewsEvent event,
    Emitter<CosmetologyNewsState> emit,
  ) async {
    emit(CosmetologyNewsLoading());
    final result = await searchCosmetologyNewsUseCase();
    result.fold(
      (failure) => emit(CosmetologyNewsError(failure.message)),
      (newsResponse) => emit(CosmetologyNewsLoaded(newsResponse: newsResponse)),
    );
  }

  Future<void> _onGetSkincareNews(
    GetSkincareNewsEvent event,
    Emitter<CosmetologyNewsState> emit,
  ) async {
    emit(CosmetologyNewsLoading());
    final result = await getSkincareNewsUseCase();
    result.fold(
      (failure) => emit(CosmetologyNewsError(failure.message)),
      (newsResponse) => emit(CosmetologyNewsLoaded(newsResponse: newsResponse)),
    );
  }

  Future<void> _onGetTopBeautyNews(
    GetTopBeautyNewsEvent event,
    Emitter<CosmetologyNewsState> emit,
  ) async {
    emit(CosmetologyNewsLoading());
    final result = await getTopBeautyNewsUseCase();
    result.fold(
      (failure) => emit(CosmetologyNewsError(failure.message)),
      (newsResponse) => emit(CosmetologyNewsLoaded(newsResponse: newsResponse)),
    );
  }

  Future<void> _onGetCosmeticsNewsByDate(
    GetCosmeticsNewsByDateEvent event,
    Emitter<CosmetologyNewsState> emit,
  ) async {
    emit(CosmetologyNewsLoading());
    final result = await getCosmeticsNewsByDateUseCase(event.fromDate, event.toDate);
    result.fold(
      (failure) => emit(CosmetologyNewsError(failure.message)),
      (newsResponse) => emit(CosmetologyNewsLoaded(newsResponse: newsResponse)),
    );
  }

  Future<void> _onGetHealthNewsSources(
    GetHealthNewsSourcesEvent event,
    Emitter<CosmetologyNewsState> emit,
  ) async {
    emit(CosmetologyNewsLoading());
    final result = await getHealthNewsSourcesUseCase();
    result.fold(
      (failure) => emit(CosmetologyNewsError(failure.message)),
      (sourcesResponse) => emit(CosmetologyNewsSourcesLoaded(sourcesResponse: sourcesResponse)),
    );
  }
}

