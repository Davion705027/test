import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_map_operate.dart';

import '../../../../../../global/data_store_controller.dart';
import '../../../../../../services/models/res/match_entity.dart';
import '../../../../models/bet_item_collection.dart';
import '../odds_button.dart';
import '../odds_item.dart';

/// 15号模板,单一盘口，投注项总数ol超过4个时，换行展示
/// 换行则每行展示3个，不够一行的用空白灰框填充。
/// 否则一行最多4个，最少1个。如准确进球数、准确局数玩法
class Temp15 extends StatelessWidget {
  const Temp15({super.key, required this.matchHps, required this.fullscreen});

  final MatchHps matchHps;
  final bool fullscreen;

  @override
  Widget build(BuildContext context) {
    MatchEntity? match = DataStoreController.to.getMatchById(matchHps.mid);

    List collection = fillBlankPlaceholder(matchHps.collection);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: collection.length > 4 ? 3 : collection.length,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: collection.length > 4
            ? childAspectRatio(3, fullscreen)
            : childAspectRatio(collection.length, fullscreen),
      ),
      itemBuilder: (BuildContext context, int index) {
        if (collection[index] == null) {
          return blankPlaceholder(
            fullscreen,
            height: fullscreen ? 44.5 : 44.5.h,
          );
        }
        BetItemCollection c = collection[index];
        return OddsButton(
          match: match,
          hps: matchHps,
          ol: c.ol,
          hl: c.hl,
          name:
              ObjectUtil.isNotEmpty(c.ol.on) && ObjectUtil.isNotEmpty(c.ol.ott)
                  ? "${c.ol.ott} ${c.ol.on}"
                  : c.ol.ott + c.ol.on,
          isDetail: true,
          fullscreen: fullscreen,
        );
      },
      itemCount: collection.length,
    );
  }

  // 附加盘投注项集合
  List<BetItemCollection> getAppendSingleList(
      MatchHps data, MatchEntity? match) {
    List<BetItemCollection> result = [];
    List<MatchHpsHl> hl = data.hl;
    for (var i = 0; i < hl.length; i++) {
      List<MatchHpsHlOl> ol = hl[i].ol;
      for (var j = 0; j < ol.length; j++) {
        MatchHpsHlOl newOl =
            DataStoreController.to.getOlById(ol[j].oid) ?? ol[j];
        MatchHpsHl newHl = DataStoreController.to.getHlById(hl[i].hid) ?? hl[i];
        var item = BetItemCollection(
          ol: newOl,
          hl: newHl,
        );
        result.add(item);
      }
    }
    return result;
  }

  /// 补充空白占位
  List fillBlankPlaceholder(List list) {
    List newList = [...list];
    if (list.length > 4) {
      // 大于4个时换行

      newList.addAll(List.filled(3 - (newList.length % 3), null).toList());
    }
    return newList;
  }
}
