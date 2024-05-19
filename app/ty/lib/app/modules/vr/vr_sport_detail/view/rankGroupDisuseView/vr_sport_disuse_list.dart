
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/models/res/item_disuse_entity.dart';
import 'package:flutter_ty_app/app/widgets/image_view.dart';

import '../../../../../utils/oss_util.dart';

///淘汰赛列表
class disuseListWidget extends GetView<VrSportDetailLogic> {
  late Color textColor;
  late BuildContext mContext;
  @override
  Widget build(BuildContext context) {
    Color bg = context.isDarkMode? Colors.black87:Colors.white;
     textColor = context.isDarkMode? Colors.white.withOpacity(0.9):Colors.black;
     mContext = context;
    return Obx(() {
      if (controller.state.disuseIndex.value < 3) {

        /// 16强 1/4赛 半决赛 是一种样式
        int num = controller.state.disuseList.length ~/ 2;
        Get.log('controller.disuseList = $num');
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.only(
                    top: 5.w, bottom: 10.w, left: 10.w, right: 10.w),
                // color: bg,
                child: disuseWidget(index),
              );
            },
            childCount: num,
          ),
        );
      } else {
        /// 决赛的样式  只有 队伍名称
        ItemDisuseEntity model = controller.state.disuseList.first;
        return SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.only(left: 10.w, top: 12.w, right: 10.w),
            decoration: BoxDecoration(
              color: context.isDarkMode?
              const Color(0xffFFFFFF).withOpacity(0.3):
              const Color(0xffF2F2F6),
              borderRadius: BorderRadius.circular(8),
            ),
            height: 64.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.only(left: 5.w, right: 8.w),
                      child: Text(
                        model.homeName,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.normal),
                      ),
                    )),
                Container(
                  alignment: Alignment.center,
                  width: 63.w,
                  height: 54.w,
                  decoration: BoxDecoration(
                    color: const Color(0xffFFFFFF).withOpacity(0.10),
                    borderRadius: BorderRadius.circular(4),
                    image:  DecorationImage(
                      image: NetworkImage(
                        OssUtil.getServerPath(
                          'assets/images/icon/vs_bg.png',
                        ),
                      ),
                      fit: BoxFit.cover,
                    ),

                  ),
                  child:  Text(
                    'VS',
                    style: TextStyle(
                        color: context.isDarkMode?
                        Color(0xffE1C564):
                        Colors.grey,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.only(left: 8.w, right: 5.w),
                      child: Text(
                        model.awayName,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                            fontSize: 14.sp,
                            fontWeight:FontWeight.normal),
                      ),
                    )),
              ],
            ),
          ),
        );
      }
    });
  }

  ///淘汰赛每一行widget
  disuseWidget(int index) {
    ItemDisuseEntity model1 = controller.state.disuseList[2 * index];
        // ItemDisuseEntity.fromJson();
    ItemDisuseEntity model2 = controller.state.disuseList[2 * index + 1];
        // ItemDisuseEntity.fromJson();
    String rightTitle = controller.getdisuseRowName(index);
    Get.log("index = $index rightTitle = $rightTitle  model1 = ${model1.awayName} ${model1.homeName} "
        " model2 = ${model2.awayName} ${model2.homeName} ");
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            flex: 2,
            child: Column(
              children: [
                disuseItem(model1, 2 * index),
                const SizedBox(
                  height: 20,
                ),
                disuseItem(model2, 2 * index + 1),
              ],
            )),
        // SizedBox(width: 44.w,
        // height: 92.w,),
        const ImageView(
          'assets/images/vr/vr_vs.svg',
          width: 44,
          height: 92,
        ),
        Expanded(
            flex: 1,
            child: Container(
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: mContext.isDarkMode?
                Colors.white.withOpacity(0.04):
                const Color(0xffFFFFFF).withOpacity(0.16),

                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                rightTitle,
                textAlign: TextAlign.center,
                style:  TextStyle(
                    color: textColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w700),
              ),
            ))
      ],
    );
  }

  ///淘汰赛单行左边
  disuseItem(ItemDisuseEntity model, int index) {
    String name = controller.replaceEnglishNumber(index.toString());
    List homeScore = controller.getMatchScore(model.homeScore);
    List awayScore = controller.getMatchScore(model.awayScore);

    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(right: 5.w),
      decoration: BoxDecoration(
        color: mContext.isDarkMode?Colors.white.withOpacity(0.04):const Color(0xffFFFFFF).withOpacity(0.16),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            width: 45.w,
            child: Text(
              name,
              style: TextStyle(
                  color: textColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: 37,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            model.homeName,
                            maxLines: 2,
                            style: TextStyle(
                                color: textColor, fontSize: 14.sp),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: scoreWidget(homeScore.first, homeScore[1], homeScore.last),)
                    ],
                  ),
                  Container(
                    // margin: EdgeInsets.only(left: 9.w, right: 9.w),
                    height: 1,
                    color: mContext.isDarkMode
                        ?Colors.white.withOpacity(0.1):const Color(0xfff2f2f6),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: 37,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            model.awayName,
                            style: TextStyle(
                                color:textColor, fontSize: 14.sp),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child:scoreWidget(awayScore.first, awayScore[1], awayScore.last),)
                    ],
                  ),
                ],
              )),
          // Expanded(
          //     flex: 1,
          //     child: Column(
          //       children: [
          //         scoreWidget(homeScore.first, homeScore[1], homeScore.last),
          //         scoreWidget(awayScore.first, awayScore[1], awayScore.last),
          //       ],
          //     )),
        ],
      ),
    );
  }

  ///比分样式
  scoreWidget(String score, String s, String t) {
    return Container(
      height: 37,
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          scoreTextWidget(score),
          scoreTextWidget(s),
          scoreTextWidget(t),
        ],
      ),
    );
  }

  scoreTextWidget(String score) {
    return Expanded(
        flex: 1,
        child: Text(
          score,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: textColor,
              fontSize: 13.sp,
              fontWeight: FontWeight.w700),
        ));
  }
}
