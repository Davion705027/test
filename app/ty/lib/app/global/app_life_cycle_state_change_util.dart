import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_ty_app/app/global/user_controller.dart';
import 'package:flutter_ty_app/app/global/ws/ws_app.dart';
import 'package:flutter_ty_app/app/global/ws/ws_app_send.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_detail_controller.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_controller.dart';
import 'package:flutter_ty_app/app/routes/app_pages.dart';

import '../modules/vr/vr_sport_detail/import_head.dart';
import '../utils/bus/bus.dart';

class AppLifecycleStateChangeUtil {
  static AppLifecycleStateChangeUtil? _instance;

  static AppLifecycleStateChangeUtil instance() {
    _instance ??= AppLifecycleStateChangeUtil._();
    remainTime = remain;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
    return _instance!;
  }

  static final StreamController<int> _streamController = StreamController();


  static bool noNetwork = false;

  ///记录当前的时间
  static int remainTime = 0;
  static int remain = 15 * 60;
  static bool isResumed = false;
  static bool backHome = false;

  AppLifecycleStateChangeUtil._() {}
  Timer? wsTimer;
  Timer? backTimer;

  startTimer() {
    backTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      remainTime -= 1;

      ///如果计完成取消定时
      if (remainTime <= 0) {
        backHome = true;
        remainTime = 0;
        cancelBackTimer();
      }

      ///流数据更新
      _streamController.sink.add(remainTime);
    });
  }

  ///前台
  resumed() {
    ///取消后台计数器
    cancelBackTimer();
    if (backHome == true) {
      ///回到首页
      Get.until((route) => route.settings.name == Routes.mainTab);
    }
    isResumed = true;
    if (AppWebSocket.channel == null) {
      AppWebSocket.connect();
    }

    ///激活接口
    activeApi();
    cancelTime();
    instance().wsTimer =
        Timer.periodic(const Duration(milliseconds: 4000), (timer) {
      ///赛事订阅
      AppWebSocket.instance().skt_send_menu();
      AppWebSocket.instance().skt_send_match_status();
      AppWebSocket.instance()
          .skt_send_order({'cuid': UserController.to.getUid()});
    });
  }

  ///后台
  paused() {
    backHome = false;
    startTimer();
    isResumed = false;

    ///取消接口
    cancelApi();
    cancelTime();
    AppWebSocket.unsubscribe();
    AppWebSocket.closeSocket();
  }

  ///不活跃
  inactive() {}

  ///隐藏
  hidden() {
    cancelTime();
  }

  ///前台激活接口
  void activeApi() {
    if (Get.currentRoute == Routes.mainTab) {
      if(Get.isRegistered<HomeController>()) {
        HomeController.to.fetchData();
      }
    } else if (Get.currentRoute == Routes.matchDetail) {
      // ///详情需要激活接口
      // MatchDetailController detailController =
      //     Get.find<MatchDetailController>();
      // detailController.refreshData();
    }
    if(Get.isRegistered<ShopCartController>()) {
      ShopCartController.to.refreshData();
    }
  }

  ///前台取消接口
  void cancelApi() {
    if (Get.currentRoute == Routes.mainTab) {
    } else if (Get.currentRoute == Routes.matchDetail) {}
  }

  ///定时器取消
  cancelTime() {
    if (wsTimer != null) {
      wsTimer?.cancel();
      wsTimer = null;
    }
  }

  cancelBackTimer() {
    backTimer?.cancel();
    backTimer = null;
  }

  void onNetworkChanged() {
    Connectivity().onConnectivityChanged.listen((connectionState) {
      switch (connectionState) {
        case ConnectivityResult.wifi:
        case ConnectivityResult.mobile:
          if(noNetwork){
            Get.log('恢复网络');
          }
          noNetwork = false;
          break;
        case ConnectivityResult.none:
           if(!noNetwork  && isResumed ){
             Get.snackbar(
               LocaleKeys.app_h5_cathectic_kind_tips.tr,
               LocaleKeys.common_no_network.tr,
               colorText: Colors.white,
               snackPosition: SnackPosition.TOP,
             );
             noNetwork = true;
           }

          break;
        case ConnectivityResult.bluetooth:
          // TODO: Handle this case.
        case ConnectivityResult.ethernet:
          // TODO: Handle this case.
        case ConnectivityResult.vpn:
          // TODO: Handle this case.
        case ConnectivityResult.other:
          // TODO: Handle this case.
      }
    });
  }
}
