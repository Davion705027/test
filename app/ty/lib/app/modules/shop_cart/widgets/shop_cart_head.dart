import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/core/format/common/module/format-currency.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_theme.dart';
import 'package:get/get.dart';

import '../../../global/user_controller.dart';
import 'balance_refresh_widget.dart';


class ShopCartHead extends StatelessWidget {
  const ShopCartHead(this.headType, {Key? key}) : super(key: key);
  final String headType;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Container(
      margin: const EdgeInsets.fromLTRB(14, 12, 14, 8),
      height: 28,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(1),
                    decoration: ShapeDecoration(
                      color: const Color(0xFF179CFF),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1.20,
                          color: Colors.white.withOpacity(0.2),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.center,
                      child: Text(
                        headType,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontFamily: 'FZLanTingHeiS-B-GB',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 2),
                  Expanded(
                    child:Text(
                      UserController.to.getTitle(),
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: themeData.shopcartTextColor,
                        fontSize: 16,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            height: 28,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: ShapeDecoration(
              color: themeData.shopcartContentBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(()=>Text(
                    TYFormatCurrency.formatCurrency(UserController.to.balanceAmount.value),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: themeData.shopcartTextColor,
                      fontSize: 18,
                      fontFamily: 'Akrobat',
                      fontWeight: FontWeight.w700,

                    ),
                  )
                ),
                const SizedBox(width: 4),
                const BalanceRefreshWidget(width:20,height:20),

              ],
            ),
          )
        ],
      ),
    );
  }
}