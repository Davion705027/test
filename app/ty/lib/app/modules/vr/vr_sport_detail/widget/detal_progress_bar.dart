import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

enum detailProgressBarType { left, right }

class detailProgressBarWidget extends StatelessWidget {
   detailProgressBarWidget({
    super.key,
    required this.progress,
    required this.type,
    this.height = 4,
    required this.isBig,
    this.colorLeft,
    this.colorRight,
  });

  /// 0 - 100
  final int progress;
  final double? height;
  final detailProgressBarType type;
  final bool isBig;
  Color? colorLeft;
  Color? colorRight;

  @override
  Widget build(BuildContext context) {
    if (type == detailProgressBarType.left) {
      return SizedBox(
        height: height,
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              flex: 100 - progress,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.h),
                  color:context.isDarkMode?Colors.white.withOpacity(0.04): const Color(0xffF2F2F6),
                ),
              ),
            ),
            Expanded(
              flex: progress,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.h),
                  color: isBig
                      ? colorLeft!=null?colorLeft:const Color(0xFFF53F3F)

                      : Colors.white.withOpacity(0.25),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return SizedBox(
        height: height,
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              flex: progress,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.h),
                  color: isBig
                      ? colorRight!=null?colorRight:const Color(0xFFFEAE2B)
                      : Colors.white.withOpacity(0.25),
                ),
              ),
            ),
            Expanded(
              flex: 100 - progress,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.h),
                  color: context.isDarkMode?Colors.white.withOpacity(0.04): colorRight!=null?const Color(0xffE4E6ED):Color(0xffF2F2F6),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
