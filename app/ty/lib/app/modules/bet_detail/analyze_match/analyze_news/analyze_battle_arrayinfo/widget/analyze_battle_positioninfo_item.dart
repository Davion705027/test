import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import '../../../../../../services/models/res/analyze_array_person_entity.dart';
import '../../../../../../widgets/image_view.dart';
import '../analyze_battle_array_logic.dart';

/// 下拉赛事选择项
class AnalyzeBattlePositionItem extends StatelessWidget {
  Up entity;
  AnalyzeBattlePositionItem(this.entity,{super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          width: 36.w,
          height: 36.w,
          decoration: BoxDecoration(
              color: Color(0xFFFFAA01),
              borderRadius: BorderRadius.all(Radius.circular(36)),
              border: Border.all(color: Colors.white,width: 1.w)
          ),
          child: Text(
            "${entity.shirtNumber??0}",
            style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white
            ),
          ),
        ),
        SizedBox(height: 2.w,),
        Text(
          entity.thirdPlayerName??"",
          style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: Color(0xFFF2F2F2)
          ),
        ),
      ],
    );
  }
}
