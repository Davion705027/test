import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/map_extension.dart';
import 'package:flutter_ty_app/app/modules/unsettled_bets/widgets/information_view.dart';
import 'package:flutter_ty_app/app/modules/unsettled_bets/widgets/title_view.dart';
import 'package:get/get.dart';

import '../../../../../../generated/locales.g.dart';
import '../../../../../global/user_controller.dart';
import '../../../../../services/models/res/get_h5_order_list_entity.dart';
import '../../../../../utils/format_date_util.dart';
import '../../../../../utils/oss_util.dart';
import '../../../../../utils/utils.dart';
import '../../information_copy_view.dart';
import '../../information_important_view.dart';
import '../../information_line_view.dart';
import '../../information_title_view.dart';

///冠军
class OrderChampionItem extends StatelessWidget {
  const OrderChampionItem({
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
              ///按照开云的不要不要标题头部
              // InformationTitleView(
              //   information: getSportName(),
              //   outcome: getMatchName(),
              // ),
              InformationImportantView(
                information: getPlayName(),
                outcome: getPlayOptions(),
              ),
              _information(),
            ],
          ),
        ));
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
          InformationView(
            information: "${LocaleKeys.app_h5_cathectic_bet_status.tr}：",
            outcome: getOrderStatus(),
          ),
        ],
      ),
    );
  }

  String getSportName() {
    String sportNam = "";
    if (data != null && data.orderVOS != null && data.orderVOS.isNotEmpty) {
      sportNam = "[${data.orderVOS[0].sportName}]";
    }
    return sportNam;
  }

  String getMatchName() {
    String matchName = "";
    if (data != null && data.orderVOS != null && data.orderVOS.isNotEmpty) {
      matchName = data.orderVOS[0].matchName;
    }
    return matchName;
  }

  String getPlayName() {
    String playName = "";
    if (data != null && data.orderVOS != null && data.orderVOS.isNotEmpty) {
      String matchType = "";
      int chType = data.orderVOS[0].matchType;
      //找不到国际化语言，后面再补
      if (chType == 1) {
        matchType = LocaleKeys.app_early_market.tr;
      } else if (chType == 2) {
        matchType = LocaleKeys.app_live_betting.tr;
      } else if (chType == 3) {
        matchType = LocaleKeys.app_outright_winner.tr;
      }

      String marketType = "";
      String keType = data.orderVOS[0].marketType;
      if (keType == "EU") {
        marketType = LocaleKeys.odds_EU.tr;
      } else if (keType == "GB") {
        marketType = LocaleKeys.odds_GB.tr;
      } else if (keType == "HK") {
        marketType = LocaleKeys.odds_HK.tr;
      } else if (keType == "ID") {
        marketType = LocaleKeys.odds_ID.tr;
      } else if (keType == "MY") {
        marketType = LocaleKeys.odds_MY.tr;
      } else if (keType == "US") {
        marketType = LocaleKeys.odds_US.tr;
      }

      playName = "$matchType${data.orderVOS[0].playName} - $marketType";
    }
    return playName;
  }

  String getPlayOptions() {
    String playOptions = "";
    if (data != null && data.orderVOS != null && data.orderVOS.isNotEmpty) {
      playOptions =
          "${data.orderVOS[0].playOptions} @${data.orderVOS[0].oddFinally}";
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
          "${data.modifyTimeStr} ${FormatDate.formatHHMMSS(int.parse(data.modifyTime))}";
    }
    return modifyTime;
  }

  String getMatchInfo() {
    String matchInfo = "";
    if (data != null && data.orderVOS != null && data.orderVOS.isNotEmpty) {
      matchInfo =
          "[" + data.orderVOS[0].sportName + "] " + data.orderVOS[0].matchName;
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
    String orderStatus = "";
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
}
