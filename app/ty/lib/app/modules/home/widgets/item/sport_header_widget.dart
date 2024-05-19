import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

import '../../../../config/theme/app_color.dart';

class SportHeaderWidget extends StatelessWidget {
  const SportHeaderWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.isDarkMode?null:const Color(0xfff2f2f6),
      height: 20.h,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Text(
        title,
        style: TextStyle(fontSize: 12.sp, color:context.isDarkMode? Colors.white.withOpacity(0.5):const Color(0xff7981A4)),
      ),
    );
  }
}
