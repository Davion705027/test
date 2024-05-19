import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import '../../../../../../services/models/res/analyze_back_video_info_entity_entity_entity_entity.dart';
import '../../../../../../widgets/image_view.dart';
import '../analyze_match_history_logic.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
class AnalyzeHistoryTimelineView extends StatelessWidget {
  AnalyzeHistoryTimelineView(this.element,this.name, this.time, this.country,
      this.fragmentPic, this.isShowLeft,
      {super.key, this.showFirst});
  final AnalyzeBackVideoInfoEntityEntityEntityEventList element;
  final String name;
  final String time;
  final String country;
  final bool isShowLeft;

  final String fragmentPic;

  bool? showFirst = false;

  @override
  Widget build(BuildContext context) {
    double videoContaineWidth = 0.426 * ScreenUtil().screenWidth;
    // TODO: implement build
    return GetBuilder<AnalyzeMatchHistoryLogic>(
        builder: (controller){
      return Container(
          height: 78.w,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                  visible: isShowLeft==true,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  child: InkWell(
                    onTap: (){
                      controller.setSelectItem(element);
                    },
                    child: Container(
                        alignment: Alignment.centerRight,
                        height: 60.w,
                        width: videoContaineWidth,
                        padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: ShapeDecoration(
                          color: element==controller.state.curAnalyzeBackVideoInfoEntityEntityEntityEventList?const Color(0x33179CFF):const Color(0x33AFAFAF),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.w)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      " [3-5]",
                                      style: TextStyle(
                                          color: Color(0xFF179CFF),
                                          fontSize: 12.sp),
                                    ),
                                    Text(
                                      "14:00",
                                      style: TextStyle(
                                          color:Get.theme.tabPanelSelectedColor,
                                          fontSize: 12.sp),
                                    ),
                                  ],
                                ),
                                Text(
                                  "多特蒙德",
                                  style: TextStyle(
                                      color: Color(0xFF7981A4), fontSize: 11.sp),
                                ),
                                Text(
                                  "第1个进球",
                                  style: TextStyle(
                                      color: Color(0xFF7981A4), fontSize: 11.sp),
                                ),
                              ],
                            ),
                            SizedBox(width: 6.w),
                            Container(
                              width: 77.w,
                              height: 54.w,
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(8.w)),
                                    child: ImageView(
                                      cornerRadius: 4.w,
                                      fragmentPic,
                                      width: 77.w,
                                      height: 54.w,
                                      boxFit: BoxFit.fill,
                                    ),
                                  ),
                                  Positioned(
                                    left: 0,
                                    right: 0,
                                    top: 0,
                                    bottom: 0,
                                    child: ImageView(
                                        "assets/images/analyze/analyze_history_icon2.png", width: 12,),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )),
                  )),

              Column(children: [
                Container(
                  height: 8.w,
                  width: 1.5.w,
                  color: Color(0xff179CFF),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Container(
                    margin: EdgeInsets.all(4.w),
                    alignment: Alignment.center,
                    height: 14.w,
                    width: 14.w,
                    child: ImageView(
                      country,
                      width: 14.w,
                      height: 14.w,
                    ),
                  ),
                ]),
                Expanded(child: Container(
                  width: 1.5.w,
                  color: Color(0xff179CFF),
                )),
              ]),
              Visibility(
                  visible: isShowLeft==false,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  child: InkWell(
                    onTap: (){
                      controller.setSelectItem(element);
                    },
                    child: Container(
                        alignment: Alignment.centerRight,
                        height: 60.w,
                        width: videoContaineWidth,
                        padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: ShapeDecoration(
                          color: element==controller.state.curAnalyzeBackVideoInfoEntityEntityEntityEventList?const Color(0x33179CFF):const Color(0x33AFAFAF),

                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.w)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      " [3-5]",
                                      style: TextStyle(
                                          color: Color(0xFF179CFF),
                                          fontSize: 12.sp),
                                    ),
                                    Text(
                                      "14:00",
                                      style: TextStyle(
                                          color:Get.theme.tabPanelSelectedColor,
                                          fontSize: 12.sp),
                                    ),
                                  ],
                                ),
                                Text(
                                  "多特蒙德",
                                  style: TextStyle(
                                      color: Color(0xFF7981A4), fontSize: 11.sp),
                                ),
                                Text(
                                  "第1个进球",
                                  style: TextStyle(
                                      color: Color(0xFF7981A4), fontSize: 11.sp),
                                ),
                              ],
                            ),
                            SizedBox(width: 6.w),
                            Container(
                              width: 77.w,
                              height: 54.w,
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(8.w)),
                                    child: ImageView(
                                      cornerRadius: 4.w,
                                      fragmentPic,
                                      width: 77.w,
                                      height: 54.w,
                                      boxFit: BoxFit.fill,
                                    ),
                                  ),
                                  Positioned(
                                    left: 0,
                                    right: 0,
                                    top: 0,
                                    bottom: 0,
                                    child: ImageView(
                                        "assets/images/analyze/analyze_history_icon2.png", width: 12,),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )),
                  )),

            ],
          ));
    });
  }
}
