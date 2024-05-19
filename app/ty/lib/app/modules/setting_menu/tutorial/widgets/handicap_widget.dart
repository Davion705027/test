import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import '../../../../../generated/locales.g.dart';
import '../../../../utils/oss_util.dart';
import '../../../../widgets/image_view.dart';

class HandicapWidget extends StatelessWidget {
  const HandicapWidget({
    super.key,
    required this.isDark,
    required this.index,
  });

  final bool isDark;
  final int index;

  @override
  Widget build(BuildContext context) {
    if (index == 0) {
      return Container(
        decoration: isDark
            ? BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25.r)),
                image: DecorationImage(
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
                  '${LocaleKeys.app_h5_handicap_tutorial_ball.tr.replaceAll('%s', '0')} ${LocaleKeys.app_h5_handicap_tutorial_tie_handicap.tr}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isDark
                        ? Colors.white.withOpacity(0.8999999761581421)
                        : const Color(0xFF333333),
                    fontSize: 16.sp,
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
                margin: EdgeInsets.all(12.w),
                child: Text(
                  LocaleKeys.app_h5_handicap_tutorial_note_1.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isDark
                        ? Colors.white.withOpacity(0.5)
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
                      ImageView(
                        isDark
                            ? 'assets/images/icon/icon_teamlogo_dark.png'
                            : 'assets/images/icon/icon_teamlogo_light.png',
                        width: 32.w,
                        height: 32.w,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 4.h,
                        ),
                        width: 110.w,
                        child: Text(
                          LocaleKeys
                              .app_h5_handicap_tutorial_bet_home_team.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withOpacity(0.8999999761581421)
                                : Color(0xFF333333),
                            fontSize: 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: const Color(0x19F53F3F),
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
                            LocaleKeys.app_h5_handicap_tutorial_all_win.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFFF53F3F),
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
                    child:  Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '1',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isDark
                                    ? Colors.white
                                    .withOpacity(0.8999999761581421)
                                    : const Color(0xFF333333),
                                fontSize: 32.sp,
                                fontFamily: 'Akrobat',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 8.h, right: 8.h),
                              width: 9.19,
                              height: 3,
                              color: isDark
                                  ? Colors.white
                                  .withOpacity(0.8999999761581421)
                                  : const Color(0xFF333333),
                            ),
                            Text(
                              '0',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isDark
                                    ? Colors.white
                                    .withOpacity(0.8999999761581421)
                                    : Color(0xFF333333),
                                fontSize: 32.sp,
                                fontFamily: 'Akrobat',
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 4.h,
                          ),
                          child: Text(
                            LocaleKeys
                                .app_h5_handicap_tutorial_handicapData_condition
                                .tr,
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
                      ImageView(
                        isDark
                            ? 'assets/images/icon/icon_teamlogo_dark.png'
                            : 'assets/images/icon/icon_teamlogo_light.png',
                        width: 32.w,
                        height: 32.w,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 4.h,
                        ),
                        width: 110.w,
                        child: Text(
                          LocaleKeys
                              .app_h5_handicap_tutorial_bet_away_team.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withOpacity(0.8999999761581421)
                                : Color(0xFF333333),
                            fontSize: 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: const Color(0x1900B42A),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 0.50.w, color: Color(0x1900B42A)),
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
                            LocaleKeys.app_h5_handicap_tutorial_all_lose.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF00B42A),
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
                  LocaleKeys.app_h5_handicap_tutorial_note_2.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF8D8D8D),
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
                      ImageView(
                        isDark
                            ? 'assets/images/icon/icon_teamlogo_dark.png'
                            : 'assets/images/icon/icon_teamlogo_light.png',
                        width: 32.w,
                        height: 32.w,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 4.h,
                        ),
                        width: 110.w,
                        child: Text(
                          LocaleKeys
                              .app_h5_handicap_tutorial_bet_home_team.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withOpacity(0.8999999761581421)
                                : const Color(0xFF333333),
                            fontSize: 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: const Color(0x19AFAFAF),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 0.50, color: Color(0x19AFAFAF)),
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
                            LocaleKeys
                                .app_h5_handicap_tutorial_return_principal.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isDark ? const Color.fromRGBO(255, 255, 255, 0.4) : const Color(0xFFAFAFAF),
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
                    child:   Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '0',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isDark
                                    ? Colors.white
                                    .withOpacity(0.8999999761581421)
                                    : const Color(0xFF333333),
                                fontSize: 32.sp,
                                fontFamily: 'Akrobat',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 8.h, right: 8.h),
                              width: 9.19,
                              height: 3,
                              color: isDark
                                  ? Colors.white
                                  .withOpacity(0.8999999761581421)
                                  : const Color(0xFF333333),
                            ),
                            Text(
                              '0',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isDark
                                    ? Colors.white
                                    .withOpacity(0.8999999761581421)
                                    : const Color(0xFF333333),
                                fontSize: 32.sp,
                                fontFamily: 'Akrobat',
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 4.h,
                          ),
                          child: Text(
                            LocaleKeys
                                .app_h5_handicap_tutorial_handicapData_condition
                                .tr,
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
                      ImageView(
                        isDark
                            ? 'assets/images/icon/icon_teamlogo_dark.png'
                            : 'assets/images/icon/icon_teamlogo_light.png',
                        width: 32.w,
                        height: 32.w,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 4.h,
                        ),
                        width: 110.w,
                        child: Text(
                          LocaleKeys
                              .app_h5_handicap_tutorial_bet_away_team.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withOpacity(0.8999999761581421)
                                : const Color(0xFF333333),
                            fontSize: 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: const Color(0x19AFAFAF),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 0.50, color: Color(0x19AFAFAF)),
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
                            LocaleKeys
                                .app_h5_handicap_tutorial_return_principal.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isDark ? const Color.fromRGBO(255, 255, 255, 0.4) : const Color(0xFFAFAFAF),
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
    } else if (index == 1) {
      return Container(
        margin: EdgeInsets.only(top: 16.h),
        decoration: isDark
            ? BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25.r)),
                image: DecorationImage(
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
                  '${LocaleKeys.app_h5_handicap_tutorial_ball.tr.replaceAll('%s', '0/0.5')} ${LocaleKeys.app_h5_handicap_tutorial_tie_half_plate.tr}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isDark
                        ? Colors.white.withOpacity(0.8999999761581421)
                        : const Color(0xFF333333),
                    fontSize: 16.sp,
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
                margin: EdgeInsets.all(12.h),
                child: Text(
                  LocaleKeys.app_h5_handicap_tutorial_note_1.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isDark
                        ? Colors.white.withOpacity(0.5)
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
                      ImageView(
                        isDark
                            ? 'assets/images/icon/icon_teamlogo_dark.png'
                            : 'assets/images/icon/icon_teamlogo_light.png',
                        width: 32.w,
                        height: 32.w,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 4.h,
                        ),
                        width: 110.w,
                        child: Text(
                          LocaleKeys
                              .app_h5_handicap_tutorial_bet_home_team.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withOpacity(0.8999999761581421)
                                : Color(0xFF333333),
                            fontSize: 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: const Color(0x19F53F3F),
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
                            LocaleKeys.app_h5_handicap_tutorial_all_win.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFFF53F3F),
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
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '1',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: isDark
                                      ? Colors.white
                                      .withOpacity(0.8999999761581421)
                                      : const Color(0xFF333333),
                                  fontSize: 32.sp,
                                  fontFamily: 'Akrobat',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 8.h, right: 8.h),
                                width: 9.19,
                                height: 3,
                                color: isDark
                                    ? Colors.white
                                    .withOpacity(0.8999999761581421)
                                    : const Color(0xFF333333),
                              ),
                              Text(
                                '0',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: isDark
                                      ? Colors.white
                                      .withOpacity(0.8999999761581421)
                                      : const Color(0xFF333333),
                                  fontSize: 32.sp,
                                  fontFamily: 'Akrobat',
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: 4.h,
                            ),
                            child: Text(
                              LocaleKeys
                                  .app_h5_handicap_tutorial_home_team_handicap
                                  .tr
                                  .replaceAll('%s', '0/0.5'),
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
                      ImageView(
                        isDark
                            ? 'assets/images/icon/icon_teamlogo_dark.png'
                            : 'assets/images/icon/icon_teamlogo_light.png',
                        width: 32.w,
                        height: 32.w,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 4.h,
                        ),
                        width: 110.w,
                        child: Text(
                          LocaleKeys
                              .app_h5_handicap_tutorial_bet_away_team.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withOpacity(0.8999999761581421)
                                : Color(0xFF333333),
                            fontSize: 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: const Color(0x1900B42A),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 0.50.w, color: Color(0x1900B42A)),
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
                            LocaleKeys.app_h5_handicap_tutorial_all_lose.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFF00B42A),
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
                  LocaleKeys.app_h5_handicap_tutorial_note_4.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF8D8D8D),
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
                      ImageView(
                        isDark
                            ? 'assets/images/icon/icon_teamlogo_dark.png'
                            : 'assets/images/icon/icon_teamlogo_light.png',
                        width: 32.w,
                        height: 32.w,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 4.h,
                        ),
                        width: 110.w,
                        child: Text(
                          LocaleKeys
                              .app_h5_handicap_tutorial_bet_home_team.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withOpacity(0.8999999761581421)
                                : Color(0xFF333333),
                            fontSize: 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: const Color(0x1900B42A),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 0.50.w, color: Color(0x1900B42A)),
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
                            LocaleKeys.app_h5_handicap_tutorial_all_lose.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF00B42A),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '0',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isDark
                                    ? Colors.white
                                    .withOpacity(0.8999999761581421)
                                    : const Color(0xFF333333),
                                fontSize: 32.sp,
                                fontFamily: 'Akrobat',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 8.h, right: 8.h),
                              width: 9.19,
                              height: 3,
                              color: isDark
                                  ? Colors.white
                                  .withOpacity(0.8999999761581421)
                                  : const Color(0xFF333333),
                            ),
                            Text(
                              '0',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isDark
                                    ? Colors.white
                                    .withOpacity(0.8999999761581421)
                                    : const Color(0xFF333333),
                                fontSize: 32.sp,
                                fontFamily: 'Akrobat',
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 4.h,
                          ),
                          child: Text(
                            LocaleKeys
                                .app_h5_handicap_tutorial_home_team_handicap
                                .tr
                                .replaceAll('%s', '0/0.5'),
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
                      ImageView(
                        isDark
                            ? 'assets/images/icon/icon_teamlogo_dark.png'
                            : 'assets/images/icon/icon_teamlogo_light.png',
                        width: 32.w,
                        height: 32.w,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 4.h,
                        ),
                        width: 110.w,
                        child: Text(
                          LocaleKeys
                              .app_h5_handicap_tutorial_bet_away_team.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withOpacity(0.8999999761581421)
                                : const Color(0xFF333333),
                            fontSize: 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: const Color(0x19F53F3F),
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
                            LocaleKeys.app_h5_handicap_tutorial_all_win.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFFF53F3F),
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
    } else if (index == 2) {
      return Container(
        margin: EdgeInsets.only(top: 16.h),
        decoration: isDark
            ? BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25.r)),
                image: DecorationImage(
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
                  '${LocaleKeys.app_h5_handicap_tutorial_ball.tr.replaceAll('%s', '0.5')} ${LocaleKeys.app_h5_handicap_tutorial_ball_plate_1.tr}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isDark
                        ? Colors.white.withOpacity(0.8999999761581421)
                        : const Color(0xFF333333),
                    fontSize: 16.sp,
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
                margin: EdgeInsets.all(12.h),
                child: Text(
                  LocaleKeys.app_h5_handicap_tutorial_note_1.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isDark
                        ? Colors.white.withOpacity(0.5)
                        : Color(0xFF8D8D8D),
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
                      ImageView(
                        isDark
                            ? 'assets/images/icon/icon_teamlogo_dark.png'
                            : 'assets/images/icon/icon_teamlogo_light.png',
                        width: 32.w,
                        height: 32.w,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 4.h,
                        ),
                        width: 110.w,
                        child: Text(
                          LocaleKeys
                              .app_h5_handicap_tutorial_bet_home_team.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withOpacity(0.8999999761581421)
                                : Color(0xFF333333),
                            fontSize: 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: const Color(0x19F53F3F),
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
                            LocaleKeys.app_h5_handicap_tutorial_all_win.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFFF53F3F),
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
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '1',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: isDark
                                      ? Colors.white
                                      .withOpacity(0.8999999761581421)
                                      : const Color(0xFF333333),
                                  fontSize: 32.sp,
                                  fontFamily: 'Akrobat',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 8.h, right: 8.h),
                                width: 9.19,
                                height: 3,
                                color: isDark
                                    ? Colors.white
                                    .withOpacity(0.8999999761581421)
                                    : const Color(0xFF333333),
                              ),
                              Text(
                                '0',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: isDark
                                      ? Colors.white
                                      .withOpacity(0.8999999761581421)
                                      : Color(0xFF333333),
                                  fontSize: 32.sp,
                                  fontFamily: 'Akrobat',
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: 4.h,
                            ),
                            child: Text(
                              LocaleKeys
                                  .app_h5_handicap_tutorial_home_team_handicap
                                  .tr
                                  .replaceAll('%s', '0.5'),
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
                      ImageView(
                        isDark
                            ? 'assets/images/icon/icon_teamlogo_dark.png'
                            : 'assets/images/icon/icon_teamlogo_light.png',
                        width: 32.w,
                        height: 32.w,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 4.h,
                        ),
                        width: 110.w,
                        child: Text(
                          LocaleKeys
                              .app_h5_handicap_tutorial_bet_away_team.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withOpacity(0.8999999761581421)
                                : Color(0xFF333333),
                            fontSize: 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: const Color(0x1900B42A),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 0.50.w, color: Color(0x1900B42A)),
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
                            LocaleKeys.app_h5_handicap_tutorial_all_lose.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF00B42A),
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
                  LocaleKeys.app_h5_handicap_tutorial_note_5.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF8D8D8D),
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
                      ImageView(
                        isDark
                            ? 'assets/images/icon/icon_teamlogo_dark.png'
                            : 'assets/images/icon/icon_teamlogo_light.png',
                        width: 32.w,
                        height: 32.w,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 4.h,
                        ),
                        width: 110.w,
                        child: Text(
                          LocaleKeys
                              .app_h5_handicap_tutorial_bet_home_team.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withOpacity(0.8999999761581421)
                                : Color(0xFF333333),
                            fontSize: 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: const Color(0x1900B42A),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 0.50.w, color: Color(0x1900B42A)),
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
                          child: Text(
                            LocaleKeys.app_h5_handicap_tutorial_all_lose.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF00B42A),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '0',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: isDark
                                      ? Colors.white
                                      .withOpacity(0.8999999761581421)
                                      : const Color(0xFF333333),
                                  fontSize: 32.sp,
                                  fontFamily: 'Akrobat',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 8.h, right: 8.h),
                                width: 9.19,
                                height: 3,
                                color: isDark
                                    ? Colors.white
                                    .withOpacity(0.8999999761581421)
                                    : const Color(0xFF333333),
                              ),
                              Text(
                                '0',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: isDark
                                      ? Colors.white
                                      .withOpacity(0.8999999761581421)
                                      : const Color(0xFF333333),
                                  fontSize: 32.sp,
                                  fontFamily: 'Akrobat',
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: 4.h,
                            ),
                            child: Text(
                              LocaleKeys
                                  .app_h5_handicap_tutorial_home_team_handicap
                                  .tr
                                  .replaceAll('%s', '0.5'),
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
                      ImageView(
                        isDark
                            ? 'assets/images/icon/icon_teamlogo_dark.png'
                            : 'assets/images/icon/icon_teamlogo_light.png',
                        width: 32.w,
                        height: 32.w,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 4.h,
                        ),
                        width: 110.w,
                        child: Text(
                          LocaleKeys
                              .app_h5_handicap_tutorial_bet_away_team.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withOpacity(0.8999999761581421)
                                : const Color(0xFF333333),
                            fontSize: 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: const Color(0x19F53F3F),
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
                            LocaleKeys.app_h5_handicap_tutorial_all_win.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFFF53F3F),
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
    } else if (index == 3) {
      return Container(
        margin: EdgeInsets.only(top: 16.h),
        decoration: isDark
            ? BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25.r)),
                image: DecorationImage(
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
                  '${LocaleKeys.app_h5_handicap_tutorial_ball.tr.replaceAll('%s', '0.5/1')} ${LocaleKeys.app_h5_handicap_tutorial_ball_plate_2.tr}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isDark
                        ? Colors.white.withOpacity(0.8999999761581421)
                        : const Color(0xFF333333),
                    fontSize: 16.sp,
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
                margin: EdgeInsets.all(12.h),
                child: Text(
                  LocaleKeys.app_h5_handicap_tutorial_note_7.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isDark
                        ? Colors.white.withOpacity(0.5)
                        : Color(0xFF8D8D8D),
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
                      ImageView(
                        isDark
                            ? 'assets/images/icon/icon_teamlogo_dark.png'
                            : 'assets/images/icon/icon_teamlogo_light.png',
                        width: 32.w,
                        height: 32.w,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 4.h,
                        ),
                        width: 110.w,
                        child: Text(
                          LocaleKeys
                              .app_h5_handicap_tutorial_bet_home_team.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withOpacity(0.8999999761581421)
                                : Color(0xFF333333),
                            fontSize: 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: const Color(0x19F53F3F),
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
                            LocaleKeys.app_h5_handicap_tutorial_win_half.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFFF53F3F),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '1',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: isDark
                                      ? Colors.white
                                      .withOpacity(0.8999999761581421)
                                      : const Color(0xFF333333),
                                  fontSize: 32.sp,
                                  fontFamily: 'Akrobat',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 8.h, right: 8.h),
                                width: 9.19,
                                height: 3,
                                color: isDark
                                    ? Colors.white
                                    .withOpacity(0.8999999761581421)
                                    : const Color(0xFF333333),
                              ),
                              Text(
                                '0',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: isDark
                                      ? Colors.white
                                      .withOpacity(0.8999999761581421)
                                      : Color(0xFF333333),
                                  fontSize: 32.sp,
                                  fontFamily: 'Akrobat',
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: 4.h,
                            ),
                            child: Text(
                              LocaleKeys
                                  .app_h5_handicap_tutorial_home_team_handicap
                                  .tr
                                  .replaceAll('%s', '0.5/1'),
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
                      ImageView(
                        isDark
                            ? 'assets/images/icon/icon_teamlogo_dark.png'
                            : 'assets/images/icon/icon_teamlogo_light.png',
                        width: 32.w,
                        height: 32.w,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 4.h,
                        ),
                        width: 110.w,
                        child: Text(
                          LocaleKeys
                              .app_h5_handicap_tutorial_bet_away_team.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withOpacity(0.8999999761581421)
                                : Color(0xFF333333),
                            fontSize: 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: const Color(0x1900B42A),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 0.50.w, color: Color(0x1900B42A)),
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
                            LocaleKeys.app_h5_handicap_tutorial_lose_half.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF00B42A),
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
                margin: EdgeInsets.all(12.h),
                child: Text(
                  LocaleKeys.app_h5_handicap_tutorial_note_7.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF8D8D8D),
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
                      ImageView(
                        isDark
                            ? 'assets/images/icon/icon_teamlogo_dark.png'
                            : 'assets/images/icon/icon_teamlogo_light.png',
                        width: 32.w,
                        height: 32.w,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 4.h,
                        ),
                        width: 110.w,
                        child: Text(
                          LocaleKeys
                              .app_h5_handicap_tutorial_bet_home_team.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withOpacity(0.8999999761581421)
                                : Color(0xFF333333),
                            fontSize: 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: const Color(0x19F53F3F),
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
                            LocaleKeys.app_h5_handicap_tutorial_all_win.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFFF53F3F),
                              fontSize: 12.sp,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                      width: 80.w,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '2',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isDark
                                    ? Colors.white
                                    .withOpacity(0.8999999761581421)
                                    : const Color(0xFF333333),
                                fontSize: 32.sp,
                                fontFamily: 'Akrobat',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 8.h, right: 8.h),
                              width: 9.19,
                              height: 3,
                              color: isDark
                                  ? Colors.white
                                  .withOpacity(0.8999999761581421)
                                  : const Color(0xFF333333),
                            ),
                            Text(
                              '0',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isDark
                                    ? Colors.white
                                    .withOpacity(0.8999999761581421)
                                    : const Color(0xFF333333),
                                fontSize: 32.sp,
                                fontFamily: 'Akrobat',
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 4.h,
                          ),
                          child: Text(
                            LocaleKeys
                                .app_h5_handicap_tutorial_home_team_handicap
                                .tr
                                .replaceAll('%s', '0.5/1'),
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
                      ImageView(
                        isDark
                            ? 'assets/images/icon/icon_teamlogo_dark.png'
                            : 'assets/images/icon/icon_teamlogo_light.png',
                        width: 32.w,
                        height: 32.w,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 4.h,
                        ),
                        width: 110.w,
                        child: Text(
                          LocaleKeys
                              .app_h5_handicap_tutorial_bet_away_team.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withOpacity(0.8999999761581421)
                                : const Color(0xFF333333),
                            fontSize: 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: const Color(0x1900B42A),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 0.50.w, color: Color(0x1900B42A)),
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
                            LocaleKeys.app_h5_handicap_tutorial_all_lose.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF00B42A),
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
                margin: EdgeInsets.all(12.h),
                child: Text(
                  LocaleKeys.app_h5_handicap_tutorial_note_5.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF8D8D8D),
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
                      ImageView(
                        isDark
                            ? 'assets/images/icon/icon_teamlogo_dark.png'
                            : 'assets/images/icon/icon_teamlogo_light.png',
                        width: 32.w,
                        height: 32.w,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 4.h,
                        ),
                        width: 110.w,
                        child: Text(
                          LocaleKeys
                              .app_h5_handicap_tutorial_bet_home_team.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withOpacity(0.8999999761581421)
                                : Color(0xFF333333),
                            fontSize: 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: const Color(0x1900B42A),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 0.50.w, color: Color(0x1900B42A)),
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
                            LocaleKeys.app_h5_handicap_tutorial_all_lose.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF00B42A),
                              fontSize: 12.sp,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 80.w,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '0',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isDark
                                    ? Colors.white
                                    .withOpacity(0.8999999761581421)
                                    : const Color(0xFF333333),
                                fontSize: 32.sp,
                                fontFamily: 'Akrobat',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 8.h, right: 8.h),
                              width: 9.19,
                              height: 3,
                              color: isDark
                                  ? Colors.white
                                  .withOpacity(0.8999999761581421)
                                  : const Color(0xFF333333),
                            ),
                            Text(
                              '0',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isDark
                                    ? Colors.white
                                    .withOpacity(0.8999999761581421)
                                    : const Color(0xFF333333),
                                fontSize: 32.sp,
                                fontFamily: 'Akrobat',
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 4.h,
                          ),
                          child: Text(
                            LocaleKeys
                                .app_h5_handicap_tutorial_home_team_handicap
                                .tr
                                .replaceAll('%s', '0.5/1'),
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
                      ImageView(
                        isDark
                            ? 'assets/images/icon/icon_teamlogo_dark.png'
                            : 'assets/images/icon/icon_teamlogo_light.png',
                        width: 32.w,
                        height: 32.w,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 4.h,
                        ),
                        width: 110.w,
                        child: Text(
                          LocaleKeys
                              .app_h5_handicap_tutorial_bet_away_team.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withOpacity(0.8999999761581421)
                                : const Color(0xFF333333),
                            fontSize: 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: const Color(0x19F53F3F),
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
                            LocaleKeys.app_h5_handicap_tutorial_all_win.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFFF53F3F),
                              fontSize: 12.sp,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } else if (index == 4) {
      return Container(
        margin: EdgeInsets.only(top: 16.h),
        decoration: isDark
            ? BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25.r)),
                image: DecorationImage(
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
                  '${LocaleKeys.app_h5_handicap_tutorial_ball.tr.replaceAll('%s', '1')} ${LocaleKeys.app_h5_handicap_tutorial_ball_plate_3.tr}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isDark
                        ? Colors.white.withOpacity(0.8999999761581421)
                        : const Color(0xFF333333),
                    fontSize: 16.sp,
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
                margin: EdgeInsets.all(12.h),
                child: Text(
                  LocaleKeys.app_h5_handicap_tutorial_note_8.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isDark
                        ? Colors.white.withOpacity(0.5)
                        : Color(0xFF8D8D8D),
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
                      ImageView(
                        isDark
                            ? 'assets/images/icon/icon_teamlogo_dark.png'
                            : 'assets/images/icon/icon_teamlogo_light.png',
                        width: 32.w,
                        height: 32.w,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 4.h,
                        ),
                        width: 110.w,
                        child: Text(
                          LocaleKeys
                              .app_h5_handicap_tutorial_bet_home_team.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withOpacity(0.8999999761581421)
                                : Color(0xFF333333),
                            fontSize: 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: const Color(0x19AFAFAF),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 0.50, color: Color(0x19AFAFAF)),
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
                            LocaleKeys
                                .app_h5_handicap_tutorial_return_principal.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isDark ? const Color.fromRGBO(255, 255, 255, 0.4) : const Color(0xFFAFAFAF),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '1',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: isDark
                                      ? Colors.white
                                      .withOpacity(0.8999999761581421)
                                      : const Color(0xFF333333),
                                  fontSize: 32.sp,
                                  fontFamily: 'Akrobat',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 8.h, right: 8.h),
                                width: 9.19,
                                height: 3,
                                color: isDark
                                    ? Colors.white
                                    .withOpacity(0.8999999761581421)
                                    : const Color(0xFF333333),
                              ),
                              Text(
                                '0',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: isDark
                                      ? Colors.white
                                      .withOpacity(0.8999999761581421)
                                      : Color(0xFF333333),
                                  fontSize: 32.sp,
                                  fontFamily: 'Akrobat',
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: 4.h,
                            ),
                            child: Text(
                              LocaleKeys
                                  .app_h5_handicap_tutorial_home_team_handicap
                                  .tr
                                  .replaceAll('%s', '1'),
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
                      ImageView(
                        isDark
                            ? 'assets/images/icon/icon_teamlogo_dark.png'
                            : 'assets/images/icon/icon_teamlogo_light.png',
                        width: 32.w,
                        height: 32.w,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 4.h,
                        ),
                        width: 110.w,
                        child: Text(
                          LocaleKeys
                              .app_h5_handicap_tutorial_bet_away_team.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withOpacity(0.8999999761581421)
                                : Color(0xFF333333),
                            fontSize: 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: const Color(0x19AFAFAF),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 0.50, color: Color(0x19AFAFAF)),
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
                            LocaleKeys
                                .app_h5_handicap_tutorial_return_principal.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isDark ? const Color.fromRGBO(255, 255, 255, 0.4) : const Color(0xFFAFAFAF),
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
                margin: EdgeInsets.all(12.h),
                child: Text(
                  LocaleKeys.app_h5_handicap_tutorial_note_1.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF8D8D8D),
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
                      ImageView(
                        isDark
                            ? 'assets/images/icon/icon_teamlogo_dark.png'
                            : 'assets/images/icon/icon_teamlogo_light.png',
                        width: 32.w,
                        height: 32.w,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 4.h,
                        ),
                        width: 110.w,
                        child: Text(
                          LocaleKeys
                              .app_h5_handicap_tutorial_bet_home_team.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withOpacity(0.8999999761581421)
                                : Color(0xFF333333),
                            fontSize: 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: const Color(0x19F53F3F),
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
                            LocaleKeys.app_h5_handicap_tutorial_all_win.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFFF53F3F),
                              fontSize: 12.sp,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 80.w,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '2',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isDark
                                    ? Colors.white
                                    .withOpacity(0.8999999761581421)
                                    : const Color(0xFF333333),
                                fontSize: 32.sp,
                                fontFamily: 'Akrobat',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 8.h, right: 8.h),
                              width: 9.19,
                              height: 3,
                              color: isDark
                                  ? Colors.white
                                  .withOpacity(0.8999999761581421)
                                  : const Color(0xFF333333),
                            ),
                            Text(
                              '0',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isDark
                                    ? Colors.white
                                    .withOpacity(0.8999999761581421)
                                    : const Color(0xFF333333),
                                fontSize: 32.sp,
                                fontFamily: 'Akrobat',
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 4.h,
                          ),
                          child: Text(
                            LocaleKeys
                                .app_h5_handicap_tutorial_home_team_handicap
                                .tr
                                .replaceAll('%s', '1'),
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
                      ImageView(
                        isDark
                            ? 'assets/images/icon/icon_teamlogo_dark.png'
                            : 'assets/images/icon/icon_teamlogo_light.png',
                        width: 32.w,
                        height: 32.w,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 4.h,
                        ),
                        width: 110.w,
                        child: Text(
                          LocaleKeys
                              .app_h5_handicap_tutorial_bet_away_team.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withOpacity(0.8999999761581421)
                                : const Color(0xFF333333),
                            fontSize: 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: const Color(0x1900B42A),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 0.50.w, color: Color(0x1900B42A)),
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
                            LocaleKeys.app_h5_handicap_tutorial_all_lose.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF00B42A),
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
                  LocaleKeys.app_h5_handicap_tutorial_note_5.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF8D8D8D),
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
                      ImageView(
                        isDark
                            ? 'assets/images/icon/icon_teamlogo_dark.png'
                            : 'assets/images/icon/icon_teamlogo_light.png',
                        width: 32.w,
                        height: 32.w,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 4.h,
                        ),
                        width: 110.w,
                        child: Text(
                          LocaleKeys
                              .app_h5_handicap_tutorial_bet_home_team.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withOpacity(0.8999999761581421)
                                : Color(0xFF333333),
                            fontSize: 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: const Color(0x1900B42A),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 0.50.w, color: Color(0x1900B42A)),
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
                            LocaleKeys.app_h5_handicap_tutorial_all_lose.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF00B42A),
                              fontSize: 12.sp,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                      width: 80.w,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '0',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isDark
                                    ? Colors.white
                                    .withOpacity(0.8999999761581421)
                                    : const Color(0xFF333333),
                                fontSize: 32.sp,
                                fontFamily: 'Akrobat',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 8.h, right: 8.h),
                              width: 9.19,
                              height: 3,
                              color: isDark
                                  ? Colors.white
                                  .withOpacity(0.8999999761581421)
                                  : const Color(0xFF333333),
                            ),
                            Text(
                              '0',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isDark
                                    ? Colors.white
                                    .withOpacity(0.8999999761581421)
                                    : const Color(0xFF333333),
                                fontSize: 32.sp,
                                fontFamily: 'Akrobat',
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 4.h,
                          ),
                          child: Text(
                            LocaleKeys
                                .app_h5_handicap_tutorial_home_team_handicap
                                .tr
                                .replaceAll('%s', '1'),
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
                      ImageView(
                        isDark
                            ? 'assets/images/icon/icon_teamlogo_dark.png'
                            : 'assets/images/icon/icon_teamlogo_light.png',
                        width: 32.w,
                        height: 32.w,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 4.h,
                        ),
                        width: 110.w,
                        child: Text(
                          LocaleKeys
                              .app_h5_handicap_tutorial_bet_away_team.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withOpacity(0.8999999761581421)
                                : const Color(0xFF333333),
                            fontSize: 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: const Color(0x19F53F3F),
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
                            LocaleKeys.app_h5_handicap_tutorial_all_win.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFFF53F3F),
                              fontSize: 12.sp,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } else if (index == 5) {
      return Container(
        margin: EdgeInsets.only(top: 16.h),
        decoration: isDark
            ? BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25.r)),
                image: DecorationImage(
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
                  '${LocaleKeys.app_h5_handicap_tutorial_ball.tr.replaceAll('%s', '1/1.5')} ${LocaleKeys.app_h5_handicap_tutorial_ball_plate_4.tr}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isDark
                        ? Colors.white.withOpacity(0.8999999761581421)
                        : const Color(0xFF333333),
                    fontSize: 16.sp,
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
                margin: EdgeInsets.all(12.h),
                child: Text(
                  LocaleKeys.app_h5_handicap_tutorial_note_9.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isDark
                        ? Colors.white.withOpacity(0.5)
                        : Color(0xFF8D8D8D),
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
                      ImageView(
                        isDark
                            ? 'assets/images/icon/icon_teamlogo_dark.png'
                            : 'assets/images/icon/icon_teamlogo_light.png',
                        width: 32.w,
                        height: 32.w,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 4.h,
                        ),
                        width: 110.w,
                        child: Text(
                          LocaleKeys
                              .app_h5_handicap_tutorial_bet_home_team.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withOpacity(0.8999999761581421)
                                : Color(0xFF333333),
                            fontSize: 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: const Color(0x1900B42A),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 0.50.w, color: Color(0x1900B42A)),
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
                            LocaleKeys.app_h5_handicap_tutorial_lose_half.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF00B42A),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '1',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isDark
                                    ? Colors.white
                                    .withOpacity(0.8999999761581421)
                                    : const Color(0xFF333333),
                                fontSize: 32.sp,
                                fontFamily: 'Akrobat',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 8.h, right: 8.h),
                              width: 9.19,
                              height: 3,
                              color: isDark
                                  ? Colors.white
                                  .withOpacity(0.8999999761581421)
                                  : const Color(0xFF333333),
                            ),
                            Text(
                              '0',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isDark
                                    ? Colors.white
                                    .withOpacity(0.8999999761581421)
                                    : Color(0xFF333333),
                                fontSize: 32.sp,
                                fontFamily: 'Akrobat',
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 4.h,
                          ),
                          child: Text(
                            LocaleKeys
                                .app_h5_handicap_tutorial_home_team_handicap
                                .tr
                                .replaceAll('%s', '1/1.5'),
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
                      ImageView(
                        isDark
                            ? 'assets/images/icon/icon_teamlogo_dark.png'
                            : 'assets/images/icon/icon_teamlogo_light.png',
                        width: 32.w,
                        height: 32.w,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 4.h,
                        ),
                        width: 110.w,
                        child: Text(
                          LocaleKeys
                              .app_h5_handicap_tutorial_bet_away_team.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withOpacity(0.8999999761581421)
                                : Color(0xFF333333),
                            fontSize: 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: const Color(0x19F53F3F),
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
                            LocaleKeys.app_h5_handicap_tutorial_win_half.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFFF53F3F),
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
                margin: EdgeInsets.all(12.h),
                child: Text(
                  LocaleKeys.app_h5_handicap_tutorial_note_7.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF8D8D8D),
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
                      ImageView(
                        isDark
                            ? 'assets/images/icon/icon_teamlogo_dark.png'
                            : 'assets/images/icon/icon_teamlogo_light.png',
                        width: 32.w,
                        height: 32.w,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 4.h,
                        ),
                        width: 110.w,
                        child: Text(
                          LocaleKeys
                              .app_h5_handicap_tutorial_bet_home_team.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withOpacity(0.8999999761581421)
                                : Color(0xFF333333),
                            fontSize: 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: const Color(0x19F53F3F),
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
                            LocaleKeys.app_h5_handicap_tutorial_all_win.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFFF53F3F),
                              fontSize: 12.sp,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 80.w,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '2',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: isDark
                                      ? Colors.white
                                      .withOpacity(0.8999999761581421)
                                      : const Color(0xFF333333),
                                  fontSize: 32.sp,
                                  fontFamily: 'Akrobat',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 8.h, right: 8.h),
                                width: 9.19,
                                height: 3,
                                color: isDark
                                    ? Colors.white
                                    .withOpacity(0.8999999761581421)
                                    : const Color(0xFF333333),
                              ),
                              Text(
                                '0',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: isDark
                                      ? Colors.white
                                      .withOpacity(0.8999999761581421)
                                      : const Color(0xFF333333),
                                  fontSize: 32.sp,
                                  fontFamily: 'Akrobat',
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: 4.h,
                            ),
                            child: Text(
                              LocaleKeys
                                  .app_h5_handicap_tutorial_home_team_handicap
                                  .tr
                                  .replaceAll('%s', '1/1.5'),
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
                      ImageView(
                        isDark
                            ? 'assets/images/icon/icon_teamlogo_dark.png'
                            : 'assets/images/icon/icon_teamlogo_light.png',
                        width: 32.w,
                        height: 32.w,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 4.h,
                        ),
                        width: 110.w,
                        child: Text(
                          LocaleKeys
                              .app_h5_handicap_tutorial_bet_away_team.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withOpacity(0.8999999761581421)
                                : const Color(0xFF333333),
                            fontSize: 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: const Color(0x1900B42A),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 0.50.w, color: Color(0x1900B42A)),
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
                            LocaleKeys.app_h5_handicap_tutorial_all_lose.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF00B42A),
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
                  LocaleKeys.app_h5_handicap_tutorial_note_5.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF8D8D8D),
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
                      ImageView(
                        isDark
                            ? 'assets/images/icon/icon_teamlogo_dark.png'
                            : 'assets/images/icon/icon_teamlogo_light.png',
                        width: 32.w,
                        height: 32.w,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 4.h,
                        ),
                        width: 110.w,
                        child: Text(
                          LocaleKeys
                              .app_h5_handicap_tutorial_bet_home_team.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withOpacity(0.8999999761581421)
                                : Color(0xFF333333),
                            fontSize: 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: const Color(0x1900B42A),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 0.50.w, color: Color(0x1900B42A)),
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
                            LocaleKeys.app_h5_handicap_tutorial_all_lose.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF00B42A),
                              fontSize: 12.sp,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 80.w,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '0',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isDark
                                    ? Colors.white
                                    .withOpacity(0.8999999761581421)
                                    : const Color(0xFF333333),
                                fontSize: 32.sp,
                                fontFamily: 'Akrobat',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 8.h, right: 8.h),
                              width: 9.19,
                              height: 3,
                              color: isDark
                                  ? Colors.white
                                  .withOpacity(0.8999999761581421)
                                  : const Color(0xFF333333),
                            ),
                            Text(
                              '0',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isDark
                                    ? Colors.white
                                    .withOpacity(0.8999999761581421)
                                    : const Color(0xFF333333),
                                fontSize: 32.sp,
                                fontFamily: 'Akrobat',
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 4.h,
                          ),
                          child: Text(
                            LocaleKeys
                                .app_h5_handicap_tutorial_home_team_handicap
                                .tr
                                .replaceAll('%s', '1/1.5'),
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
                      ImageView(
                        isDark
                            ? 'assets/images/icon/icon_teamlogo_dark.png'
                            : 'assets/images/icon/icon_teamlogo_light.png',
                        width: 32.w,
                        height: 32.w,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 4.h,
                        ),
                        width: 110.w,
                        child: Text(
                          LocaleKeys
                              .app_h5_handicap_tutorial_bet_away_team.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withOpacity(0.8999999761581421)
                                : const Color(0xFF333333),
                            fontSize: 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: const Color(0x19F53F3F),
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
                            LocaleKeys.app_h5_handicap_tutorial_all_win.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFFF53F3F),
                              fontSize: 12.sp,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } else if (index == 6) {
      return Container(
        margin: EdgeInsets.only(top: 16.h),
        decoration: isDark
            ? BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25.r)),
                image: DecorationImage(
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
                  '${LocaleKeys.app_h5_handicap_tutorial_ball.tr.replaceAll('%s', '1.5')} ${LocaleKeys.app_h5_handicap_tutorial_ball_plate_5.tr}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isDark
                        ? Colors.white.withOpacity(0.8999999761581421)
                        : const Color(0xFF333333),
                    fontSize: 16.sp,
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
                margin: EdgeInsets.all(12.h),
                child: Text(
                  LocaleKeys.app_h5_handicap_tutorial_note_5.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isDark
                        ? Colors.white.withOpacity(0.5)
                        : Color(0xFF8D8D8D),
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
                      ImageView(
                        isDark
                            ? 'assets/images/icon/icon_teamlogo_dark.png'
                            : 'assets/images/icon/icon_teamlogo_light.png',
                        width: 32.w,
                        height: 32.w,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 4.h,
                        ),
                        width: 110.w,
                        child: Text(
                          LocaleKeys
                              .app_h5_handicap_tutorial_bet_home_team.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withOpacity(0.8999999761581421)
                                : Color(0xFF333333),
                            fontSize: 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: const Color(0x1900B42A),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 0.50.w, color: Color(0x1900B42A)),
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
                            LocaleKeys.app_h5_handicap_tutorial_all_lose.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF00B42A),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '1',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: isDark
                                      ? Colors.white
                                      .withOpacity(0.8999999761581421)
                                      : const Color(0xFF333333),
                                  fontSize: 32.sp,
                                  fontFamily: 'Akrobat',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 8.h, right: 8.h),
                                width: 9.19,
                                height: 3,
                                color: isDark
                                    ? Colors.white
                                    .withOpacity(0.8999999761581421)
                                    : const Color(0xFF333333),
                              ),
                              Text(
                                '0',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: isDark
                                      ? Colors.white
                                      .withOpacity(0.8999999761581421)
                                      : Color(0xFF333333),
                                  fontSize: 32.sp,
                                  fontFamily: 'Akrobat',
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: 4.h,
                            ),
                            child: Text(
                              LocaleKeys
                                  .app_h5_handicap_tutorial_home_team_handicap
                                  .tr
                                  .replaceAll('%s', '1.5'),
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
                      ImageView(
                        isDark
                            ? 'assets/images/icon/icon_teamlogo_dark.png'
                            : 'assets/images/icon/icon_teamlogo_light.png',
                        width: 32.w,
                        height: 32.w,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 4.h,
                        ),
                        width: 110.w,
                        child: Text(
                          LocaleKeys
                              .app_h5_handicap_tutorial_bet_away_team.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withOpacity(0.8999999761581421)
                                : Color(0xFF333333),
                            fontSize: 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: const Color(0x19F53F3F),
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
                            LocaleKeys.app_h5_handicap_tutorial_all_win.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFFF53F3F),
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
                margin: EdgeInsets.all(12.h),
                child: Text(
                  LocaleKeys.app_h5_handicap_tutorial_note_3.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF8D8D8D),
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
                      ImageView(
                        isDark
                            ? 'assets/images/icon/icon_teamlogo_dark.png'
                            : 'assets/images/icon/icon_teamlogo_light.png',
                        width: 32.w,
                        height: 32.w,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 4.h,
                        ),
                        width: 110.w,
                        child: Text(
                          LocaleKeys
                              .app_h5_handicap_tutorial_bet_home_team.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withOpacity(0.8999999761581421)
                                : Color(0xFF333333),
                            fontSize: 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: const Color(0x19F53F3F),
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
                            LocaleKeys.app_h5_handicap_tutorial_all_win.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFFF53F3F),
                              fontSize: 12.sp,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                      width: 80.w,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '2',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isDark
                                    ? Colors.white
                                    .withOpacity(0.8999999761581421)
                                    : const Color(0xFF333333),
                                fontSize: 32.sp,
                                fontFamily: 'Akrobat',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 8.h, right: 8.h),
                              width: 9.19,
                              height: 3,
                              color: isDark
                                  ? Colors.white
                                  .withOpacity(0.8999999761581421)
                                  : const Color(0xFF333333),
                            ),
                            Text(
                              '0',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isDark
                                    ? Colors.white
                                    .withOpacity(0.8999999761581421)
                                    : const Color(0xFF333333),
                                fontSize: 32.sp,
                                fontFamily: 'Akrobat',
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 4.h,
                          ),
                          child: Text(
                            LocaleKeys
                                .app_h5_handicap_tutorial_home_team_handicap
                                .tr
                                .replaceAll('%s', '1.5'),
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
                      ImageView(
                        isDark
                            ? 'assets/images/icon/icon_teamlogo_dark.png'
                            : 'assets/images/icon/icon_teamlogo_light.png',
                        width: 32.w,
                        height: 32.w,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 4.h,
                        ),
                        width: 110.w,
                        child: Text(
                          LocaleKeys
                              .app_h5_handicap_tutorial_bet_away_team.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withOpacity(0.8999999761581421)
                                : const Color(0xFF333333),
                            fontSize: 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: const Color(0x1900B42A),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 0.50.w, color: Color(0x1900B42A)),
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
                            LocaleKeys.app_h5_handicap_tutorial_all_lose.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF00B42A),
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
                  LocaleKeys.app_h5_handicap_tutorial_note_5.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF8D8D8D),
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
                      ImageView(
                        isDark
                            ? 'assets/images/icon/icon_teamlogo_dark.png'
                            : 'assets/images/icon/icon_teamlogo_light.png',
                        width: 32.w,
                        height: 32.w,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 4.h,
                        ),
                        width: 110.w,
                        child: Text(
                          LocaleKeys
                              .app_h5_handicap_tutorial_bet_home_team.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withOpacity(0.8999999761581421)
                                : Color(0xFF333333),
                            fontSize: 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: const Color(0x1900B42A),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 0.50.w, color: Color(0x1900B42A)),
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
                            LocaleKeys.app_h5_handicap_tutorial_all_lose.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF00B42A),
                              fontSize: 12.sp,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                      width: 80.w,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '0',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isDark
                                    ? Colors.white
                                    .withOpacity(0.8999999761581421)
                                    : const Color(0xFF333333),
                                fontSize: 32.sp,
                                fontFamily: 'Akrobat',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 8.h, right: 8.h),
                              width: 9.19,
                              height: 3,
                              color: isDark
                                  ? Colors.white
                                  .withOpacity(0.8999999761581421)
                                  : const Color(0xFF333333),
                            ),
                            Text(
                              '0',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isDark
                                    ? Colors.white
                                    .withOpacity(0.8999999761581421)
                                    : const Color(0xFF333333),
                                fontSize: 32.sp,
                                fontFamily: 'Akrobat',
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 4.h,
                          ),
                          child: Text(
                            LocaleKeys
                                .app_h5_handicap_tutorial_home_team_handicap
                                .tr
                                .replaceAll('%s', '1.5'),
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
                      ImageView(
                        isDark
                            ? 'assets/images/icon/icon_teamlogo_dark.png'
                            : 'assets/images/icon/icon_teamlogo_light.png',
                        width: 32.w,
                        height: 32.w,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 4.h,
                        ),
                        width: 110.w,
                        child: Text(
                          LocaleKeys
                              .app_h5_handicap_tutorial_bet_away_team.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withOpacity(0.8999999761581421)
                                : const Color(0xFF333333),
                            fontSize: 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: const Color(0x19F53F3F),
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
                            LocaleKeys.app_h5_handicap_tutorial_all_win.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFFF53F3F),
                              fontSize: 12.sp,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } else if (index == 7) {
      return Container(
        margin: EdgeInsets.only(top: 16.h, bottom: 300.h),
        decoration: isDark
            ? BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25.r)),
                image: DecorationImage(
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
                  '${LocaleKeys.app_h5_handicap_tutorial_ball.tr.replaceAll('%s', '1.5/2')} ${LocaleKeys.app_h5_handicap_tutorial_ball_plate_6.tr}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isDark
                        ? Colors.white.withOpacity(0.8999999761581421)
                        : const Color(0xFF333333),
                    fontSize: 16.sp,
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
                margin: EdgeInsets.all(12.h),
                child: Text(
                  LocaleKeys.app_h5_handicap_tutorial_note_10.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isDark
                        ? Colors.white.withOpacity(0.5)
                        : Color(0xFF8D8D8D),
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
                      ImageView(
                        isDark
                            ? 'assets/images/icon/icon_teamlogo_dark.png'
                            : 'assets/images/icon/icon_teamlogo_light.png',
                        width: 32.w,
                        height: 32.w,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 4.h,
                        ),
                        width: 110.w,
                        child: Text(
                          LocaleKeys
                              .app_h5_handicap_tutorial_bet_home_team.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withOpacity(0.8999999761581421)
                                : Color(0xFF333333),
                            fontSize: 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: const Color(0x1900B42A),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 0.50.w, color: Color(0x1900B42A)),
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
                            LocaleKeys.app_h5_handicap_tutorial_all_lose.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF00B42A),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '1',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isDark
                                    ? Colors.white
                                    .withOpacity(0.8999999761581421)
                                    : const Color(0xFF333333),
                                fontSize: 32.sp,
                                fontFamily: 'Akrobat',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 8.h, right: 8.h),
                              width: 9.19,
                              height: 3,
                              color: isDark
                                  ? Colors.white
                                  .withOpacity(0.8999999761581421)
                                  : const Color(0xFF333333),
                            ),
                            Text(
                              '0',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isDark
                                    ? Colors.white
                                    .withOpacity(0.8999999761581421)
                                    : Color(0xFF333333),
                                fontSize: 32.sp,
                                fontFamily: 'Akrobat',
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 4.h,
                          ),
                          child: Text(
                            LocaleKeys
                                .app_h5_handicap_tutorial_home_team_handicap
                                .tr
                                .replaceAll('%s', '1.5/2'),
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
                      ImageView(
                        isDark
                            ? 'assets/images/icon/icon_teamlogo_dark.png'
                            : 'assets/images/icon/icon_teamlogo_light.png',
                        width: 32.w,
                        height: 32.w,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 4.h,
                        ),
                        width: 110.w,
                        child: Text(
                          LocaleKeys
                              .app_h5_handicap_tutorial_bet_away_team.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withOpacity(0.8999999761581421)
                                : Color(0xFF333333),
                            fontSize: 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: const Color(0x19F53F3F),
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
                            LocaleKeys.app_h5_handicap_tutorial_all_win.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFFF53F3F),
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
                margin: EdgeInsets.all(12.h),
                child: Text(
                  LocaleKeys.app_h5_handicap_tutorial_note_6.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF8D8D8D),
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
                      ImageView(
                        isDark
                            ? 'assets/images/icon/icon_teamlogo_dark.png'
                            : 'assets/images/icon/icon_teamlogo_light.png',
                        width: 32.w,
                        height: 32.w,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 4.h,
                        ),
                        width: 110.w,
                        child: Text(
                          LocaleKeys
                              .app_h5_handicap_tutorial_bet_home_team.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withOpacity(0.8999999761581421)
                                : Color(0xFF333333),
                            fontSize: 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: const Color(0x19F53F3F),
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
                            LocaleKeys.app_h5_handicap_tutorial_win_half.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFFF53F3F),
                              fontSize: 12.sp,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 80.w,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '2',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isDark
                                    ? Colors.white
                                    .withOpacity(0.8999999761581421)
                                    : const Color(0xFF333333),
                                fontSize: 32.sp,
                                fontFamily: 'Akrobat',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 8.h, right: 8.h),
                              width: 9.19,
                              height: 3,
                              color: isDark
                                  ? Colors.white
                                  .withOpacity(0.8999999761581421)
                                  : const Color(0xFF333333),
                            ),
                            Text(
                              '0',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isDark
                                    ? Colors.white
                                    .withOpacity(0.8999999761581421)
                                    : const Color(0xFF333333),
                                fontSize: 32.sp,
                                fontFamily: 'Akrobat',
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 4.h,
                          ),
                          child: Text(
                            LocaleKeys
                                .app_h5_handicap_tutorial_home_team_handicap
                                .tr
                                .replaceAll('%s', '1.5/2'),
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
                      ImageView(
                        isDark
                            ? 'assets/images/icon/icon_teamlogo_dark.png'
                            : 'assets/images/icon/icon_teamlogo_light.png',
                        width: 32.w,
                        height: 32.w,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 4.h,
                        ),
                        width: 110.w,
                        child: Text(
                          LocaleKeys
                              .app_h5_handicap_tutorial_bet_away_team.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withOpacity(0.8999999761581421)
                                : const Color(0xFF333333),
                            fontSize: 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: const Color(0x1900B42A),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 0.50.w, color: Color(0x1900B42A)),
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
                            LocaleKeys.app_h5_handicap_tutorial_lose_half.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF00B42A),
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
                  LocaleKeys.app_h5_handicap_tutorial_note_1.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF8D8D8D),
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
                      ImageView(
                        isDark
                            ? 'assets/images/icon/icon_teamlogo_dark.png'
                            : 'assets/images/icon/icon_teamlogo_light.png',
                        width: 32.w,
                        height: 32.w,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 4.h,
                        ),
                        width: 110.w,
                        child: Text(
                          LocaleKeys
                              .app_h5_handicap_tutorial_bet_home_team.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withOpacity(0.8999999761581421)
                                : Color(0xFF333333),
                            fontSize: 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: const Color(0x19F53F3F),
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
                            LocaleKeys.app_h5_handicap_tutorial_all_win.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFFF53F3F),
                              fontSize: 12.sp,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 80.w,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '3',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: isDark
                                      ? Colors.white
                                      .withOpacity(0.8999999761581421)
                                      : const Color(0xFF333333),
                                  fontSize: 32.sp,
                                  fontFamily: 'Akrobat',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 8.h, right: 8.h),
                                width: 9.19,
                                height: 3,
                                color: isDark
                                    ? Colors.white
                                    .withOpacity(0.8999999761581421)
                                    : const Color(0xFF333333),
                              ),
                              Text(
                                '0',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: isDark
                                      ? Colors.white
                                      .withOpacity(0.8999999761581421)
                                      : const Color(0xFF333333),
                                  fontSize: 32.sp,
                                  fontFamily: 'Akrobat',
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: 4.h,
                            ),
                            child: Text(
                              LocaleKeys
                                  .app_h5_handicap_tutorial_home_team_handicap
                                  .tr
                                  .replaceAll('%s', '1.5/2'),
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
                      ImageView(
                        isDark
                            ? 'assets/images/icon/icon_teamlogo_dark.png'
                            : 'assets/images/icon/icon_teamlogo_light.png',
                        width: 32.w,
                        height: 32.w,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 4.h,
                        ),
                        width: 110.w,
                        child: Text(
                          LocaleKeys
                              .app_h5_handicap_tutorial_bet_away_team.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withOpacity(0.8999999761581421)
                                : const Color(0xFF333333),
                            fontSize: 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: const Color(0x1900B42A),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 0.50.w, color: Color(0x1900B42A)),
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
                            LocaleKeys.app_h5_handicap_tutorial_all_lose.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF00B42A),
                              fontSize: 12.sp,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(12.h),
                child: Text(
                  LocaleKeys.app_h5_handicap_tutorial_note_11.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF8D8D8D),
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
                      ImageView(
                        isDark
                            ? 'assets/images/icon/icon_teamlogo_dark.png'
                            : 'assets/images/icon/icon_teamlogo_light.png',
                        width: 32.w,
                        height: 32.w,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 4.h,
                        ),
                        width: 110.w,
                        child: Text(
                          LocaleKeys
                              .app_h5_handicap_tutorial_bet_home_team.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withOpacity(0.8999999761581421)
                                : Color(0xFF333333),
                            fontSize: 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: const Color(0x1900B42A),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 0.50.w, color: Color(0x1900B42A)),
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
                            LocaleKeys.app_h5_handicap_tutorial_all_lose.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF00B42A),
                              fontSize: 12.sp,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 80.w,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '0',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isDark
                                    ? Colors.white
                                    .withOpacity(0.8999999761581421)
                                    : const Color(0xFF333333),
                                fontSize: 32.sp,
                                fontFamily: 'Akrobat',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 8.h, right: 8.h),
                              width: 9.19,
                              height: 3,
                              color: isDark
                                  ? Colors.white
                                  .withOpacity(0.8999999761581421)
                                  : const Color(0xFF333333),
                            ),
                            Text(
                              '0',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isDark
                                    ? Colors.white
                                    .withOpacity(0.8999999761581421)
                                    : const Color(0xFF333333),
                                fontSize: 32.sp,
                                fontFamily: 'Akrobat',
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 4.h,
                          ),
                          child: Text(
                            LocaleKeys
                                .app_h5_handicap_tutorial_home_team_handicap
                                .tr
                                .replaceAll('%s', '1.5/2'),
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
                      ImageView(
                        isDark
                            ? 'assets/images/icon/icon_teamlogo_dark.png'
                            : 'assets/images/icon/icon_teamlogo_light.png',
                        width: 32.w,
                        height: 32.w,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 4.h,
                        ),
                        width: 110.w,
                        child: Text(
                          LocaleKeys
                              .app_h5_handicap_tutorial_bet_away_team.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withOpacity(0.8999999761581421)
                                : const Color(0xFF333333),
                            fontSize: 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: const Color(0x19F53F3F),
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
                            LocaleKeys.app_h5_handicap_tutorial_all_win.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFFF53F3F),
                              fontSize: 12.sp,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return Container();
  }
}
