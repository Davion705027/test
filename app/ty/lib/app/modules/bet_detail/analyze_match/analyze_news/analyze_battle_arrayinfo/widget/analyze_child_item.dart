import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../../../services/models/res/analyze_array_person_entity.dart';
import '../../../../../../widgets/image_view.dart';

/// 下拉赛事选择项
class AnalyzeChildItem extends StatelessWidget {
  Up entity;
  AnalyzeChildItem(this.entity,{super.key});
  @override
  Widget build(BuildContext context) {
    print("=================>thirdPlayerPicUrl  ${entity.thirdPlayerPicUrl}");


    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(8.w),
      height: 40.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 60.w,
            height: 44.w,
            alignment: Alignment.center,
            child: ClipOval(
              child:

              ImageView(
                boxFit: BoxFit.fill,
                entity.thirdPlayerPicUrl?.isNotEmpty==true?(entity.thirdPlayerPicUrl??""):"https://app-h5.dbsportxxx1zx.com/2024-04-02-16-09-04/app-h5/image/png/my.png",

                width: 28.w,
                height: 28.w,
              ),
            ),
          ),
          Container(
            width: 60.w,
            alignment: Alignment.centerLeft,
            child: Text(
              entity.positionName??"",
              style: TextStyle(
                color:Get.theme.tabPanelSelectedColor,
                fontSize: 11.sp
              ),
            ),
          ),
          Expanded(
            child: Container(

              alignment: Alignment.center,
              child: Text(
                entity.thirdPlayerName??"",
                style: TextStyle(
                  color:Get.theme.tabPanelSelectedColor,
                  fontSize: 11.sp,
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            width: 60.w,
            child: Text(
              "${entity.shirtNumber??0}",
              style: TextStyle(
                color:Get.theme.tabPanelSelectedColor,
                fontSize: 11.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
