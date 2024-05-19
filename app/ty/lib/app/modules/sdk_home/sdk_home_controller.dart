import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/main.dart';

import '../../global/config_controller.dart';
import '../../global/user_controller.dart';
import '../../services/api/common_api.dart';
import '../../services/network/domain.dart';
import '../dj/controllers/dj_controller.dart';
import '../home/logic/home_controller_logic.dart';
import '../login/login_head_import.dart';
import 'sdk_home_logic.dart';

class SdkHomeController extends GetxController {
  final SdkHomelogic logic = SdkHomelogic();

  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady

    super.onReady();
    initData();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future<void> initData() async {
    dbClear();
    ///安卓IOS SDK接入方式
    //接收安卓IOS 带参跳转
    //  h5url = window.defaultRouteName;
    StringKV.env.save(h5Env);
    ///Flutter 接入方式
    if (h5ulr.isNotEmpty && h5ulr.contains('token')) {
      ///取h5地址
      Uri uri = Uri.parse(h5ulr);
      Map<String, dynamic> params = uri.queryParameters;

      // 处理用户信息
      setUserInfo(params);
      // oss逻辑处理
      domainInstance.create(h5ulr, callback: (DamainModel res) async {
        // 设置api
        // setApiDomain();
        AppDio.getInstance().setApiDomain();

        ///======== 设置ws地址 连接websocket
        ///现在已经移到MaintabController
        // AppWebSocket.setWebSocketUrl();
        // AppWebSocket.connect();
        // DataStoreController.to.initObj();
        Get.log("baseUrl ${StringKV.baseUrl.get() ?? ''}");

        /// 用户信息和余额
        ConfigController.to.fetchConfig();

        /// 用户信息和余额
        UserController.to.getUserInfo();

        // 处理一些公共逻辑
        doCommonAction();
        Get.offNamed(Routes.mainTab);

        /// 传赛事ID 再跳转详情
        String? mid = params['mid'];
        if (ObjectUtil.isNotEmpty(mid)) {
          Get.toNamed(Routes.matchDetail, arguments: {
            'mId': mid.toString(),
          })?.then((res) {
            if (Get.currentRoute == Routes.home) {
              if (!ObjectUtil.isEmpty(res)) {
                HomeControllerLogic.preLoadNextMatchBaseInfoList(res, true);
              }
            } else if (Get.currentRoute == Routes.DJView) {
              DJController.to.getDateList();
            }
          });
        }
      });
      // 启动域名检测功能
      domainInstance.run();
    }
  }

  doCommonAction() {
    String str = StringKV.eSportsImgDomain.get() ?? '';
    if(str.isNotEmpty)return;
    // 获取电竞域名
    CommonApi.instance().getDjImageDomain().then((value) {
      String data = value.data ?? 'https://uphw-cdn5.q7b4549e.com';
      StringKV.eSportsImgDomain.save(data);
    });
  }

  // 设置用户信息
  setUserInfo(Map params) {
    ///设置token
    String token = params['token'].toString();
    StringKV.token.save(token);

    ///更新用户语言
    String lang = params['lg'].toString();
    if (kDebugMode) {
      print('token---------$token');
      print('lang---------$lang');
    }

    String language = 'CN';

    ///国际化更新
    if (lang.contains('en')) {
      language = 'GB';
      Get.updateLocale(const Locale('en', 'GB'));
    } else if (lang.contains('zh')) {
      language = 'CN';
      Get.updateLocale(const Locale('zh', 'CN'));
    } else if (lang.contains('tw')) {
      language = 'TW';
      Get.updateLocale(const Locale('zh', 'TW'));
    } else if (lang.contains('vi')) {
      language = 'VN';
      Get.updateLocale(const Locale('vi', 'VN'));
    } else if (lang.contains('ms')) {
      language = 'MY';
      Get.updateLocale(const Locale('ms', 'MY'));
    } else if (lang.contains('th')) {
      language = 'TH';
      Get.updateLocale(const Locale('th', 'TH'));
    }else if (lang.contains('ko')) {
      language = 'KR';
      Get.updateLocale(const Locale('ko', 'KR'));
    }else if (lang.contains('pt')) {
      language = 'PT';
      Get.updateLocale(const Locale('pt', 'PT'));
    }
    StringKV.language.save(language);
  }
}
