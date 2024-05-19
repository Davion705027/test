import 'package:flutter_ty_app/app/extension/safe_update_extensions.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/services/api/notice_center_api.dart';
import 'package:flutter_ty_app/app/services/models/res/notice_center_entity.dart';

import 'notice_message_logic.dart';


class NoticeMessageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static NoticeMessageController get to => Get.put(NoticeMessageController());
  final NoticeMessagelogic logic = NoticeMessagelogic();

  TabController? tabController;

  int progress = 0;

  List<String> tabTitles = [];
  List<List<NoticeCenterNlMtl>> mtls = [];

  void onTabChanged(int index) {
    debugPrint('tabController.indexIsChanging: $index');
    safeUpdate();

    if (tabController?.indexIsChanging == true) return;
  }

  void _initData() async {
    try {
      final res = await NoticeCenterApi.instance().getNoticeData();
      final nls = res.data?.nl ?? [];

      for (var nl in nls) {
        tabTitles.add(nl.nen);
        debugPrint('nl.mtl: ${nl.mtl.length}');
        mtls.add(nl.mtl);
      }

      tabController = TabController(length: tabTitles.length, vsync: this);
      safeUpdate();
    } catch (e) {
      debugPrint('getNoticeData error: $e');
    }
  }

  @override
  void onReady() {
    _initData();
    super.onReady();
  }

  @override
  void onClose() {
    tabController?.dispose();
    super.onClose();
  }
}
