import 'dart:ui';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/view/rankGroupDisuseView/vr_sport_rank_list.dart';
import 'package:flutter_ty_app/app/widgets/image_view.dart';

import '../../../../utils/oss_util.dart';


class rankDisusePage extends GetView<VrSportDetailLogic> {
  const rankDisusePage({super.key});

  @override
  Widget build(BuildContext context) {

    return
      Obx(() {
        return controller.state.isCup.value
            ?  Container(
          decoration: context.isDarkMode
              ?  BoxDecoration(
            // borderRadius: BorderRadius.all(Radius.circular(8)),
            image: DecorationImage(
              image: NetworkImage(
                OssUtil.getServerPath(
                  'assets/images/home/color_background_skin.png',
                ),
              ),
              fit: BoxFit.cover,
            ),
          )
              : const BoxDecoration(
            color: Colors.white,
          ),
          margin: EdgeInsets.only(
              top: 8.w,
              bottom: 8.w,
              left: 5.w,
              right:5.w),
          // color: _bgColor,
          child: CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: [
              MultiSliver(
                pushPinnedChildren: false,
                children: [
                  ///排行榜头部【小组赛，淘汰赛】
                  Visibility(
                      visible: controller.state.isCup.value,
                      child:  headWidget(context)

                    // child: SliverPersistentHeader(
                    //    delegate: _sliverChildListDelegate(
                    //        headWidget(context), 50,
                    //        (bool overlapsContent, double shrinkOffset) {}),
                    //    pinned: true,
                    //  ),
                  ),

                  ///世界杯类型的页面 独立头部
                  Obx(() => Visibility(
                    visible: controller.state.isCup.value &&
                        controller.state.groudIndex.value == 1,
                    child: SliverPersistentHeader(
                      delegate: _sliverChildListDelegate(
                          Container(
                            decoration:   context.isDarkMode
                                  ?  BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    OssUtil.getServerPath(
                                      'assets/images/home/color_background_skin.png',
                                    ),
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              )
                                  : const BoxDecoration(
                                color: Colors.white,
                              ),
                              // color:context.isDarkMode
                              //     ? Colors.transparent
                              //     : Colors.white,
                              child: disuseHeadWidget(context)),
                          35,
                              (bool overlapsContent, double shrinkOffset) {}),
                      pinned: true,
                    ),
                  )),

                  ///底部是 小组赛淘汰样式
                  groupListWidget()

                ],
              )
            ],
          ),
        )
            :
        Container(
          decoration: context.isDarkMode
              ?  BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            image: DecorationImage(
              image: NetworkImage(
                OssUtil.getServerPath(
                  'assets/images/home/color_background_skin.png',
                ),
              ),
              fit: BoxFit.cover,
            ),
          )
              : const BoxDecoration(
            color: Colors.white,
          ),
          margin: EdgeInsets.only(
              top: 8.w,
              bottom: 8.w,
              left: 5.w,
              right:5.w),
          // color: _bgColor,
          child: CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: [
              MultiSliver(
                pushPinnedChildren: false,
                children: [


                  ///非世界杯类型的头部
                  listHeadWidget(context),

                 rankListWidget()

                ],
              )
            ],
          ),
        );
      });

  }

  Widget headWidget(BuildContext context) {
    return Obx(() => controller.state.isCup.value == true ? group(context) : rank());
  }

  ///排行榜的名称带关闭的头部  非世界杯类型头部
  Widget rank() {
    return Container(
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: const Color(0xffFFFFFF).withOpacity(0.16),
      ),
      margin: EdgeInsets.only(top: 10, left: 10.w, right: 10.w),
      child: Text(
        LocaleKeys.virtual_sports_match_detail_leaderboard.tr,
        style: const TextStyle(
            color: Color(0xFF3E65FF),
            fontSize: 12,
            fontWeight: FontWeight.w600),
      ),
    );
  }

  ///小组赛和淘汰赛切换tab的头部  世界杯类型头部
  Widget group(BuildContext context) {

    final  Color bgColor = context.isDarkMode
        ? Colors.white.withOpacity(0.05):Colors.grey.withOpacity(0.16);
    final  Color selectbgColor = context.isDarkMode
        ? Colors.white.withOpacity(0.08):Colors.white;
    final Color textColor = context.isDarkMode
        ? Colors.white.withOpacity(0.9):Colors.black;
    return Container(
      height: 24.w,
      margin: EdgeInsets.symmetric(horizontal: 14.w,vertical: 12.w),
      padding: EdgeInsets.only(top: 2.w,bottom: 2.w,left: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        // color: const Color(0xffFFFFFF).withOpacity(0.16),
        color: bgColor
      ),
      // margin: EdgeInsets.only(top: 10, left: 10.w, right: 10.w),
      child:     Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: controller.state.dataHeadTitle.asMap().keys.map((int index) {
          bool isSelect = index == controller.state.groudIndex.value;
          Get.log("index = $index controller.state.groudIndex.valu = ${controller.state.groudIndex.value}");
          bool canClick = false;
          // if (index == 1 && controller.state.isDisuse == 0) {
          //   canClick = false;
          // }


          return  Expanded(
              flex: 1,
              child:GestureDetector(
                onTap: () {
                  if (!canClick) return;
                  controller.clickGroupIndex(index);
                },
                behavior: HitTestBehavior.translucent,
                child:Container(
                  decoration: BoxDecoration(
                    color: isSelect?selectbgColor:Colors.transparent,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding: EdgeInsets.only(left: 15.w, right: 15.w ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // const SizedBox(
                      //   height: 3,
                      // ),
                      Text(
                        controller.state.dataHeadTitle[index],
                        style: TextStyle(
                            color:  isSelect
                                ?textColor
                                : textColor.withOpacity(0.5),
                            fontSize: 12,
                            fontWeight:
                            isSelect ? FontWeight.w600 : FontWeight.w400),
                      ),
                      // Visibility(
                      //   visible: isSelect,
                      //   maintainState: true,
                      //   child: Container(
                      //     height: 3,
                      //     width: 40,
                      //     color: const Color(0xff3E65FF),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              )
          );
        }).toList(),
      ),
    );
  }

  ///排行榜列表标题
  Widget listHeadWidget(BuildContext context) {
    return Container(
      // color: Colors.white,
      decoration: context.isDarkMode
          ?  BoxDecoration(
        color:Colors.transparent
        // image: DecorationImage(
        //   image: NetworkImage(
        //     OssUtil.getServerPath(
        //       'assets/images/home/color_background_skin.png',
        //     ),
        //   ),
        //   fit: BoxFit.cover,
        // ),
      )
          : const BoxDecoration(
        color: Color(0xfff2f2f6),
      ),
      child: rowWidghte(
        context:context,
          index: 0,
          teamName: LocaleKeys.virtual_sports_team.tr,
          type: LocaleKeys.virtual_sports_game.tr,
          reslut:  LocaleKeys.virtual_sports_win_tie_loss.tr,
          score:LocaleKeys.virtual_sports_integral.tr),
    );
  }

  ///淘汰赛 类型筛选的头部 小组赛没有单独的头部 只有列表
  Widget disuseHeadWidget(BuildContext context) {
    return Obx(() => Row(
          children: controller.state.disuseTitle.asMap().keys.map((int index) {
            bool select = index <= controller.state.disuseIndex.value;
            String titleStr = controller.state.disuseTitle[index];
            return GestureDetector(
              onTap: () {
                controller.clickDisuse(index);
              },
              // behavior: HitTestBehavior.translucent,
              child: Container(
                color: context.isDarkMode
                    ? Colors.transparent
                    :Colors.white,
                padding: EdgeInsets.only(left: 10.w),
                width: MediaQuery.of(context).size.width /
                    controller.state.disuseTitle.length,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   Expanded(
                       child:
                       Container(
                         color:context.isDarkMode
                             ? Colors.transparent
                             : Colors.white,
                         alignment: Alignment.center,
                         child: titleStr.length > 5
                             ? Text(
                           titleStr,
                           maxLines: 1,
                           style: TextStyle(
                             color: select
                                 // ? const Color(0xFF179CFF)
                                 ? const Color(0xFF127DCC)
                                 : Colors.grey.withOpacity(0.9),
                           ),
                         )
                             : Text(
                           titleStr,
                           maxLines: 1,
                           style: TextStyle(
                             color: select
                                 ? const Color(0xFF127DCC)
                                 : Colors.grey.withOpacity(0.9),
                           ),
                         ),
                       )
                        ),
                    Container(
                      height: 2,
                      width: double.maxFinite,
                      color: select ? const Color(0xFF127DCC): Colors.transparent,
                    )
                  ],
                ),
              ),
            );
          }).toList(),
        ));
  }

  ///排名列表样式  包含标题 是一种样式
  rowWidghte(
      {
        required BuildContext context,
        required int index,
      required String teamName,
      required String type,
      required String reslut,
      required String score}) {
    Color? textColor = index == 0
        ?  context.isDarkMode?Colors.white.withOpacity(0.4):const Color(0xff949AB6)
    // Colors.white.withOpacity(0.5)
        : Colors.white.withOpacity(0.8);
    FontWeight? textFont = index == 0 ? FontWeight.w400 : FontWeight.w700;
    double fristW = 40.w;
    return Container(
      // margin: EdgeInsets.only(left: 10.w, right: 10.w),
      decoration: BoxDecoration(
        color:  context.isDarkMode
            ?Colors.transparent :Colors.white,
          borderRadius: index == 0
              ? const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                )
              : BorderRadius.circular(0)),
      child: Column(
        children: [
          SizedBox(height: 10.w,),
          Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                    flex: 2,
                    child: Row(
                      children: [

                        index == 0
                            ? SizedBox(
                          width: fristW,
                        )
                            : index < 4
                            ? SizedBox(
                          width: fristW,
                          child: ImageView(
                            'assets/images/detailnew/rank$index.png',
                            height: 18.w,
                            width: 18.w,
                          ),
                        )
                            : SizedBox(
                          width: fristW,
                          child: Center(
                            child: Container(
                              alignment: Alignment.center,
                              width: 18.w,
                              height: 18.w,
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.16),
                                  borderRadius: BorderRadius.circular(4)),
                              child: Text(
                                index.toString(),
                                style:  TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          teamName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: textColor, fontSize:  10.sp, fontWeight: textFont),
                        ),
                      ],
                    )),
                Expanded(
                    flex: 1,
                    child: Text(
                      type,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: textColor, fontSize:  10.sp, fontWeight: textFont),
                    )),
                Expanded(
                    flex: 1,
                    child: reslut.length > 5
                        ? FittedBox(
                            child: Text(
                              reslut,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: textColor,
                                  fontSize: 10.sp,
                                  fontWeight: textFont),
                            ),
                          )
                        : Text(
                            reslut,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: textColor,
                                fontSize:  10.sp,
                                fontWeight: textFont),
                          )),
                Expanded(
                    flex: 1,
                    child: Text(
                      score,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: textColor, fontSize:  10.sp, fontWeight: textFont),
                    )),
              ],
            ),

          SizedBox(height: 10.w,),

        ],
      ),
    );
  }
}

class _sliverChildListDelegate extends SliverPersistentHeaderDelegate {
  final Widget widget;
  final double tabHeadHeight;
  Function? callback;

  _sliverChildListDelegate(
    this.widget,
    this.tabHeadHeight,
    this.callback,
  );

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    callback!(overlapsContent, shrinkOffset);
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          color: Colors.black,
          child: widget,
        ),
      ),
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => tabHeadHeight;

  @override
  // TODO: implement minExtent
  double get minExtent => tabHeadHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
