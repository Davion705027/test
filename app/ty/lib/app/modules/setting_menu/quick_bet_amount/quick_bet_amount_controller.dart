import 'package:flutter_ty_app/app/global/user_controller.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/utils/lodash.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../services/api/menu_api.dart';
import 'quick_bet_amount_logic.dart';

class QuickBetAmountController extends GetxController {
  final QuickBetAmountlogic logic = QuickBetAmountlogic();

  late List<int> seriesList = [];
  late List<int> singleList = [];
  late ActionType currentActionType;
  TextEditingController textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();

  String selectedSingleLevelBetting = '';
  String selectedMatchBetting = '';

  bool betAmount = false;

  late int bettingColumn;

  bool downloadData = true;

  // 最小投注额
  int min = 0;

  @override
  void onInit() {
    // TODO: implement onInit
    initData();
    initState();

    textEditingController.text = '10';
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
    super.onClose();
  }

  // 初始化状态
  initState(){
    min = UserController.to.userInfo.value?.cvo?.single?.min ?? 0;
  }

  Future<void> initData() async {

    seriesList = UserController.to.seriesList;
    singleList = UserController.to.singleList;
    if(seriesList.isEmpty && singleList.isEmpty){
      await UserController.to.getUserCustomizeInfo();
      seriesList = UserController.to.seriesList;
      singleList = UserController.to.singleList;
    }
    // // print(seriesList);
    // // print(singleList);
    // // if(seriesList.isNotEmpty && singleList.isNotEmpty)return;
    // final res = await MenuApi.instance().getUserCustomizeInfo(
    //   1,
    // );
    // if (res.code == '0000000') {
    //   downloadData = true;
    //   seriesList = res.data.seriesList;
    //   singleList = res.data.singleList;
    //   update();
    // } else {
    //   ToastUtils.show(res.msg);
    // }
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

  onSelectSingleLevelBetting(int amount, int i) {
    bettingColumn = i;
    betAmount = true;
    selectedMatchBetting = '';
    selectedSingleLevelBetting = amount.toString();
    focusNode.requestFocus();
    textEditingController.text = amount.toString();

    currentActionType = ActionType.SINGLE;

    update();
  }

  onSelectMatchBetting(int amount, int i) {
    bettingColumn = i;
    betAmount = true;
    selectedSingleLevelBetting = '';
    selectedMatchBetting = amount.toString();
    focusNode.requestFocus();
    textEditingController.text = amount.toString();

    currentActionType = ActionType.SERIES;

    update();
  }

  onCloseVisibility() {
    betAmount = false;
    update();
  }

  onFocusNode() {
    focusNode.unfocus();
    update();
  }

  onInsertText(String myText) {
    if (textEditingController.text.isNotEmpty &&
        int.parse(textEditingController.text) >= 9999999) {
      update();
      return;
    }
    textEditingController.text = textEditingController.text + myText;
    focusNode.requestFocus();
    update();
  }

  onMaxInputText() {
    textEditingController.text = '9999999';
    focusNode.requestFocus();
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
    var v = textEditingController.text;
    int index = bettingColumn - 1;

    List<int> copySingList = lodash.deepCopyArr<int>(singleList);
    List<int> copySeriesList = lodash.deepCopyArr(seriesList);
    if (currentActionType == ActionType.SINGLE) {
      copySingList[index] = int.parse(v);
    } else {
      copySeriesList[index] = int.parse(v);
    }

    final res = await MenuApi.instance().saveUserCustomizeInfo(
      1,
      copySeriesList,
      copySingList,
    );
    if (res.code == '0000000') {
      betAmount = false;
      ToastUtils.customizedBetAmountSuccessful(
          '${'${LocaleKeys.app_h5_filter_quick_bet.tr}$bettingColumn '}${'${LocaleKeys.app_h5_filter_change_to.tr}: '}${toAmountSplit(int.parse(textEditingController.text).toStringAsFixed(2))}');
      // await initData();
      // 减少接口请求
      if (currentActionType == ActionType.SINGLE) {
        singleList = copySingList;
      } else {
        seriesList = copySeriesList;
      }
      update();

      UserController.to.seriesList = seriesList;
      UserController.to.singleList = singleList;
      // 更新UserController中得数据 不走接口
      UserController.to.setUserCustomizeInfo();
    } else {
      ToastUtils.show(res.msg);
      update();
    }
  }
}

enum ActionType {
  SINGLE('single'),
  SERIES('series');

  final String code;

  const ActionType(this.code);
}
