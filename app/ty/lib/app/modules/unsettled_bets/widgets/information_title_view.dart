import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/db/app_cache.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

class InformationTitleView extends StatelessWidget {
  const InformationTitleView({
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

    return Container(
      margin: EdgeInsets.only(top: 8.h, left: 10.w, right: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            information,
            style: TextStyle(
              color: color,
              fontSize: 12.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w400,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(left: 4.h),
              alignment: Alignment.centerRight,
              child: Text(
                outcome,
                style: TextStyle(
                  color: color,
                  fontSize: 12.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
