import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../utils/oss_util.dart';
import '../../../../widgets/image_view.dart';

class BigAndSmallBallWidget extends StatelessWidget {
  const BigAndSmallBallWidget({
    super.key,
    required this.isDark,
    required this.title,
    required this.subTitle,
    required this.lTitle,
    required this.lSubTitle,
    required this.lSubTitleColor,
    required this.lSubTitleTextColor,
    required this.cTitle,
    required this.cSubTitle,
    required this.rTitle,
    required this.rSubTitle,
    required this.rSubTitleColor,
    required this.rSubTitleTextColor,
  });

  final bool isDark;
  final String title;
  final String subTitle;
  final String lTitle;
  final String lSubTitle;
  final Color lSubTitleColor;
  final Color lSubTitleTextColor;
  final String cTitle;
  final String cSubTitle;
  final String rTitle;
  final String rSubTitle;
  final Color rSubTitleColor;
  final Color rSubTitleTextColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16.h),
      decoration: isDark
          ? BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25.r)),
              image:  DecorationImage(
                image: NetworkImage(
                  OssUtil.getServerPath(
                    'assets/images/icon/tutorial_background_darks.png',
                  ),
                ),

                fit: BoxFit.cover,
              ),
            )
          : BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(25.r),
              ),
            ),
      child: Container(
        margin: EdgeInsets.only(top: 12.h, bottom: 24.h),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isDark
                      ? Colors.white.withOpacity(0.8999999761581421)
                      : const Color(0xFF333333),
                  fontSize: 18.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              color: isDark
                  ? Colors.white.withOpacity(0.07999999821186066)
                  : const Color(0xFFFBFBFB),
              margin: EdgeInsets.only(
                top: 12.h,
              ),
              height: 1.h,
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 12.h, bottom: 12.h),
              child: Text(
                subTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isDark
                      ? const Color.fromRGBO(255, 255, 255, 0.4)
                      : const Color(0xFF8D8D8D),
                  fontSize: 13.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: 4.h,
                      ),
                      child: Text(
                        lTitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isDark
                              ? Colors.white.withOpacity(0.8999999761581421)
                              : const Color(0xFF333333),
                          fontSize: 16.sp,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.h),
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        color: lSubTitleColor,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 0.50, color: Color(0x19F53F3F)),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: Container(
                        margin: EdgeInsets.only(
                          left: 10.w,
                          right: 10.w,
                          top: 2.h,
                          bottom: 2.h,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          lSubTitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: lSubTitleTextColor,
                            fontSize: 12.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: 80.w,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 4.h,
                        ),
                        child: Text(
                          cTitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withOpacity(0.8999999761581421)
                                : const Color(0xFF333333),
                            fontSize: 32.sp,
                            fontFamily: 'Akrobat',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 4.h,
                        ),
                        child: Text(
                          cSubTitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color.fromRGBO(255, 255, 255, 0.4),
                            fontSize: 12.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: 4.h,
                      ),
                      child: Text(
                        rTitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isDark
                              ? Colors.white.withOpacity(0.8999999761581421)
                              : const Color(0xFF333333),
                          fontSize: 16.sp,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.h),
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        color: rSubTitleColor,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 0.50.w,
                            color: const Color(0x1900B42A),
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: Container(
                        margin: EdgeInsets.only(
                          left: 10.w,
                          right: 10.w,
                          top: 2.h,
                          bottom: 2.h,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          rSubTitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: rSubTitleTextColor,
                            fontSize: 12.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                  ],
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
