import 'package:get/get.dart';

import 'simulation_training_controller.dart';

class SimulationTrainingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SimulationTrainingController());
  }
}
