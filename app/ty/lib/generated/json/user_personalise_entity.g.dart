import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/user_personalise_entity.dart';

UserPersonaliseEntity $UserPersonaliseEntityFromJson(
    Map<String, dynamic> json) {
  final UserPersonaliseEntity userPersonaliseEntity = UserPersonaliseEntity();
  final String? addHandicap = jsonConvert.convert<String>(json['addHandicap']);
  if (addHandicap != null) {
    userPersonaliseEntity.addHandicap = addHandicap;
  }
  final String? handicapType = jsonConvert.convert<String>(
      json['handicapType']);
  if (handicapType != null) {
    userPersonaliseEntity.handicapType = handicapType;
  }
  final String? isHk = jsonConvert.convert<String>(json['isHk']);
  if (isHk != null) {
    userPersonaliseEntity.isHk = isHk;
  }
  final String? playAdName = jsonConvert.convert<String>(json['playAdName']);
  if (playAdName != null) {
    userPersonaliseEntity.playAdName = playAdName;
  }
  final String? playAdNameCg = jsonConvert.convert<String>(
      json['playAdNameCg']);
  if (playAdNameCg != null) {
    userPersonaliseEntity.playAdNameCg = playAdNameCg;
  }
  final String? popUps = jsonConvert.convert<String>(json['popUps']);
  if (popUps != null) {
    userPersonaliseEntity.popUps = popUps;
  }
  final String? skinMode = jsonConvert.convert<String>(json['skinMode']);
  if (skinMode != null) {
    userPersonaliseEntity.skinMode = skinMode;
  }
  final String? toAccept = jsonConvert.convert<String>(json['toAccept']);
  if (toAccept != null) {
    userPersonaliseEntity.toAccept = toAccept;
  }
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    userPersonaliseEntity.userId = userId;
  }
  final String? userLanguage = jsonConvert.convert<String>(
      json['userLanguage']);
  if (userLanguage != null) {
    userPersonaliseEntity.userLanguage = userLanguage;
  }
  final String? userVersion = jsonConvert.convert<String>(json['userVersion']);
  if (userVersion != null) {
    userPersonaliseEntity.userVersion = userVersion;
  }
  return userPersonaliseEntity;
}

Map<String, dynamic> $UserPersonaliseEntityToJson(
    UserPersonaliseEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['addHandicap'] = entity.addHandicap;
  data['handicapType'] = entity.handicapType;
  data['isHk'] = entity.isHk;
  data['playAdName'] = entity.playAdName;
  data['playAdNameCg'] = entity.playAdNameCg;
  data['popUps'] = entity.popUps;
  data['skinMode'] = entity.skinMode;
  data['toAccept'] = entity.toAccept;
  data['userId'] = entity.userId;
  data['userLanguage'] = entity.userLanguage;
  data['userVersion'] = entity.userVersion;
  return data;
}

extension UserPersonaliseEntityExtension on UserPersonaliseEntity {
  UserPersonaliseEntity copyWith({
    String? addHandicap,
    String? handicapType,
    String? isHk,
    String? playAdName,
    String? playAdNameCg,
    String? popUps,
    String? skinMode,
    String? toAccept,
    String? userId,
    String? userLanguage,
    String? userVersion,
  }) {
    return UserPersonaliseEntity()
      ..addHandicap = addHandicap ?? this.addHandicap
      ..handicapType = handicapType ?? this.handicapType
      ..isHk = isHk ?? this.isHk
      ..playAdName = playAdName ?? this.playAdName
      ..playAdNameCg = playAdNameCg ?? this.playAdNameCg
      ..popUps = popUps ?? this.popUps
      ..skinMode = skinMode ?? this.skinMode
      ..toAccept = toAccept ?? this.toAccept
      ..userId = userId ?? this.userId
      ..userLanguage = userLanguage ?? this.userLanguage
      ..userVersion = userVersion ?? this.userVersion;
  }
}