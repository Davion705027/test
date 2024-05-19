import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/unsettled_bets/widgets/information_view.dart';
import 'package:get/get.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../global/user_controller.dart';
import '../../../../services/models/res/get_h5_order_list_entity.dart';
import '../../../../utils/format_date_util.dart';
import '../../../../utils/oss_util.dart';
import '../../../../utils/utils.dart';
import '../cross_checks_titles_view.dart';
import '../information_copy_view.dart';
import '../multiple_together_view.dart';



class Item extends StatelessWidget {
  const Item({
    super.key,
    required this.index,
    required this.data,
    required this.type,
    this.onTap,
  });

  final VoidCallback? onTap;

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
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            children: [
              CrossChecksTitlesView(
                information: getSeriesValue(),
              ),
              _mergeTogether(),
              _information(),
            ],
          ),
        ));
  }

  Widget _mergeTogether() {
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: data.orderVOS.isNotEmpty
          ? MultipleTogetherView(
        orderVOS: data.orderVOS,
        onTap: onTap,
        Expand: data.isExpand,
        type: type,
      )
          : Container(),
    );
  }

  Widget _information() {
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: Column(
        children: [
          InformationView(
            information: "${LocaleKeys.bet_record_bet_val.tr}：",
            outcome: getOrderAmountTotal(),
            isAmount: true,
          ),
          InformationView(
            titleColorType: 2,
            InformationColorType: getProfitAmountColor(),
            information: type == 0
                ? "${LocaleKeys.app_h5_cathectic_winnable.tr}："
                : "${LocaleKeys.app_h5_cathectic_settle.tr}：",
            outcome: getProfitAmount(),
            isAmount: true,
          ),
          InformationCopyView(
            information: "${LocaleKeys.app_h5_cathectic_bet_number.tr}：",
            outcome: getOrderNo(),
          ),
          InformationView(
            information: "${LocaleKeys.bet_record_sort1.tr}：",
            outcome: getModifyTime(),
          ),
          InformationView(
            information: "${LocaleKeys.app_h5_cathectic_bet_status.tr}：",
            outcome: getOrderStatus(),
          ),
        ],
      ),
    );
  }

  String getSeriesValue() {
    String seriesValue = '';
    if (data != null) {
      seriesValue = data.seriesValue;
    }
    return seriesValue;
  }

  /* String getMarketValue(int index) {
    String marketValue = '';
    if (data != null && data.orderVOS.isNotEmpty) {
      marketValue = data.orderVOS[index].marketValue;
    }
    return marketValue;
  }
  String getOddFinally(int index) {
    String oddFinally = '';
    if (data != null && data.orderVOS.isNotEmpty) {
      oddFinally = data.orderVOS[index].oddFinally;
    }
    return oddFinally;
  }

  String getPlayName(int index) {
    String playName = '';
    if (data != null && data.orderVOS.isNotEmpty) {
      playName = data.orderVOS[index].playName;
    }
    return playName;
  }
  String getMatch(int index) {
    String matchInfo = '';
    if (data != null && data.orderVOS.isNotEmpty) {
      matchInfo = data.orderVOS[index].matchInfo;
    }
    return matchInfo;
  }
  String setSettleScore(int index){
    String settleScore = '';
    if (data != null && data.orderVOS.isNotEmpty) {
      settleScore = data.orderVOS[index].settleScore;
    }
    return settleScore;
  }
  String setBetResult(int index){
  // 'bet_record_bet_no_status00': '未结算',
  // 'bet_record_bet_no_status02': '走水',
  // 'bet_record_bet_no_status03': '输',
  // 'bet_record_bet_no_status04': '赢',
  // 'bet_record_bet_no_status05': '赢半',
  // 'bet_record_bet_no_status06': '输半',
  // 'bet_record_bet_no_status07': '比赛取消',
  // 'bet_record_bet_no_status08': '比赛延期',
  // 'bet_record_bet_no_status11': '比赛延迟',
  // 'bet_record_bet_no_status12': '比赛中断',
  // 'bet_record_bet_no_status15': '比赛放弃',
    String betResult = '';
    if (data != null && data.orderVOS.isNotEmpty) {
      int result  = data.orderVOS[index].betResult;
      if (result==0){
        betResult = LocaleKeys.bet_record_bet_no_status00.tr+"  ";
      }else if (result==2){
        betResult = LocaleKeys.bet_record_bet_no_status02.tr+"  ";
      }else if (result==3){
        betResult = LocaleKeys.bet_record_bet_no_status03.tr+"  ";
      }else if (result==4){
        betResult = LocaleKeys.bet_record_bet_no_status04.tr+"  ";
      }else if (result==5){
        betResult = LocaleKeys.bet_record_bet_no_status05.tr+"  ";
      }else if (result==6){
        betResult = LocaleKeys.bet_record_bet_no_status06.tr+"  ";
      }else if (result==7){
        betResult = LocaleKeys.bet_record_bet_no_status07.tr+"  ";
      }else if (result==8){
        betResult = LocaleKeys.bet_record_bet_no_status08.tr+"  ";
      }else if (result==11){
        betResult = LocaleKeys.bet_record_bet_no_status11.tr+"  ";
      }else if (result==12){
        betResult = LocaleKeys.bet_record_bet_no_status02.tr+"  ";
      }else if (result==13){

      }else if (result==15){
        betResult = LocaleKeys.bet_record_bet_no_status15.tr+"  ";
      }else if (result==16){

      }
    }
    return betResult;
  }
  String getSportName(int index) {
    String sportName = '';
    if (data != null && data.orderVOS.isNotEmpty) {

      String marketType = "";
      String keType = data.orderVOS[index].marketType;
      if (keType == "EU") {
        marketType = '['+LocaleKeys.odds_EU.tr+']';
      } else if (keType == "GB") {
        marketType = '['+LocaleKeys.odds_GB.tr+']';
      } else if (keType == "HK") {
        marketType = '['+LocaleKeys.odds_HK.tr+']';
      } else if (keType == "ID") {
        marketType = '['+LocaleKeys.odds_ID.tr+']';
      } else if (keType == "MY") {
        marketType = '['+LocaleKeys.odds_MY.tr+']';
      } else if (keType == "US") {
        marketType = '['+LocaleKeys.odds_US.tr+']';
      }
      sportName = data.orderVOS[index].sportName+' '+data.orderVOS[index].playName+' '+marketType;
    }
    return sportName;
  }*/

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

  String getOrderAmountTotal() {
    String orderAmountTotal = '';
    if (data != null) {
      String managerCode = UserController.to.currCurrency();
      orderAmountTotal =
          setAmount(data.orderAmountTotal.toString()) + " " + managerCode;
    }
    return orderAmountTotal;
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

  String getProfitAmount() {
    String profitAmount = '';
    String managerCode = UserController.to.currCurrency();
    if (data != null) {
      if (type == 0) {
        profitAmount =
            setAmount(data.maxWinAmount.toString()) + " " + managerCode;
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

  String getOrderStatus() {
    String orderStatus = '';
    if (data != null) {
      String status = data.orderStatus;
      if (status == "0" || status == "1") {
        orderStatus = LocaleKeys.bet_record_successful_betting.tr;
      } else if (status == "2") {
        orderStatus = LocaleKeys.bet_record_invalid_bet.tr;
      } else if (status == "3") {
        orderStatus = LocaleKeys.bet_record_confirming.tr;
      } else if (status == "4") {
        orderStatus = LocaleKeys.bet_bet_err.tr;
      }
    }
    return orderStatus;
  }
}
