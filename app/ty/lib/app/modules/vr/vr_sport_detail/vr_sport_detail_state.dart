import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/services/models/res/common_score_model_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/group_soure_model_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/item_disuse_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_history_dog_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_match_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_sports_menu_entity.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';

class VrSportDetailState {
    ///Initialize variables
    List matchDetailList = [
      LocaleKeys.virtual_sports_match_detail_historical_results.tr,
      LocaleKeys.virtual_sports_match_detail_bet.tr,
      LocaleKeys.virtual_sports_match_detail_leaderboard.tr
    ];
    ///悬停标识
    RxBool overlapsContent = false.obs;
    TabController? matchTabController;
    ScrollController scrollController = ScrollController();

    List<String> historyScore = [];
    List<VrHistoryDogEntity> historyScoreDog = [];
    ///是否是世界杯类型
    RxBool isCup = false.obs;
    ///小组赛 淘汰赛切换下标
    RxInt groudIndex = 1.obs;
    ///排行榜
    List<CommonScoreModelData> rankList = [];
    ///小组赛
    List<GroupSoureModelDataGroupData> groupList = [];

    ///淘汰赛列表
    List<ItemDisuseEntity> disuseList = [];
    Map<String, List<ItemDisuseEntity>> disuseListMap = {};
    ///淘汰赛下标
    RxInt disuseIndex = 0.obs;

    List disuseTitle = [
      LocaleKeys.virtual_sports_Q8.tr,
      LocaleKeys.virtual_sports_quarter_finals.tr,
      LocaleKeys.virtual_sports_SEMIFINAL.tr,
      LocaleKeys.virtual_sports_FINAL.tr,
    ];

    ///小组赛 淘汰赛
    List dataHeadTitle = [
      LocaleKeys.virtual_sports_group_matches.tr,
      LocaleKeys.virtual_sports_knockout.tr,
    ];

    ///是否显示淘汰赛下标
    int isDisuse = 0;

    VrMatchEntity? vrMatch;
    MatchEntity? match;
    String? batchNo;
    String? lod;
    VrSportsMenuEntity? topMenu;

}
