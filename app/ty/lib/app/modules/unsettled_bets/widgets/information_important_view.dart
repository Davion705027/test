import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/db/app_cache.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

class InformationImportantView extends StatelessWidget {
  const InformationImportantView({
    Key? key,
    required this.information,
    required this.outcome,
    this.scoreBenchmark="",

  }) : super(key: key);

  final String information, outcome,scoreBenchmark;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 6.h),
      decoration: BoxDecoration(
          color: Get.isDarkMode
              ? const Color(0xFF127DCC)
              : const Color(0xff179CFF),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            information,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          Container(
            height: 3.h,
          ),
          Text(
            outcome,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w400,
            ),
          ),
          if (scoreBenchmark.isNotEmpty)
          Container(
            height: 3.h,
          ),
          if (scoreBenchmark.isNotEmpty)
          Text(
            scoreBenchmark,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }
}
