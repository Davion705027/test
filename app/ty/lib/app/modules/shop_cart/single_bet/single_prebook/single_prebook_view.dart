import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_theme.dart';
import 'package:get/get.dart';

import '../../../../../generated/locales.g.dart';
import '../../widgets/bet_input_widget.dart';
import '../../widgets/bet_item_widget.dart';
import '../../widgets/bet_slide_widget.dart';
import '../../widgets/number_keyboard.dart';
import '../../widgets/prebook_odd_widget.dart';
import '../../widgets/shop_cart_head.dart';
import 'single_prebook_controller.dart';

class SinglePrebookView extends StatelessWidget {
  SinglePrebookView(this.shopCartItem,this.shopCartBetStatus,this.orderResp,{Key? key}) : super(key: key);

  final shopCartItem;
  final shopCartBetStatus;
  final orderResp;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SinglePrebookController>(
      init: SinglePrebookController(shopCartItem,shopCartBetStatus,orderResp),
        builder: (logic)
    {
      ThemeData themeData = Theme.of(context);
      return Container(
          padding: EdgeInsets.only(bottom: 30),
          decoration: ShapeDecoration(
            color: themeData.shopcartBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShopCartHead(LocaleKeys.app_h5_bet_odd.tr),
                BetItemWidget(logic!.itemList.first),
                _buildInputWidget(context,logic),
                PrebookOddWidget(),
                GetBuilder<SinglePrebookController>(
                    id: "keyboard",
                    builder: (controller) {
                      if (controller.showKeyBoard) {
                        return NumberKeyboard(
                            currentValue: controller.amountController.text,
                            onTextInput: (myText) {
                              controller.insertText(myText);
                            },
                            onTextSet: (myText) {
                              controller.replaceText(myText);
                            },
                            onBackspace: () {
                              controller.backspace();
                            },
                            onCollapse: () {
                              controller.keyboardVisiable(false);
                            },
                            onMaxValue: () {
                              controller.maxInputText();
                            },
                            quickValues: logic.userCvoMoney,
                        );
                      } else {
                        return Container();
                      }
                    }
                ),
                _buildBetButton(context,logic),
              ]
          )
      );
    });
  }

  Widget _buildInputWidget(BuildContext context,SinglePrebookController logic){
    ThemeData themeData = Theme.of(context);
    return Container(
      margin: EdgeInsets.fromLTRB(14,6,14,8),
      child:Row(
        children: [
          Expanded(
              child: GetBuilder<SinglePrebookController>(
                  id: "input",
                  builder: (controller) {
                    return BetInputWidget(logic.amountController,logic.amountFocusNode,
                      logic.minValue,logic.maxValue,
                      themeData.shopcartContentBackgroundColor,
                      showCurrency: true,
                    );
                  }
              )
          ),
          SizedBox(width: 8.w,),
          InkWell(
            child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 5),
                width: 96.w,
                height: 44.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: themeData.shopcartBackgroundColor,
                  border: Border.all(
                    color: const Color(0xFF179CFF),
                  ),
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.center,
                  child: Text(LocaleKeys.app_h5_bet_cancel_appoint.tr,
                    style: TextStyle(
                      color: Color(0xFF179CFF),
                      fontSize: 16.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
            ),
            onTap: (){
              logic.cancelPrebook();
            },
          )
        ],
      ),
    );
  }

  Widget _buildBetButton(BuildContext context,SinglePrebookController logic){
    ThemeData themeData = Theme.of(context);
    bool isParlayDisable = logic!.itemList.safeFirst?.canParlay == false;
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child:Row(
          children: [
            Expanded(
              child: BetSlideWidget(isPrebook: true),
            ),
            const SizedBox(width: 8,),
            Container(
              width: 50.h,
              height: 50.h,
              padding: EdgeInsets.all(5),
              alignment: Alignment.center,
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: themeData.shopcartParlayChangeBackgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.h),
                ),
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.center,
                child: Text(
                  '+${LocaleKeys.app_h5_bet_parlay.tr.replaceAll(' ', '\n')}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isParlayDisable?Colors.white:const Color(0xFF179CFF),
                    fontSize: 18.h,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
          ],
        )
    );
  }
}
