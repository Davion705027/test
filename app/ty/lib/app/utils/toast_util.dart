import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import '../../generated/locales.g.dart';
import '../config/theme/app_color.dart';
import '../widgets/image_view.dart';

class ToastUtils {
  static show(String msgStr) {
    showToast(
      msgStr,
      backgroundColor: AppColor.toastBackground.withOpacity(1.0),
      textStyle: const TextStyle(color: Colors.white, fontSize: 14),
      radius: 6,
      textPadding:
          const EdgeInsets.only(top: 10, bottom: 10, left: 12, right: 12),
      dismissOtherToast: true,
    );
  }

  static showGrayBackground(String msgStr) {
    showToast(
      msgStr,
      backgroundColor: Colors.black.withOpacity(0.699999988079071),
      textStyle: const TextStyle(color: Colors.white, fontSize: 14),
      radius: 4,
      textPadding:
       EdgeInsets.only(top: 8.h, bottom: 8.h, left: 12.w, right: 12.w),
      dismissOtherToast: true,
    );
  }

  /// 确认弹窗，底部显示"我知道了"
  static message(
      {String title = "", required String content, bool fullscreen = false}) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0), // 设置圆角
        ),
        child: Container(
          constraints: const BoxConstraints(minHeight: 193, maxHeight: 326),
          width: fullscreen ? 270 : 256,
          padding: const EdgeInsets.only(top: 20),
          decoration: ShapeDecoration(
            color: Get.isDarkMode ? const Color(0xFF303442) : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x4C000000),
                blurRadius: 10,
                offset: Offset(0, 0),
                spreadRadius: 0,
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (title != "")
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Get.isDarkMode
                                ? Colors.white.withOpacity(0.9)
                                : const Color(0xFF303442),
                            fontSize: fullscreen ? 18 : 16,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ).marginOnly(bottom: fullscreen ? 8 : 22),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Text(
                            content,
                            style: TextStyle(
                              color: Get.isDarkMode
                                  ? Colors.white.withOpacity(0.5)
                                  : const Color(0xFF7981A4),
                              fontSize: 14,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 1,
                margin: EdgeInsets.only(top: fullscreen ? 12 : 24),
                color: Get.isDarkMode
                    ? const Color(0xFF272931)
                    : const Color(0xFFF3FAFF),
              ),
              Container(
                height: 44,
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Text(
                    LocaleKeys.info_rules_i_know.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Get.isDarkMode
                          ? const Color(0xFF127DCC)
                          : const Color(0xFF179CFF),
                      fontSize: 16,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 300),
      transitionCurve: Curves.easeInOut,
    );
  }

  ///自定义投注金额成功
  static customizedBetAmountSuccessful(String msgStr) {
    var t = Container(
      height: 45.h,
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 100.h),

      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        gradient: const LinearGradient(
          colors: [Color(0xFF179CFF), Color(0xFF45B0FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          Container(width: 15.w,),
          ImageView(
            'assets/images/icon/a_ok.png',
            width: 18.w,
            height: 18.w,
            color: Colors.white,
          ),
          Container(width: 15.w,),
          Container(
            alignment: Alignment.center,
            width: 280.w,
            child: Text(
              msgStr,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFFFFFFFF),
                fontSize: 14.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w500,
              ),
            ),
          )

        ],
      ),
    );

    showToastWidget(
      t,
      duration: const Duration(seconds: 2),
      position: const ToastPosition(
        align: Alignment.bottomCenter,
      ),
    );
  }
}
