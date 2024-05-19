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
          builder: (controller){

            var dataList=((controller.state.curMainTab.value==1?controller.state.analyzeArrayPersonEntity.value.up:controller.state.analyzeArrayPersonEntity2.value.up)??[]);
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 5.w),
              width: controller.bgImgWidth,
              height: controller.bgImgHeight,
              child:  Stack(
                children: [
                  Container(
                    width: controller.bgImgWidth,
                    height: controller.bgImgHeight,
                    child: ImageView(

                      controller.showBasketBall==true?"assets/images/bets/analyze_bet_head_bg2.png":"assets/images/bets/analyze_bet_head_bg1.png",

                      boxFit: BoxFit.fill,
                      width: controller.bgImgWidth,
                      height: controller.bgImgHeight,
                    ),
                  ),
                  Container(

                    width: controller.bgImgWidth,
                    height: controller.bgImgHeight,
                    child:  Stack(
                      children: dataList.map((e) =>  Positioned(
                          left: controller.requestPosition(e,e.position?.toInt()??0,dataList.indexOf(e)).left,
                          top:controller.requestPosition(e,e.position?.toInt()??0,dataList.indexOf(e)).top ,
                          child: AnalyzeBattlePositionItem(e) )).toList(),
                    ),
                  )
                ],
              ),
            );
          });

  }
}
