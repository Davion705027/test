import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_map_operate.dart';
import 'package:get/get.dart';

import '../../../../../global/data_store_controller.dart';
import '../../../../../services/models/res/match_entity.dart';
import '../../../constant/detail_constant.dart';
import '../../../controllers/match_detail_controller.dart';
import '../header_bottom.dart';
import '../header_middle.dart';

class CommonFlexibleSpace extends StatelessWidget {
  const CommonFlexibleSpace({super.key, this.tag});

  final String? tag;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MatchDetailController>(
      tag: tag,
      builder: (controller) {
        MatchEntity? match = controller.detailState.match;
        if (match == null) return Container();
        // 数据仓库controller
        return GetBuilder<DataStoreController>(
          id: DataStoreController.to.getMatchId(match.mid),
          builder: (dataController) {
            MatchEntity matchEntity =
                dataController.getMatchById(match.mid) ?? match;
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                /// 内容显示在appbar下
                SizedBox(
                  height: appbarHeight + Get.mediaQuery.padding.top,
                ),

                /// 详情页视频区域中部(主副队logo+主副队名+赛事[阶段+时间+比分])
                HeaderMiddle(
                  match: matchEntity,
                  controller: controller,
                ),

                ///详情页视频区域(视频+动画按钮)+底部(赛事比分或者是足球犯规显示)
                HeaderBottom(
                  match: matchEntity,
                  controller: controller,
                ),
              ],
            );
          },
        );
      },
    );
  }
}
