import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_ctr_ws.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_map_operate.dart';
import 'package:flutter_ty_app/app/global/user_controller.dart';
import 'package:flutter_ty_app/app/modules/dj/states/dj_state.dart';
import 'package:flutter_ty_app/app/modules/home/models/section_group_enum.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_controller.dart';
import 'package:flutter_ty_app/app/services/api/dj_data_api.dart';
import 'package:flutter_ty_app/app/services/models/res/dj_date_entity_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/sport_config_info.dart';
import 'package:flutter_ty_app/app/utils/bus/bus.dart';
import 'package:flutter_ty_app/app/utils/bus/event_enum.dart';

class DJController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late String globalRequestSessionKey;

  static DJController get to => Get.put(DJController());
  DjState DJState = DjState();

  late PageController pageController;
  StreamSubscription? subscription;

  @override
  void onInit() {
    pageController =
        PageController(initialPage: 0, keepPage: true, viewportFraction: 1);
    Bus.getInstance().on(EventType.changeLang, (value) {
      getDateList();
    });
    // 盘口设置
    Bus.getInstance().on(EventType.changeOddType, (_) {
      update();
    });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    // RCMD_C109

    Bus.getInstance().on(EventType.RCMD_C109, (wsObj) {
      String currentRoute = Get.currentRoute;

      ///进入详情  或者 不是电竞当前页 列表接口需要屏蔽
      if (DataStoreController.to.isEnterDatail == true ||
          currentRoute != Routes.DJView) return;
      Get.log('DJController C109 $currentRoute');
      Get.log('DJController wsObj[0] ${wsObj[0]}');
      var cd = wsObj;
      Get.log('DJController    cd $cd');
      if (cd == null || cd.length < 1) {
        return;
      }
      bool isReq = false;
      cd.forEach((element) {
        var csid = element['csid'];
        Get.log(
            'DJController csid $csid   DJState.djListReq.csid ${DJState.djListReq.csid}');
        if (csid == DJState.djListReq.csid) {
          if (DJState.selectDate?.menuType != 100) {
            //冠军
            isReq = true;
          }
        }
        // isReq = true;
        if (isReq) {
          //赛事新增
          getAddMatch();
        }
      });
    });
    /* subscription = Bus.getInstance().wsReceive<WsType>().listen((event) {
      // Get.log("subscription ${event.type} = ${event.data['cd']}");
      var cd = event.data['cd'];
      if(cd == null || cd.length<1){
      switch (event.type) {
        case WsType.C101:
        case WsType.C102:
        case WsType.C104: //賽事移除
        case WsType.C901:
          var cmec = cd['cmec'];
          var csid = cd['csid'];
          var mid = cd['mid'];
          var mmp = cd['mmp'];
          var mst = cd['mst'];
          var mhs = cd['mhs'];
          var ms = cd['ms'];

          Get.log('DJController csid ${csid}   DJState.djListReq.csid ${ DJState.djListReq.csid} cmd ${event.type}');
          Get.log("赛事移除 = subscription ${event.type} = ${event.data['cd']}");
          if (mhs == 2 || mmp == '999'  || !is_valid_match(ms)) {
            int index = -1;

            if (DJState.djListEntity != null) {
              for (int i = 0; i < DJState.djListEntity!.length; i++) {
                var element = DJState.djListEntity?[i];
                Get.log(
                    'DJController mid = ${mid} element.mid = ${element?.mid}');
                if (element?.mid == mid) {
                  Get.log('DJController element.mid = ${element?.mid}');
                  index = i;
                }
              }
              if (index != -1) {
                DJState.djListEntity?.removeAt(index);
              }
              update();
            }
          }

          break;
        case WsType.C114:
        case WsType.C303:
          //电竞不需要
          //mid接口
          var mid = cd['mid'].toString();
          List<String> mids = mid.split(',');
          for (int j = 0; j < mids.length; j++) {
            var time = event.type == WsType.C303 ? 3000 : 2000;
          }
          break;
        default:
          break;
      }
      }
    });*/
    getDateList();
  }

  @override
  void onClose() {
    pageController.dispose();
    DataStoreController.to.pageKey = otherPageKey;
    Bus.getInstance().off(EventType.changeOddType);

    ShopCartController.to.changeDjMenu(changeGame: true);
    super.onClose();
  }

  void getDateList() {
    DJController.to.DJState.collopList.clear();
    DJState.isLoading = true;
    doudi();
    update();

    var id;
    if (!isCollect()) {
      //收藏特殊處理
      id = (DJState.gameId.toNum() ?? 0) - 2000;
      DJState.djListReq.csid = id.toString();
    }

    DjDataApi.instance()
        .getDateMenuList(DJState.djListReq.csid.toString())
        .then((value) {
      DJState.djDateEntity = value.data;
      DJState.selectDate = DJState.djDateEntity?.first;
      getDifferentParams(DJState.selectDate!);

      globalRequestSessionKey =
          DJState.djListReq.getRequestSessionKey(isCollect());
      if (isCollect()) {
        //收藏特殊處理
        getCollectList();
      } else {
        getListData();
      }
      update();
    });
  }

  void getListData() {

    String currentRequestSessionKey =
    DJState.djListReq.getRequestSessionKey(isCollect());
    DjDataApi.instance()
        .esportsMatches(
            // '1','100','240640629535469568','41002','0','','2','3000'
            DJState.djListReq.category.toString(),
            DJState.djListReq.csid,
            UserController.to.getUid(),
            DJState.djListReq.euid,
            '0',
            DJState.djListReq.md.toString(),
            '2',
            '3000')
        .then((value) {
      Get.log("${globalRequestSessionKey == currentRequestSessionKey} globalRequestSessionKey =2  $globalRequestSessionKey   currentRequestSessionKey = $currentRequestSessionKey");
      if (globalRequestSessionKey != currentRequestSessionKey) {
        return;
      }

      DJState.djListEntity = value.data;

      ///电竞数据插入前 先锁住
      DataStoreController.to.pageKey = djPageKey;
      DataStoreController.to.injecthowMatchIdListByMatchEntity(
          DJState.djListEntity ?? [],
          pageRouteKey: djPageKey);
      DJState.djListEntity?.forEach((matchEntity) {
        DataStoreController.to.injectMatch(matchEntity);
        matchEntity.hps.forEach((hps) {
          List<MatchHpsHl> hls = hps.hl;
          for (MatchHpsHl hl in hls) {
            DataStoreController.to.updateHl(hl);
            List<MatchHpsHlOl> ols = hl.ol;
            for (MatchHpsHlOl ol in ols) {
              DataStoreController.to.updateOl(ol);
            }
          }
        });
      });
      DJState.isLoading = false;
      update();
    });
  }

  void getCollectList() {

    String currentRequestSessionKey =
    DJState.djListReq.getRequestSessionKey(isCollect());
    List<SportConfigInfo> list = ConfigController.to.gameMenuList;
    var csid = '';
    var euid = '';
    list.forEach((element) {
      if (csid == '') {
        csid = ((element.mi.toNum() ?? 0) - 2000).toString();
        euid = ConfigController.to.getDjEuid(element.mi).toString();
      } else {
        csid += ',${((element.mi.toNum() ?? 0) - 2000).toString()}';
        euid += ',${ConfigController.to.getDjEuid(element.mi).toString()}';
      }
    });
    DjDataApi.instance()
        .collection(
            //{
            //   "collect": 1
            //   "csid": "100,101,103,102",
            //   "cuid": "509825984426120034",
            //   "euid": "41002,41001,41003,41004",
            //   "hpsFlag": 0,
            //   "md": "0",
            //   "sort": 1,
            //   "type": 3000,
            //   "device": "v2_h5_st",//
            // }
            1,
            csid,
            UserController.to.getUid(),
            euid,
            '0',
            DJState.djListReq.md.toString(),
            '1',
            '3000')
        .then((value) {
      Get.log("${globalRequestSessionKey == currentRequestSessionKey} globalRequestSessionKey =2  $globalRequestSessionKey   currentRequestSessionKey = $currentRequestSessionKey");
      if (globalRequestSessionKey != currentRequestSessionKey) {
        return;
      }
      DJState.djListEntity = value.data;

      DJState.isLoading = false;
      update();
    });
  }

  void getAddMatch() {
    Get.log("DJ = matchesPB getAddMatch");
    DjDataApi.instance()
        .matchesPB(
      DJState.djListReq.category.toString(),
      DJState.djListReq.cuid,
      DJState.djListReq.euid,
      DJState.djListReq.hpsFlag.toString(),
      DJState.djListReq.md.toString(),
      DJState.djListReq.sort.toString(),
      DJState.djListReq.type.toString(),
    )
        .then((value) {
      Get.log("DJ = matchesPB getAddMatch $value");
      if(value.data == null){
        return;
      }
      DJState.djListEntity?.addAll(value.data as Iterable<MatchEntity>);
      Get.log("DJ = matchesPB callback = $value");
    });
  }

  isCollop(matchEntity, SectionGroupEnum sectionGroupEnum) {
    String tid = matchEntity.tid;
    return DJController.to.DJState.collopList
        .contains("${tid}_${sectionGroupEnum.index}");
  }

  clickCollop(clickValue, matchEntity, SectionGroupEnum sectionGroupEnum) {
    matchEntity.isExpand = clickValue;
    var key = "${matchEntity?.tid}_${sectionGroupEnum.index}";
    if (clickValue) {
      DJController.to.DJState.collopList.remove(key);
    } else {
      if (!DJController.to.DJState.collopList.contains(key)) {
        DJController.to.DJState.collopList.add(key);
      }
    }
    // Get.log(
    //     'DJController.to.DJState.collopList = ${DJController.to.DJState.collopList}');
    DJController.to.update();
  }

  bool isCollect() {
    return DJState.gameId == "50000";
  }

  bool isGuanjun() {
    return DJState.selectDate?.menuType == 100;
  }

  bool is_valid_match(ms) {
    return [0, 1, 2, 7, 10, 110].contains(ms); //有效状态包括未开赛与进行中
  }

  bool isClose(MatchEntity match) {
    bool isClose = MatchDataBaseWS.closeMatch(
        mhs: match.mhs, mmp: match.mmp, ms: match.ms);
    var ms = match.ms;

    ///ms 关盘状态
    List closeMsState = [3, 4, 5, 6, 7, 8, 9];
    bool closeForMs = (ms != null && closeMsState.contains(ms));

    return isClose || closeForMs;
  }

  List<SportConfigInfo> getMenuData() {
    return isGuanjun()
        ? ConfigController.to.gameMenuList
        : ConfigController.to.getGameMenuListByMenuId();
    // Get.log("WW = ${sportMenuList.value}");
  }

  void doudi() {

    12.seconds.delay((){
      if(
      DJState.isLoading == true){
        DJState.isLoading = false;
        update();
      }
    });
  }
}

extension DJControllerExtension on DJController {
  void changeTime(DjDateEntityEntity date) {
    DJState.selectDate = date;
    DJState.isLoading = true;
    doudi();
    update();
    getDifferentParams(date);

    globalRequestSessionKey =
        DJState.djListReq.getRequestSessionKey(isCollect());
    if (isCollect() && !isGuanjun()) {
      //收藏特殊處理
      getCollectList();
    } else {
      getListData();
    }

    // getListData();

    ShopCartController.to.changeDjMenu();
  }

  void changeGame(csid, euid) {
    DJState.djListEntity?.clear();
    update();
    if (!isCollect()) {
      DJState.djListReq.csid = csid.toString();
      DJState.djListReq.euid = euid.toString();
    }
    getDateList();

    ShopCartController.to.changeDjMenu(changeGame: true);
  }

  // void changeNew(bool value) {
  //   DJState.isNew = value;
  //   update();
  //   // getListData();
  // }

  // void changeHot(bool value) {
  //   DJState.isHot = value;
  //   update();
  // }

  // void changeSport(SportEntity sportEntity) {
  //   DJState.currentSport = sportEntity;
  //   update();
  // }
  getDifferentParams(DjDateEntityEntity date) {
    if (isGuanjun()) {
      //冠军
      DJState.djListReq.md = '';
      DJState.djListReq.category = 2;
    } else {
      DJState.djListReq.md = date.field1;
      DJState.djListReq.category = 1;
    }
  }
}
