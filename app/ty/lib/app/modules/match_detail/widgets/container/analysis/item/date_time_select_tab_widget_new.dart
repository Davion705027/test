import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

class DateSelectTabWidgetNew extends StatefulWidget {
  const DateSelectTabWidgetNew(
    this.callDuration, {
    super.key,
  });

  final Function(int day) callDuration;

  @override
  State<StatefulWidget> createState() {
    return DateSelectTabWidgetNewState();
  }
}

class DateSelectTabWidgetNewState extends State<DateSelectTabWidgetNew> {
  int selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 120.w,
        height: 26.w,
        decoration: BoxDecoration(
          color: Get.theme.foldColor,
          borderRadius: BorderRadius.circular(26.w),
        ),
        child: Center(
          child: Container(
            width: 118.w,
            height: 24.w,
            decoration: BoxDecoration(
              color: Get.theme.foldColor,
              borderRadius: BorderRadius.circular(24.w),
            ),
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
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.w),
                        bottomLeft: Radius.circular(24.w),
                      ),
                      color: selectIndex == 0
                          ? Get.theme.oddsButtonBackgroundColor
                          : Get.theme.foldColor,
                    ),
                    child: Text(
                      " ${LocaleKeys.analysis_football_matches_near.tr}5 ",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: selectIndex == 0
                            ? Get.theme.secondTabPanelSelectedFontColor
                            : AppColor.colorUnSelectBorder,
                      ),
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
                      color: selectIndex == 1
                          ? Get.theme.oddsButtonBackgroundColor
                          : Get.theme.foldColor,
                    ),
                    child: Text(
                      " ${LocaleKeys.analysis_football_matches_near.tr}10 ",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: selectIndex == 1
                            ? Get.theme.secondTabPanelSelectedFontColor
                            : AppColor.colorUnSelectBorder,
                      ),
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
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(24.w),
                        bottomRight: Radius.circular(24.w),
                      ),
                      color: selectIndex == 2
                          ? Get.theme.oddsButtonBackgroundColor
                          : Get.theme.foldColor,
                    ),
                    child: Text(
                      " ${LocaleKeys.analysis_football_matches_near.tr}15 ",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: selectIndex == 2
                            ? Get.theme.secondTabPanelSelectedFontColor
                            : AppColor.colorUnSelectBorder,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
