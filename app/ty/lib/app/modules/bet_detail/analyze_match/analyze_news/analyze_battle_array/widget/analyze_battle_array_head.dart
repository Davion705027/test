import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../../../services/models/res/analyze_array_person_entity.dart';
import '../../../../../../widgets/image_view.dart';
import '../analyze_battle_array_logic.dart';
import 'analyze_battle_position_item.dart';

class AnalyzeBattleArrayHead extends StatelessWidget {
  AnalyzeBattleArrayHead({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AnalyzeBattleArrayLogic>(
        id: "analyzeChildArrayComponent",
        builder: (controller) {
          print("触发刷新=====>");
          List<Up> first = [];
          List<Up> second = [];
          List<Up> three = [];
          if (controller.showBasketBall == true) {
            if ((controller.basketball_data?.length ?? 0) == 1) {
              first.add(controller.basketball_data?.first ?? Up());
            } else if ((controller.basketball_data?.length ?? 0) == 2) {
              first.add(controller.basketball_data?.first ?? Up());
              second.add(controller.basketball_data?[1] ?? Up());
            } else if ((controller.basketball_data?.length ?? 0) == 3) {
              first.add(controller.basketball_data?.first ?? Up());
              second.add(controller.basketball_data?[1] ?? Up());
              second.add(controller.basketball_data?[2] ?? Up());
            } else if ((controller.basketball_data?.length ?? 0) == 4) {
              first.add(controller.basketball_data?.first ?? Up());
              second.add(controller.basketball_data?[1] ?? Up());
              second.add(controller.basketball_data?[2] ?? Up());
              three.add(controller.basketball_data?.last ?? Up());
            } else if ((controller.basketball_data?.length ?? 0) == 5) {
              first.add(controller.basketball_data?.first ?? Up());
              second.add(controller.basketball_data?[1] ?? Up());
              second.add(controller.basketball_data?[2] ?? Up());
              three.add(controller.basketball_data?[3] ?? Up());
              three.add(controller.basketball_data?[4] ?? Up());
            }
          }

          if ((((controller.state.curMainTab.value == 0
                          ? controller.line_up_data_home
                          : controller.line_up_data_away) ==
                      null) &&
                  (!controller.showBasketBall)) ||
              (controller.showBasketBall &&
                  controller.basketball_data?.isEmpty == true)) {
            return Container(
              width: controller.bgImgWidth,
              height: controller.bgImgHeight,
              child: ImageView(
                controller.showBasketBall == true
                    ? "assets/images/bets/analyze_bet_head_bg2.png"
                    : "assets/images/bets/analyze_bet_head_bg1.png",
                boxFit: BoxFit.fill,
                width: controller.bgImgWidth,
                height: controller.bgImgHeight,
              ),
            );
          } else {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 5.w),
              width: controller.bgImgWidth,
              height: controller.bgImgHeight,
              child: Stack(
                children: [
                  Container(
                    width: controller.bgImgWidth,
                    height: controller.bgImgHeight,
                    child: ImageView(
                      controller.showBasketBall == true
                          ? "assets/images/bets/analyze_bet_head_bg2.png"
                          : "assets/images/bets/analyze_bet_head_bg1.png",
                      boxFit: BoxFit.fill,
                      width: controller.bgImgWidth,
                      height: controller.bgImgHeight,
                    ),
                  ),
                  controller.showBasketBall
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: first
                                  .map((e) => AnalyzeBattlePositionItem(e))
                                  .toList(),
                            ),
                            Row(
                              mainAxisAlignment:second.length<=1? MainAxisAlignment.start:MainAxisAlignment.spaceBetween,
                              children: second
                                  .map((e) => AnalyzeBattlePositionItem(e))
                                  .toList(),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 100.w),
                              child: Row(

                                mainAxisAlignment:second.length<=1? MainAxisAlignment.start:MainAxisAlignment.spaceBetween,
                                children: three
                                    .map((e) => AnalyzeBattlePositionItem(e))
                                    .toList(),
                              ),
                            ),
                          ],
                        )
                      : Container(
                          width: controller.bgImgWidth,
                          height: controller.bgImgHeight,
                          child: Column(children: [
                            if ((controller.state.curMainTab.value == 0
                                        ? controller.line_up_data_home
                                        : controller.line_up_data_away)
                                    ?.up
                                    ?.isNotEmpty ==
                                true)
                              Visibility(
                                visible: controller.showItem(
                                    true,
                                    (controller.state.curMainTab.value == 0
                                            ? (controller.line_up_data_home?.up
                                                        ?.isNotEmpty ==
                                                    true
                                                ? controller.line_up_data_home
                                                    ?.up?.first
                                                : Up())
                                            : (controller.line_up_data_home?.up
                                                        ?.isNotEmpty ==
                                                    true
                                                ? controller.line_up_data_away
                                                    ?.up?.first
                                                : Up())) ??
                                        Up()),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AnalyzeBattlePositionItem((controller.state
                                                        .curMainTab.value ==
                                                    0
                                                ? controller.line_up_data_home
                                                : controller.line_up_data_away)
                                            ?.up
                                            ?.first ??
                                        Up()),
                                  ],
                                ),
                              ),
                            Expanded(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: (controller.state.curMainTab.value == 0
                                      ? controller.football_filtered_data_home
                                      : controller.football_filtered_data_away)
                                  .map((e) {
                                if (e.length > 4) {
                                  bool atUp = ((controller
                                                      .state.curMainTab.value ==
                                                  0
                                              ? controller
                                                  .football_filtered_data_home
                                              : controller
                                                  .football_filtered_data_away)
                                          .indexOf(e) <=
                                      1);
                                  List<Up> firstRow = [e.first, e.last];
                                  List<Up> sencodRow =
                                      e.sublist(1, e.length - 1);

                                  print("atUp  ${atUp}");

                                  for (Up up in sencodRow) {
                                    print(" sencodRow  ${up.shirtNumber}");
                                  }

                                  return Container(
                                    width: controller.bgImgWidth,
                                    height: 100.w,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                            top: atUp ? 0 : 40.w,
                                            left: 0,
                                            right: 0,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: firstRow
                                                  .map((e) =>
                                                      AnalyzeBattlePositionItem(
                                                          e))
                                                  .toList(),
                                            )),
                                        Positioned(
                                            top: atUp ? 30.w : 0.w,
                                            left: 40.w,
                                            right: 40.w,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: sencodRow
                                                  .map((e) =>
                                                      AnalyzeBattlePositionItem(
                                                          e))
                                                  .toList(),
                                            )),
                                      ],
                                    ),
                                  );
                                }

                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: e
                                      .map((e) => AnalyzeBattlePositionItem(e))
                                      .toList(),
                                );
                              }).toList(),
                            )),
                            if ((controller.state.curMainTab.value == 0
                                        ? controller.line_up_data_home
                                        : controller.line_up_data_away)
                                    ?.up
                                    ?.isNotEmpty ==
                                true)
                              Visibility(
                                visible: controller.showItem(
                                    false,
                                    (controller.state.curMainTab.value == 0
                                                ? controller.line_up_data_home
                                                : controller.line_up_data_away)
                                            ?.up
                                            ?.last ??
                                        Up()),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AnalyzeBattlePositionItem((controller.state
                                                        .curMainTab.value ==
                                                    0
                                                ? controller.line_up_data_home
                                                : controller.line_up_data_away)
                                            ?.up
                                            ?.last ??
                                        Up()),
                                  ],
                                ),
                              ),
                          ]),
                        )
                ],
              ),
            );
          }
        });
  }
}
