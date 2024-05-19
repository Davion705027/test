import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/db/app_cache.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewCacheController extends GetxController {
  static WebviewCacheController get to => Get.put(WebviewCacheController(),permanent: true);
  Map cache = {};

  getKey(key){
    return '$key-${getLang()}-${getTheme()}';
  }
  void setCache(String key,Widget value){
    cache[getKey(key)] = value;
  }
  Widget? getCache(String key){
    return cache[getKey(key)];
  }

  getRule(){
    return getCache('rule') ?? initRule();
  }
  getLang(){
    return Get.locale!.toLanguageTag();
  }
  getTheme(){
    return Get.isDarkMode ? 'theme02' : 'theme01';
  }

  // 规则说明
  initRule(){
    if(Platform.isWindows)return;
    String apiUrl = MapKV.topic.get()?['sports_rules'] ?? 'https://topic.sportxxx1zx.com/sports-rules/23-app/common/';
    String token = StringKV.token.get() ?? '';
    String theme = getTheme();
    String tag = Get.locale!.toLanguageTag();
    String lang = tag.replaceAll("-", "_");
    String url = 'en_GB';
    if(lang=='pt_PT'){
      url  = '$apiUrl#/en_GB?token=$token&themeColors=$theme&sty=y0';
    }else {
      url = '$apiUrl#/$lang?token=$token&themeColors=$theme&sty=y0';
    }



    WebViewController webControler = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          // onProgress: (int progressa) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse(url));

    WebViewWidget webviewWidget = WebViewWidget(
      controller: webControler,
    );
    setCache('rule', webviewWidget);

    return webviewWidget;
  }
}