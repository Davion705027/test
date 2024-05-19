import 'package:flutter_ty_app/app/global/app_life_cycle_state_change_util.dart';
import 'package:flutter_ty_app/app/global/ws/ws_app_bus.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/utils/utils.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../modules/shop_cart/shop_cart_controller.dart';
import '../../services/network/domain.dart';
import '../../utils/logger.dart';

class AppWebSocket {
  static AppWebSocket? _instance;

  // late MqttServerClient _client;
  static WebSocketChannel? channel;
  static String mqttUrl = '';
  static String wsPrefix = '/yewuws2/push';
  static Timer? reconnectTimer;
  Timer? sockettTimer;
  static bool socketClosed = false;

  static AppWebSocket instance() {
    _instance ??= AppWebSocket._();
    return _instance!;
  }

  AppWebSocket._() {
    AppLifecycleStateChangeUtil.instance().resumed();
    setWebSocketUrl();
  }

  static changWsUrl()async {
    // 确保关闭
    await closeSocket();
    setWebSocketUrl();
    connect();
  }

  ///登录获取websocketurl
  static setWebSocketUrl() {
    var firstApi = DOMAIN_RESULT.first_one;
    if (firstApi.isEmpty) return null;
    var wsUrl = firstApi.replaceFirst('http', 'ws') + wsPrefix;
    StringKV.wssUrl.save(wsUrl);
    return wsUrl;
  }

  static getWebSocketUrl() {
    String? wsCache = StringKV.wssUrl.get();
    if (hasValue(wsCache) && wsCache!.isNotEmpty) {
      return wsCache;
    }
    return setWebSocketUrl();
  }

  ///  登录成功 或者 splash_controller 有token时连接
  static connect() async {
    socketClosed = false;
    await initWebSocket();

    if (instance().sockettTimer != null) {
      instance().sockettTimer!.cancel();
      instance().sockettTimer = null;
    }
    
    instance().sockettTimer =
        Timer.periodic(const Duration(milliseconds: 15000), (timer) {
      // Get.log('心跳包------------');
      instance().sendMsg({"cmd": "C0"});
    });

    if (channel?.stream.isBroadcast == false) {
      listen();
    }

    //购物车订阅
    ShopCartController.to.subscribeMarket();
  }

  /// 初始化连接
  static initWebSocket() async {
    try {
      channel = WebSocketChannel.connect(
        Uri.parse(getWebSocketUrl()),
      );

      await channel?.ready;
    } catch (e) {
      // Get.log(e.toString());
      //失败重连，等15秒
      await Future.delayed(const Duration(seconds: 15));
      await initWebSocket();
    }
  }

  /// 数据变化
  static listen() {
    channel?.stream.listen(
      (message) {
        try {
          Map<String, dynamic> data = jsonDecode(message);
          String cmd = data["cmd"];
          if (cmd.isNotEmpty) {
            Logger.getInstance().wsReceiveLog(data);
            ///初始化数据仓库
            ///拿到cmd 先全局推送
            AppWebSocketBus.instance().pubicWsPush(cmd, data);
          }
        } catch (ex) {}
      },
      onError: (err) {
        reconnect();

      },
      onDone: () {
        reconnect();
      },
      cancelOnError: false,

      /// 如果出错，是否取消订阅
    );
  }



  /// 断线重连
  static reconnect() async {
    if(!socketClosed) {
      if (AppLifecycleStateChangeUtil.isResumed) {
       await unsubscribe();
        connect();
      }
    }
  }

  /// @Description:发送ws消息到ws服务器
  /// @param: data 消息体
  /// @param: type 消息标记-自定义模拟推送内部命令该值为custom
  /// @return:
  void sendMsg(dynamic data, {String? type}) {
    if (data != null) {
      if (type != null) {
        data['type'] = type;
      }
      Logger.getInstance().wsSendLog(data);
      channel?.sink.add(jsonEncode(data));
    }
  }

  /// 关闭连接
  static closeSocket() async{
    if (channel != null) {
      await channel!.sink.close();
      channel = null;
    }
    socketClosed = true;
    instance().sockettTimer?.cancel();
  }

  /// 取消所有订阅
  static unsubscribe() async {
    if (channel != null) {
      channel!.sink.close();
    }
  }

  /// 订阅
  static subscribe(String topic) {
    if (channel != null) {
      channel!.sink.add(topic);
    }
  }
}
