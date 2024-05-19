import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/get_user_customize_info_entity.dart';

GetUserCustomizeInfoEntity $GetUserCustomizeInfoEntityFromJson(
    Map<String, dynamic> json) {
  final GetUserCustomizeInfoEntity getUserCustomizeInfoEntity = GetUserCustomizeInfoEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    getUserCustomizeInfoEntity.code = code;
  }
  final GetUserCustomizeInfoData? data = jsonConvert.convert<
      GetUserCustomizeInfoData>(json['data']);
  if (data != null) {
    getUserCustomizeInfoEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    getUserCustomizeInfoEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    getUserCustomizeInfoEntity.ts = ts;
  }
  return getUserCustomizeInfoEntity;
}

Map<String, dynamic> $GetUserCustomizeInfoEntityToJson(
    GetUserCustomizeInfoEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.toJson();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension GetUserCustomizeInfoEntityExtension on GetUserCustomizeInfoEntity {
  GetUserCustomizeInfoEntity copyWith({
    String? code,
    GetUserCustomizeInfoData? data,
    String? msg,
    int? ts,
  }) {
    return GetUserCustomizeInfoEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

GetUserCustomizeInfoData $GetUserCustomizeInfoDataFromJson(
    Map<String, dynamic> json) {
  final GetUserCustomizeInfoData getUserCustomizeInfoData = GetUserCustomizeInfoData();
  final dynamic fastBetAmount = json['fastBetAmount'];
  if (fastBetAmount != null) {
    getUserCustomizeInfoData.fastBetAmount = fastBetAmount;
  }
  final dynamic firstTime = json['firstTime'];
  if (firstTime != null) {
    getUserCustomizeInfoData.firstTime = firstTime;
  }
  final List<int>? seriesList = (json['seriesList'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<int>(e) as int).toList();
  if (seriesList != null) {
    getUserCustomizeInfoData.seriesList = seriesList;
  }
  final List<int>? singleList = (json['singleList'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<int>(e) as int).toList();
  if (singleList != null) {
    getUserCustomizeInfoData.singleList = singleList;
  }
  final bool? switchOn = jsonConvert.convert<bool>(json['switchOn']);
  if (switchOn != null) {
    getUserCustomizeInfoData.switchOn = switchOn;
  }
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    getUserCustomizeInfoData.type = type;
  }
  return getUserCustomizeInfoData;
}

Map<String, dynamic> $GetUserCustomizeInfoDataToJson(
    GetUserCustomizeInfoData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['fastBetAmount'] = entity.fastBetAmount;
  data['firstTime'] = entity.firstTime;
  data['seriesList'] = entity.seriesList;
  data['singleList'] = entity.singleList;
  data['switchOn'] = entity.switchOn;
  data['type'] = entity.type;
  return data;
}

extension GetUserCustomizeInfoDataExtension on GetUserCustomizeInfoData {
  GetUserCustomizeInfoData copyWith({
    dynamic fastBetAmount,
    dynamic firstTime,
    List<int>? seriesList,
    List<int>? singleList,
    bool? switchOn,
    String? type,
  }) {
    return GetUserCustomizeInfoData()
      ..fastBetAmount = fastBetAmount ?? this.fastBetAmount
      ..firstTime = firstTime ?? this.firstTime
      ..seriesList = seriesList ?? this.seriesList
      ..singleList = singleList ?? this.singleList
      ..switchOn = switchOn ?? this.switchOn
      ..type = type ?? this.type;
  }
}