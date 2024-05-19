import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VrCompetitionDetailController extends GetxController
    with GetSingleTickerProviderStateMixin {
  String competitionName = '欧洲冠军杯';

  final List<Widget> tabs = [
    const Text('历史战绩'),
    const Text('投注'),
    const Text('排行榜'),
  ];

  late TabController tabController;

  onCompetitionChange() {}

  @override
  void onInit() {
    tabController = TabController(length: tabs.length, vsync: this);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
