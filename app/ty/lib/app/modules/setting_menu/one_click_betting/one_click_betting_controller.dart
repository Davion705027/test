import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/global/user_controller.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../services/api/menu_api.dart';
import '../../../services/models/res/get_user_customize_info_entity.dart';
import '../../login/login_head_import.dart';
import 'one_click_betting_logic.dart';

class OneClickBettingController extends GetxController {
  final OneClickBettinglogic logic = OneClickBettinglogic();

  bool betAmount = false;
  TextEditingController textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();
  late List<int> singleList = [];

  // 是否开启和关闭
  bool switchOn = false;

  // 当前值
  int fastBetAmount = 0;

  // 最小投注额
  int min = 0;

  // 最大投注额
  int max = 100000000;

  @override
  void onInit() {
    initData();
    initSingleList();
    initState();
  }

  // 初始化状态
  initState(){
    min = UserController.to.userInfo.value?.cvo?.single?.min ?? 0;
  }

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

  // 获取 一键投注和投注额
  Future<void> initSingleList() async {
    final ress = await MenuApi.instance().getUserCustomizeInfo(
      1,
    );
    if (ress.code == '0000000') {
      singleList = ress.data.singleList;
      update();
    } else {
      ToastUtils.show(ress.msg);
    }
  }

  Future<GetUserCustomizeInfoEntity> initData() async {
    final res = await MenuApi.instance().getUserCustomizeInfo(
      2,
    );
    if (res.code == '0000000') {
      switchOn = res.data.switchOn;
      fastBetAmount = int.parse(res.data.fastBetAmount.toString());
      update();

    } else {
      ToastUtils.show(res.msg);
    }

    return res;
  }

  onCloseVisibility() {
    betAmount = !betAmount;
    update();
  }

  onInsertText(String myText) {
    String inputText = textEditingController.text + myText;
    if(inputText.toInt() >= max){
      textEditingController.text = max.toString();
    }else{
      textEditingController.text = inputText;
    }
    focusNode.requestFocus();
    update();
  }

  onMaxInputText() {
    textEditingController.text = max.toString();
    focusNode.requestFocus();
    update();
  }

  replaceText(String myText) {
    textEditingController.text = myText;
    update();
  }

  onBackspace() {
    if (textEditingController.text.isEmpty) {
      return;
    }
    String lastChar = textEditingController.text
        .substring(0, textEditingController.text.length - 1);
    textEditingController.text = lastChar;
    focusNode.requestFocus();
    update();
  }

  onOK() async {
    if(int.parse(textEditingController.text) <= min){
      textEditingController.text = min.toString();
    }
    betAmount = false;
    final res = await MenuApi.instance()
        .saveUserCustomizeInfos(textEditingController.text, false, true, 2);

    if (res.code == '0000000') {
      ToastUtils.customizedBetAmountSuccessful(
          '${'${LocaleKeys.bet_one_click_bet_change.tr} '}${toAmountSplit(int.parse(textEditingController.text).toStringAsFixed(2))}');
      update();
      final res = await initData();
      UserController.to.getUserCustomizeInfoBetAmount(infoRes:res);

    } else {
      ToastUtils.show(res.msg);
    }
  }

  String toAmountSplit(String num) {
    String numStr = (num ?? 0).toString();

    if (numStr.contains('.')) {
      List<String> parts = numStr.split('.');
      String integerPart = parts[0];
      String decimalPart = parts[1];

      String formattedInteger = integerPart.replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+\b)'),
        (match) => '${match.group(1)},',
      );

      return '$formattedInteger.$decimalPart';
    } else {
      return numStr.replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+\b)'),
        (match) => '${match.group(1)},',
      );
    }
  }

  onOneClickBetting() async {   
    final res = await MenuApi.instance().saveUserCustomizeInfos(
        textEditingController.text.isEmpty
            ? fastBetAmount.toString()
            : textEditingController.text,
        false,
        !switchOn,
        2);

    if (res.code == '0000000') {
      if (switchOn == false) {
        ToastUtils.customizedBetAmountSuccessful(
            '${'${LocaleKeys.bet_one_click_bet_change.tr} '}${toAmountSplit(int.parse(textEditingController.text.isEmpty ? fastBetAmount.toString() : textEditingController.text).toStringAsFixed(2))}');
      }

      update();
      final res = await initData();
      UserController.to.getUserCustomizeInfoBetAmount(infoRes:res);
    } else {
      ToastUtils.show(res.msg);
    }
  }
}
