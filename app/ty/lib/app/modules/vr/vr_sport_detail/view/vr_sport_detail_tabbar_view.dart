import 'package:flutter/cupertino.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_detail_controller.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/odds_info_container.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/tab/bet_mode_tab_widget.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/view/vr_sport_history_data.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/view/vr_sport_history_dog.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/view/vr_sport_rank_disuse_page.dart';
import 'package:flutter_ty_app/app/utils/oss_util.dart';

class vrSportDetailTabBarView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        id: 'bottomPage',
        init: VrSportDetailLogic(),
        builder: (controller) {

          if(controller.state
              .matchDetailList.isEmpty){
            return  const Column(
              children: [BetModeTab(), Expanded(child: OddsInfoContainer(refresh: true,))],
            );
          }else{
            String title = controller.state
                .matchDetailList[controller.state.matchTabController?.index ?? 0];
            ///历史战绩
            if (title ==
                LocaleKeys.virtual_sports_match_detail_historical_results.tr) {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: controller.state.topMenu?.menuId =='1001'?
                  sportHistoryDataView():
                controller.state.topMenu?.menuId == '1004'?
                    const SizedBox():
              sportHistoryDogView(),
              );

              ///投注
            } else if (title == LocaleKeys.virtual_sports_match_detail_bet.tr) {
              return  Column(
                children: [BetModeTab(), Expanded(child: Container(
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
                      color: Colors.transparent,
                    ),

                    child: OddsInfoContainer(refresh: true,)))],
              );
            } else {
              ///排行榜
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child:  const rankDisusePage(),
              );
            }
          }

        });

    // return Obx(() {
    //   return controller.matchDetailList.isNotEmpty
    //       ? TabBarView(
    //           controller: controller.matchTabController,
    //           children: _tabTypeList(controller.matchDetailList),
    //         )
    //       : Container();
    // });
  }

// RxList matchDetailList = [
//   LocaleKeys.virtual_sports_match_detail_historical_results.tr,
//   LocaleKeys.virtual_sports_match_detail_bet.tr,
//   LocaleKeys.virtual_sports_match_detail_leaderboard.tr
// ].obs;
// List<Widget> _tabTypeList(List typeList) {
//   return typeList.map((index) {
//     ///历史战绩
//     if (index ==
//         LocaleKeys.virtual_sports_match_detail_historical_results.tr) {
//       return ListView.builder(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         padding: EdgeInsets.zero,
//         itemBuilder: (context, index) {
//           return  SizedBox(
//             height: 30,
//             child: Text('ceshi$index'),
//           );
//         },
//         itemCount: 100,
//       );
//
//       ///投注
//     } else if (index == LocaleKeys.virtual_sports_match_detail_bet.tr) {
//       return Container(
//         color: Colors.yellow,
//       );
//     } else {
//       ///排行榜
//       return Container(
//         color: Colors.blue,
//       );
//     }
//   }).toList();
// }
}
