import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

import '../../../login/login_head_import.dart';
import 'handicap_strategy_logic.dart';

class HandicapStrategyController extends GetxController  with GetSingleTickerProviderStateMixin {
  final HandicapStrategylogic logic = HandicapStrategylogic();

  final AutoScrollController autoScrollController = AutoScrollController();
  late ListObserverController listObserverController = ListObserverController(controller: autoScrollController);

  late TabController tabController;
  int currentIndex = 0;

  List<String> tabList = [
    '0',
    '0/0.5',
    '0.5',
    '0.5/1',
    '1',
    '1/1.5',
    '1.5',
    '1.5/2',
  ];

  @override
  void onInit() {
    // TODO: implement onInit
    tabController = TabController(length: tabList.length, vsync: this);
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    tabController.dispose();
    autoScrollController.dispose();
    super.onClose();
  }


  changeIndex(int index) {
    currentIndex = index;
    listObserverController.animateTo(
      index: index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
    update();
  }

  onObserves(index) {
    currentIndex = index;
    update();
    tabController.animateTo(index);
  }
}
