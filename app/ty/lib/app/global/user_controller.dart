import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/core/constant/index.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_map_operate.dart';
import 'package:flutter_ty_app/app/global/server-time.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/services/models/res/balance_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/user_info.dart';
import 'package:flutter_ty_app/app/services/models/res/user_personalise_entity.dart';
import 'package:uuid/uuid.dart';

import '../../generated/locales.g.dart';
import '../modules/home/controllers/home_controller.dart';
import '../services/api/menu_api.dart';
import '../services/models/res/get_user_customize_info_entity.dart';
import '../services/network/domain.dart';
import '../services/network/response_interceptor.dart';

class UserController extends GetxController {
  static UserController get to => Get.put(UserController(), permanent: true);

  Rxn<UserInfo> userInfo = Rxn<UserInfo>();
  final balance = Rxn<BalanceEntity>();

  final RxDouble balanceAmount = 0.0.obs;
  String preOdds = 'EU';
  String curOdds = 'EU';

  late UserPersonaliseEntity userPersonaliseEntity;

  // 用户是否开启一键投注
  bool isOneClickBet = false;

  // 用户一键投注设置金额
  double oneClickBetAmount = 0.0;

  // 用户自定义投注金额  单关投注 串关投注 显示列表
  late List<int> seriesList = [];
  late List<int> singleList = [];

  @override
  void onInit() {
    super.onInit();

    initUserPersonaliseEntity();
  }

  afterUserCb() {
    serverTime.getServerTime();
    // getServerTime();
    getBalance();
    Future.delayed(const Duration(seconds: 1), () {
      getUserPersonalise();
      getUserCustomizeInfo();
      getUserCustomizeInfoBetAmount();
    });
  }

  // oss逻辑会拉取此接口 在此判断
  Future<void> getUserInfo() async {
    try {
      if (userInfo.value == null) {
        final res =
            await AccountApi.instance().getUserInfo(StringKV.token.get() ?? '');
        if (res.success) {
          userInfo.value = res.data;
          Get.log("userInfo.value = ${userInfo.value}");
          domainInstance.setUserInfo(userInfo.value);
          //获取用户热门，时间排序方式。
          HomeController.to.homeState.isHot =
          (UserController.to.userInfo.value!.sort == 1);
          BoolKV.sort.save(UserController.to.userInfo.value!.sort==1);
        }

      }
      afterUserCb();
    } catch (e) {
      Get.log('get user info error: $e');
    }
  }

  // 获取服务器时间 存入本地 需要计算 和本地时间的差值
  getServerTime() async {
    AccountApi.instance().getServerTime().then((value) {
      try {
        int serverTime = int.tryParse(value.data) ?? 0;
        int localtime = DateTime.now().millisecondsSinceEpoch;
        // print(serverTime);
        // print(localtime);
        // print(serverTime - localtime);
        int v = serverTime - localtime;
        if (kDebugMode) {
          print(v);
        }
        IntKV.diffTime.save(v);
      } catch (e) {}
    });
  }

  //有单独调用刷新余额
  Future<void> getBalance() async {
    try {
      final balanceRes =
          await AccountApi.instance().getBalance(userInfo.value?.userId ?? '');
      if (balanceRes.success) {
        balance.value = balanceRes.data;
        balanceAmount.value = balanceRes.data!.amount;

        update();
      }
    } catch (e) {
      Get.log('get balance error: $e');
    }
  }

  Future<void> getUserPersonalise() async {
    try {
      final personaliseRes = await AccountApi.instance().getUserPersonalise(1);
      if (personaliseRes.success && personaliseRes.data != null) {
        userPersonaliseEntity = personaliseRes.data!;
        curOdds = userPersonaliseEntity.handicapType == '0' ? 'EU' : 'HK';
        preOdds = userPersonaliseEntity.handicapType == '0' ? 'EU' : 'HK';
        String userVersion = "0";
        if (userPersonaliseEntity.userVersion.isNotEmpty) {
          userVersion = userPersonaliseEntity.userVersion;
        }
        //获取用户是专业版本，新手版。
        HomeController.to.homeState.isProfess = (userVersion == "0");
        BoolKV.userVersion.save(userVersion == "0");
      }
    } catch (e) {
      Get.log('get balance error: $e');
    }
  }

  Future<void> setUserPersonalise({
    String? toAccept,
    String? userVersion,
    String? handicapType,
  }) async {
    try {
      final personaliseRes = await AccountApi.instance()
          .setUserPersonalise(toAccept, userVersion, handicapType);
      if (personaliseRes.success && toAccept != null) {
        userPersonaliseEntity.toAccept = toAccept;
      }
    } catch (e) {
      Get.log('setUserPersonalise error: $e');
    }
  }

  Future<void> getUserCustomizeInfo() async {
    try {
      final customizeInfoRes = await MenuApi.instance().getUserCustomizeInfo(1);
      if (customizeInfoRes.code == '0000000') {
        if (customizeInfoRes.data.singleList.isNotEmpty) {
          singleList = customizeInfoRes.data.singleList;
        }else{
          UserInfoCvoSingle single = userInfo.value?.cvo?.single ?? UserInfoCvoSingle();
          
          List<int> arr = [
            // single.qon,
            // single.qtw,
            // single.qth,
            // single.qfo,
            // single.qth,
            // single.qfi
          ];

          single.toJson().forEach((key, value) { 
            if (key.startsWith('q')) {
              arr.add(value);
            }
          });
          arr.sort((a,b)=>a-b);
          if(arr.length>5){
            arr.removeLast();
          }
          singleList = arr;
        }

        if (customizeInfoRes.data.seriesList.isNotEmpty) {
          seriesList = customizeInfoRes.data.seriesList;  
        }else{
          UserInfoCvoSeries series = userInfo.value?.cvo?.series ?? UserInfoCvoSeries();
          List<int> arr = [
            // series.qon,
            // series.qtw,
            // series.qth,
            // series.qfo,
            // series.qth,
            // series.qfi
          ];
          series.toJson().forEach((key, value) {
            if (key.startsWith('q')) {
              arr.add(value);
            }
          });
          arr.sort((a,b)=>a-b);
          if(arr.length>5){
            arr.removeLast();
          }
          seriesList = arr;
        }

        
        setUserCustomizeInfo();
      }
    } catch (e) {
      Get.log('get UserCustomizeInfo error: $e');
    }
  }
  // 初始化接口设置  自定义快捷投注设置
  setUserCustomizeInfo(){
    setUserCustomizeSingle();
    setUserCustomizeSeries();
  }
  
  setUserCustomizeSingle(){
      UserInfoCvoSingle? single = userInfo.value?.cvo?.single;
      if(single == null){
        single = UserInfoCvoSingle();
        userInfo.value?.cvo?.single = single;
      }
      if(singleList.isEmpty)return;

      single.qon = singleList[0];
      if (singleList.length > 1) {
        single.qtw = singleList[1];
      }
      if (singleList.length > 2) {
        single.qth = singleList[2];
      }
      if (singleList.length > 3) {
        single.qfo = singleList[3];
      }
      if (singleList.length > 4) {
        single.qfi = singleList[4];
      }
     
  }
  
  setUserCustomizeSeries(){
      UserInfoCvoSeries? series = userInfo.value?.cvo?.series;
      if(series == null){
        series = UserInfoCvoSeries();
        userInfo.value?.cvo?.series = series;
      }
      
      if (seriesList.isEmpty) return;

      series.qon = seriesList[0];

      if (seriesList.length > 1) {
        series.qtw = seriesList[1];
      }
      if (seriesList.length > 2) {
        series.qth = seriesList[2];
      }
      if (seriesList.length > 3) {
        series.qfo = seriesList[3];
      }
      if (seriesList.length > 4) {
        series.qfi = seriesList[4];
      }
   
  }

  Future<void> getUserCustomizeInfoBetAmount({GetUserCustomizeInfoEntity? infoRes}) async {
    GetUserCustomizeInfoEntity customizeInfoRes;
    if(infoRes!=null){
      customizeInfoRes = infoRes;
    }else{
      try {
        customizeInfoRes = await MenuApi.instance().getUserCustomizeInfo(2);
      } catch (e) {
        Get.log('get UserCustomizeInfo error: $e');
        return;
      }
    }
    if (customizeInfoRes.code == '0000000' && customizeInfoRes.data != null) {
      isOneClickBet = customizeInfoRes.data.switchOn;
      oneClickBetAmount =
          double.tryParse(customizeInfoRes.data.fastBetAmount.toString()) ??
              userInfo.value?.cvo?.single?.qfi.toDouble() ??
              10;
    }
  }

  String getUid() {
    if (ObjectUtil.isNotEmpty(userInfo.value?.userId)) {
      return userInfo.value!.userId;
    } else {
      /// uuid
      return const Uuid().v1();
    }
  }

  ///  预约结算 start 0：关；1：开
  /// bookedSettleSwitchBasketball    预约提前结算开关-篮球
  /// bookedSettleSwitchFootball      预约提前结算开关-足球
  /// partSettleSwitchBasketball      部分提前结算开关-篮球
  /// partSettleSwitchFootball        部分提前结算开关-足球
  /// settleSwitch                    足球提前结算开关
  /// settleSwitchBasket              篮球提前结算开关
  /// sysBookedSettleSwitch           系统预约提前结算开关
  /// sysPartSettleSwitch             系统部分提前结算开关
  ///
  ///提前结算，足球开关
  bool isSettleSwitch(){
    bool settleSwitch=false;
    if(ObjectUtil.isNotEmpty(userInfo.value?.settleSwitchVO)){
      settleSwitch =userInfo.value!.settleSwitchVO?.settleSwitch== 1;
    }
    return settleSwitch;
  }
  ///提前结算，篮球开关
  bool isSettleSwitchBasket(){
    bool settleSwitchBasket=false;
    if(ObjectUtil.isNotEmpty(userInfo.value?.settleSwitchVO)){
      settleSwitchBasket = userInfo.value!.settleSwitchVO?.settleSwitchBasket== 1;
    }
    return settleSwitchBasket;
  }

  void initUserPersonaliseEntity() {
    userPersonaliseEntity = UserPersonaliseEntity();
    userPersonaliseEntity.addHandicap = '0'; // 附加盘(0-关/1-开,默认关)
    userPersonaliseEntity.handicapType = '0'; //	盘口类型,欧盘/亚盘(EU-欧盘,AS-亚盘,默认欧盘)
    userPersonaliseEntity.isHk = '0'; // 港译/简译(0-港译/1-简译,默认简译)
    userPersonaliseEntity.playAdName = '1'; // 列表页附加玩法(0-关,1-开,默认关)
    userPersonaliseEntity.playAdNameCg = '0'; // 列表页附加玩法配置(0-3行展示/1-全部行,默认全部行)
    userPersonaliseEntity.skinMode = '1'; // 日间/夜间(0-日间,1-夜间,默认日间)
    userPersonaliseEntity.toAccept = '1'; // 自动接受最好赔率(0-任何赔率/1-最佳赔率,默认任何赔率)
    userPersonaliseEntity.userLanguage = 'zh'; //	多语言切换(默认根据商户设置,对应值为多语言code)
    userPersonaliseEntity.userVersion = '0'; //	专业版/新手版(0-专业版,1-新手版,默认专业版)
  }

  // 是否支持当前赔率
  bool isCurDdds(String? odds) {
    // 获取当前的盘口赔率
    String currOddsNum = (Csid.odds_table[curOdds]) ?? '1';

    // 获取当前投注项 如果不支持当前的赔率 就使用欧赔
    if (odds?.contains(currOddsNum) == true) {
      return true;
    }
    return false;
  }

  //获取当前倍率对应的名称
  String curOddsLabel(String? odds) {
    BetOddsConstantModel? betOddsConstantModel;
    if (isCurDdds(odds)) {
      betOddsConstantModel =
          oddsConstant.firstWhereOrNull((element) => element.value == curOdds);
    }
    return betOddsConstantModel?.label ?? LocaleKeys.odds_EU;
  }

  // 获取当前币种
  String currCurrency() {
    int? cur_code = int.tryParse(userInfo.value?.cvo?.series?.code ?? '1');
    String currency = currency_code[cur_code] ?? 'RMB';
    return currency;
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

  // 设置盘口
  setCur(String odds) {
    curOdds = odds;
  }

  // 是否显示 活动
  bool isHaveActivity() {
    return (userInfo.value?.activityList.isNotEmpty ?? false) &&
        ['zh', 'hk'].contains(Get.locale?.languageCode);
  }

  // 对应国际化title
  String getTitle() {
    String languageCode = Get.locale?.languageCode ?? "zh";
    String? title = "";
    if (languageCode == 'zh') {
      title = userInfo.value?.configVO?.titleMap?.zh;
    } else if (languageCode == 'en') {
      title = userInfo.value?.configVO?.titleMap?.en;
    } else if (languageCode == 'md') {
      title = userInfo.value?.configVO?.titleMap?.md;
    } else if (languageCode == 'ms') {
      title = userInfo.value?.configVO?.titleMap?.ms;
    } else if (languageCode == 'pty') {
      title = userInfo.value?.configVO?.titleMap?.pty;
    } else if (languageCode == 'th') {
      title = userInfo.value?.configVO?.titleMap?.th;
    } else if (languageCode == 'ad') {
      title = userInfo.value?.configVO?.titleMap?.ad;
    } else if (languageCode == 'vi') {
      title = userInfo.value?.configVO?.titleMap?.vi;
    } else if (languageCode == 'tw') {
      title = userInfo.value?.configVO?.titleMap?.tw;
    } else if (languageCode == 'hy') {
      title = userInfo.value?.configVO?.titleMap?.hy;
    }
    return title ?? userInfo.value?.configVO?.title?? "";
  }
}