import 'dart:convert';

import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/user_info.g.dart';

export 'package:flutter_ty_app/generated/json/user_info.g.dart';

@JsonSerializable()
class UserInfo {
  late String activityId = '';
  late List<UserInfoActivityList> activityList = [];
  late String addition2 = '';
  late String callbackUrl = '';
  late int chatRoomSwitch = 0;
  UserInfoConfigVO? configVO;
  late int cp = 0;
  UserInfoCvo? cvo;
  late int esMarketLevel = 0;
  late bool favoriteButton = false;
  late String filterLeague = '';
  late String filterSport = '';
  late String frontVersion = '';
  late String gr = '';
  late int h5BannerSwitch = 0;
  late String h5FrontVersion = '';
  late String h5VerSysSwitch = '';
  late String h5VersionSwitch = '';
  late bool inActivity = false;
  late bool isNewUser = false;
  late int isTestMerchant = 0;
  late String isVideo = '';
  late String jumpfrom = '';
  late String jumpsupport = '';
  late String languageList = '';
  late String languageName = '';
  late String languageSwitch = '';
  late String languageSystemSwitch = '';
  late String languages = '';
  late String loginUrl = '';
  late String mId = '';
  dynamic maintainTime;
  late bool maintaining = false;
  late String maintainingContent = '';
  late String maintainingH5Url = '';
  late String maintainingPCUrl = '';
  late String maintainingTime = '';
  late String maintainingTitle = '';
  late int marketLevel = 0;
  dynamic matchId;
  late UserInfoMerchantEventSwitchVO merchantEventSwitchVO;
  late String nickName = '';
  late int ommv = 0;
  late int openElectronicBasketball = 1;
  late int openElectronicFootball = 1;
  late int openElectronicTy = 0;
  late int openEsport = 1;
  late int openVrSport = 1;
  late UserInfoOss oss;
  late String pcVerSysSwitch = '';
  late String pcVersionSwitch = '';
  late UserInfoPca pca;
  late int pcs = 0;
  late int pullMsgRate = 0;
  late int settleSwitch = 0;
  late int settleSwitchBasket = 0;
  UserInfoSettleSwitchVO? settleSwitchVO ;
  late int sort = 1;
  dynamic sportId;
  late String stm = '';
  dynamic storeFlag;
  dynamic tournamentId;
  late int userBetPrefer = 0;
  late String userId = '';
  late String userMarketPrefer = '';
  late String userName = '';
  late UserInfoVideoManageVo videoManageVo;
  late int zr = 0;

  UserInfo();

  factory UserInfo.init() {
    UserInfo userInfo = UserInfo();
    userInfo.configVO = UserInfoConfigVO();
    userInfo.cvo = UserInfoCvo();
    userInfo.cvo?.series = UserInfoCvoSeries();
    return userInfo;
  }

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      $UserInfoFromJson(json);

  Map<String, dynamic> toJson() => $UserInfoToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class UserInfoActivityList {
  late String activityId = '';
  dynamic endTime;
  late String h5Url = '';
  late String id = '';
  late String inEndTime = '';
  late String inStartTime = '';
  dynamic maintainStatus;
  late String name = '';
  late String pcUrl = '';
  late int period = 0;
  dynamic startTime;
  late int status = 0;
  late int type = 0;

  UserInfoActivityList();

  factory UserInfoActivityList.fromJson(Map<String, dynamic> json) =>
      $UserInfoActivityListFromJson(json);

  Map<String, dynamic> toJson() => $UserInfoActivityListToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class UserInfoConfigVO {
  late int appDefault = 0;
  late String bannerUrl = '';
  late int bookBet = 0;
  late int bookMarketSwitch = 0;
  late int bookMarketSwitchBasketball = 0;
  late String compatLogoUrl = '';
  late Map<String, dynamic> configMap = {};
  late String filterLeague = '';
  late String filterSport = '';
  late int h5Default = 0;
  dynamic inlineWidth;
  late String leagueLogoUrl = '';
  late String loadLogoUrl = '';
  late String marketConfigKey = '';
  late int marketConfigValue = 0;
  late int marketDefault = 0;
  late int maxSeriesNum = 0;
  late int minSeriesNum = 0;
  late int nociceTag = 0;
  late String pcLogoUrl = '';
  late int profesTag = 0;
  late int standardTag = 0;
  late String title = '';
  UserInfoConfigVOTitleMap? titleMap;
  late String videoLogoUrl = '';

  UserInfoConfigVO();

  factory UserInfoConfigVO.fromJson(Map<String, dynamic> json) =>
      $UserInfoConfigVOFromJson(json);

  Map<String, dynamic> toJson() => $UserInfoConfigVOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class UserInfoConfigVOTitleMap {
  late String hy = '';
  late String tw = '';
  late String vi = '';
  late String ad = '';
  late String th = '';
  late String pty = '';
  late String ms = '';
  late String md = '';
  late String en = '';
  late String zh = '';

  UserInfoConfigVOTitleMap();

  factory UserInfoConfigVOTitleMap.fromJson(Map<String, dynamic> json) =>
      $UserInfoConfigVOTitleMapFromJson(json);

  Map<String, dynamic> toJson() => $UserInfoConfigVOTitleMapToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class UserInfoCvo {
  UserInfoCvoSeries? series;
  UserInfoCvoSingle? single;

  UserInfoCvo();

  factory UserInfoCvo.fromJson(Map<String, dynamic> json) =>
      $UserInfoCvoFromJson(json);

  Map<String, dynamic> toJson() => $UserInfoCvoToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class UserInfoCvoSeries {
  late String code = '';
  late int min = 10;
  late int qfi = 10;
  late int qfo = 20;
  late int qon = 30;
  late int qsi = 40;
  late int qth = 50;
  late int qtw = 60;

  UserInfoCvoSeries();

  factory UserInfoCvoSeries.fromJson(Map<String, dynamic> json) =>
      $UserInfoCvoSeriesFromJson(json);

  Map<String, dynamic> toJson() => $UserInfoCvoSeriesToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class UserInfoCvoSingle {
  late String code = '';
  late int min = 10;
  late int qfi = 10;
  late int qfo = 20;
  late int qon = 30;
  late int qth = 40;
  late int qtw = 50;

  UserInfoCvoSingle();

  factory UserInfoCvoSingle.fromJson(Map<String, dynamic> json) =>
      $UserInfoCvoSingleFromJson(json);

  Map<String, dynamic> toJson() => $UserInfoCvoSingleToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class UserInfoMerchantEventSwitchVO {
  late String configKey = '';
  late String configValue = '';
  late int cornerEvent = 0;
  late int eventSwitch = 0;
  late int penaltyEvent = 0;

  UserInfoMerchantEventSwitchVO();

  factory UserInfoMerchantEventSwitchVO.fromJson(Map<String, dynamic> json) =>
      $UserInfoMerchantEventSwitchVOFromJson(json);

  Map<String, dynamic> toJson() => $UserInfoMerchantEventSwitchVOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class UserInfoOss {
  late List<String> api = [];
  late List<String> chatroomHttpUrl = [];
  late List<String> chatroomUrl = [];
  late List<String> img = [];
  @JSONField(name: "live_h5")
  late String liveH5 = '';
  @JSONField(name: "live_pc")
  late String livePc = '';
  late String loginUrl = '';
  late List<String> loginUrlArr = [];

  UserInfoOss();

  factory UserInfoOss.fromJson(Map<String, dynamic> json) =>
      $UserInfoOssFromJson(json);

  Map<String, dynamic> toJson() => $UserInfoOssToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class UserInfoPca {
  late int pcam = 0;
  late int pcap = 0;
  late String pcms = '';
  late String pcps = '';

  UserInfoPca();

  factory UserInfoPca.fromJson(Map<String, dynamic> json) =>
      $UserInfoPcaFromJson(json);

  Map<String, dynamic> toJson() => $UserInfoPcaToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class UserInfoVideoManageVo {
  late int closedWithoutOperation = 0;
  late String configKey = '';
  late String configValue = '';
  dynamic customViewTime;
  late String merchantCode = '';
  late int noBackgroundPlay = 0;
  late int videoSettings = 0;
  late int videoSwitch = 0;
  dynamic viewingTime;

  UserInfoVideoManageVo();

  factory UserInfoVideoManageVo.fromJson(Map<String, dynamic> json) =>
      $UserInfoVideoManageVoFromJson(json);

  Map<String, dynamic> toJson() => $UserInfoVideoManageVoToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
@JsonSerializable()
class UserInfoSettleSwitchVO {
  late int bookedSettleSwitchBasketball;
  late int bookedSettleSwitchFootball;
  late int partSettleSwitchBasketball;
  late int partSettleSwitchFootball;
  late int settleSwitch = 0;
  late int settleSwitchBasket = 0;
  late int sysBookedSettleSwitch;
  late int sysPartSettleSwitch;

  UserInfoSettleSwitchVO();

  factory UserInfoSettleSwitchVO.fromJson(Map<String, dynamic> json) => $UserInfoSettleSwitchVOFromJson(json);

  Map<String, dynamic> toJson() => $UserInfoSettleSwitchVOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
