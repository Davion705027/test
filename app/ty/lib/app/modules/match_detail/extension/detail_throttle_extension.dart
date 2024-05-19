import 'package:flutter_ty_app/app/modules/match_detail/extension/detail_bus_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/odds_info_extension.dart';
import 'package:rxdart/rxdart.dart';

import '../../login/login_head_import.dart';
import '../controllers/match_detail_controller.dart';

/// 节流处理
extension DetailThrottleExtension on MatchDetailController {
  initThrottle() {
    detailState.throttleOddsList = detailState.throttleOddsListSubject
        .throttleTime(const Duration(milliseconds: 3000),
            trailing: true, leading: true) // 设置节流时间为1秒
        .listen((_) {
      if (isClosed) {
        return;
      }
      // 接口请求节流
      // if (kDebugMode) {
      //   print('throttleOddsList节流间隔：1.5秒');
      // }
      fetchCategoryList();
    });
    detailState.throttleRCMD303 = detailState.throttleRCMD303Subject
        .throttleTime(const Duration(milliseconds: 3000),
            trailing: true, leading: true)
        .listen((_) {
      if (isClosed) {
        return;
      }
      // 接口请求节流
      // if (kDebugMode) {
      //   print('throttleRCMD303节流间隔：1.5秒');
      // }
      RCMD_C303();
    });

    // detailState.throttleEventSwitch = detailState.throttleEventSwitchSubject
    //     .throttleTime(const Duration(milliseconds: 1500))
    //     .listen((_) {
    //   if (isClosed) {
    //     return;
    //   }
    //   // 接口请求节流
    //   if (kDebugMode) {
    //     print('赛事切换节流间隔：2秒');
    //   }
    //
    // });
  }
}
