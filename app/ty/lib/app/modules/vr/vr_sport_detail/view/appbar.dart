import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/controllers/vr_home_controller.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/going_sport_widget.dart';
import 'package:flutter_ty_app/app/utils/bus/bus.dart';
import 'package:flutter_ty_app/app/utils/bus/event_enum.dart';

class detailsAppBar extends GetView<VrSportDetailLogic> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<VrHomeController>(builder: (VrHomeController controller) {
      final vrMatch = VrSportDetailLogic.to.state.vrMatch!;
      final match = VrSportDetailLogic.to.state.match!;
      const nextVrMatch = null;
      return Container(
        // margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Stack(
          children: [
            ///体育头部
            // Padding(
            //   // padding: EdgeInsets.only(top: 30),
            //   child: ,
            // ),
            GoingSportWidget(
              key: ValueKey('going_match_${vrMatch?.batchNo}'),
              type: controller.topMenu?.type ?? 1,
              vrMatch: vrMatch,
              nextVrMatch: nextVrMatch,
              getVirtualReplay: controller.getVirtualReplay,
              onNextMatchCountdownEnd: controller.onNextMatchCountdownEnd,
              onVideoPlayFinished: (){
                controller.onVideoPlayFinished();
                Get.log("发送赛事结束 =");
                2.seconds.delay((){
                  Bus.getInstance().emit(
                    EventType.VRDetailEnd,
                  );
                });
              },
              isShowItem: false,
              isVrDetail: true,
              aspectRatio: 390 / 264,
              onCount: (time){
                Get.log("剩余时间 = $time");
                if(time<=10){
                  Get.log("发送封盘 = $time");

                  Bus.getInstance().emit(
                    EventType.VRDetailClose,
                  );
                }
              },
            ),
            Align(
              alignment: Alignment.center,
              child: SafeArea(
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () async {
                          Get.back();
                        },
                        child: Container(
                          // color: const Color(0x19323232),
                          width: 50.w,
                          height: 44.h,
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(vertical: 4.h),
                          // child: ImageView(
                          //   'assets/images/vr/leftbar.svg',
                          //   width: 24.w,
                          //   height: 24.w,
                          //   boxFit: BoxFit.fitHeight,
                          // ),
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 20.w,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Text(
                        match.tn,
                        style: TextStyle(fontSize: 18.sp, color: Colors.white),
                      ),
                      SizedBox(
                        width: 50.w,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });

    /* return SliverAppBar(
      // key: controller.appBarKey,
      title: (controller.state.overlapsContent.value == true)

          ///列表悬停页面
          ? Container(
              color: Colors.yellow,
            )
          : null,
      titleSpacing: 0,
      leadingWidth: 50.w,

      leading: Container(
        color: Colors.transparent,
        child: Row(
          children: [
            InkWell(
              onTap: () async {
                Get.back();
              },
              child: Container(
                // color: const Color(0x19323232),
                width: 50.w,
                height: 44.h,
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(vertical: 4.h),
                child: ImageView(
                  'assets/images/vr/leftbar.png',
                  width: 36.w,
                  height: 36.h,
                ),
              ),
            ),
          ],
        ),
      ),
      pinned: true,
      stretch: false,
      expandedHeight: 265,
      // backgroundColor: Colors.red,
      onStretchTrigger: () async {},
      // ignore: prefer_const_constructors
      flexibleSpace: FlexibleSpaceBar(
        background:  DecoratedBox(
          position: DecorationPosition.foreground,
          decoration: BoxDecoration(
            // color: Colors.black,

          ),
          child: Stack(
            children: [
              ///体育头部
              Align(
                child: Text(
                  '头部',
                  style: TextStyle(color: Colors.white, fontSize: 150),
                ),
              ),
              GetBuilder<VrHomeController>(
                builder: (VrHomeController controller) {
                  final vrMatch = VrSportDetailLogic.to.state.vrMatch!;

                  final nextVrMatch = null;
                  return GoingSportWidget(
                    key: ValueKey(
                        'going_match_${vrMatch?.batchNo}'),
                    type: controller.topMenu?.type ?? 1,
                    vrMatch: vrMatch,
                    nextVrMatch: nextVrMatch,
                    getVirtualReplay:
                    controller.getVirtualReplay,
                    onNextMatchCountdownEnd:
                    controller.onNextMatchCountdownEnd,
                    onVideoPlayFinished:
                    controller.onVideoPlayFinished,
                    isShowItem: false,
                  );
            }),
            ],
          ),
        ),
        stretchModes: const <StretchMode>[
          StretchMode.zoomBackground,
          StretchMode.fadeTitle,
          StretchMode.blurBackground,
        ],
      ),
    );*/
  }
}
