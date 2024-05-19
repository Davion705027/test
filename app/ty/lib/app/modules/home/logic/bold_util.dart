import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';

class BoldUtil {
  static Map<int, List<MatchHpsHlOl>> getFromBoldMatchHps(MatchHps hps) {
    Map<int, List<MatchHpsHlOl>> map = {};
    if (hps.hl.isEmpty) {
      return map;
    }
    MatchHpsHl hpsHl = hps.hl.first;

    /// otd 1 主胜 0 平 2 客胜
    hpsHl.ol.forEach((element) {
      if (element.otd == 1) {
        if (map[1] == null) {
          map[1] = [];
        }
        map[1]?.add(element);
      } else if (element.otd == 0) {
        if (map[0] == null) {
          map[0] = [];
        }
        map[0]?.add(element);
      } else if (element.otd == 2) {
        if (map[2] == null) {
          map[2] = [];
        }
        map[2]?.add(element);
      } else if (element.otd == -1) {
        if (map[-1] == null) {
          map[-1] = [];
        }
        element.on = LocaleKeys.list_other.tr;
        map[-1]?.add(element);

      }
    });
    return map;
  }
}
