import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

class LoginUtils {
  static List decodeString(String encodedString) {
    String decodedString = utf8.decode(base64.decode(encodedString));
    List decodedList = Uri.decodeComponent(decodedString).split('|');
    return decodedList;
  }

  /// 测速方法
  /// 测试url: const res = await race(apiList,'/game/version') ==> url
  /// 测试cdn: const res = await race(cdnList,'/newh5/static/images/test.png') ==> url
  static Future<String> race(dynamic apiUrls, String address) async {
    if (apiUrls.length == 1) {
      return apiUrls[0];
    }

    final completer = Completer<String>();
    for (final url in apiUrls) {
      Dio dio = Dio();
      if (kDebugMode) {
        (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
            HttpClient()
              ..badCertificateCallback =
                  (X509Certificate cert, String host, int port) => true;
      }
      dio.get(url + address).then((value) => {
            if (!completer.isCompleted) {completer.complete(url)}
          });
    }

    return completer.future;
  }
}
