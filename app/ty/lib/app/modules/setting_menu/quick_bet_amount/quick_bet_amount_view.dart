import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/quick_bet_amount/widgets/no_amount_widget.dart';
import '../../../../generated/locales.g.dart';
import '../../../global/user_controller.dart';
import '../../shop_cart/widgets/number_keyboard.dart';
import 'quick_bet_amount_controller.dart';

class QuickBetAmountPage extends StatefulWidget {
  const QuickBetAmountPage({Key? key}) : super(key: key);

  @override
  State<QuickBetAmountPage> createState() => _QuickBetAmountPageState();
}

class _QuickBetAmountPageState extends State<QuickBetAmountPage> {
  final controller = Get.find<QuickBetAmountController>();
  final logic = Get.find<QuickBetAmountController>().logic;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuickBetAmountController>(
      builder: (controller) {
        return Scaffold(
          body: Container(
            color: context.isDarkMode ? const Color(0xFF1E2029) : Colors.white,
            child: Stack(
              children: [
                SafeArea(
                  child: Column(
                    children: [
                      //头部
                      _title(),
                      //单关投注
                      _singleLevelBetting(),
                      //串关投注
                      _matchBetting(),
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
                onTap: () => Get.back(),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 20.w,
                  color: context.isDarkMode
                      ? Colors.white
                      : const Color(0xFF303442),
                ),
              ),
              Text(
                LocaleKeys.app_h5_filter_customized_amount.tr,
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

  //单关投注
  Widget _singleLevelBetting() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            top: 10.h,
          ),
          child: Row(
            children: [
              ImageView(
                'assets/images/icon/title_tag.png',
                width: 3.w,
                height: 30.h,
              ),
              Container(
                width: 8.w,
              ),
              Text(
                LocaleKeys.common_single.tr,
                style: TextStyle(
                  color: context.isDarkMode
                      ? Colors.white
                      : const Color(0xFF303442),
                  fontSize: 12.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
        controller.downloadData == false
            ? const NoAmountWidget()
            : Container(
                margin: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h),
                decoration: BoxDecoration(
                  color: context.isDarkMode
                      ? const Color(0xFF0E1014)
                      : const Color(0xFFe4e6ed),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: GridView.builder(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 10.w,
                      mainAxisSpacing: 10.w,
                      crossAxisCount: 3,
                      childAspectRatio: 1.7,
                    ),
                    itemCount: controller.singleList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () => controller.onSelectSingleLevelBetting(
                            controller.singleList[index], index + 1),
                        child: Container(
                          margin:
                              EdgeInsets.only(top: 10.h, left: 5.w, right: 5.w),
                          child: Column(
                            children: [
                              AutoSizeText(
                                maxLines: 1,
                                '${LocaleKeys.app_h5_filter_quick_bet.tr}${index + 1}',
                                style: TextStyle(
                                  color: context.isDarkMode
                                      ? Colors.white
                                      : const Color(0xFF303442),
                                  fontSize: 12.sp,
                                  fontFamily: 'PingFang SC',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Container(
                                height: 25.h,
                                margin: EdgeInsets.only(top: 5.h),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: context.isDarkMode
                                      ? const Color(0xFF303442)
                                      : Colors.white,
                                  border:
                                      controller.selectedSingleLevelBetting ==
                                              controller.singleList[index].toString()
                                          ? Border.all(
                                              color: Colors.blue,
                                              width: 1.0,
                                            )
                                          : null,
                                ),
                                child: Text(
                                  '+ ${controller.toAmountSplit(controller.singleList[index].toString())}',
                                  style: TextStyle(
                                    color: context.isDarkMode
                                        ? Colors.white
                                        : const Color(0xFF303442),
                                    fontSize: 12.sp,
                                    fontFamily: 'Akrobat',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
      ],
    );
  }

  //串关投注
  Widget _matchBetting() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            top: 10.h,
          ),
          child: Row(
            children: [
              ImageView(
                'assets/images/icon/title_tag.png',
                width: 3.w,
                height: 30.h,
              ),
              Container(
                width: 8.w,
              ),
              Text(
                LocaleKeys.app_multi.tr,
                style: TextStyle(
                  color: context.isDarkMode
                      ? Colors.white
                      : const Color(0xFF303442),
                  fontSize: 12.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
        controller.downloadData == false
            ? const NoAmountWidget()
            : Container(
                margin: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h),
                decoration: BoxDecoration(
                  color: context.isDarkMode
                      ? const Color(0xFF0E1014)
                      : const Color(0xFFe4e6ed),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: GridView.builder(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 10.w,
                      mainAxisSpacing: 10.w,
                      crossAxisCount: 3,
                      childAspectRatio: 1.7,
                    ),
                    itemCount: controller.seriesList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () => controller.onSelectMatchBetting(
                            controller.seriesList[index], index + 1),
                        child: Container(
                          margin:
                              EdgeInsets.only(top: 10.h, left: 5.w, right: 5.w),
                          child: Column(
                            children: [
                              AutoSizeText(
                                maxLines: 1,
                                '${LocaleKeys.app_h5_filter_quick_bet.tr}${index + 1}',
                                style: TextStyle(
                                  color: context.isDarkMode
                                      ? Colors.white
                                      : const Color(0xFF303442),
                                  fontSize: 12.sp,
                                  fontFamily: 'PingFang SC',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Container(
                                height: 25.h,
                                margin: EdgeInsets.only(top: 5.h),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: context.isDarkMode
                                      ? const Color(0xFF303442)
                                      : Colors.white,
                                  border: controller.selectedMatchBetting ==
                                          controller.seriesList[index].toString()
                                      ? Border.all(
                                          color: Colors.blue,
                                          width: 1.0,
                                        )
                                      : null,
                                ),
                                child: Text(
                                  '+ ${controller.toAmountSplit(controller.seriesList[index].toString())}',
                                  style: TextStyle(
                                    color: context.isDarkMode
                                        ? Colors.white
                                        : const Color(0xFF303442),
                                    fontSize: 12.sp,
                                    fontFamily: 'Akrobat',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
      ],
    );
  }

  //自定义金额栏
  Widget _customAmountColumn() {
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
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 5.w),
                            height: 30,
                            width: 2.w,
                            color: Colors.blue,
                          ),
                          Text(
                            LocaleKeys.app_h5_filter_customized_amount.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: context.isDarkMode
                                  ? Colors.white
                                  : const Color(0xFF303442),
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
                        left: 15.w,
                        right: 15.w,
                      ),
                      child: Row(
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
                                Text(
                                  '${LocaleKeys.app_h5_filter_lowest_money.tr} 10￥',
                                  style: TextStyle(
                                    color: const Color(0xFF7981A3),
                                    fontSize: 12.sp,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w400,
                                  ),
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
                                    : const Color(0xFFF3FAFF),
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
                      onTextInput: (myText) => controller.onInsertText(myText),
                      onBackspace: () => controller.onBackspace(),
                      onCollapse: () => controller.onCloseVisibility(),
                      onMaxValue: () => controller.onMaxInputText(),
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
    Get.delete<QuickBetAmountController>();
    super.dispose();
  }
}
