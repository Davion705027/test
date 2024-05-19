import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/league_filter/widgets/no_data_widget.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/view/rankGroupDisuseView/vr_sport_disuse_list.dart';
import 'package:flutter_ty_app/app/services/models/res/group_soure_model_entity.dart';

///小组赛列表
class groupListWidget extends GetView<VrSportDetailLogic> {

  @override
  Widget build(BuildContext context) {

    Color bgColor = context.isDarkMode
        ? Colors.white.withOpacity(0.04):Colors.white;
    Color textColor = context.isDarkMode
        ? Colors.white:Colors.black;
    // TODO: implement build
    return Obx(() => controller.state.groudIndex.value == 0
        ? controller.state.groupList.isNotEmpty
            ///小组赛列表
            ? SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    GroupSoureModelDataGroupData model =
                        controller.state.groupList[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 10.w),
                      color: Colors.transparent,
                      child: listWidget(index, model,bgColor,textColor),
                    );
                  },
                  childCount: controller.state.groupList.length,
                ),
              )
            : SliverFillRemaining(
                child: Container(
                  padding: EdgeInsets.only(left: 10.w, right: 10.w),
                  child: const NoDataWidget(
                  ),
                ),
              )
        :
        ///淘汰赛列表
        disuseListWidget());
  }

  ///小组赛列表
  listWidget(int index, GroupSoureModelDataGroupData model, Color bgColor, Color textColor) {

    return Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w),
      decoration: BoxDecoration(
          // color: Colors.white.withOpacity(0.16),
        color: bgColor,
          borderRadius: BorderRadius.circular(4.w)),
      child: Column(
        children: [

          Container(
            padding: EdgeInsets.only(top: 8.w, bottom: 8.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 3.w,
                        height: 15.h,
                        decoration: BoxDecoration(
                          color: const Color(0xff127DCC),
                          // gradient: const LinearGradient(
                          //   begin: Alignment.topCenter,
                          //   end: Alignment.bottomCenter,
                          //   colors: [
                          //     Color.fromRGBO(104, 156, 249, 1),
                          //     Color.fromRGBO(61, 88, 240, 1),
                          //     Color.fromRGBO(71, 100, 245, 1),
                          //   ],
                          // ),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(2.r),
                              topLeft: Radius.circular(0.r),
                              bottomRight: Radius.circular(2.r),
                              bottomLeft: Radius.circular(0.r)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 8.w),
                        child: Text(
                          // LocaleKeys.virtualSports_groupMatches_zu.tr
                          //     .replaceAll("{no}", model.groupId),
                          '${model.groupId} 组',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color:textColor.withOpacity(0.9),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white.withOpacity(0.08),
            height: 1.w,
          ),
          grouplistHeadWidget(bgColor, textColor),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemBuilder: (ctx, index) {
              GroupSoureModelDataGroupDataSVirtualSportXZTeamRankingDetailPOList
                  itemModel =
                  model.sVirtualSportXZTeamRankingDetailPOList[index];
              String teamName = itemModel.virtualTeamName;
              String type = itemModel.totalCount.toString();
              String reslut = itemModel.winDrawLostDescription;
              String jin = itemModel.goalsScored.toString();
              String shi = itemModel.goalsConceded.toString();
              String jingshengqiu = itemModel.goalsWinning.toString();
              String jifen = itemModel.points.toString();
              return SizedBox(
                height: 50,
                child: groupRowWidghte(
                    index: index + 1,
                    teamName: teamName,
                    type: type,
                    reslut: reslut,
                    jin: jin,
                    shi: shi,
                    jingshengqiu: jingshengqiu,
                    jifen: jifen,
                    bgColor: bgColor, textC: textColor
                ),
              );
            },
            itemCount: model.sVirtualSportXZTeamRankingDetailPOList.length,
            cacheExtent: double.maxFinite,
          )
        ],
      ),
    );
  }

  ///小组赛标题
  Widget grouplistHeadWidget(Color bgColor, Color textColor) {
    return SizedBox(
      height: 30,
      child: groupRowWidghte(
          index: 0,
          teamName: LocaleKeys.virtual_sports_team.tr,
          type: LocaleKeys.virtual_sports_game.tr,
          reslut: LocaleKeys.virtual_sports_win_tie_loss.tr,
          jin: LocaleKeys.virtual_sports_advance.tr,
          shi: LocaleKeys.virtual_sports_lose.tr,
          jingshengqiu: LocaleKeys.virtual_sports_goal_difference.tr,
          jifen: LocaleKeys.virtual_sports_integral.tr,
          bgColor: bgColor, textC: textColor),
    );
  }

  ///小组赛列表 包含 小组赛标题 是一个样式
  groupRowWidghte(
      {required int index,
      required String teamName,
      required String type,
      required String reslut,
      required String jin,
      required String shi,
      required String jingshengqiu,
      required String jifen, required Color bgColor, required Color textC}) {
    Color? textColor = index == 0
        ? textC?.withOpacity(0.4)
        : textC?.withOpacity(0.9);
    FontWeight? textFont = index == 0 ? FontWeight.w400 : FontWeight.w500;
    double fristW = 40.w;
    return Container(
      decoration: const BoxDecoration(
        // color: index == 0 ? Colors.white.withOpacity(0.08) : Colors.transparent,
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                index == 0
                    ? SizedBox(
                        width: fristW,
                      )
                    : SizedBox(
                        width: fristW,
                        child: Center(
                          child: Container(
                            alignment: Alignment.center,
                            width: 18.w,
                            height: 18.w,
                            decoration: BoxDecoration(
                                // color: Colors.white.withOpacity(0.16),
                                borderRadius: BorderRadius.circular(4)),
                            child: Text(
                              index.toString(),
                              style:  TextStyle(
                                  color: textC,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                Expanded(
                    flex: 5,
                    child: Text(
                      teamName,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: textColor, fontSize: 13.sp, fontWeight: textFont),
                    )),
                Expanded(
                    flex: 3,
                    child: Text(
                      type,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: textColor, fontSize: 13.sp, fontWeight: textFont),
                    )),
                Expanded(
                    flex: 4,
                    child: (index == 0 && reslut.length > 6)
                        ? FittedBox(
                            child: Text(
                              reslut,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: textColor,
                                  fontSize: 13.sp,
                                  fontWeight: textFont),
                            ),
                          )
                        : Text(
                            reslut,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: textColor,
                                fontSize: 13.sp,
                                fontWeight: textFont),
                          )),
                Expanded(
                    flex: 2,
                    child: Text(
                      jin,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: textColor, fontSize: 13.sp, fontWeight: textFont),
                    )),
                Expanded(
                    flex: 2,
                    child: Text(
                      shi,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: textColor, fontSize: 13.sp, fontWeight: textFont),
                    )),
                Expanded(
                    flex: 3,
                    child: Text(
                      jingshengqiu,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: textColor, fontSize: 13.sp, fontWeight: textFont),
                    )),
                Expanded(
                    flex: 2,
                    child: Text(
                      jifen,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: textColor, fontSize: 13.sp, fontWeight: textFont),
                    )),
              ],
            ),
          ),
          Visibility(
              visible: index > 0,
              child: Container(
                margin: EdgeInsets.only(left: 15.w, right: 15.w),
                height: 1,
                color: Colors.white.withOpacity(0.08),
              ))
        ],
      ),
    );
  }
}
