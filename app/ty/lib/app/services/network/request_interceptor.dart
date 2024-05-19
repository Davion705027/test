import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_ty_app/app/global/user_controller.dart';
import 'package:flutter_ty_app/app/services/network/retry_interceptor.dart';
import 'package:flutter_ty_app/main.dart';
import 'package:get/get.dart';
import 'package:mutex/mutex.dart';

import '../../db/app_cache.dart';
import '../../utils/logger.dart';

/// @Author swifter
/// @Date 2023/9/17 15:18

class RequestInterceptor extends Interceptor {
  bool Function(RequestOptions req)? shouldThrottle;

  ///发送回调
  void Function(RequestOptions req, DateTime until)? onThrottled;
  final Mutex _mutex = Mutex();
  DateTime _nextAvailable = DateTime.now();

  RequestInterceptor({this.shouldThrottle, this.onThrottled});

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String apiPath = options.path;
    Map<String, dynamic> headers = options.headers;

    String? token = StringKV.token.get();
    if(token == null){
      Uri uri = Uri.parse(h5ulr);
      Map<String, dynamic> params = uri.queryParameters;
      if(params.keys.contains('token')){
        token = params['token'].toString();
      }else{
        Get.log('获取不到token');
      }
    }
    int time = DateTime.now().millisecondsSinceEpoch;
    //StringKV.req_checkId.save(time.toString()); 耗时操作
    headers['lang'] = _getLang();
    headers['checkId'] = 'pc-$token-${UserController.to.getUid()}-$time';
    headers['request-code'] = '{"panda-bss-source":"1"}';
    headers['requestId'] = token;
    headers['Content-Type'] = 'application/json;charset=UTF-8';
    headers.removeWhere((key, value) => value == null);
    options.headers = headers;
    Logger.getInstance().httpSendLog(options);
    // 所有请求路径加上 ?t=时间戳
    if (!options.path.contains('?t=')) {
      options.path = '${options.path}?t=$time';
    }

    if (shouldThrottle?.call(options) == false ||
        options.throttleable == false) {
      //Get.log('没有延迟请求---->$apiPath}');

      //     !ThrottleUtil.throttleMilliseconds.keys.contains(apiPath)) {
      return super.onRequest(options, handler);
    }

    Duration interval = Duration(milliseconds: options.throttledurtion);

    // if (ThrottleUtil.throttleApiList.contains(apiPath) &&
    //     ThrottleUtil.throttleMilliseconds.keys.contains(apiPath)) {
    //   int throttleTime =
    //       ThrottleUtil.throttleMilliseconds[apiPath]['milliseconds'];
    //   interval = Duration(milliseconds: throttleTime);
    // }
    //
    // if (!ThrottleUtil.throttleMilliseconds.keys.contains(apiPath) ||
    //     !ThrottleUtil.throttleMilliseconds[apiPath].keys
    //         .contains('nextAvailable')) {
    //   ThrottleUtil.throttleMilliseconds[apiPath] = {};
    //   ThrottleUtil.throttleMilliseconds[apiPath]['nextAvailable'] =
    //       DateTime.now();
    // }
    // Map keyMap = ThrottleUtil.throttleMilliseconds[apiPath];

    var now = DateTime.now();
    _mutex.protect(() async {
      if (now.isBefore(_nextAvailable)) {
        /// 这里的代码会被保护 不会并发执行
        // if (now.isBefore(options.nextAvailable)) {
        // var scheduledTime = options.nextAvailable;
        // options.extra[kThrottleNextAvailable] = options.nextAvailable.add(interval);

        // var scheduledTime = keyMap['nextAvailable'];
        // keyMap['nextAvailable'] = keyMap['nextAvailable'].add(interval);
        // return scheduledTime;
        var scheduledTime = _nextAvailable;
        _nextAvailable = _nextAvailable.add(interval);
        return scheduledTime;
      } else {
        // options.extra[kThrottleNextAvailable] = now.add(interval);

        // options.extra[kThrottleNextAvailable] = now.add(interval);
        _nextAvailable = now.add(interval);
        return null;
      }
    }).then((scheduledTime) {
      if (scheduledTime != null) {
        onThrottled?.call(options, scheduledTime);
        Future.delayed(
          scheduledTime.difference(now),
          () {
            return super.onRequest(options, handler);
          },
        );
      } else {
        super.onRequest(options, handler);
      }
    });
  }

  int _getDevice() {
    return Platform.isIOS
        ? 2
        : Platform.isAndroid
            ? 4
            : 3;
  }

  String _getLang() {
    //默认简体
    String lang = 'zh';
    //繁体
    if (Get.locale?.languageCode == 'zh' && Get.locale?.countryCode == 'TW') {
      lang = 'tw';
      //英文
    } else if (Get.locale?.languageCode == 'en') {
      lang = 'en';
      //越南
    } else if (Get.locale?.languageCode == 'vi') {
      lang = 'vi';
      //韩国
    } else if (Get.locale?.languageCode == 'ko') {
      lang = 'ko';
      //葡萄牙
    } else if (Get.locale?.languageCode == 'pt') {
      lang = 'pt';
    }
    return lang;
  }
}
