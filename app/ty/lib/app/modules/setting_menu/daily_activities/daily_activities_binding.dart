import 'package:get/get.dart';

import 'daily_activities_controller.dart';

class DailyActivitiesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DailyActivitiesController());
  }
}
