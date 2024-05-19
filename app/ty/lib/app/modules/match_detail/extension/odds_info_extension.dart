import 'dart:async';

// import 'package:animated_scroll_view/animated_scroll_view.dart';
import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_map_operate.dart';
import 'package:flutter_ty_app/app/global/user_controller.dart';
import 'package:get/get.dart';

import '../../../global/data_store_controller.dart';
import '../../../routes/app_pages.dart';
import '../../../services/api/match_detail_api.dart';
import '../../../services/api/result_api.dart';
import '../../../services/models/res/api_res.dart';
import '../../../services/models/res/category_list_entity.dart';
import '../../../services/models/res/match_entity.dart';
import '../../../services/models/res/vr_hot_entity.dart';
import '../../../utils/utils.dart';
import '../constant/detail_constant.dart';
import '../controllers/match_detail_controller.dart';
import '../models/bet_item_collection.dart';
import '../models/request_status.dart';

/// 投注数据逻辑
extension OddsInfoLogic on MatchDetailController {
  /// refresh->true->请求接口 ws调时showType = 2 ; isVrGameEnd vr赛事结束状态
  Future<void> refreshOddsInfoData(
      {bool refresh = false,
      bool noLoading = false,
      int? showType,
      bool isVrGameEnd = false}) async {
    if (detailState.oddsInfoList.isNotEmpty) {
      detailState.oddsInfoIsNoData = false;
    }

    if (refresh ||
        detailState.oddsInfoList.isEmpty ||
        detailState.mId != detailState.oddsInfoList[0].mid) {
      String mid = detailState.mId;
      try {
        ApiRes<List<dynamic>> res;
        if (!noLoading) {
          // ws推送静默刷新
          detailState.oddsInfoRequestStatus = RequestStatus.loading;
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            update([matchOddsInfoGetBuildId, matchBetModeTabGetBuildId]);
          });
        }

        String route = Get.currentRoute;
        // 普通赛事赛果
        if (route == Routes.matchResultsDetails) {
          res = await ResultApi.instance().getMatchResult(
              0, mid, createGcuuid(), detailState.isDJDetail ? "1" : null);
        }
        // vr虚拟体育
        else if (route == Routes.vrSportDetail) {
          if (isVrGameEnd) {
            // vr体育赛事赛果
            res =
                await MatchDetailApi.instance().getVirtualMatchResult("0", mid);
          } else {
            res = await MatchDetailApi.instance()
                .getVirtualMatchOddsInfo("0", mid, createGcuuid(), 2);
          }
        } else {
          if (detailState.isDJDetail) {
            // 电竞
            res = await MatchDetailApi.instance()
                .getESMatchOddsInfo("0", mid, createGcuuid(), showType);
          } else {
            // 普通详情
            res = await MatchDetailApi.instance()
                .getMatchOddsInfo1("0", mid, createGcuuid(), showType);
          }
        }
        dataHandle(res, noLoading);
      } on DioException catch (e) {
        detailState.oddsInfoRequestStatus = RequestStatus.noNetwork;
        // 捕获 DioError
        // if (e.type == DioExceptionType.connectionTimeout ||
        //     e.type == DioExceptionType.receiveTimeout) {
        //   // 这里是处理连接超时或接收超时的逻辑，通常表示网络连接有问题
        //   detailState.oddsInfoRequestStatus = RequestStatus.noNetwork;
        // } else {
        //   // 其他类型的错误
        // }
      } catch (e) {
        // if (!noLoading) {
        //   detailState.oddsInfoRequestStatus = RequestStatus.fail;
        // }
      } finally {
        if (detailState.oddsInfoList.isEmpty) {
          detailState.oddsInfoIsNoData = true;
        } else {
          detailState.oddsInfoIsNoData = false;
        }

        // 兜底 loading还存在 、原始投注数据为空 置为网络错误
        if (detailState.oddsInfoRequestStatus == RequestStatus.loading &&
            detailState.oddsInfoList.isEmpty) {
          detailState.oddsInfoRequestStatus = RequestStatus.noNetwork;
        }
      }
    }

    filterOddsInfo();

    /// ws推送->滚动->不更新
    if (showType == 2) {
      if (detailState.endScroll) {
        update([matchOddsInfoGetBuildId, matchBetModeTabGetBuildId]);
      }
    } else {
      update([matchOddsInfoGetBuildId, matchBetModeTabGetBuildId]);
    }
    // if (!detailState.fullscreen.value) {
    //   update([matchOddsInfoGetBuildId, matchBetModeTabGetBuildId]);
    // } else {
    //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //     update([matchOddsInfoGetBuildId, matchBetModeTabGetBuildId]);
    //   });
    // }
  }

  dataHandle(ApiRes<List<dynamic>> res, bool noLoading) {
    detailState.oddsInfoRequestStatus = RequestStatus.success;
    if (res.success) {
      if (ObjectUtil.isEmptyList(res.data)) {
        if (!noLoading) {
          // ws 可能推送 {"code":"0000000","data":[],"msg":"成功","ts":1712542534494} 但是其实是有数据 这里不能关盘
          detailState.oddsInfoIsNoData = true;
          // update([matchOddsInfoGetBuildId, matchBetModeTabGetBuildId]);
        }
        return;
      }
      detailState.oddsInfoIsNoData = false;
      detailState.oddsInfoRequestCount = 0;
      if (!ObjectUtil.isEmptyList(res.data)) {
        // vr体育热门特殊处理
        if (res.data?[0]['hotName'] != null) {
          detailState.vrHotEntity = VrHotEntity.fromJson(res.data![0]);

          /// 热门投注注入
          // for (MatchHps hps in detailState.vrHotEntity?.plays ?? []) {
          //   List<MatchHpsHl> hls = hps.hl;
          //   for (MatchHpsHl hl in hls) {
          //     DataStoreController.to.updateHl(hl);
          //     List<MatchHpsHlOl> ols = hl.ol;
          //     for (MatchHpsHlOl ol in ols) {
          //       //区分列表还是详情
          //       ol.isDetail = true;
          //       DataStoreController.to.updateOl(ol);
          //     }
          //   }
          // }
          res.data!.removeAt(0);
        }
      }
      List<MatchHps> temp =
          EntityFactory.generateOBJ<List<MatchHps>>(res.data) ?? [];

      // 原始所有投注数据
      detailState.oddsInfoList = temp;

      /// 更新数据仓库
      for (MatchHps hps in detailState.oddsInfoList) {
        // index 用与取消置顶返回的位置
        hps.index = detailState.oddsInfoList.indexOf(hps);
        // 设置置顶缓存 保存在db
        if (detailState.hHtonMap["${hps.mid}_${hps.hpid}_${hps.topKey}"] !=
            null) {
          hps.hton =
              detailState.hHtonMap["${hps.mid}_${hps.hpid}_${hps.topKey}"]!;
        }

        // 展开收起状态 保存在controller
        if (detailState.hShowMap["${hps.hpid}_${hps.topKey}"] != null) {
          hps.hshow = detailState.hShowMap["${hps.hpid}_${hps.topKey}"]!;
        }

        List<MatchHpsHl> hls = hps.hl;
        hps.collection = [];
        hps.otherCollection = [];
        for (MatchHpsHl hl in hls) {
          DataStoreController.to.updateHl(hl);
          List<MatchHpsHlOl> ols = hl.ol;

          for (MatchHpsHlOl ol in ols) {
            //区分列表还是详情
            ol.isDetail = true;
            DataStoreController.to.updateOl(ol);

            /// 投注项生成
            getCollection(ol, hl, hps);
          }
        }
      }
      // chpids处理
      detailState.chpids.clear();
      detailState.oddsInfoList.forEach((MatchHps item) {
        detailState.chpids[item.chpid] = item.chpid;
      });
    }
    // update([matchOddsInfoGetBuildId, matchBetModeTabGetBuildId]);
  }

  /// 玩法集切换
  changeCategoryTab(String tabId) {
    // 点中自己
    if (detailState.curCategoryTabId == tabId) return;
    detailState.curCategoryTabId = tabId;
    refreshOddsInfoData();
    // if (detailState.getFewer.value == 3) {
    //   detailState.getFewer.value == 1;
    // }
    // update([matchBetModeTabGetBuildId]);
  }

  /// 一键折叠、打开
  changeBtn() {
    String route = Get.currentRoute;

    // if(route != Routes.matchResultsDetails){
    //     // 没有玩法数据时不能点击
    //     if (detailState.categoryList.length <= 1 &&
    //     detailState.curCategoryTabId == "0") {
    //     return;
    //     }
    // }

    if (detailState.getFewer.value == 1 || detailState.getFewer.value == 3) {
      detailState.getFewer.value = 2;
    } else {
      detailState.getFewer.value = 1;
    }
    // 一键收起状态：1、全展开 2、全收起 3、部分展开 2和3箭头向上 针对全局

    if (route == Routes.matchResultsDetails) {
      detailState.oddsInfoList.forEach((element) {
        detailState.getFewer.value == 1
            ? element.hshow = "Yes"
            : element.hshow = "No";
        detailState.toggleAnimate = true;
        detailState.hShowMap["${element.hpid}_${element.topKey}"] =
            element.hshow;
        // update(["hpid_${element.hpid}_${element.topKey}"]);
      });
    } else {
      getOddsInfoFilter(detailState.oddsInfoList).forEach((element) {
        detailState.getFewer.value == 1
            ? element.hshow = "Yes"
            : element.hshow = "No";
        detailState.hShowMap["${element.hpid}_${element.topKey}"] =
            element.hshow;
        detailState.toggleAnimate = true;
        // update(["hpid_${element.hpid}_${element.topKey}"]);
      });
    }
    update([matchOddsInfoGetBuildId]);
  }

  /// 列表项折叠展开
  setHShow(MatchHps item) {
    // 部分折叠
    detailState.getFewer.value = 3;
    detailState.toggleAnimate = true;
    if (item.hshow == "Yes") {
      item.hshow = "No";
    } else {
      item.hshow = "Yes";
    }
    detailState.hShowMap["${item.hpid}_${item.topKey}"] = item.hshow;
    update(["hpid_${item.hpid}_${item.topKey}"]);
  }

  /// 列表项置顶
  setHton(MatchHps item) {
    // if (!checkItemIdExists(item.hpid)) return;
    int newIndex = 0;
    if (item.hton != "0") {
      // 取消置顶
      item.hton = '0';
      newIndex = item.index;
      detailState.hHtonMap.remove("${item.mid}_${item.hpid}_${item.topKey}");
    } else {
      // // vr置顶在热门投注下
      // if (detailState.hasHotName) {
      //   newIndex = 1;
      // }
      // 使用时间排序
      item.hton = DateTime.now().millisecondsSinceEpoch.toString();
      detailState.hHtonMap["${item.mid}_${item.hpid}_${item.topKey}"] =
          item.hton;
    }
    // refreshOddsInfoData();
    // update([matchOddsInfoGetBuildId]);

    // int totalLength = detailState.filterOddsInfoList.length;

    /// AnimatedListView bug 最后一项置顶后，取消置顶最后一项消失 特殊处理
    // if (newIndex == (totalLength - 1) && item.hton == "0") {
    //   insert(item, totalLength);
    //   delete(item);
    // } else {
    //   detailState.eventController.add(
    //     MoveAdaptiveItemEvent.byId(
    //       itemId: item.hashCode.toString(),
    //       newIndex: newIndex,
    //     ),
    //   );
    // }

    2.delay(() {
      String status = item.hton != "0" ? "0" : "1",
          playId = item.hpid,
          matchId = detailState.mId,
          cuid = UserController.to.getUid(),
          // 玩法置顶接口增加topKey字段
          topKey = item.topKey;
      MatchDetailApi.instance().playTop(status, playId, matchId, cuid, topKey);
    });
  }

  // delete(MatchHps item) {
  //   detailState.eventController.add(
  //     RemoveAdaptiveItemEvent.byId(
  //       itemId: item.hashCode.toString(),
  //     ),
  //   );
  // }
  //
  // insert(MatchHps item, int index) {
  //   detailState.eventController.add(
  //     InsertAdaptiveItemEvent(
  //       item: item,
  //       index: index,
  //     ),
  //   );
  // }

  compareToValue(value) {
    if (value == 0) {
      return null;
    }
    return value;
  }

  ///@description WS推送C105(C106)更新足球基准分
  ///@param {Object} C105(C106)推送过来的盘口数据集合
  ///@return {Undefined}
  //         "hid": "143594241848119843",
  //         "hmt": 0,
  //         "hn": 2,
  //         "hpid": "4",
  //         "hps": "S1|2:0",
  //         "hs": 0,
  //         "mid": "3324785",
  //         "ol": [ ... ],
  //         "t": "1712150269611"
  //       }
  // todo 需要优化
  updateItemScore(List<dynamic> hls) {
    hls.forEach((hl) {
      String hpid = hl['hpid'] ?? "";
      String hps = hl['hps'] ?? "";
      String hid = hl['hid'] ?? "";
      detailState.oddsInfoList
          .where((element) => element.hpid == hpid)
          .toList()
          .forEach((element) {
        int index = detailState.oddsInfoList.indexOf(element);
        // 15分钟进球-让球({a}-{b})   15分钟角球-让球({a}-{b})
        if (["232", "33"].contains(element.hpid)) {
          if (hps != "" && hpid == element.hpid && hid == element.hid) {
            detailState.oddsInfoList.safe(index)?.hps = hps;
            update(["hpid_${element.hpid}_${element.topKey}"]);
            // print("更新足球基准分hpid_${element.hpid}");
          }
        } else {
          // 这4个玩法对应C103比分集合更新比分，不对应C105
          bool flag = ["32", "34", "231", "233"].contains(element.hpid);
          if (hps != "" && element.hpid == hpid && !flag) {
            detailState.oddsInfoList.safe(index)?.hps = hps;
            update(["hpid_${element.hpid}_${element.topKey}"]);
            // print("更新足球基准分2hpid_${element.hpid}");
          }
        }
      });
    });
  }

  // 列表子项收缩状态
  void listItemAddCustomAttr(MatchHps hps, int playlistLength) {
    // 附加盘收缩
    // playlist_length:单个玩法集下的玩法数量存在而且玩法数量小于11 Vr体育
    if (playlistLength < 11 && Get.currentRoute == Routes.vrSportDetail) {
      hps.hshow = 'Yes';
    }
    // 一键收起状态 1 全展开 2全收齐 3部分展开 1和3箭头向上
    if (detailState.getFewer.value == 2) {
      hps.hshow = 'No';
    }
    if (detailState.getFewer.value == 1) {
      hps.hshow = 'Yes';
    }
  }

  getCollection(MatchHpsHlOl ol, MatchHpsHl hl, MatchHps hps) {
    var item = BetItemCollection(
      ol: ol,
      hl: hl,
    );
    if (hps.hpt == 4) {
      // 波胆
      // 去除其他项 以及 os=3需要隐藏投注项
      if (ol.ot != 'Other' && ol.os != 3) {
        hps.collection.add(item);
      }
      // 构建其他项
      if (ol.ot == 'Other') {
        // 合并数据，根据id去重
        hps.otherCollection.addIf(
            !hps.otherCollection.any((element) => element == item), item);
      }
    } else if (hps.hpt == 5) {
      hps.collection.add(item);
      // 其他or平局
      if (ol.otd == 0) {
        hps.otherCollection.add(item);
      }
    } else if (hps.hpt == 6) {
      hps.collection.add(item);
      //  /// 其他 底部横向一列
      if (ol.otd == -1) {
        hps.otherCollection.addIf(
            !hps.otherCollection.any((element) => element == item), item);
      }
    } else if (hps.hpt == 14) {
      hps.collection.add(item);
      // 玩法ID:353(独赢 & 最先进球球队) [无进球]投注项的otd
      if (ol.otd == 1130) {
        // 合并数据，根据id去重
        hps.otherCollection.add(item);
      }
    } else {
      hps.collection.add(item);
    }
  }

  /// 获取tab切换的玩法集，根据玩法集plays对应到所有数据hpid即可过滤数据。
  List<MatchHps> getOddsInfoFilter(List<MatchHps> allData) {
    // 置顶筛选 降序
    // List<MatchHps> htonList = allData
    //     .where((element) => element.hton != "0" || element.hton != "")
    //     .toList();
    // allData.removeWhere((element) => element.hton != "0" || element.hton != "");
    // allData.sort((a, b) {
    //   return a.index.compareTo(b.index);
    // });
    // print("置顶列表");
    // print(htonList);
    // if (htonList.isNotEmpty) {
    //   htonList.sort((a, b) {
    //     int aHton = int.tryParse(a.hton) ?? 0;
    //     int bHton = int.tryParse(b.hton) ?? 0;
    //     return bHton.compareTo(aHton);
    //   });
    //   allData.insertAll(0, htonList);
    // }

    final mcid = detailState.curCategoryTabId;
    CategoryListData? findItem = detailState.categoryList.firstWhereOrNull(
      (item) => item.id == mcid,
    );
    List<MatchHps> res = [];

    if (findItem != null) {
      List<int> plays = findItem.plays;
      int round = findItem.round ?? -1;

      res = allData.where((item) {
        // 电竞需要判断第一局和第二局的原因，需要加上chpid判断
        if (detailState.isDJDetail) {
          if (round > 0) {
            return plays.contains(int.parse(item.hpid)) &&
                (detailState.chpids['${item.hpid}-$round'] == item.chpid ||
                    item.chpid == item.hpid);
          } else {
            // 所有投注
            return plays.contains(int.parse(item.hpid));
          }
        } else {
          return plays.contains(int.parse(item.hpid));
        }
      }).toList();
    } else {
      // 没有找到tab对应项 重置为所有投注
      // detailState.curCategoryTabId = "0";

      res = [...allData];
    }
    // 赛果详情返回全部
    if (Routes.matchResultsDetails == Get.currentRoute) {
      res = [...allData];
    }
    // 兜底取全部
    if (res.isEmpty) {
      // detailState.curCategoryTabId = "0";
      res = [...allData];
    }

    // 置顶非置顶
    return [...listSortNew(res), ...listSortNormal(res)];
  }

  // 非置顶的玩法项冒泡排序
  List<MatchHps> listSortNormal(List<MatchHps> hpsList) {
    List<MatchHps> listNormal = [];
    for (var i = 0; i < hpsList.length; i++) {
      if (hpsList[i].hton == '0') {
        listNormal.add(hpsList[i]);
      }
    }
    if (listNormal.isNotEmpty) {
      var len = listNormal.length - 1;
      for (var i = 0; i < len; i++) {
        for (var k = 0; k < len - i; k++) {
          if (listNormal[k].hpon > listNormal[k + 1].hpon) {
            MatchHps t = listNormal[k];
            listNormal[k] = listNormal[k + 1];
            listNormal[k + 1] = t;
          }
        }
      }
    }
    return listNormal;
  }

  //  冒泡排序(原来地址顺序不发生变化---保持原来的顺序不变,返回新的列表但是子项使用原来的地址)
  List<MatchHps> listSortNew(List<MatchHps> hpsList) {
    List<MatchHps> listTop = [];
    for (var i = 0; i < hpsList.length; i++) {
      if (hpsList[i].hton != "0") {
        listTop.add(hpsList[i]);
      }
    }
    if (listTop.isNotEmpty) {
      var len = listTop.length - 1;

      for (var i = 0; i < len; i++) {
        for (var k = 0; k < len - i; k++) {
          if ((int.tryParse(listTop[k].hton) ?? 0) <
              (int.tryParse(listTop[k + 1].hton) ?? 0)) {
            MatchHps t = listTop[k];
            listTop[k] = listTop[k + 1];
            listTop[k + 1] = t;
          }
        }
      }
    }
    return listTop;
  }

  void filterOddsInfo() {
    String route = Get.currentRoute;
    detailState.filterOddsInfoList.clear();

    if (route == Routes.matchResultsDetails) {
      // 赛果不进行筛选，显示全部
      detailState.filterOddsInfoList
          .addAll(getOddsInfoFilter(detailState.oddsInfoList));
      detailState.hasHotName = false;
    } else if (route == Routes.vrSportDetail &&
        detailState.vrHotEntity != null &&
        detailState.match != null &&
        detailState.curCategoryTabId == "0") {
      // detailState.filterOddsInfoList
      //     .addAll(detailState.vrHotEntity?.plays ?? []);
      // vr体育注入热门投注
      detailState.filterOddsInfoList.add(detailState.vrHotEntity);
      detailState.filterOddsInfoList
          .addAll(getOddsInfoFilter(detailState.oddsInfoList));
      detailState.hasHotName = true;
    } else {
      detailState.filterOddsInfoList
          .addAll(getOddsInfoFilter(detailState.oddsInfoList));
      detailState.hasHotName = false;
    }

    // 盘口收缩
    detailState.filterOddsInfoList.forEach((hps) {
      if (hps is MatchHps) {
        listItemAddCustomAttr(hps, detailState.filterOddsInfoList.length);
      }
    });
  }
}
