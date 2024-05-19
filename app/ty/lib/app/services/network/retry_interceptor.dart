import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_ty_app/app/services/network/domain.dart';

import '../../db/app_cache.dart';

/// 接口失败重试拦截器
/// 重试次数默认为3次
/// 重试间隔默认为1秒
///

class RetryInterceptor extends Interceptor {
  final Dio dio;

  /// 重试次数
  final int retryCount;

  /// 重试间隔
  final int retryTimer;

  RetryInterceptor(this.dio, {this.retryCount = 6, this.retryTimer = 1000});

  /// 根据返回的错误码的重试
  @override
  Future<void> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    /// 不支持重试
    if (!response.requestOptions._retryable) {
      return handler.next(response);
    }

    /// 解析返回数据
    if (response.data is String) {
      response.data = json.decode(response.data);
    }
    String? code = response.data['code'];

    var attempt = response.requestOptions._attempt;
    final shouldRetry =
        attempt < retryCount && response.requestOptions._codes.contains(code);
    if (!shouldRetry) {
      return handler.next(response);
    }
    if(attempt == retryCount - 1){
       // 切换域名
      var newUrl = domainInstance.changeDomain();
      if(newUrl != null){
        response.requestOptions._attempt = 0;
        response.requestOptions.baseUrl = StringKV.best_api.get()!;
      }
    }
    response.requestOptions._attempt = attempt + 1;

    await Future.delayed(Duration(milliseconds: retryTimer));
    try {
      final res = await dio.fetch(response.requestOptions);
      handler.resolve(res);
    } catch (e) {}
  }

  /// 网络错误的重试
  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    /// 不支持重试
    if (!err.requestOptions._retryable) {
      return super.onError(err, handler);
    }

    var attempt = err.requestOptions._attempt;
    final shouldRetry = attempt < retryCount;
    if (!shouldRetry) {
      return super.onError(err, handler);
    }
    if(attempt == retryCount - 1){
       // 切换域名
      var newUrl = domainInstance.changeDomain();
      if(newUrl != null){
        err.requestOptions.baseUrl = StringKV.best_api.get()!;
        err.requestOptions._attempt = 0;
      }
    }
    err.requestOptions._attempt = attempt + 1;

    await Future.delayed(Duration(milliseconds: retryTimer));
    try {
      final res = await dio.fetch(err.requestOptions);
      handler.resolve(res);
    } on DioException catch (e) {
      super.onError(e, handler);
    } catch (e) {}
  }
}

/// 重试标记
const kRetryable = 'retry_retryable';
const KRetryCode = 'retry_code';

///节流限频标志
const kThrottleAbleKey = 'throttle_able';

///节流时间间隔 毫秒级别

const kThrottleDurtionKey = 'throttle_durtion';

///节流接口的激活时间
const kThrottleNextAvailable = 'throttle_next_available';

extension RequestOptionX on RequestOptions {
  /// 重试次数
  static const _kAttemptKey = 'retry_attempt';

  int get _attempt => this.extra[_kAttemptKey] ?? 0;

  set _attempt(int value) => this.extra[_kAttemptKey] = value;

  /// 是否支持重试
  bool get _retryable => this.extra[kRetryable] ?? false;

  /// 重试错误码 ['0400500', '0401038'] 默认为500和1038
  List<String> get _codes => this.extra[KRetryCode].toString().split(',')
    ..addAll(['0400500', '0401038']);

  /// 是否支持接口节流
  bool get throttleable => this.extra[kThrottleAbleKey] ?? false;

  /// 节流间隔时间
  int get throttledurtion => this.extra[kThrottleDurtionKey] ?? 1000;

  /// 节流记录间隔时间
  DateTime get nextAvailable =>
      this.extra[kThrottleNextAvailable] ?? DateTime.now();
}
