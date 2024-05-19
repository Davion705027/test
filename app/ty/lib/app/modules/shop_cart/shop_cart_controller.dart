import 'dart:math';

import 'package:flutter_ty_app/app/core/constant/index.dart';
import 'package:flutter_ty_app/app/core/format/index.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/base/base_bet_controller.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/single_bet/single_bet_controller.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';

import '../../../generated/locales.g.dart';
import '../../core/format/common/module/format-score.dart';
import '../../global/user_controller.dart';
import '../../global/ws/ws_app.dart';
import '../../global/ws/ws_type.dart';
import '../dj/controllers/dj_controller.dart';
import '../home/models/main_menu.dart';
import '../match_detail/models/odds_button_enum.dart';
import 'esport_bet/esport_mix_bet_controller.dart';
import 'esport_bet/esport_single_bet_controller.dart';
import 'mix_bet/mix_bet_controller.dart';
import 'model/shop_cart_item.dart';
import 'model/shop_cart_type.dart';
import 'shop_cart_state.dart';
import 'shop_cart_util.dart';
import 'vr_bet/vr_mix_bet_controller.dart';
import 'vr_bet/vr_single_bet_controller.dart';

class ShopCartController extends GetxController {
  static ShopCartController get to =>
      Get.put(ShopCartController(), );//permanent: true);

  final ShopCartState state = ShopCartState();

  late SingleBetController singleBetController;
  late MixBetController mixBetController;
  late EsportSingleBetController esportSingleBetController;
  late EsportMixBetController esportMixBetController;
  late VrSingleBetController vrSingleBetController;
  late VrMixBetController vrMixBetController;
  final isParlay = false.obs;
  final isEsportParlay = false.obs;
  final isVrParlay = false.obs;
  final isEsportBet = false.obs;
  final isVrBet = false.obs;

  List lastC10Cd = [];
  //late Timer refreshTimer;

  @override
  void onInit() {
    super.onInit();

    singleBetController = Get.put(SingleBetController());
    mixBetController = Get.put(MixBetController());
    esportSingleBetController = Get.put(EsportSingleBetController());
    esportMixBetController = Get.put(EsportMixBetController());
    vrSingleBetController = Get.put(VrSingleBetController());
    vrMixBetController = Get.put(VrMixBetController());

    // refreshTimer = Timer.periodic(const Duration(seconds: 6), (timer) {
    //   refreshData();
    // });
  }

  @override
  void onClose() {
    clearData();
    super.onClose();
  }

  //根据串关、电竞、VR等各个维度判断出当前的数据容器
  BaseBetController? get currentBetController {
    if (isVrBet.value) {
      if (isVrParlay.value && (Get.context != null && MediaQuery.of(Get.context!).orientation != Orientation.landscape)) {
        return vrMixBetController;
      } else {
        return vrSingleBetController;
      }
    } else if (isEsportBet.value && (Get.context != null && MediaQuery.of(Get.context!).orientation != Orientation.landscape)) {
      if (isEsportParlay.value) {
        return esportMixBetController;
      } else {
        return esportSingleBetController;
      }
    } else {
      if (isParlay.value && (Get.context != null && MediaQuery.of(Get.context!).orientation != Orientation.landscape)) {  //全屏模式下面为单关
        return mixBetController;
      } else {
        return singleBetController;
      }
    }
  }

// 选择投注项数据
  /**
   *
   * @param MatchEntity match,MatchHps place,MatchHpsHl market,MatchHpsHlOl odds,
   * 可选参数：
   * @param {Boolean} isDetail
   * @param {'common_bet'|'guanjun_bet'|'vr_bet'|'esports_bet'} betType 根据赛事纬度判断当前赛事属于 那种投注类型
   * @param {1|2|3|4|5} deviceType 设备类型 1:H5，2：PC,3:Android,4:IOS,5:其他设备
   * @param {'h5_detail'|'h5_list'} matchDataType
   * @param {String} playName 玩法名
   * @returns
   */
  void addBet(
      MatchEntity match, MatchHps place, MatchHpsHl? market, MatchHpsHlOl odds,
      {bool isDetail = false,
      OddsBetType betType = OddsBetType.common,
      bool secondaryPaly = false,
      String? matchDataType,
      String? playName,
      String? tipTitle}) {
    bool oddsIsDetail = odds.isDetail??false;
    if(currentBetController?.betStatus.value == ShopCartBetStatus.OneClickBetting){
      //正在一键投注，不接受其它投注项
      return;
    }

    // 有数据的再次点击 为取消投注项
    int itemIndex = currentBetController?.itemList
            .indexWhere((item) => item.playOptionsId == odds.oid) ??
        -1;
    if (itemIndex >= 0) {
      currentBetController
          ?.delShopCartItem(currentBetController!.itemList[itemIndex]);
      return;
    }

    if (currentBetController is MixBetController &&
        (betType == OddsBetType.guanjun || (betType == OddsBetType.esport && match.ispo == 0) ||
            ["C01", "B03", "O01"].contains(odds.cds) ||
            [2, 4].contains(match.mbmty))) {
      ToastUtils.showGrayBackground(LocaleKeys.bet_invalidation2.tr);
      return;
    }

    if (currentBetController is MixBetController &&
        currentBetController!.itemCount >= (currentBetController as MixBetController).maxSeriesNum) {
      ToastUtils.showGrayBackground(LocaleKeys.bet_bet_max_item.tr.replaceAll('{num}', (currentBetController as MixBetController).maxSeriesNum.toString()));
      return;
    }

    int matchType = getMatchType(betType, matchMs: match.ms);
    List handicapList =
        getHandicap(match, place, market, odds, oddsIsDetail, betType,secondaryPaly:secondaryPaly);
    String playOptionName;
    // 详情投注项
    if (oddsIsDetail) {
      playOptionName = odds.otv.isNotEmpty?odds.otv:odds.on;
    }else{
      playOptionName = odds.on.isNotEmpty?odds.on:odds.otv;
    }

    ShopCartItem item = ShopCartItem();
    item.sportId = match.csid;
    item.matchId = match.mid;
    item.tournamentId = match.tid;
    item.scoreBenchmark = match.msc.safeFirst ?? '';
    item.marketId = market?.hid ?? place.hid;
    item.marketValue = market?.hv ?? '';
    item.playOptionsId = odds.oid;
    item.marketTypeFinally = UserController.to.curOdds;
    item.odds = odds.ov;
    item.oddFinally = TYFormatOddsConversionMixin.computeValueByCurOddType(
            odds.ov,
            place.hpid,
            place.hsw.split(','),
            int.tryParse(match.csid) ?? 0)
        .obs; //hsw?
    item.sportName = match.csna;
    item.matchType = matchType;
    item.matchName = match.tn;
    item.playOptionName = playOptionName;
    item.playOptions = odds.ot;
    item.tournamentLevel = match.tlev;
    item.playId = place.hpid;
    item.playName = getPlayName(match, place, market, odds, oddsIsDetail, betType,secondaryPaly:secondaryPaly);
    item.dataSource = odds.cds;
    item.home = match.mhn.length > 0
        ? match.mhn
        : (match.teams.length > 0 ? match.teams[0] : '');
    item.away = match.man.length > 0
        ? match.man
        : (match.teams.length > 1 ? match.teams[1] : '');
    //item.ot = odds.ot;  //playOptions
    item.placeNum = market?.hn;
    item.betAmount = '';
    item.betType = betType;
    item.tidName = match.tn;
    item.matchMs = match.ms;
    item.matchMmp = match.mmp;
    item.matchTime = match.mgt;
    item.handicap = handicapList.firstOrNull ?? '';
    item.handicapHv = ''.obs;
    if(handicapList.length>1){
      item.handicapHv.value = handicapList[1];
    }
    item.markScore = ShopCartUtil.calcBifen(match.msc,
        int.tryParse(match.csid) ?? 0, match.ms, int.tryParse(place.hpid) ?? 0);
    item.mbmty = match.mbmty;
    item.olOs = odds.os.obs;
    item.hlHs = (market?.hs ?? 0).obs;
    item.midMhs = match.mhs.obs;
    //matchCtr
    //deviceType
    item.oddsHsw = place.hsw;
    item.ispo = match.ispo;
    item.hpsHids = place.hids;
    //有新添加的属性
    final score = TYFormatScore.formatTotalScore(match);
    item.scoreHome = score.home;
    item.scoreAway = score.away;
    item.scoreHomeAway = score.text.replaceAll(' ', '');

    currentBetController?.addShopCartItem(item);

    // 一键投注
    if(currentBetController is SingleBetController && UserController.to.isOneClickBet){
      if(UserController.to.balanceAmount.value < UserController.to.oneClickBetAmount){
        ShopCartUtil.showBetError('0400455');
        currentBetController?.clearData();
        return;
      }

      currentBetController!.betStatus.value = ShopCartBetStatus.OneClickBetting;
      currentBetController!.queryBetAmount().then((voidValue) {
        final betAmount = min(UserController.to.oneClickBetAmount,double.tryParse(currentBetController!.maxValue)??8888);
        currentBetController!.amountController.text = betAmount.toString();

        currentBetController!.doBet().then((value) {
          if(!value){
            //报错的话，进入正常流程
            currentBetController!.betStatus.value = ShopCartBetStatus.Normal;

          }
          currentBetController!.showBet();
        });
      });



    }else {
      //currentBetController?.queryBetAmount();

      if ((currentBetController is VrMixBetController && isVrParlay.value)  || (currentBetController is EsportMixBetController && isEsportParlay.value) || (currentBetController is MixBetController && isParlay.value )) {
        //串关显示收拢界面
        state.showShopCart.value = false;
      } else {
        //单关显示投注界面
        //state.showShopCart.value = true;
        currentBetController?.showBet(queryAmount: true);
      }
    }
  }

  /*
  投注项是否选中
  参数：
    oid 投注项ID
  */
  bool isCheck(String? oid) {
    if (oid == null || oid.isEmpty) {
      return false;
    }
    var shopCartItem = currentBetController?.itemList
        .firstWhereOrNull((item) => item.playOptionsId == oid);

    return shopCartItem != null;
  }

  /*
   * @param betType  投注类型
   * @param  matchMs  赛事阶段
   */
  int getMatchType(OddsBetType betType, {int? matchMs}) {
    // 1 ：早盘赛事 ，2： 滚球盘赛事，3：冠军，4：虚拟赛事，5：电竞赛事")
    int matchType = 1;
    // 冠军
    if (betType == OddsBetType.common) {
      //  ms的值，0:未开赛 1:滚球阶段 2:暂停 3:结束 4:关闭 5:取消 6:比赛放弃 7:延迟 8:未知 9:延期 10:比赛中断 110:即将开赛
      if ([1, 2, 110].contains(matchMs)) {
        matchType = 2;
      }
    }
    // 冠军
    if (betType == OddsBetType.guanjun) {
      matchType = 3;
    }
    // 电竞赛事 电竞冠军的话也为5
    if (betType == OddsBetType.esport || currentBetController == esportSingleBetController || currentBetController == esportMixBetController) {
      matchType = 5;
    }
    // 虚拟赛事
    if (betType == OddsBetType.vr) {
      matchType = 4;
    }

    return matchType;
  }

  // 设置玩法名称
  String getPlayName(MatchEntity match, MatchHps place, MatchHpsHl? market,
      MatchHpsHlOl odds, bool isDetail, OddsBetType betType,
      {bool secondaryPaly = false, bool isKemp = false}) {
    // chpid 优先于hpid
    String hpid = place.chpid.isNotEmpty ? place.chpid : place.hpid;
    String playName = ALL_SPORT_PLAY[int.tryParse(hpid) ?? 0] ?? '';

    if (secondaryPaly) {
      // 缺乏play_obj

      playName = place.hpnb.isNotEmpty ? place.hpnb : place.hpn;
    } else {
      if (isDetail) {
        // 详情 并且本地没有配置玩法
        playName = place.hpn;
      } else {
        String hpn = place.hpn;
        //暂无play_obj
        //hpn = lodash_.get(mid_obj.play_obj,`hpid_${hpid}.hpn`,play_name)
        // 冠军玩法 部分玩法hpid相同
        if (betType == OddsBetType.guanjun || isKemp) {
          List<MatchHps> hpnList = [];
          //暂无hpsPns
          //hpnList = match.hpsPns;
          if (hpnList.isEmpty) {
            hpnList = match.hps;
          }
          MatchHps? hpnObj =
              hpnList.firstWhereOrNull((item) => item.hid == place.hid);
          if (hpnObj?.hid != null) {
            hpn = hpnObj!.hpn.isNotEmpty ? hpnObj.hpn : hpnObj.hps;
          } else {
            hpn = LocaleKeys.bet_bet_winner.tr;
          }
        }
        if (hpn.isNotEmpty) {
          playName = hpn;
        }
      }
    }

    return playName;
  }

  // 获取盘口值 附加值
  List<String> getHandicap(MatchEntity match, MatchHps place,
      MatchHpsHl? market, MatchHpsHlOl odds, bool isDetail, OddsBetType betType,
      {bool secondaryPaly = false,bool repeat=false}) {
    // ## 详情页的取值，直接取 ol 层级的 `ott` + `on`,当遇到下面几种玩法时，直接取 `otv`,
    // 3-全场让球赛果  69-上半场让球赛果  71-下半场让球赛果
    // 220-球员得分 221-球员三分球 271-球员助攻 272-球员篮板
    // 171-独赢&总局数 13-独赢&进球大小 101-独赢&两队都进球  106-下半场独赢&下半场两队都进球 105-上半场独赢&上半场两队都进球 216-独赢&总分 102-进球大小&两队都进球
    // 107-双重机会&两队都进球
    // 339-拳击的独赢&准确回合数

    // ## 列表页的取值，分2个值相加，即 a+b 的形式，规则如下
    // 1. b取 最里层ol 的 `on`
    // 2. 当b的值里含有 `主胜` 或者 `客胜` 字样时，b 为空字符串
    // 3. 当 `ots` 值是 `T1` 时，a 取 `mhn`,当 `ots` 值是 `T2` 时，a 取 `man`,
    // 4. 当 玩法id 字段 `hpid` ,为 2 或者 173 或者 38 或者 114 时，a 为空字符串
    String text = '';
    String hv = '';
    // 展示用的 + 投注项
    const detail_mark = [
      3,
      13,
      69,
      71,
      102,
      107,
      101,
      106,
      105,
      171,
      216,
      220,
      221,
      271,
      272,
      339
    ];
    const lsit_mark = [2, 173, 38, 114];
    // 特殊玩法
    const list_head = [
      359,
      31,
      340,
      383,
      13,
      102,
      351,
      101,
      107,
      347,
      105,
      106,
      345,
      346,
      348,
      349,
      353,
      360,
      384
    ];
    // vr 前后2 玩法
    const vr_hpid = [20034, 20035, 20036, 20037, 20038];

    List<String> teams = match.teams;
    if (secondaryPaly) {
      //TODO
      if (["Under", 'Over'].contains(odds.ot)) {
        final onArray = odds.on.split(' ');
        text = onArray.safeFirst ?? '';
        hv = onArray.length>1?onArray[1]:'';
      } else if (odds.ot == "Other") {
        // 波胆 玩法 其他
        text = LocaleKeys.list_other.tr;
        hv = '';
      } else if ([111, 119, 126, 129, 135, 136, 310, 311, 333]
          .contains(int.tryParse(place.hpid))) {
        // 独赢 罚牌玩法 / 加时赛 / 冠军
        if (odds.ots == 'T1') {
          text = match.mhn;
        }
        if (odds.ots == 'T2') {
          text = match.man;
        }
        if (odds.ots == '') {
          text = odds.onb;
        }
      } else if ([33, 113, 121, 128, 130, 306, 308, 334]
          .contains(int.tryParse(place.hpid))) {
        // 让球
        if (odds.ots == 'T1') {
          text = match.mhn;
        }
        if (odds.ots == 'T2') {
          text = match.man;
        }
        hv = odds.on;
      } else if (odds.ot.contains("And")) {
        // 特色玩法 拼接
        if (odds.ots == 'T1') {
          text = match.mhn;
        }
        if (odds.ots == 'T2') {
          text = match.man;
        }
        // 平局
        if (odds.ots == '') {
          text = odds.onb;
          hv = odds.on;
        } else {
          List textOnb = odds.onb.split('&');
          text = text + (textOnb.length > 1 ? " & " + textOnb[1] : '');
          hv = odds.on;
        }
      } else {
        text = odds.on;
        hv = '';
      }

      if(text.isEmpty && !repeat){
        //因为详情页面更新了数据仓库，导致取不倒数据，重新再取一遍详情逻辑
        return getHandicap(match, place,market, odds, true, betType,secondaryPaly:false,repeat:true);
      }
    } else {
      // vr 体育的 赛狗 赛马 泥地摩托  摩托
      if (betType == OddsBetType.vr &&
          ['1002', '1011', '1009', '1010'].contains(match.csid)) {
        if (vr_hpid.contains(int.tryParse(place.hpid))) {
          List hvArray = odds.ot.split('/');
          List<Map<String, dynamic>> textArray = hvArray.map((item) {
            int index = (int.tryParse(item) ?? 0) - 1;
            return {
              'text': 0 <= index && index < teams.length ? teams[index] : '',
              'hv': item,
            };
          }).toList();
          //Vue里是数组，暂时以,代替
          text = textArray.map((e) => e['text']).join(',');
          hv = textArray.map((e) => e['hv']).join(',');
        } else if (20033 == int.tryParse(place.hpid)) {
          int index = (int.tryParse(odds.ot) ?? 0) - 1;
          List<Map<String, dynamic>> textArray = [
            {
              'text': 0 <= index && index < teams.length ? teams[index] : '',
              'hv': odds.ot,
            }
          ];
          //Vue里是数组，暂时以,代替
          text = textArray.map((e) => e['text']).join(',');
          hv = textArray.map((e) => e['hv']).join(',');
        } else {
          text = odds.otv;
        }
      } else {
        // 详情
        if (isDetail) {
          // 有球头 球头需要变色
          if (market?.hv != null && market!.hv!.isNotEmpty) {
            text = odds.ott;
            hv = odds.on;
          } else {
            text = odds.ott + odds.on;
            hv = '';
          }
          if (detail_mark.contains(int.tryParse(place.hpid)) &&
              odds.ot == 'X') {
            text = odds.otv;
            hv = '';
          }
          // 特殊玩法
          if (list_head.contains(int.tryParse(place.hpid))) {
            text = odds.otv;
            hv = '';
          }

          // 组合玩法
          if(odds.ot.contains('And')){
            text = odds.otv;
            hv = '';
          }

          if(text.isEmpty && !repeat){
            //因为列表页面更新了数据仓库，导致取不倒数据，重新再取一遍列表逻辑
            return getHandicap(match, place,market, odds, false, betType,secondaryPaly:secondaryPaly,repeat:true);
          }
        } else {
          String a = '';
          String b = odds.on;
          if (betType == OddsBetType.vr) {
            if (odds.ots == 'T1') {
              a = teams.length > 0 ? teams[0] : '';
            }
            if (odds.ots == 'T2') {
              a = teams.length > 1 ? teams[1] : '';
            }
          } else {
            if (odds.ots == 'T1') {
              a = match.mhn;
            }
            if (odds.ots == 'T2') {
              a = match.man;
            }
          }

          // 加入是否有球头判断
          if (['T1', 'T2'].contains(odds.ots) && (market?.hv?.isEmpty??true)) {
            b = '';
          }

          if (lsit_mark.contains(int.tryParse(place.hpid))) {
            a = '';
          }

          // 首页大小类玩法
          if (['Over', "Under"].contains(odds.ot)) {
            // h5数据格式和pc不一样
            List onArray = odds.on.split(' ');
            a = onArray.length > 1 ? onArray[0] : '';
            b = onArray.safeLast?? '';
          }

          // 平 不变色
          if (odds.ot == 'X') {
            text = b;
          } else {
            text = a;
            hv = b;
          }

          if(text.isEmpty && !repeat){
            //因为详情页面更新了数据仓库，导致取不倒数据，重新再取一遍详情逻辑
            return getHandicap(match, place,market, odds, true, betType,secondaryPaly:secondaryPaly,repeat:true);
          }
        }
      }
    }

    return [text, hv];
  }

  void changeMenuIndex(MainMenu menu) {
    isParlay.value = menu.isMatchBet &&
        (Get.currentRoute == Routes.mainTab ||
            Get.currentRoute == Routes.matchDetail);

    //切换到冠军盘
    if((menu.isChampion || menu.isMatchBet)  && !(state.menu.isChampion || state.menu.isMatchBet)){
      UserController.to.preOdds = UserController.to.curOdds;
      UserController.to.curOdds = 'EU';
    }else if(!(menu.isChampion || menu.isMatchBet)  && (state.menu.isChampion || state.menu.isMatchBet)){
      UserController.to.curOdds = UserController.to.preOdds;
    }

    state.menu = menu;
  }

  void changeDjMenu({bool changeGame=false}){
    bool isDjGuanjun = Get.isRegistered<DJController>() && DJController.to.isGuanjun();
    if(changeGame){//重置为所有日期
      isDjGuanjun = false;
    }

    //切换到冠军盘
    if(isDjGuanjun && !state.isDjGuanjun){
      UserController.to.preOdds = UserController.to.curOdds;
      UserController.to.curOdds = 'EU';
    }else if(!isDjGuanjun && state.isDjGuanjun){
      UserController.to.curOdds = UserController.to.preOdds;
    }

    state.isDjGuanjun = isDjGuanjun;
  }

  // 根据当前的投注项 获取对应的赔率变化ws
  void subscribeMarket() {
    List itemList = [];
    //订阅需一起订阅
    itemList.addAll(singleBetController.itemList);
    itemList.addAll(mixBetController.itemList);
    itemList.addAll(esportSingleBetController.itemList);
    itemList.addAll(esportMixBetController.itemList);
    itemList.addAll(vrSingleBetController.itemList);
    itemList.addAll(vrMixBetController.itemList);
    if (itemList.isEmpty) {
      //购物车无数据
      return;
    }

    List marketIds = [];
    List matchIds = [];
    itemList.forEach((element) {
      marketIds.add(element.marketId);
      matchIds.add(element.matchId);
    });
    marketIds = marketIds.toSet().toList();
    matchIds = matchIds.toSet().toList();

    Map<String, dynamic> C2Map = {};
    C2Map['hid'] = marketIds.join(',');
    C2Map['mid'] = matchIds.join(',');
    C2Map['marketLevel'] = UserController.to.userInfo.value?.marketLevel ?? 0;
    C2Map['esMarketLevel'] =
        UserController.to.userInfo.value?.esMarketLevel ?? 0;

    // 取消之前的所有订阅
    C2Map['hid'] = '';
    sendBetC02Message(C2Map);
    C2Map['hid'] = marketIds.join(',');
    // 重新发起
    Future.delayed(Duration(milliseconds: 10), () {
      sendBetC02Message(C2Map);
    });

    //Vue代码没走C10订阅，可能有点问题
    //C10，只发普通投注
    List objCd = [];
    marketIds.clear();
    matchIds.clear();
    itemList.clear();
    itemList.addAll(singleBetController.itemList);
    itemList.addAll(mixBetController.itemList);
    itemList.forEach((element) {
      marketIds.add(element.marketId);
      matchIds.add(element.matchId);
      objCd.add({
        'mid': element.marketId,
        'hpid': element.playId,
        'hn': element.placeNum,
      });
    });
    marketIds = marketIds.toSet().toList();
    matchIds = matchIds.toSet().toList();

    Map<String, dynamic> C10Map = {};
    C10Map['hid'] = marketIds.join(',');
    C10Map['mid'] = matchIds.join(',');
    C10Map['marketLevel'] = UserController.to.userInfo.value?.marketLevel ?? 0;
    C10Map['esMarketLevel'] =
        UserController.to.userInfo.value?.esMarketLevel ?? 0;

    C10Map['cd'] = objCd;
    sendBetC10Message(C10Map);
  }

  // 电竞/电竞冠军 / vr
  //目前 AppWebSocket.instance().skt_send_bat_handicap_odds 会判断hid，不能取消订阅，故重写
  sendBetC02Message(Map obj) {
    Map<String, dynamic> cmd_obj = {};
    cmd_obj['cmd'] = WsType.C2;
    cmd_obj['hid'] = obj['hid'];
    cmd_obj['mid'] = obj['mid'];
    cmd_obj['marketLevel'] = obj['marketLevel'];
    cmd_obj['esMarketLevel'] = obj['esMarketLevel'];
    if (cmd_obj['mid'] != "") {
      AppWebSocket.instance().sendMsg(cmd_obj);
    }
  }

  // 常规赛事 / 冠军
  //AppWebSocket中没有 C10
  sendBetC10Message(Map obj) {
    Map<String, dynamic> cmd_obj = {};
    cmd_obj['cmd'] = "C10";
    cmd_obj['hid'] = obj['hid'];
    cmd_obj['mid'] = obj['mid'];
    cmd_obj['marketLevel'] = obj['marketLevel'];
    cmd_obj['esMarketLevel'] = obj['esMarketLevel'];
    // 需要订阅的数据
    cmd_obj['cd'] = obj['cd'];
    // 是否全局取消订阅
    cmd_obj['cws'] = false;
    // 需求取消订阅的数据
    cmd_obj['cn'] = [];

    // 上次订阅的内容 和当前订阅的内容做对比，当前没有订阅的上次内容需要做 取消订阅处理
    lastC10Cd.forEach((element1) {
      bool exists = false;
      for (Map element2 in obj['cd']) {
        if (element1['mid'] == element2['mid'] &&
            element1['hpid'] == element2['hpid'] &&
            element1['hn'] == element2['hn']) {
          exists = true;
          break;
        }
      }
      if (!exists) {
        cmd_obj['cn'].add(element1);
      }
    });
    //记录此次订阅的内容
    lastC10Cd = cmd_obj['cd'];

    if (cmd_obj['hid'] != "" && cmd_obj['mid'] != "") {
      AppWebSocket.instance().sendMsg(cmd_obj);
    }
  }

  //刷新投注项
  void refreshData(){
    if(currentBetController == mixBetController){
      mixBetController.queryLatestMarketInfo(type:'set_bet');
      Future.delayed(Duration(milliseconds: 3000),(){
        singleBetController.queryLatestMarketInfo(type:'set_bet');
      });
    }else{
      singleBetController.queryLatestMarketInfo(type:'set_bet');
      Future.delayed(Duration(milliseconds: 3000),(){
        mixBetController.queryLatestMarketInfo(type:'set_bet');
      });
    }
  }

  //清除数据
  void clearData(){
    singleBetController.clearData();
    mixBetController.clearData();
    esportSingleBetController.clearData();
    esportMixBetController.clearData();
    vrSingleBetController.clearData();
    vrMixBetController.clearData();
  }
}
