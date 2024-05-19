import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/item_disuse_entity.dart';

ItemDisuseEntity $ItemDisuseEntityFromJson(Map<String, dynamic> json) {
  final ItemDisuseEntity itemDisuseEntity = ItemDisuseEntity();
  final String? awayName = jsonConvert.convert<String>(json['awayName']);
  if (awayName != null) {
    itemDisuseEntity.awayName = awayName;
  }
  final String? awayNameCode = jsonConvert.convert<String>(
      json['awayNameCode']);
  if (awayNameCode != null) {
    itemDisuseEntity.awayNameCode = awayNameCode;
  }
  final String? awayScore = jsonConvert.convert<String>(json['awayScore']);
  if (awayScore != null) {
    itemDisuseEntity.awayScore = awayScore;
  }
  final String? homeName = jsonConvert.convert<String>(json['homeName']);
  if (homeName != null) {
    itemDisuseEntity.homeName = homeName;
  }
  final String? homeNameCode = jsonConvert.convert<String>(
      json['homeNameCode']);
  if (homeNameCode != null) {
    itemDisuseEntity.homeNameCode = homeNameCode;
  }
  final String? homeScore = jsonConvert.convert<String>(json['homeScore']);
  if (homeScore != null) {
    itemDisuseEntity.homeScore = homeScore;
  }
  final String? isSecond = jsonConvert.convert<String>(json['isSecond']);
  if (isSecond != null) {
    itemDisuseEntity.isSecond = isSecond;
  }
  final String? phase = jsonConvert.convert<String>(json['phase']);
  if (phase != null) {
    itemDisuseEntity.phase = phase;
  }
  final String? tournamentId = jsonConvert.convert<String>(
      json['tournamentId']);
  if (tournamentId != null) {
    itemDisuseEntity.tournamentId = tournamentId;
  }
  return itemDisuseEntity;
}

Map<String, dynamic> $ItemDisuseEntityToJson(ItemDisuseEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['awayName'] = entity.awayName;
  data['awayNameCode'] = entity.awayNameCode;
  data['awayScore'] = entity.awayScore;
  data['homeName'] = entity.homeName;
  data['homeNameCode'] = entity.homeNameCode;
  data['homeScore'] = entity.homeScore;
  data['isSecond'] = entity.isSecond;
  data['phase'] = entity.phase;
  data['tournamentId'] = entity.tournamentId;
  return data;
}

extension ItemDisuseEntityExtension on ItemDisuseEntity {
  ItemDisuseEntity copyWith({
    String? awayName,
    String? awayNameCode,
    String? awayScore,
    String? homeName,
    String? homeNameCode,
    String? homeScore,
    String? isSecond,
    String? phase,
    String? tournamentId,
  }) {
    return ItemDisuseEntity()
      ..awayName = awayName ?? this.awayName
      ..awayNameCode = awayNameCode ?? this.awayNameCode
      ..awayScore = awayScore ?? this.awayScore
      ..homeName = homeName ?? this.homeName
      ..homeNameCode = homeNameCode ?? this.homeNameCode
      ..homeScore = homeScore ?? this.homeScore
      ..isSecond = isSecond ?? this.isSecond
      ..phase = phase ?? this.phase
      ..tournamentId = tournamentId ?? this.tournamentId;
  }
}