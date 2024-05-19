import 'package:flutter_ty_app/app/utils/utils.dart';
import 'package:get/get.dart';

import 'token_expired_state.dart';

class TokenExpiredLogic extends GetxController {
  final TokenExpiredState state = TokenExpiredState();
  static TokenExpiredLogic get to => Get.find();

  // 图片的key
  // String imgKey = 'images/common/friendly_reminder_zh.jpg';
  var expiredState = TokenExpiredState();


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

  @override
  void onInit() {
    // TODO: implement onInit

    onInitData();
    super.onInit();
  }

  void onInitData() {
    if(!isZh()){
      expiredState.imgKey = 'assets/images/common/friendly_reminder_en.jpg';
    }
    
  }
}
