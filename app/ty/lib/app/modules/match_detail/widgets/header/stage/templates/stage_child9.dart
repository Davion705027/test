import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:get/get.dart';

import '../../../../../../services/models/res/match_entity.dart';

/// 详情页显示排球赛事第几节以及赛事时间
class StageChild9 extends StatelessWidget {
  const StageChild9(
      {super.key,
      required this.isPinnedAppbar,
      required this.match,
      required this.isMatchSelect});

  final bool isPinnedAppbar;
  final MatchEntity match;
  final bool isMatchSelect;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AutoSizeText(
          "mmp_9_${match.mmp}".tr,
          maxLines: 1,
          minFontSize: 8,
          style: TextStyle(
            color: isMatchSelect ? Get.theme.subSelectTitleColor : Colors.white,
            fontSize: isPinnedAppbar ? 14.sp : 12.sp,
            fontFamily: 'PingFang SC',
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
