import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/user_info.dart';

UserInfo $UserInfoFromJson(Map<String, dynamic> json) {
  final UserInfo userInfo = UserInfo();
  final String? activityId = jsonConvert.convert<String>(json['activityId']);
  if (activityId != null) {
    userInfo.activityId = activityId;
  }
  final List<
      UserInfoActivityList>? activityList = (json['activityList'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<UserInfoActivityList>(e) as UserInfoActivityList)
      .toList();
  if (activityList != null) {
    userInfo.activityList = activityList;
  }
  final String? addition2 = jsonConvert.convert<String>(json['addition2']);
  if (addition2 != null) {
    userInfo.addition2 = addition2;
  }
  final String? callbackUrl = jsonConvert.convert<String>(json['callbackUrl']);
  if (callbackUrl != null) {
    userInfo.callbackUrl = callbackUrl;
  }
  final int? chatRoomSwitch = jsonConvert.convert<int>(json['chatRoomSwitch']);
  if (chatRoomSwitch != null) {
    userInfo.chatRoomSwitch = chatRoomSwitch;
  }
  final UserInfoConfigVO? configVO = jsonConvert.convert<UserInfoConfigVO>(
      json['configVO']);
  if (configVO != null) {
    userInfo.configVO = configVO;
  }
  final int? cp = jsonConvert.convert<int>(json['cp']);
  if (cp != null) {
    userInfo.cp = cp;
  }
  final UserInfoCvo? cvo = jsonConvert.convert<UserInfoCvo>(json['cvo']);
  if (cvo != null) {
    userInfo.cvo = cvo;
  }
  final int? esMarketLevel = jsonConvert.convert<int>(json['esMarketLevel']);
  if (esMarketLevel != null) {
    userInfo.esMarketLevel = esMarketLevel;
  }
  final bool? favoriteButton = jsonConvert.convert<bool>(
      json['favoriteButton']);
  if (favoriteButton != null) {
    userInfo.favoriteButton = favoriteButton;
  }
  final String? filterLeague = jsonConvert.convert<String>(
      json['filterLeague']);
  if (filterLeague != null) {
    userInfo.filterLeague = filterLeague;
  }
  final String? filterSport = jsonConvert.convert<String>(json['filterSport']);
  if (filterSport != null) {
    userInfo.filterSport = filterSport;
  }
  final String? frontVersion = jsonConvert.convert<String>(
      json['frontVersion']);
  if (frontVersion != null) {
    userInfo.frontVersion = frontVersion;
  }
  final String? gr = jsonConvert.convert<String>(json['gr']);
  if (gr != null) {
    userInfo.gr = gr;
  }
  final int? h5BannerSwitch = jsonConvert.convert<int>(json['h5BannerSwitch']);
  if (h5BannerSwitch != null) {
    userInfo.h5BannerSwitch = h5BannerSwitch;
  }
  final String? h5FrontVersion = jsonConvert.convert<String>(
      json['h5FrontVersion']);
  if (h5FrontVersion != null) {
    userInfo.h5FrontVersion = h5FrontVersion;
  }
  final String? h5VerSysSwitch = jsonConvert.convert<String>(
      json['h5VerSysSwitch']);
  if (h5VerSysSwitch != null) {
    userInfo.h5VerSysSwitch = h5VerSysSwitch;
  }
  final String? h5VersionSwitch = jsonConvert.convert<String>(
      json['h5VersionSwitch']);
  if (h5VersionSwitch != null) {
    userInfo.h5VersionSwitch = h5VersionSwitch;
  }
  final bool? inActivity = jsonConvert.convert<bool>(json['inActivity']);
  if (inActivity != null) {
    userInfo.inActivity = inActivity;
  }
  final bool? isNewUser = jsonConvert.convert<bool>(json['isNewUser']);
  if (isNewUser != null) {
    userInfo.isNewUser = isNewUser;
  }
  final int? isTestMerchant = jsonConvert.convert<int>(json['isTestMerchant']);
  if (isTestMerchant != null) {
    userInfo.isTestMerchant = isTestMerchant;
  }
  final String? isVideo = jsonConvert.convert<String>(json['isVideo']);
  if (isVideo != null) {
    userInfo.isVideo = isVideo;
  }
  final String? jumpfrom = jsonConvert.convert<String>(json['jumpfrom']);
  if (jumpfrom != null) {
    userInfo.jumpfrom = jumpfrom;
  }
  final String? jumpsupport = jsonConvert.convert<String>(json['jumpsupport']);
  if (jumpsupport != null) {
    userInfo.jumpsupport = jumpsupport;
  }
  final String? languageList = jsonConvert.convert<String>(
      json['languageList']);
  if (languageList != null) {
    userInfo.languageList = languageList;
  }
  final String? languageName = jsonConvert.convert<String>(
      json['languageName']);
  if (languageName != null) {
    userInfo.languageName = languageName;
  }
  final String? languageSwitch = jsonConvert.convert<String>(
      json['languageSwitch']);
  if (languageSwitch != null) {
    userInfo.languageSwitch = languageSwitch;
  }
  final String? languageSystemSwitch = jsonConvert.convert<String>(
      json['languageSystemSwitch']);
  if (languageSystemSwitch != null) {
    userInfo.languageSystemSwitch = languageSystemSwitch;
  }
  final String? languages = jsonConvert.convert<String>(json['languages']);
  if (languages != null) {
    userInfo.languages = languages;
  }
  final String? loginUrl = jsonConvert.convert<String>(json['loginUrl']);
  if (loginUrl != null) {
    userInfo.loginUrl = loginUrl;
  }
  final String? mId = jsonConvert.convert<String>(json['mId']);
  if (mId != null) {
    userInfo.mId = mId;
  }
  final dynamic maintainTime = json['maintainTime'];
  if (maintainTime != null) {
    userInfo.maintainTime = maintainTime;
  }
  final bool? maintaining = jsonConvert.convert<bool>(json['maintaining']);
  if (maintaining != null) {
    userInfo.maintaining = maintaining;
  }
  final String? maintainingContent = jsonConvert.convert<String>(
      json['maintainingContent']);
  if (maintainingContent != null) {
    userInfo.maintainingContent = maintainingContent;
  }
  final String? maintainingH5Url = jsonConvert.convert<String>(
      json['maintainingH5Url']);
  if (maintainingH5Url != null) {
    userInfo.maintainingH5Url = maintainingH5Url;
  }
  final String? maintainingPCUrl = jsonConvert.convert<String>(
      json['maintainingPCUrl']);
  if (maintainingPCUrl != null) {
    userInfo.maintainingPCUrl = maintainingPCUrl;
  }
  final String? maintainingTime = jsonConvert.convert<String>(
      json['maintainingTime']);
  if (maintainingTime != null) {
    userInfo.maintainingTime = maintainingTime;
  }
  final String? maintainingTitle = jsonConvert.convert<String>(
      json['maintainingTitle']);
  if (maintainingTitle != null) {
    userInfo.maintainingTitle = maintainingTitle;
  }
  final int? marketLevel = jsonConvert.convert<int>(json['marketLevel']);
  if (marketLevel != null) {
    userInfo.marketLevel = marketLevel;
  }
  final dynamic matchId = json['matchId'];
  if (matchId != null) {
    userInfo.matchId = matchId;
  }
  final UserInfoMerchantEventSwitchVO? merchantEventSwitchVO = jsonConvert
      .convert<UserInfoMerchantEventSwitchVO>(json['merchantEventSwitchVO']);
  if (merchantEventSwitchVO != null) {
    userInfo.merchantEventSwitchVO = merchantEventSwitchVO;
  }
  final String? nickName = jsonConvert.convert<String>(json['nickName']);
  if (nickName != null) {
    userInfo.nickName = nickName;
  }
  final int? ommv = jsonConvert.convert<int>(json['ommv']);
  if (ommv != null) {
    userInfo.ommv = ommv;
  }
  final int? openElectronicBasketball = jsonConvert.convert<int>(
      json['openElectronicBasketball']);
  if (openElectronicBasketball != null) {
    userInfo.openElectronicBasketball = openElectronicBasketball;
  }
  final int? openElectronicFootball = jsonConvert.convert<int>(
      json['openElectronicFootball']);
  if (openElectronicFootball != null) {
    userInfo.openElectronicFootball = openElectronicFootball;
  }
  final int? openElectronicTy = jsonConvert.convert<int>(
      json['openElectronicTy']);
  if (openElectronicTy != null) {
    userInfo.openElectronicTy = openElectronicTy;
  }
  final int? openEsport = jsonConvert.convert<int>(json['openEsport']);
  if (openEsport != null) {
    userInfo.openEsport = openEsport;
  }
  final int? openVrSport = jsonConvert.convert<int>(json['openVrSport']);
  if (openVrSport != null) {
    userInfo.openVrSport = openVrSport;
  }
  final UserInfoOss? oss = jsonConvert.convert<UserInfoOss>(json['oss']);
  if (oss != null) {
    userInfo.oss = oss;
  }
  final String? pcVerSysSwitch = jsonConvert.convert<String>(
      json['pcVerSysSwitch']);
  if (pcVerSysSwitch != null) {
    userInfo.pcVerSysSwitch = pcVerSysSwitch;
  }
  final String? pcVersionSwitch = jsonConvert.convert<String>(
      json['pcVersionSwitch']);
  if (pcVersionSwitch != null) {
    userInfo.pcVersionSwitch = pcVersionSwitch;
  }
  final UserInfoPca? pca = jsonConvert.convert<UserInfoPca>(json['pca']);
  if (pca != null) {
    userInfo.pca = pca;
  }
  final int? pcs = jsonConvert.convert<int>(json['pcs']);
  if (pcs != null) {
    userInfo.pcs = pcs;
  }
  final int? pullMsgRate = jsonConvert.convert<int>(json['pullMsgRate']);
  if (pullMsgRate != null) {
    userInfo.pullMsgRate = pullMsgRate;
  }
  final int? settleSwitch = jsonConvert.convert<int>(json['settleSwitch']);
  if (settleSwitch != null) {
    userInfo.settleSwitch = settleSwitch;
  }
  final int? settleSwitchBasket = jsonConvert.convert<int>(
      json['settleSwitchBasket']);
  if (settleSwitchBasket != null) {
    userInfo.settleSwitchBasket = settleSwitchBasket;
  }
  final UserInfoSettleSwitchVO? settleSwitchVO = jsonConvert.convert<
      UserInfoSettleSwitchVO>(json['settleSwitchVO']);
  if (settleSwitchVO != null) {
    userInfo.settleSwitchVO = settleSwitchVO;
  }
  final int? sort = jsonConvert.convert<int>(json['sort']);
  if (sort != null) {
    userInfo.sort = sort;
  }
  final dynamic sportId = json['sportId'];
  if (sportId != null) {
    userInfo.sportId = sportId;
  }
  final String? stm = jsonConvert.convert<String>(json['stm']);
  if (stm != null) {
    userInfo.stm = stm;
  }
  final dynamic storeFlag = json['storeFlag'];
  if (storeFlag != null) {
    userInfo.storeFlag = storeFlag;
  }
  final dynamic tournamentId = json['tournamentId'];
  if (tournamentId != null) {
    userInfo.tournamentId = tournamentId;
  }
  final int? userBetPrefer = jsonConvert.convert<int>(json['userBetPrefer']);
  if (userBetPrefer != null) {
    userInfo.userBetPrefer = userBetPrefer;
  }
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    userInfo.userId = userId;
  }
  final String? userMarketPrefer = jsonConvert.convert<String>(
      json['userMarketPrefer']);
  if (userMarketPrefer != null) {
    userInfo.userMarketPrefer = userMarketPrefer;
  }
  final String? userName = jsonConvert.convert<String>(json['userName']);
  if (userName != null) {
    userInfo.userName = userName;
  }
  final UserInfoVideoManageVo? videoManageVo = jsonConvert.convert<
      UserInfoVideoManageVo>(json['videoManageVo']);
  if (videoManageVo != null) {
    userInfo.videoManageVo = videoManageVo;
  }
  final int? zr = jsonConvert.convert<int>(json['zr']);
  if (zr != null) {
    userInfo.zr = zr;
  }
  return userInfo;
}

Map<String, dynamic> $UserInfoToJson(UserInfo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['activityId'] = entity.activityId;
  data['activityList'] = entity.activityList.map((v) => v.toJson()).toList();
  data['addition2'] = entity.addition2;
  data['callbackUrl'] = entity.callbackUrl;
  data['chatRoomSwitch'] = entity.chatRoomSwitch;
  data['configVO'] = entity.configVO?.toJson();
  data['cp'] = entity.cp;
  data['cvo'] = entity.cvo?.toJson();
  data['esMarketLevel'] = entity.esMarketLevel;
  data['favoriteButton'] = entity.favoriteButton;
  data['filterLeague'] = entity.filterLeague;
  data['filterSport'] = entity.filterSport;
  data['frontVersion'] = entity.frontVersion;
  data['gr'] = entity.gr;
  data['h5BannerSwitch'] = entity.h5BannerSwitch;
  data['h5FrontVersion'] = entity.h5FrontVersion;
  data['h5VerSysSwitch'] = entity.h5VerSysSwitch;
  data['h5VersionSwitch'] = entity.h5VersionSwitch;
  data['inActivity'] = entity.inActivity;
  data['isNewUser'] = entity.isNewUser;
  data['isTestMerchant'] = entity.isTestMerchant;
  data['isVideo'] = entity.isVideo;
  data['jumpfrom'] = entity.jumpfrom;
  data['jumpsupport'] = entity.jumpsupport;
  data['languageList'] = entity.languageList;
  data['languageName'] = entity.languageName;
  data['languageSwitch'] = entity.languageSwitch;
  data['languageSystemSwitch'] = entity.languageSystemSwitch;
  data['languages'] = entity.languages;
  data['loginUrl'] = entity.loginUrl;
  data['mId'] = entity.mId;
  data['maintainTime'] = entity.maintainTime;
  data['maintaining'] = entity.maintaining;
  data['maintainingContent'] = entity.maintainingContent;
  data['maintainingH5Url'] = entity.maintainingH5Url;
  data['maintainingPCUrl'] = entity.maintainingPCUrl;
  data['maintainingTime'] = entity.maintainingTime;
  data['maintainingTitle'] = entity.maintainingTitle;
  data['marketLevel'] = entity.marketLevel;
  data['matchId'] = entity.matchId;
  data['merchantEventSwitchVO'] = entity.merchantEventSwitchVO.toJson();
  data['nickName'] = entity.nickName;
  data['ommv'] = entity.ommv;
  data['openElectronicBasketball'] = entity.openElectronicBasketball;
  data['openElectronicFootball'] = entity.openElectronicFootball;
  data['openElectronicTy'] = entity.openElectronicTy;
  data['openEsport'] = entity.openEsport;
  data['openVrSport'] = entity.openVrSport;
  data['oss'] = entity.oss.toJson();
  data['pcVerSysSwitch'] = entity.pcVerSysSwitch;
  data['pcVersionSwitch'] = entity.pcVersionSwitch;
  data['pca'] = entity.pca.toJson();
  data['pcs'] = entity.pcs;
  data['pullMsgRate'] = entity.pullMsgRate;
  data['settleSwitch'] = entity.settleSwitch;
  data['settleSwitchBasket'] = entity.settleSwitchBasket;
  data['settleSwitchVO'] = entity.settleSwitchVO?.toJson();
  data['sort'] = entity.sort;
  data['sportId'] = entity.sportId;
  data['stm'] = entity.stm;
  data['storeFlag'] = entity.storeFlag;
  data['tournamentId'] = entity.tournamentId;
  data['userBetPrefer'] = entity.userBetPrefer;
  data['userId'] = entity.userId;
  data['userMarketPrefer'] = entity.userMarketPrefer;
  data['userName'] = entity.userName;
  data['videoManageVo'] = entity.videoManageVo.toJson();
  data['zr'] = entity.zr;
  return data;
}

extension UserInfoExtension on UserInfo {
  UserInfo copyWith({
    String? activityId,
    List<UserInfoActivityList>? activityList,
    String? addition2,
    String? callbackUrl,
    int? chatRoomSwitch,
    UserInfoConfigVO? configVO,
    int? cp,
    UserInfoCvo? cvo,
    int? esMarketLevel,
    bool? favoriteButton,
    String? filterLeague,
    String? filterSport,
    String? frontVersion,
    String? gr,
    int? h5BannerSwitch,
    String? h5FrontVersion,
    String? h5VerSysSwitch,
    String? h5VersionSwitch,
    bool? inActivity,
    bool? isNewUser,
    int? isTestMerchant,
    String? isVideo,
    String? jumpfrom,
    String? jumpsupport,
    String? languageList,
    String? languageName,
    String? languageSwitch,
    String? languageSystemSwitch,
    String? languages,
    String? loginUrl,
    String? mId,
    dynamic maintainTime,
    bool? maintaining,
    String? maintainingContent,
    String? maintainingH5Url,
    String? maintainingPCUrl,
    String? maintainingTime,
    String? maintainingTitle,
    int? marketLevel,
    dynamic matchId,
    UserInfoMerchantEventSwitchVO? merchantEventSwitchVO,
    String? nickName,
    int? ommv,
    int? openElectronicBasketball,
    int? openElectronicFootball,
    int? openElectronicTy,
    int? openEsport,
    int? openVrSport,
    UserInfoOss? oss,
    String? pcVerSysSwitch,
    String? pcVersionSwitch,
    UserInfoPca? pca,
    int? pcs,
    int? pullMsgRate,
    int? settleSwitch,
    int? settleSwitchBasket,
    UserInfoSettleSwitchVO? settleSwitchVO,
    int? sort,
    dynamic sportId,
    String? stm,
    dynamic storeFlag,
    dynamic tournamentId,
    int? userBetPrefer,
    String? userId,
    String? userMarketPrefer,
    String? userName,
    UserInfoVideoManageVo? videoManageVo,
    int? zr,
  }) {
    return UserInfo()
      ..activityId = activityId ?? this.activityId
      ..activityList = activityList ?? this.activityList
      ..addition2 = addition2 ?? this.addition2
      ..callbackUrl = callbackUrl ?? this.callbackUrl
      ..chatRoomSwitch = chatRoomSwitch ?? this.chatRoomSwitch
      ..configVO = configVO ?? this.configVO
      ..cp = cp ?? this.cp
      ..cvo = cvo ?? this.cvo
      ..esMarketLevel = esMarketLevel ?? this.esMarketLevel
      ..favoriteButton = favoriteButton ?? this.favoriteButton
      ..filterLeague = filterLeague ?? this.filterLeague
      ..filterSport = filterSport ?? this.filterSport
      ..frontVersion = frontVersion ?? this.frontVersion
      ..gr = gr ?? this.gr
      ..h5BannerSwitch = h5BannerSwitch ?? this.h5BannerSwitch
      ..h5FrontVersion = h5FrontVersion ?? this.h5FrontVersion
      ..h5VerSysSwitch = h5VerSysSwitch ?? this.h5VerSysSwitch
      ..h5VersionSwitch = h5VersionSwitch ?? this.h5VersionSwitch
      ..inActivity = inActivity ?? this.inActivity
      ..isNewUser = isNewUser ?? this.isNewUser
      ..isTestMerchant = isTestMerchant ?? this.isTestMerchant
      ..isVideo = isVideo ?? this.isVideo
      ..jumpfrom = jumpfrom ?? this.jumpfrom
      ..jumpsupport = jumpsupport ?? this.jumpsupport
      ..languageList = languageList ?? this.languageList
      ..languageName = languageName ?? this.languageName
      ..languageSwitch = languageSwitch ?? this.languageSwitch
      ..languageSystemSwitch = languageSystemSwitch ?? this.languageSystemSwitch
      ..languages = languages ?? this.languages
      ..loginUrl = loginUrl ?? this.loginUrl
      ..mId = mId ?? this.mId
      ..maintainTime = maintainTime ?? this.maintainTime
      ..maintaining = maintaining ?? this.maintaining
      ..maintainingContent = maintainingContent ?? this.maintainingContent
      ..maintainingH5Url = maintainingH5Url ?? this.maintainingH5Url
      ..maintainingPCUrl = maintainingPCUrl ?? this.maintainingPCUrl
      ..maintainingTime = maintainingTime ?? this.maintainingTime
      ..maintainingTitle = maintainingTitle ?? this.maintainingTitle
      ..marketLevel = marketLevel ?? this.marketLevel
      ..matchId = matchId ?? this.matchId
      ..merchantEventSwitchVO = merchantEventSwitchVO ??
          this.merchantEventSwitchVO
      ..nickName = nickName ?? this.nickName
      ..ommv = ommv ?? this.ommv
      ..openElectronicBasketball = openElectronicBasketball ??
          this.openElectronicBasketball
      ..openElectronicFootball = openElectronicFootball ??
          this.openElectronicFootball
      ..openElectronicTy = openElectronicTy ?? this.openElectronicTy
      ..openEsport = openEsport ?? this.openEsport
      ..openVrSport = openVrSport ?? this.openVrSport
      ..oss = oss ?? this.oss
      ..pcVerSysSwitch = pcVerSysSwitch ?? this.pcVerSysSwitch
      ..pcVersionSwitch = pcVersionSwitch ?? this.pcVersionSwitch
      ..pca = pca ?? this.pca
      ..pcs = pcs ?? this.pcs
      ..pullMsgRate = pullMsgRate ?? this.pullMsgRate
      ..settleSwitch = settleSwitch ?? this.settleSwitch
      ..settleSwitchBasket = settleSwitchBasket ?? this.settleSwitchBasket
      ..settleSwitchVO = settleSwitchVO ?? this.settleSwitchVO
      ..sort = sort ?? this.sort
      ..sportId = sportId ?? this.sportId
      ..stm = stm ?? this.stm
      ..storeFlag = storeFlag ?? this.storeFlag
      ..tournamentId = tournamentId ?? this.tournamentId
      ..userBetPrefer = userBetPrefer ?? this.userBetPrefer
      ..userId = userId ?? this.userId
      ..userMarketPrefer = userMarketPrefer ?? this.userMarketPrefer
      ..userName = userName ?? this.userName
      ..videoManageVo = videoManageVo ?? this.videoManageVo
      ..zr = zr ?? this.zr;
  }
}

UserInfoActivityList $UserInfoActivityListFromJson(Map<String, dynamic> json) {
  final UserInfoActivityList userInfoActivityList = UserInfoActivityList();
  final String? activityId = jsonConvert.convert<String>(json['activityId']);
  if (activityId != null) {
    userInfoActivityList.activityId = activityId;
  }
  final dynamic endTime = json['endTime'];
  if (endTime != null) {
    userInfoActivityList.endTime = endTime;
  }
  final String? h5Url = jsonConvert.convert<String>(json['h5Url']);
  if (h5Url != null) {
    userInfoActivityList.h5Url = h5Url;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    userInfoActivityList.id = id;
  }
  final String? inEndTime = jsonConvert.convert<String>(json['inEndTime']);
  if (inEndTime != null) {
    userInfoActivityList.inEndTime = inEndTime;
  }
  final String? inStartTime = jsonConvert.convert<String>(json['inStartTime']);
  if (inStartTime != null) {
    userInfoActivityList.inStartTime = inStartTime;
  }
  final dynamic maintainStatus = json['maintainStatus'];
  if (maintainStatus != null) {
    userInfoActivityList.maintainStatus = maintainStatus;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    userInfoActivityList.name = name;
  }
  final String? pcUrl = jsonConvert.convert<String>(json['pcUrl']);
  if (pcUrl != null) {
    userInfoActivityList.pcUrl = pcUrl;
  }
  final int? period = jsonConvert.convert<int>(json['period']);
  if (period != null) {
    userInfoActivityList.period = period;
  }
  final dynamic startTime = json['startTime'];
  if (startTime != null) {
    userInfoActivityList.startTime = startTime;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    userInfoActivityList.status = status;
  }
  final int? type = jsonConvert.convert<int>(json['type']);
  if (type != null) {
    userInfoActivityList.type = type;
  }
  return userInfoActivityList;
}

Map<String, dynamic> $UserInfoActivityListToJson(UserInfoActivityList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['activityId'] = entity.activityId;
  data['endTime'] = entity.endTime;
  data['h5Url'] = entity.h5Url;
  data['id'] = entity.id;
  data['inEndTime'] = entity.inEndTime;
  data['inStartTime'] = entity.inStartTime;
  data['maintainStatus'] = entity.maintainStatus;
  data['name'] = entity.name;
  data['pcUrl'] = entity.pcUrl;
  data['period'] = entity.period;
  data['startTime'] = entity.startTime;
  data['status'] = entity.status;
  data['type'] = entity.type;
  return data;
}

extension UserInfoActivityListExtension on UserInfoActivityList {
  UserInfoActivityList copyWith({
    String? activityId,
    dynamic endTime,
    String? h5Url,
    String? id,
    String? inEndTime,
    String? inStartTime,
    dynamic maintainStatus,
    String? name,
    String? pcUrl,
    int? period,
    dynamic startTime,
    int? status,
    int? type,
  }) {
    return UserInfoActivityList()
      ..activityId = activityId ?? this.activityId
      ..endTime = endTime ?? this.endTime
      ..h5Url = h5Url ?? this.h5Url
      ..id = id ?? this.id
      ..inEndTime = inEndTime ?? this.inEndTime
      ..inStartTime = inStartTime ?? this.inStartTime
      ..maintainStatus = maintainStatus ?? this.maintainStatus
      ..name = name ?? this.name
      ..pcUrl = pcUrl ?? this.pcUrl
      ..period = period ?? this.period
      ..startTime = startTime ?? this.startTime
      ..status = status ?? this.status
      ..type = type ?? this.type;
  }
}

UserInfoConfigVO $UserInfoConfigVOFromJson(Map<String, dynamic> json) {
  final UserInfoConfigVO userInfoConfigVO = UserInfoConfigVO();
  final int? appDefault = jsonConvert.convert<int>(json['appDefault']);
  if (appDefault != null) {
    userInfoConfigVO.appDefault = appDefault;
  }
  final String? bannerUrl = jsonConvert.convert<String>(json['bannerUrl']);
  if (bannerUrl != null) {
    userInfoConfigVO.bannerUrl = bannerUrl;
  }
  final int? bookBet = jsonConvert.convert<int>(json['bookBet']);
  if (bookBet != null) {
    userInfoConfigVO.bookBet = bookBet;
  }
  final int? bookMarketSwitch = jsonConvert.convert<int>(
      json['bookMarketSwitch']);
  if (bookMarketSwitch != null) {
    userInfoConfigVO.bookMarketSwitch = bookMarketSwitch;
  }
  final int? bookMarketSwitchBasketball = jsonConvert.convert<int>(
      json['bookMarketSwitchBasketball']);
  if (bookMarketSwitchBasketball != null) {
    userInfoConfigVO.bookMarketSwitchBasketball = bookMarketSwitchBasketball;
  }
  final String? compatLogoUrl = jsonConvert.convert<String>(
      json['compatLogoUrl']);
  if (compatLogoUrl != null) {
    userInfoConfigVO.compatLogoUrl = compatLogoUrl;
  }
  final Map<String, dynamic>? configMap =
  (json['configMap'] as Map<String, dynamic>).map(
          (k, e) => MapEntry(k, e));
  if (configMap != null) {
    userInfoConfigVO.configMap = configMap;
  }
  final String? filterLeague = jsonConvert.convert<String>(
      json['filterLeague']);
  if (filterLeague != null) {
    userInfoConfigVO.filterLeague = filterLeague;
  }
  final String? filterSport = jsonConvert.convert<String>(json['filterSport']);
  if (filterSport != null) {
    userInfoConfigVO.filterSport = filterSport;
  }
  final int? h5Default = jsonConvert.convert<int>(json['h5Default']);
  if (h5Default != null) {
    userInfoConfigVO.h5Default = h5Default;
  }
  final dynamic inlineWidth = json['inlineWidth'];
  if (inlineWidth != null) {
    userInfoConfigVO.inlineWidth = inlineWidth;
  }
  final String? leagueLogoUrl = jsonConvert.convert<String>(
      json['leagueLogoUrl']);
  if (leagueLogoUrl != null) {
    userInfoConfigVO.leagueLogoUrl = leagueLogoUrl;
  }
  final String? loadLogoUrl = jsonConvert.convert<String>(json['loadLogoUrl']);
  if (loadLogoUrl != null) {
    userInfoConfigVO.loadLogoUrl = loadLogoUrl;
  }
  final String? marketConfigKey = jsonConvert.convert<String>(
      json['marketConfigKey']);
  if (marketConfigKey != null) {
    userInfoConfigVO.marketConfigKey = marketConfigKey;
  }
  final int? marketConfigValue = jsonConvert.convert<int>(
      json['marketConfigValue']);
  if (marketConfigValue != null) {
    userInfoConfigVO.marketConfigValue = marketConfigValue;
  }
  final int? marketDefault = jsonConvert.convert<int>(json['marketDefault']);
  if (marketDefault != null) {
    userInfoConfigVO.marketDefault = marketDefault;
  }
  final int? maxSeriesNum = jsonConvert.convert<int>(json['maxSeriesNum']);
  if (maxSeriesNum != null) {
    userInfoConfigVO.maxSeriesNum = maxSeriesNum;
  }
  final int? minSeriesNum = jsonConvert.convert<int>(json['minSeriesNum']);
  if (minSeriesNum != null) {
    userInfoConfigVO.minSeriesNum = minSeriesNum;
  }
  final int? nociceTag = jsonConvert.convert<int>(json['nociceTag']);
  if (nociceTag != null) {
    userInfoConfigVO.nociceTag = nociceTag;
  }
  final String? pcLogoUrl = jsonConvert.convert<String>(json['pcLogoUrl']);
  if (pcLogoUrl != null) {
    userInfoConfigVO.pcLogoUrl = pcLogoUrl;
  }
  final int? profesTag = jsonConvert.convert<int>(json['profesTag']);
  if (profesTag != null) {
    userInfoConfigVO.profesTag = profesTag;
  }
  final int? standardTag = jsonConvert.convert<int>(json['standardTag']);
  if (standardTag != null) {
    userInfoConfigVO.standardTag = standardTag;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    userInfoConfigVO.title = title;
  }
  final UserInfoConfigVOTitleMap? titleMap = jsonConvert.convert<
      UserInfoConfigVOTitleMap>(json['titleMap']);
  if (titleMap != null) {
    userInfoConfigVO.titleMap = titleMap;
  }
  final String? videoLogoUrl = jsonConvert.convert<String>(
      json['videoLogoUrl']);
  if (videoLogoUrl != null) {
    userInfoConfigVO.videoLogoUrl = videoLogoUrl;
  }
  return userInfoConfigVO;
}

Map<String, dynamic> $UserInfoConfigVOToJson(UserInfoConfigVO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['appDefault'] = entity.appDefault;
  data['bannerUrl'] = entity.bannerUrl;
  data['bookBet'] = entity.bookBet;
  data['bookMarketSwitch'] = entity.bookMarketSwitch;
  data['bookMarketSwitchBasketball'] = entity.bookMarketSwitchBasketball;
  data['compatLogoUrl'] = entity.compatLogoUrl;
  data['configMap'] = entity.configMap;
  data['filterLeague'] = entity.filterLeague;
  data['filterSport'] = entity.filterSport;
  data['h5Default'] = entity.h5Default;
  data['inlineWidth'] = entity.inlineWidth;
  data['leagueLogoUrl'] = entity.leagueLogoUrl;
  data['loadLogoUrl'] = entity.loadLogoUrl;
  data['marketConfigKey'] = entity.marketConfigKey;
  data['marketConfigValue'] = entity.marketConfigValue;
  data['marketDefault'] = entity.marketDefault;
  data['maxSeriesNum'] = entity.maxSeriesNum;
  data['minSeriesNum'] = entity.minSeriesNum;
  data['nociceTag'] = entity.nociceTag;
  data['pcLogoUrl'] = entity.pcLogoUrl;
  data['profesTag'] = entity.profesTag;
  data['standardTag'] = entity.standardTag;
  data['title'] = entity.title;
  data['titleMap'] = entity.titleMap?.toJson();
  data['videoLogoUrl'] = entity.videoLogoUrl;
  return data;
}

extension UserInfoConfigVOExtension on UserInfoConfigVO {
  UserInfoConfigVO copyWith({
    int? appDefault,
    String? bannerUrl,
    int? bookBet,
    int? bookMarketSwitch,
    int? bookMarketSwitchBasketball,
    String? compatLogoUrl,
    Map<String, dynamic>? configMap,
    String? filterLeague,
    String? filterSport,
    int? h5Default,
    dynamic inlineWidth,
    String? leagueLogoUrl,
    String? loadLogoUrl,
    String? marketConfigKey,
    int? marketConfigValue,
    int? marketDefault,
    int? maxSeriesNum,
    int? minSeriesNum,
    int? nociceTag,
    String? pcLogoUrl,
    int? profesTag,
    int? standardTag,
    String? title,
    UserInfoConfigVOTitleMap? titleMap,
    String? videoLogoUrl,
  }) {
    return UserInfoConfigVO()
      ..appDefault = appDefault ?? this.appDefault
      ..bannerUrl = bannerUrl ?? this.bannerUrl
      ..bookBet = bookBet ?? this.bookBet
      ..bookMarketSwitch = bookMarketSwitch ?? this.bookMarketSwitch
      ..bookMarketSwitchBasketball = bookMarketSwitchBasketball ??
          this.bookMarketSwitchBasketball
      ..compatLogoUrl = compatLogoUrl ?? this.compatLogoUrl
      ..configMap = configMap ?? this.configMap
      ..filterLeague = filterLeague ?? this.filterLeague
      ..filterSport = filterSport ?? this.filterSport
      ..h5Default = h5Default ?? this.h5Default
      ..inlineWidth = inlineWidth ?? this.inlineWidth
      ..leagueLogoUrl = leagueLogoUrl ?? this.leagueLogoUrl
      ..loadLogoUrl = loadLogoUrl ?? this.loadLogoUrl
      ..marketConfigKey = marketConfigKey ?? this.marketConfigKey
      ..marketConfigValue = marketConfigValue ?? this.marketConfigValue
      ..marketDefault = marketDefault ?? this.marketDefault
      ..maxSeriesNum = maxSeriesNum ?? this.maxSeriesNum
      ..minSeriesNum = minSeriesNum ?? this.minSeriesNum
      ..nociceTag = nociceTag ?? this.nociceTag
      ..pcLogoUrl = pcLogoUrl ?? this.pcLogoUrl
      ..profesTag = profesTag ?? this.profesTag
      ..standardTag = standardTag ?? this.standardTag
      ..title = title ?? this.title
      ..titleMap = titleMap ?? this.titleMap
      ..videoLogoUrl = videoLogoUrl ?? this.videoLogoUrl;
  }
}

UserInfoConfigVOTitleMap $UserInfoConfigVOTitleMapFromJson(
    Map<String, dynamic> json) {
  final UserInfoConfigVOTitleMap userInfoConfigVOTitleMap = UserInfoConfigVOTitleMap();
  final String? hy = jsonConvert.convert<String>(json['hy']);
  if (hy != null) {
    userInfoConfigVOTitleMap.hy = hy;
  }
  final String? tw = jsonConvert.convert<String>(json['tw']);
  if (tw != null) {
    userInfoConfigVOTitleMap.tw = tw;
  }
  final String? vi = jsonConvert.convert<String>(json['vi']);
  if (vi != null) {
    userInfoConfigVOTitleMap.vi = vi;
  }
  final String? ad = jsonConvert.convert<String>(json['ad']);
  if (ad != null) {
    userInfoConfigVOTitleMap.ad = ad;
  }
  final String? th = jsonConvert.convert<String>(json['th']);
  if (th != null) {
    userInfoConfigVOTitleMap.th = th;
  }
  final String? pty = jsonConvert.convert<String>(json['pty']);
  if (pty != null) {
    userInfoConfigVOTitleMap.pty = pty;
  }
  final String? ms = jsonConvert.convert<String>(json['ms']);
  if (ms != null) {
    userInfoConfigVOTitleMap.ms = ms;
  }
  final String? md = jsonConvert.convert<String>(json['md']);
  if (md != null) {
    userInfoConfigVOTitleMap.md = md;
  }
  final String? en = jsonConvert.convert<String>(json['en']);
  if (en != null) {
    userInfoConfigVOTitleMap.en = en;
  }
  final String? zh = jsonConvert.convert<String>(json['zh']);
  if (zh != null) {
    userInfoConfigVOTitleMap.zh = zh;
  }
  return userInfoConfigVOTitleMap;
}

Map<String, dynamic> $UserInfoConfigVOTitleMapToJson(
    UserInfoConfigVOTitleMap entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['hy'] = entity.hy;
  data['tw'] = entity.tw;
  data['vi'] = entity.vi;
  data['ad'] = entity.ad;
  data['th'] = entity.th;
  data['pty'] = entity.pty;
  data['ms'] = entity.ms;
  data['md'] = entity.md;
  data['en'] = entity.en;
  data['zh'] = entity.zh;
  return data;
}

extension UserInfoConfigVOTitleMapExtension on UserInfoConfigVOTitleMap {
  UserInfoConfigVOTitleMap copyWith({
    String? hy,
    String? tw,
    String? vi,
    String? ad,
    String? th,
    String? pty,
    String? ms,
    String? md,
    String? en,
    String? zh,
  }) {
    return UserInfoConfigVOTitleMap()
      ..hy = hy ?? this.hy
      ..tw = tw ?? this.tw
      ..vi = vi ?? this.vi
      ..ad = ad ?? this.ad
      ..th = th ?? this.th
      ..pty = pty ?? this.pty
      ..ms = ms ?? this.ms
      ..md = md ?? this.md
      ..en = en ?? this.en
      ..zh = zh ?? this.zh;
  }
}

UserInfoCvo $UserInfoCvoFromJson(Map<String, dynamic> json) {
  final UserInfoCvo userInfoCvo = UserInfoCvo();
  final UserInfoCvoSeries? series = jsonConvert.convert<UserInfoCvoSeries>(
      json['series']);
  if (series != null) {
    userInfoCvo.series = series;
  }
  final UserInfoCvoSingle? single = jsonConvert.convert<UserInfoCvoSingle>(
      json['single']);
  if (single != null) {
    userInfoCvo.single = single;
  }
  return userInfoCvo;
}

Map<String, dynamic> $UserInfoCvoToJson(UserInfoCvo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['series'] = entity.series?.toJson();
  data['single'] = entity.single?.toJson();
  return data;
}

extension UserInfoCvoExtension on UserInfoCvo {
  UserInfoCvo copyWith({
    UserInfoCvoSeries? series,
    UserInfoCvoSingle? single,
  }) {
    return UserInfoCvo()
      ..series = series ?? this.series
      ..single = single ?? this.single;
  }
}

UserInfoCvoSeries $UserInfoCvoSeriesFromJson(Map<String, dynamic> json) {
  final UserInfoCvoSeries userInfoCvoSeries = UserInfoCvoSeries();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    userInfoCvoSeries.code = code;
  }
  final int? min = jsonConvert.convert<int>(json['min']);
  if (min != null) {
    userInfoCvoSeries.min = min;
  }
  final int? qfi = jsonConvert.convert<int>(json['qfi']);
  if (qfi != null) {
    userInfoCvoSeries.qfi = qfi;
  }
  final int? qfo = jsonConvert.convert<int>(json['qfo']);
  if (qfo != null) {
    userInfoCvoSeries.qfo = qfo;
  }
  final int? qon = jsonConvert.convert<int>(json['qon']);
  if (qon != null) {
    userInfoCvoSeries.qon = qon;
  }
  final int? qsi = jsonConvert.convert<int>(json['qsi']);
  if (qsi != null) {
    userInfoCvoSeries.qsi = qsi;
  }
  final int? qth = jsonConvert.convert<int>(json['qth']);
  if (qth != null) {
    userInfoCvoSeries.qth = qth;
  }
  final int? qtw = jsonConvert.convert<int>(json['qtw']);
  if (qtw != null) {
    userInfoCvoSeries.qtw = qtw;
  }
  return userInfoCvoSeries;
}

Map<String, dynamic> $UserInfoCvoSeriesToJson(UserInfoCvoSeries entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['min'] = entity.min;
  data['qfi'] = entity.qfi;
  data['qfo'] = entity.qfo;
  data['qon'] = entity.qon;
  data['qsi'] = entity.qsi;
  data['qth'] = entity.qth;
  data['qtw'] = entity.qtw;
  return data;
}

extension UserInfoCvoSeriesExtension on UserInfoCvoSeries {
  UserInfoCvoSeries copyWith({
    String? code,
    int? min,
    int? qfi,
    int? qfo,
    int? qon,
    int? qsi,
    int? qth,
    int? qtw,
  }) {
    return UserInfoCvoSeries()
      ..code = code ?? this.code
      ..min = min ?? this.min
      ..qfi = qfi ?? this.qfi
      ..qfo = qfo ?? this.qfo
      ..qon = qon ?? this.qon
      ..qsi = qsi ?? this.qsi
      ..qth = qth ?? this.qth
      ..qtw = qtw ?? this.qtw;
  }
}

UserInfoCvoSingle $UserInfoCvoSingleFromJson(Map<String, dynamic> json) {
  final UserInfoCvoSingle userInfoCvoSingle = UserInfoCvoSingle();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    userInfoCvoSingle.code = code;
  }
  final int? min = jsonConvert.convert<int>(json['min']);
  if (min != null) {
    userInfoCvoSingle.min = min;
  }
  final int? qfi = jsonConvert.convert<int>(json['qfi']);
  if (qfi != null) {
    userInfoCvoSingle.qfi = qfi;
  }
  final int? qfo = jsonConvert.convert<int>(json['qfo']);
  if (qfo != null) {
    userInfoCvoSingle.qfo = qfo;
  }
  final int? qon = jsonConvert.convert<int>(json['qon']);
  if (qon != null) {
    userInfoCvoSingle.qon = qon;
  }
  final int? qth = jsonConvert.convert<int>(json['qth']);
  if (qth != null) {
    userInfoCvoSingle.qth = qth;
  }
  final int? qtw = jsonConvert.convert<int>(json['qtw']);
  if (qtw != null) {
    userInfoCvoSingle.qtw = qtw;
  }
  return userInfoCvoSingle;
}

Map<String, dynamic> $UserInfoCvoSingleToJson(UserInfoCvoSingle entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['min'] = entity.min;
  data['qfi'] = entity.qfi;
  data['qfo'] = entity.qfo;
  data['qon'] = entity.qon;
  data['qth'] = entity.qth;
  data['qtw'] = entity.qtw;
  return data;
}

extension UserInfoCvoSingleExtension on UserInfoCvoSingle {
  UserInfoCvoSingle copyWith({
    String? code,
    int? min,
    int? qfi,
    int? qfo,
    int? qon,
    int? qth,
    int? qtw,
  }) {
    return UserInfoCvoSingle()
      ..code = code ?? this.code
      ..min = min ?? this.min
      ..qfi = qfi ?? this.qfi
      ..qfo = qfo ?? this.qfo
      ..qon = qon ?? this.qon
      ..qth = qth ?? this.qth
      ..qtw = qtw ?? this.qtw;
  }
}

UserInfoMerchantEventSwitchVO $UserInfoMerchantEventSwitchVOFromJson(
    Map<String, dynamic> json) {
  final UserInfoMerchantEventSwitchVO userInfoMerchantEventSwitchVO = UserInfoMerchantEventSwitchVO();
  final String? configKey = jsonConvert.convert<String>(json['configKey']);
  if (configKey != null) {
    userInfoMerchantEventSwitchVO.configKey = configKey;
  }
  final String? configValue = jsonConvert.convert<String>(json['configValue']);
  if (configValue != null) {
    userInfoMerchantEventSwitchVO.configValue = configValue;
  }
  final int? cornerEvent = jsonConvert.convert<int>(json['cornerEvent']);
  if (cornerEvent != null) {
    userInfoMerchantEventSwitchVO.cornerEvent = cornerEvent;
  }
  final int? eventSwitch = jsonConvert.convert<int>(json['eventSwitch']);
  if (eventSwitch != null) {
    userInfoMerchantEventSwitchVO.eventSwitch = eventSwitch;
  }
  final int? penaltyEvent = jsonConvert.convert<int>(json['penaltyEvent']);
  if (penaltyEvent != null) {
    userInfoMerchantEventSwitchVO.penaltyEvent = penaltyEvent;
  }
  return userInfoMerchantEventSwitchVO;
}

Map<String, dynamic> $UserInfoMerchantEventSwitchVOToJson(
    UserInfoMerchantEventSwitchVO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['configKey'] = entity.configKey;
  data['configValue'] = entity.configValue;
  data['cornerEvent'] = entity.cornerEvent;
  data['eventSwitch'] = entity.eventSwitch;
  data['penaltyEvent'] = entity.penaltyEvent;
  return data;
}

extension UserInfoMerchantEventSwitchVOExtension on UserInfoMerchantEventSwitchVO {
  UserInfoMerchantEventSwitchVO copyWith({
    String? configKey,
    String? configValue,
    int? cornerEvent,
    int? eventSwitch,
    int? penaltyEvent,
  }) {
    return UserInfoMerchantEventSwitchVO()
      ..configKey = configKey ?? this.configKey
      ..configValue = configValue ?? this.configValue
      ..cornerEvent = cornerEvent ?? this.cornerEvent
      ..eventSwitch = eventSwitch ?? this.eventSwitch
      ..penaltyEvent = penaltyEvent ?? this.penaltyEvent;
  }
}

UserInfoOss $UserInfoOssFromJson(Map<String, dynamic> json) {
  final UserInfoOss userInfoOss = UserInfoOss();
  final List<String>? api = (json['api'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (api != null) {
    userInfoOss.api = api;
  }
  final List<String>? chatroomHttpUrl = (json['chatroomHttpUrl'] as List<
      dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (chatroomHttpUrl != null) {
    userInfoOss.chatroomHttpUrl = chatroomHttpUrl;
  }
  final List<String>? chatroomUrl = (json['chatroomUrl'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<String>(e) as String)
      .toList();
  if (chatroomUrl != null) {
    userInfoOss.chatroomUrl = chatroomUrl;
  }
  final List<String>? img = (json['img'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (img != null) {
    userInfoOss.img = img;
  }
  final String? liveH5 = jsonConvert.convert<String>(json['live_h5']);
  if (liveH5 != null) {
    userInfoOss.liveH5 = liveH5;
  }
  final String? livePc = jsonConvert.convert<String>(json['live_pc']);
  if (livePc != null) {
    userInfoOss.livePc = livePc;
  }
  final String? loginUrl = jsonConvert.convert<String>(json['loginUrl']);
  if (loginUrl != null) {
    userInfoOss.loginUrl = loginUrl;
  }
  final List<String>? loginUrlArr = (json['loginUrlArr'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<String>(e) as String)
      .toList();
  if (loginUrlArr != null) {
    userInfoOss.loginUrlArr = loginUrlArr;
  }
  return userInfoOss;
}

Map<String, dynamic> $UserInfoOssToJson(UserInfoOss entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['api'] = entity.api;
  data['chatroomHttpUrl'] = entity.chatroomHttpUrl;
  data['chatroomUrl'] = entity.chatroomUrl;
  data['img'] = entity.img;
  data['live_h5'] = entity.liveH5;
  data['live_pc'] = entity.livePc;
  data['loginUrl'] = entity.loginUrl;
  data['loginUrlArr'] = entity.loginUrlArr;
  return data;
}

extension UserInfoOssExtension on UserInfoOss {
  UserInfoOss copyWith({
    List<String>? api,
    List<String>? chatroomHttpUrl,
    List<String>? chatroomUrl,
    List<String>? img,
    String? liveH5,
    String? livePc,
    String? loginUrl,
    List<String>? loginUrlArr,
  }) {
    return UserInfoOss()
      ..api = api ?? this.api
      ..chatroomHttpUrl = chatroomHttpUrl ?? this.chatroomHttpUrl
      ..chatroomUrl = chatroomUrl ?? this.chatroomUrl
      ..img = img ?? this.img
      ..liveH5 = liveH5 ?? this.liveH5
      ..livePc = livePc ?? this.livePc
      ..loginUrl = loginUrl ?? this.loginUrl
      ..loginUrlArr = loginUrlArr ?? this.loginUrlArr;
  }
}

UserInfoPca $UserInfoPcaFromJson(Map<String, dynamic> json) {
  final UserInfoPca userInfoPca = UserInfoPca();
  final int? pcam = jsonConvert.convert<int>(json['pcam']);
  if (pcam != null) {
    userInfoPca.pcam = pcam;
  }
  final int? pcap = jsonConvert.convert<int>(json['pcap']);
  if (pcap != null) {
    userInfoPca.pcap = pcap;
  }
  final String? pcms = jsonConvert.convert<String>(json['pcms']);
  if (pcms != null) {
    userInfoPca.pcms = pcms;
  }
  final String? pcps = jsonConvert.convert<String>(json['pcps']);
  if (pcps != null) {
    userInfoPca.pcps = pcps;
  }
  return userInfoPca;
}

Map<String, dynamic> $UserInfoPcaToJson(UserInfoPca entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['pcam'] = entity.pcam;
  data['pcap'] = entity.pcap;
  data['pcms'] = entity.pcms;
  data['pcps'] = entity.pcps;
  return data;
}

extension UserInfoPcaExtension on UserInfoPca {
  UserInfoPca copyWith({
    int? pcam,
    int? pcap,
    String? pcms,
    String? pcps,
  }) {
    return UserInfoPca()
      ..pcam = pcam ?? this.pcam
      ..pcap = pcap ?? this.pcap
      ..pcms = pcms ?? this.pcms
      ..pcps = pcps ?? this.pcps;
  }
}

UserInfoVideoManageVo $UserInfoVideoManageVoFromJson(
    Map<String, dynamic> json) {
  final UserInfoVideoManageVo userInfoVideoManageVo = UserInfoVideoManageVo();
  final int? closedWithoutOperation = jsonConvert.convert<int>(
      json['closedWithoutOperation']);
  if (closedWithoutOperation != null) {
    userInfoVideoManageVo.closedWithoutOperation = closedWithoutOperation;
  }
  final String? configKey = jsonConvert.convert<String>(json['configKey']);
  if (configKey != null) {
    userInfoVideoManageVo.configKey = configKey;
  }
  final String? configValue = jsonConvert.convert<String>(json['configValue']);
  if (configValue != null) {
    userInfoVideoManageVo.configValue = configValue;
  }
  final dynamic customViewTime = json['customViewTime'];
  if (customViewTime != null) {
    userInfoVideoManageVo.customViewTime = customViewTime;
  }
  final String? merchantCode = jsonConvert.convert<String>(
      json['merchantCode']);
  if (merchantCode != null) {
    userInfoVideoManageVo.merchantCode = merchantCode;
  }
  final int? noBackgroundPlay = jsonConvert.convert<int>(
      json['noBackgroundPlay']);
  if (noBackgroundPlay != null) {
    userInfoVideoManageVo.noBackgroundPlay = noBackgroundPlay;
  }
  final int? videoSettings = jsonConvert.convert<int>(json['videoSettings']);
  if (videoSettings != null) {
    userInfoVideoManageVo.videoSettings = videoSettings;
  }
  final int? videoSwitch = jsonConvert.convert<int>(json['videoSwitch']);
  if (videoSwitch != null) {
    userInfoVideoManageVo.videoSwitch = videoSwitch;
  }
  final dynamic viewingTime = json['viewingTime'];
  if (viewingTime != null) {
    userInfoVideoManageVo.viewingTime = viewingTime;
  }
  return userInfoVideoManageVo;
}

Map<String, dynamic> $UserInfoVideoManageVoToJson(
    UserInfoVideoManageVo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['closedWithoutOperation'] = entity.closedWithoutOperation;
  data['configKey'] = entity.configKey;
  data['configValue'] = entity.configValue;
  data['customViewTime'] = entity.customViewTime;
  data['merchantCode'] = entity.merchantCode;
  data['noBackgroundPlay'] = entity.noBackgroundPlay;
  data['videoSettings'] = entity.videoSettings;
  data['videoSwitch'] = entity.videoSwitch;
  data['viewingTime'] = entity.viewingTime;
  return data;
}

extension UserInfoVideoManageVoExtension on UserInfoVideoManageVo {
  UserInfoVideoManageVo copyWith({
    int? closedWithoutOperation,
    String? configKey,
    String? configValue,
    dynamic customViewTime,
    String? merchantCode,
    int? noBackgroundPlay,
    int? videoSettings,
    int? videoSwitch,
    dynamic viewingTime,
  }) {
    return UserInfoVideoManageVo()
      ..closedWithoutOperation = closedWithoutOperation ??
          this.closedWithoutOperation
      ..configKey = configKey ?? this.configKey
      ..configValue = configValue ?? this.configValue
      ..customViewTime = customViewTime ?? this.customViewTime
      ..merchantCode = merchantCode ?? this.merchantCode
      ..noBackgroundPlay = noBackgroundPlay ?? this.noBackgroundPlay
      ..videoSettings = videoSettings ?? this.videoSettings
      ..videoSwitch = videoSwitch ?? this.videoSwitch
      ..viewingTime = viewingTime ?? this.viewingTime;
  }
}

UserInfoSettleSwitchVO $UserInfoSettleSwitchVOFromJson(
    Map<String, dynamic> json) {
  final UserInfoSettleSwitchVO userInfoSettleSwitchVO = UserInfoSettleSwitchVO();
  final int? bookedSettleSwitchBasketball = jsonConvert.convert<int>(
      json['bookedSettleSwitchBasketball']);
  if (bookedSettleSwitchBasketball != null) {
    userInfoSettleSwitchVO.bookedSettleSwitchBasketball =
        bookedSettleSwitchBasketball;
  }
  final int? bookedSettleSwitchFootball = jsonConvert.convert<int>(
      json['bookedSettleSwitchFootball']);
  if (bookedSettleSwitchFootball != null) {
    userInfoSettleSwitchVO.bookedSettleSwitchFootball =
        bookedSettleSwitchFootball;
  }
  final int? partSettleSwitchBasketball = jsonConvert.convert<int>(
      json['partSettleSwitchBasketball']);
  if (partSettleSwitchBasketball != null) {
    userInfoSettleSwitchVO.partSettleSwitchBasketball =
        partSettleSwitchBasketball;
  }
  final int? partSettleSwitchFootball = jsonConvert.convert<int>(
      json['partSettleSwitchFootball']);
  if (partSettleSwitchFootball != null) {
    userInfoSettleSwitchVO.partSettleSwitchFootball = partSettleSwitchFootball;
  }
  final int? settleSwitch = jsonConvert.convert<int>(json['settleSwitch']);
  if (settleSwitch != null) {
    userInfoSettleSwitchVO.settleSwitch = settleSwitch;
  }
  final int? settleSwitchBasket = jsonConvert.convert<int>(
      json['settleSwitchBasket']);
  if (settleSwitchBasket != null) {
    userInfoSettleSwitchVO.settleSwitchBasket = settleSwitchBasket;
  }
  final int? sysBookedSettleSwitch = jsonConvert.convert<int>(
      json['sysBookedSettleSwitch']);
  if (sysBookedSettleSwitch != null) {
    userInfoSettleSwitchVO.sysBookedSettleSwitch = sysBookedSettleSwitch;
  }
  final int? sysPartSettleSwitch = jsonConvert.convert<int>(
      json['sysPartSettleSwitch']);
  if (sysPartSettleSwitch != null) {
    userInfoSettleSwitchVO.sysPartSettleSwitch = sysPartSettleSwitch;
  }
  return userInfoSettleSwitchVO;
}

Map<String, dynamic> $UserInfoSettleSwitchVOToJson(
    UserInfoSettleSwitchVO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['bookedSettleSwitchBasketball'] = entity.bookedSettleSwitchBasketball;
  data['bookedSettleSwitchFootball'] = entity.bookedSettleSwitchFootball;
  data['partSettleSwitchBasketball'] = entity.partSettleSwitchBasketball;
  data['partSettleSwitchFootball'] = entity.partSettleSwitchFootball;
  data['settleSwitch'] = entity.settleSwitch;
  data['settleSwitchBasket'] = entity.settleSwitchBasket;
  data['sysBookedSettleSwitch'] = entity.sysBookedSettleSwitch;
  data['sysPartSettleSwitch'] = entity.sysPartSettleSwitch;
  return data;
}

extension UserInfoSettleSwitchVOExtension on UserInfoSettleSwitchVO {
  UserInfoSettleSwitchVO copyWith({
    int? bookedSettleSwitchBasketball,
    int? bookedSettleSwitchFootball,
    int? partSettleSwitchBasketball,
    int? partSettleSwitchFootball,
    int? settleSwitch,
    int? settleSwitchBasket,
    int? sysBookedSettleSwitch,
    int? sysPartSettleSwitch,
  }) {
    return UserInfoSettleSwitchVO()
      ..bookedSettleSwitchBasketball = bookedSettleSwitchBasketball ??
          this.bookedSettleSwitchBasketball
      ..bookedSettleSwitchFootball = bookedSettleSwitchFootball ??
          this.bookedSettleSwitchFootball
      ..partSettleSwitchBasketball = partSettleSwitchBasketball ??
          this.partSettleSwitchBasketball
      ..partSettleSwitchFootball = partSettleSwitchFootball ??
          this.partSettleSwitchFootball
      ..settleSwitch = settleSwitch ?? this.settleSwitch
      ..settleSwitchBasket = settleSwitchBasket ?? this.settleSwitchBasket
      ..sysBookedSettleSwitch = sysBookedSettleSwitch ??
          this.sysBookedSettleSwitch
      ..sysPartSettleSwitch = sysPartSettleSwitch ?? this.sysPartSettleSwitch;
  }
}