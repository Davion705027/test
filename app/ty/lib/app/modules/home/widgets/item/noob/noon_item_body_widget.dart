import 'dart:collection';

import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/core/format/common/module/format-score.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_map_operate.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/item/flag_widget.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/utils/match_util.dart';

import '../../../../../../generated/locales.g.dart';
import '../../../../../services/models/res/match_entity.dart';
import '../../../../../utils/csid_util.dart';
import '../../../../../utils/format_score_util.dart';
import '../../../../../utils/utils.dart';
import '../../../../match_detail/widgets/container/odds_info/odds_button.dart';
import '../../../controllers/collection_controller.dart';
import '../../../models/combine_info.dart';
import '../counting-down/counting-down.dart';
import '../profession/score_list.dart';

/*
* 新手版 赛事列表条目
* */
class NoobItemBodyWidget extends StatelessWidget {
  const NoobItemBodyWidget(
      {super.key, required this.matchEntity, required this.combineType});

  final MatchEntity matchEntity;
  final CombineType combineType;

  @override
  Widget build(BuildContext context) {
    DataStoreController controller = DataStoreController.to;
    return GetBuilder<DataStoreController>(
      id: controller.getMatchId(matchEntity.mid),
      builder: (logic) {
        MatchEntity match =
            controller.getMatchById(matchEntity.mid) ?? matchEntity;
        return RepaintBoundary(
          child: InkWell(
            onTap: () async {
              final res = await Get.toNamed(Routes.matchDetail, arguments: {
                'mid': match.mid,
                'csid': match.csid,
              });
              HomeController.to.fetchData(isWsFetch: true);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal:
                            combineType == CombineType.match ? 8.w : 0.w),
                    child: Divider(
                      height: 0.5,
                      color: context.isDarkMode
                          ? Colors.white.withOpacity(0.07999999821186066)
                          : Color(0xffE4E6ED),
                    )),
                4.h.verticalSpace,

                ///列表头部
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: _buildHeader(match, context),
                ),

                ///列表名称
                _buildTeam(match, context),
                _buildBetGroup(match,context.isDarkMode),
                ScoreList(
                  match: match,
                  edition: 2,
                ).marginOnly(top: 8.h),
                // MultiScoreWidget(match),
                SizedBox(
                  height: 6.h,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _buildBetGroup(MatchEntity matchEntity,bool isDarkMode) {
    MatchHps? hps = matchEntity.hps.safeFirst;
    List<MatchHpsHlOl> hpsOls = hps?.hl.safeFirst?.ol ?? [];
    bool isFake = false;
    if (hpsOls.isEmpty) {
      isFake = true;
      if (matchEntity.csid == "1") {
        //足球类型是3个投注项
        hpsOls.addAll([MatchHpsHlOl(), MatchHpsHlOl(), MatchHpsHlOl()]);
      } else {
        hpsOls.addAll([MatchHpsHlOl(), MatchHpsHlOl()]);
      }
    } else if (hpsOls.safeFirst?.oid != '') {
      Map<int, MatchHpsHlOl?> temp = {};
      hpsOls.forEach((e) {
        if (e?.ots == 'T1') {
          temp[0] = e;
        } else if (e?.ots == 'T2') {
          temp[2] = e;
        } else {
          temp[1] = e;
        }
      });
      hpsOls.clear();
      SplayTreeMap<int, MatchHpsHlOl> sortedValuesAsc = SplayTreeMap.from(
          temp, (int keys1, int keys2) => keys1!.compareTo(keys2!));
      hpsOls.addAll((sortedValuesAsc.values).toList());
    }
    CollectionController controller = CollectionController.to;
    return Container(
      height: 32.w,
      alignment: Alignment.center,
      child: Stack(
        children: [
          if (!HomeController.to.homeState.menu.isMatchBet)
            Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: Obx(() {
                  if (ConfigController.to.accessConfig.value.collectSwitch) {
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: GetBuilder<CollectionController>(
                          init: CollectionController.to,
                          builder: (logic) {
                            return InkWell(
                              onTap: () {
                                controller.addOrCancelMatch(matchEntity);
                              },
                              child: ImageView(
                                matchEntity.mf ||
                                        CollectionController
                                            .to.commonCollectionMidList
                                            .contains(matchEntity.mid)
                                    ? 'assets/images/home/ico_fav_nor_sel.svg'
                                    :  isDarkMode? 'assets/images/home/ico_fav_nor.png':'assets/images/home/ico_fav_nor_light.png',
                                width: 16.w,
                                height: 16.w,
                              ),
                            );
                          }),
                    );
                  } else {
                    return 0.verticalSpace;
                  }
                })),

          Align(
            alignment: Alignment.center,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                    decoration: const BoxDecoration(
                      boxShadow:  [
                        BoxShadow(
                        color: Color(0x0A000000),
                  blurRadius: 6,
                  offset: Offset(0, 2),
                  spreadRadius: 0,
                 )]),
                    child:  OddsButton(
                  height: 32.w,
                  width: hpsOls.length == 3
                      ? 90.w
                      : hpsOls.length == 2
                          ? 140.w
                          : 280.w,
                  match: matchEntity,
                  radius: 4.w,
                  hps: hps,
                  ol: isFake ? null : hpsOls[index],
                  hl: hps?.hl.safeFirst,
                ));
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: 2.w,
                );
              },
              itemCount: hpsOls.length,
            ),
          ),
        ],
      ),
    );
  }

  _buildTeam(MatchEntity matchEntity, BuildContext context) {
    int result = MatchUtil.getHandicapIndexBy(matchEntity);
    Color mhnColor = result == 1
        ? Color(0xff74c4ff)
        : context.isDarkMode
            ? Colors.white.withOpacity(0.8999999761581421)
            : const Color(0xFF303442); //主队
    Color manColor = result == 2
        ? Color(0xff74c4ff)
        : context.isDarkMode
            ? Colors.white.withOpacity(0.8999999761581421)
            : const Color(0xFF303442); //客队
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    matchEntity.mhn,
                    style: TextStyle(
                      color: mhnColor,
                      fontSize: 12.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.right,
                    maxLines: 2,
                  ),
                ),
                SizedBox(
                  width: 4.w,
                ),
                ImageView(
                  (matchEntity.mhlu as List).safeFirst == "" ||
                          (matchEntity.mhlu as List).safeFirst == null
                      ? 'assets/images/home/home_team_logo.svg'
                      : (matchEntity.mhlu as List).safeFirst,
                  width: 20.w,
                  height: 20.w,
                  cdn: true,
                ),
                Container(
                    width: 4.w,
                    height: 4.w,
                    margin: EdgeInsets.symmetric(horizontal: 8.w),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.w)),
                      color: set_serving_side(matchEntity, 'home')
                          ? Color(0xff4ab06a)
                          : Colors.transparent,
                    )),
              ],
            ),
          ),
          Container(
            width: 20.w,
            height: 20.w,
            alignment: Alignment.center,
            child: Text(
              'VS',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.isDarkMode
                    ? Colors.white.withOpacity(0.8999999761581421)
                    : const Color(0xFF303442),
                fontSize: 12.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: 4.w,
                    height: 4.w,
                    margin: EdgeInsets.symmetric(horizontal: 8.w),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.w)),
                      color: set_serving_side(matchEntity, 'away')
                          ? Color(0xff4ab06a)
                          : Colors.transparent,
                    )),
                ImageView(
                  (matchEntity.malu as List).safeFirst == "" ||
                          (matchEntity.malu as List).safeFirst == null
                      ? 'assets/images/home/home_team_logo.svg'
                      : (matchEntity.malu as List).safeFirst,
                  width: 20.w,
                  height: 20.w,
                  cdn: true,
                ),
                SizedBox(
                  width: 4.w,
                ),
                Expanded(
                  child: Text(
                    matchEntity.man,
                    style: TextStyle(
                      color: manColor,
                      fontSize: 12.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.left,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildHeader(MatchEntity matchEntity, BuildContext context) {
    // Get.log("mc = ${matchEntity.mc} ${matchEntity.mhn}");
    bool showCountingDown = MatchUtil.showCountingDown(matchEntity);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FlagWidget(
            matchEntity: matchEntity,
            type: 1,
          ),
          SizedBox(
            width: 4.w,
          ),
          // 1 开赛   110 即将开赛
          //  ms = 1 110 才匹配（已开赛的）其他直接显示时间。

          //  <!--开赛日期 ms != 110 (不为即将开赛)  subMenuType = 13网球(进行中不显示，赛前需要显示)-->
          ///  kyapp 没有显示即将开始 倒计时 这里不需要判断倒计时
          /*       if (matchEntity.ms != 110 &&
                      !showStartCountingDown &&
                      !showCountingDown)*/

          if (matchEntity.ms != 110 && !showCountingDown)
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateUtil.formatDateMs(int.tryParse(matchEntity.mgt) ?? 0,
                      format:
                          isZh() ? LocaleKeys.time11.tr : LocaleKeys.time4.tr),
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                    color: context.isDarkMode
                        ? Colors.white.withOpacity(0.30000001192092896)
                        : const Color(0xffAFB3C8),
                  ),
                ),
                SizedBox(
                  width: 5.w,
                )
              ],
            ),
          // <!-- 赛事回合数mfo match.ms != 1(不为开赛)-->
          if (matchEntity.mfo != null &&
              ![1, 110].contains(matchEntity.ms) && //网球单独处理
              matchEntity != null &&
              [5, 7, 8, 9, 10].contains(int.parse(matchEntity.csid)))
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  matchEntity.mfo,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                    color: context.isDarkMode
                        ? Colors.white.withOpacity(0.30000001192092896)
                        : const Color(0xffAFB3C8),
                  ),
                ),
                SizedBox(
                  width: 5.w,
                )
              ],
            ),

          ///  即将开赛 ms = 110  显示即将开赛
          if (matchEntity.ms == 110)
            Text(
              'ms_110'.tr,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12.sp,
                color: context.isDarkMode
                    ? Colors.white.withOpacity(0.30000001192092896)
                    : const Color(0xffAFB3C8),
              ),
            ).marginOnly(right: 4.w),

          /// 今日赛事
          // if (matchEntity.mcg == 3)
          //  ms = 1 110 才匹配（已开赛的）其他直接显示时间。
          // if ([1].contains(matchEntity.ms))
          //   Text(
          //     // tid 联赛id归位一类，
          //     'mmp_${matchEntity.csid}_${matchEntity.mmp}'.tr,
          //     style: TextStyle(
          //       fontSize: 12.sp,
          //       fontFamily: 'PingFang SC',
          //       fontWeight: FontWeight.w400,
          //       color: context.isDarkMode
          //           ? Colors.white.withOpacity(0.30000001192092896)
          //           : const Color(0xffAFB3C8),
          //     ),
          //   ).marginOnly(right: 4.w),
          //  <!--倒计时或正计时-->
          if (matchEntity.ms != 110 &&
              showCountingDown &&
              HomeController.to.visiable)
            Countingdown(matchEntity),
          // TimeWidget(
          //   matchEntity: matchEntity,
          // ),

          SizedBox(
            width: 4.w,
          ),
          matchEntity.ms != 110
              ? Text(
                  //网球单独处理
                  matchEntity != null &&
                          matchEntity.csid ==
                              DetailCsidConfig.detailCsidConfig["CSID_5"]
                                  ?["csid"]
                      ? FormatScore.formatminScore(matchEntity)
                      : TYFormatScore.formatTotalScore(matchEntity).text,
                  style: TextStyle(
                    color: context.isDarkMode
                        ? Colors.white.withOpacity(0.8999999761581421)
                        : const Color(0xFF303442),
                    fontSize: 12.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w400,
                  ),
                ).marginOnly(left: 4.w)
              : SizedBox(),
          // 赛事回合数mfo match.ms != 1(不为开赛) 为开赛显示
          if (ObjectUtil.isNotEmpty(matchEntity.mfo) && matchEntity.ms != 1)
            Text(
              matchEntity.mfo,
              style: TextStyle(
                color: context.isDarkMode
                    ? Colors.white.withOpacity(0.30000001192092896)
                    : const Color(0xffAFB3C8),
                fontSize: 12.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
              ),
            ).marginOnly(left: 4.w),
          const Spacer(),
          Obx(() {
            return Text(
              ConfigController.to.accessConfig.value.handicapNum
                  ? '${LocaleKeys.footer_menu_more.tr}(${matchEntity.mc})'
                  : LocaleKeys.footer_menu_more.tr,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: context.isDarkMode
                    ? Colors.white.withOpacity(0.30000001192092896)
                    : const Color(0xFFAFB3C8),
                fontSize: 10.sp,
                height: 0.9,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
              ),
            );
          }),
          ImageView(
            context.isDarkMode
                ? 'assets/images/league/ico_arrowright_nor_darkmode.png'
                : 'assets/images/league/ico_arrowright_nor.png',
            width: 12.w,
            height: 12.w,
          ),
        ],
      ),
    );
  }

  ///是否是发球方
  bool set_serving_side(item, side) {
    return item.ms == 1 && item.mat == side;
  }

  _buildScore(MatchEntity match) {
    Get.log("match.csid  = ${match.csid}");
    if (match.csid != '2') {
      return SizedBox();
    }
    List<Widget> list = [];
    var mscmap = {
      for (var item in match.msc)
        item.split("|")[0]: item.split("|")[1].replaceAll(":", "-")
    };
    var lastKey = '';
    for (int i = 19; i < 22; i++) {
      if (mscmap.containsKey('S$i')) {
        lastKey = 'S$i';
      }
    }
    for (int i = 19; i < 22; i++) {
      if (mscmap['S$i'] != null && mscmap['S$i'] != '') {
        list.add(Text(
          "${mscmap['S$i']!} ",
          style: TextStyle(
              color: lastKey == 'S$i' ? Color(0xFF179CFF) : Color(0xFF303442)),
        ));
      }
    }

    return Row(
      children: list,
    );
  }
}
