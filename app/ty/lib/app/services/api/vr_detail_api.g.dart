// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vr_detail_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _VrDetailApi implements VrDetailApi {
  _VrDetailApi(
    this._dio, {
    this.baseUrl,
  });

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ApiRes<List<CommonScoreModelData>>> getVirtualSportTeamRanking(
      tid) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'tid': tid};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiRes<List<CommonScoreModelData>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu11/v1/w/virtual/getVirtualSportTeamRanking',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiRes<List<CommonScoreModelData>>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiRes<List<GroupSoureModelDataGroupData>>>
      getVirtualSportXZTeamRanking(tid) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'tid': tid};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiRes<List<GroupSoureModelDataGroupData>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu11/v1/w/virtual/getVirtualSportXZTeamRanking',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        ApiRes<List<GroupSoureModelDataGroupData>>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiRes<Map<String, dynamic>>> getMatchSorce(
    tid,
    batchNo,
    lod,
    mmp,
    beginTime,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'tid': tid,
      r'batchNo': batchNo,
      r'lod': lod,
      r'mmp': mmp,
      r'beginTime': beginTime,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiRes<Map<String, dynamic>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu11/v1/w/virtual/getMatchSorce',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiRes<Map<String, dynamic>>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiRes<List<VrHistoryDogEntity>>> getVirtualMatchDetailCount(
      mid) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'mid': mid};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiRes<List<VrHistoryDogEntity>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu11/v1/m/matchDetail/getVirtualMatchDetailCount',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiRes<List<VrHistoryDogEntity>>.fromJson(_result.data!);
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
