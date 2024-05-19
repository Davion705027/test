import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/mix_bet/mix_bet_controller.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../utils/toast_util.dart';
import '../../../widgets/image_view.dart';
import '../shop_cart_controller.dart';

class ShopCartBall extends StatelessWidget {
  ShopCartBall({Key? key}) : super(key: key);

  final logic = ShopCartController.to;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {

          if(logic.currentBetController is MixBetController){
            int minSeriesNum = (logic.currentBetController! as MixBetController).minSeriesNum;

            if( logic.currentBetController!.itemCount < minSeriesNum) {
              String errorMsg = LocaleKeys.bet_bet_min_item.tr;
              errorMsg = errorMsg.replaceAll('{num}', minSeriesNum.toString());

              ToastUtils.showGrayBackground(errorMsg);
              return;
            }
          }
          logic.currentBetController?.showBet(queryAmount: true);
        },
        child: Stack(
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 10.w,left: 4.w),
              margin: EdgeInsets.all(5.w),
              decoration: ShapeDecoration(
                gradient: const LinearGradient(
                  begin: Alignment(-0.04, 1.00),
                  end: Alignment(0.04, -1),
                  colors: [Color(0xFF179CFF), Color(0xFF45B0FF)],
                ),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    color: Colors.white.withOpacity(0.2),
                  ),
                  borderRadius: BorderRadius.circular(40.w),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x333C71FA),
                    blurRadius: 12,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: ImageView(
                Get.locale?.languageCode=='zh' || Get.locale?.languageCode=='tw'?'assets/images/shopcart/shrink2.png':'assets/images/shopcart/shrink_p2.png',
                width: 40.w,
                boxFit: BoxFit.fitWidth,
              ),
            ),
            Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 20.w,
                  height: 20.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.w),
                      border: Border.all(
                        color: const Color(0XFFFFFFFF),
                      ),
                      color: const Color(0XFFE95B5B)),
                  child: Text(
                    logic.currentBetController?.itemCount?.toString() ?? '',
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: const Color(0XFFFFFFFF),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ))
          ],
        ));
  }
}
