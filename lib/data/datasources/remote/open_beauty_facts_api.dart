import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:retrofit/retrofit.dart';
import '../../../core/config/api_config.dart';
import 'dto/beauty_product_dto.dart';

part 'open_beauty_facts_api.g.dart';

@RestApi(baseUrl: ApiConfig.openBeautyFactsBaseUrl)
abstract class OpenBeautyFactsApi {
  factory OpenBeautyFactsApi(Dio dio) = _OpenBeautyFactsApi;

  @GET("/api/v0/product/{barcode}.json")
  Future<BeautyProductDto> getProductByBarcode(@Path("barcode") String barcode);

  @GET("/cgi/search.pl")
  Future<BeautyProductSearchDto> searchProducts(
    @Query("search_terms") String query,
    @Query("search_simple") int? simple,
    @Query("action") String action,
    @Query("json") int json,
    @Query("page_size") int? pageSize,
  );

  @GET("/cgi/search.pl")
  Future<BeautyProductSearchDto> searchByIngredient(
    @Query("tagtype_0") String tagType,
    @Query("tag_contains_0") String? tagContains,
    @Query("tag_0") String ingredient,
    @Query("action") String action,
    @Query("json") int json,
  );
}

