import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';

import 'analyze_divider.dart';

class ItemHeaderWidget extends StatelessWidget {
  final String? name;
  Color? bgColor;
  bool? showDivider;
  double? height;

  ItemHeaderWidget({super.key,this.height, this.name, this.bgColor, this.showDivider});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor ?? Colors.transparent,
      height: 32.w,
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
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
              )
            ],
          ),
          if(showDivider==true)
            Column(children: [
              SizedBox(height: 4.w,),
              AnalyzeDivider()
            ],)
        ],
      ),
    );
  }
}
