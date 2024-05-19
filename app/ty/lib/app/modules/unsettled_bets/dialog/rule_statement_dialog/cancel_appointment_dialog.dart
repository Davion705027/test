import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import 'package:get/get.dart';

import '../../../../../generated/locales.g.dart';
import '../../bookin_bets/bookin_bets_logic.dart';

class CancelAppointmentDialogPage extends StatelessWidget {
  const CancelAppointmentDialogPage({Key? key, required this.index})
      : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<BookinBetsLogic>();
    return AlertDialog(
      alignment: Alignment.center,
      insetPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      titlePadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      backgroundColor: Colors.transparent,
      elevation: 0,
      //SingleChildScrollView
      content: _body(context, logic),
    );
  }

  Widget _body(BuildContext context, BookinBetsLogic logic) {
    return Container(
      width: 256.w,
      height: 160.h,
      decoration: ShapeDecoration(
        color: context.isDarkMode ? const Color(0xFF1E2029) : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x4C000000),
            blurRadius: 10,
            offset: Offset(0, 0),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  LocaleKeys.app_h5_cathectic_kind_tips.tr,
                  style: TextStyle(
                    color: Color(context.isDarkMode ? 0xFFE9E9EA : 0xFF303442),
                    fontSize: 16.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 22.h,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10.h, right: 10.h),
                  alignment: Alignment.topCenter,
                  child: Text(
                    LocaleKeys.app_h5_cathectic_confirm_cancel_reservation.tr,
                    style: TextStyle(
                      color: const Color(0xFF7981A4),
                      fontSize: 14.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 44.h,
            decoration: BoxDecoration(
                border: Border(
              top: BorderSide(
                width: 1,
                color: Color(context.isDarkMode ? 0xFF272931 : 0xFFF3FAFF),
              ),
            )),
            child: Row(
              children: [
                Expanded(
                    child: InkWell(
                  onTap: () => {
                    Navigator.of(context).pop(),
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      LocaleKeys.common_cancel.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color:
                            Color(context.isDarkMode ? 0xFF67696F : 0xFFAFB3C8),
                        fontSize: 16.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )),
                Container(
                  height: 44.h,
                  width: 1.w,
                  color: Color(context.isDarkMode ? 0xFF272931 : 0xFFF3FAFF),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () => {
                      logic.cancelPreBetOrder(index),
                      Navigator.of(context).pop(),
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        LocaleKeys.common_ok.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: context.isDarkMode
                              ? const Color(0xFF127DCC)
                              : const Color(0xff179CFF),
                          fontSize: 16.sp,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
