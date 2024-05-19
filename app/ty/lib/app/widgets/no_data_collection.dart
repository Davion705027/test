import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:get/get.dart';

import '../modules/match_detail/constant/detail_constant.dart';
import 'image_view.dart';

/// 无数据展示页
class NoDataCollect extends StatelessWidget {
  const NoDataCollect(
      {super.key, required this.content, this.top, this.backHeader = false});

  final bool backHeader;

  /// 展示文本
  final String content;

  final double? top;

  @override
  Widget build(BuildContext context) {
    bool isDark = Get.isDarkMode;
    return Container(
      color:isDark ?  null:Color(0xffF2F2F6),
      alignment: Alignment.center,
      padding: EdgeInsets.only(top:Get.mediaQuery.padding.top),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          SizedBox(
            height: top ?? 144.h,
          ),
          Container(
            width: 240.w,
            height: 240.w,
            alignment: Alignment.center,
            child: Stack(
              alignment: Alignment.center,
              children: [
                ImageView(
                  isDark
                      ? 'assets/images/detail/no-data-bg-night.svg'
                      : 'assets/images/detail/no-data-bg.svg',
                  width: 239.w,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ImageView(
                      'assets/images/detail/def_nocollection.png',
                      width: 186.80.w,
                    ),
                    Text(
                      LocaleKeys.app_favorite_Tips.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isDark
                            ? Colors.white.withOpacity(0.5)
                            : const Color(0xFFafb3c8),
                        fontSize: 12.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),

          /*Text(
            content,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isDark
                  ? Colors.white.withOpacity(0.5)
                  : const Color(0xFFafb3c8),
              fontSize: 14.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w500,
            ),
          ),*/
        ],
      ),
    );
  }
}
