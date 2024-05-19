import 'dart:math';

import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/utils/bus/event_bus.dart';
import 'package:flutter_ty_app/app/extension/map_extension.dart';
import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_map_operate.dart';
import 'package:flutter_ty_app/app/global/ws/ws_type.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/utils/bus/bus.dart';
import 'package:flutter_ty_app/app/utils/bus/event_enum.dart';

///101 102 103 104 106  201 203 901

///********************* 频发调接口的 *********************///
///  "C109","C302","C303" C112
class MatchDataBaseWS {
  EventBus? eventBus;

  ///记录赛事id
  Map<String, dynamic> midsMap = {};
  String nameCode = '';
  String type = '';
  bool isDestroyed = false;

  // DataStoreCtr matchCtr = DataStoreCtr();
  // late DataStoreController dataStoreController;

  DataStoreController? _dataStoreController;

  DataStoreController get dataStoreController {
    _dataStoreController ??= DataStoreController.to;
    return _dataStoreController!;
  }

  // 延时器
  Timer? microTimer;
  var currentType;
  var wsObj;

  /// ================================= 逻辑没对齐 ===============
  // void run() {
  //   if (eventBus.hasSubscriberFor(MITT_TYPES.WS_STATUS_CHANGE_EVENT)) {
  //     // Remove previous ws message listener
  //     eventBus.remove(MITT_TYPES.WS_STATUS_CHANGE_EVENT, rWsMsg);
  //   }
  //
  //   // Add ws message listener
  //   eventBus.on(MITT_TYPES.WS_STATUS_CHANGE_EVENT, rWsMsg);
  // }

  // void rWsMsg(obj) {
  //   ///=============获取cmd
  //   String cmd = '';
  //   if (cmd == 'WS_STATUS_CHANGE_EVENT') {
  //     ///=============获取 ws_status
  //     bool wsStatus = true;
  //     if (wsStatus != null && wsStatus) {
  //       if (wsTimer != null) {
  //         wsTimer?.cancel();
  //         wsTimer = null;
  //       }
  //       wsTimer = Timer.periodic(const Duration(milliseconds: 1500), (t) {
  //         scmdC8(cmd);
  //       });
  //     }
  //   } else if (cmd == 'WS_MSG_REV') {
  //     ///=========data.data
  //     Map<String, dynamic> data = {};
  //     if (data != null) {
  //       ///=============获取cmd
  //       String wsCmd = '';
  //       switch (wsCmd) {
  //         case 'C101':
  //           C101(data);
  //           break;
  //         case 'C102':
  //           C102(data);
  //           break;
  //         case 'C103':
  //           C103(data);
  //           break;
  //         case 'C104':
  //           C104(data);
  //           break;
  //         case 'C105':
  //           C105(data);
  //           break;
  //         case 'C106':
  //           C106(data);
  //           break;
  //         case 'C107':
  //           C107(data);
  //           break;
  //         case 'C110':
  //           C110(data);
  //           break;
  //         case 'C120':
  //           C120(data);
  //           break;
  //         case 'C302':
  //           C302(data);
  //           break;
  //         case 'C303':
  //           C303(data);
  //           break;
  //         case 'C304':
  //           C304(data);
  //           break;
  //         case 'C801':
  //           C801(data);
  //           break;
  //         case 'C901':
  //           C901(data);
  //           break;
  //         default:
  //           break;
  //       }
  //     }
  //   }
  // }

  ///101 102 103 104 106  201 203 901
  initBus() {
    // if (wsTimer != null) {
    //   wsTimer?.cancel();
    //   wsTimer = null;
    // }
    // wsTimer = Timer.periodic(const Duration(milliseconds: 1500), (t) {
    //   scmdC8();
    // });
    ///C8订阅后 下面cmd 是可接收
    /// C101,C102,C103,C105,C107,C110,C113,C114,C115,C303,C304,C305,C801
    Bus.getInstance().wsReceive<WsType>().listen((event) {
      // dataStoreController = dataStoreController.dataState;
      // "cd":{"cmec":"match_status","cmes":0,"csid":"8","mat":"away","mct":"0","mess":"1","mid":"
      // 3263011","mmp":"999"},"cmd":"C102","ctsp":"1709636840763",
      // "ld":"B02_0af5158e202403051907156855ec1f6a"}

      microtaskCmd(event.type, event.data);

      ///关盘通知 统一处理
      removeMatch(event.type, event.data);
      switch (event.type) {
        case WsType.C101:
          C101(event.data);
          break;

        /// 赛事事件
        case WsType.C102:
          C102(event.data);
          break;
        case WsType.C103:
          C103(event.data);
          break;

        ///赛事级别盘口状态
        case WsType.C104:
          C104(event.data);
          break;

        ///105盘口状态、赔率  106注单订阅盘口状态、赔率
        case WsType.C105 || WsType.C106:
          C105(event.data);
          break;

        case WsType.C107:
          C107(event.data);
          break;
        case WsType.C108:
          C108(event.data);
          break;

        ///自行处理
        case WsType.C109:
          C109(event.data);
          break;

        ///赛事订阅C1-玩法数量（C110）
        case WsType.C110:
          C110(event.data);
          break;

        ///玩法集变更
        case WsType.C112:
          C112(event.data);
          break;

        ///玩法集变更
        case WsType.C120:
          C120(event.data);
          break;

        /// 订单状态 注单结算
        case WsType.C201:

          ///注单处理逻辑
          C201(event.data);
          break;
        case WsType.C202:

          ///注单处理逻辑
          C202(event.data);
          break;
        case WsType.C203:

          ///用户账变
          C203(event.data);
          break;
        case WsType.C210:

          /// 赛事提前结算状态变化
          C210(event.data);
          break;
        case WsType.C211:

          /// 赛事提前结算状态变化
          C211(event.data);
          break;

        /// 赛事状态发现变更  ms
        case WsType.C301:
          C301(event.data);
          break;

        /// 赛事状态发现变更  ms
        case WsType.C302:
          C302(event.data);
          break;
        case WsType.C303:
          C303(event.data);
          break;
        case WsType.C304:
          C304(event.data);
          break;
        case WsType.C501:
          C501(event.data);
          break;
        case WsType.C601:
          C601(event.data);
          break;
        case WsType.C801:
          C801(event.data);
          break;
        case WsType.C901:
          C901(event.data);
          break;
        case WsType.C1021:
          C1021(event.data);
          break;
        case WsType.C3011:
          C3011(event.data);
          break;
        default:
          break;
      }
    });
    initTimer();
  }

  initTimer() {
    microTimer = Timer.periodic(const Duration(milliseconds: 1500), (timer) {
      ///添加任务执行--- 添加合并延迟推送
      microtaskSend();
      // if (timer.tick >= 1500) {
      //   timer.cancel();
      // }
    });

  }

  ///微任务队列
  ///  "C109","C302","C303" C112
  ///  301
  microtaskCmd(String cmd, wsObj) {
    // {"cd":{"csid":"1","hpid":"10","mid":"3286676"},
    // "cmd":"C303","ctsp":"1710240227003","ld":"AO_0af5159020240312184345880657e15e_1"}
    // {
    //   'C109':[
    //     {"csid":"1","hs":0,"mid":"3288756","ms":"1"},
    //     {"csid":"1","hs":0,"mid":"3288756","ms":"1"},
    //     {"csid":"1","hs":0,"mid":"3288756","ms":"1"},
    //     {"csid":"1","hs":0,"mid":"3288756","ms":"1"},
    //     {"csid":"1","hs":0,"mid":"3288756","ms":"1"},
    //   ]
    // };


      final cdObj = wsObj['cd'];
      if ([WsType.C302, WsType.C303, WsType.C112].contains(cmd)) {
        String mid = cdObj['mid'] ?? '';
        if (mid.isNotEmpty) {
          if (midsMap.keys.contains(cmd)) {
            List midsList = midsMap[cmd];
            midsList.add(mid);
          } else {
            ///C303 302  合并成1个  C302
            if (cmd == WsType.C303) {
              if (midsMap.keys.contains(WsType.C302)) {
                List midsList = midsMap[WsType.C302];
                midsList.add(mid);
              } else {
                midsMap[WsType.C302] = [mid];
              }
            } else {
              midsMap[cmd] = [mid];
            }
          }
        }
      } else if ([WsType.C109, WsType.C301].contains(cmd)) {
        List cd = cdObj ?? [];
        if (cd.isNotEmpty) {
          if (midsMap.keys.contains(cmd)) {
            List cdObjList = midsMap[cmd];
            cdObjList.addAll(cd);
          } else {
            midsMap[cmd] = cd;
          }
        }
      }

  }

  microtaskSend() {
    if (midsMap.keys.isNotEmpty) {
      // if (kDebugMode) {
      //   print('推送时间间隔------》${DateTime.now()}');
      // }

     Future((){
       if(Get.currentRoute == Routes.matchDetail ){
         if(midsMap.keys.contains(WsType.C109) && midsMap.keys.contains(WsType.C302)){
           midsMap.remove(WsType.C302);
         }
       }
       midsMap.keys.forEach((element){

         if (element == WsType.C109) {
           List cdObjList = midsMap[WsType.C109];
           ///列表相关 刷新接口
           Bus.getInstance().emit(EventType.RCMD_C109, cdObjList.toSet().toList());
         } else if (element== WsType.C112) {
           List midsList = midsMap[WsType.C112];
           Bus.getInstance()
               .emit(EventType.socketOddinfo, midsList.toSet().toList());
         } else if (element== WsType.C302) {
           List midsList = midsMap[WsType.C302];
           Bus.getInstance().emit(EventType.init302, midsList.toSet().toList());
         } else if (element == WsType.C301) {
           List cdObjList = midsMap[WsType.C301];
           Bus.getInstance()
               .emit(EventType.RCMD_C301, cdObjList.toSet().toList());
         }
       });
     }).then((value) => midsMap.clear());
    }

  }

  removeMatch(String cmd, wsObj) {
    if ([WsType.C101, WsType.C102, WsType.C104, WsType.C901].contains(cmd)) {
      var mid = wsObj['cd']['mid'].toString() ?? '';
      var mhs = wsObj['cd']['mhs'];
      var mmp = wsObj['cd']['mmp'];
      var ms = wsObj['cd']['ms'];
      if (ms != null) {
        ms = int.tryParse(ms.toString());
      }
      bool isClose = closeMatch(mhs: mhs, mmp: mmp, ms: ms);

      if(isClose){
        /// 赛事删除
        Bus.getInstance().emit(EventType.removeMatch, mid);
      }


      /// 确定关盘  数据仓库需要更新
      // if (isClose) {
      //   /// mhs === 2 为关盘
      //   if (mid.isNotEmpty) {
      //     MatchEntity? match = dataStoreController.getMatchById(mid);
      //     if (match != null) {
      //       if (mhs != null) {
      //         match.mhs = mhs;
      //       }
      //       if (mmp != null) {
      //         match.mmp = mmp;
      //       }
      //       if (ms != null) {
      //         match.ms = ms;
      //       }
      //       dataStoreController.updateMatch(match);
      //     }
      //   }
      // }
    }
  }

  static bool closeMatch({dynamic mhs, dynamic mmp, dynamic ms}) {
    ///mhs 关盘状态
    List closeMhsState = [2, 11];
    bool closeForMhs = (mhs != null && closeMhsState.contains(mhs));

    // ///ms 关盘状态
    // List closeMsState = [3, 4, 5, 6, 7, 8, 9];
    // bool closeForMs = (ms != null && closeMsState.contains(ms));
    return closeForMhs || mmp == '999';
  }

  List<T> getRandomItems<T>(List<T> list, int count) {
    Random random = Random();
    List<T> resultList = [];

    // 如果要取出的数据数量大于列表长度，则返回整个列表
    if (count >= list.length) {
      return List.from(list);
    }

    while (resultList.length < count) {
      int randomIndex = random.nextInt(list.length); // 生成随机索引
      T randomItem = list[randomIndex]; // 获取随机索引对应的元素

      // 如果 resultList 中不包含当前随机元素，则添加到 resultList 中
      if (!resultList.contains(randomItem)) {
        resultList.add(randomItem);
      }
    }

    return resultList;
  }

  ///赛事状态
  // {"cd":{"mid":"308230039208001538","ms":1},
  // "cmd":"C101","ctsp":"1710743707617","ld":"RC_PUSH_3fd0a7b47fa04291b05845fa5305b8fb_STAT_1111178"}
  void C101(wsObj) {
    if (wsObj != null) {
      final cdObj = wsObj['cd'];
      String mid = cdObj['mid'] ?? '';
      String ms = cdObj['ms'].toString();
      // Real-time time
      ///=============获取ctsp
      MatchEntity? match = dataStoreController.getMatchById(mid);

      /// 获取快速查询对象中的mid赛事对象
      // final match = getQuickMidObj(mid);
      if (match != null) {
        int oldMs = match.ms;
        wsObj['oldMs']  = oldMs;
        ///滚球开赛推送
        Bus.getInstance().emit(EventType.RCMD_C101, [wsObj]);
        if (ms.isNotEmpty) {
          match.ms = int.tryParse(ms) ?? 0;
        }
        dataStoreController.updateMatch(match);
        Bus.getInstance().emit(EventType.updata_detail_data, [wsObj]);
        /// 数据同步逻辑
        // assignWith(match, cdObj);
      }
    }
  }

  ///赛事事件
  // "cd":{"cmec":"match_status","cmes":0,"csid":"8","mat":"away","mct":"0","mess":"1","mid":"
  // 3263011","mmp":"999"},"cmd":"C102","ctsp":"1709636840763",
  // "ld":"B02_0af5158e202403051907156855ec1f6a"}
  void C102(wsObj) {
    if (wsObj != null) {
      final cdObj = wsObj['cd'];
      String mid = cdObj['mid'] ?? "";
      // int? cmec = int.tryParse(cdObj['cmec'].toString());
      // int? cmes = int.tryParse(cdObj['cmes'].toString());
      // String? csid = cdObj['csid'];
      // String? mat = cdObj['mat'];
      // String? mgt = cdObj['mgt'];
      // String? mct = cdObj['mct'];
      // String? mess = cdObj['mess'];
      // String? mmp = cdObj['mmp'];
      // int? mst = int.tryParse(cdObj['mst'].toString());
      //
      // /// 棒球
      // int? mbhn = int.tryParse(cdObj['mbhn'].toString());
      // int? mbkn = int.tryParse(cdObj['mbkn'].toString());
      // int? mbcn = int.tryParse(cdObj['mbcn'].toString());
      // int? mbolp = int.tryParse(cdObj['mbolp'].toString());
      // int? mbtlp = int.tryParse(cdObj['mbtlp'].toString());
      // int? mbthlp = int.tryParse(cdObj['mbthlp'].toString());

      // String ctsp = wsObj['ctsp'];

      /// 获取快速查询对象中的mid赛事对象
      // MatchEntity match = getQuickMidObj(mid);
      MatchEntity? match = dataStoreController.getMatchById(mid);
      // final sktData = wsObj.cd;

      /// var 事件 skt_data.cmec !== 'goal 避免接口返回 goal 事件
      /// 设置赛事比分更新时间
      // wsMatchKeyUpdTimeCacheSet(match, 'msc', ctsp);

      // cmec":"match_status","cmes":0,"csid":"8","mat":"away","mct":"0","mess":"1"
      if (match != null) {

        Bus.getInstance().emit(EventType.RCMD_C102, [wsObj]);
        Map<String, dynamic> matchMap = match.toJson();
        matchMap.addAll(cdObj);
        MatchEntity newMatch = MatchEntity.fromJson(matchMap);
        dataStoreController.updateMatch(newMatch);
        Bus.getInstance().emit(EventType.updata_detail_data, [wsObj]);
      }
    }
  }

  ///赛事比分
  // {"cd":{"csid":1,"mid":"3261173","mpid":"6","msc":
  // ["S1|0:0","S2|0:0","S5|4:3","S6|2:1","S8|56:33","S10|0:0","S11|0:0","S12|0:0",
  // "S13|0:0","S14|0:0","S15|4:3","S17|1:1","S18|1:0","S104|54:40","S105|0:0","S555|4:3"
  // ,"S1001|0:0","S1002|0:0","S1003|0:0","S1004|0:0","S1005|0:0","S1006|0:0","S1101|2:1",
  // "S5001|1:0","S5002|2:2","S5003|1:1","S5004|0:0","S5005|0:0","S5006|0:0","S10011|0:0",
  // "S10012|0:0","S10013|0:0","S10021|0:0","S10022|0:0","S10023|0:0","S10031|0:0","S10032|0:0",
  // "S10101|0:0","S10102|0:0","S10103|0:0","S11001|0:0","S12001|0:0","S50011|0:0","S50012|0:0","S50013|0:0"]},
  // "cmd":"C103","ctsp":"1710239917185","ld":"KO_0af50b2320240312183837069761c72d054b"}

  void C103(wsObj) {
    if (wsObj != null) {
      Bus.getInstance().emit(EventType.updata_detail_data, [wsObj]);
      // ws命令数据信息
      final cdObj = wsObj['cd'];
      // 赛事标识
      ///=============获取mid
      String mid = cdObj['mid'].toString();
      List msc = cdObj['msc'];
      // 实时时间歘
      ///=============获取ctsp
      String ctsp = wsObj['ctsp'];

      // 获取快速查询对象中的mid赛事对象
      // final match = getQuickMidObj(mid);
      MatchEntity? match = dataStoreController.getMatchById(mid);
      if (match != null) {
        /// 合并赛事
        Map<String, dynamic> matchMap = match.toJson();

        /// 更新msc比分信息
        matchMap.addAll(cdObj);
        MatchEntity newMatch = MatchEntity.fromJson(matchMap);
        dataStoreController.updateMatch(newMatch);

        // // 数据同步逻辑
        // assignWith(match, {...cdObj, 'is_ws': true});
        // // 格式化列表赛事(部分数组转对象)
        // listSerializedMatchObj([match], true);
        // // 设置赛事比分更新时间
        // wsMatchKeyUpdTimeCacheSet(match, 'msc', ctsp);
      }
    }
  }

  ///C104 赛事级别盘口状态
  // {
  // "cd": {
  // "csid": "2",
  // "mhs": 0, 0开盘 1 封盘  2 关盘 11锁盘
  // "mid": "634519",
  // "ms": "110"
  // },
  // "cmd": "C104",
  // "ctsp": "1611287974122",
  // "ld": "82c7abba44124dbcb24d47824fd231ce_odds_trade"
  // }
  void C104(wsObj) {
    if (wsObj != null) {
      Bus.getInstance().emit(EventType.updata_detail_data, [wsObj]);
      // ws命令数据信息
      Map<String, dynamic> cd = wsObj["cd"];
      // 赛事标识
      String mid = cd["mid"];

      /// 实时时间歘
      /// 获取快速查询对象中的mid赛事对象
      MatchEntity? match = dataStoreController.getMatchById(mid);
      if (match != null) {
        match?.mhs = int.parse(cd["mhs"].toString());
        // match?.ms = int.parse(cd["ms"].toString());
        match?.ms = int.tryParse(cd["ms"].toString())??0;

        // Map<String, dynamic> matchMap = match.toJson();
        // matchMap.addAll(cd);
        // MatchEntity? newMatch = MatchEntity.fromJson(matchMap);
        // 同步更新快速查询对象中的赛事状态
        dataStoreController.updateMatch(match);
      }
    }
  }

  // {
  // "cd": {
  // "hls": [
  // {
  // "hid": "143349024444581022",
  // "hmt": 0,
  // "hn": 1,
  // "hpid": "2",
  // "hs": 0,
  // "mid": "619449",
  // "ol": [
  // {
  // "obv": "178000",
  // "oid": "143634920413042028",
  // "os": 1,
  // "ot": "Over",
  // "ov": "178000"
  // },
  //
  // ]
  // },
  // {
  // "hid": "142841435599534052",
  // "hmt": 0,
  // "hpid": "1",
  // "hs": 0,
  // "mid": "619449",
  // "ol": [
  // {
  // "obv": "88000",
  // "oid": "143573153910168915",
  // "os": 2,
  // "ot": "1",
  // "ov": "88000"
  // },
  // {
  // "obv": "1799000",
  // "oid": "140457023563880646",
  // "os": 1,
  // "ot": "X",
  // "ov": "1799000"
  // },
  // {
  // "obv": "5645000",
  // "oid": "145602149493075410",
  // "os": 1,
  // "ot": "2",
  // "ov": "5645000"
  // }
  // ]
  // }
  // ],
  // "mid": "619449"
  // },
  // "cmd": "C105",
  // "ctsp": "1610590773893",
  // "ld": "0af51251202101141019331186a5783f"
  // }
  ///盘口赔率
  void C105(wsObj) {
    if (wsObj != null) {
      Bus.getInstance().emit(EventType.RCMD_C105, [wsObj]);
      Map<String, dynamic> cd = wsObj["cd"];
      String mid = cd["mid"];
      MatchEntity? match = dataStoreController.getMatchById(mid);
      if (match != null) {
        List<Map<String, dynamic>> hls =
            cd.get('hls')?.cast<Map<String, dynamic>>() ?? [];
        if (hls.isNotEmpty) {
          hls?.forEach((hlMap) {
            List<Map<String, dynamic>>? ols =
                hlMap.get("ol")?.cast<Map<String, dynamic>>();
            ols?.forEach((olMap) {
              MatchHpsHlOl? ol =
                  dataStoreController.getOlById(olMap.get("oid"));
              if (ol != null) {
                Map<String, dynamic> oldOlMap = ol.toJson();
                // 合并赔率
                oldOlMap.addAll(olMap);
                MatchHpsHlOl newOl = MatchHpsHlOl.fromJson(oldOlMap);
                // 更新赔率状态
                dataStoreController.updateOl(newOl);
              }
            });
          });
        }
      }

    }
  }

  // {"cd":{"hls":[{"hid":"141166327841400404","hmt":0,"hpid":"1",
  // "hs":0,"mid":"3309107","ol":[{"obv":"440000","oid":"144240021206684277",
  // "os":1,"ot":"1","ov":"440000"},{"obv":"145000","oid":"148031785175341227","os":1,
  // "ot":"2","ov":"145000"},{"obv":"425000","oid":"144068151919801125","os":1,"ot":"X"
  // ,"ov":"425000"}]}],"ld":"AO_0af5159720240318143400766992c849_0","mid":"3309107"},"
  // cmd":"C106","ctsp":"1710743641357","ld":"AO_0af5159720240318143400766992c849_0"}
  void C106(wsObj) {
    C105(wsObj);
  }

  ///赛事视频/动画状态
  // {"cd":{"mid":"3262113","mms":1,"mvs":1,"pmms":0},
  // "cmd":"C107","ctsp":"1710240985511","ld":"ce7bb731be5745c1925372deba587715"}
  /// 动画状态 mvs -1: 没有配置动画源  0 已配置 不可用  1/2 已配置 可用
  /// 视频状态 mms -1: 没有配置动画源  0 已配置 不可用  1 已配置 暂未播放  2 已配置 播放中
  void C107(wsObj) {
    if (wsObj != null) {
      Bus.getInstance().emit(EventType.updata_detail_data, [wsObj]);
      Map<String, dynamic> cd = wsObj["cd"];
      String mid = cd["mid"];
      MatchEntity? match = dataStoreController.getMatchById(mid);
      // final match = getQuickMidObj(mid);
      if (match != null) {
        if (cd['mvs'] != null) {
          match.mvs = cd['mvs'];
        }
        if (cd['mms'] != null) {
          match.mms = cd['mms'];
        }
        if (cd['pmms'] != null) {
          match.pmms = cd['pmms'];
        }
        dataStoreController.updateMatch(match);
        // Data synchronization logic
        // assignWith(match, cdObj);
        // matchUpdTimeRetChange(match);
        // updDataVersion();
      }
    }
  }

  /// 财务推送 收到这个命令需要刷新整个页面
//   {
//   cmd: "C108", // 指令
//   ctsp: 13136466799,   // 时间戳
//   cd:""//数据
// }
  void C108(wsObj) {
    if (wsObj != null) {
      Bus.getInstance().emit(EventType.RCMD_C108, [wsObj]);
    }
  }

  // {"cd":[{"csid":"1","hs":0,"mid":"3288756","ms":"1"},{"csid":"1","hs":0,"mid":"306148956190478338","ms":"0"}],
  // "cmd":"C109","ctsp":"1710234480448",
  // "ld":"a4ed698c104d43df9f701f6d38b17211_trade_config,RC_PUSH_81b3e39431144e78867f67ed3ad11b83_1102121_1"}
  ///109 赛事开盘推送 无需订阅  自动推送
  /// ***** 同步赛事状态 调用相关的api接口
  void C109(wsObj) {
    if (wsObj != null) {
      // Bus.getInstance().emit(EventType.RCMD_C109, [wsObj]);
      // List cdList = wsObj["cd"];
      // cdList.forEach((element) {
      //   Map eleMap = element;
      //   MatchEntity? match = dataStoreController.getMatchById(eleMap['mid']);
      //   if (match != null) {
      //     match.csid = eleMap['csid'].toString();
      //     match.ms = int.parse(eleMap['ms'].toString());
      //     dataStoreController.updateMatch(match);
      //   }
      // });
    }
  }

  ///赛事订阅C8-玩法数量
  ///赛事玩法数量同步到玩法数量显示区域
  // {"cd":{"mc":133,"mid":"3261173"},"cmd":"C110","ctsp":"1710239917139"
  // ,"ld":"AO_0af5159020240312183835892b6960b8_0"}
  void C110(Map<String, dynamic> wsObj) {
    if (wsObj != null) {
      Bus.getInstance().emit(EventType.RCMD_C110, [wsObj]);
      Map<String, dynamic> cdObj = wsObj['cd'];
      String mid = cdObj['mid'];
      int mc = int.tryParse(cdObj['mc'].toString()) ?? 0;

      String ctsp = wsObj['ctsp'];
      MatchEntity? match = dataStoreController.getMatchById(mid);
      // Map<String, dynamic> match = getQuickMidObj(mid);
      if (match != null) {
        match.mc = mc;
        dataStoreController.updateMatch(match);
      }
    }
  }

  ///c8订阅
  ///  玩法集变更(C112)
  ///  触发http请求  赛事详情模块收到消息 重新调用玩法集菜单api接口  同步最新的数据、
  // {
  // "cd": {
  // "mcid": [
  // "48",
  // "76"
  // ],
  // "mcms": "3",
  // "mid": "611980"
  // },
  // "cmd": "C112",
  // "ctsp": "1610592753695",
  // "ld": "0af5125120210114105233410817f0a6"
  // }
  void C112(Map<String, dynamic> wsObj) {
    if (wsObj != null) {
      // Bus.getInstance().emit(EventType.socketOddinfo, [wsObj]);
    }
  }

  ///盘口结束时间(针对冠军赛事) C8
  // {
  // "cd": {
  // "mid": "77821687983308802",
  // "hid": "144025105247958058",
  // "hmgt": "1628879400000", 冠军盘口开始时间
  // "hmed": "1652535000000" 冠军盘口结束时间
  // },
  // "cmd": "C120",
  // "ctsp": "1614050093866",
  // "ld": "c0e02d578dcb4a079e2dcb9652ae9640-1629029377566"
  // }

  ///冠军 右边显示的事件
  void C120(Map<String, dynamic> wsObj) {
    if (wsObj != null) {
      // Bus.getInstance().emit(EventType.RCMD_C120, [wsObj]);
      Map<String, dynamic> cdObj = wsObj['cd'];
      String mid = cdObj['mid'].toString();
      MatchEntity? match = dataStoreController.getMatchById(mid);
      if (match != null) {
        Map<String, dynamic> matchMap = match.toJson();
        matchMap.addAll(cdObj);
        MatchEntity newMatch = MatchEntity.fromJson(matchMap);
        dataStoreController.updateMatch(newMatch);
      }
    }
  }

  // {"cd":{"cuid":"509825984426120034","isOddsChange":false,"newProcessOrder":0,"orderNo":"5132230936416288","preStatus":0,"status":1,
  // "tryNewProcessBet":0},"cmd":"C201","ctsp":"1710743654741","ld":"fe2c007ba8b14ba787b553657fb269fd"}
  ///注单订阅  订单状态改变使用 C3订阅
  void C201(Map<String, dynamic> wsObj) {
    if (wsObj != null) {
      ///注单处理逻辑
      Map<String, dynamic> cd = wsObj["cd"];
      Bus.getInstance().emit(EventType.orderPreSettle, cd);
    }
  }

  /// 未结算订单数 未结算订单数量变化 C3订阅
  // {"cd":{"count":85,"cuid":"509825984426120034"},"cmd":"C202","ctsp":"1710743654741",
  // "ld":"fe2c007ba8b14ba787b553657fb269fd"}
  void C202(Map<String, dynamic> wsObj) {
    Bus.getInstance().emit(EventType.RCMD_C202, [wsObj]);
  }

  ///用户账变 重新请求用户余额接口
  // {
  // "cd": {
  // "cuid": "204783950864248832"
  // },
  // "cmd": "C203",
  // "ctsp": "1611300018516",
  // "ld": "b84fb3f36e524ca282b1172877dfdd60"
  // }
  void C203(Map<String, dynamic> wsObj) {
    Bus.getInstance().emit(EventType.RCMD_C203, [wsObj]);
  }

  /// 赛事提前结算投注项  C21订阅   提前结算投注项数据变化通知
  // {
  // "cmd": "C210",
  // "ctsp": "1635915042008",
  // "cd": [
  // {
  // "hid": "142725909041383",
  // "oid": "142725909041383930",
  // "probabilities": 0.0165,
  // "cashOutStatus": 1,
  // "ov": "1.98"
  // }
  // ],
  // "ld": "SR_ac12b2f620211103141208728b148f60"
  // }
  void C210(Map<String, dynamic> wsObj) {
    if (wsObj != null) {
      Bus.getInstance().emit(EventType.RCMD_C210, [wsObj]);
    }
  }

  /// 赛事提前结算状态变化 C8订阅
  // "cd": {
  //         "mearlys": 0,
  //         "mid": "2935854"
  //     },
  //     "cmd": "C211",
  //     "ctsp": "1638513379595",
  //     "ld": "4eb7da4a209c4128ac9697e84de6360f_merge_trade"
  void C211(Map<String, dynamic> wsObj) {
    if (wsObj != null) {
      Map<String, dynamic> cdObj = wsObj['cd'];
      String mid = cdObj['mid'].toString();
      String mearlys = cdObj['mearlys'].toString();
      MatchEntity? match = dataStoreController.getMatchById(mid);
      if (match != null) {
        if (mearlys != null) {
          match.mearlys = int.parse(mearlys);
        }
        dataStoreController.updateMatch(match);
      }
    }
  }

  ///菜单栏目统计
  ///菜单栏目数量变化时触发
  // {
  // "cd": [
  // {
  // "containLive": false,
  // "count": 1488,
  // "menuId": "302",
  // "sys": 4
  // },
  //
  // ],
  // "cmd": "C301",
  // "ctsp": "1610590730014"
  // }
  void C301(Map<String, dynamic> wsObj) {
    // Bus.getInstance().emit(EventType.RCMD_C301, [wsObj]);
  }

  ///赛事开赛状态
  ///***触发http请求  C4订阅
  // {"cd":{"csid":"8","mid":"3288468","ms":1},"cmd":"C302","ctsp":"1710241062185",
  // "ld":"BG_0af513aa20240312185735034a2ef68c0377status,
  // B02_0af515942024031218574214189cdf50,BG_0af513aa20240312185735034a2ef68c0377status,
  // B02_0af515942024031218574214189cdf50"}
  void C302(Map<String, dynamic> wsObj) {
    if (wsObj != null) {
      Map<String, dynamic> cdObj = wsObj['cd'];
      String mid = cdObj['mid'];
      String ms = cdObj['ms'].toString();
      MatchEntity? match = dataStoreController.getMatchById(mid);
      if (match != null) {
        match.ms = int.parse(ms);
        dataStoreController.updateMatch(match);
        // assignWith(match, cdObj);
      }
    }
  }

  // {"cd":{"csid":"1","hpid":"10","mid":"3286676"},
  // "cmd":"C303","ctsp":"1710240227003","ld":"AO_0af5159020240312184345880657e15e_1"}
  ///新增玩法/盘口通知
  void C303(Map<String, dynamic> wsObj) {
    if (wsObj != null) {
      ///1s 2s 给你发一个mid [‘2222’,‘2222’,‘2222’,‘2222’,]
      ///玩法id mid   多个玩法是用逗号隔开

      // Map<String, dynamic> cdObj = wsObj['cd'];
      // String mid = cdObj['mid'];
      // List matchList = mid.split(',');
      // matchList.forEach((element) {
      //   String matchId = element.toString();
      //   MatchEntity? match = dataStoreController.getMatchById(matchId);
      //   // Map<String, dynamic> match = getQuickMidObj(mid);
      //   if (match != null) {
      //     dataStoreController.updateMatch(match);
      //     // updMatchAllStatus({'mid': mid, 'hid': cdObj['hid'], 'hs': cdObj['hs']});
      //   }
      // });
    }
  }

  ///废除
  void C304(Map<String, dynamic> wsObj) {
    if (wsObj != null) {
      Bus.getInstance().emit(EventType.RCMD_C304, [wsObj]);
      // Map<String, dynamic> cdObj = wsObj['cd'];
      // String mid = cdObj['mid'];
      // String ctsp = wsObj['ctsp'];
    }
  }

  ///新版UI菜单 C51订阅
  // {
  // "cd": [
  //
  // {
  // "containLive": false,
  // "count": 1,
  // "menuId": "302010108"
  // },
  // {
  // "containLive": false,
  // "count": 20,
  // "menuId": "302010109"
  // }
  // ],
  // "cmd": "C501",
  // "ctsp": "1610590812789"
  // }
  void C501(Map<String, dynamic> wsObj) {
    if (wsObj != null) {
      Bus.getInstance().emit(EventType.RCMD_C501, [wsObj]);
      // Map<String, dynamic> cdObj = wsObj['cd'];
      // String mid = cdObj['mid'];
      // String ctsp = wsObj['ctsp'];
    }
  }

  ///热门赛事变化时触发
  ///** 触犯http请求
  // {
  // "cmd": "C601",
  // "cd": {
  // "hoid": 1 // hoid子栏目列表：“1”：热门9场赛事 “2”：直播/动画列表 (2目前没用到)
  // },
  // "ctsp": "1612240060001",
  // "Id": "task_1612240060001"
  // }
  void C601(Map<String, dynamic> wsObj) {
    if (wsObj != null) {
      Bus.getInstance().emit(EventType.RCMD_C601, [wsObj]);
      // Map<String, dynamic> cdObj = wsObj['cd'];
      // String mid = cdObj['mid'];
      // String ctsp = wsObj['ctsp'];
    }
  }

  ///倒计时补充
  ///C8订阅  主要是同步倒计时事件
  // {
  // "cd": [
  // {
  // "mct": "0",
  // "mess": "1",
  // "mhs": 0,
  // "mid": "594472",
  // "mmp": "0",
  // "ms": "0",
  // "mst": 0
  // },
  // {
  // "mct": "0",
  // "mess": "1",
  // "mhs": 1,
  // "mid": "615509",
  // "mmp": "31",
  // "ms": "1",
  // "msc": [
  // "S1|2:0",
  // "S2|2:0",
  // "S3|0:0",
  // "S5|2:2",
  // "S8|32:20",
  // "S10|1:0",
  // "S11|0:0",
  // "S12|2:0",
  // "S15|2:2",
  // "S16|0:0",
  // "S17|3:1",
  // "S18|0:2",
  // "S104|59:44",
  // "S105|49:51",
  // "S555|2:2"
  // ],
  // "mst": 2700
  // },
  //
  // ],
  // "cmd": "C801",
  // "ctsp": "1610593030384"
  // }

//  同步到中央数据库
  void C801(Map<String, dynamic> wsObj) {
    if (wsObj != null) {
      // Bus.getInstance().emit(EventType.RCMD_C801, [wsObj]);
      List cdObj = wsObj['cd'];
      cdObj.forEach((element) {
        String mid = element['mid'];
        MatchEntity? match = dataStoreController.getMatchById(mid);
        if (match != null) {
          Map<String, dynamic> matchMap = match.toJson();
          matchMap.addAll(element);
          MatchEntity newMatch = MatchEntity.fromJson(matchMap);
          dataStoreController.updateMatch(newMatch);
        }
      });


    }
  }

  ///关盘补充
  ///收到消息后 根据联赛和赛事信息删除联赛下的赛事
  // {
  // "cd": {
  // "csid": "1",
  // "mhs": 2,    0:开盘 1 封盘  2 关盘  11 锁盘
  // "mid": "2289274",
  // "ms": "0",
  // "tid": "821456"
  // },
  // "cmd": "C901",
  // "ctsp": "1620291316135",
  // "ld": "cca874a2026540119554ee9f61a27aac_trade_status"
  // }
  void C901(Map<String, dynamic> wsObj) {
    if (wsObj != null) {
      Bus.getInstance().emit(EventType.RCMD_C901, [wsObj]);
      // Map<String, dynamic> cdObj = wsObj['cd'];
      // String mid = cdObj['mid'];
      // String ctsp = wsObj['ctsp'];
    }
  }

  ///赛事事件 通知赛事变化 更新指定模块显示逻辑
  ///C81订阅
  // {
  // "cd": {
  // "cmec": "goal",
  // "cmes": 0,
  // "mess": "1",
  // "mid": "611987",
  // "mmp": "7",
  // "mst": 613
  // },
  // "cmd": "C1021",
  // "ctsp": "1610593949695",
  // "ld": "0af503492021011411122966642b20cc"
  // }
  void C1021(Map<String, dynamic> wsObj) {
    if (wsObj != null) {
      Bus.getInstance().emit(EventType.RCMD_C1021, [wsObj]);
      Map<String, dynamic> cdObj = wsObj['cd'];
      String mid = cdObj['mid'];
      MatchEntity? match = dataStoreController.getMatchById(mid);
      if (match != null) {
        Map<String, dynamic> matchMap = match.toJson();
        matchMap.addAll(cdObj);
        MatchEntity newMatch = MatchEntity.fromJson(matchMap);
        dataStoreController.updateMatch(newMatch);
      }
      // Map<String, dynamic> cdObj = wsObj['cd'];
      // String mid = cdObj['mid'];
      // String ctsp = wsObj['ctsp'];
    }
  }

  ///菜单栏顺序变更
  // {
  // "cd": {
  // "refreshAll": true
  // },
  // "cmd": "C3011",
  // "ctsp": "1612240060001",
  // "ld": "task_1612240060001"
  // }
  void C3011(Map<String, dynamic> wsObj) {
    if (wsObj != null) {
      Bus.getInstance().emit(EventType.RCMD_C3011, [wsObj]);
      // Map<String, dynamic> cdObj = wsObj['cd'];
      // String mid = cdObj['mid'];
      // String ctsp = wsObj['ctsp'];
    }
  }

  List<Map<String, dynamic>> getC8List(List<dynamic> matchList) {
    List<Map<String, dynamic>> list = [];
    matchList.forEach((item) {
      if (item != null) {
        String mid = item['mid'];
        String hpid = "*";
        if (item['hpids'] is List &&
            item['hpids'].length > 0 &&
            !item['hpids'].contains("*")) {
          hpid = item['hpids'].join(',');
        }
        Map<String, dynamic> obj = {'mid': mid, 'hpid': hpid, 'level': 3};
        list.add(obj);
      }
    });
    return list;
  }

  // void scmdC8() {
  //   if (dataStoreController.midsAtion.isNotEmpty) {
  //     List<dynamic> list =
  //         getMatchObjectFormListToObj(dataStoreController.midsAtion, 'Array');
  //     Map<String, dynamic> obj = {};
  //     obj['key'] = dataStoreController.nameCode;
  //     obj['module'] = 'match-ctr';
  //     obj['list'] = getC8List(list);
  //     obj['one_send'] = false;
  //     // obj['ctr_cmd'] = ctrCmd;
  //     obj['cufm'] = "L";
  //     if (dataStoreController.type == 'match') {
  //       obj['cufm'] = "LM";
  //       obj['one_send'] = true;
  //     }
  //     if (obj['list'].length > 0) {
  //       AppWebSocket.instance().skt_send_match_status(obj);
  //     }
  //   }
  // }

  void destroy() {
    microTimer?.cancel();
    microTimer = null;
  }
}
