import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/config/theme/app_color.dart';
import 'package:flutter_ty_app/app/widgets/image_view.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import 'package:get/get.dart';

import '../../../utils/oss_util.dart';
import 'language_logic.dart';

class LanguagePage extends StatefulWidget {
   const LanguagePage({Key? key}) : super(key: key);

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  final logic = Get.find<LanguageLogic>();
  final state = Get.find<LanguageLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LanguageLogic>(builder: (logic) {
      return Scaffold(
        body: _body(),
        backgroundColor: context.isDarkMode
            ? AppColor.titleBackgroundColor
            : Colors.white,
      );
    });
  }

  Widget _body() {
    return Container(
      decoration: context.isDarkMode
          ?  BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  OssUtil.getServerPath(
                    'assets/images/language/background_dark.png',
                  ),
                ),
                fit: BoxFit.cover,
              ),
            )
          : null,
      child: SafeArea(
        child: Column(
          children: [
            _title(context),
            Container(
              height: 10.h,
              color: Color(context.isDarkMode ? 0xFF15161B : 0xFFF2F2F6),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: logic.loadListLanguages(),
            ),
            Expanded(
              child: Container(
                height: 10.h,
                color: Color(context.isDarkMode ? 0xFF15161B : 0xFFF2F2F6),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title(BuildContext context) {
    return Container(
      color:  context.isDarkMode?null: Colors.white,
      height: 48.h,
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              if(!logic.changelan){
                Get.back();
              }

            },
            child: Icon(
              Icons.arrow_back_ios,
              size: 16.w,
              color:
                  context.isDarkMode ? Colors.white : const Color(0xFFC9CDDB),
            ),
          ),
          Text(
            LocaleKeys.setting_menu_chan_lan.tr,
            style: TextStyle(
              color:
                  context.isDarkMode ? Colors.white : const Color(0xFF303442),
              fontSize: 14.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            width: 25.w,
          ),
        ],
      ),
    );
  }

}
