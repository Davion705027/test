
import 'dart:ffi';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/core/format/common/module/format-score.dart';
import 'package:flutter_ty_app/app/modules/home/logic/other_player_name_to_playid.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/utils/format_score_util.dart';

import '../../../../../utils/csid_util.dart';
import '../../../../../widgets/GlobalFadeTransition.dart';
import '../../../../../widgets/image_view.dart';
import '../../../controllers/home_controller.dart';

class TeamScoreWidget extends StatelessWidget {
  TeamScoreWidget(
      {super.key,
      required this.matchEntity,
      required this.index,
      this.isMainPlay = false,
      this.isShowGoal = false,
      this.isShowRed = false,
      this.isShowMststi = false,
      this.hint = '',
      this.playId = '',
      this.hSpecial = ''});

  final bool isMainPlay;

  final String playId;
  final MatchEntity matchEntity;
  final int index; // 0 主队 1 客队
  final String hSpecial; // 计算15分钟比分参数

  final String hint ; // 显示弹出提示

  // 是否显示红牌
  final bool isShowRed;

  // 是否显示进球动画
  bool isShowGoal;

  // 是否显示伤停补时
  bool isShowMststi;


  // final String name;
  //
  // // 比分 只有滚球 ms == 1 时才有，其他情况下为空。显示的是msc的匹配出来的
  // // format-msc.js
  // final String score;
  /// 15分钟玩法 1007  罚牌 1003
  ///
  @override
  Widget build(BuildContext context) {

    String matStr = index == 0 ? 'home' : 'away';
    String name = index == 0 ? matchEntity.mhn : matchEntity.man;
    // 罚牌
    // int punish = 0; // FormatScore.formatTotalScore(matchEntity, index);
    // 罚牌,改动
    String punish = '0';
    ///足球
    if (matchEntity.msc.isNotEmpty &&
        matchEntity.csid ==
            DetailCsidConfig.detailCsidConfig["CSID_1"]?["csid"]&&HomeController.to.visiable ) {
      punish = FormatScore.footballScoreStatusArray(matchEntity, index);
    }
    // 区分特殊玩法 角球 15 罚牌
    bool isSpecialPlay = [
      playIdConfig.hpsCorner,
      playIdConfig.hps15Minutes,
      playIdConfig.hpsPunish
    ].contains(playId);
    // 冠军 角球 加时赛
    bool isNotShowScore = [
      playIdConfig.hpsOutright,
      playIdConfig.hpsPenalty,
      playIdConfig.hpsPromotion,
      playIdConfig.hpsOvertime
    ].contains(playId);
    String score = '';
    if (matchEntity.mcg == 1&&HomeController.to.visiable ) {
      // 特殊玩法比分
      if (isSpecialPlay) {
        score = TYFormatScore.getScoreSecond(
                index == 0 ? 1 : 2, playId, matchEntity, hSpecial)
            .toString();
      } else {
        if (isNotShowScore) {
          score = '';
        } else {
          // 总比分
          if (matchEntity != null &&
              matchEntity.csid ==
                  DetailCsidConfig.detailCsidConfig["CSID_5"]?["csid"]) {
            // 网球比分
            score = "";
            if (matchEntity.msc != null && matchEntity.msc.length > 0) {
              score = FormatScore.formatminScore(matchEntity,
                  index: index, isMain: true);
            } else {
              score = '';
            }
          } else {
            score =
                FormatScore.formatTotalScore(matchEntity, index, playId: playId)
                    .toString();
          }
        }
      }
    }

    ///是否是发球方
    bool isServingSide = (matchEntity.ms == 1 && matchEntity.mat == matStr) ? true : false;

    ///比分颜色
    Color? textColor = context.isDarkMode
        ? Colors.white.withOpacity(0.8999999761581421)
        : const Color(0xff303442);

    Color? scoreColor = context.isDarkMode
        ? Colors.white.withOpacity(0.8999999761581421)
        : const Color(0xff303442);
    if (playId == playIdConfig.hps15Minutes) {
      scoreColor = const Color(0xffF2C037);
    }

    return Container(
      height: 32.h,
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: Get.width - ((isShowGoal||isShowMststi) ? 300.w: 260.w),
                  ),
                  child: Text(
                    name,
                    style: TextStyle(
                      height: 1.2,
                      fontSize: name.length > 12 ? 11.sp : 12.sp,
                      color: textColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                //isServingSide 棒球 绿点
                if(isServingSide)
                  Container(
                    width: 4,
                    height: 4,
                    margin: EdgeInsets.only(left: 3.w),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(2)),
                  ),
                if (punish.isNotEmpty && punish != '0' && isMainPlay&&HomeController.to.visiable )
                  isShowRed
                      ? GlobalFadeTransition(
                          child: Container(
                            margin: EdgeInsets.only(left: 3.w),
                            width: 15.w,
                            height: 16.w,
                            alignment: Alignment.center,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFF53F3F),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2.r)),
                            ),
                            child: Text(
                              punish,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ).marginOnly(right: 4.w)
                      : Container(
                          margin: EdgeInsets.only(left: 3.w),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(2.r),
                          ),
                          alignment: Alignment.center,
                          width: 15.w,
                          height: 16.w,
                          child: Text(
                            punish,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ).marginOnly(right: 4.w),
                ///伤停补时等文字动画
                if (matchEntity.csid == "1" &&
                    isMainPlay &&isShowMststi&&hint.isNotEmpty&&HomeController.to.visiable && HomeController.to.homeState.endScroll)
                  GlobalFadeTransition(
                    child: Container(
                      margin: EdgeInsets.only(left: 3.w),
                      alignment: Alignment.center,
                      child: Text(
                        hint,
                        style: TextStyle(
                          color: Colors.amber,
                          height: 1.2,
                          fontSize: 12.sp,
                          letterSpacing: 2,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ).marginOnly(right: 4.w),

                ///足球进球动画
                if (matchEntity.csid == "1" &&
                    isMainPlay &&
                    isShowGoal&&HomeController.to.visiable && HomeController.to.homeState.endScroll)
                  Row(
                    children: [
                      5.horizontalSpace,
                      ImageView(
                        'assets/images/shopcart/icon_goal.gif',
                        width: 10.w,
                        height: 10.h,
                      ),
                      3.horizontalSpace,
                      Text(
                        LocaleKeys.match_result_goal.tr,
                        style: TextStyle(
                          height: 1.2,
                          fontSize: 11.sp,
                         // color: context.isDarkMode ? Colors.white : Colors.black,
                          color: Colors.amber,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.clip,
                      ),
                    ],
                  ),


              ],
            ),
          ),
          Text(
            score,
            style: TextStyle(
              fontSize: 14.sp,
              color: scoreColor,
              fontWeight: FontWeight.w700,
              fontFamily: 'DIN Alternate',
            ),
          )
        ],
      ),
    );
  }
}
