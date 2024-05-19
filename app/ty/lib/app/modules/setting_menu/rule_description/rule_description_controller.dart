import 'dart:ui';

import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../db/app_cache.dart';
import 'rule_description_logic.dart';

class RuleDescriptionController extends GetxController {
  static RuleDescriptionController get to => Get.put(RuleDescriptionController());
  final RuleDescriptionlogic logic = RuleDescriptionlogic();
  late final WebViewController webViewController;
  bool isInit = false;

  late Widget webviewWidget;

  int progress = 0;
  @override
  void onInit() {
    // TODO: implement onInit
    // initData();
    super.onInit();
  }

  void initData() {

    if(isInit) return;
    isInit = true;
    
    String apiUrl = MapKV.topic.get()?['sports_rules'] ?? 'https://topic.sportxxx1zx.com/sports-rules/23-app/common/';
    String token = StringKV.token.get() ?? '';
    String theme = Get.isDarkMode ? 'theme02' : 'theme01';
    String tag = Get.locale!.toLanguageTag();
    String lang = tag.replaceAll("-", "_");

    String url = 'en_GB';
    if(lang=='pt_PT'){
      url  = '$apiUrl#/en_GB?token=$token&themeColors=$theme&sty=y0';
    }else {
      url = '$apiUrl#/$lang?token=$token&themeColors=$theme&sty=y0';
    }
    initWeb(url);
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

  initWeb(String url) {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progressa) {
            progress = progressa;
            // update();
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse(url));

    webviewWidget = WebViewWidget(
      controller: webViewController,
    );
  }
}
