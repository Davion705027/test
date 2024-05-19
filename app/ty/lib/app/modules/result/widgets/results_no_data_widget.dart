import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../widgets/image_view.dart';

class ResultsNoDataWidget extends StatelessWidget {
  const ResultsNoDataWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 100.h,
      ),
      child: Column(
        children: [
          ImageView(
            'assets/images/icon/def_common.png',
            width: 240.w,
            height: 240.h,
          ),
          Container(
            width: 8.w,
          ),
          Text(
            LocaleKeys.common_no_data.tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF7981A3),
              fontSize: 16.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
