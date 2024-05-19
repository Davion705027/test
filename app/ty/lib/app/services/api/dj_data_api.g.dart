// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dj_data_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _DjDataApi implements DjDataApi {
  _DjDataApi(
    this._dio, {
    this.baseUrl,
  });

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ApiRes<List<DjDateEntityEntity>>> getDateMenuList(csid) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'csid': csid};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiRes<List<DjDateEntityEntity>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu11/v1/w/esports/getDateMenuList',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiRes<List<DjDateEntityEntity>>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiRes<List<MatchEntity>>> esportsMatches(
    category,
    csid,
    cuid,
    euid,
    hpsFlag,
    md,
    sort,
    type,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'category': category,
      'csid': csid,
      'cuid': cuid,
      'euid': euid,
      'hpsFlag': hpsFlag,
      'md': md,
      'sort': sort,
      'type': type,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiRes<List<MatchEntity>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu11/v1/m/esportsMatches',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiRes<List<MatchEntity>>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiRes<List<MatchEntity>>> collection(
    collect,
    csid,
    cuid,
    euid,
    hpsFlag,
    md,
    sort,
    type,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'collect': collect,
      'csid': csid,
      'cuid': cuid,
      'euid': euid,
      'hpsFlag': hpsFlag,
      'md': md,
      'sort': sort,
      'type': type,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiRes<List<MatchEntity>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu11/v1/m/escnh5',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiRes<List<MatchEntity>>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiRes<List<MatchEntity>>> matchesPB(
    category,
    cuid,
    euid,
    hpsFlag,
    md,
    sort,
    type,
  ) async {
    const _extra = <String, dynamic>{
      'retry_retryable': true,
      'retry_code': '0401038',
    };
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'category': category,
      'cuid': cuid,
      'euid': euid,
      'hpsFlag': hpsFlag,
      'md': md,
      'sort': sort,
      'type': type,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiRes<List<MatchEntity>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu11/v1/m/matchesPB',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiRes<List<MatchEntity>>.fromJson(_result.data!);
    return value;
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
}
