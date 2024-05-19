// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _MatchApi implements MatchApi {
  _MatchApi(
    this._dio, {
    this.baseUrl,
  });

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ChampionMatchResultEntity> championMatchResults(
    euid,
    type,
    orderBy,
    category,
    startTime,
    endTime,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'euid': euid,
      r'type': type,
      r'orderBy': orderBy,
      r'category': category,
      r'startTime': startTime,
      r'endTime': endTime,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ChampionMatchResultEntity>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/championMatchResult',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ChampionMatchResultEntity.fromJson(_result.data!);
    return value;
  }

  @override
  Future<EventInfo2Entity> getEventInfo() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<EventInfo2Entity>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu11/v1/w/eventInfo',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = EventInfo2Entity.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiRes<List<MatchEntity>>> matchesCollectNewH5(req) async {
    const _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(req.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiRes<List<MatchEntity>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu11/v1/m/matchesCollectNewH5',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiRes<List<MatchEntity>>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiRes<Map<String, CollectionInfo?>>> collectMatches(
    matchType,
    cuid,
  ) async {
    const _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'matchType': matchType,
      'cuid': cuid,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiRes<Map<String, CollectionInfo>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu11/v1/w/collectMatches',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiRes<Map<String, CollectionInfo>>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiRes<List<MatchEntity>>> getMatchBaseInfo(
    mids,
    cuid,
    sort,
    euid,
    device,
    pids,
    isUser,
    playId,
    tabs,
  ) async {
    const _extra = <String, dynamic>{
      'retry_retryable': true,
      'throttle_able': true,
      'throttle_durtion': 1000,
    };
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'mids': mids,
      'cuid': cuid,
      'sort': sort,
      'euid': euid,
      'device': device,
      'pids': pids,
      'is_user': isUser,
      'playId': playId,
      'tabs': tabs,
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiRes<List<MatchEntity>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu11/v1/m/getMatchBaseInfoByMidsPB',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiRes<List<MatchEntity>>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiRes<List<MatchEntity>>> matches(req) async {
    const _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(req.toJson());
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

  @override
  Future<ApiRes<List<CollectionCountInfo>>> updateCollectMatches(
    cuid,
    euid,
    sort,
    type,
  ) async {
    const _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'cuid': cuid,
      'euid': euid,
      'sort': sort,
      'type': type,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiRes<List<CollectionCountInfo>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu11/v1/w/menu/countCollect',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiRes<List<CollectionCountInfo>>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiRes<int>> addOrCancelMatch(
    cuid,
    mid,
    cf,
  ) async {
    const _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'cuid': cuid,
      'mid': mid,
      'cf': cf,
    };
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ApiRes<int>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu13/v1/userCollection/addOrCancelMatch',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiRes<int>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiRes<int>> addOrCancelTournament(
    cuid,
    tid,
    cf,
  ) async {
    const _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'cuid': cuid,
      'tid': tid,
      'cf': cf,
    };
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ApiRes<int>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu13/v1/userCollection/addOrCancelTournament',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiRes<int>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiRes<int>> addOrCancelTournamentGuanjun(
    cuid,
    mid,
    cf,
  ) async {
    const _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'cuid': cuid,
      'mid': mid,
      'cf': cf,
    };
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ApiRes<int>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu13/v1/userCollection/addOrCancelTournament',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiRes<int>.fromJson(_result.data!);
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
