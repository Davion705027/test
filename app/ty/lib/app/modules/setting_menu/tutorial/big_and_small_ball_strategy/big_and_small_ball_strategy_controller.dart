import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

import '../../../../routes/app_pages.dart';
import '../../../login/login_head_import.dart';
import 'big_and_small_ball_strategy_logic.dart';

class BigAndSmallBallStrategyController extends GetxController   with GetSingleTickerProviderStateMixin {
  final BigAndSmallBallStrategylogic logic = BigAndSmallBallStrategylogic();
  final AutoScrollController autoScrollController = AutoScrollController();
  late ListObserverController listObserverController = ListObserverController(controller: autoScrollController);

  late TabController tabController;
  int currentIndex = 0;

  List<String> tabList = [
    '2.5',
    '2.5/3',
    '3',
    '3/3.5',
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
    tabController.animateTo(index);
    update();

  }

  onSimulationTraining() {
    Get.toNamed(Routes.simulationTraining);
  }
}
