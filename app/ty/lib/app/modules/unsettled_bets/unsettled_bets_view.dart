import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/unsettled_bets/await_bets/await_bets_logic.dart';
import 'package:flutter_ty_app/app/modules/unsettled_bets/await_bets/await_bets_view.dart';
import 'package:flutter_ty_app/app/modules/unsettled_bets/bookin_bets/bookin_bets_logic.dart';
import 'package:flutter_ty_app/app/modules/unsettled_bets/bookin_bets/bookin_bets_view.dart';
import 'package:flutter_ty_app/app/modules/unsettled_bets/lapse_bets/lapse_bets_logic.dart';
import 'package:flutter_ty_app/app/modules/unsettled_bets/lapse_bets/lapse_bets_view.dart';
import 'package:flutter_ty_app/app/modules/unsettled_bets/unsettled_bets_logic.dart';
import 'package:get/get.dart';

import '../../../generated/locales.g.dart';

class UnsettledBetsPage extends StatefulWidget {
  const UnsettledBetsPage({Key? key}) : super(key: key);

  @override
  State<UnsettledBetsPage> createState() => _UnsettledBetsPageState();
}

class _UnsettledBetsPageState extends State<UnsettledBetsPage> {
  final logic = Get.find<UnsettledBetsLogic>();
  final state = Get.find<UnsettledBetsLogic>().state;
  Color? color;

  @override
  Widget build(BuildContext context) {
    color = Color(context.isDarkMode ? 0xFF1E2029 : 0xFFFFFFFF);
    return GetBuilder<UnsettledBetsLogic>(
      builder: (logic) {
        return AlertDialog(
          insetPadding: const EdgeInsets.fromLTRB(60, 80, 60, 0),
          contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          titlePadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: _title(),
          //SingleChildScrollView
          content: _body(),
        );
      },
    );
  }

  // 0xFF1E2029
  //导航部分
  Widget _title() {
    return Container(
      height: 35.h,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.all(Radius.circular(20))),
      padding: const EdgeInsets.all(3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _state(0, context),
          SizedBox(
            width: Get.locale?.languageCode == 'zh' ? 8.w : 5.w,
          ),
          _state(1, context),
          SizedBox(
            width: Get.locale?.languageCode == 'zh' ? 6.w : 5.w,
          ),
          _state(2, context),
        ],
      ),
    );
  }

  //头部切换Widget
  Widget _state(int type, BuildContext context) {
    return Expanded(
        flex: 1,
        child: InkWell(
          onTap: () => logic.setType(type),
          child: Container(
            decoration: logic.type == type
                ? BoxDecoration(
                    color: context.isDarkMode
                        ? const Color(0xFF127DCC)
                        : const Color(0xff179CFF),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  )
                : null,
            alignment: Alignment.center,
            child: Text(
              type == 0
                  ? LocaleKeys.bet_record_no_account.tr
                  : type == 1
                      ? LocaleKeys.pre_record_booking.tr
                      : LocaleKeys.pre_record_expired.tr,
              style: TextStyle(
                fontSize: Get.locale?.languageCode == 'zh'? 13.sp:12.sp,
             //  height: 1.h,
                fontWeight: FontWeight.w500,
                color: logic.type == type
                    ? Colors.white
                    : context.isDarkMode
                        ? Colors.white.withOpacity(0.5)
                        : const Color(0xff7981A4),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ));
  }

  //内容
  Widget _body() {
    return InkWell(
      onTap: () => {
        Navigator.of(context).pop(),
      },
      child: Container(
        width: 400.w,
        //    decoration: BoxDecoration(color: Colors.black),
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(top: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (logic.type == 0) _awaitBets(),
            if (logic.type == 1) _bookingBets(),
            if (logic.type == 2) _lapseBets(),
          ],
        ),
      ),
    );
  }

  ///未结算
  Widget _awaitBets() {
    Get.delete<BookinBetsLogic>();
    Get.delete<LapseBetsLogic>();
    Get.lazyPut(() => AwaitBetsLogic());
    return AwaitBetsPage();
  }

  ///预约中
  Widget _bookingBets() {
    Get.delete<AwaitBetsLogic>();
    Get.delete<LapseBetsLogic>();
    Get.lazyPut(() => BookinBetsLogic());
    return BookinBetsPage();
  }

  ///已失效
  Widget _lapseBets() {
    Get.delete<AwaitBetsLogic>();
    Get.delete<BookinBetsLogic>();
    Get.lazyPut(() => LapseBetsLogic());
    return LapseBetsPage();
  }

  @override
  void dispose() {
    Get.delete<UnsettledBetsLogic>();
    super.dispose();
  }
}
