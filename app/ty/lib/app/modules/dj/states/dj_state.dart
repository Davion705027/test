import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:flutter_ty_app/app/global/user_controller.dart';
import 'package:flutter_ty_app/app/modules/dj/models/game.dart';
import 'package:flutter_ty_app/app/services/models/res/dj_date_entity_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/dj_list_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/sport_entity.dart';

import '../../../services/models/req/dj_list_req.dart';

class DjState {
  List<DjDateEntityEntity>? djDateEntity;
  List<MatchEntity>? djListEntity;

  bool isFirst = true;
  /// 刷新中
  bool isLoading = false;

  ///选中日期
  DjDateEntityEntity? selectDate;
  /// 选中的菜单
  String gameId = ConfigController.to.gameMenuList.first.mi ?? '2100';

  DJListReq djListReq = DJListReq(
  category:1,csid:'100',euid:'41002',hpsFlag:0,md:'',sort:2,type:3000,
  cuid: UserController.to.getUid(),
  );

  /// 是否新手版
  bool isNew = false;

  /// 是否热门
  bool isHot = true;

  /// 球类
  SportEntity currentSport = SportEntity();

  /// 联赛
  Game league = Game.leagueList.first;

  /// 是否展开
  bool isExpand = true;
  bool isExpandProcess = true;
  bool isExpandAll = true;
  ///合上的tids
  List<String> collopList = [];

}
