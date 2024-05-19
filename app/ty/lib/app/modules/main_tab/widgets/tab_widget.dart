import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

import '../../../widgets/image_view.dart';

class TabWidget extends StatelessWidget {
  const TabWidget({
    super.key,
    required this.title,
    required this.imageUrl,
    this.onTap,
    required,
    this.animation = false,
    this.animate,
    required this.dailyActivities,
  });

  final String title;
  final String imageUrl;
  final VoidCallback? onTap;
  final bool animation;
  final bool dailyActivities;
  final AnimationController? animate;

  ///菜单数量
  final int tabNum = 5;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            dailyActivities == true
                ? Column(
                    children: [
                      ImageView(
                        'assets/images/icon/activity.gif',
                        width: 55.w,
                        height: 55.w,
                      )
                    ],
                  )
                : Column(
                    children: [
                      animation == true
                          ? RotationTransition(
                              turns:
                                  Tween(begin: 0.0, end: 1.0).animate(animate!),
                              child: ImageView(
                                context.isDarkMode ? 'assets/images/icon/main_tab5_night.svg':'assets/images/icon/main_tab5.png',
                                width: 24.w,
                                height: 24.w,
                              ),
                            )
                          : ImageView(
                              imageUrl,
                              width: 24.w,
                              height: 24.w,
                            ),
                      Container(
                        height: 5.h,
                      ),
                     Container(
                       margin: EdgeInsets.only(left: 2.w,right: 2.w),
                       width: MediaQuery.of(context).size.width / tabNum,
                       child:  Text(
                         title,
                         maxLines: 1,
                         overflow: TextOverflow.ellipsis,
                         textAlign: TextAlign.center,
                         style:  TextStyle(
                           color: context.isDarkMode ? const Color(0xff40ffffff) : const Color(0xff949AB6),
                           fontSize: 12,
                         ),
                       ),
                     )
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
