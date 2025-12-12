part of 'open_beauty_facts_api.dart';

class _OpenBeautyFactsApi implements OpenBeautyFactsApi {
  _OpenBeautyFactsApi(this._dio, {this.baseUrl, this.errorLogger}) {
    baseUrl ??= 'https://world.openbeautyfacts.org';
  }

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<BeautyProductDto> getProductByBarcode(String barcode) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<BeautyProductDto>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/api/v0/product/${barcode}.json',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late BeautyProductDto _value;
    try {
      if (kDebugMode && _result.data != null) {
        print('Product by barcode response keys: ${(_result.data as Map).keys.toList()}');
        if ((_result.data as Map).containsKey('product')) {
          final product = (_result.data as Map)['product'];
          if (product is Map) {
            print('Product keys: ${(product as Map).keys.toList()}');
            final nameKeys = (product as Map).keys.where((k) => 
              k.toString().toLowerCase().contains('name')).toList();
            print('Name-related keys: $nameKeys');
            for (var key in nameKeys) {
              print('$key: ${product[key]} (type: ${product[key]?.runtimeType})');
            }
            print('Product brands: ${product['brands']} (type: ${product['brands']?.runtimeType})');
            print('Product categories: ${product['categories']} (type: ${product['categories']?.runtimeType})');
            print('Product nutriscore_grade: ${product['nutriscore_grade']} (type: ${product['nutriscore_grade']?.runtimeType})');
            print('Product ecoscore_grade: ${product['ecoscore_grade']} (type: ${product['ecoscore_grade']?.runtimeType})');
            print('Product nova_group: ${product['nova_group']} (type: ${product['nova_group']?.runtimeType})');
            // Проверяем альтернативные названия полей
            print('Product nutriscore: ${product['nutriscore']}');
            print('Product ecoscore: ${product['ecoscore']}');
            print('Product nova: ${product['nova']}');
            // Выводим все ключи продукта для отладки
            print('All product keys: ${product.keys.toList()}');
          }
        }
      }
      _value = BeautyProductDto.fromJson(_result.data!);
    } on Object catch (e, s) {
      if (kDebugMode) {
        print('Error parsing product by barcode: $e');
        print('Stack trace: $s');
        print('Response data: ${_result.data}');
      }
      rethrow;
    }
    return _value;
  }

  @override
  Future<BeautyProductSearchDto> searchProducts(
    String query,
    int? simple,
    String action,
    int json,
    int? pageSize,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'search_terms': query,
      r'search_simple': simple,
      r'action': action,
      r'json': json,
      r'page_size': pageSize,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<BeautyProductSearchDto>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/cgi/search.pl',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late BeautyProductSearchDto _value;
    try {
      if (kDebugMode && _result.data != null) {
        print('Raw API response keys (search): ${(_result.data as Map).keys.toList()}');
        if ((_result.data as Map).containsKey('products')) {
          final products = (_result.data as Map)['products'];
          print('Products type: ${products.runtimeType}');
          if (products is List) {
            print('Products is List, length: ${products.length}');
            if (products.isNotEmpty) {
              print('First product type: ${products.first.runtimeType}');
              print('First product: ${products.first}');
            }
          } else if (products is Map) {
            print('Products is Map, keys count: ${products.length}');
            if (products.isNotEmpty) {
              final firstKey = products.keys.first;
              final firstValue = products[firstKey];
              print('First product key: $firstKey');
              print('First product value type: ${firstValue.runtimeType}');
              print('First product value: $firstValue');
            }
          }
        }
        print('Full response: ${_result.data}');
      }
      _value = BeautyProductSearchDto.fromJson(_result.data!);
    } on FormatException catch (e) {
      if (kDebugMode) {
        print('FormatException during parsing (search): $e');
        print('Response data: ${_result.data}');
      }
      rethrow;
    } on TypeError catch (e) {
      if (kDebugMode) {
        print('TypeError during parsing (search): $e');
        print('Response data: ${_result.data}');
      }
      rethrow;
    } on Object catch (e, s) {
      if (kDebugMode) {
        print('Error during parsing (search): $e');
        print('Stack trace: $s');
        print('Response data: ${_result.data}');
      }
      rethrow;
    }
    return _value;
  }

  @override
  Future<BeautyProductSearchDto> searchByIngredient(
    String tagType,
    String? tagContains,
    String ingredient,
    String action,
    int json,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'tagtype_0': tagType,
      r'tag_contains_0': tagContains,
      r'tag_0': ingredient,
      r'action': action,
      r'json': json,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<BeautyProductSearchDto>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/cgi/search.pl',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late BeautyProductSearchDto _value;
    try {
      if (kDebugMode && _result.data != null) {
        print('Raw API response keys (ingredient): ${(_result.data as Map).keys.toList()}');
      }
      _value = BeautyProductSearchDto.fromJson(_result.data!);
    } on FormatException catch (e) {
      if (kDebugMode) {
        print('FormatException during parsing (ingredient): $e');
        print('Response data: ${_result.data}');
      }
      rethrow;
    } on TypeError catch (e) {
      if (kDebugMode) {
        print('TypeError during parsing (ingredient): $e');
        print('Response data: ${_result.data}');
      }
      rethrow;
    } on Object catch (e, s) {
      if (kDebugMode) {
        print('Error during parsing (ingredient): $e');
        print('Stack trace: $s');
        print('Response data: ${_result.data}');
      }

      rethrow;
    }
    return _value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(String dioBaseUrl, String? baseUrl) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
