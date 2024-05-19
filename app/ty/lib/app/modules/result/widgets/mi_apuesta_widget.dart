
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/result/results_details/results_details_controller.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import '../../../core/format/common/module/format-date.dart';
import '../../../services/models/res/get_h5_order_list_entity.dart';
import '../../../services/models/res/playback_video_url_entity.dart';
import '../../../utils/amount_util.dart';
import '../../../utils/oss_util.dart';
import '../../../widgets/image_view.dart';
import 'package:intl/intl.dart';

import 'HeaderModel.dart';

class MiApuestaWidget extends StatelessWidget {
  const MiApuestaWidget({
    super.key,
    required this.isDark,
    required this.miApuestaData,
  });

  final bool isDark;
  final List<GetH5OrderListDataRecordxData> miApuestaData;


  @override
  Widget build(BuildContext context) {
    return Container(
      color: isDark ? null : Colors.white,
      height: double.maxFinite,
      child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: miApuestaData.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              color: isDark ? null : Colors.white,
              child: Container(
                margin: EdgeInsets.only(left: 10.w,right: 10.w,top: 5.h),
                padding: EdgeInsets.only(left: 10.w,right: 10.w,top: 10.h,bottom: 10.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Colors.blue,
                    width: 1.0,
                  ),
                ),
                child: Column(
                  children: [
                    if(int.parse(miApuestaData[index].seriesType) != 1)
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          miApuestaData[index].seriesValue,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: isDark ? Colors.white : const Color(0xFF303442),
                            fontSize: 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                    ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: miApuestaData[index].orderVOS.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index1) {
                          GetH5OrderListDataRecordxDataOrderVOS  orderVOS  = miApuestaData[index].orderVOS[index1];
                          return Column(
                            children: [
                              if(miApuestaData[index].matchType !=3 &&  miApuestaData[index].seriesType == '1' )
                                Container(
                                  margin: EdgeInsets.only(
                                    top: 10.h,
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          ImageView(
                                            orderVOS.tournamentPic,
                                            cdn: true,
                                            width: 20.w,
                                            height: 20.w,
                                          ).marginOnly(right: 8.w),
                                          Text(
                                            orderVOS.matchName,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: isDark
                                                  ? Colors.white
                                                  : const Color(0xFF414655),
                                              fontSize: 14.sp,
                                              fontFamily: 'PingFang SC',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        ],
                                      ),

                                      if(miApuestaData[index].preOrder!=null)
                                        Text(
                                          LocaleKeys.pre_record_book.tr,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color:
                                            isDark ? const Color.fromRGBO(23, 156, 255, 1) : const Color(0xFFffb001),
                                            fontSize: 14.sp,
                                            fontFamily: 'PingFang SC',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                    ],
                                  ),
                                ),
                              Container(
                                margin: EdgeInsets.only(
                                  top: 20.h,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        miApuestaData[index].seriesType == '1' ?
                                        Container(
                                          width: 3.w,
                                          height: 12.h,
                                          color: Colors.red,
                                        )
                                            :ImageView(
                                          orderVOS.tournamentPic,
                                          cdn: true,
                                          width: 22.w,
                                          height: 22.w,
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Text(
                                          orderVOS.matchInfo,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: isDark
                                                ? Colors.white
                                                : const Color(0xFF414655),
                                            fontSize: 14.sp,
                                            fontFamily: 'PingFang SC',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                    ),
                                    Text(
                                      formatDateTime(int.parse(orderVOS.beginTime)),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: isDark
                                            ? Colors.white
                                            : const Color(0xFF414655),
                                        fontSize: 12.sp,
                                        fontFamily: 'PingFang SC',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  left: 25.h,
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                        top: 10.h,
                                      ),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                '${orderVOS.sportName}   ${'types_competitions_matchtype_${orderVOS.matchType}'.tr}  ${orderVOS.playName}${orderVOS.scoreBenchmark.isEmpty ?  ''  : '('} ${orderVOS.scoreBenchmark.replaceAll(':', '-')} ${orderVOS.scoreBenchmark.isEmpty ? '' : ')'}  [${'types_competitions_odds_${orderVOS.marketType}'.tr}]'  ,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: isDark
                                                      ? Colors.white
                                                      : const Color(0xFF707070),
                                                  fontSize: 12.sp,
                                                  fontFamily: 'PingFang SC',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),

                                          if(orderVOS.settleScore!='' && miApuestaData[index].orderStatus != 1 && miApuestaData[index].seriesType!='1')
                                            Expanded(
                                              child: Container(
                                                alignment: Alignment.centerRight,
                                                child: Text(
                                                  orderVOS.settleScore,
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: isDark
                                                        ? Colors.white
                                                        : const Color(0xFF707070),
                                                    fontSize: 12.sp,
                                                    fontFamily: 'PingFang SC',
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            )
                                        ],
                                      ),
                                    ),

                                    Container(
                                      margin: EdgeInsets.only(
                                        top: 10.h,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                orderVOS.marketValue,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: isDark
                                                      ? Colors.white
                                                      : const Color(0xFF414655),
                                                  fontSize: 14.sp,
                                                  fontFamily: 'PingFang SC',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                '@ ${orderVOS.oddFinally}',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 14.sp,
                                                  fontFamily: 'PingFang SC',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )
                                            ],
                                          ),
                                          Text(
                                            calcText(miApuestaData[index],orderVOS),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: isDark
                                                  ? Colors.white
                                                  : const Color(0xFF707070),
                                              fontSize: 14.sp,
                                              fontFamily: 'PingFang SC',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ],
                          );
                        }),
                    Container(
                      margin: EdgeInsets.only(
                        top: 10.h,
                        left: 25.h,
                      ),
                      child: Row(
                        crossAxisAlignment:
                        CrossAxisAlignment.center,
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                LocaleKeys.app_betting.tr,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: isDark
                                      ? Colors.white
                                      : const Color(0xFF707070),
                                  fontSize: 12.sp,
                                  fontFamily: 'PingFang SC',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                AmountUtil.toAmountSplit(double.parse(miApuestaData[index].preSettleBetAmount.toString()).toStringAsFixed(2)),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: isDark
                                      ? Colors.white
                                      : const Color(0xFF707070),
                                  fontSize: 14.sp,
                                  fontFamily: 'PingFang SC',
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                LocaleKeys.bet_record_go_back.tr,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: isDark
                                      ? Colors.white
                                      : const Color(0xFF707070),
                                  fontSize: 12.sp,
                                  fontFamily: 'PingFang SC',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                AmountUtil.toAmountSplit(double.parse(miApuestaData[index].backAmount.toString()).toStringAsFixed(2)),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: isDark
                                      ? Colors.white
                                      : const Color(0xFF707070),
                                  fontSize: 14.sp,
                                  fontFamily: 'PingFang SC',
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.end,
                            children: [
                              Text(
                                getFooterScore(miApuestaData[index]),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: isDark
                                      ? Colors.white
                                      : const Color(0xFF707070),
                                  fontSize: 14.sp,
                                  fontFamily: 'PingFang SC',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                getFooterText(miApuestaData[index]),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: isDark
                                      ? Colors.white
                                      : const Color(0xFF707070),
                                  fontSize: 14.sp,
                                  fontFamily: 'PingFang SC',
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 10.h,

                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              top: 10.h,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                AutoSizeText(
                                  LocaleKeys.bet_order_no.tr,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: isDark
                                        ? Colors.white
                                        : const Color(0xFF414655),
                                    fontSize: 12.sp,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                AutoSizeText(
                                  miApuestaData[index].orderNo,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: isDark
                                        ? Colors.white
                                        : const Color(0xFF414655),
                                    fontSize: 10.sp,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                InkWell(
                                  onTap: () {
                                    Clipboard.setData(ClipboardData(text: miApuestaData[index].orderNo));
                                    ToastUtils.showGrayBackground(
                                        LocaleKeys.bet_record_copy_suc.tr);
                                  },
                                  child: ImageView(
                                    'assets/images/icon/copy.svg',
                                    cdn: false,
                                    width: 15.w,
                                    height: 15.w,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: 10.h,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                AutoSizeText(
                                  LocaleKeys.bet_record_bet_time.tr,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: isDark
                                        ? Colors.white
                                        : const Color(0xFF414655),
                                    fontSize: 12.sp,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                AutoSizeText(
                                  formatDateTime(int.parse(miApuestaData[index].betTime)),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: isDark
                                        ? Colors.white
                                        : const Color(0xFF414655),
                                    fontSize: 10.sp,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  formatDateTime(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var formatter = DateFormat('MM/dd HH:mm');
    return formatter.format(date);
  }

  String calcText(GetH5OrderListDataRecordxData miApues,GetH5OrderListDataRecordxDataOrderVOS vos) {
   String orderStatus = miApues.orderStatus;
   String seriesType = miApues.seriesType;
   int betStatus = vos.betStatus;
   int betResult = vos.betResult;
   int cancelType = vos.cancelType;


    String res = '';
    switch (orderStatus) {
      case '3':
      case '4':
        res = '';
        break;
      case '0':
        if (seriesType == '1') {
          res = '';
        } else {
          if (betStatus == 3 || betStatus == 4) {
            res = betResult3[cancelType] ?? LocaleKeys.bet_record_invalid;
          } else if (betStatus == 1) {
            if (betResult == 13 || betResult == 16) {
              res = LocaleKeys.bet_record_invalid;
            } else {
              res = betResultValue[betResult] ?? '';
            }
          } else {
            res = '';
          }
        }
        break;
      case '1':
        if (seriesType == '1') {
          res = '';
        } else {
          if (betStatus == 3 || betStatus == 4) {
            res = betResult3[cancelType] ?? LocaleKeys.bet_record_invalid;
          } else if (betStatus == 1) {
            if (betResult == 13 || betResult == 16) {
              res = LocaleKeys.bet_record_invalid;
            } else {
              if (seriesType == '3' && [2, 3, 4, 5, 6].contains(betResult)) {
                res = '';
                break;
              }
              res = betResultValue[betResult] ?? '';
            }
          } else {
            res = '';
          }
        }
        break;
      case '2':
        if (seriesType == '1') {
          res = '';
        } else {
          if (betStatus == 3 || betStatus == 4) {
            res = betResult3[cancelType] ?? LocaleKeys.bet_record_invalid;
          } else if (betStatus == 1) {
            res = betResult1[betResult] ?? LocaleKeys.bet_record_invalid;
          } else {
            res = '';
          }
        }
        break;
      default:
        break;
    }
    return res;
  }

  // 底部 订单状态 数
  String getFooterText(GetH5OrderListDataRecordxData data){
    String res = '';
    switch (data.orderStatus) {
      case '0':
        // classFooter.value = 'green';
        res = LocaleKeys.bet_record_successful_betting.tr;
        break;
      case '1':
        // classFooter.value = 'black';
        bool flag = data.seriesType == '1' && data.orderVOS != null && data.orderVOS.isNotEmpty;
        if (flag) {
          if (data.preBetAmount != null && int.parse(data.preBetAmount) > 0) {
            double difference = data.backAmount - data.orderAmountTotal;
            if (difference > 0) {
              // classFooter.value = 'red';
              // isWin.value = true;
              res = footBetResult[4] ?? '';
            } else if (difference < 0) {
              res = footBetResult[3] ?? '';
            } else {
              res = footBetResult[2] ?? '';
            }
            break;
          }
          int betResultValue = data.orderVOS[0].betResult;
          if (betResultValue == 13 || betResultValue == 16) {
            res = LocaleKeys.bet_record_invalid.tr;
          } else {
            if (betResultValue == 4 || betResultValue == 5) {
              // classFooter.value = 'red';
              // isWin.value = true;
            }
            res = footBetResult[betResultValue] ?? '';
          }
        } else {
          if (data.outcome == 4 || data.outcome == 5) {
            // classFooter.value = 'red';
            // isWin.value = true;
          }
          res = footOutcome[data.outcome] ?? LocaleKeys.bet_record_successful_betting.tr;
        }
        break;
      case '2':
        // classFooter.value = 'black';
        res = LocaleKeys.bet_record_invalid_bet.tr;
        break;
      case '3':
        // classFooter.value = 'orange';
        res = LocaleKeys.bet_record_confirming.tr;
        break;
      case '4':
        // classFooter.value = 'red';
        res = LocaleKeys.bet_bet_err.tr;
        break;
      default:
        res = '';
        break;
    }
    return res;
  }

  String getFooterScore(GetH5OrderListDataRecordxData data){
    if (data.seriesType == '1' && data.orderVOS != null && data.orderVOS.isNotEmpty) {
      if (data.orderStatus == '1') {
        return data.orderVOS[0].settleScore ?? '';
      } else if (data.orderStatus == '2') {
        int betStatus = data.orderVOS[0].betStatus;
        int betResult = data.orderVOS[0].betResult;
        int cancelType = data.orderVOS[0].cancelType;
        if (betStatus == 1) {
          return betResult1[betResult] ?? '';
        } else if (betStatus == 3 || betStatus == 4) {
          return betResult3[cancelType] ?? '';
        } else {
          return '';
        }
      } else {
        return '';
      }
    } else {
      return '';
    }
  }
}

Map betResultValue = {
    //'未结算',
    0: LocaleKeys.bet_record_bet_no_status00.tr,
    //'走水',
    2: LocaleKeys.bet_record_bet_no_status02.tr,
    //'输',
    3: LocaleKeys.bet_record_bet_no_status03.tr,
    //'赢',
    4: LocaleKeys.bet_record_bet_no_status04.tr,
     //'赢半',
    5: LocaleKeys.bet_record_bet_no_status05.tr,
    //'输半',
    6: LocaleKeys.bet_record_bet_no_status06.tr,
    //'比赛取消',
    7: LocaleKeys.bet_record_bet_no_status07.tr,
    //'比赛延期',
    8: LocaleKeys.bet_record_bet_no_status08.tr,
    // '比赛延迟',
    11: LocaleKeys.bet_record_bet_no_status11.tr,
    // '比赛中断',
    12: LocaleKeys.bet_record_bet_no_status12.tr,
    // '比赛放弃'
    15: LocaleKeys.bet_record_bet_no_status15.tr
};

Map betResult1 = {
  // '比赛取消',
  7: LocaleKeys.bet_record_bet_no_status07.tr,
  //'比赛延期',
  8: LocaleKeys.bet_record_bet_no_status08.tr,
  // '比赛延迟',
  11: LocaleKeys.bet_record_bet_no_status11.tr,
  // '比赛中断',
  12: LocaleKeys.bet_record_bet_no_status12.tr,
  // '比赛放弃'
  15: LocaleKeys.bet_record_bet_no_status15.tr,
};

//手动取消订单的原因展示
Map betResult3 = {
  1: LocaleKeys.bet_record_cancel_type_1.tr,
  2: LocaleKeys.bet_record_cancel_type_2.tr,
  3: LocaleKeys.bet_record_cancel_type_3.tr,
  4: LocaleKeys.bet_record_cancel_type_4.tr,
  5: LocaleKeys.bet_record_cancel_type_5.tr,
  6: LocaleKeys.bet_record_cancel_type_6.tr,
  17:LocaleKeys.bet_record_cancel_type_17.tr,
  20:LocaleKeys.bet_record_cancel_type_20.tr
};



// footer

Map footBetResult = {
  //'未结算',
  0: LocaleKeys.bet_record_bet_no_status00.tr,
  //'走水',
  2: LocaleKeys.bet_record_bet_no_status02.tr,
  //  //'输',
  3: LocaleKeys.bet_record_bet_no_status03.tr,
  // //'赢',
  4: LocaleKeys.bet_record_bet_no_status04.tr,
  // //'赢半',
  5: LocaleKeys.bet_record_bet_no_status05.tr,
  // //'输半',
  6: LocaleKeys.bet_record_bet_no_status06.tr,
  // //'比赛取消',
  7: LocaleKeys.bet_record_bet_no_status07.tr,
  // //'比赛延期',
  8: LocaleKeys.bet_record_bet_no_status08.tr,
  // // '比赛延迟',
  11: LocaleKeys.bet_record_bet_no_status11.tr,
  // // '比赛中断',
  12: LocaleKeys.bet_record_bet_no_status12.tr,
  // // '比赛放弃'
  15: LocaleKeys.bet_record_bet_no_status15.tr,
};
Map footOutcome = {
  // //'走水',
  2: LocaleKeys.bet_record_bet_no_status02.tr,
  // //'输',
  3: LocaleKeys.bet_record_bet_no_status03.tr,
  // //'赢',
  4: LocaleKeys.bet_record_bet_no_status04.tr,
  // //'赢半',
  5: LocaleKeys.bet_record_bet_no_status05.tr,
  // //'输半',
  6: LocaleKeys.bet_record_bet_no_status06.tr,
};