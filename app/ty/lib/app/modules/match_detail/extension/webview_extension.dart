import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:get/get.dart';
import '../controllers/match_detail_controller.dart';

import '../models/header_type_enum.dart';

/// 视频、动画与 webview交互逻辑
extension WebviewExtension on MatchDetailController {
  initWebView() {
    TargetPlatform platform = Get.theme.platform;
    if (platform == TargetPlatform.windows) {
      // windows 不进行初始化
      // return;
    }

    // detailState.webViewController = controller
    //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //   ..setBackgroundColor(Colors.black26)
    //   ..setNavigationDelegate(
    //     NavigationDelegate(
    //       onProgress: (int progress) {
    //         // 在 WebView 加载完成后注入 JavaScript 代码移除滚动条
    //         _loadRemoveScrollbarScript();
    //       },
    //       onPageStarted: (String url) {},
    //       onPageFinished: (String url) {},
    //       onWebResourceError: (WebResourceError error) {},
    //     ),
    //   )
    //   ..addJavaScriptChannel("message", onMessageReceived: (message) {
    //     print("addJavaScriptChannel");
    //     print(message);
    //   });
  }

  // 注入 JavaScript 代码移除滚动条
  void _loadRemoveScrollbarScript() async {
    await detailState.webViewController?.evaluateJavascript(source: '''
      window.addEventListener('load', () => {
        document.documentElement.style.overflow = 'hidden';
        document.body.style.overflow = 'hidden';
      });
    ''');
  }

  ///@description: 给iframe发送全局视频类型变化事件
  ///@param {int} type 1:高清flv, 2:流畅m3u8
  switchVideoUrl({int type = 0}) {
    sendMessage({"cmd": 'switch_type', "val": type});
  }

  /// 声音切换
  switchVideoVolume() {
    if (detailState.liveMuted.value) {
      sendMessage({"cmd": 'volume_video', "volume": 1});
      detailState.liveMuted.value = false;
    } else {
      sendMessage({"cmd": 'volume_video', 'volume': 0});
      detailState.liveMuted.value = true;
    }
  }

  /// 发送指令
  sendMessage(Map map) async {
    if (detailState.headerType.value == HeaderType.live) {
      String msg = jsonEncode(map);
      if (map['cmd'] == 'switch_type') {
        await detailState.webViewController?.evaluateJavascript(
            source:
                "document.getElementById('iframe').contentWindow.postMessage($msg,'*')");
        await detailState.webViewController?.evaluateJavascript(
            source: "index.video_msg('${LocaleKeys.app_toggle_hd_video.tr}${map['val'] + 1}')");
        await detailState.webViewController
            ?.evaluateJavascript(source: "index.playM3u8(${map['val']})");
      } else if (map['cmd'] == 'volume_video') {
        if (map['volume'] == 0) {
          await detailState.webViewController?.evaluateJavascript(source: '''
            var videos = document.getElementById('iframe').contentWindow.document.getElementsByTagName('video');
            for (var i = 0; i < videos.length; i++) {
              videos[i].muted = true;
            }
          ''');
        } else {
          await detailState.webViewController?.evaluateJavascript(source: '''
            var videos = document.getElementById('iframe').contentWindow.document.getElementsByTagName('video');
            for (var i = 0; i < videos.length; i++) {
              videos[i].muted = false;
            }
          ''');
        }
      } else {
        await detailState.webViewController?.evaluateJavascript(
            source:
                "document.getElementById('iframe').contentWindow.postMessage($msg,'*')");
      }
    }
  }
}
