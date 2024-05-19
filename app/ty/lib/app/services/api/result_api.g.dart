// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ResultApi implements ResultApi {
  _ResultApi(
    this._dio, {
    this.baseUrl,
  });

  final Dio _dio;

  String? baseUrl;

  @override
  Future<GetFilterMatchListNewEntity> getFilterMatchListNew(
    type,
    euid,
    inputText,
    cuid,
    device,
    showem,
    md,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'type': type,
      r'euid': euid,
      r'inputText': inputText,
      r'cuid': cuid,
      r'device': device,
      r'showem': showem,
      r'md': md,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetFilterMatchListNewEntity>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu11/v1/m/getFilterMatchListNew',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetFilterMatchListNewEntity.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiRes<List<MatchEntity>>> matcheResult(
    category,
    cuid,
    device,
    euid,
    hpsFlag,
    md,
    showem,
    sort,
    tid,
    type,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'category': category,
      'cuid': cuid,
      'device': device,
      'euid': euid,
      'hpsFlag': hpsFlag,
      'md': md,
      'showem': showem,
      'sort': sort,
      'tid': tid,
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
              '/yewu11/v1/m/matcheResultPB',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiRes<List<MatchEntity>>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiRes<List<dynamic>>> getMatchResult(
    mcid,
    mid,
    cuid,
    isESport,
  ) async {
    const _extra = <String, dynamic>{
      'retry_retryable': true,
      'retry_code': '0401038',
    };
    final queryParameters = <String, dynamic>{
      r'mcid': mcid,
      r'mid': mid,
      r'cuid': cuid,
      r'isESport': isESport,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiRes<List<dynamic>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu11/v1/m/matchDetail/getMatchResult',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiRes<List<dynamic>>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiRes<MatchEntity>> getResultMatchDetail(
    mid,
    type,
    cuid,
    isESport,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'mid': mid,
      r'type': type,
      r'cuid': cuid,
      r'isESport': isESport,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiRes<MatchEntity>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu11/v1/m/matchDetail/getResultMatchDetail',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiRes<MatchEntity>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiRes<List<MatchEntity>>> matcheHandpick(
    cuid,
    sportId,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'cuid': cuid,
      'sportId': sportId,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiRes<List<MatchEntity>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu11/v1/m/matcheHandpick',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiRes<List<MatchEntity>>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PlaybackVideoUrlEntity> playbackVideoUrl(
    device,
    eventCode,
    mid,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'device': device,
      'eventCode': eventCode,
      'mid': mid,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PlaybackVideoUrlEntity>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu11/v1/w/playbackVideoUrl',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PlaybackVideoUrlEntity.fromJson(_result.data!);
    return value;
  }

  @override
  Future<MchampionMatchResultEntity> championMatchResult(
    category,
    cuid,
    device,
    endTime,
    euid,
    isVirtualSport,
    md,
    orderBy,
    sort,
    sportType,
    startTime,
    type,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'category': category,
      'cuid': cuid,
      'device': device,
      'endTime': endTime,
      'euid': euid,
      'isVirtualSport': isVirtualSport,
      'md': md,
      'orderBy': orderBy,
      'sort': sort,
      'sportType': sportType,
      'startTime': startTime,
      'type': type,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<MchampionMatchResultEntity>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu11/v1/m/championMatchResult',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = MchampionMatchResultEntity.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetH5OrderListEntity> resultGetH5OrderList(
    matchId,
    orderBy,
    orderStatus,
    timeType,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'matchId': matchId,
      'orderBy': orderBy,
      'orderStatus': orderStatus,
      'timeType': timeType,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetH5OrderListEntity>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu12/order/betRecord/getH5OrderList',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetH5OrderListEntity.fromJson(_result.data!);
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
