import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/core/format/index.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_theme.dart';
import 'package:get/get.dart';

import '../../../widgets/image_view.dart';
import '../single_bet/single_prebook/single_prebook_controller.dart';

class PrebookOddWidget extends StatelessWidget {
  PrebookOddWidget({Key? key}) : super(key: key);

  final logic = Get.find<SinglePrebookController>();

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: ShapeDecoration(
        color: themeData.shopcartContentBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            child: Container(
              width: 30,
              height: 30,
              alignment: Alignment.center,
              child: const ImageView('assets/images/shopcart/icon_addreduce1.png', width: 16,),
            ),
            onTap: (){
                logic.reduceOdd();
            },
          ),
          Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '@',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: themeData.shopcartTextColor,
                    fontSize: 14,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 2),
                Obx(()=>
                    Text(
                      TYFormatOddsConversionMixin.formatOdds(logic.prebookOdd.value, int.tryParse(logic.itemList.first.sportId)??0),
                      style: TextStyle(
                        color: themeData.shopcartTextColor,
                        fontSize: 18.sp,
                        fontFamily: 'Akrobat',
                        fontWeight: FontWeight.w700,
                      ),
                    )
                ),
              ],
            ),
          ),
          InkWell(
            child: Container(
              width: 30,
              height: 30,
              alignment: Alignment.center,
              child: const ImageView('assets/images/shopcart/icon_addreserve1.png', width: 16,),
            ),
            onTap: (){
              logic.addOdd();
            },
          ),

        ],
      ),
    );
  }
}