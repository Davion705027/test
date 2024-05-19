// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/db/app_cache.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

class InformationLineView extends StatelessWidget {
  const InformationLineView({
    Key? key,
    required this.information,
    this.Type = 0,
    this.top = 8,
    this.multiLine = true,
  }) : super(key: key);

  final String information;
  final int Type, top;
  final bool multiLine;

  @override
  Widget build(BuildContext context) {
    List<Color> listColor = [
      const Color(0xFF303442),
      const Color(0xFFAFB3C8),
    ];
    if (context.isDarkMode) {
      listColor[0] = Colors.white.withOpacity(0.8999999761581421);
      listColor[1] = Colors.white.withOpacity(0.30000001192092896);
    }

    return Container(
      margin: EdgeInsets.only(top: top.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: multiLine
                ? Text(
                    information,
                    style: TextStyle(
                      color: listColor[Type],
                      fontSize: 12.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                    ),
                  )
                : Text(
                    information,
                    style: TextStyle(
                      color: listColor[Type],
                      fontSize: 12.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
          ),
        ],
      ),
    );
  }
}
