import 'dart:math';

import 'package:get/get.dart';

import '../../generated/locales.g.dart';
import '../db/app_cache.dart';
import '../services/network/domain.dart';

class VideoUtil {
  /// 视频链接拼接
  static String getVideoUrlH5(String referUrl, String mid,
      {int liveType = 1, int hdSd = 0, bool muted = false}) {
    String mediaSrc = '';

    // 最优api
    String? requestDomain = DOMAIN_RESULT.first_one == ""
        ? StringKV.best_api.get()
        : DOMAIN_RESULT.first_one;
    double random = Random().nextDouble();
    String token = StringKV.token.get() ?? "";
    String lang = Get.locale?.languageCode ?? "zh";
    int volumeNumber = muted ? 0 : 100;
    int sound = muted ? 0 : 1;
    int dplayerVolume = 0; // 声音按钮
    mediaSrc =
        '$referUrl?live_type=$liveType&hd_sd=$hdSd&random=$random&mid=$mid&domain=$requestDomain&is_client=1&load_error=${LocaleKeys.video_sorry.tr}&refresh=${LocaleKeys.footer_menu_refresh.tr}&token=$token&lang=$lang&controls=1&volume_number=$volumeNumber&sound=$sound'
        '&dplayer-volume=$dplayerVolume';
    // mediaSrc = 'https:' + mediaSrc;
    mediaSrc = Uri.encodeFull(mediaSrc);
    return mediaSrc;
  }
}
