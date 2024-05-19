import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_ty_app/app/db/app_cache.dart';
import 'package:flutter_ty_app/app/routes/app_pages.dart';
import 'package:flutter_ty_app/app/utils/bus/bus.dart';
import 'package:flutter_ty_app/app/utils/bus/event_enum.dart';
import 'package:flutter_ty_app/app/utils/toast_util.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;

import '../../utils/logger.dart';
import '../../utils/pb.dart';

/// @Author swifter
/// @Date 2023/9/17 15:19

class ResponseInterceptor extends Interceptor {
  //所有接口上报的 用户信息失效，这里不包含 OSS域名检测的 
  //接口会去 清除 这个 统计 ， 连续累计 一定 次数才会弹出 token 失效
  int _allExpiredCount = 0;
  // token 过期 累加达到 上限， 延迟 xx秒 执行的  弹出 用户token 失效对应的弹窗  等 流程的  定时器
  //相邻接口报用户token 失效累计次数上限
  int _allExpiredCountMax = 6;


  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    try {
      
      String? code = response.data['code'];
      dynamic status = response.data['status'];
      String url = response.realUri.toString();
      // 解析PB数据
      if(PB.isPb(url)){
        response.data['data'] = pakoPb.unzipData(response.data['data']);
      }else if (response.data is String) {
        response.data = json.decode(response.data);
      }

      ///==============登录失效 先注释掉
      /// 无效token回到登录页
      if (code == '0401013' && Get.currentRoute != Routes.login) {
        _allExpiredCount += 1;

        if(_allExpiredCount >= _allExpiredCountMax){
          tokenExpiredAction();
          Bus.getInstance().emit(EventType.appSignOut);  
        }
      }

      // 接口成功 清除相关状态
      if(code == '0000000'){
        _allExpiredCount = 0;
        Logger.getInstance().httpReceiveLog(response);
      }
      

      /// 无效token回到登录页
      handler.next(response);
    } catch (e) {
      Get.log("请求失败 ${e.toString()}");
    }
  }


  // token 过期跳转 公共方法 在domain中也需要使用
  static tokenExpiredAction() {
    Get.offNamed(Routes.login);
    ToastUtils.showGrayBackground(LocaleKeys.app_loginInvalid.tr);
    // sp.clear();
    ///清空所有存储字段
    dbClear();
  }


}
