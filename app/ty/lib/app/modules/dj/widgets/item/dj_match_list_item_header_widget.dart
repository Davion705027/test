import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/models/res/dj_list_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';

import '../../../../widgets/image_view.dart';

class DJMatchListItemHeaderWidget extends StatelessWidget {
  const DJMatchListItemHeaderWidget(
      {super.key,
      required this.matchEntity,
      required this.onExpandChange,
      required this.onCollectionChange,
      this.hasCollection,
        this.count = 0});

  final MatchEntity matchEntity;
  final ValueChanged<bool> onExpandChange;
  final ValueChanged<bool> onCollectionChange;
  final bool? hasCollection;
  final int count;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onExpandChange(!matchEntity.isExpand);
      },
      child: Container(
        height: 24.h,
        alignment: Alignment.centerLeft,
        color: context.isDarkMode
            ? Colors.white.withOpacity(0.03999999910593033)
            : Colors.white.withOpacity(0.5),
        child: Row(
          children: [
            Container(
              width: 2.w,
              height: 12.h,
              decoration: BoxDecoration(
                // 右上 右下圆角
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(2.w),
                  bottomRight: Radius.circular(2.w),
                ),
                color: const Color(0xff179CFF),
              ),
            ),

            SizedBox(
              width: 4.w,
            ),
            Expanded(
              child: Text(
                matchEntity.tn,
                // 'LCK 韩国冠军联赛 - 春季赛',
                style: TextStyle(
                  fontSize: 12.sp,
                  color:
                  context.isDarkMode? Colors.white.withOpacity(0.9):const Color(0xff303442),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
                count==0|| matchEntity.isExpand?"": "$count",
              style: TextStyle(
                fontSize: 12.sp,
                color:
                // Color(0xff303442),
                context.isDarkMode? Colors.white.withOpacity(0.9):const Color(0xffC9C9C9),
                fontWeight: FontWeight.w600,
              ),
            ),
            InkWell(
              onTap: () {
                onExpandChange(!matchEntity.isExpand);
              },
              child: Container(
                width: 24.h,
                height: 24.h,
                alignment: Alignment.center,
                child: ImageView(
                  matchEntity.isExpand

                      ? context.isDarkMode
                      ? 'assets/images/league/item_expand_darkmode.png'
                      : 'assets/images/league/item_expand.png'
                      : context.isDarkMode
                      ? 'assets/images/league/ico_arrowright_nor_darkmode.png'
                      : 'assets/images/league/ico_arrowright_nor.png',

                      // ? context.isDarkMode?'assets/images/league/item_expand_darkmode.svg':'assets/images/league/item_expand.png'
                      // : context.isDarkMode?'assets/images/league/ico_arrowright_nor_darkmode.png':'assets/images/league/ico_arrowright_nor.png',
                  width: 12.w,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
