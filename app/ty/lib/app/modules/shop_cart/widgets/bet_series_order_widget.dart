import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/core/format/common/module/format-currency.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/base/base_bet_controller.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_theme.dart';
import 'package:flutter_ty_app/app/core/format/index.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_util.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/widgets/bet_question_widget.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../global/user_controller.dart';
import '../../../services/models/res/bet_result_entity.dart';
import '../../../widgets/image_view.dart';
import '../mix_bet/mix_bet_controller.dart';
import '../model/bet_count_model.dart';
import '../shop_cart_controller.dart';

class BetSeriesOrderWidget extends StatelessWidget {
  BetSeriesOrderWidget(this.betResultOrder, {Key? key}) : super(key: key);

  BetResultSeriesOrderRespList betResultOrder;
  final logic = ShopCartController.to.currentBetController as MixBetController;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    double betMoney = (double.tryParse(betResultOrder.betAmount)??0.0)/100;
    String inputSummy = TYFormatMoney.formatMoney((double.tryParse(betResultOrder.seriesBetAmount)??0.0)/100);
    String profitAmount = TYFormatMoney.formatMoney((double.tryParse(betResultOrder.maxWinAmount)??0.0)/100);
    print(betResultOrder.seriesValue);
    print('LocaleKeys.bet_${logic.betSpecialSeries.first.id}'.tr);
    BetCountModel betCountModel = logic.betSpecialSeries.firstWhere((element) => element.localeName.tr.startsWith( betResultOrder.seriesValue), orElse: () => BetCountModel('','', '', 0));
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 14, vertical: 2),
        padding: const EdgeInsets.fromLTRB(0,16,0,2),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: themeData.shopcartContentBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      BetQuestionWidget(betCountModel),
                      const SizedBox(width: 2),
                      Text(betResultOrder.seriesValue,
                        style: TextStyle(
                          color: themeData.shopcartTextColor,
                          fontSize: 14.sp,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 6),
                      GetBuilder<MixBetController>(
                          id: "series_order_resp",
                          init: logic,
                          builder: (controller) {
                            return Text(
                              betResultOrder.orderStatusCode==0?LocaleKeys.bet_message_error.tr
                                  :betResultOrder.orderStatusCode==1?LocaleKeys.app_h5_bet_bet_confirm.tr
                                  :betResultOrder.orderStatusCode==2?LocaleKeys.bet_message_loading.tr
                                  :'',
                              style: TextStyle(
                                color: Color(0xFF179CFF),
                                fontSize: 12,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w400,
                              ),
                            );
                          }
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        TYFormatCurrency.formatCurrency(betMoney),
                        style: TextStyle(
                          color: themeData.shopcartTextColor,
                          fontSize: 20.sp,
                          fontFamily: 'Akrobat',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 2),
                      Text('x'+ betResultOrder.seriesSum.toString() ,
                        style: TextStyle(
                          color: themeData.shopcartLabelColor,
                          fontSize: 14.sp,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 8,),
            Container(
                padding: const EdgeInsets.fromLTRB(12, 4,12,4),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Get.theme.shopcartDividerColor,
                      width: 0.5,
                    ),
                  ),
                ),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child:FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child:RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '${LocaleKeys.app_h5_bet_expect_win.tr}:',
                                    style: TextStyle(
                                      color: themeData.shopcartLabelColor,
                                      fontSize: 12.sp,
                                      fontFamily: 'PingFang SC',
                                      fontWeight: FontWeight.w500,

                                    ),
                                  ),
                                  TextSpan(
                                    text: profitAmount+' ',
                                    style: TextStyle(
                                      color: Color(0xFFF53F3F),
                                      fontSize: 12.sp,
                                      fontFamily: 'Akrobat',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  TextSpan(
                                    text: UserController.to.currCurrency(),
                                    style: TextStyle(
                                      color: themeData.shopcartLabelColor,
                                      fontSize: 12.sp,
                                      fontFamily: 'PingFang SC',
                                      fontWeight: FontWeight.w500,

                                    ),
                                  ),
                                ],
                              ),
                            ))),
                    Expanded(
                        child:FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerRight,
                            child:RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: LocaleKeys.bet_sum2.tr + ':',
                                    style: TextStyle(
                                      color: themeData.shopcartLabelColor,
                                      fontSize: 12.sp,
                                      fontFamily: 'PingFang SC',
                                      fontWeight: FontWeight.w500,

                                    ),
                                  ),
                                  TextSpan(
                                    text: inputSummy+' ',
                                    style: TextStyle(
                                      color: themeData.shopcartLabelColor,
                                      fontSize: 12.sp,
                                      fontFamily: 'Akrobat',
                                      fontWeight: FontWeight.w700,

                                    ),
                                  ),
                                  TextSpan(
                                    text: UserController.to.currCurrency(),
                                    style: TextStyle(
                                      color: themeData.shopcartLabelColor,
                                      fontSize: 12.sp,
                                      fontFamily: 'PingFang SC',
                                      fontWeight: FontWeight.w500,

                                    ),
                                  ),
                                ],
                              ),
                            ))),

                  ],
                )
            ),
          ]
        )
    );
  }
}