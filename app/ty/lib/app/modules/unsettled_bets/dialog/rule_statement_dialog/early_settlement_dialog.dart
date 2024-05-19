import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import 'package:get/get.dart';

import '../../../../../generated/locales.g.dart';
import '../../bookin_bets/bookin_bets_logic.dart';

class EarlySettlementDialogPage extends StatelessWidget {
  const EarlySettlementDialogPage({Key? key, required this.state})
      : super(key: key);

  final bool state;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.center,
      insetPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      titlePadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      backgroundColor: Colors.transparent,
      elevation: 0,
      //SingleChildScrollView
      content: _body(
        context,
      ),
    );
  }

  Widget _body(BuildContext context) {
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (state)
                  ImageView(
                    'assets/images/bets/tandem_success.png',
                    width: 22.w,
                    height: 22.h,
                  ),
                if (state)
                  SizedBox(
                    width: 12.w,
                  ),
                Text(
                  state
                      ? LocaleKeys.early_btn5.tr
                      : LocaleKeys.early_btn2.tr + LocaleKeys.early_btn4.tr,
                  style: TextStyle(
                    color: Color(context.isDarkMode ? 0xFFE9E9EA : 0xFF303442),
                    fontSize: 16.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 44.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border(
              top: BorderSide(
                width: 1,
                color: Color(context.isDarkMode ? 0xFF272931 : 0xFFF3FAFF),
              ),
            )),
            child: InkWell(
              onTap: () => {
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
    );
  }
}
