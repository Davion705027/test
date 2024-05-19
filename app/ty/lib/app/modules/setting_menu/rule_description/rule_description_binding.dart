import 'package:get/get.dart';

import 'rule_description_controller.dart';

class RuleDescriptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RuleDescriptionController());
  }
}
