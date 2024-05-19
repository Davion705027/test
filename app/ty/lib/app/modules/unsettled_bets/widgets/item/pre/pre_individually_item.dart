import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/unsettled_bets/widgets/information_view.dart';
import 'package:flutter_ty_app/app/modules/unsettled_bets/widgets/title_view.dart';
import 'package:get/get.dart';

import '../../../../../../generated/locales.g.dart';
import '../../../../../global/user_controller.dart';
import '../../../../../services/models/res/get_h5_pre_bet_orderlist_entity.dart';
import '../../../../../utils/format_date_util.dart';
import '../../../../../utils/oss_util.dart';
import '../../../../../utils/utils.dart';
import '../../../../../widgets/image_view.dart';
import '../../information_copy_view.dart';
import '../../information_important_view.dart';
import '../../information_line_view.dart';
import '../../modify_odds_view.dart';
import '../../title_special_view.dart';

///单关
class PreIndividuallyItem extends StatelessWidget {
  const PreIndividuallyItem({
    super.key,
    required this.index,
    required this.data,
    required this.type,
  });

  ///type  0: 未注单-预约中 ，1:已失效
  final int index, type;
  final GetH5PreBetOrderlistDataRecordxData data;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => {},
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              image: DecorationImage(
                image: NetworkImage(
                  OssUtil.getServerPath(
                    context.isDarkMode
                        ? 'assets/images/bets/nighttime_bg.png'
                        : 'assets/images/bets/daytime_bg.png',
                  ),
                ),
                fit: BoxFit.cover,
              ),
              color: Colors.white),
          margin: EdgeInsets.only(bottom: 20.h),
          padding:
              const EdgeInsets.only(top: 8, left: 12, right: 12, bottom: 16),
          child: Column(
            children: [
              _titleview(),
              InformationImportantView(
                information: getPlayName(),
                outcome: getPlayOptions(),
                scoreBenchmark: getScoreBenchmark(),
              ),
              _information(),
            ],
          ),
        ));
  }

  Widget _titleview() {
    int sportId = 0;
    if (data != null && data.detailList.isNotEmpty) {
      sportId = data.detailList[0].sportId;
    }

    ///单关，这4种vr体育，vr赛狗，vr赛马，vr摩托车，vr泥地摩托车，标题头部不一样
    if (sportId == 1009 ||
        sportId == 1010 ||
        sportId == 1011 ||
        sportId == 1002) {
      return TitleSpecialView(
        information: data.detailList[0].batchNo,
      );
    } else {
      return TitleView(
        information: getHomeName(),
        outcome: getAwayName(),
      );
    }
  }

  Widget _information() {
    return Container(
      child: Column(
        children: [
          InformationCopyView(
            information: "${LocaleKeys.app_h5_cathectic_bet_number.tr}：",
            outcome: getOrderNo(),
          ),
          InformationView(
            information: "${LocaleKeys.bet_record_bet_pre_time.tr}：",
            outcome: getModifyTime(),
          ),
          InformationLineView(
            information: getMatchInfo(),
            multiLine: false,
          ),
          InformationView(
            information: "${LocaleKeys.bet_record_bet_val.tr}：",
            outcome: getOrderAmountTotal(),
            isAmount: true,
          ),
          InformationView(
            titleColorType: 2,
            InformationColorType: 2,
            information: "${LocaleKeys.app_h5_cathectic_winnable.tr}：",
            outcome: getMaxWinAmount(),
            isAmount: true,
          ),
          InformationView(
            information: "${LocaleKeys.app_h5_cathectic_bet_status.tr}：",
            outcome: getOrderStatus(),
            InformationColorType: type == 0 ? 2 : 3,
          ),

          ///只有预约中才会有修改赔率
          if (type == 0)
            ModifyOddsView(
              index: index,
              data: data,
            ),
        ],
      ),
    );
  }

  String getHomeName() {
    String homeName = '';
    if (data != null && data.detailList != null && data.detailList.isNotEmpty) {
      List<String> matchInfo = data.detailList[0].matchInfo.split(' v ');
      if (matchInfo.isNotEmpty) {
        homeName = matchInfo[0];
      }
    }
    return homeName;
  }

  String getAwayName() {
    String awayName = '';
    if (data != null && data.detailList != null && data.detailList.isNotEmpty) {
      List<String> matchInfo = data.detailList[0].matchInfo.split(' v ');
      if (matchInfo.isNotEmpty && matchInfo.length > 1) {
        awayName = matchInfo[1];
      }
    }
    return awayName;
  }

  String getPlayName() {
    String playName = '';
    if (data != null && data.detailList != null && data.detailList.isNotEmpty) {
      String matchType = '';
      int chType = data.detailList[0].matchType;
      if (chType == 1) {
        matchType = ' ' + LocaleKeys.matchtype_1.tr;
      } else if (chType == 2) {
        matchType = ' ' + LocaleKeys.matchtype_2.tr;
      } else if (chType == 3) {
        matchType = ' ' + LocaleKeys.ouzhou_match_outrights.tr;
      }

      String marketType = '';
      String keType = data.detailList[0].marketType;
      if (keType == "EU") {
        marketType = ' - ' + LocaleKeys.odds_EU.tr;
      } else if (keType == "GB") {
        marketType = ' - ' + LocaleKeys.odds_GB.tr;
      } else if (keType == "HK") {
        marketType = ' - ' + LocaleKeys.odds_HK.tr;
      } else if (keType == "ID") {
        marketType = ' - ' + LocaleKeys.odds_ID.tr;
      } else if (keType == "MY") {
        marketType = ' - ' + LocaleKeys.odds_MY.tr;
      } else if (keType == "US") {
        marketType = ' - ' + LocaleKeys.odds_US.tr;
      }
      playName = LocaleKeys.app_h5_cathectic_bets.tr +
          ':[' +
          data.detailList[0].sportName +
          ']:' +
          matchType +
          ' ' +
          data.detailList[0].playName +
          marketType;
    }
    return playName;
  }

  String getPlayOptions() {
    String playOptions = "";
    if (data != null && data.detailList != null && data.detailList.isNotEmpty) {
      playOptions =
          "${data.detailList[0].playOptionName} @${data.detailList[0].oddFinally}";
    }
    return playOptions;
  }

  String getOrderNo() {
    String orderNo = "";
    if (data != null) {
      orderNo = data.orderNo;
    }
    return orderNo;
  }

  String getModifyTime() {
    String modifyTime = "";
    if (data != null) {
      modifyTime =
          "${data.modifyTimeStr} ${FormatDate.formatHHMMSS(int.parse(type == 0 ? data.modifyTime : data.betTime))}";
    }
    return modifyTime;
  }

  String getMatchInfo() {
    String matchInfo = "";
    if (data != null && data.detailList != null && data.detailList.isNotEmpty) {
      matchInfo = "[" +
          data.detailList[0].sportName +
          "] " +
          data.detailList[0].matchName;
    }
    return matchInfo;
  }

  String getOrderAmountTotal() {
    String orderAmountTotal = "";
    if (data != null) {
      String managerCode = UserController.to.currCurrency();
      orderAmountTotal =
          setAmount(data.orderAmountTotal.toString()) + " " + managerCode;
    }
    return orderAmountTotal;
  }

  String getMaxWinAmount() {
    String maxWinAmount = "";
    if (data != null) {
      String managerCode = UserController.to.currCurrency();
      maxWinAmount =
          setAmount(data.maxWinAmount.toString()) + " " + managerCode;
    }
    return maxWinAmount;
  }

  String getOrderStatus() {
    String orderStatus = "";
    if (data != null) {
      int Status = data.preOrderStatus;
      if (Status == 2 || Status == 3) {
        orderStatus = LocaleKeys.pre_record_booked_fail.tr;
      } else if (Status == 4) {
        orderStatus = LocaleKeys.pre_record_canceled.tr;
      } else {
        orderStatus = LocaleKeys.pre_record_booking.tr;
      }
    }
    return orderStatus;
  }

  getScoreBenchmark() {
    String scoreBenchmark = '';
    if (data != null &&
        data.detailList.isNotEmpty &&
        data.detailList[0].scoreBenchmark.isNotEmpty) {
      String benchmark = data.detailList[0].scoreBenchmark.replaceAll(':', '-');
      scoreBenchmark =
          LocaleKeys.bet_record_settle_num.tr + "(" + benchmark + ")";
    }
    return scoreBenchmark;
  }
}
