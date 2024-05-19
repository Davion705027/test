import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_ty_app/app/services/network/domain.dart';
import 'package:flutter_ty_app/app/services/network/response_interceptor.dart';
import 'package:flutter_ty_app/app/services/network/retry_interceptor.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../db/app_cache.dart';
import 'request_interceptor.dart';

/// @Author swifter
/// @Date 2023/9/17 15:17

class AppDio {
  static AppDio? instance;

  Map looptimers = {};

  late final Dio _dio;

  Dio get dio => _dio;

  static AppDio getInstance() {
    instance ??= AppDio._internal();
    // if (kDebugMode) {
    //   //允许自签名证书
    //   (instance!.dio.httpClientAdapter as IOHttpClientAdapter)
    //       .createHttpClient = () => HttpClient()
    //     ..badCertificateCallback =
    //         (X509Certificate cert, String host, int port) => true;
    // }
    return instance!;
  }

  AppDio._internal() {
    _dio = Dio();

    /// 配置dio实例
    BaseOptions options = BaseOptions(
        baseUrl: StringKV.baseUrl.get() ?? '',
        connectTimeout: const Duration(milliseconds: 3000),
        receiveTimeout: const Duration(milliseconds: 9000),
    );
    _dio.options = options;

    _dio.httpClientAdapter = IOHttpClientAdapter(
      //自己设置缺省超时时间
      createHttpClient: (){
        HttpClient httpClient = HttpClient();
        httpClient.idleTimeout = const Duration(seconds: 60); // 设置 keep-alive 的空闲超时时间为 60 秒
        return httpClient;
      },
    );

    /// 添加拦截器
    _dio.interceptors.add(RequestInterceptor());
    _dio.interceptors.add(RetryInterceptor(_dio));
    _dio.interceptors.add(ResponseInterceptor());
    //测试代码
    bool env = const bool.fromEnvironment("LOG_OPEN", defaultValue: true);
    if(env){
      _dio.interceptors.add(
        LogInterceptor(
          responseBody: true,
          requestBody: true,
          requestHeader: true,
          responseHeader: true,
          request: true,
          
        ),
      );
    }
  }

  // 设置网络相关数据
  setApiDomain() {
    var api_domain = DOMAIN_RESULT.first_one;

    if (api_domain.isEmpty) {
      String? best_api = StringKV.best_api.get();
      String? gr = StringKV.gr.get();
      var domain_api = domainInstance.get_save_domain_api();
      if (gr == null) {
        gr = DOMAIN_RESULT.gr.isNotEmpty ? DOMAIN_RESULT.gr : "COMMON";
        StringKV.gr.save(gr);
      }
      if (best_api != null) {
        // 缓存   有  最快域名
        DOMAIN_RESULT.first_one = best_api;
        api_domain = best_api;
      } else {
        // 缓存   无  最快域名
        // 从本地 存储内找一条数据先用 ， 后面即便 是分组不对 ，会走到纠错流程
        var find_obj;
        if (domain_api.isNotEmpty) {
          find_obj = domain_api.where((x) => x.group == gr);
        }
        if (find_obj != null) {
          //如果找到 数据
          api_domain = find_obj["api"];
          DOMAIN_RESULT.first_one = api_domain;
        } else {
          // 什么都没有的 补偿刷新一次  或者两次
          // if (has_reload < 4) {
          //   SessionStorage .set("set_root_domain_error_force_reload", has_reload + 1);
          //   force_current_api_flow_use_oss_file_api_reload();
          // } else {
          //   // 正常的走到 释放页面 的步骤 ，就是 wifi 图标 必须刷新页面才行的 那种
          // }
        }
      }
    }

    // 设置api 和 ws
    // https://api.jlsdfj012.com/yewu11

    // 全局设置
    // https://api.jlsdfj012.com 现在全局设置的不带yewu后缀 自行在接口前面加上
    _dio.options.baseUrl = api_domain;
    StringKV.baseUrl.save(api_domain);

    // final wsUrl = DOMAIN_RESULT.first_one.replaceFirst('http', 'ws');
    // StringKV.wssUrl.save(wsUrl);
  }
}
