import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import 'dashed_line_painter_view.dart';

class ShowAllSingleView extends StatelessWidget {
  const ShowAllSingleView({
    Key? key,
    required this.Expand,
    this.onTap,
  }) : super(key: key);

  final bool Expand;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {},
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: Expand
                      ? SizedBox(
                          height: 10.h,
                          width: 6.w,
                        )
                      : RepaintBoundary(
                          child: CustomPaint(
                            size: Size(1, 10.h),
                            painter: DashedLinePainter(
                              color: context.isDarkMode
                                  ? const Color(0xFF127DCC)
                                  : const Color(0xff179CFF),
                            ),
                          ),
                        ),
                ),
                if (!Expand)
                  Container(
                    width: 6.w,
                    height: 6.h,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: OvalBorder(
                        side: BorderSide(
                          width: 1,
                          strokeAlign: BorderSide.strokeAlignCenter,
                          color: context.isDarkMode
                              ? const Color(0xFF127DCC)
                              : const Color(0xff179CFF),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(
              width: 4.w,
            ),
            InkWell(
              onTap: onTap,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 12.w),
                decoration: ShapeDecoration(
                  color: context.isDarkMode
                      ? const Color(0xFF127DCC)
                      : const Color(0xff179CFF),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                //    margin: const EdgeInsets.only(top: 8),
                child: Text(
                  Expand
                      ? LocaleKeys.bet_record_pack_up.tr
                      : LocaleKeys.bet_record_pack_down.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
