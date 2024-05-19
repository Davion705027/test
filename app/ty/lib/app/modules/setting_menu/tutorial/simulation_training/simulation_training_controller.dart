import 'package:get/get.dart';

import '../../../../../generated/locales.g.dart';
import '../../../login/login_head_import.dart';
import 'simulation_training_logic.dart';

class SimulationTrainingController extends GetxController {
  final SimulationTraininglogic logic = SimulationTraininglogic();

  bool question1 = true;
  bool question2 = false;
  int select = 0;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  onBack() {
    Get.back();
    Get.back();
  }

  onSelect(int selects) {
    if (select == 0) {
      select = selects;
    }
    update();
  }

  nextQuestion() {
    question1 = false;
    select = 0;
    question2 = true;
    update();
  }

  Widget textWithHighLight(String founderString,{TextStyle? style}){
    List<TextSpan> spans = [];
    TextStyle backStyle = TextStyle(
      color: style?.color,
      fontSize: style?.fontSize,
    );
    TextStyle blueStyle = TextStyle(
      color: Colors.blue,
      fontSize: style?.fontSize,
    );

    if (founderString.contains(LocaleKeys.app_h5_handicap_tutorial_small.tr.replaceAll('%s', '2/2.5'))) {
      spans.add(TextSpan(style: blueStyle));

    } else {

      spans.add(TextSpan(style: backStyle));

    }

    return RichText(
      text: TextSpan(children: spans),
    );
  }

}
