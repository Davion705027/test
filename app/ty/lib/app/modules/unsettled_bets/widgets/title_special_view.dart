import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TitleSpecialView extends StatelessWidget {
  const TitleSpecialView({
    Key? key,
    required this.information,
  }) : super(key: key);
  final String information;

  @override
  Widget build(BuildContext context) {
    Color color = context.isDarkMode
        ? Colors.white.withOpacity(0.8999999761581421)
        : const Color(0xFF303442);
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 30.w),
      child: Text(
        information,
        style: TextStyle(
          color: color,
          fontSize: 14.sp,
          fontFamily: 'PingFang SC',
          fontWeight: FontWeight.w400,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
