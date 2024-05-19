import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/set_user_language_entity.dart';

SetUserLanguageEntity $SetUserLanguageEntityFromJson(
    Map<String, dynamic> json) {
  final SetUserLanguageEntity setUserLanguageEntity = SetUserLanguageEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    setUserLanguageEntity.code = code;
  }
  final SetUserLanguageData? data = jsonConvert.convert<SetUserLanguageData>(
      json['data']);
  if (data != null) {
    setUserLanguageEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    setUserLanguageEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    setUserLanguageEntity.ts = ts;
  }
  return setUserLanguageEntity;
}

Map<String, dynamic> $SetUserLanguageEntityToJson(
    SetUserLanguageEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.toJson();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension SetUserLanguageEntityExtension on SetUserLanguageEntity {
  SetUserLanguageEntity copyWith({
    String? code,
    SetUserLanguageData? data,
    String? msg,
    int? ts,
  }) {
    return SetUserLanguageEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

SetUserLanguageData $SetUserLanguageDataFromJson(Map<String, dynamic> json) {
  final SetUserLanguageData setUserLanguageData = SetUserLanguageData();
  final dynamic createTime = json['createTime'];
  if (createTime != null) {
    setUserLanguageData.createTime = createTime;
  }
  final String? createUser = jsonConvert.convert<String>(json['createUser']);
  if (createUser != null) {
    setUserLanguageData.createUser = createUser;
  }
  final String? currencyCode = jsonConvert.convert<String>(
      json['currencyCode']);
  if (currencyCode != null) {
    setUserLanguageData.currencyCode = currencyCode;
  }
  final dynamic delFlag = json['delFlag'];
  if (delFlag != null) {
    setUserLanguageData.delFlag = delFlag;
  }
  final dynamic disabled = json['disabled'];
  if (disabled != null) {
    setUserLanguageData.disabled = disabled;
  }
  final dynamic esMarketLevel = json['esMarketLevel'];
  if (esMarketLevel != null) {
    setUserLanguageData.esMarketLevel = esMarketLevel;
  }
  final dynamic financeTag = json['financeTag'];
  if (financeTag != null) {
    setUserLanguageData.financeTag = financeTag;
  }
  final String? ipAddress = jsonConvert.convert<String>(json['ipAddress']);
  if (ipAddress != null) {
    setUserLanguageData.ipAddress = ipAddress;
  }
  final dynamic isTest = json['isTest'];
  if (isTest != null) {
    setUserLanguageData.isTest = isTest;
  }
  final String? languageName = jsonConvert.convert<String>(
      json['languageName']);
  if (languageName != null) {
    setUserLanguageData.languageName = languageName;
  }
  final dynamic marketLevel = json['marketLevel'];
  if (marketLevel != null) {
    setUserLanguageData.marketLevel = marketLevel;
  }
  final String? merchantCode = jsonConvert.convert<String>(
      json['merchantCode']);
  if (merchantCode != null) {
    setUserLanguageData.merchantCode = merchantCode;
  }
  final String? modifyTime = jsonConvert.convert<String>(json['modifyTime']);
  if (modifyTime != null) {
    setUserLanguageData.modifyTime = modifyTime;
  }
  final String? modifyUser = jsonConvert.convert<String>(json['modifyUser']);
  if (modifyUser != null) {
    setUserLanguageData.modifyUser = modifyUser;
  }
  final String? password = jsonConvert.convert<String>(json['password']);
  if (password != null) {
    setUserLanguageData.password = password;
  }
  final String? realName = jsonConvert.convert<String>(json['realName']);
  if (realName != null) {
    setUserLanguageData.realName = realName;
  }
  final String? remark = jsonConvert.convert<String>(json['remark']);
  if (remark != null) {
    setUserLanguageData.remark = remark;
  }
  final dynamic settleInAdvance = json['settleInAdvance'];
  if (settleInAdvance != null) {
    setUserLanguageData.settleInAdvance = settleInAdvance;
  }
  final dynamic specialBettingLimitDelayTime = json['specialBettingLimitDelayTime'];
  if (specialBettingLimitDelayTime != null) {
    setUserLanguageData.specialBettingLimitDelayTime =
        specialBettingLimitDelayTime;
  }
  final String? specialBettingLimitRemark = jsonConvert.convert<String>(
      json['specialBettingLimitRemark']);
  if (specialBettingLimitRemark != null) {
    setUserLanguageData.specialBettingLimitRemark = specialBettingLimitRemark;
  }
  final dynamic specialBettingLimitTime = json['specialBettingLimitTime'];
  if (specialBettingLimitTime != null) {
    setUserLanguageData.specialBettingLimitTime = specialBettingLimitTime;
  }
  final dynamic specialBettingLimitType = json['specialBettingLimitType'];
  if (specialBettingLimitType != null) {
    setUserLanguageData.specialBettingLimitType = specialBettingLimitType;
  }
  final String? uid = jsonConvert.convert<String>(json['uid']);
  if (uid != null) {
    setUserLanguageData.uid = uid;
  }
  final dynamic userBetPrefer = json['userBetPrefer'];
  if (userBetPrefer != null) {
    setUserLanguageData.userBetPrefer = userBetPrefer;
  }
  final dynamic userLevel = json['userLevel'];
  if (userLevel != null) {
    setUserLanguageData.userLevel = userLevel;
  }
  final String? userMarketPrefer = jsonConvert.convert<String>(
      json['userMarketPrefer']);
  if (userMarketPrefer != null) {
    setUserLanguageData.userMarketPrefer = userMarketPrefer;
  }
  final String? username = jsonConvert.convert<String>(json['username']);
  if (username != null) {
    setUserLanguageData.username = username;
  }
  final dynamic vipLevel = json['vipLevel'];
  if (vipLevel != null) {
    setUserLanguageData.vipLevel = vipLevel;
  }
  return setUserLanguageData;
}

Map<String, dynamic> $SetUserLanguageDataToJson(SetUserLanguageData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['createTime'] = entity.createTime;
  data['createUser'] = entity.createUser;
  data['currencyCode'] = entity.currencyCode;
  data['delFlag'] = entity.delFlag;
  data['disabled'] = entity.disabled;
  data['esMarketLevel'] = entity.esMarketLevel;
  data['financeTag'] = entity.financeTag;
  data['ipAddress'] = entity.ipAddress;
  data['isTest'] = entity.isTest;
  data['languageName'] = entity.languageName;
  data['marketLevel'] = entity.marketLevel;
  data['merchantCode'] = entity.merchantCode;
  data['modifyTime'] = entity.modifyTime;
  data['modifyUser'] = entity.modifyUser;
  data['password'] = entity.password;
  data['realName'] = entity.realName;
  data['remark'] = entity.remark;
  data['settleInAdvance'] = entity.settleInAdvance;
  data['specialBettingLimitDelayTime'] = entity.specialBettingLimitDelayTime;
  data['specialBettingLimitRemark'] = entity.specialBettingLimitRemark;
  data['specialBettingLimitTime'] = entity.specialBettingLimitTime;
  data['specialBettingLimitType'] = entity.specialBettingLimitType;
  data['uid'] = entity.uid;
  data['userBetPrefer'] = entity.userBetPrefer;
  data['userLevel'] = entity.userLevel;
  data['userMarketPrefer'] = entity.userMarketPrefer;
  data['username'] = entity.username;
  data['vipLevel'] = entity.vipLevel;
  return data;
}

extension SetUserLanguageDataExtension on SetUserLanguageData {
  SetUserLanguageData copyWith({
    dynamic createTime,
    String? createUser,
    String? currencyCode,
    dynamic delFlag,
    dynamic disabled,
    dynamic esMarketLevel,
    dynamic financeTag,
    String? ipAddress,
    dynamic isTest,
    String? languageName,
    dynamic marketLevel,
    String? merchantCode,
    String? modifyTime,
    String? modifyUser,
    String? password,
    String? realName,
    String? remark,
    dynamic settleInAdvance,
    dynamic specialBettingLimitDelayTime,
    String? specialBettingLimitRemark,
    dynamic specialBettingLimitTime,
    dynamic specialBettingLimitType,
    String? uid,
    dynamic userBetPrefer,
    dynamic userLevel,
    String? userMarketPrefer,
    String? username,
    dynamic vipLevel,
  }) {
    return SetUserLanguageData()
      ..createTime = createTime ?? this.createTime
      ..createUser = createUser ?? this.createUser
      ..currencyCode = currencyCode ?? this.currencyCode
      ..delFlag = delFlag ?? this.delFlag
      ..disabled = disabled ?? this.disabled
      ..esMarketLevel = esMarketLevel ?? this.esMarketLevel
      ..financeTag = financeTag ?? this.financeTag
      ..ipAddress = ipAddress ?? this.ipAddress
      ..isTest = isTest ?? this.isTest
      ..languageName = languageName ?? this.languageName
      ..marketLevel = marketLevel ?? this.marketLevel
      ..merchantCode = merchantCode ?? this.merchantCode
      ..modifyTime = modifyTime ?? this.modifyTime
      ..modifyUser = modifyUser ?? this.modifyUser
      ..password = password ?? this.password
      ..realName = realName ?? this.realName
      ..remark = remark ?? this.remark
      ..settleInAdvance = settleInAdvance ?? this.settleInAdvance
      ..specialBettingLimitDelayTime = specialBettingLimitDelayTime ??
          this.specialBettingLimitDelayTime
      ..specialBettingLimitRemark = specialBettingLimitRemark ??
          this.specialBettingLimitRemark
      ..specialBettingLimitTime = specialBettingLimitTime ??
          this.specialBettingLimitTime
      ..specialBettingLimitType = specialBettingLimitType ??
          this.specialBettingLimitType
      ..uid = uid ?? this.uid
      ..userBetPrefer = userBetPrefer ?? this.userBetPrefer
      ..userLevel = userLevel ?? this.userLevel
      ..userMarketPrefer = userMarketPrefer ?? this.userMarketPrefer
      ..username = username ?? this.username
      ..vipLevel = vipLevel ?? this.vipLevel;
  }
}