import 'package:flutter/widgets.dart';
import 'package:flutter_ty_app/app/modules/unsettled_bets/widgets/show_all_single_view.dart';
import 'package:flutter_ty_app/app/modules/unsettled_bets/widgets/single_together_view.dart';

import '../../../../generated/locales.g.dart';
import '../../../services/models/res/get_h5_order_list_entity.dart';
import '../../login/login_head_import.dart';

class MultipleTogetherView extends StatelessWidget {
  const MultipleTogetherView({
    Key? key,
    required this.orderVOS,
    this.onTap,
    required this.Expand,
    required this.type,
  }) : super(key: key);

  final bool Expand;
  final VoidCallback? onTap;
  final List<GetH5OrderListDataRecordxDataOrderVOS> orderVOS;
  final int type;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: getMultipleTogether(),
    );
  }

  List<Widget> getMultipleTogether() {
    List<Widget> listSingleTogetherView = [];
    if (orderVOS.isNotEmpty) {
      int length = 0;
      if (Expand || orderVOS.length < 4) {
        length = orderVOS.length;
      } else {
        length = 3;
      }

      for (int i = 0; i < length; i++) {
        GetH5OrderListDataRecordxDataOrderVOS dataOrderVOS = orderVOS[i];
        if (dataOrderVOS != null) {
          int topType = 1;
          int bottomType = 1;
          if (i == 0) {
            topType = 0;
          }
          if (length-1 == i) {
            if (!Expand ){
              if (orderVOS.length<4){
                bottomType = 0;
              }else{
                bottomType = 2;
              }
            }else {
              bottomType = 0;
            }
          }

          listSingleTogetherView.add(
            SingleTogetherView(
              marketValue: getMarketValue(dataOrderVOS),
              oddFinally: getOddFinally(dataOrderVOS),
              playName: getPlayName(dataOrderVOS),
              matchInfo: getMatch(dataOrderVOS),
              settleScore: setSettleScore(dataOrderVOS),
              betResult: setBetResult(dataOrderVOS),
              betResultColor: setBetResultColor(dataOrderVOS),
              sportName: getSportName(dataOrderVOS),
              topType: topType,
              bottomType: bottomType,
              scoreBenchmark: type == 0 ? getScoreBenchmark(dataOrderVOS) : '',
            ),
          );
        }
      }
    }
    //当大于3串才有展开折叠功能
    if (orderVOS.length > 3) {
      listSingleTogetherView.add(ShowAllSingleView(
        onTap: onTap,
        Expand: Expand,
      ));
    }
    return listSingleTogetherView;
  }

  String getMarketValue(GetH5OrderListDataRecordxDataOrderVOS dataOrderVOS) {
    String marketValue = '';
    marketValue = dataOrderVOS!.marketValue;
    return marketValue;
  }

  String getOddFinally(GetH5OrderListDataRecordxDataOrderVOS dataOrderVOS) {
    String oddFinally = '';
    oddFinally = dataOrderVOS!.oddFinally;
    return oddFinally;
  }

  String getPlayName(GetH5OrderListDataRecordxDataOrderVOS dataOrderVOS) {
    String playName = '';
    playName = dataOrderVOS!.playName;
    return playName;
  }

  String getMatch(GetH5OrderListDataRecordxDataOrderVOS dataOrderVOS) {
    String matchInfo = '';
    matchInfo = dataOrderVOS!.matchInfo;
    return matchInfo;
  }

  String setSettleScore(GetH5OrderListDataRecordxDataOrderVOS dataOrderVOS) {
    String settleScore = '';
    settleScore = dataOrderVOS!.settleScore;
    return settleScore;
  }
  bool setBetResultColor(GetH5OrderListDataRecordxDataOrderVOS dataOrderVOS){
    int result = dataOrderVOS!.betResult;
    return (result == 4 || result == 5);
  }

  String setBetResult(GetH5OrderListDataRecordxDataOrderVOS dataOrderVOS) {
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
    int result = dataOrderVOS!.betResult;
    if (result == 0) {
     // betResult = LocaleKeys.bet_record_bet_no_status00.tr + "  ";
    } else if (result == 2) {
      betResult = LocaleKeys.bet_record_account.tr+" "+LocaleKeys.bet_record_bet_no_status02.tr + "  ";
    } else if (result == 3) {
      betResult = LocaleKeys.bet_record_account.tr+" "+LocaleKeys.bet_record_bet_no_status03.tr + "  ";
    } else if (result == 4) {
      betResult = LocaleKeys.bet_record_account.tr+" "+LocaleKeys.bet_record_bet_no_status04.tr + "  ";
    } else if (result == 5) {
      betResult = LocaleKeys.bet_record_account.tr+" "+LocaleKeys.bet_record_bet_no_status05.tr + "  ";
    } else if (result == 6) {
      betResult = LocaleKeys.bet_record_account.tr+" "+LocaleKeys.bet_record_bet_no_status06.tr + "  ";
    } else if (result == 7) {
      betResult = LocaleKeys.bet_record_bet_no_status07.tr + "  ";
    } else if (result == 8) {
      betResult = LocaleKeys.bet_record_bet_no_status08.tr + "  ";
    } else if (result == 11) {
      betResult = LocaleKeys.bet_record_bet_no_status11.tr + "  ";
    } else if (result == 12) {
      betResult = LocaleKeys.bet_record_bet_no_status12.tr + "  ";
    } else if (result == 13) {
    } else if (result == 15) {
      betResult = LocaleKeys.bet_record_bet_no_status15.tr + "  ";
    } else if (result == 16) {
      betResult = LocaleKeys.bet_record_bet_no_status16.tr + "  ";
    }

    return betResult;
  }

  String getSportName(GetH5OrderListDataRecordxDataOrderVOS dataOrderVOS) {
    String sportName = '';
    String matchType ='';
    String marketType = "";

    int chType = dataOrderVOS!.matchType;
    if (chType == 1) {
      matchType= LocaleKeys.matchtype_1.tr;
    } else if (chType == 2) {
      matchType= LocaleKeys.new_menu_1.tr;
    } else if (chType == 3) {
      matchType= LocaleKeys.new_menu_4.tr;
    }

    String scoreBenchmark = '';

    if (dataOrderVOS != null && dataOrderVOS.scoreBenchmark.isNotEmpty) {
      scoreBenchmark = " (" +  dataOrderVOS.scoreBenchmark + ")";
    }

    String keType = dataOrderVOS!.marketType;
    if (keType == "EU") {
      marketType = '[' + LocaleKeys.odds_EU.tr + ']';
    } else if (keType == "GB") {
      marketType = '[' + LocaleKeys.odds_GB.tr + ']';
    } else if (keType == "HK") {
      marketType = '[' + LocaleKeys.odds_HK.tr + ']';
    } else if (keType == "ID") {
      marketType = '[' + LocaleKeys.odds_ID.tr + ']';
    } else if (keType == "MY") {
      marketType = '[' + LocaleKeys.odds_MY.tr + ']';
    } else if (keType == "US") {
      marketType = '[' + LocaleKeys.odds_US.tr + ']';
    }
    sportName = dataOrderVOS!.sportName +
        ' ' +matchType+' '+
        dataOrderVOS.playName +scoreBenchmark+
        ' ' +
        marketType;

    return sportName;
  }

  getScoreBenchmark(GetH5OrderListDataRecordxDataOrderVOS dataOrderVOS) {
    String scoreBenchmark = '';
    if (dataOrderVOS != null && dataOrderVOS.scoreBenchmark.isNotEmpty) {
      String benchmark =dataOrderVOS.scoreBenchmark.replaceAll(':', '-');
      scoreBenchmark= LocaleKeys.bet_record_settle_num.tr+"("+benchmark+")";
    }
    return scoreBenchmark;
  }
}
