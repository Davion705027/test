// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vr_sports_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _VrSportsApi implements VrSportsApi {
  _VrSportsApi(
    this._dio, {
    this.baseUrl,
  });

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ApiRes<List<VrSportsMenuEntity>>> getVrSportsMenus(
    device,
    time,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'device': device,
      r't': time,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiRes<List<VrSportsMenuEntity>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu11/v1/w/virtual/menus',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiRes<List<VrSportsMenuEntity>>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiRes<List<VrMatchEntity>>> getVirtualMatches(
    csid,
    tid,
    device,
    time,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r't': time};
    final _headers = <String, dynamic>{};
    final _data = {
      'csid': csid,
      'tid': tid,
      'device': device,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiRes<List<VrMatchEntity>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu11/v1/m/virtualMatches',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiRes<List<VrMatchEntity>>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiRes<VrSportReplayEntity>> virtualReplay(
    batchNo,
    csid,
    tid,
    time,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r't': time};
    final _headers = <String, dynamic>{};
    final _data = {
      'batchNo': batchNo,
      'csid': csid,
      'tid': tid,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiRes<VrSportReplayEntity>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu11/v1/w/virtualReplay',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiRes<VrSportReplayEntity>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiRes<dynamic>> getMatchScore(
    mids,
    time,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r't': time};
    final _headers = <String, dynamic>{};
    final _data = {'mids': mids};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ApiRes<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu11/v1/w/virtual/getMatchScore',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiRes<dynamic>.fromJson(_result.data!);
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
