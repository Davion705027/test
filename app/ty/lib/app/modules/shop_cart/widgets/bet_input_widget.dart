import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/utils/amount_util.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../global/user_controller.dart';
import '../shop_cart_controller.dart';
import '../shop_cart_theme.dart';

class BetInputWidget extends StatelessWidget {
  BetInputWidget(this.textEditingController, this.focusNode, this.minValue,
      this.maxValue, this.backgroundColor,
      {this.focusColor,
      this.unfocusColor,
      this.showCurrency,
      this.height = 44,
      this.textAlign,
      this.borderRadius = 12,
      Key? key})
      : super(key: key);
  TextEditingController textEditingController;
  FocusNode focusNode;
  String minValue;
  String maxValue;
  Color backgroundColor;
  Color? focusColor;
  Color? unfocusColor;
  bool? showCurrency;
  TextAlign? textAlign;
  double borderRadius;
  double height;

  final logic = ShopCartController.to.currentBetController;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Container(
        height: height.h,
        padding: const EdgeInsets.fromLTRB(12,0,12,0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: backgroundColor,
            border:focusNode.hasFocus && logic!.showKeyBoard && focusColor != null
                ? Border.all(
              color: focusColor!,
            ): (unfocusColor!=null?Border.all(
              color: unfocusColor!,
            ):null)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextField(
                controller: textEditingController,
                focusNode: focusNode,
                style: TextStyle(
                    fontSize: 18.sp,
                    fontFamily: 'Akrobat',
                    fontWeight: FontWeight.w700),
                //autofocus: true,
                textAlign: textAlign ?? TextAlign.start,
                enableInteractiveSelection: false,
                showCursor: true,
                readOnly: true,
                cursorColor: Colors.blue,
                cursorHeight:16.sp,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  hintText: '${LocaleKeys.app_h5_bet_limit.tr} ${AmountUtil.toAmountSplit(double.parse(minValue).toStringAsFixed(2))}-${ AmountUtil.toAmountSplit(double.parse(maxValue).toStringAsFixed(2))}',
                  hintStyle: TextStyle(
                    color: themeData.shopcartTintColor,
                    fontSize: 14.sp,
                    fontFamily: 'Akrobat',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            if (showCurrency == true)
              Text(
                UserController.to.currCurrency(),
                style: TextStyle(
                  color: themeData.shopcartLabelColor,
                  fontSize: 14.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w500,
                ),
              ),
          ],
        ));
  }
}
