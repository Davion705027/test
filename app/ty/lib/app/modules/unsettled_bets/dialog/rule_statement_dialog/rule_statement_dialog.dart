import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import 'package:get/get.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../utils/oss_util.dart';




class RuleStatementDialogPage extends StatefulWidget {
  const RuleStatementDialogPage({Key? key}) : super(key: key);

  @override
  State<RuleStatementDialogPage> createState() => _RuleStatementDialogState();
}


class _RuleStatementDialogState extends State<RuleStatementDialogPage> {

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
      content: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      width: 256.w,
      decoration:  BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          image: DecorationImage(
            image: NetworkImage(
              OssUtil.getServerPath(
                context.isDarkMode
                    ? 'assets/images/bets/nighttime_bg.png'
                    : 'assets/images/bets/daytime_bg.png',
              ),
            ),
            fit: BoxFit.cover,
          ),
          color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
           Text(
            LocaleKeys.app_h5_cathectic_cash_rules.tr,
            textAlign: TextAlign.center,
            style:  TextStyle(
              color: context.isDarkMode?Colors.white.withOpacity(0.8999999761581421):Color(0xFF303442),
              fontSize: 14,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            height: 1,
            decoration: BoxDecoration(color:  context.isDarkMode?Colors.white.withOpacity(0.07999999821186066):Color(0xFFE4E6ED)),
          ),
          const SizedBox(height: 8),
           SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SizedBox(
                    child: Text(
                      LocaleKeys.app_h5_cathectic_explain1.tr+'\n'+LocaleKeys.app_h5_cathectic_explain2.tr,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: context.isDarkMode? Colors.white.withOpacity(0.8999999761581421):Color(0xFF303442),
                        fontSize: 12,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w400,
                        height: 1.75
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: ()=>{
              Navigator.of(context).pop(),
            },
            child:  Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    color: context.isDarkMode
                        ? const Color(0xFF127DCC)
                        : const Color(0xff179CFF),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    LocaleKeys.ac_rules_understand.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: context.isDarkMode
                          ? const Color(0xFF127DCC)
                          : const Color(0xff179CFF),
                      fontSize: 12.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
