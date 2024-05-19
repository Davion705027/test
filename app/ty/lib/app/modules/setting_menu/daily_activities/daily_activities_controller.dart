import 'dart:ui';

import 'package:flutter_ty_app/app/utils/utils.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../db/app_cache.dart';
import 'daily_activities_logic.dart';

class DailyActivitiesController extends GetxController {
  final DailyActivitieslogic logic = DailyActivitieslogic();
  late final WebViewController webViewController;


  int progress = 0;
  @override
  void onInit() {
    // TODO: implement onInit
    initData();
    super.onInit();
  }

  void initData() {

    String token = StringKV.token.get() ?? '';
    String gr = StringKV.gr.get() ?? 'common';
    String api = StringKV.best_api.get() ?? '';
    // 加密api
    api = apiEncrypt(api);
    // var s = MapKV.topic.get();
    String topic = MapKV.topic.get()?['domain'] ?? '';
      
    String theme = Get.isDarkMode ? 'theme02' : 'theme01';
    // 强制设置蓝色
    theme+= '_y0';

    String tag = Get.locale!.toLanguageTag();
    String lang = tag.split('-')[0];

    
    // 活动域名
    String domain = MapKV.topic.get()?['activity'] ?? 'https://topic.sportxxx1zx.com/activity/common/common/';

    String u = '$domain?token=$token&gr=$gr&theme=$theme&lang=$lang&api=$api&project=app-h5&topic=$topic';

    // String url = '$apiUrl#/$lang?token=$token&themeColors=$theme&sty=y0';
    
    // String url = 'https://topic.o05j3f.com/activity/common/common/?token=9553d1eee7eb2b1821916764ff420d3ca8997897&gr=common&theme=theme01_y0&lang=zh&api=F44HJ+atFdYQqXLm85ADttIpMFzIilQuBIFLyvAEXBo=&project=app-h5&topic=https%3A%2F%2Ftopic.o05j3f.com&pb=1';
    initWeb(u);
  }

  initWeb(String url) {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progressa) {
            progress = progressa;
            update();
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse(url));
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
