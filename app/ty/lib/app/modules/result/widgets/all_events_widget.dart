import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import '../../../widgets/image_view.dart';
import '../../match_detail/widgets/header/score/match_detail_score.dart';
import 'HeaderModel.dart';

class AllEventsWidget extends StatelessWidget {
  const AllEventsWidget({
    super.key,
    required this.isDark,
    this.onExpandAll,
    required this.isExpandAll,
  });

  final bool isDark;
  final VoidCallback? onExpandAll;
  final bool isExpandAll;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      decoration: BoxDecoration(
        color: context.isDarkMode ? const Color(0xfff1e2029) : Colors.white,
        border: Border(
          top: BorderSide(
            color: const Color(0xFFFEAE2B).withOpacity(.8),
            width: 2.0.h,
          ),
        ),
      ),
      child: InkWell(
        onTap: onExpandAll,
        child: Container(
          margin: EdgeInsets.only(left: 14.w, right: 14.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ImageView(
                    'assets/images/icon/icon_date.png',
                    width: 18.w,
                    height: 18  .w,
                  ),
                  Container(
                    width: 5.w,
                  ),
                  Text(
                  LocaleKeys.filter_all_leagues.tr,
                    style: TextStyle(
                      color: context.isDarkMode
                          ? Colors.white
                          : const Color(0xFF303442),
                      fontSize: 12.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
              SizedBox(
                width: 30.w,
                height: 20.w,
                child: Transform.rotate(
                  angle: isExpandAll ? 0 : -pi / 2,
                  child: ImageView(
                    context.isDarkMode
                        ? 'assets/images/icon/allEvents_dark.png'
                        : 'assets/images/icon/allEvents_light.png',
                    width: 30.w,
                    height: 20.w,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
