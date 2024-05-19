import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/analysis/item/item_header_widget.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../../../widgets/image_view.dart';

/// 下拉赛事选择项
class MatchHistoryItem extends StatelessWidget {
  const MatchHistoryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.w),
      // padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.w),
      width: 1.sw,
      height: 72.w,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
           
        controller: ScrollController(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 56.w,
              height: 72.w,
              decoration: BoxDecoration(
                border: Border(
                    right: BorderSide(color: Color(0xFFF2F2F6), width: 0.5),
                    bottom: BorderSide(color: Color(0xFFF2F2F6), width: 0.5)),
              ),
              alignment: Alignment.center,
              child: Text(
                "Dafabet",
                style: TextStyle(
                  color:Get.theme.tabPanelSelectedColor,
                  fontSize: 12.sp,
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(color: Color(0xFFF2F2F6), width: 0.5),
                        bottom:
                            BorderSide(color: Color(0xFFF2F2F6), width: 0.5)),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "即时",
                    style: TextStyle(
                      color:Get.theme.tabPanelSelectedColor,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(color: Color(0xFFF2F2F6), width: 0.5),
                        bottom:
                            BorderSide(color: Color(0xFFF2F2F6), width: 0.5)),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "初盘",
                    style: TextStyle(
                      color:Get.theme.tabPanelSelectedColor,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  width: 90.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(color: Color(0xFFF2F2F6), width: 0.5),
                        bottom:
                            BorderSide(color: Color(0xFFF2F2F6), width: 0.5)),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "1.82",
                    style: TextStyle(
                        color:Get.theme.tabPanelSelectedColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w800),
                  ),
                ),
                Container(
                  width: 90.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(color: Color(0xFFF2F2F6), width: 0.5),
                        bottom:
                            BorderSide(color: Color(0xFFF2F2F6), width: 0.5)),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "1.84",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Color(0xFFF53F3F),
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  width: 90.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(color: Color(0xFFF2F2F6), width: 0.5),
                        bottom:
                            BorderSide(color: Color(0xFFF2F2F6), width: 0.5)),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "1",
                    style: TextStyle(
                        color:Get.theme.tabPanelSelectedColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w800),
                  ),
                ),
                Container(
                  width: 90.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(color: Color(0xFFF2F2F6), width: 0.5),
                        bottom:
                            BorderSide(color: Color(0xFFF2F2F6), width: 0.5)),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "0",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF00B42A),
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  width: 90.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(color: Color(0xFFF2F2F6), width: 0.5),
                        bottom:
                            BorderSide(color: Color(0xFFF2F2F6), width: 0.5)),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "1.09",
                    style: TextStyle(
                        color:Get.theme.tabPanelSelectedColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w800),
                  ),
                ),
                Container(
                  width: 90.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(color: Color(0xFFF2F2F6), width: 0.5),
                        bottom:
                            BorderSide(color: Color(0xFFF2F2F6), width: 0.5)),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "1.84",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF00B42A),
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
