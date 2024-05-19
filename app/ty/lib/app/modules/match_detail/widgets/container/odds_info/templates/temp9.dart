import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_map_operate.dart';

import '../../../../../../global/data_store_controller.dart';
import '../../../../../../services/models/res/match_entity.dart';
import '../../../../models/bet_item_collection.dart';
import '../../../../models/odds_button_enum.dart';
import '../vr_odds_button.dart';

/// 针对虚拟体育新增的玩法模板9 横向左右两列 不需要变赔
class Temp9 extends StatelessWidget {
  const Temp9({super.key, required this.matchHps});

  final MatchHps matchHps;

  @override
  Widget build(BuildContext context) {
    MatchEntity? match = DataStoreController.to.getMatchById(matchHps.mid);
    List<BetItemCollection> collection = getAppendSingleList(matchHps, match);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(8.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8.h,
        crossAxisSpacing: 8.w,
        childAspectRatio: 150 / 44.5,
      ),
      itemBuilder: (BuildContext context, int index) {
        BetItemCollection c = collection[index];
        if (match == null) {
          return Container();
        }
        return VrOddsButton(
            index: index,
            match: match,
            hps: matchHps,
            ol: c.ol,
            hl: c.hl,
            isDetail: true,
            direction: OddsTextDirection.horizontal);
      },
      itemCount: collection.length,
    );
  }

  // 附加盘投注项集合
  List<BetItemCollection> getAppendSingleList(
      MatchHps data, MatchEntity? match) {
    List<BetItemCollection> result = [];

    List<MatchHpsHlOl> ol = data.hl[0].ol; // 取第一个hl
    for (var j = 0; j < ol.length; j++) {
      result.add(BetItemCollection(
        ol: ol[j],
        hl: data.hl[0],
      ));
    }

    return result;
  }
}
