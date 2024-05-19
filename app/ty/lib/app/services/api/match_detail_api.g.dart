// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_detail_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _MatchDetailApi implements MatchDetailApi {
  _MatchDetailApi(
    this._dio, {
    this.baseUrl,
  });

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ApiRes<Map<String, dynamic>>> getMatchDetail(
    mid,
    cuid,
    init,
  ) async {
    const _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{
      r'mid': mid,
      r'cuid': cuid,
      r'init': init,
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
              '/yewu11/v1/m/matchDetail/getMatchDetailPB',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiRes<Map<String, dynamic>>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiRes<Map<String, dynamic>>> getESMatchDetail(
    mid,
    cuid,
    init,
  ) async {
    const _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{
      r'mid': mid,
      r'cuid': cuid,
      r'init': init,
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
              '/yewu11/v1/m/matchDetail/getESMatchDetail',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiRes<Map<String, dynamic>>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiRes<List<CategoryListData>>> getCategoryList(
    sportId,
    mid,
  ) async {
    const _extra = <String, dynamic>{
      'retry_retryable': true,
      'throttle_able': true,
      'throttle_durtion': 1500,
    };
    final queryParameters = <String, dynamic>{
      r'sportId': sportId,
      r'mid': mid,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiRes<List<CategoryListData>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu11/v1/m/category/getCategoryList',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiRes<List<CategoryListData>>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiRes<List<MatchEntity>>> getMatchDetailByTournamentId(
    tId,
    type,
    dateTime,
    isESport,
  ) async {
    const _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{
      r'tId': tId,
      r'type': type,
      r'dateTime': dateTime,
      r'isESport': isESport,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiRes<List<MatchEntity>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu11/v1/m/matchDetail/getMatchDetailByTournamentIdPB',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiRes<List<MatchEntity>>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiRes<List<dynamic>>> getMatchOddsInfo1(
    mcid,
    mid,
    cuid,
    showType,
  ) async {
    const _extra = <String, dynamic>{
      'retry_retryable': true,
      'throttle_able': true,
      'throttle_durtion': 1500,
    };
    final queryParameters = <String, dynamic>{
      r'mcid': mcid,
      r'mid': mid,
      r'cuid': cuid,
      r'showType': showType,
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
              '/yewu11/v1/m/matchDetail/getMatchOddsInfo1PB',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiRes<List<dynamic>>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiRes<List<dynamic>>> getESMatchOddsInfo(
    mcid,
    mid,
    cuid,
    showType,
  ) async {
    const _extra = <String, dynamic>{
      'retry_retryable': true,
      'throttle_able': true,
      'throttle_durtion': 1500,
    };
    final queryParameters = <String, dynamic>{
      r'mcid': mcid,
      r'mid': mid,
      r'cuid': cuid,
      r'showType': showType,
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
              '/yewu11/v1/m/matchDetail/getESMatchOddsInfoPB',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiRes<List<dynamic>>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiRes<List<dynamic>>> getVirtualMatchOddsInfo(
    mcid,
    mid,
    cuid,
    showType,
  ) async {
    const _extra = <String, dynamic>{
      'retry_retryable': true,
      'throttle_able': true,
      'throttle_durtion': 1500,
    };
    final queryParameters = <String, dynamic>{
      r'mcid': mcid,
      r'mid': mid,
      r'cuid': cuid,
      r'showType': showType,
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
              '/yewu11/v1/m/matchDetail/getVirtualMatchOddsInfo',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiRes<List<dynamic>>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiRes<List<dynamic>>> getVirtualMatchResult(
    mcid,
    mid,
  ) async {
    const _extra = <String, dynamic>{
      'retry_retryable': true,
      'throttle_able': true,
      'throttle_durtion': 1500,
    };
    final queryParameters = <String, dynamic>{
      r'mcid': mcid,
      r'mid': mid,
    };
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
              '/yewu11/v1/m/matchDetail/getVirtualMatchResult',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiRes<List<dynamic>>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiRes<DetailVideoEntity>> getDetailVideo(
    sm,
    euid,
    csid,
    tid,
    sort,
    keyword,
    cuid,
    mid,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'sm': sm,
      r'euid': euid,
      r'csid': csid,
      r'tid': tid,
      r'sort': sort,
      r'keyword': keyword,
      r'cuid': cuid,
      r'mid': mid,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiRes<DetailVideoEntity>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu11/v1/w/getDetailVideo',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiRes<DetailVideoEntity>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<LiveVideoUrlEntity> liveVideoUrl(
    device,
    mid,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'device': device,
      'mid': mid,
    };
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<LiveVideoUrlEntity>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu11/v1/w/liveVideoUrl',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = LiveVideoUrlEntity.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiRes<VideoAnimationUrlEntity>> getVideoAnimationUrl(
    type,
    mid,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'type': type,
      'mid': mid,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiRes<VideoAnimationUrlEntity>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu11/v1/w/videoAnimationUrl',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiRes<VideoAnimationUrlEntity>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<void> playTop(
    status,
    playId,
    matchId,
    cuid,
    topKey,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'status': status,
      r'playId': playId,
      r'matchId': matchId,
      r'cuid': cuid,
      r'topKey': topKey,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    await _dio.fetch<void>(_setStreamType<void>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v1/m/category/playTop',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
  }

  @override
  Future<ApiRes<MatchDetailsNewsEntity>> getMatchDetailNews(
    mid,
    type,
    t,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'matchId': mid,
      r'type': type,
      r't': t,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiRes<MatchDetailsNewsEntity>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v1/art/getArticle',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiRes<MatchDetailsNewsEntity>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiRes<MatchDetailEntity>> getMatchDetailBatter(
    mid,
    t,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'mid': mid,
      r't': t,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiRes<MatchDetailEntity>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v1/m/matchDetail/getEventResult',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiRes<MatchDetailEntity>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiRes<MatchDetailsLeaguePointsEntity>> getMatchDetailVSInfo(
    mid,
    flag,
    t,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'mid': mid,
      r'flag': flag,
      r't': t,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiRes<MatchDetailsLeaguePointsEntity>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'v2/statistics/vsInfo',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        ApiRes<MatchDetailsLeaguePointsEntity>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiRes<MatchDetailsHistoryEntity>> getMatchDetailTeamVSHistory(
    mid,
    flag,
    cps,
    t,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'mid': mid,
      r'flag': flag,
      r'cps': cps,
      r't': t,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiRes<MatchDetailsHistoryEntity>>(Options(
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
    final value = ApiRes<MatchDetailsHistoryEntity>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiRes<MatchDetailsRecentEntity>> getMatchDetailTeamVsOtherTeam(
    mid,
    flag,
    cps,
    t,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'mid': mid,
      r'flag': flag,
      r'cps': cps,
      r't': t,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiRes<MatchDetailsRecentEntity>>(Options(
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
    final value = ApiRes<MatchDetailsRecentEntity>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiRes<MatchDiskSurfaceEntity>> getMatchDetailAnalysiseData(
    mid,
    flag,
    cps,
    t,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'mid': mid,
      r'flag': flag,
      r'cps': cps,
      r't': t,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiRes<MatchDiskSurfaceEntity>>(Options(
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
    final value = ApiRes<MatchDiskSurfaceEntity>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiRes<MatchTechnologyEntity>> getMatchDetailtechnology(
    mid,
    flag,
    cps,
    t,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'mid': mid,
      r'flag': flag,
      r'cps': cps,
      r't': t,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiRes<MatchTechnologyEntity>>(Options(
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
    final value = ApiRes<MatchTechnologyEntity>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiRes<MatchLineupEntity>> getMatchDetaiLineup(
    mid,
    flag,
    cps,
    t,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'mid': mid,
      r'flag': flag,
      r'cps': cps,
      r't': t,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiRes<MatchLineupEntity>>(Options(
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
    final value = ApiRes<MatchLineupEntity>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiRes<MatchIntelligenceEntity>> getMatchDetaiintelligence(
    mid,
    flag,
    cps,
    t,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'mid': mid,
      r'flag': flag,
      r'cps': cps,
      r't': t,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiRes<MatchIntelligenceEntity>>(Options(
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
    final value = ApiRes<MatchIntelligenceEntity>.fromJson(_result.data!);
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
