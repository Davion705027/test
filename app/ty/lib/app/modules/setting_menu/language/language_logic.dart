import 'package:flutter/cupertino.dart';
import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/main_tab/main_tab_controller.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/language/widgets/language_item.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/setting_menu_controller.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_controller.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/utils/bus/bus.dart';
import 'package:flutter_ty_app/app/utils/bus/event_enum.dart';
import 'package:get/get.dart';

import '../../../db/app_cache.dart';
import '../../../services/api/language_api.dart';
import 'language_state.dart';

class LanguageLogic extends GetxController {
  final LanguageState state = LanguageState();

  bool changelan = false;

  //语言标题
  List<String> itemName = [
    "中文简体",
    "繁體中文",
    "English",
    "Tiếng Việt",
   // "ไทย",
   // "Melayu",
    // "印尼语",
     "Português",
     "한국어",
    // "西班牙语",
    // "缅甸语",
    //"阿拉伯语",
    //"俄罗斯语"
  ];

  //"zh": "简体中文",
  //"tw": "繁體中文",
  //"en": "English",
  //"vi": "Tiếng Việt",
  //"th": "ไทย",
  //"ms": "Melayu",
  //"ad": "Indonesia",
  //"pt": "Português",
  //"ko": "한국어",
  //"es": "Español",
  //"mya": "မြန်မာ",
  //"ry": "Japanese",
  //"ru": "ру́сский язы́к",
  //图标
  List<String> itemIcon = [
    "assets/images/language/zh_cn.png",
    "assets/images/language/zh_tw.png",
    "assets/images/language/en_gb.png",
    "assets/images/language/vi_vn.png",
   // "assets/images/language/th_th.png",
    //"assets/images/language/ms_my.png",
    //  "assets/images/language/id_id.png",
      "assets/images/language/pt_pt.png",
      "assets/images/language/ko_kr.png",
    //  "assets/images/language/es_es.png",
    //  "assets/images/language/my_mm.png",
    //"阿拉伯语",
    //"俄罗斯语"
  ];

  //存储语言
  final List<String> itemLanguage = [
    "CN",
    "TW",
    "GB",
    "VN",
    //"TH",
   // "MY",
    // "ID",
     "PT",
     "KR",
    // "ES",
    // "MM",
    //"阿拉伯语",
    //"俄罗斯语"
  ];

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

  //设置语言条目
  List<Widget> loadListLanguages() {
    List<Widget> children = [];
    //获取当前语言
    String language = StringKV.language.get() ?? "";
    int current = 0;
    if (language.isNotEmpty) {
      for (int i = 0; i < itemLanguage.length; i++) {
        if (itemLanguage[i].contains(language)) {
          current = i;
          break;
        }
      }
    }
    //设置国际化条目
    for (int i = 0; i < itemName.length; i++) {
      children.add(LanguageItem(
        title: itemName[i],
        imageUrl: itemIcon[i],
        isSelected: i == current,
        onTap: () {
          //切换语言的事件处理
          setLanguage(itemLanguage[i]);
        },
      ));
    }
    return children;
  }

  changeLangEffect() async {
    // 必须等此接口成功后再切换页面
    await ConfigController.to.loadNameList(switchLanguages: true);
    Bus.getInstance().emit(EventType.changeLang);
    // 重新拉取name list


    // 菜单中 活动的显示
    SettingMenuController.to.setShowActivity();
    // tab 中活动的显示
    MainTabController.to.setShowActivity();
    //清除购物车数据
    ShopCartController.to.clearData();
  }

  setLanguage(String language) {
    changelan = true;
    StringKV.language.save(language);
    Locale locale = const Locale('zh', 'CN');
    String languageName = 'zh';
    switch (language) {
      case "CN":
        languageName = 'zh';
        locale = const Locale('zh', 'CN');
        break;
      case "TW":
        languageName = 'tw';
        locale = const Locale('zh', 'TW');
        break;
      case "GB":
        languageName = 'en';
        locale = const Locale('en', 'GB');
        break;
      case "VN":
        languageName = 'vi';
        locale = const Locale('vi', 'VN');
        break;
      case "KR":
        languageName = 'ko';
        locale = const Locale('ko', 'KR');
        break;
      case "PT":
        languageName = 'pt';
        locale = const Locale('pt', 'PT');
        break;
      case "TH":
        languageName = 'th';
        locale = const Locale('th', 'TH');
        break;
      case "MY":
        languageName = 'ms';
        locale = const Locale('ms', 'MY');
        break;
      case "ID":
      case "PT":
      case "KR":
      case "ES":
      case "MM":
        locale = const Locale('zh', 'CN');
        break;
    }

    setUserLanguage(languageName);
    Get.updateLocale(locale).then((value) async {
       // ToastUtils.showGrayBackground(LocaleKeys.setting_menu_chan_lan.tr);
      //切换语言相关处理
      await changeLangEffect();
      //关闭设置菜单界面
      SettingMenuController.to.steShutDown();
      changelan = false;
      // ToastUtils.dismissLoading();
      //关闭当前界面
      Get.back();
    });
  }

  setUserLanguage(String languageName) async {
    String token = StringKV.token.get() ?? "";
    final res =
        await LanguageApi.instance().setUserLanguage(token, languageName);
    String code = res.code;
    if (code == "0000000") {
      //   print("LanguageLogic----------"+res.msg);
      //切换语言成功。
    }
  }
}
