import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:flutter_ty_app/app/global/user_controller.dart';
import 'package:flutter_ty_app/app/modules/home/models/combine_info.dart';
import 'package:flutter_ty_app/app/modules/home/models/league.dart';
import 'package:flutter_ty_app/app/modules/home/models/refresh_status.dart';
import 'package:flutter_ty_app/app/modules/home/models/section_group_enum.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/models/req/match_list_req.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';

import '../../../db/app_cache.dart';
import '../models/main_menu.dart';

class HomeState {
  /// 菜单
  MainMenu menu = MainMenu.menuList.first;

  /// 选中的菜单
  String sportId = ConfigController.to.sportMenuList.safeFirst?.mi ?? '101';

  /// 选中的联赛
  League league = League.leagueList.first;

  /// 是否专业版
  bool isProfess = BoolKV.userVersion.get() ?? true;
  bool isHot = BoolKV.sort.get() ?? true;
  var isLight = !Get.isDarkMode;

  /// 日期
  int? dateTime = null;

  /// 处于搜索模式
  bool isSearch = false;

  /// 是否展开
  Map<SectionGroupEnum, bool> expandMap = {
    SectionGroupEnum.IN_PROGRESS: true,
    SectionGroupEnum.NOT_STARTED: true,
    SectionGroupEnum.ALL: true,
  };

  /// 刷新中
  RefreshStatus refreshStatus = RefreshStatus.isLoading;

  /// 赛事列表请求实体
  MatchListReq matchListReq = MatchListReq(
      cuid: UserController.to.getUid(),
      euid: '40203',
      // 默认足球
      type: 3,
      sort: BoolKV.sort.get() ?? true ? 1 : 2,
      device: 'v2_h5_st',
      hpsFlag: 0,
      category: 1,
      md: '0',
      tid: null);

  /// 赛事列表
  List<MatchEntity> matchtSet = [];

  /// 分组后的赛事列表
  // List<MatchGroup> matchGroupList = [];

  List<CombineInfo> combineList = [];

  bool endScroll = true;
}
