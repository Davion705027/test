import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import '../../../../generated/locales.g.dart';

class League {
  String name;
  int val;
  String tid;
  String? img;
  String alias;

  late Set<String> tids = {};

  League(this.name, this.val, this.tid, this.img, this.alias);

  static resetAllTids() {
    leagueList.forEach((element) {
      element.tids = {};
    });
  }

  static resetAllName() {
    List<String> listName = [
      LocaleKeys.app_h5_match_all.tr,
      LocaleKeys.app_h5_match_champions.tr,
      LocaleKeys.app_h5_match_premier.tr,
      LocaleKeys.app_h5_match_serie.tr,
      LocaleKeys.app_h5_match_laliga.tr,
      LocaleKeys.app_h5_match_bundesliga.tr,
      LocaleKeys.app_h5_match_ligue.tr,
      LocaleKeys.app_h5_match_china_super.tr
    ];
    for (int i = 0; i < leagueList.length; i++) {
      leagueList[i].name = listName[i];
    }
  }

  static List<League> leagueList = [
    League("", 0, '0', "", 'all'),
    League("", 2, '6408', "", 'european_league'),
    League("", 3, '180', "", 'english_league'),
    League("", 4, '239', "", 'serie_league'),
    League("", 5, '320', "", 'spanish_league'),
    League("", 6, '276', "", 'german_league'),
    League("", 7, '79', "", 'french_league'),
    League("", 8, '10011006344', "", 'china_league'),
  ];

  static Map<String, dynamic> popular_leagues = {
    'european_league': {'key': '欧洲冠军联赛', 'tids': []},
    'english_league': {'key': '英格兰超级联赛', 'tids': []},
    'serie_league': {'key': '意大利甲级联赛', 'tids': []},
    'spanish_league': {'key': '西班牙甲级联赛', 'tids': []},
    'german_league': {'key': '德国甲级联赛', 'tids': []},
    'french_league': {'key': '法国甲级联赛', 'tids': []},
    'china_league': {'key': '中国超级联赛', 'tids': []},
  };
}
