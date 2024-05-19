import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/global/user_controller.dart';
import 'package:flutter_ty_app/app/widgets/image_view.dart';
import 'package:get/get.dart';

import '../../../../../generated/locales.g.dart';

class DJHeaderWidget extends StatefulWidget {
  const DJHeaderWidget({super.key});


  @override
  State<DJHeaderWidget> createState() => _DJHeaderWidgetState();
}

class _DJHeaderWidgetState extends State<DJHeaderWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.h,
      color: context.theme.scaffoldBackgroundColor,
      padding:  EdgeInsets.symmetric(horizontal: 14.w),
      alignment: Alignment.center,
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Container(
              width: 24.w,
              height: 24.w,
              alignment: Alignment.center,
              child: ImageView(
                "assets/images/dj/icon_arrowleft_nor.svg",
                boxFit: BoxFit.fill,
                width: 20.w,
                svgColor:  context.isDarkMode? Colors.white:Colors.black,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                LocaleKeys.menu_itme_name_esports.tr,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  color: context.isDarkMode? Colors.white.withOpacity(0.9): Colors.black,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          _buildBalance(),
        ],
      ),
    );
  }

  Widget _buildBalance() {
    return GetBuilder<UserController>(builder: (controller) {
      return GestureDetector(
        onTap: () {
        },
        child: Container(
          padding:
          EdgeInsets.only(top: 2.h, left: 4.w, right: 6.w, bottom: 2.h),
          height: 22.h,
          decoration: ShapeDecoration(
            color:context.isDarkMode? Colors.white.withOpacity(0.04):  const Color(0xFFF2F2F6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13),
            ),
          ),
          child: Row(
            children: [
              ImageView('assets/images/home/icon_trans_nor.svg',
                  width: 16.w, height: 16.w),
              Container(width: 5.w,),
              Text(
                controller.balance.value != null
                    ? controller.toAmountSplit(controller.balance.value!.amount.toString())
                    : '-',
                style: TextStyle(
                  color: context.isDarkMode? Colors.white.withOpacity(0.9): const Color(0xFF303442),
                  fontSize: 14.sp,
                  fontFamily: 'DIN Alternate',
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
