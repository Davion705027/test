// import 'package:flutter_ty_app/app/global/data_store_operate/data_store_bus.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_ctr_ws.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/utils/bus/bus.dart';
import 'package:flutter_ty_app/app/utils/bus/event_enum.dart';

const String MATCH_ID = 'matchId_';
const String HID = 'hid_';
const String OID = 'oid_';

const djPageKey = 'Esports_key';
const otherPageKey = 'other_key';
String getMatchId(String mid) {
  return MATCH_ID + mid;
}

String getHid(String hid) {
  return HID + hid;
}

String getOid(String oid) {
  return OID + oid;
}

class DataStoreController extends GetxController {
  static DataStoreController get to =>
      Get.put(DataStoreController(), permanent: true);

  ///赛事模型
  Map<String, MatchEntity> matchMap = <String, MatchEntity>{};

  ///可视化赛事模型
  List<String> showMatchIdList = [];

  ///进入电竞后需要锁住 避免收到其他接口插入数据
  String pageKey = otherPageKey;

  ///进入详情标识  (C101 C105 C109 C112 C302 C303 )
  bool isEnterDatail = false;
  ///盘口列表模型
  Map<String, MatchHpsHl> hlMap = <String, MatchHpsHl>{};

  ///盘口模型
  Map<String, MatchHpsHlOl> olMap = <String, MatchHpsHlOl>{};

  @override
  onInit() {
    super.onInit();
    Bus.getInstance().on(EventType.changeLang, (value) {
      DataStoreController.to.matchMap.clear();
      DataStoreController.to.olMap.clear();
      DataStoreController.to.hlMap.clear();
    });
  }







  List<String> midsAtion = [];
  List matchList = [];
  Map<String, dynamic> listToObj = {
    'ol_obj': {},
    'hl_obj': {},
    'hn_obj': {},
    'mid_obj': {},
  };
  List<String> matchUpdTimeKeys = [
    'mst',
    'mc',
    'mf',
    'mct',
    'ms',
    'mhs',
    'mess',
    'mmp',
    'mms',
    'mat',
    'mvs',
    'tf',
    'msc',
  ];

  Map<String, int> otherPlayNameToPlayId = {
    // 晋级赛
    'hpsPromotion': 1005,
    // 冠军
    'hpsOutright': 1006,
    // 角球
    'hpsCorner': 1001,
    // 5分钟玩法
    // 'hps5Minutes': 1009,
    // 15分钟玩法
    'hps15Minutes': 1007,
    // 波胆
    'hpsBold': 1008,
    // 特色组合
    'hpsCompose': 1010,
    // 罚牌
    'hpsPunish': 1003,
    // 加时赛
    'hpsOvertime': 1002,
    // 点球大战
    'hpsPenalty': 1004,
  };
  Map<String, dynamic> cache = {};
  Map<String, dynamic> cacheMatch = {
    '23432234': {'mmp': 111111111111, 'ms': 222222222},
  };
  Map<String, dynamic> wsMatchKeyUpdTimeCache = {
    '23432234': {'mmp': 111111111, 'ms': 22222222},
  };
  Map<String, dynamic> dataVersion = {'version': '123'};
  Map<String, dynamic> cacheOid = {};

  String type = '';
  Map params = {};
  String nameCode = '';
  Map str = {'a': '123131'};

  void initObj() {
    ///注册消息中心
    MatchDataBaseWS().initBus();

    /// 方法：    set_list(match_list,config)
    ///处于激活的赛事mids数组
    midsAtion = [];
    matchList = [];

    /// 所有赛事列表数据转obj对象
    listToObj = {
      /// 页面显示赛事投注项对象
      'ol_obj': {},

      /// 页面显示赛事盘口对象
      'hl_obj': {},

      /// 页面显示赛事坑位对象
      'hn_obj': {},

      /// 页面显示赛事赛事对象
      'mid_obj': {},
    };

    /// 赛事基本信息需要同步的时间
    matchUpdTimeKeys = [
      'mst',
      'mc',
      'mf',
      'mct',
      'ms',
      'mhs',
      'mess',
      'mmp',
      'mms',
      'mat',
      'mvs',
      'tf',
      'msc'
    ];

    /// mst: 赛事进行时间
    /// mc: 赛事玩法总数
    /// mf: 赛事是否收藏
    /// mct: 当前是第几盘或者第几局
    /// ms: 赛事状态 0 赛事未开始 1 进行中 2暂停 3结束 4关闭 5取消 6 放弃 7延迟 8未知  9延期 10中断
    /// mhs: 赛事玩法状态
    /// mess: mess 开始结束状态 1、start 0、stop（此字段只适用于特定事件编码）篮球暂停事件编码=time_start
    /// mmp: 比赛阶段
    /// mms: 视频状态  0:不可用 1:可用，暂未播放 2：可用，播放中''',
    /// mat: 发球方  home 主队 away 客队
    /// mvs: 动画状态  0:不可用 1:可用，暂未播放 2：可用，播放中',
    /// tf: 联赛是否收藏
    /// msc: 比分

    /// 所有临时变量信息
    cache = {
      /// 赛事折叠状态
      /// 联赛折叠状态
    };

    /// 所有赛事基础信息动态数据时间更新
    cacheMatch = {
      '23432234': {'mmp': 111111111111, 'ms': 222222222}
    };

    /// ws赛事属性key数据更新时间
    wsMatchKeyUpdTimeCache = {
      '23432234': {'mmp': 111111111, 'ms': 22222222}
    };

    /// 数据版本更新参数
    dataVersion = {'version': '123'};

    /// 所有投注项动态数据时间更新
    cacheOid = {};
  }
}
