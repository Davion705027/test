import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/config/theme/app_color.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/widgets/image_view.dart';
import 'package:get/get.dart';

import 'vr_common_box_shadow.dart';

class DogHorseRankRow extends StatelessWidget {
  const DogHorseRankRow({
    super.key,
    required this.rank,
    this.iconSrc,
    this.title,
    this.subtitle,
    required this.teamNum,
  });

  final int rank;
  final String teamNum;
  final String? iconSrc;
  final String? title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return VrCommonBoxShadow(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      color: Get.isDarkMode
          ? Colors.white.withOpacity(0.03999999910593033)
          : AppColor.colorWhite,
      child: Row(
        children: [
          ImageView(
            iconSrc ?? 'assets/images/vr/vr_dog_horse_rank$teamNum.png',
            width: 20.w,
            height: 20.w,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              title ?? 'Annette Black',
              style: TextStyle(
                fontSize: 12,
                color: Get.isDarkMode ? Colors.white : '#303442'.hexColor,
              ),
            ),
          ),
          Text(
            subtitle ?? '${rank + 1}',
            style: TextStyle(
              fontSize: 12.sp,
              color: Get.isDarkMode ? Colors.white : '#303442'.hexColor,
              fontWeight: FontWeight.w700,
              // 设计稿字体：Akrobat，字重：bold，字号：12
              // fontFamily: '',
            ),
          ),
        ],
      ),
    );
  }
}
