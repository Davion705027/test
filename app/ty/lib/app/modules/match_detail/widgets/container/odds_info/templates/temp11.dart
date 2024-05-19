import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_map_operate.dart';

import '../../../../../../global/data_store_controller.dart';
import '../../../../../../services/models/res/match_entity.dart';
import '../../../../models/bet_item_collection.dart';
import '../odds_item.dart';
import '../vr_odds_button.dart';

/// vr虚拟体育 Temp11 取hl[0] ol 不需要变赔
class Temp11 extends StatelessWidget {
  const Temp11({super.key, required this.matchHps});

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
        crossAxisCount: 3,
        mainAxisSpacing: 8.h,
        crossAxisSpacing: 8.w,
        childAspectRatio: 80.w / 44.5.h,
      ),
      itemBuilder: (BuildContext context, int index) {
        BetItemCollection c = collection[index];
        if (match == null) {
          return Container();
        }
        return VrOddsButton(
          match: match,
          hps: matchHps,
          ol: c.ol,
          hl: c.hl,
          isDetail: true,
        );
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

  /// 补充空白占位 不足total个 补到total个
  List fillBlankPlaceholder(List list, int total) {
    List newList = [...list];

    if (list.length < total) {
      int length = list.length;
      newList.addAll(List.filled(total - length, null).toList());
    }
    return newList;
  }
}
