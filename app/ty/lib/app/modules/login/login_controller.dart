import 'package:dio/dio.dart';
import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/global/user_controller.dart';
import 'package:flutter_ty_app/app/services/api/common_api.dart';
import 'package:flutter_ty_app/app/services/network/domain.dart';

import '../../global/ws/ws_app.dart';
import 'login_head_import.dart';
import 'login_logic.dart';

class LoginController extends GetxController {
  final Loginlogic logic = Loginlogic();

  ///初始化配置
  bool obscurePassword = false;
  String version = '';
  String env = '生产维护';

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  final dio = Dio();

  String domain = '';
  String terminal = 'h5';

  @override
  void onInit() {
    // TODO: implement onInit
    initialization();

    ///获取设备信息 版本信息
    getVersion();
    super.onInit();
  }

  void onObscurePassword() {
    obscurePassword = !obscurePassword;
    update();
  }

  ///获取设备信息 版本信息
  Future<void> getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    env = StringKV.env.get() ?? "";
    update();
  }

  void initialization() {
    env = StringKV.env.get() ?? "";

    goToSelect(env);
  }

  void goToSelect(String ev) {
    env = ev;
    StringKV.env.save(ev);

    if (env == '生产维护') {
      domain = 'https://neibu.dbsportxxx1zx.com/yewu6';
      usernameController.text = 'kj';
      passwordController.text = 'kj';
      codeController.text = 'oubao';

      BUILDIN_CONFIG['CURRENT_ENV'] = 'idc_online';
      BUILDIN_CONFIG['OSS_FILE_NAME'] = 'prod.json';
    } else if (env == '开发') {
      domain = 'http://dev-api-1.sportxxxifbdxm2.com/yewu6';
      usernameController.text = '';
      passwordController.text = '';
      codeController.text = '';

      BUILDIN_CONFIG['CURRENT_ENV'] = 'local_dev';
      BUILDIN_CONFIG['OSS_FILE_NAME'] = 'dev.json';
    } else if (env == '测试') {
      domain = 'http://sit-api-2.sportxxxifbdxm2.com/yewu6';
      usernameController.text = 'ty7C6IRjXPLZ';
      passwordController.text = 'ty7C6IRjXPLZ';
      codeController.text = '';

      BUILDIN_CONFIG['CURRENT_ENV'] = 'local_test';
      BUILDIN_CONFIG['OSS_FILE_NAME'] = 'test.json';
    } else if (env == '隔离') {
      domain = 'http://uat-api-1.sportxxxifbdxm2.com/yewu6';
      usernameController.text = '';
      passwordController.text = '';
      codeController.text = '';

      BUILDIN_CONFIG['CURRENT_ENV'] = 'idc_lspre';
      BUILDIN_CONFIG['OSS_FILE_NAME'] = 'lspre.json';
    } else if (env == '试玩') {
      domain = 'https://api.dbsporxxxw1box.com/yewu6';
      usernameController.text = 'tyyGZkpfmJlP';
      passwordController.text = 'tyyGZkpfmJlP';
      codeController.text = '';

      BUILDIN_CONFIG['CURRENT_ENV'] = 'idc_sandbox';
      BUILDIN_CONFIG['OSS_FILE_NAME'] = 'play.json';
    } else if (env == 'MINI') {
      domain = 'http://api.sportxxxyp7.com/yewu6';
      usernameController.text = '';
      passwordController.text = '';
      codeController.text = '';

      BUILDIN_CONFIG['CURRENT_ENV'] = 'idc_ylcs';
      BUILDIN_CONFIG['OSS_FILE_NAME'] = 'mini.json';
    }
  }

  ///登录
  Future<void> toLogin() async {
    if (usernameController.text.isEmpty) {
      ToastUtils.show('请输入用户名称');
      return;
    } else if (passwordController.text.isEmpty) {
      ToastUtils.show('请输入用户密码');
      return;
    }

    var res = await AccountApi(AppDio.getInstance().dio, baseUrl: domain)
        .loginPanda(usernameController.text, codeController.text,
            passwordController.text, terminal);
    var data = res['data'];
    if (res['status'] == false) {
      ToastUtils.show(res['msg']);
    } else {
      inItData(data);
    }
  }

  Future<void> inItData(Map data) async {
    String h5 = data['loginUrl'];

    // var t1 = DateTime.now().microsecondsSinceEpoch;
    DateTime t1 = DateTime.now();
    // oss逻辑处理
    domainInstance.create(h5, callback: (DamainModel res) async {
      // 设置api
      // setApiDomain();
      AppDio.getInstance().setApiDomain();

      ///获取 api接口 才写入用户token 不然进入app没用
      Uri uri = Uri.parse(h5);
      Map<String, dynamic> params = uri.queryParameters;

      /// 处理用户信息
      setUserInfo(params);

      ///======== 设置ws地址 连接websocket
      AppWebSocket.setWebSocketUrl();
      AppWebSocket.connect();
      DataStoreController.to.initObj();

      /// 用户信息和余额
      ConfigController.to.fetchConfig();
      UserController.to.getUserInfo();
      // 处理一些公共逻辑
      doCommonAction();

      Get.offNamed(Routes.mainTab);
    });
    // 启动域名检测功能
    domainInstance.run();
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
    } else if (lang.contains('ko')) {
      language = 'KR';
      Get.updateLocale(const Locale('ko', 'KR'));
    }else if (lang.contains('pt')) {
      language = 'PT';
      Get.updateLocale(const Locale('pt', 'PT'));
    }
    StringKV.language.save(language);
  }

  toSelect() {
    showModalBottomSheet(
        context: Get.context!,
        builder: (context) => StatefulBuilder(
            // 嵌套一个StatefulBuilder 部件
            builder: (context, bottomSheetUpdate) => BottomSheet(
                  builder: (BuildContext context) {
                    return Container(
                      height: 600.h,
                      decoration: const BoxDecoration(
                        color: AppColor.activeBackgroundColor,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 40.h,
                            decoration: const BoxDecoration(
                              color: AppColor.mhBackgroundColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  ' ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                                const Text(
                                  '模拟登录环境选择',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                InkWell(
                                  onTap: () => Get.back(),
                                  child: Container(
                                    margin: EdgeInsets.only(right: 15.w),
                                    child: ImageView(
                                      "assets/images/icon/activity-rule-close.png",
                                      boxFit: BoxFit.fill,
                                      width: 25.w,
                                      height: 25.h,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10.w, right: 10.w),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    bottomSheetUpdate(() {
                                      goToSelect('生产维护');
                                      update();
                                    });
                                    Get.back();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      top: 10.w,
                                    ),
                                    height: 50.h,
                                    decoration: env == '生产维护'
                                        ? ShapeDecoration(
                                            color: const Color(0x4C3E65FF),
                                            shape: RoundedRectangleBorder(
                                              side: const BorderSide(
                                                  width: 1,
                                                  color: Color(0xFF3E65FF)),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          )
                                        : ShapeDecoration(
                                            color: Colors.white.withOpacity(
                                                0.05000000074505806),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: 20.w, right: 20.w),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            '生产维护',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                          if (env == '生产维护')
                                            ImageView(
                                              "assets/images/icon/common-select.png",
                                              boxFit: BoxFit.fill,
                                              width: 28.w,
                                              height: 28.h,
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    bottomSheetUpdate(() {
                                      goToSelect('开发');
                                      update();
                                    });
                                    Get.back();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      top: 10.w,
                                    ),
                                    height: 50.h,
                                    decoration: env == '开发'
                                        ? ShapeDecoration(
                                            color: const Color(0x4C3E65FF),
                                            shape: RoundedRectangleBorder(
                                              side: const BorderSide(
                                                  width: 1,
                                                  color: Color(0xFF3E65FF)),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          )
                                        : ShapeDecoration(
                                            color: Colors.white.withOpacity(
                                                0.05000000074505806),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: 20.w, right: 20.w),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            '开发',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                          if (env == '开发')
                                            ImageView(
                                              "assets/images/icon/common-select.png",
                                              boxFit: BoxFit.fill,
                                              width: 28.w,
                                              height: 28.h,
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    bottomSheetUpdate(() {
                                      goToSelect('测试');
                                      update();
                                    });
                                    Get.back();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      top: 10.w,
                                    ),
                                    height: 50.h,
                                    decoration: env == '测试'
                                        ? ShapeDecoration(
                                            color: const Color(0x4C3E65FF),
                                            shape: RoundedRectangleBorder(
                                              side: const BorderSide(
                                                  width: 1,
                                                  color: Color(0xFF3E65FF)),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          )
                                        : ShapeDecoration(
                                            color: Colors.white.withOpacity(
                                                0.05000000074505806),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: 20.w, right: 20.w),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            '测试',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                          if (env == '测试')
                                            ImageView(
                                              "assets/images/icon/common-select.png",
                                              boxFit: BoxFit.fill,
                                              width: 28.w,
                                              height: 28.h,
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    bottomSheetUpdate(() {
                                      goToSelect('隔离');
                                      update();
                                    });
                                    Get.back();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      top: 10.w,
                                    ),
                                    height: 50.h,
                                    decoration: env == '隔离'
                                        ? ShapeDecoration(
                                            color: const Color(0x4C3E65FF),
                                            shape: RoundedRectangleBorder(
                                              side: const BorderSide(
                                                  width: 1,
                                                  color: Color(0xFF3E65FF)),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          )
                                        : ShapeDecoration(
                                            color: Colors.white.withOpacity(
                                                0.05000000074505806),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: 20.w, right: 20.w),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            '隔离',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                          if (env == '隔离')
                                            ImageView(
                                              "assets/images/icon/common-select.png",
                                              boxFit: BoxFit.fill,
                                              width: 28.w,
                                              height: 28.h,
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    bottomSheetUpdate(() {
                                      goToSelect('试玩');
                                      update();
                                    });
                                    Get.back();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      top: 10.w,
                                    ),
                                    height: 50.h,
                                    decoration: env == '试玩'
                                        ? ShapeDecoration(
                                            color: const Color(0x4C3E65FF),
                                            shape: RoundedRectangleBorder(
                                              side: const BorderSide(
                                                  width: 1,
                                                  color: Color(0xFF3E65FF)),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          )
                                        : ShapeDecoration(
                                            color: Colors.white.withOpacity(
                                                0.05000000074505806),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: 20.w, right: 20.w),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            '试玩',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                          if (env == '试玩')
                                            ImageView(
                                              "assets/images/icon/common-select.png",
                                              boxFit: BoxFit.fill,
                                              width: 28.w,
                                              height: 28.h,
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    bottomSheetUpdate(() {
                                      goToSelect('MINI');
                                      update();
                                    });
                                    Get.back();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      top: 10.w,
                                    ),
                                    height: 50.h,
                                    decoration: env == 'MINI'
                                        ? ShapeDecoration(
                                            color: const Color(0x4C3E65FF),
                                            shape: RoundedRectangleBorder(
                                              side: const BorderSide(
                                                  width: 1,
                                                  color: Color(0xFF3E65FF)),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          )
                                        : ShapeDecoration(
                                            color: Colors.white.withOpacity(
                                                0.05000000074505806),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: 20.w, right: 20.w),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'MINI',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                          if (env == 'MINI')
                                            ImageView(
                                              "assets/images/icon/common-select.png",
                                              boxFit: BoxFit.fill,
                                              width: 28.w,
                                              height: 28.h,
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  onClosing: () {},
                )));
  }
}
