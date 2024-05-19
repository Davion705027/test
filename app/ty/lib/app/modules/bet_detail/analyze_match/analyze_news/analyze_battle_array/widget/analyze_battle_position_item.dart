import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import '../../../../../../services/models/res/analyze_array_person_entity.dart';

/// 下拉赛事选择项
class AnalyzeBattlePositionItem extends StatelessWidget {
  final Up entity;
  const AnalyzeBattlePositionItem(
    this.entity, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [
        Container(
          alignment: Alignment.center,
          width: 36.w,
          height: 36.w,
          decoration: BoxDecoration(
            color: const Color(0xFFFFAA01),
            borderRadius: BorderRadius.circular(36.w),
            border: Border.all(
              color: Colors.white,
              width: 1.w,
            ),
          ),
          child: Text(
            "${entity.shirtNumber ?? 0}",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          height: 2.w,
        ),
        Container(
          width: 85.w,

          alignment: Alignment.center,
          child: Text(
            entity.thirdPlayerName ?? "",
            overflow:TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
