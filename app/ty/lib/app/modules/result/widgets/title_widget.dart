import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key,
    required this.title,
    required this.isSelected,
    required this.isDark,
    this.onTap,
  });

  final String title;
  final bool isSelected;
  final bool isDark;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            margin:  EdgeInsets.only(left: 10.w,right: 10.w,),
            child: Text(
              title,
              maxLines: 1,
              // overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                color:  isDark ? isSelected ?  Colors.white : Colors.white.withOpacity(0.5) : isSelected ?  const Color(0xFF303442) : const Color(0xFF7981A3),
                fontSize: 16.sp,
                fontFamily: 'PingFang SC',
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
              ),
            ),
          ),
          Container(
            height: 2.h,
          ),
          isSelected
              ? Container(
                margin:  EdgeInsets.only(left: 10.w,right: 10.w,),
                  width: 64.w,
                  height: 2.h,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF179CFF),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2)),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
