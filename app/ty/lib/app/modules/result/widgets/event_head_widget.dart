import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventHeadWidget extends StatelessWidget {
  const EventHeadWidget({
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
    return Container(
      margin: EdgeInsets.only(
        left: 20.w,
      ),
      child: InkWell(
        onTap: onTap,
        child: Stack(
          alignment: Alignment.center,
          children: [
            isSelected
                ? Container(
                    width: 70.w,
                    height: 3.h,
                    margin: EdgeInsets.only(
                      top: 15.w,
                    ),
                    decoration: ShapeDecoration(
                      color: const Color(0xFF179CFF),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2)),
                    ),
                  )
                : Container(),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color:  isDark ? isSelected ?  Colors.white : Colors.white.withOpacity(0.5) : isSelected ?  const Color(0xFF303442) : const Color(0xFF303442),
                fontSize: isSelected ? 16.sp : 14.sp,
                fontFamily: 'PingFang SC',
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
