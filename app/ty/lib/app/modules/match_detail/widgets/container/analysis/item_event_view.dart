import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';

import '../../../../login/login_head_import.dart';

/**
 * @author[xiongwei]
 * @version[创建日期，2024/2/28 13:22]
 * @function[功能简介 ]
 **/
class item_event_view extends StatelessWidget {
  const item_event_view(
      this.name, this.time, this.country, this.isShow, this.isShow1,
      {super.key});

  final String name;
  final String time;
  final String country;
  final bool isShow;

  final bool isShow1;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        margin: EdgeInsets.all(10.w),
        alignment: Alignment.center,
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Visibility(
                  visible: isShow,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  child: Container(
                      alignment: Alignment.centerRight,
                      height: 35.h,
                      width: 150.w,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: ShapeDecoration(
                        color:  Get.theme.resultContainerBgColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                      ),
                      child: Text(
                        name,
                        style: TextStyle(
                            fontSize: 12.w,
                            fontWeight: FontWeight.w400,
                            color:Get.theme.tabPanelSelectedColor),
                      ))),

              Container(
                alignment: Alignment.center,
                height: 30.h,
                width: 30.w,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: ShapeDecoration(
                  color:  Get.theme.resultContainerBgColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                ),
                child: ImageView(
                  country,
                  width: 40.w,
                  height: 40.w,
                ),
              ),
              Visibility(
                visible: isShow1,
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: Container(
                    alignment: Alignment.centerLeft,
                    height: 35.h,
                    width: 150.w,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: ShapeDecoration(
                      color:  Get.theme.resultContainerBgColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                    ),
                    child: Text(
                      time,
                      style: TextStyle(
                          fontSize: 12.w,
                          fontWeight: FontWeight.w400,
                          color:Get.theme.tabPanelSelectedColor),
                    )),
              )
            ]),
            Container(
              margin: const EdgeInsets.only(top: 10),
              height: 20.h,
              width: 1.5.w,
              color: Color(0xff179CFF),
            )
          ],
        ));
  }
}
