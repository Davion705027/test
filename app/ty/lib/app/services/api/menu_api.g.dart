// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _MenuApi implements MenuApi {
  _MenuApi(
    this._dio, {
    this.baseUrl,
  });

  final Dio _dio;

  String? baseUrl;

  @override
  Future<MenuEntity> setUserPersonalise(handicapType) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'handicapType': handicapType};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<MenuEntity>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu12/user/setUserPersonalise',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = MenuEntity.fromJson(_result.data!);
    return value;
  }

  @override
  Future<MenuEntity> rememberSelect(sort) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'sort': sort};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<MenuEntity>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu12/user/rememberSelect',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = MenuEntity.fromJson(_result.data!);
    return value;
  }

  @override
  Future<MenuEntity> setUserPersonaliseT(userVersion) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'userVersion': userVersion};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<MenuEntity>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu12/user/setUserPersonalise',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = MenuEntity.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetUserCustomizeInfoEntity> getUserCustomizeInfo(type) async {
    const _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'type': type};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetUserCustomizeInfoEntity>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu13/order/betRecord/getUserCustomizeInfo',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetUserCustomizeInfoEntity.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SaveUserCustomizeInfoEntity> saveUserCustomizeInfo(
    type,
    seriesList,
    singleList,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'type': type,
      'seriesList': seriesList,
      'singleList': singleList,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SaveUserCustomizeInfoEntity>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu13/order/betRecord/saveUserCustomizeInfo',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SaveUserCustomizeInfoEntity.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SaveUserCustomizeInfoEntity> saveUserCustomizeInfos(
    fastBetAmount,
    firstTime,
    switchOn,
    type,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'fastBetAmount': fastBetAmount,
      'firstTime': firstTime,
      'switchOn': switchOn,
      'type': type,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SaveUserCustomizeInfoEntity>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu13/order/betRecord/saveUserCustomizeInfo',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SaveUserCustomizeInfoEntity.fromJson(_result.data!);
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
