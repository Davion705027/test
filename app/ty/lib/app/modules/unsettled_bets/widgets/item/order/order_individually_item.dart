import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/unsettled_bets/widgets/information_view.dart';
import 'package:flutter_ty_app/app/modules/unsettled_bets/widgets/rule_statement_view.dart';
import 'package:flutter_ty_app/app/modules/unsettled_bets/widgets/title_view.dart';
import 'package:get/get.dart';

import '../../../../../../generated/locales.g.dart';
import '../../../../../global/user_controller.dart';
import '../../../../../services/models/res/get_h5_order_list_entity.dart';
import '../../../../../utils/format_date_util.dart';
import '../../../../../utils/oss_util.dart';
import '../../../../../utils/utils.dart';
import '../../dividing_line_view.dart';
import '../../early_redemption_details_view.dart';
import '../../early_settlement_feature_view.dart';
import '../../extend_view.dart';
import '../../information_copy_view.dart';
import '../../information_important_view.dart';
import '../../information_line_view.dart';
import '../../information_title_view.dart';
import '../../title_special_view.dart';

///单关
class OrderIndividuallyItem extends StatelessWidget {
  const OrderIndividuallyItem({
    super.key,
    required this.index,
    required this.data,
    required this.type,
  });

  ///type  0: 未注单-未结算 ，1:已结算
  final int index, type;
  final GetH5OrderListDataRecordxData data;

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
    if (data != null && data.orderVOS.isNotEmpty) {
      sportId = data.orderVOS[0].sportId;
    }

    ///单关，这4种vr体育，vr赛狗，vr赛马，vr摩托车，vr泥地摩托车，标题头部不一样
    if (sportId == 1009 ||
        sportId == 1010 ||
        sportId == 1011 ||
        sportId == 1002) {
      return TitleSpecialView(
        information: data.orderVOS[0].batchNo,
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
            information: "${LocaleKeys.bet_record_sort1.tr}：",
            outcome: getModifyTime(),
          ),
          InformationLineView(
            information: getMatchInfo(),
          ),
          if (type == 1 && gettleScore().isNotEmpty)
            InformationLineView(
              information: getSettleScore(),
            ),
          InformationView(
            information: "${LocaleKeys.bet_record_bet_val.tr}：",
            outcome: getOrderAmountTotal(),
            isAmount:true,
          ),
          InformationView(
            titleColorType: 2,
            InformationColorType: getProfitAmountColor(),
            information: type == 0
                ? "${LocaleKeys.app_h5_cathectic_winnable.tr}："
                : "${LocaleKeys.app_h5_cathectic_settle.tr}：",
            outcome: getProfitAmount(),
              isAmount:true,
          ),
          InformationView(
            information: "${LocaleKeys.app_h5_cathectic_bet_status.tr}：",
            outcome: getOrderStatus(),
          ),
          if (getExhibitEarlySettlement())
            EarlyRedemptionDetailsView(
              data: data,
              index: index,
            ),
          if (getEarlySettlementFeature())
            EarlySettlementFeatureView(
              information: getMaxCashout(),
              index: index,
              turnOnEarlySettlement: data.turnOnEarlySettlement,
              earlySettlementBeingRequested: data.earlySettlementBeingRequested,
              earlySettlementSuccessfulType: data.earlySettlementSuccessfulType,
            ),
        ],
      ),
    );
  }

  ///只有已注单才有，判断单关是否展示提前结算信息的view
  bool getExhibitEarlySettlement() {
    ///只有已结注单才展示
    if (type == 1) {
      if (data.preSettle != null) {
        int preSettle = data.preSettle;
        if (preSettle == 1 || preSettle == 2) {
          return true;
        }
      }
    }
    return false;
  }

  ///只有未注单才有，判断是否有提前结算功能
  bool getEarlySettlementFeature() {
    ///只有已结注单才展示
    if (type == 0) {
      return data.exhibitEarlySettlement;
    }
    return false;
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
    if (data != null && data.orderVOS != null && data.orderVOS.isNotEmpty) {
      String matchType = '';
      int chType = data.orderVOS[0].matchType;
      if (chType == 1) {
        matchType = ' ${LocaleKeys.matchtype_1.tr}';
      } else if (chType == 2) {
        matchType = ' ${LocaleKeys.matchtype_2.tr}';
      } else if (chType == 3) {
        matchType = ' ${LocaleKeys.ouzhou_match_outrights.tr}';
      }

      String marketType = '';
      String keType = data.orderVOS[0].marketType;
      if (keType == "EU") {
        marketType = ' - ${LocaleKeys.odds_EU.tr}';
      } else if (keType == "GB") {
        marketType = ' - ${LocaleKeys.odds_GB.tr}';
      } else if (keType == "HK") {
        marketType = ' - ${LocaleKeys.odds_HK.tr}';
      } else if (keType == "ID") {
        marketType = ' - ${LocaleKeys.odds_ID.tr}';
      } else if (keType == "MY") {
        marketType = ' - ${LocaleKeys.odds_MY.tr}';
      } else if (keType == "US") {
        marketType = ' - ${LocaleKeys.odds_US.tr}';
      }
      playName =
          '${LocaleKeys.app_h5_cathectic_bets.tr}:[${data.orderVOS[0].sportName}]:$matchType ${data.orderVOS[0].playName}$marketType';
    }
    return playName;
  }

  String getPlayOptions() {
    String playOptions = '';
    if (data != null && data.orderVOS != null && data.orderVOS.isNotEmpty) {
      playOptions =
          "${data.orderVOS[0].marketValue} @${data.orderVOS[0].oddFinally}";
    }
    return playOptions;
  }

  String getOrderNo() {
    String orderNo = '';
    if (data != null) {
      orderNo = data.orderNo;
    }
    return orderNo;
  }

  String getModifyTime() {
    String modifyTime = '';
    if (data != null) {
      modifyTime =
          "${data.betTimeStr} ${FormatDate.formatHHMMSS(int.parse(data.betTime))}";
    }
    return modifyTime;
  }

  String getMatchInfo() {
    String matchInfo = '';
    if (data != null && data.orderVOS != null && data.orderVOS.isNotEmpty) {
      matchInfo =
          "[${data.orderVOS[0].sportName}] ${data.orderVOS[0].matchName}";
    }
    return matchInfo;
  }

  String getSettleScore() {
    String settleScore = '';
    if (data != null && data.orderVOS != null && data.orderVOS.isNotEmpty) {
      settleScore =
          '${LocaleKeys.bet_record_score_result.tr}(${data.orderVOS[0].settleScore})';
    }
    return settleScore;
  }

  String gettleScore() {
    String settleScore = '';
    if (data != null && data.orderVOS != null && data.orderVOS.isNotEmpty) {
      settleScore = data.orderVOS[0].settleScore;
    }
    return settleScore;
  }

  String getOrderAmountTotal() {
    String orderAmountTotal = '';
    if (data != null) {
      String managerCode = UserController.to.currCurrency();
      orderAmountTotal =
          "${setAmount(data.orderAmountTotal.toString())} $managerCode";
    }
    return orderAmountTotal;
  }

  String getProfitAmount() {
    String profitAmount = '';
    String managerCode = UserController.to.currCurrency();
    if (data != null) {
      if (type == 0) {
        profitAmount =
            "${setAmount(data.maxWinAmount.toString())} $managerCode";
      } else if (type == 1) {
        //只有已结注单才会展示  输赢状态
        String results = '';
        //已结注单，注单成功的时候
        if (data.orderStatus == '1') {
          int outcome = data.outcome;
          if (outcome != null) {
            if (outcome == 2) {
              results = LocaleKeys.bet_record_bet_no_status02.tr;
            } else if (outcome == 3) {
              results = LocaleKeys.bet_record_bet_no_status03.tr;
            } else if (outcome == 4) {
              results = LocaleKeys.bet_record_bet_no_status04.tr;
            } else if (outcome == 5) {
              results = LocaleKeys.bet_record_bet_no_status05.tr;
            } else if (outcome == 6) {
              results = LocaleKeys.bet_record_bet_no_status06.tr;
            } else if (outcome == 7) {
              results = LocaleKeys.bet_record_bet_no_status07.tr;
            } else if (outcome == 8) {
              results = LocaleKeys.bet_record_bet_no_status08.tr;
            }
          }
        } else {
          results = LocaleKeys.bet_record_bet_no_status17.tr;
        }
        //已结注单，注单失败的时候结算是0元
        if (data.orderStatus == '1') {
          profitAmount = results +
              '  ' +
              setAmount(data.profitAmount.toString()) +
              " " +
              managerCode;
        } else {
          profitAmount = results + '  ' + '0.00' + " " + managerCode;
        }
      }
    }
    return profitAmount;
  }

  int getProfitAmountColor() {
    int profitAmount = 0;
    //当是未注单-未结算就是蓝色
    if (type == 0) {
      return 2;
    }
    //已结注单，注单失败的时候
    if (data.orderStatus == '1') {
      if (data != null) {
        int outcome = data.outcome;
        if (outcome == 4 || outcome == 5) {
          profitAmount = 2;
        }
      }
    }
    return profitAmount;
  }

  String getOrderStatus() {
    String orderStatus = '';
    if (data != null) {
      String Status = data.orderStatus;
      if (Status == "0" || Status == "1") {
        orderStatus = LocaleKeys.bet_record_successful_betting.tr;
      } else if (Status == "2") {
        orderStatus = LocaleKeys.bet_record_invalid_bet.tr;
      } else if (Status == "3") {
        orderStatus = LocaleKeys.bet_record_confirming.tr;
      } else if (Status == "4") {
        orderStatus = LocaleKeys.bet_bet_err.tr;
      }
    }
    return orderStatus;
  }

  String getMaxCashout() {
    String maxCashout = '';
    if (data != null) {
      maxCashout = data.maxCashout.toString();
    }
    return maxCashout;
  }

  getScoreBenchmark() {
    String scoreBenchmark = '';
    if (data != null &&
        data.orderVOS.isNotEmpty &&
        data.orderVOS[0].scoreBenchmark.isNotEmpty) {
      String benchmark = data.orderVOS[0].scoreBenchmark.replaceAll(':', '-');
      scoreBenchmark = "${LocaleKeys.bet_record_settle_num.tr}($benchmark)";
    }
    return scoreBenchmark;
  }
}
