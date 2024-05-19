import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../../utils/oss_util.dart';
import '../custom_cache_manager.dart';

class PreloadImg {
  static preloadOnHome(BuildContext context) {
    loadLoop(homeImgList, context);
  }

  static preloadOnSetting(BuildContext context) {
    loadLoop(settingImgList, context);
  }

  static preloadOnVrSport(BuildContext context) {
    loadLoop(vrSportImgList, context);
  }

  static preloadLeague(BuildContext context) {
    List<String> leagueUrls = [];
    [0, 7, 3, 10, 4, 5, 6, 40].forEach((element) {
      leagueUrls.add(
          'assets/images/league/sportstab_ico_${element}_nor_night_league.png');
      leagueUrls
          .add('assets/images/league/sportstab_ico_${element}_sel_league.png');
      leagueUrls
          .add('assets/images/league/sportstab_ico_${element}_nor_league.png');
    });

    loadLoop(leagueUrls, context);
  }

  static preloadMenu(BuildContext context) {
    List<String> menuUrls = [];
    for (int i = 0; i <= 66; i++) {
      menuUrls.add('assets/images/sport/sportstab_ico_${i}_nor.png');
      menuUrls.add('assets/images/sport/sportstab_ico_${i}_nor_night.png');
      menuUrls.add('assets/images/sport/sportstab_ico_${i}_sel.png');
    }
    loadLoop(menuUrls, context);
  }

  static delayPreloadOnDetail(BuildContext context) {
    // 详情页背景大图 除足球和篮球外延迟预加载
    delayLoad(3, detailImgList, context);
  }

  // 可用于外部自定义
  static delayLoad(int seconds, List<String> list, BuildContext context) {
    Future.delayed(Duration(seconds: seconds), () {
      loadLoop(list, context);
    });
  }
}

Map<List, bool> recordObj = {};

loadLoop(List<String> toLoadList, BuildContext context) async {
  if (recordObj[toLoadList] == true) return;
  final cacheManager = CustomCacheManager();

  for (int i = 0; i < toLoadList.length; i++) {
    String url = OssUtil.getServerPath(toLoadList[i]);
    final cacheFile = await cacheManager.getFileFromCache(url);
    // 没缓存或者超过过期时间
    if (cacheFile == null || cacheFile.validTill.isBefore(DateTime.now())) {
      await cacheManager.downloadFile(url);
      // await cacheManager.putFile(
      //   url,
      //   Uint8List.fromList([]),
      //   fileExtension: 'jpg',
      // );
    }

    // if (url.endsWith(".svg")) {
    //   _loadSvg(url);
    // } else {
    //   precacheImage(CachedNetworkImageProvider(url), context);
    // }

    // precacheImage(NetworkImage(url), context);
  }
  recordObj[toLoadList] = true;
}

Future<void> _loadSvg(String url) async {
  final cacheManager = DefaultCacheManager();
  cacheManager.getSingleFile(url);
}

// home页面 预加载的图片
List<String> homeImgList = [
  'assets/images/detail/odds-info-loading.gif',
  'assets/images/detail/odds-info-loading.webp',
  'assets/images/jlt/play-act.png',
  'assets/images/jlt/play.png',
  'assets/images/jlt/play-dark.png',
  'assets/images/shopcart/order_status_success1.png',
  'assets/images/shopcart/order_status_failure1.png',
  'assets/images/shopcart/order_status_prebook_success2.png',
  'assets/images/shopcart/order_status_standby1.png',
  'assets/images/shopcart/tandem_success1.png',
  'assets/images/shopcart/tandem_failed1.png',
  'assets/images/shopcart/closed_pic1.png',
  'assets/images/shopcart/backspace1.png',
  'assets/images/shopcart/collapse1.png',
  'assets/images/icon/main_tab1.png',
  'assets/images/icon/main_tab2.png',
  'assets/images/icon/main_tab3.png',
  'assets/images/icon/main_tab4.png',
  'assets/images/icon/main_tab5.png',
  'assets/images/detail/bg/football.jpg',
  'assets/images/detail/bg/basketball.jpg',
];

// 设置
List<String> settingImgList = [
  'assets/images/icon/search_unselected.png',
  'assets/images/icon/search_selected.png',
  'assets/images/icon/league_icon.png'
];

// 详情
List<String> detailImgList = [
  // 投注按钮
  'assets/images/detail/odds_up.svg',
  'assets/images/detail/odds_down.svg',
  'assets/images/detail/match-icon-lock.svg',
  // 缺省图
  'assets/images/detail/icon_arrowleft_nor_night.svg',
  'assets/images/detail/icon_arrowleft_nor.svg',
  'assets/images/detail/no-data-bg-night.svg',
  'assets/images/detail/no-data-bg.svg',
  'assets/images/detail/no-data-night.svg',
  'assets/images/detail/no-data.svg',
  'assets/images/detail/fullscreen-nodata-network.svg',
  'assets/images/detail/no_data_collect.png',
  'assets/images/detail/fullscreen-nodata-lock.svg',
  'assets/images/detail/def_marketclose.png',
  'assets/images/detail/fullscreen-nodata.svg',
  'assets/images/detail/bg/baseball.jpg',
  'assets/images/detail/bg/ice_hockey.jpg',
  'assets/images/detail/bg/tennis.jpg',
  'assets/images/detail/bg/american_football.jpg',
  'assets/images/detail/bg/snooker_pool.jpg',
  'assets/images/detail/bg/ping_pong.jpg',
  'assets/images/detail/bg/volleyball.jpg',
  'assets/images/detail/bg/badminton.jpg',
  'assets/images/detail/bg/handball.jpg',
  'assets/images/detail/bg/boxing.jpg',
  'assets/images/detail/bg/beach_volleyball.jpg',
  'assets/images/detail/bg/rugby.jpg',
  'assets/images/detail/bg/hockey.jpg',
  'assets/images/detail/bg/water_polo.jpg',
  'assets/images/detail/bg/details-LOL.jpg',
  'assets/images/detail/bg/DOTA.jpg',
  'assets/images/detail/bg/CS_GO.jpg',
  'assets/images/detail/bg/details-KPL.jpg',
];

// vr 体育
List<String> vrSportImgList = [
  // 菜单
  'assets/images/vr/vr_home_football.png',
  'assets/images/vr/vr_home_football_sel.png',
  'assets/images/vr/vr_home_basketball.png',
  'assets/images/vr/vr_home_basketball_sel.png',
  'assets/images/vr/vr_home_horse.png',
  'assets/images/vr/vr_home_horse_sel.png',
  'assets/images/vr/vr_home_dog.png',
  'assets/images/vr/vr_home_dog_sel.png',
  'assets/images/vr/vr_home_motorcycle.png',
  'assets/images/vr/vr_home_motorcycle_sel.png',
  'assets/images/vr/vr_home_dirt_bike.png',
  'assets/images/vr/vr_home_dirt_bike_sel.png',
  // 视频
  'assets/images/vr/video_mute.svg',
  'assets/images/vr/video_volume.svg',
  'assets/images/vr/vr_football_video_bg.png',
  'assets/images/vr/vr_basketball_video_bg.png',
  'assets/images/vr/vr_horse_video_bg_new.png',
  'assets/images/vr/vr_dog_video_bg.png',
  'assets/images/vr/vr_motorcycle_video_bg.png',
  'assets/images/vr/vr_dirtbike_video_bg.png',
  // 余额
  'assets/images/home/icon_trans_nor.svg',
  // 其他
  'assets/images/icon/icon_arrow_right_grey.png',
  // detail
  'assets/images/data/icondefault.png',
  'assets/images/vr/Wimage.png',
  'assets/images/vr/Dimage.png',
  'assets/images/vr/Limage.png',
  'assets/images/vr/Wimage.svg',
  'assets/images/vr/Dimage.svg',
  'assets/images/vr/Limage.svg',
  'assets/images/vr/ico_fav_sel.svg',
  'assets/images/vr/ico_fav.svg',
  'assets/images/vr/vr_dog_horse_rank1.svg',
  'assets/images/vr/vr_dog_horse_rank2.svg',
  'assets/images/vr/vr_dog_horse_rank3.svg',
  'assets/images/vr/vr_dog_horse_rank4.svg',
  'assets/images/vr/vr_dog_horse_rank5.svg',
  'assets/images/vr/vr_dog_horse_rank6.svg',
  'assets/images/vr/vr_dog_horse_rank7.svg',
  'assets/images/detailnew/rank1.png',
  'assets/images/detailnew/rank2.png',
  'assets/images/detailnew/rank3.png',
  'assets/images/detailnew/rank4.png',
  'assets/images/vr/bet_record_NO.1.png',
  'assets/images/vr/bet_record_NO.2.png',
  'assets/images/vr/bet_record_NO.3.png',
];
