import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/match_lineup_entity.dart';

MatchLineupEntity $MatchLineupEntityFromJson(Map<String, dynamic> json) {
  final MatchLineupEntity matchLineupEntity = MatchLineupEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    matchLineupEntity.code = code;
  }
  final MatchLineupData? data = jsonConvert.convert<MatchLineupData>(
      json['data']);
  if (data != null) {
    matchLineupEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    matchLineupEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    matchLineupEntity.ts = ts;
  }
  return matchLineupEntity;
}

Map<String, dynamic> $MatchLineupEntityToJson(MatchLineupEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data?.toJson();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension MatchLineupEntityExtension on MatchLineupEntity {
  MatchLineupEntity copyWith({
    String? code,
    MatchLineupData? data,
    String? msg,
    int? ts,
  }) {
    return MatchLineupEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

MatchLineupData $MatchLineupDataFromJson(Map<String, dynamic> json) {
  final MatchLineupData matchLineupData = MatchLineupData();
  final String? homeFormation = jsonConvert.convert<String>(
      json['homeFormation']);
  if (homeFormation != null) {
    matchLineupData.homeFormation = homeFormation;
  }
  final List<MatchLineupDataUp>? up = (json['up'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<MatchLineupDataUp>(e) as MatchLineupDataUp)
      .toList();
  if (up != null) {
    matchLineupData.up = up;
  }
  final List<MatchLineupDataDown>? down = (json['down'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<MatchLineupDataDown>(e) as MatchLineupDataDown)
      .toList();
  if (down != null) {
    matchLineupData.down = down;
  }
  return matchLineupData;
}

Map<String, dynamic> $MatchLineupDataToJson(MatchLineupData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['homeFormation'] = entity.homeFormation;
  data['up'] = entity.up?.map((v) => v.toJson()).toList();
  data['down'] = entity.down?.map((v) => v.toJson()).toList();
  return data;
}

extension MatchLineupDataExtension on MatchLineupData {
  MatchLineupData copyWith({
    String? homeFormation,
    List<MatchLineupDataUp>? up,
    List<MatchLineupDataDown>? down,
  }) {
    return MatchLineupData()
      ..homeFormation = homeFormation ?? this.homeFormation
      ..up = up ?? this.up
      ..down = down ?? this.down;
  }
}

MatchLineupDataUp $MatchLineupDataUpFromJson(Map<String, dynamic> json) {
  final MatchLineupDataUp matchLineupDataUp = MatchLineupDataUp();
  final String? awayFormation = jsonConvert.convert<String>(
      json['awayFormation']);
  if (awayFormation != null) {
    matchLineupDataUp.awayFormation = awayFormation;
  }
  final String? createTime = jsonConvert.convert<String>(json['createTime']);
  if (createTime != null) {
    matchLineupDataUp.createTime = createTime;
  }
  final String? dataSourceCode = jsonConvert.convert<String>(
      json['dataSourceCode']);
  if (dataSourceCode != null) {
    matchLineupDataUp.dataSourceCode = dataSourceCode;
  }
  final int? homeAway = jsonConvert.convert<int>(json['homeAway']);
  if (homeAway != null) {
    matchLineupDataUp.homeAway = homeAway;
  }
  final String? homeFormation = jsonConvert.convert<String>(
      json['homeFormation']);
  if (homeFormation != null) {
    matchLineupDataUp.homeFormation = homeFormation;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    matchLineupDataUp.id = id;
  }
  final int? invalid = jsonConvert.convert<int>(json['invalid']);
  if (invalid != null) {
    matchLineupDataUp.invalid = invalid;
  }
  final String? matchInfoId = jsonConvert.convert<String>(json['matchInfoId']);
  if (matchInfoId != null) {
    matchLineupDataUp.matchInfoId = matchInfoId;
  }
  final String? modifyTime = jsonConvert.convert<String>(json['modifyTime']);
  if (modifyTime != null) {
    matchLineupDataUp.modifyTime = modifyTime;
  }
  final int? position = jsonConvert.convert<int>(json['position']);
  if (position != null) {
    matchLineupDataUp.position = position;
  }
  final String? positionEnName = jsonConvert.convert<String>(
      json['positionEnName']);
  if (positionEnName != null) {
    matchLineupDataUp.positionEnName = positionEnName;
  }
  final String? positionName = jsonConvert.convert<String>(
      json['positionName']);
  if (positionName != null) {
    matchLineupDataUp.positionName = positionName;
  }
  final dynamic shirtNumber = json['shirtNumber'];
  if (shirtNumber != null) {
    matchLineupDataUp.shirtNumber = shirtNumber;
  }
  final String? sportId = jsonConvert.convert<String>(json['sportId']);
  if (sportId != null) {
    matchLineupDataUp.sportId = sportId;
  }
  final int? substitute = jsonConvert.convert<int>(json['substitute']);
  if (substitute != null) {
    matchLineupDataUp.substitute = substitute;
  }
  final String? thirdPlayerEnName = jsonConvert.convert<String>(
      json['thirdPlayerEnName']);
  if (thirdPlayerEnName != null) {
    matchLineupDataUp.thirdPlayerEnName = thirdPlayerEnName;
  }
  final String? thirdPlayerName = jsonConvert.convert<String>(
      json['thirdPlayerName']);
  if (thirdPlayerName != null) {
    matchLineupDataUp.thirdPlayerName = thirdPlayerName;
  }
  final String? thirdPlayerPicUrl = jsonConvert.convert<String>(
      json['thirdPlayerPicUrl']);
  if (thirdPlayerPicUrl != null) {
    matchLineupDataUp.thirdPlayerPicUrl = thirdPlayerPicUrl;
  }
  final String? thirdPlayerSourceId = jsonConvert.convert<String>(
      json['thirdPlayerSourceId']);
  if (thirdPlayerSourceId != null) {
    matchLineupDataUp.thirdPlayerSourceId = thirdPlayerSourceId;
  }
  final String? thirdTeamSourceId = jsonConvert.convert<String>(
      json['thirdTeamSourceId']);
  if (thirdTeamSourceId != null) {
    matchLineupDataUp.thirdTeamSourceId = thirdTeamSourceId;
  }
  return matchLineupDataUp;
}

Map<String, dynamic> $MatchLineupDataUpToJson(MatchLineupDataUp entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['awayFormation'] = entity.awayFormation;
  data['createTime'] = entity.createTime;
  data['dataSourceCode'] = entity.dataSourceCode;
  data['homeAway'] = entity.homeAway;
  data['homeFormation'] = entity.homeFormation;
  data['id'] = entity.id;
  data['invalid'] = entity.invalid;
  data['matchInfoId'] = entity.matchInfoId;
  data['modifyTime'] = entity.modifyTime;
  data['position'] = entity.position;
  data['positionEnName'] = entity.positionEnName;
  data['positionName'] = entity.positionName;
  data['shirtNumber'] = entity.shirtNumber;
  data['sportId'] = entity.sportId;
  data['substitute'] = entity.substitute;
  data['thirdPlayerEnName'] = entity.thirdPlayerEnName;
  data['thirdPlayerName'] = entity.thirdPlayerName;
  data['thirdPlayerPicUrl'] = entity.thirdPlayerPicUrl;
  data['thirdPlayerSourceId'] = entity.thirdPlayerSourceId;
  data['thirdTeamSourceId'] = entity.thirdTeamSourceId;
  return data;
}

extension MatchLineupDataUpExtension on MatchLineupDataUp {
  MatchLineupDataUp copyWith({
    String? awayFormation,
    String? createTime,
    String? dataSourceCode,
    int? homeAway,
    String? homeFormation,
    String? id,
    int? invalid,
    String? matchInfoId,
    String? modifyTime,
    int? position,
    String? positionEnName,
    String? positionName,
    dynamic shirtNumber,
    String? sportId,
    int? substitute,
    String? thirdPlayerEnName,
    String? thirdPlayerName,
    String? thirdPlayerPicUrl,
    String? thirdPlayerSourceId,
    String? thirdTeamSourceId,
  }) {
    return MatchLineupDataUp()
      ..awayFormation = awayFormation ?? this.awayFormation
      ..createTime = createTime ?? this.createTime
      ..dataSourceCode = dataSourceCode ?? this.dataSourceCode
      ..homeAway = homeAway ?? this.homeAway
      ..homeFormation = homeFormation ?? this.homeFormation
      ..id = id ?? this.id
      ..invalid = invalid ?? this.invalid
      ..matchInfoId = matchInfoId ?? this.matchInfoId
      ..modifyTime = modifyTime ?? this.modifyTime
      ..position = position ?? this.position
      ..positionEnName = positionEnName ?? this.positionEnName
      ..positionName = positionName ?? this.positionName
      ..shirtNumber = shirtNumber ?? this.shirtNumber
      ..sportId = sportId ?? this.sportId
      ..substitute = substitute ?? this.substitute
      ..thirdPlayerEnName = thirdPlayerEnName ?? this.thirdPlayerEnName
      ..thirdPlayerName = thirdPlayerName ?? this.thirdPlayerName
      ..thirdPlayerPicUrl = thirdPlayerPicUrl ?? this.thirdPlayerPicUrl
      ..thirdPlayerSourceId = thirdPlayerSourceId ?? this.thirdPlayerSourceId
      ..thirdTeamSourceId = thirdTeamSourceId ?? this.thirdTeamSourceId;
  }
}

MatchLineupDataDown $MatchLineupDataDownFromJson(Map<String, dynamic> json) {
  final MatchLineupDataDown matchLineupDataDown = MatchLineupDataDown();
  final String? awayFormation = jsonConvert.convert<String>(
      json['awayFormation']);
  if (awayFormation != null) {
    matchLineupDataDown.awayFormation = awayFormation;
  }
  final String? createTime = jsonConvert.convert<String>(json['createTime']);
  if (createTime != null) {
    matchLineupDataDown.createTime = createTime;
  }
  final String? dataSourceCode = jsonConvert.convert<String>(
      json['dataSourceCode']);
  if (dataSourceCode != null) {
    matchLineupDataDown.dataSourceCode = dataSourceCode;
  }
  final int? homeAway = jsonConvert.convert<int>(json['homeAway']);
  if (homeAway != null) {
    matchLineupDataDown.homeAway = homeAway;
  }
  final String? homeFormation = jsonConvert.convert<String>(
      json['homeFormation']);
  if (homeFormation != null) {
    matchLineupDataDown.homeFormation = homeFormation;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    matchLineupDataDown.id = id;
  }
  final int? invalid = jsonConvert.convert<int>(json['invalid']);
  if (invalid != null) {
    matchLineupDataDown.invalid = invalid;
  }
  final String? matchInfoId = jsonConvert.convert<String>(json['matchInfoId']);
  if (matchInfoId != null) {
    matchLineupDataDown.matchInfoId = matchInfoId;
  }
  final String? modifyTime = jsonConvert.convert<String>(json['modifyTime']);
  if (modifyTime != null) {
    matchLineupDataDown.modifyTime = modifyTime;
  }
  final int? position = jsonConvert.convert<int>(json['position']);
  if (position != null) {
    matchLineupDataDown.position = position;
  }
  final String? positionEnName = jsonConvert.convert<String>(
      json['positionEnName']);
  if (positionEnName != null) {
    matchLineupDataDown.positionEnName = positionEnName;
  }
  final String? positionName = jsonConvert.convert<String>(
      json['positionName']);
  if (positionName != null) {
    matchLineupDataDown.positionName = positionName;
  }
  final dynamic shirtNumber = json['shirtNumber'];
  if (shirtNumber != null) {
    matchLineupDataDown.shirtNumber = shirtNumber;
  }
  final String? sportId = jsonConvert.convert<String>(json['sportId']);
  if (sportId != null) {
    matchLineupDataDown.sportId = sportId;
  }
  final int? substitute = jsonConvert.convert<int>(json['substitute']);
  if (substitute != null) {
    matchLineupDataDown.substitute = substitute;
  }
  final String? thirdPlayerEnName = jsonConvert.convert<String>(
      json['thirdPlayerEnName']);
  if (thirdPlayerEnName != null) {
    matchLineupDataDown.thirdPlayerEnName = thirdPlayerEnName;
  }
  final String? thirdPlayerName = jsonConvert.convert<String>(
      json['thirdPlayerName']);
  if (thirdPlayerName != null) {
    matchLineupDataDown.thirdPlayerName = thirdPlayerName;
  }
  final String? thirdPlayerPicUrl = jsonConvert.convert<String>(
      json['thirdPlayerPicUrl']);
  if (thirdPlayerPicUrl != null) {
    matchLineupDataDown.thirdPlayerPicUrl = thirdPlayerPicUrl;
  }
  final String? thirdPlayerSourceId = jsonConvert.convert<String>(
      json['thirdPlayerSourceId']);
  if (thirdPlayerSourceId != null) {
    matchLineupDataDown.thirdPlayerSourceId = thirdPlayerSourceId;
  }
  final String? thirdTeamSourceId = jsonConvert.convert<String>(
      json['thirdTeamSourceId']);
  if (thirdTeamSourceId != null) {
    matchLineupDataDown.thirdTeamSourceId = thirdTeamSourceId;
  }
  return matchLineupDataDown;
}

Map<String, dynamic> $MatchLineupDataDownToJson(MatchLineupDataDown entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['awayFormation'] = entity.awayFormation;
  data['createTime'] = entity.createTime;
  data['dataSourceCode'] = entity.dataSourceCode;
  data['homeAway'] = entity.homeAway;
  data['homeFormation'] = entity.homeFormation;
  data['id'] = entity.id;
  data['invalid'] = entity.invalid;
  data['matchInfoId'] = entity.matchInfoId;
  data['modifyTime'] = entity.modifyTime;
  data['position'] = entity.position;
  data['positionEnName'] = entity.positionEnName;
  data['positionName'] = entity.positionName;
  data['shirtNumber'] = entity.shirtNumber;
  data['sportId'] = entity.sportId;
  data['substitute'] = entity.substitute;
  data['thirdPlayerEnName'] = entity.thirdPlayerEnName;
  data['thirdPlayerName'] = entity.thirdPlayerName;
  data['thirdPlayerPicUrl'] = entity.thirdPlayerPicUrl;
  data['thirdPlayerSourceId'] = entity.thirdPlayerSourceId;
  data['thirdTeamSourceId'] = entity.thirdTeamSourceId;
  return data;
}

extension MatchLineupDataDownExtension on MatchLineupDataDown {
  MatchLineupDataDown copyWith({
    String? awayFormation,
    String? createTime,
    String? dataSourceCode,
    int? homeAway,
    String? homeFormation,
    String? id,
    int? invalid,
    String? matchInfoId,
    String? modifyTime,
    int? position,
    String? positionEnName,
    String? positionName,
    dynamic shirtNumber,
    String? sportId,
    int? substitute,
    String? thirdPlayerEnName,
    String? thirdPlayerName,
    String? thirdPlayerPicUrl,
    String? thirdPlayerSourceId,
    String? thirdTeamSourceId,
  }) {
    return MatchLineupDataDown()
      ..awayFormation = awayFormation ?? this.awayFormation
      ..createTime = createTime ?? this.createTime
      ..dataSourceCode = dataSourceCode ?? this.dataSourceCode
      ..homeAway = homeAway ?? this.homeAway
      ..homeFormation = homeFormation ?? this.homeFormation
      ..id = id ?? this.id
      ..invalid = invalid ?? this.invalid
      ..matchInfoId = matchInfoId ?? this.matchInfoId
      ..modifyTime = modifyTime ?? this.modifyTime
      ..position = position ?? this.position
      ..positionEnName = positionEnName ?? this.positionEnName
      ..positionName = positionName ?? this.positionName
      ..shirtNumber = shirtNumber ?? this.shirtNumber
      ..sportId = sportId ?? this.sportId
      ..substitute = substitute ?? this.substitute
      ..thirdPlayerEnName = thirdPlayerEnName ?? this.thirdPlayerEnName
      ..thirdPlayerName = thirdPlayerName ?? this.thirdPlayerName
      ..thirdPlayerPicUrl = thirdPlayerPicUrl ?? this.thirdPlayerPicUrl
      ..thirdPlayerSourceId = thirdPlayerSourceId ?? this.thirdPlayerSourceId
      ..thirdTeamSourceId = thirdTeamSourceId ?? this.thirdTeamSourceId;
  }
}