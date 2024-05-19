import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/odds_info_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/odds_info/templates/temp8.dart';
import 'package:get/get.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../global/user_controller.dart';
import '../../../../routes/app_pages.dart';
import '../../../../services/api/match_detail_api.dart';
import '../../../../services/models/res/match_entity.dart';
import '../../../../widgets/loading.dart';
import '../../../../widgets/no_data.dart';
import '../../../../widgets/scroll_index_widget.dart';
import '../../constant/detail_constant.dart';
import '../../controllers/match_detail_controller.dart';
import '../../models/request_status.dart';
import 'odds_info/odds_item.dart';

/// 普通赛事投注列表 、赛果详情展示 、vr、dj投注列表
class OddsInfoContainer extends StatefulWidget {
  const OddsInfoContainer({Key? key, this.tag, this.refresh = false})
      : super(key: key);
  final String? tag;
  final bool refresh;

  @override
  State<OddsInfoContainer> createState() => _OddsInfoContainerState();
}

class _OddsInfoContainerState extends State<OddsInfoContainer> {
  final GlobalKey<AnimatedListState> oddsInfoListKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      left: false,
      right: false,
      child: GetBuilder<MatchDetailController>(
        tag: widget.tag,
        id: matchOddsInfoGetBuildId,
        initState: (_) {
          /// 初始化投注数据
          if (widget.refresh) {
            Get.find<MatchDetailController>(tag: widget.tag)
                .refreshOddsInfoData(refresh: widget.refresh);
          }
        },
        builder: (controller) {
          final detailState = controller.detailState;
          bool fullscreen = detailState.fullscreen.value;
          String route = Get.currentRoute;
          if (detailState.oddsInfoRequestStatus == RequestStatus.loading) {
            // 接口请求loading
            return const Loading();
          }

          /// 请求时网络错误
          else if (detailState.oddsInfoRequestStatus ==
              RequestStatus.noNetwork) {
            return NoData(
              fullscreen: fullscreen,
              top: 0,
              type: NoDataType.noWifi,

              /// 无网络时 三个接口都刷新
              onRefresh: () {
                Get.find<MatchDetailController>(tag: widget.tag).refreshData();
              },
            );
          }

          /// 数据为空或者请求失败
          else if (detailState.oddsInfoIsNoData ||
              detailState.oddsInfoRequestStatus == RequestStatus.fail) {
            // 赛果显示暂无数据
            String content = "";
            if (route == Routes.matchResultsDetails) {
              content = LocaleKeys.analysis_football_matches_no_data.tr;
              return NoData(
                fullscreen: fullscreen,
                content: content,
                top: 0,
                type: NoDataType.none,
              );
            } else {
              content = detailState.curCategoryTabId == "0"
                  ? "${LocaleKeys.detail_odd_closed.tr}\n\n${LocaleKeys.detail_no_way_bet.tr}"
                  : LocaleKeys.detail_odd_closed.tr;
            }
            return NoData(
              fullscreen: fullscreen,
              content: content,
              top: 0,
              type: NoDataType.oddsClosed,
            );
          }
          return ScrollIndexWidget(
            endCallBack: (bool endScroll) {
              detailState.endScroll = endScroll;
              // 停止滚动暂停gif
              try {
                if (endScroll) {
                  300.milliseconds.delay(() {
                    // 连续滚动加个缓冲
                    if (endScroll && !detailState.gifAnimatedStatus.value) {
                      detailState.gifController?.repeat();
                      detailState.gifAnimatedStatus.value = true;
                    }
                  });
                } else {
                  if ((detailState.gifController?.isAnimating ?? false) &&
                      detailState.gifAnimatedStatus.value) {
                    detailState.gifAnimatedStatus.value = false;
                    detailState.gifController?.stop(canceled: false);
                  }
                }
              } catch (e) {}
            },
            callBack: (int firstIndex, int lastIndex) {},
            child: AnimatedList(
              key: oddsInfoListKey,
              padding: EdgeInsets.only(
                  top: 8,
                  bottom: fullscreen
                      ? 0
                      : route != Routes.vrSportDetail
                          ? Get.mediaQuery.padding.bottom
                          : 0),
              initialItemCount: detailState.filterOddsInfoList.length,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, i, animation) {
                if (i >= detailState.filterOddsInfoList.length) {
                  return Container();
                }
                if (detailState.filterOddsInfoList[i] is MatchHps) {
                  return _buildItem(detailState.filterOddsInfoList[i],
                      animation, i, controller);
                } else {
                  // 虚拟体育增加热门 只在所有投注第一个
                  return Temp8(
                    item: detailState.vrHotEntity!,
                    match: detailState.match!,
                  );
                }
              },
            ),
          );

          // return ScrollIndexWidget(
          //   endCallBack: (bool endScroll) {
          //     detailState.endScroll = endScroll;
          //
          //     // if(endScroll){
          //     //   detailState.gifController.repeat();
          //     // }else{
          //     //
          //     //   detailState.gifController.stop();
          //     // }
          //     // print(detailState.gifController.status);
          //   },
          //   callBack: (int firstIndex, int lastIndex) {},
          //   // estimateCount: detailState.filterOddsInfoList.length,
          //   child: AnimatedListView(
          //     eventController: detailState.eventController,
          //     idMapper: (object) => object.hashCode.toString(),
          //     items: detailState.filterOddsInfoList,
          //     padding: EdgeInsets.only(
          //         top: 8,
          //         right: 0,
          //         left: 0,
          //         bottom: fullscreen
          //             ? 0
          //             : route != Routes.vrSportDetail
          //                 ? Get.mediaQuery.padding.bottom
          //                 : 0),
          //     itemBuilder: (item) {
          //       int i = detailState.filterOddsInfoList.indexOf(item);
          //       return detailState.filterOddsInfoList.safe(i) is MatchHps
          //           ? OddsItem(
          //               tag: widget.tag,
          //               item: detailState.filterOddsInfoList.safe(i),
          //               index: i,
          //               length: detailState.filterOddsInfoList.length,
          //               hasHotName: detailState.hasHotName,
          //               fullscreen: fullscreen,
          //             )
          //           : detailState.vrHotEntity != null && detailState.match != null
          //               ?
          //               // 虚拟体育增加热门 只在所有投注第一个
          //               Temp8(
          //                   item: detailState.vrHotEntity!,
          //                   match: detailState.match!,
          //                 )
          //               : Container();
          //     },
          //   ),
          // );
        },
      ),
    );
  }

  Widget _buildItem(MatchHps hps, Animation<double> animation, int index,
      MatchDetailController controller) {
    return SizeTransition(
      sizeFactor: animation,
      child: OddsItem(
        tag: widget.tag,
        item: hps,
        index: index,
        htonCallback: () => _setHton(hps, index, controller),
      ),
    );
  }

  _setHton(MatchHps hps, int index, MatchDetailController controller) {
    // 插入的索引
    int insertIndex = 0;
    if (hps.hton != "0") {
      // 取消置顶
      hps.hton = '0';
      // 先移除再计算
      controller.detailState.hHtonMap
          .remove("${hps.mid}_${hps.hpid}_${hps.topKey}");
      _removeItem(hps, index, controller);
      // 重新计算索引值
      controller.filterOddsInfo();
      insertIndex = controller.detailState.filterOddsInfoList.indexOf(hps);

      if (insertIndex >= 0) {
        controller.detailState.filterOddsInfoList.removeAt(insertIndex);
        _addItem(hps, controller, insertIndex);
      }
    } else {
      // vr置顶在热门投注下
      if (controller.detailState.hasHotName) {
        insertIndex = 1;
      }
      // // vr置顶在热门投注下
      // if (detailState.hasHotName) {
      //   newIndex = 1;
      // }
      // 使用时间排序
      hps.hton = DateTime.now().millisecondsSinceEpoch.toString();
      controller.detailState.hHtonMap["${hps.mid}_${hps.hpid}_${hps.topKey}"] =
          hps.hton;
      _removeItem(hps, index, controller);
      _addItem(hps, controller, insertIndex);
    }

    2.delay(() {
      String status = hps.hton != "0" ? "0" : "1",
          playId = hps.hpid,
          matchId = controller.detailState.mId,
          cuid = UserController.to.getUid(),
          // 玩法置顶接口增加topKey字段
          topKey = hps.topKey;
      MatchDetailApi.instance().playTop(status, playId, matchId, cuid, topKey);
    });
  }

  void _addItem(
      MatchHps hps, MatchDetailController controller, int insertIndex) async {
    controller.detailState.filterOddsInfoList.insert(insertIndex, hps);
    oddsInfoListKey.currentState!.insertItem(insertIndex);
  }

  void _removeItem(
      MatchHps hps, int index, MatchDetailController controller) async {
    oddsInfoListKey.currentState!.removeItem(index,
        (context, animation) => _buildItem(hps, animation, index, controller));
    controller.detailState.filterOddsInfoList.removeAt(index);
  }
}
