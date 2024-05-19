import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TitleView extends StatelessWidget {
  const TitleView({
    Key? key,
    required this.information,
    required this.outcome,
  }) : super(key: key);
  final String information, outcome;

  @override
  Widget build(BuildContext context) {
    Color color = context.isDarkMode
        ? Colors.white.withOpacity(0.8999999761581421)
        : const Color(0xFF303442);
    return Row(
        //  crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 5.w),
              child: Text(
                information,
                style: TextStyle(
                  color: color,
                  fontSize: 13.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w400,
                ),
                textAlign:TextAlign.center,
            //   maxLines: 1,
            //   overflow: TextOverflow.ellipsis,
              ),
            ),
          ),

          Column(
            children: [
              Container(
                height: Get.locale?.languageCode == 'zh' ? 2.h : 0.h,
              ),
              Text(
                "VS",
                style: TextStyle(
                  color: color,
                  fontSize: 13.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 5.w),
              child: Text(
                outcome,
                style: TextStyle(
                  color: color,
                  fontSize: 13.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w400,
                ),
                  textAlign:TextAlign.center,
              //  maxLines: 1,
              //  overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ]);
  }
}
