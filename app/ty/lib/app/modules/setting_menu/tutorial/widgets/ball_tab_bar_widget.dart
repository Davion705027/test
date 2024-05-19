import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import '../../../../../generated/locales.g.dart';

class BallTabBarWidget extends StatelessWidget {
  const BallTabBarWidget({
    super.key,
    required this.title,
    required this.isSelected,
    required this.isDark,
  });

  final String title;
  final bool isSelected;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 12.w,
      ),
      decoration: getShapeDecoration(),
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 20.w, right: 20.w,top: 4.h,bottom: 4.h),
        child: Text(
          '$title${LocaleKeys.app_h5_handicap_tutorial_ball.tr.replaceAll('%s', '')}',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isDark
                ? Colors.white
                : isSelected
                    ? Colors.white
                    : const Color(0xFF333333),
            fontSize: 14.sp,
            fontFamily: 'PingFang SC',
          ),
        ),
      ),
    );
  }

  getShapeDecoration() {
    if (isDark) {
      return isSelected
          ? ShapeDecoration(
              color: Colors.white.withOpacity(0.07999999821186066),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  color: Colors.white.withOpacity(0.11999999731779099),
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x051B1E26),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            )
          : ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  color: Colors.white.withOpacity(0.20000000298023224),
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x051B1E26),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            );
    } else {
      return isSelected
          ? ShapeDecoration(
              color: Color(0xFF333333),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x051B1E26),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            )
          : ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1.w, color: Color(0xFF333333)),
                borderRadius: BorderRadius.circular(20),
              ),
              shadows: [
                BoxShadow(
                  color: const Color(0x051B1E26),
                  blurRadius: 12.r,
                  offset: const Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            );
    }
  }
}
