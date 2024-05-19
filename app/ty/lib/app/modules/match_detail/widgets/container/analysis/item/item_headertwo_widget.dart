import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';

import '../blue_text_view.dart';
import 'date_time_select_tab_widget.dart';
import 'gray_text_view.dart';


class ItemHeaderTwoWidget extends StatelessWidget {
  final String? name;
  const ItemHeaderTwoWidget({super.key, this.name});

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 32.w,
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Container(
            width: 2.w,
            height: 12.w,
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
            width: 6.w,
          ),
          Expanded(
            child: Text(
              name ?? '',
              style: TextStyle(
                fontSize: 14.sp,
                color: Get.theme.oddsButtonValueFontColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          bluetext("同主客", 60, 25),
          Text("  "),
          graytext("同赛事", 60, 25),
          Text("  "),
          DateSelectTabWidget((days){

          }),

        ],
      ),
    );
  }

}
