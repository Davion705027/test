import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/image_view.dart';

class MenuSwitchWidget extends StatelessWidget {
  const MenuSwitchWidget({
    super.key,
    required this.title,
    required this.isDark,
    required this.switchA,
    required this.switchAParameter,
    this.switchAOnTap,
    required this.switchB,
    required this.switchBParameter,
    this.switchBOnTap,
    required this.dividing,
    this.disableSwitch,
  });

  final bool isDark;
  final bool dividing;
  final String title;
  final String switchA;
  final int switchAParameter;
  final VoidCallback? switchAOnTap;
  final bool? disableSwitch;

  final String switchB;
  final int switchBParameter;
  final VoidCallback? switchBOnTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      color:
          isDark ? Colors.white.withOpacity(0.03999999910593033) : Colors.white,
      child: Container(
        margin: EdgeInsets.only(
          left: 15.w,
          right: 15.w,
        ),
        decoration: dividing == true
            ? BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: isDark
                        ? Colors.white.withOpacity(0.07999999821186066)
                        : const Color(0xFFF2F2F6),
                    width: 0.50.h,
                  ),
                ),
              )
            : null,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: isDark
                    ? Colors.white.withOpacity(0.8999999761581421)
                    : const Color(0xFF303442),
                fontSize: 14.sp,
              ),
            ),
            Stack(children: [
              Container(
                alignment: Alignment.center,
                height: 28.h,
                decoration: ShapeDecoration(
                  color: isDark
                      ? Colors.white.withOpacity(0.03999999910593033)
                      : const Color(0xFF7981A3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.only(left: 2.w, right: 2.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: switchAOnTap,
                        child: Container(
                          alignment: Alignment.center,
                          height: 24.h,
                          decoration: switchAParameter == 1
                              ? ShapeDecoration(
                                  color: isDark
                                      ? Colors.white.withOpacity(0.20000000298023224)
                                      : Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                )
                              : null,
                          child: Container(
                            width: 60.w,
                            margin: EdgeInsets.only(left: 10.w, right: 10.w),
                            child: AutoSizeText(
                              switchA,
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: isDark
                                    ? Colors.white.withOpacity(0.5)
                                    : switchAParameter == 1
                                        ? const Color(0xff7981A4)
                                        : Colors.white,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: switchBOnTap,
                        child: Container(
                          alignment: Alignment.center,
                          height: 24.h,
                          decoration: switchBParameter == 2
                              ? ShapeDecoration(
                                  color: isDark
                                      ? Colors.white
                                          .withOpacity(0.20000000298023224)
                                      : Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                )
                              : null,
                          child: Container(
                            margin: EdgeInsets.only(left: 10.w, right: 10.w),
                            width: 60.w,
                            child: AutoSizeText(
                              switchB,
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: isDark
                                    ? Colors.white.withOpacity(0.5)
                                    : switchBParameter == 2
                                        ? const Color(0xff7981A4)
                                        : Colors.white,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if(disableSwitch == true)
                Positioned.fill(
                    child: Container(
                        decoration: ShapeDecoration(
                    color: isDark
                        ? Colors.white12.withOpacity(0.10000000298023224)
                        : Colors.white.withOpacity(.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  )
                )
                )
            ]
            ),
          ],
        ),
      ),
    );
  }
}
