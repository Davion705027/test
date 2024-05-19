import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/image_view.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({
    super.key,
    required this.title,
    required this.imageUrl,
    this.onTap,
    required this.summary,
    required,
    required this.isDark,
    required this.subTitle,
    required this.dividing,
  });

  final bool isDark;
  final bool dividing;
  final String title;
  final String subTitle;
  final String summary;
  final String imageUrl;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 48.h,
        color: isDark ?  Colors.white.withOpacity(0.03999999910593033) : Colors.white,
        child: Container(
          decoration:
          dividing == true ?
          BoxDecoration(
            border: Border(
              top: BorderSide(
                color: isDark ? Colors.white.withOpacity(0.07999999821186066) : const Color(0xFFF2F2F6),
                width: 0.50.h,
              ),
            ),
          ):null,
          margin: EdgeInsets.only(
            left: 14.w,
            right: 14.w,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: isDark ? Colors.white.withOpacity(0.8999999761581421) : const Color(0xFF303442),
                      fontSize: 14.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Container(
                    width: 5.w,
                  ),
                  if (summary.isNotEmpty)
                    Text(
                      summary,
                      style: TextStyle(
                        color: isDark ? Colors.white.withOpacity(0.30000001192092896) : const Color(0xFFAFB3C8),
                        fontSize: 14.sp,
                      ),
                    ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (imageUrl.isNotEmpty)
                    ImageView(
                      imageUrl,
                      width: 70.w,
                      height: 24.h,
                    ),
                  Container(
                    width: 5.w,
                  ),
                  if (subTitle.isNotEmpty)
                    Text(
                      subTitle,
                      style: TextStyle(
                        color: isDark ? Colors.white.withOpacity(0.30000001192092896) : const Color(0xFFAFB3C8),
                        fontSize: 14.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  Container(
                    width: 5.w,
                  ),
                  ImageView(
                    isDark ? "assets/images/icon/icon_arrow_right_grey.png" : "assets/images/icon/icon_arrow_right_grey_light.png",
                    width: 16.w,
                    height: 16.w,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
