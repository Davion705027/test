// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analyze_detail_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _AnalyzeDetailApi implements AnalyzeDetailApi {
  _AnalyzeDetailApi(
    this._dio, {
    this.baseUrl,
  });

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ApiRes<AnalyzeBackVideoInfoEntityEntityEntityEntity>> playbackVideoUrl(
    mid,
    device,
    eventCode,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'mid': mid,
      'device': device,
      'eventCode': eventCode,
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiRes<AnalyzeBackVideoInfoEntityEntityEntityEntity>>(
            Options(
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
    final value = ApiRes<AnalyzeBackVideoInfoEntityEntityEntityEntity>.fromJson(
        _result.data!);
    return value;
  }

  @override
  Future<ApiRes<List<AnalyzeVSInfoEntity>>> vsInfo(
    mid,
    flag,
    t,
  ) async {
    const _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{
      r'mid': mid,
      r'flag': flag,
      r'': t,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiRes<List<AnalyzeVSInfoEntity>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu11/v2/statistics/vsInfo',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiRes<List<AnalyzeVSInfoEntity>>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiRes<List<AnalyzeTeamVsHistoryEntity>>> teamVSHistory(
    mid,
    flag,
    cps,
  ) async {
    const _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{
      r'mid': mid,
      r'flag': flag,
      r'cps': cps,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiRes<List<AnalyzeTeamVsHistoryEntity>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu11/v2/statistics/teamVSHistory',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        ApiRes<List<AnalyzeTeamVsHistoryEntity>>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiRes<List<AnalyzeTeamVsOtherTeamItemEntityEntity>>> teamVsOtherTeam(
    mid,
    flag,
    cps,
  ) async {
    const _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{
      r'mid': mid,
      r'flag': flag,
      r'cps': cps,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiRes<List<AnalyzeTeamVsOtherTeamItemEntityEntity>>>(
            Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
                .compose(
                  _dio.options,
                  '/yewu11/v2/statistics/teamVsOtherTeam',
                  queryParameters: queryParameters,
                  data: _data,
                )
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiRes<List<AnalyzeTeamVsOtherTeamItemEntityEntity>>.fromJson(
        _result.data!);
    return value;
  }

  @override
  Future<ApiRes<Map<String, dynamic>>> getMatchAnalysiseData(
    parentMenuId,
    sonMenuId,
    standardMatchId,
  ) async {
    const _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'parentMenuId': parentMenuId,
      'sonMenuId': sonMenuId,
      'standardMatchId': standardMatchId,
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiRes<Map<String, dynamic>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu11/v1/w/matchAnalysise/getMatchAnalysiseData',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiRes<Map<String, dynamic>>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiRes<String>> addArticleCount(id) async {
    const _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {'id': id};
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ApiRes<String>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu11/v1/art/addArticleCount',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiRes<String>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiRes<AnalyzeNewsEntity>> getArticle(
    matchId,
    type,
    t,
  ) async {
    const _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{
      r'matchId': matchId,
      r'type': type,
      r't': t,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiRes<AnalyzeNewsEntity>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu11/v1/art/getArticle',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiRes<AnalyzeNewsEntity>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiRes<AnalyzeArrayPersonEntity>> getMatchLineupList(
    matchInfoId,
    homeAway,
  ) async {
    const _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{
      r'matchInfoId': matchInfoId,
      r'homeAway': homeAway,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiRes<AnalyzeArrayPersonEntity>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu11/v2/matchLineup/getMatchLineupList',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiRes<AnalyzeArrayPersonEntity>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiRes<List<AnalyzeNewsEntity>>> getFavoriteArticle(
    id,
    matchId,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'id': id,
      r'matchId': matchId,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiRes<List<AnalyzeNewsEntity>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu11/v1/art/getFavoriteArticle',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiRes<List<AnalyzeNewsEntity>>.fromJson(_result.data!);
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
