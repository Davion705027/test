import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/modules/dj/controllers/dj_controller.dart';
import 'package:flutter_ty_app/app/modules/dj/widgets/item/guanjun/item_guanjun_widget.dart';
import 'package:flutter_ty_app/app/modules/dj/widgets/item/new/match_list_new_item_widget.dart';
import 'package:flutter_ty_app/app/modules/dj/widgets/item/new/new_item_body_widget.dart';
import 'package:flutter_ty_app/app/modules/dj/widgets/item/profession/item_main_widget.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/home/models/section_group_enum.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/services/models/res/dj_list_entity.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../../services/models/res/match_entity.dart';
import '../../models/o_dj_section_group_enum.dart';

///电竞联赛
class OMatchListItemWidget extends StatelessWidget {
  const OMatchListItemWidget(
      {super.key, required this.matchEntity, required this.sectionGroupEnum,this.showGroupHead = true,this.count = 0,this.isLast = false});

  final MatchEntity matchEntity;
  final SectionGroupEnum sectionGroupEnum;
  final bool showGroupHead;
  final bool isLast;
  final int count;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      // init: HomeController(),
      builder: (controller) {
        return Column(
          children: [
            item(controller),
            DJController.to.DJState.selectDate?.menuType != 100 && isLast?Container(height: 8.w,
              color: context.isDarkMode?null:const Color(0xfff2f2f6),):SizedBox.shrink(),
          ],
        );


      },
    );
  }

  item(HomeController controller) {
    if(DJController.to.DJState.selectDate?.menuType == 100){//冠军
      return ItemGuanjunWidget(
          sectionGroupEnum: sectionGroupEnum,
          matchEntity: matchEntity,
          count:count
      );
    }else{
      if (controller.homeState.isProfess) {
        return ItemMainWidget(
            sectionGroupEnum: sectionGroupEnum,
            matchEntity: matchEntity,
            showGroupHead:showGroupHead,
            count:count
        );
      } else {
        return NewItemBodyWidget(
            matchEntity: matchEntity,
            showGroupHead:showGroupHead,
            sectionGroupEnum: sectionGroupEnum,
            count:count
        );
      }
    }
  }
}
