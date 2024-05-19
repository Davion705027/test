import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_theme.dart';
import 'package:flutter_ty_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../config/theme/app_color.dart';
import '../../../core/format/common/module/format-currency.dart';
import '../../../global/user_controller.dart';
import '../../../widgets/image_view.dart';
import '../../shop_cart/widgets/balance_refresh_widget.dart';
import '../../shop_cart/widgets/number_keyboard.dart';
import 'one_click_betting_controller.dart';

class OneClickBettingPage extends StatefulWidget {
  const OneClickBettingPage({Key? key}) : super(key: key);

  @override
  State<OneClickBettingPage> createState() => _OneClickBettingPageState();
}

class _OneClickBettingPageState extends State<OneClickBettingPage> {
  final controller = Get.find<OneClickBettingController>();
  final logic = Get.find<OneClickBettingController>().logic;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OneClickBettingController>(
      builder: (controller) {
        return Scaffold(
          body: Container(
            color: context.isDarkMode
                ? const Color(0xFF1E2029)
                : const Color(0xFFF2F2F6),
            child: Stack(
              children: [
                SafeArea(
                  child: Column(
                    children: [
                      //头部
                      _title(),
                      _menu(),
                    ],
                  ),
                ),
                //自定义金额栏
                _customAmountColumn(),
              ],
            ),
          ),
        );
      },
    );
  }

  //头部
  Widget _title() {
    return SizedBox(
      height: 48.h,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.withOpacity(0.5),
              width: 0.5,
            ),
          ),
        ),
        child: Container(
          margin: EdgeInsets.only(left: 14.w, right: 14.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => Get.back(),//offNamed导致串关小球补显示   Get.offNamed(Routes.mainTab),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 20.w,
                  color: context.isDarkMode
                      ? Colors.white
                      : const Color(0xFF303442),
                ),
              ),
              Text(
                LocaleKeys.bet_one_click_bet.tr,
                style: TextStyle(
                  color: context.isDarkMode
                      ? Colors.white
                      : const Color(0xFF303442),
                  fontSize: 16.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 25.w,
              ),
            ],
          ),
        ),
      ),
    );
  }

  //菜单
  Widget _menu() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            top: 10.w,
          ),
          height: 48.h,
          decoration: BoxDecoration(
            color: context.isDarkMode ? const Color(0xFF272931) : Colors.white,
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.withOpacity(0.5),
                width: 0.5,
              ),
            ),
          ),
          child: InkWell(
            onTap: () => controller.onOneClickBetting(),
            child: Container(
              margin: EdgeInsets.only(left: 20.w, right: 20.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    LocaleKeys.bet_one_click_bet.tr,
                    style: TextStyle(
                      color: context.isDarkMode
                          ? Colors.white
                          : const Color(0xFF303442),
                      fontSize: 16.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  controller.switchOn == true
                      ? ImageView(
                          "assets/images/icon/one_click_pass1.png",
                          width: 36.w,
                          height: 18.h,
                        )
                      : ImageView(
                          "assets/images/icon/one_click_pass.png",
                          width: 40.w,
                          height: 20.h,
                        ),
                ],
              ),
            ),
          ),
        ),
        if (controller.switchOn == true)
          Container(
            height: 48.h,
            decoration: BoxDecoration(
              color:
                  context.isDarkMode ? const Color(0xFF272931) : Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.withOpacity(0.5),
                  width: 0.5,
                ),
              ),
            ),
            child: Container(
              margin: EdgeInsets.only(left: 20.w, right: 20.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    LocaleKeys.bet_record_bet_val.tr,
                    style: TextStyle(
                      color: context.isDarkMode
                          ? Colors.white
                          : const Color(0xFF303442),
                      fontSize: 16.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  InkWell(
                    onTap: () => controller.onCloseVisibility(),
                    child: Row(
                      children: [
                        Text(
                          controller.toAmountSplit(
                              controller.fastBetAmount.toStringAsFixed(2)),
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          width: 5.w,
                        ),
                        ImageView(
                          "assets/images/icon/edit_icon.svg",
                          width: 22.w,
                          height: 22.w,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
      ],
    );
  }

  //自定义金额栏
  Widget _customAmountColumn() {
    ThemeData themeData = Theme.of(context);
    return Visibility(
      visible: controller.betAmount,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => controller.onCloseVisibility(),
            child: Container(
              height: double.maxFinite,
              color: Colors.black.withOpacity(0.6),
            ),
          ),
          Column(
            children: [
              const Expanded(child: SizedBox()),
              Container(
                margin: EdgeInsets.only(
                  bottom: 15.h,
                  right: 15.w,
                ),
                child: Row(
                  children: [
                    const Expanded(child: SizedBox()),
                    InkWell(
                      onTap: () => controller.onCloseVisibility(),
                      child: Container(
                        width: 30.w,
                        height: 30.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.withOpacity(0.4),
                        ),
                        child: const Icon(
                          Icons.close_sharp,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: ShapeDecoration(
                  color: context.isDarkMode
                      ? const Color(0xFF1E2029)
                      : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.r),
                      topRight: Radius.circular(24.r),
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          left: 15.w, right: 15.w, top: 15.h, bottom: 5.h),
                      padding: const EdgeInsets.all(12),
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: context.isDarkMode
                            ? const Color(0xFF272931)
                            : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            LocaleKeys.bet_one_click_bet.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 14.sp,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
                                Obx(() => Text(
                                      TYFormatCurrency.formatCurrency(
                                          UserController
                                              .to.balanceAmount.value),
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: themeData.shopcartTextColor,
                                        fontSize: 14.sp,
                                        fontFamily: 'Akrobat',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )),
                                SizedBox(width: 4.w),
                                BalanceRefreshWidget(
                                  width: 20.w,
                                  height: 20.h,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: 15.w,
                        right: 15.w,
                      ),
                      decoration: ShapeDecoration(
                        color: context.isDarkMode
                            ? const Color(0xFF272931)
                            : const Color(0xFFF3FAFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  LocaleKeys.bet_record_bet_val.tr,
                                  style: TextStyle(
                                    color: const Color(0xFF7981A3),
                                    fontSize: 12.sp,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 5.w),
                                      height: 15.h,
                                      width: 2.w,
                                      color: Colors.blue,
                                    ),
                                    Text(
                                      '${LocaleKeys.app_h5_filter_lowest_money.tr} ${controller.min}${ ' ${UserController.to.currCurrency()}'}',
                                      style: TextStyle(
                                        color: const Color(0xFF7981A3),
                                        fontSize: 12.sp,
                                        fontFamily: 'PingFang SC',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 10.w,
                          ),
                          Expanded(
                            flex: 5,
                            child: Container(
                              height: 40.h,
                              margin: EdgeInsets.only(
                                top: 10.w,
                                bottom: 10.h,
                              ),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: context.isDarkMode
                                    ? const Color(0xFF272931)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(
                                  left: 10.w,
                                  right: 10.h,
                                ),
                                child: TextField(
                                  controller: controller.textEditingController,
                                  focusNode: controller.focusNode,
                                  keyboardType: TextInputType.number,
                                  readOnly: true,
                                  autofocus: true,
                                  showCursor: true,
                                  cursorColor: Colors.blue,
                                  style: TextStyle(
                                    color: context.isDarkMode
                                        ? Colors.white
                                        : AppColor.backgroundColor,
                                    fontSize: 14.sp,
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(10.h),
                                    hintText:
                                    '${LocaleKeys.bet_record_bet_val.tr}  0',
                                    hintStyle: TextStyle(
                                      color: const Color(0xFF7981A3),
                                      fontSize: 12.sp,
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white.withOpacity(0.0)),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white.withOpacity(0.0)),
                                    ),
                                    suffixIcon: Container(
                                      margin: EdgeInsets.all(10.h,),
                                      child: Text(
                                        UserController.to.currCurrency(),
                                        style: TextStyle(
                                          color: const Color(0xFF7981A4),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    NumberKeyboard(
                      currentValue: controller.textEditingController.text,
                      quickValues: controller.singleList,
                      onTextInput: (myText) => controller.onInsertText(myText),
                      onBackspace: () => controller.onBackspace(),
                      onCollapse: () => controller.onCloseVisibility(),
                      onMaxValue: () => controller.onMaxInputText(),
                      onTextSet: (myText) => controller.replaceText(myText),
                    ),
                    InkWell(
                      onTap: () => controller.onOK(),
                      child: Container(
                        height: 45.h,
                        width: double.maxFinite,
                        margin: EdgeInsets.only(
                            left: 15.w, right: 15.w, bottom: 30.h),
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF179CFF), Color(0xFF45B0FF)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            LocaleKeys.common_ok.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFFFFFFFF),
                              fontSize: 14.sp,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<OneClickBettingController>();
    super.dispose();
  }
}
