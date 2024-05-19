import 'dart:convert';

import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/match_entity.g.dart';

import '../../../modules/match_detail/models/bet_item_collection.dart';

export 'package:flutter_ty_app/generated/json/match_entity.g.dart';

@JsonSerializable()
class MatchEntity {
  late String mcid = '';
  late String tnjc = '';
  late List<MatchHps> hpsBold = [];
  late String csna = '';
  late String tid = '';
  late String mst = '';
  late String srid = '';
  late int mcg = 0;
  late bool cosCorner = false;
  late String atf = '';
  late bool cosPunish = false;
  late bool cosOutright = false;
  late String mdsc = '';
  late int gcs = 0;
  late int mc = 0;
  late List<MatchHps> hpsOvertime = [];
  late bool mf = false; // 赛事是否收藏
  late String mgt = '';
  late String maid = '';
  late int mct = 0;
  late int tlev = 0;
  late String mhlut = '';
  late int mo = 0;
  late int ctt = 0;
  late int mp = 0;
  late String csid = '';
  dynamic pmms;

  /// 0、赛事未开始 1、滚球阶段 2、暂停 3、结束 4、关闭 5、取消 6、比赛放弃 7、延迟 8、未知 9、延期 10、比赛中断   ms=110时:显示即将开赛
  late int ms = 0;
  late String cmec = '';
  late bool cos5Minutes = false;
  late int mle = 0;
  late int lvs = 0;
  late int sort = 0;

  // 目前发现的 VR 体育内部是返回字符串类型，所以改用 dynamic
  // 使用的时候注意区分自己的业务逻辑
  dynamic malu;
  late List<MatchHps> hps15Minutes = [];
  late String lurl = '';
  late String mprmc = '';
  late bool cosOvertime = false;
  late String mhn = '';
  late String betAmount = '';
  late String cds = '';

  // 目前发现的 VR 体育内部是返回字符串类型，所以改用 dynamic
  // 使用的时候注意区分自己的业务逻辑
  dynamic frmhn;
  late bool compose = false;
  late int operationTournamentSort = 0;
  late bool cos15Minutes = false;
  late int mhs = 0; // 全部玩法 能不投注
  late String mlet = '';
  late List<MatchHps> hps5Minutes = [];
  late bool cosPenalty = false;
  late List<MatchHps> hpsCorner = [];
  late String mhid = '';
  late List<MatchHps> hpsPunish = [];
  late String mrmc = '';
  late String mid = '';
  late int mess = 0;
  late bool cosBold = false;
  dynamic lss;
  late String mmp = '';
  late String mststi = '';
  late int mms = 0;
  late int mbmty = 0;
  late int regionIdSort = 0;

  // 目前发现的 VR 体育内部是返回字符串类型，所以改用 dynamic
  // 使用的时候注意区分自己的业务逻辑
  dynamic mhlu;
  late String seid = '';
  late String mstst = '';
  late String malut = '';
  late String man = '';

  // 目前发现的 VR 体育内部是返回字符串类型，所以改用 dynamic
  // 使用的时候注意区分自己的业务逻辑
  dynamic frman;
  late String mat = '';
  late int mng = 0;
  late String mststr = '';
  late List<MatchHps> hps = [];
  late List<MatchHps> hpsCompose = [];
  late int mvs = -1;
  late List<MatchHps> hpsPenalty = [];
  late int mststs = 0;
  late int mearlys = 0;
  late bool tf = false; // 联赛是否收藏
  late int th = 0;
  late bool cosPromotion = false;
  dynamic mfo;
  late int mft = 0;
  late String tn = '';
  late List<String> msc = []; // s11 红 s12 黄牌 红 黄牌 没有不显示（目前不显示）
  late List<MatchHps> hpsPromotion = [];
  late List<MatchHps> hpsOutright = []; //冠军数据
  late String seoy = '';
  late String onTn = '';
  late String med = '';

  late String mbkn = '';
  late String mbhn = '';
  late String mbcn = '';

  // VR 体育内部新增 teams
  late List<String> teams = [];

  /// 电竞详情
  late String vurl = '';
  late String varl = '';

  late int ispo = 0;

  /// 棒球 一垒二垒三垒
  late String mbtlp = '';
  late String mbolp = '';
  late String mbthlp = '';

  late String lod = '';
  late String batchNo = '';

  MatchEntity();

  @JSONField(serialize: false, deserialize: false)
  bool isCollection = false;
  @JSONField(serialize: false, deserialize: false)
  bool isExpand = true;
  @JSONField(serialize: false, deserialize: false)
  int startFlag = 0;

  @JSONField(serialize: false, deserialize: false)
  int homeRedScore = 0; // 主队红牌
  @JSONField(serialize: false, deserialize: false)
  int awayRedScore = 0; // 客队红牌
  @JSONField(serialize: false, deserialize: false)
  int homeYellowScore = 0; // 主队黄牌
  @JSONField(serialize: false, deserialize: false)
  int awayYellowScore = 0; // 客队黄牌
  @JSONField(serialize: false, deserialize: false)
  List<String> mscListDict = [];
  @JSONField(serialize: true, deserialize: true)
  String homeScore = "0";
  @JSONField(serialize: true, deserialize: true)
  String awayScore = "0";
  @JSONField(serialize: false, deserialize: false)
  List<List<String>> mscFormat = [];
  @JSONField(serialize: false, deserialize: false)
  List<List<String>> mscSFormat = [];

  factory MatchEntity.fromJson(Map<String, dynamic> json) =>
      $MatchEntityFromJson(json);

  Map<String, dynamic> toJson() => $MatchEntityToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MatchEntity &&
          runtimeType == other.runtimeType &&
          mid == other.mid;

  @override
  int get hashCode => mid.hashCode;

  @override
  String toString() {
    return jsonEncode(this);
  }
}

// ouzhou-h5-sport-play-config
@JsonSerializable()
class MatchHps {
  late String mid = '';
  late String chpid = ''; // 1,17 全场独赢(3项盘）
  late String hpid = '';
  late int hpon = 0;

  /// Yes No
  late String hshow = '';

  late String hSpecial = '0';

  /// 全场大小
  late String hpn = '';
  late String topKey = '';
  late String hps = '';
  late dynamic jno = '';
  late String hlid = '';

  /// 置顶
  late String hton = '';
  late String hpnb = '';
  late int hpt = 0;

  ///1,2,3,4
  late String hsw = '';
  late int hmm = 0;
  late int hids = 0;
  late List<MatchHpsHl> hl = [];

  /// 冠军
  late String hid = '';
  late int hpono = 0;
  late int hs = 0; // 1 控制一列
  dynamic hv;
  late int hmt = 0;
  late int hn = 0;
  late String hmed = '';
  late String hmgt = '';
  late List<MatchHpsHlOl> ol = [];

  /// 详情
  /// 可能为空。也可能为[[obj]] 或者 [obj]嵌套
  @JSONField(deserialize: false)
  late List<dynamic>? title = [];

  @JSONField(serialize: false, deserialize: false)
  int index = 0; // 记录原始Index 用于取消置顶

  @JSONField(serialize: false, deserialize: false)
  List<BetItemCollection> collection = [];
  @JSONField(serialize: false, deserialize: false)
  List<BetItemCollection> otherCollection = [];

  MatchHps();

  factory MatchHps.fromJson(Map<String, dynamic> json) =>
      $MatchHpsFromJson(json);

  Map<String, dynamic> toJson() => $MatchHpsToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MatchHps &&
        other.hpid == hpid &&
        other.chpid == chpid &&
        other.topKey == topKey;
  }

  @override
  int get hashCode => hpid.hashCode + chpid.hashCode + topKey.hashCode;
}

@JsonSerializable()
class MatchHpsHl {
  late String hid = '';
  late int hs = 0;
  String? hv;
  late int hmt = 0;
  int? hn;
  String? hon;
  String? ad2;
  String? ad1;
  late int hipo = 0;

  late List<MatchHpsTitle> title = [];
  late List<MatchHpsHlOl> ol = [];

  MatchHpsHl();

  factory MatchHpsHl.fromJson(Map<String, dynamic> json) =>
      $MatchHpsHlFromJson(json);

  Map<String, dynamic> toJson() => $MatchHpsHlToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class MatchHpsHlOl {
  late String oid = '';
  late int os = 1; // 1开盘 非1关闭 投注项状态 投注项状态
  late int otd = 0;
  late String ot = '';
  late int ov = 0; // 赔率
  late String on = ''; // 玩法名称 主胜 没有的话显示onb
  late String onb = ''; // 玩法名称 主胜
  late String onbl = ''; //1007 玩法名称 主胜
  late String cds = '';
  late String ots = '';
  late String otv = '';
  late int obv = 0;
  late String ott = '';
  late int oddSort = 0;

  /// 赛果
  int? result;

  /// vr 体育热门
  late String teamId = '';
  late String otn = '';
  late String osid = '';
  late String hpid = '';

  /// 详情里更新的ol，添加此字段
  bool? isDetail;

  MatchHpsHlOl();

  factory MatchHpsHlOl.fromJson(Map<String, dynamic> json) =>
      $MatchHpsHlOlFromJson(json);

  Map<String, dynamic> toJson() => $MatchHpsHlOlToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class MatchHpsTitle {
  late String osn;
  late int otd;

  MatchHpsTitle();

  factory MatchHpsTitle.fromJson(Map<String, dynamic> json) =>
      $MatchHpsTitleFromJson(json);

  Map<String, dynamic> toJson() => $MatchHpsTitleToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
