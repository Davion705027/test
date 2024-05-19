

import 'dart:async';
import '../db/app_cache.dart';
import '../services/api/account_api.dart';

class ServerTime {
  // 远程服务器时间
  late int remoteTime;
  // 用户本机时间戳
  late int localTime;
  // 是否需要矫正时间
  bool checkTime = true;
  // 差值
  int diffTime = 100;

  Timer? timer;

  // 构造函数
  ServerTime() {
    // 初始化本地时间
    localTime = DateTime.now().millisecondsSinceEpoch;
    // 初始化远程服务器时间
    remoteTime = DateTime.now().millisecondsSinceEpoch + diffTime;
  }

  // 获取服务器时间
  Future<void> getServerTime() async {
    try {
      // 发起HTTP请求获取服务器时间
      var res = await AccountApi.instance().getServerTime();
      var currentTime = DateTime.now().millisecondsSinceEpoch;
      var serverTime = int.tryParse(res.data);
      localTime = currentTime;
      remoteTime = serverTime ?? currentTime;

      diffTime = remoteTime - currentTime;

      if(checkTime){
        startCheckTimer();
      }
    } catch (error) {
      // 请求失败，记录当前时间
      localTime = DateTime.now().millisecondsSinceEpoch;
      remoteTime = DateTime.now().millisecondsSinceEpoch;
    }
  }

  // 获取当前服务器时间戳 外部使用
  int getRemoteTime() {
    var now = DateTime.now().millisecondsSinceEpoch;
    return now + diffTime;
    // var time = remoteTime + (now - localTime);
    // return time;
  }


  startCheckTimer(){
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      var now  = DateTime.now().millisecondsSinceEpoch;
      localTime += 1000;

     
      if( (now - localTime).abs() > 1000){
        timer?.cancel();
        // print('时间不对 进行调整');
        getServerTime();
      }
    });

  }

}



final serverTime = ServerTime();
