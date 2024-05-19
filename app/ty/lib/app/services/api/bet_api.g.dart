// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bet_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _BetApi implements BetApi {
  _BetApi(
    this._dio, {
    this.baseUrl,
  });

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ApiRes<BetAmountEntity>> queryBetAmount(betAmountReq) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(betAmountReq.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiRes<BetAmountEntity>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu13/v1/betOrder/queryBetAmount',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiRes<BetAmountEntity>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiRes<List<BetAmountBetAmountInfo>>> queryMarketMaxMinBetMoney(
      betAmountReq) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(betAmountReq.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiRes<List<BetAmountBetAmountInfo>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu13/v1/betOrder/queryMarketMaxMinBetMoney',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiRes<List<BetAmountBetAmountInfo>>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiRes<List<LastMarketEntity>>> queryLatestMarketInfo(
      latestMarketReq) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(latestMarketReq.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiRes<List<LastMarketEntity>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu13/v1/betOrder/queryLatestMarketInfo',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiRes<List<LastMarketEntity>>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiRes<BetAmountEntity>> queryPreBetAmount(betAmountReq) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(betAmountReq.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiRes<BetAmountEntity>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu13/v1/betOrder/queryPreBetAmount',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiRes<BetAmountEntity>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiRes<BetResultEntity>> bet(betReq) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(betReq.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiRes<BetResultEntity>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu13/v1/betOrder/bet',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiRes<BetResultEntity>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetH5OrderListEntity> getH5OrderList(
    orderStatus,
    searchAfter,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'orderStatus': orderStatus,
      'searchAfter': searchAfter,
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetH5OrderListEntity>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu12/order/betRecord/getH5OrderListPB',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetH5OrderListEntity.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetH5PreBetOrderlistEntity> getH5PreBetOrderlist(
    preOrderStatusList,
    searchAfter,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'preOrderStatusList': preOrderStatusList,
      'searchAfter': searchAfter,
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetH5PreBetOrderlistEntity>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu13/order/betRecord/getH5PreBetOrderlist',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetH5PreBetOrderlistEntity.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetH5OrderListEntity> getH5OrderListSettled(
    orderStatus,
    searchAfter,
    orderBy,
    timeType,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'orderStatus': orderStatus,
      'searchAfter': searchAfter,
      'orderBy': orderBy,
      'timeType': timeType,
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetH5OrderListEntity>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu12/order/betRecord/getH5OrderListPB',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetH5OrderListEntity.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UpdatePreBetOddsEntity> updatePreBetOdds(
    marketType,
    odds,
    orderNo,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'marketType': marketType,
      'odds': odds,
      'orderNo': orderNo,
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UpdatePreBetOddsEntity>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu13/order/betRecord/updatePreBetOdds',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UpdatePreBetOddsEntity.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CancelPreBetOrderEntity> cancelPreBetOrder(orderNo) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'orderNo': orderNo};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CancelPreBetOrderEntity>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu13/v1/betOrder/cancelPreBetOrder',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CancelPreBetOrderEntity.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetCashoutMaxAmountListEntity> getCashoutMaxAmountList(orderNo) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'orderNo': orderNo};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetCashoutMaxAmountListEntity>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu13/order/betRecord/getCashoutMaxAmountList',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetCashoutMaxAmountListEntity.fromJson(_result.data!);
    return value;
  }

  @override
  Future<OrderPreSettleEntity> orderPreSettle(
    deviceType,
    frontSettleAmount,
    orderNo,
    settleAmount,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'deviceType': deviceType,
      'frontSettleAmount': frontSettleAmount,
      'orderNo': orderNo,
      'settleAmount': settleAmount,
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<OrderPreSettleEntity>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu13/v1/betOrder/orderPreSettle',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = OrderPreSettleEntity.fromJson(_result.data!);
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
