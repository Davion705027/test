import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/config/theme/theme_controller.dart';
import 'package:flutter_ty_app/app/db/app_cache.dart';
import 'package:flutter_ty_app/app/global/assets/preloadImg.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'app/config/lang/translation_service.dart';
import 'app/config/theme/app_theme.dart';
import 'app/modules/home/controllers/home_controller.dart';
import 'app/modules/sdk_home/sdk_home_binding.dart';
import 'app/modules/shop_cart/shop_cart_material.dart';
import 'app/modules/shop_cart/shop_cart_navigator_observer.dart';
import 'app/modules/shop_cart/shop_cart_view.dart';
import 'app/routes/app_pages.dart';
import 'app/widgets/image_view.dart';

bool isIPad = false;
var h5ulr = '';
var h5Env = '';
BuildContext? oBContext;

Future<void> main() async {
  await TYInit(isSDK: false);

  final Locale local = TranslationService.getInitLocale();
  BuildContext oBContext;
  runApp(MyApp(
    locale: local,
    url: '',
    env: '',
    context: null,
    isSDK: false,
    // isDark: isDarkMode ?? true, //缺省使用dark模式
  ));
}

Future<void> TYInit({bool isSDK=true}) async{
  WidgetsFlutterBinding.ensureInitialized();

  /// 初始化数据库
  await dbPreInit();

  /// 状态栏透明
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  /// 禁用手机横屏
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // bool isDarkMode = BoolKV.theme.get() ?? false;

  ///获取当前语言
 // final Locale local = TranslationService.getInitLocale();


  if(Platform.isIOS){
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    if (iosInfo.utsname.machine.contains('iPad')) {
      isIPad = true;
    }else {
      isIPad = false;
    }
  }

  loadFont(isSDK:isSDK);
}

Future<void> loadFont({required bool isSDK}) async {
  // 使用 rootBundle.load 方法加载字体文件
  String fontPath = 'fonts/Akrobat-Bold.otf';
  if(isSDK){
    fontPath = 'packages/flutter_ty_app/' + fontPath;
  }

  final fontData = rootBundle.load(fontPath);
  // 使用 FontLoader 加载字体文件
  var myCustomFont = FontLoader('Akrobat')
    ..addFont(fontData);
  // 开始加载字体文件
  await myCustomFont.load();

}

class MyApp extends StatelessWidget {

  MyApp({
    super.key,
    required this.locale,
    required this.url,
    required this.env,
    required context,
    this.isSDK = true,
  }) {
    h5ulr = url;
    h5Env = env;
    oBContext = context;
  }

  ///theme控制器
  final ThemeController themeController = Get.put(ThemeController());
  final Locale locale;
  final String url;
  final String env;
  final bool isSDK;



  Widget _loading() {
    return ImageView(
      'assets/images/game/refresh_icon.gif',
      width: 35.w,
      height: 35.w,
    );
  }



  @override
  Widget build(BuildContext context) {
    PreloadImg.preloadOnHome(context);
    PreloadImg.delayPreloadOnDetail(context);
    themeController.isDarkMode.value = BoolKV.theme.get() ?? false;
    return ScreenUtilInit(
      designSize:  isIPad ? const Size(768, 1024) : const Size(390, 844),
      minTextAdapt: true,
      builder: (context, child) => RefreshConfiguration(
        footerBuilder: () => CustomFooter(
          height: 80.h,
          builder: (BuildContext context, LoadStatus? mode) {
            return Container(
              padding: EdgeInsets.only(top: 10.h, bottom: 80.h),
              alignment: Alignment.center,
              child: Text(
                '${LocaleKeys.myScroll_msg7.tr}～',
                style: TextStyle(
                    color: Colors.white.withOpacity(0.5), fontSize: 12.sp),
              ),
            );
          },
        ),
        headerBuilder: () => ClassicHeader(
          refreshingText: '${LocaleKeys.myScroll_msg5.tr}～',
          idleText: '${LocaleKeys.myScroll_msg5.tr}～',
          completeText: '${LocaleKeys.myScroll_msg5.tr}～',
          failedText: '${LocaleKeys.myScroll_msg5.tr}～',
          releaseText: '${LocaleKeys.myScroll_msg5.tr}～',
          completeDuration: Duration.zero,
          idleIcon: _loading(),
          refreshingIcon: _loading(),
          completeIcon: _loading(),
          failedIcon: _loading(),
          releaseIcon: _loading(),
        ),
        child: GestureDetector(
          onTap: () {
            hideKeyboard(context);
          },
          child: OKToast(
            child: GetMaterialApp(
              title: '体育',
              debugShowMaterialGrid: false,
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              defaultTransition: Transition.cupertino,
              themeMode: themeController.isDarkMode.value
                  ? ThemeMode.dark
                  : ThemeMode.light,
              translations: TranslationService(),
              localizationsDelegates: const [
                RefreshLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en', 'GB'),  ///英式-英语
                Locale('zh', 'CN'), ///中文-简体
                Locale('zh', 'TW'), ///中文-繁体
                Locale('vi', 'VN'), ///越南
                Locale('ms', 'MY'), ///马来西亚
                Locale('th', 'TH'), ///泰国
                Locale('ko', 'KR'), ///韩国
                Locale('pt', 'PT'), ///葡萄牙
              //  Locale('id', 'ID'),
              ],
              locale: locale,
              fallbackLocale: TranslationService.fallbackLocale,
              // defaultTransition: Transition.cupertino,
              debugShowCheckedModeBanner: false,
              initialRoute: isSDK?AppPages.init_SDK:AppPages.init_APP,
              getPages: AppPages.routes,
              initialBinding: SdkHomeBinding(),
              navigatorObservers: [ShopCartNavigatorObserver()],
              builder: (context, child) {
                return MediaQuery(
                    data: MediaQuery.of(context)
                        .copyWith(textScaler: TextScaler.noScaling),
                    child: ShopCartMaterial(
                      child: Stack(
                        children: [
                          if (child != null) child,
                          ShopCartComponent(),
                        ],
                      ),
                    ));
              },
            ),
          ),
        ),
      ),
    );
  }

  ///添加全局点击背景收起键盘判断
  void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
