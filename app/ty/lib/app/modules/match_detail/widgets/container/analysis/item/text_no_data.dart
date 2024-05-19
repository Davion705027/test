import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/config/theme/app_color.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import 'package:get/get.dart';
/// 无数据展示页 无网络带刷新按钮
class TextNoData extends StatelessWidget {
  String? content;
   TextNoData(
      {super.key,
      this.content,
      });


  @override
  Widget build(BuildContext context) {
    final bool isDark = Get.isDarkMode;
    return Container(
      alignment: Alignment.center,
      height: 50.w,
      child: Text(content??LocaleKeys.common_no_data.tr,style: TextStyle(fontSize: 10.sp,color: AppColor.tabSelectTextColor),),

    );
  }
}
