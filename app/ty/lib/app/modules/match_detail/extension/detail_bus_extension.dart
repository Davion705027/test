import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/extension/map_extension.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_map_operate.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_detail_controller.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/odds_info_extension.dart';
import 'package:get/get.dart';

import '../../../global/data_store_controller.dart';
import '../../../global/ws/ws_type.dart';
import '../../../routes/app_pages.dart';
import '../../../services/models/res/match_entity.dart';
import '../../../utils/bus/bus.dart';
import '../../../utils/bus/event_enum.dart';
import '../../../utils/debounce_throttle.dart';
import '../constant/detail_constant.dart';

/// ws推送
extension DetailBusExtension on MatchDetailController {
  /// 处理ws指令 与返回来的数据
  /// `ms` 赛事状态 0:未开赛 1:赛事进行中  2:暂停 3:结束 4:关闭 5:取消 6:比赛放弃 7:延迟 8:未知 9:延期 10:比赛中断 110:即将开赛
  ///  `mmp` 赛事阶段
  ///  赛事结束标志 mmp=999 || ms = "比赛结束"  mhs=2 关盘 移除赛事
  ///  `mhs` 赛事级别盘口状态（0:active 开盘, 1:suspended 封盘, 2:deactivated 关盘 ,11:锁盘状态）
  ///  c303  拉取所有数据
  ///  "C101","C102","C104","C109","C302","C303"
  ///  "C102"  获取玩法集 获取盘口信息
  ///  "C109"  获取玩法集 获取盘口信息
  ///  "C112"  获取玩法集 获取盘口信息
  ///  "C303"  获取盘口信息 新增玩法/新增盘口/主主盘变更
  initBus() {
    var fetchCategoryThrottle = throttle(() {
      fetchCategoryList();
    }, const Duration(milliseconds: 1500));

    var fetchOddsInfoThrottle = throttle(() {
      refreshOddsInfoData(refresh: true, noLoading: true, showType: 2);
    }, const Duration(milliseconds: 1500));

    //C101, C102, C103, C104, C107
    Bus.getInstance().on(EventType.updata_detail_data, (data) {
      Map<String, dynamic> map =
          (data as List).safeFirst as Map<String, dynamic>;
      String cmd = map['cmd'];

      if (!filterDifferentMatch(data)) {
        return;
      }

      switch (cmd) {
        case WsType.C101:
          // >>>>C101 赛事状态
          // {
          //     "cd": {
          //         "mid": "639633",
          //         "ms": 3
          //     },
          //     "cmd": "C101",
          //     "ctsp": "1580714665510"
          // }
          Map<String, dynamic> cd = map['cd'];
          String mid = cd['mid'];
          int ms = int.tryParse(cd['ms'].toString()) ?? -1;
          int oldMs = int.tryParse(cd['oldMs'].toString()) ?? -1;

          // 监听赛事状态ms的值，0:未开赛 1:滚球阶段 2:暂停 3:结束 4:关闭 5:取消 6:比赛放弃 7:延迟 8:未知 9:延期 10:比赛中断 110:即将开赛
          List<int> arrMs = [0, 1, 2, 7, 10, 110];
          debugPrint("赛事状态变化");
          debugPrint(ms.toString());
          if (!arrMs.contains(ms)) {
            eventSwitch();
          }
          // 赛事状态为 0:未开赛 1:滚球阶段 2:暂停 7:延迟 10:比赛中断 110:即将开赛 时更新玩法集
          else {
            // ms变更时才调用
            if (ms != oldMs) {
              // 重新调用 赛事详情页面接口(/v1/m/matchDetail/getMatchDetailPB)
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                fetchMatchDetailData();
                // detailState.throttleOddsListSubject.add(null);
                fetchCategoryThrottle();
              });
            }
          }
          break;
        case WsType.C102:
          // RCMD_C102(map['cd']);
          Map<String, dynamic> cd = map['cd'];
          if (cd.get('mmp').toString() == "999") {
            //切换赛事
            eventSwitch();
          } else {
            // 赛事mmp变更
            if (detailState.match?.mmp != cd.get('mmp').toString()) {
              // detailState.throttleOddsListSubject.add(null);
              fetchCategoryThrottle();
            }
          }
          break;
        case WsType.C103:
          break;
        case WsType.C104:
          Map<String, dynamic> cd = map['cd'];
          int mhs = int.tryParse(cd['mhs'].toString()) ?? -1;
          // 赛事级别盘口状态 0:active 开, 1:suspended 封, 2:deactivated 关, 11:锁
          if (mhs == 0 || mhs == 11) {
            // 重新拉取数据;
            // 重新拉取数据; 因为
            // 玩法集tab
            // detailState.throttleRCMD303Subject.add(null);
            // detailState.throttleOddsListSubject.add(null);
            fetchCategoryThrottle();
            fetchOddsInfoThrottle();
            // useMittEmit(MITT_TYPES.EMIT_GET_ODDS_LIST)
            // useMittEmit(MITT_TYPES.EMIT_MATCH_DETAIL_SOCKET)
          } else if (mhs == 1) {
            // 设置盘口状态
          } else if (mhs == 2) {
            // 关盘
            closeOrder();
          }
          break;
        case WsType.C107:
          // 动画、视频源
          break;
        default:
          break;
      }
      // c102 list
      // [{cd: {csid: 1, mid: 3336827, mpid: 6, msc: [S1|0:2, S2|0:2, S5|2:1, S6|0:0, S8|0:0, S10|0:0, S11|0:0, S12|0:0, S13|0:0, S14|0:0, S15|2:1, S17|0:0, S18|0:0, S104|0:0, S105|0:0, S555|2:1, S1001|0:2, S1002|0:0, S1003|0:0, S1004|0:0, S1005|0:0, S1006|0:0, S1101|0:0, S5001|2:1, S5002|0:0, S5003|0:0, S5004|0:0, S5005|0:0, S5006|0:0, S10011|0:2, S10013|0:0, S10021|0:0, S10101|0:0, S10102|0:0, S10103|0:0, S11001|0:0, S12001|0:0, S50011|0:0, S50012|0:0]}, cmd: C103, ctsp: 1711358681195, ld: PD_1404c314-de99-40ee-92ea-7df23ebacac6}]
    });

    /// 更新玩法集和投注数据
    Bus.getInstance().on(EventType.init302, (data) {
      // 滚动时 ws 的http

      if (data.contains(detailState.mId)) {
        fetchCategoryThrottle();
        fetchOddsInfoThrottle();
      }
    });
    Bus.getInstance().on(EventType.RCMD_C109, (List data) {
      bool find = false;
      int index = -1;
      data.forEach((element) {
        String mId = element['mid'];
        int i = data.indexOf(element);
        if (mId == detailState.mId) {
          find = true;
          index = i;
        }
      });
      if (find) {
        fetchCategoryThrottle();
        fetchOddsInfoThrottle();
      }
    });

    // C112 玩法集变更
    Bus.getInstance().on(EventType.socketOddinfo, (data) {
      if (data.contains(detailState.mId)) {
        /// hanmer说只拉玩法集接口
        // detailState.throttleRCMD303Subject.add(null);
        // detailState.throttleOddsListSubject.add(null);
        fetchCategoryThrottle();
      }
    });
    Bus.getInstance().on(EventType.RCMD_C110, (data) {
      Map<String, dynamic> map =
          (data as List).safeFirst as Map<String, dynamic>;
      if (filterDifferentMatch(data)) {
        RCMD_C110(map['cd']);
      }
    });
    Bus.getInstance().on(EventType.RCMD_C105, (data) {
      Map<String, dynamic> map =
          (data as List).safeFirst as Map<String, dynamic>;
      if (filterDifferentMatch(data)) {
        RCMD_C105(map['cd']);
      }
    });
    Bus.getInstance().on(EventType.nativeDetailData, (data) {
      if (isClosed) {
        return;
      }
      setNativeDetailData(data);
    });

    /// 关盘切换赛事
    Bus.getInstance().on(EventType.removeMatch, (value) {
      // if (value == detailState.mId) {
      //   1.seconds.delay(() {
      //     eventSwitch();
      //   });
      // }
    });

    /// vr体育赛事结束
    Bus.getInstance().on(EventType.VRDetailEnd, (value) {
      if (Get.currentRoute == Routes.vrSportDetail) {
        detailState.vrLockStatus = false;
        refreshOddsInfoData(refresh: true, isVrGameEnd: true);
      }
    });

    /// vr体育锁盘
    Bus.getInstance().on(EventType.VRDetailClose, (data) {
      if (Get.currentRoute == Routes.vrSportDetail) {
        MatchEntity? match =
            DataStoreController.to.getMatchById(detailState.mId);
        if (match != null && !detailState.vrLockStatus) {
          detailState.vrLockStatus = true;
          // vr体育特殊玩法
          if (detailState.vrHotEntity != null) {
            detailState.vrHotEntity!.plays.forEach((item) {
              item.hl.forEach((hl) {
                hl.ol.forEach((ol) {
                  ol.os = 2;
                });
              });
            });
          }
          detailState.oddsInfoList.forEach((item) {
            item.hl.forEach((hl) {
              hl.ol.forEach((ol) {
                ol.os = 2;
              });
            });
          });

          update([matchOddsInfoGetBuildId]);
        }
      }
    });
  }

  /// 过滤赛事
  bool filterDifferentMatch(data) {
    Map<String, dynamic> map = (data as List).safeFirst as Map<String, dynamic>;
    // String cmd = map['cmd'];
    try {
      Map<String, dynamic> cd = map['cd'] as Map<String, dynamic>;
      if (cd.get('mid') == detailState.mId) {
        return true;
      }
    } catch (e) {
      List<dynamic> cd = map['cd'] as List<dynamic>;
      bool find = false;
      cd.forEach((element) {
        String mId = element['mid'];
        if (mId == detailState.mId) {
          find = true;
        }
      });
      return find;
    }
    return false;
  }

  RCMD_C303() {
    // 玩法集tab
    // fetchOddsListData();
    // todo 玩法集 目前是全部 vue是当个tab下的oddsinfo
    refreshOddsInfoData(refresh: true, noLoading: true, showType: 2);
  }

  RCMD_C302(Map<String, dynamic> cd) {
    // 赛事更新
    // if(cd.get('mmp') == 999 || cd.get('mmp') == 3) useMittEmit(MITT_TYPES.EMIT_SET_REMOVE_SESSION_STORAGE);
    // useMittEmit(MITT_TYPES.EMIT_GET_ODDS_LIST)
    // useMittEmit(MITT_TYPES.EMIT_MATCH_DETAIL_SOCKET,() => {
    // matchDetailClass.set_flag_get_ol_list(Math.random());
    // })
  }

  /// 赛事级别盘口状态(C104)  hs: 0:active 开盘, 1:suspended 封盘, 2:deactivated 关盘,11:锁盘状态
  RCMD_C104(Map<String, dynamic> cd) {
    // int mhs = cd.get('mhs');
    // // 赛事级别盘口状态 0:active 开, 1:suspended 封, 2:deactivated 关, 11:锁
    // if (mhs == 0 || mhs == 11) {
    //   // 重新拉取数据;
    //   // 重新拉取数据; 因为
    //   // 玩法集tab
    //   // detailState.throttleRCMD303Subject.add(null);
    //   // detailState.throttleOddsListSubject.add(null);
    //   fetchCategoryThrottle();
    //   fetchOddsInfoThrottle();
    //   // useMittEmit(MITT_TYPES.EMIT_GET_ODDS_LIST)
    //   // useMittEmit(MITT_TYPES.EMIT_MATCH_DETAIL_SOCKET)
    // } else if (mhs == 1) {
    //   // 设置盘口状态
    // } else if (mhs == 2) {
    //   // 关盘
    //   closeOrder();
    // }
  }

  // 切换赛事
  RCMD_C102(Map<String, dynamic> cd) {
    if (cd.get('mmp').toString() == "999") {
      //切换赛事
      eventSwitch();
    } else {
      // 赛事mmp变更
      if (detailState.match?.mmp != cd.get('mmp').toString()) {
        detailState.throttleOddsListSubject.add(null);
      }
    }
  }

  /// RCMD_C110 锁盘 mc==0
  RCMD_C110(Map<String, dynamic> cd) {
    if (cd.get('mc') == 0) {
      // closeOrder();
    }
  }

  /// 处理玩法更新
  RCMD_C105(Map<String, dynamic> cd) {
    if (ObjectUtil.isNotEmpty(cd.get('hls'))) {
      // matchDetailClass.set_flag_get_ol_list(Math.random());
    }
    // 足球赛事投注玩法，基准分的动态更新
    try {
      if (cd.containsKey("hls") && cd['hls'] != null) {
        List<dynamic> hls = cd['hls'] as List<dynamic>;
        // useMittEmit(MITT_TYPES.EMIT_CHANGE_BASE_SCORE, obj.cd.hls)
        updateItemScore(hls);
      }
    } catch (err) {
      print("RCMD_C105 " + err.toString());
      print(cd.toString());
    }
  }

  disposeBus() {
    // 订阅
    Bus.getInstance().off(EventType.updata_detail_data);
    Bus.getInstance().off(EventType.init302);
    Bus.getInstance().off(EventType.RCMD_C109);
    Bus.getInstance().off(EventType.socketOddinfo);
    Bus.getInstance().off(EventType.RCMD_C110);
    Bus.getInstance().off(EventType.RCMD_C105);
    Bus.getInstance().off(EventType.removeMatch);
    Bus.getInstance().off(EventType.nativeDetailData);
    Bus.getInstance().off(EventType.VRDetailClose);
    Bus.getInstance().off(EventType.VRDetailEnd);
  }
}
