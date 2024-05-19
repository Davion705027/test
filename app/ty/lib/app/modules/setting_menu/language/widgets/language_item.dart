import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/image_view.dart';


class LanguageItem extends StatelessWidget {
  const LanguageItem({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.isSelected,
    required this.onTap,
  });

  final String title, imageUrl;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(left: 12.w),
        color: context.isDarkMode ? null : Colors.white,
        child: Container(
          height: 38.h,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color:  Color( context.isDarkMode ? 0xFF15161B :0xFFF2F2F6),
                width: 0.50.h,
              ),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    //   margin: EdgeInsets.only(top: 2),
                    child: ImageView(
                      imageUrl,
                      width: 25.w,
                      height: 18.w,
                    ),
                  ),
                  Container(
                    width: 8,
                  ),
                  Container(
                    child: Text(
                      title,
                      style: TextStyle(
                        color: Color(isSelected ? 0xFF179CFF : 0xFF7981A4),
                        fontSize: 13.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(right: 10.w),
                child: isSelected
                    ? ImageView(
                        "assets/images/language/selected.png",
                        width: 20.w,
                        height: 20.w,
                      )
                    : Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
