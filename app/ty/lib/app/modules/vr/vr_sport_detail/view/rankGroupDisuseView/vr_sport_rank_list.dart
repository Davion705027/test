import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/league_filter/widgets/no_data_widget.dart';
import 'package:flutter_ty_app/app/services/models/res/common_score_model_entity.dart';

///排名列表
class rankListWidget extends GetView<VrSportDetailLogic> {
  @override
  Widget build(BuildContext context) {
    return controller.state.rankList.isNotEmpty
        ? SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                CommonScoreModelData model = controller.state.rankList[index];
                return SizedBox(
                  height: 50.w,
                  child: rowWidghte(
                    context: context,
                    index: index,
                    teamName: model.virtualTeamName,
                    type: model.totalCount.toString(),
                    reslut: model.winDrawLostDescription,
                    score: model.points.toString(),
                  ),
                );
              },
              childCount: controller.state.rankList.length,
            ),
          )
        : SliverFillRemaining(
            child: Container(
              padding: EdgeInsets.only(left: 10.w, right: 10.w),
              child: const NoDataWidget(),
            ),
          );
  }

  ///排名列表样式 包含 排名标题 是一个样式
  rowWidghte(
      {required BuildContext context,
      required int index,
      required String teamName,
      required String type,
      required String reslut,
      required String score}) {
    Color?
        textColor = /*index == 0
        ? Colors.white.withOpacity(0.5)
        :*/
        context.isDarkMode
            ? Colors.white.withOpacity(0.9)
            : const Color(0xff303442);

    // Colors.white.withOpacity(0.8);
    FontWeight? textFont = /*index == 0 ? FontWeight.w400 :*/ FontWeight.w500;
    double fristW = 40.w;
    return Container(
      decoration:  BoxDecoration(
        color:  context.isDarkMode
            ?Colors.transparent :Colors.white,
          ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        /* index == 0
                            ? SizedBox(
                          width: fristW,
                        )
                            :*/
                        index < 3
                            ? SizedBox(
                                width: fristW,
                                child: ImageView(
                                  'assets/images/vr/bet_record_NO.${index + 1}.png',
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
                                    // decoration: BoxDecoration(
                                    //     color: Colors.white.withOpacity(0.16),
                                    //     borderRadius: BorderRadius.circular(4)),
                                    child: Text(
                                      (index + 1).toString(),
                                      style: TextStyle(
                                          color: textColor,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              ),
                        Text(
                          teamName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: textColor,
                            fontSize: 12.sp,
                            fontWeight: textFont,
                          ),
                        ),
                        // Expanded(
                        //   flex: 1,
                        //   child: Text(
                        //     teamName,
                        //     textAlign: TextAlign.center,
                        //     style: TextStyle(
                        //         color: textColor,
                        //         fontSize: 12.sp,
                        //         fontWeight: textFont),
                        //   ),
                        // ),
                      ],
                    )),
                Expanded(
                    flex: 1,
                    child: Text(
                      type,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: textColor,
                          fontSize: 12.sp,
                          fontWeight: textFont),
                    )),
                Expanded(
                    flex: 1,
                    child: Text(
                      reslut,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: textColor,
                          fontSize: 12.sp,
                          fontWeight: textFont),
                    )),
                Expanded(
                    flex: 1,
                    child: Text(
                      score,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: textColor,
                          fontSize: 12.sp,
                          fontWeight: textFont),
                    )),
              ],
            ),
          ),

          Container(
                margin: EdgeInsets.only(left: 9.w, right: 9.w),
                height: 1,
                color: context.isDarkMode
                    ?Colors.white.withOpacity(0.1):const Color(0xfff2f2f6),
              )
        ],
      ),
    );
  }
}
