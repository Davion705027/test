import 'package:flutter/cupertino.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

typedef  CallDuration=Function(int day);

class DateSelectTabWidget extends StatefulWidget {
  CallDuration callDuration;
  DateSelectTabWidget(this.callDuration,{super.key});
  @override
  State<StatefulWidget> createState() {
    return DateSelectTabWidgetState();
  }
}

class DateSelectTabWidgetState extends State<DateSelectTabWidget> {
  int selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 118.w,
      height: 24.w,
      decoration: BoxDecoration(
        color: Get.theme.foldColor,
          borderRadius: BorderRadius.all(Radius.circular(20.w))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              selectIndex = 0;
              widget.callDuration(5);
              setState(() {});
            },
            child: Container(
              width: 39.w,
              height: 24.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: selectIndex == 0 ? Get.theme.betPanelUnderlineColor : Get.theme.foldColor,
                  borderRadius: BorderRadius.all(Radius.circular(24.w))),
              child: Text(
                " ${LocaleKeys.analysis_football_matches_near.tr}5 ",
                style: TextStyle(
                    fontSize: 12.sp,
                    color: selectIndex == 0
                        ? AppColor.colorSelectBorder
                        : AppColor.colorUnSelectBorder),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              selectIndex = 1;
              widget.callDuration(10);
              setState(() {});
            },
            child: Container(
              width: 39.w,
              height: 24.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(

                  color: selectIndex == 1 ? Get.theme.betPanelUnderlineColor : Get.theme.foldColor,
                  borderRadius: BorderRadius.all(Radius.circular(24.w))),
              child: Text(
                " ${LocaleKeys.analysis_football_matches_near.tr}10 ",
                style: TextStyle(
                    fontSize: 12.sp,
                    color: selectIndex == 1
                        ? AppColor.colorSelectBorder
                        : AppColor.colorUnSelectBorder),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              selectIndex = 2;
              setState(() {});
              widget.callDuration(15);
            },
            child: Container(
              width: 39.w,
              height: 24.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: selectIndex == 2 ? Get.theme.betPanelUnderlineColor : Get.theme.foldColor,
                  borderRadius: BorderRadius.all(Radius.circular(24.w))),

              child: Text(
                " ${LocaleKeys.analysis_football_matches_near.tr}15 ",
                style: TextStyle(
                    fontSize: 12.sp,
                    color: selectIndex == 2
                        ? AppColor.colorSelectBorder
                        : AppColor.colorUnSelectBorder),
              ),
            ),
          )
        ],
      ),
    );
  }
}
