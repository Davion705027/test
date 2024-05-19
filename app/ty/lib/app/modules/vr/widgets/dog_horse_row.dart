import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/config/theme/app_color.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/widgets/image_view.dart';
import 'package:get/get_core/src/get_main.dart';

import 'vr_common_box_shadow.dart';

class DogHorseRow extends StatelessWidget {
  const DogHorseRow({
    super.key,
    required this.rank,
    this.isSelected = false,
    this.iconSrc,
    this.title,
    this.subtitle,
    this.onTap,
    required this.teamNum,
  });

  final int rank;
  final String teamNum;
  final String? iconSrc;
  final String? title;
  final String? subtitle;
  final bool isSelected;
  final VoidCallback? onTap;

  Widget buildContentView(){
    return  Row(
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
              color: (isSelected ? '#127DCC' : '#303442').hexColor,
            ),
          ),
        ),
        Text(
          subtitle ?? '${rank + 1}',
          style: TextStyle(
            fontSize: 16,
            color: (isSelected ? '#127DCC' : '#303442').hexColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return VrCommonBoxShadow(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      color: isSelected ? (Get.isDarkMode?AppColor.colorDarkMode:'#D1EBFF'.hexColor) : AppColor.colorWhite,
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
                color: (isSelected ? '#127DCC' : '#303442').hexColor,
              ),
            ),
          ),
          Text(
            subtitle ?? '${rank + 1}',
            style: TextStyle(
              fontSize: 16,
              color: (isSelected ? '#127DCC' : '#303442').hexColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
