import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/core/format/common/module/format-currency.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_theme.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../services/models/res/bet_result_entity.dart';
import '../shop_cart_controller.dart';

class BetOrderWidget extends StatelessWidget {
  BetOrderWidget(this.betResultOrder,{Key? key}) : super(key: key);

  BetResultOrderDetailRespList betResultOrder;
  final logic = ShopCartController.to.currentBetController;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    double betMoney = (double.tryParse(betResultOrder.betMoney)??0.0)/100;
    double maxWinMoney = (double.tryParse(betResultOrder.maxWinMoney)??0.0)/100;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14, vertical: 2),
      padding: const EdgeInsets.all(12),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: themeData.shopcartContentBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  LocaleKeys.bet_bet_val.tr,
                  style: TextStyle(
                    color: themeData.shopcartLabelColor,
                    fontSize: 12.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Text(
                TYFormatCurrency.formatCurrency(betMoney),
                style: TextStyle(
                  color: themeData.shopcartTextColor,
                  fontSize: 16.sp,
                  fontFamily: 'Akrobat',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  LocaleKeys.bet_bet_win.tr,
                  style: TextStyle(
                    color: themeData.shopcartLabelColor,
                    fontSize: 12.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Text(
              TYFormatCurrency.formatCurrency(maxWinMoney),
                style: TextStyle(
                  color: themeData.shopcartTextColor,
                  fontSize: 16.sp,
                  fontFamily: 'Akrobat',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  LocaleKeys.bet_order_no.tr,
                  style: TextStyle(
                    color: themeData.shopcartLabelColor,
                    fontSize: 12.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Text(
                betResultOrder.orderNo,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: themeData.shopcartLabelColor,
                  fontSize: 12.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      )
    );
  }
}