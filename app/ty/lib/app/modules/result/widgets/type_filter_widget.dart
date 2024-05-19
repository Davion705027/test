import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/result/normal_results/normal_results_controller.dart';

import '../../../core/constant/common/module/csid.dart';
import '../../../widgets/image_view.dart';
import '../../../widgets/jlt.dart';
// https://assets-image.oceasfe.com/public/upload/app/ty/assets-2024-04-05-12-00/images/jlt-act.png

class TypeFilterWidget extends StatelessWidget {
  const TypeFilterWidget({
    super.key,
    required this.title,
    required this.isSelected,
    required this.isDark,
    required this.index,
    this.onTap,
    required this.titleIndex,
    required this.miid,
  });

  final String title;
  final bool isSelected;
  final bool isDark;
  final int index;
  final VoidCallback? onTap;
  final int titleIndex;
  final int miid;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // titleIndex == 0 ?
            JltWidget(miid: miid, selected: isSelected)
            // ImageView(
            //   isDark ? isSelected ?  'assets/images/icon/menu/menu_result_select_$index.png' :  'assets/images/icon/menu/menu_result_dark_$index.png' : isSelected ?  'assets/images/icon/menu/menu_result_select_$index.png' : 'assets/images/icon/menu/menu_result_light_$index.png',
            //   width: 28.w,
            //   height: 28.w,
            // )
            // :
            // ImageView(
            //   isDark ? isSelected ?  'assets/images/icon/menu/gaming_result_select_$index.png' :  'assets/images/icon/menu/gaming_result_dark_$index.png' : isSelected ?  'assets/images/icon/menu/gaming_result_select_$index.png' : 'assets/images/icon/menu/gaming_result_light_$index.png',
            //   width: 28.w,
            //   height: 28.w,
            // )
            ,
            Container(
              margin: EdgeInsets.only(
                top: 2.h,
              ),
              child: AutoSizeText(
                title,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isDark
                      ? isSelected
                          ? Colors.white
                          : Colors.white.withOpacity(0.5)
                      : isSelected
                          ? const Color(0xFF303442)
                          : const Color(0xFFAFB3C8),
                  fontSize: 10.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
