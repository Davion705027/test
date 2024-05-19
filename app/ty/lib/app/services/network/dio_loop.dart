import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_ty_app/app/services/network/app_dio.dart';

// typedef FunThen = void Function(dynamic);
// typedef FunCatch = void Function(dynamic);
// typedef FunFinally = void Function();

///例子测试
// Future<void> fetchTest() async {
//   Map<String, dynamic> data = {
//     // parameters
//     'mids':
//     '3286402,3286615,3286620,3286629,3286631,3286636,3286642,3286643,3286645,3286646',
//     'cuid': '511778663232900410',
//     'sort': 1,
//     'device': 'v2_h5_st'
//   };
//   int maxLoop = 3;
//   int timers = 1000;
//   var result = await AppDio.getInstance().dioApiLoop(
//       '/yewu11/v1/m/getMatchBaseInfoByMids',
//       data: data,
//       maxLoop: maxLoop,
//       timers: timers,
//       errorCodes: [200,0400500]
//   );
//   if(result != null){
//     print(result.toString());
//   }
// }
enum DioMethod {
  get,
  post,
  put,
  delete,
  patch,
  head,
}

extension DioApiLoop on AppDio {
  static final Map<String, dynamic> keyMap = {};

  Future<T?> dioApiLoop<T>(
    ///接口名
    String apiPath, {
    DioMethod method = DioMethod.post,
    Map<String, dynamic>? params,
    data,
    CancelToken? cancelToken,
    Options? options,
    // FunFinally? funFinally,
    ///循环请求最大次数
    int maxLoop = 3,

    ///请求间隔时间
    int timers = 1000,

    ///需要监听的错误码数组
    List? errorCodes,

    ///循环请求标记数 不传就是从0开始计时
    int loopCount = 0,

    ///可以自己传 不传就是根据时间撮
    String? dioKey,
  }) async {
    loopCount++;
    final options = {
      'apiPath': apiPath,
      'params': params,
      // 'fun_finally': funFinally,
      'max_loop': maxLoop,
      'timers': timers,
      'error_codes': errorCodes,
      'loop_count': loopCount,
      'dioKey': dioKey,
    };
    options['loop_count'] = loopCount;
    String key = options['dioKey'].toString();
    if (dioKey != null && !keyMap.containsKey(key)) {
      return null;
    }
    if (dioKey == null) {
      dioKey =
          options['dioKey'] = DateTime.now().millisecondsSinceEpoch.toString();
      String key = options['dioKey'].toString();
      keyMap[key] = options['dioKey'];
    }
    if (looptimers.keys.contains(options['dioKey'])) {
      Timer? timer = looptimers[options['dioKey']];
      timer?.cancel();
    }

    const methodValues = {
      DioMethod.get: 'get',
      DioMethod.post: 'post',
      DioMethod.put: 'put',
      DioMethod.delete: 'delete',
      DioMethod.patch: 'patch',
      DioMethod.head: 'head'
    };
    try {
      Options opt = Options(extra: options, method: methodValues[method]);
      Response res;
      res = await dio.request(
        apiPath,
        data: data,
        queryParameters: params,
        cancelToken: cancelToken,
        options: opt,
      );
      final code =
          res.statusCode ?? res.data['code'] ?? res.data['data']['code'];
      List errorCodeList = errorCodes ?? [];
      if (errorCodeList.contains(code)) {
        if (loopCount >= maxLoop) {
          keyMap.remove(options['dioKey']);
          // funFinally?.call();
        } else {
          Timer newTimer = Timer(Duration(milliseconds: timers), () async {
            Options opt = Options(extra: options, method: methodValues[method]);
            res = await dioApiLoop(apiPath,
                data: data,
                params: params,
                maxLoop: maxLoop,
                timers: timers,
                errorCodes: errorCodes,
                cancelToken: cancelToken,
                loopCount: loopCount,
                dioKey: dioKey,
                options: opt);
            return res.data;
          });
          looptimers[options['dioKey']] = newTimer;
          return null;
        }
      } else {
        if (keyMap.containsKey(options['dioKey'])) {
          keyMap.remove(options['dioKey']);
          // funFinally?.call();
        }
      }

      return res.data;
    } on DioError catch (e) {
      if (looptimers.keys.contains(options['dioKey'])) {
        Timer? timer = looptimers[options['dioKey']];
        timer?.cancel();
      }
      if (loopCount >= maxLoop) {
        keyMap.remove(options['dioKey']);
        // funFinally?.call();
      } else {
        Timer newTimer = Timer(Duration(milliseconds: timers), () async {
          Options opt = Options(extra: options, method: methodValues[method]);
          Response res;
          res = await dioApiLoop(apiPath,
              data: data,
              params: params,
              maxLoop: maxLoop,
              timers: timers,
              cancelToken: cancelToken,
              loopCount: loopCount,
              errorCodes: errorCodes,
              dioKey: dioKey,
              options: opt);
          return res.data;
        });
        looptimers[options['dioKey']] = newTimer;
        return null;
      }
      rethrow;
    }
  }
}
