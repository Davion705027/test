import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/get_filter_match_list_new_entity.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/league_filter/league_filter_controller.dart';


GetFilterMatchListNewEntity $GetFilterMatchListNewEntityFromJson(
    Map<String, dynamic> json) {
  final GetFilterMatchListNewEntity getFilterMatchListNewEntity = GetFilterMatchListNewEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    getFilterMatchListNewEntity.code = code;
  }
  final List<GetFilterMatchListNewData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<GetFilterMatchListNewData>(
          e) as GetFilterMatchListNewData)
      .toList();
  if (data != null) {
    getFilterMatchListNewEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    getFilterMatchListNewEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    getFilterMatchListNewEntity.ts = ts;
  }
  return getFilterMatchListNewEntity;
}

Map<String, dynamic> $GetFilterMatchListNewEntityToJson(
    GetFilterMatchListNewEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension GetFilterMatchListNewEntityExtension on GetFilterMatchListNewEntity {
  GetFilterMatchListNewEntity copyWith({
    String? code,
    List<GetFilterMatchListNewData>? data,
    String? msg,
    int? ts,
  }) {
    return GetFilterMatchListNewEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

GetFilterMatchListNewData $GetFilterMatchListNewDataFromJson(
    Map<String, dynamic> json) {
  final GetFilterMatchListNewData getFilterMatchListNewData = GetFilterMatchListNewData();
  final int? hotStatus = jsonConvert.convert<int>(json['hotStatus']);
  if (hotStatus != null) {
    getFilterMatchListNewData.hotStatus = hotStatus;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    getFilterMatchListNewData.id = id;
  }
  final dynamic nameCode = json['nameCode'];
  if (nameCode != null) {
    getFilterMatchListNewData.nameCode = nameCode;
  }
  final String? nameText = jsonConvert.convert<String>(json['nameText']);
  if (nameText != null) {
    getFilterMatchListNewData.nameText = nameText;
  }
  final int? num = jsonConvert.convert<int>(json['num']);
  if (num != null) {
    getFilterMatchListNewData.num = num;
  }
  final String? picUrlthumb = jsonConvert.convert<String>(json['picUrlthumb']);
  if (picUrlthumb != null) {
    getFilterMatchListNewData.picUrlthumb = picUrlthumb;
  }
  final String? regionId = jsonConvert.convert<String>(json['regionId']);
  if (regionId != null) {
    getFilterMatchListNewData.regionId = regionId;
  }
  final String? spell = jsonConvert.convert<String>(json['spell']);
  if (spell != null) {
    getFilterMatchListNewData.spell = spell;
  }
  final String? sportId = jsonConvert.convert<String>(json['sportId']);
  if (sportId != null) {
    getFilterMatchListNewData.sportId = sportId;
  }
  final String? tournamentId = jsonConvert.convert<String>(
      json['tournamentId']);
  if (tournamentId != null) {
    getFilterMatchListNewData.tournamentId = tournamentId;
  }
  final int? tournamentLevel = jsonConvert.convert<int>(
      json['tournamentLevel']);
  if (tournamentLevel != null) {
    getFilterMatchListNewData.tournamentLevel = tournamentLevel;
  }
  final String? tournamentName = jsonConvert.convert<String>(
      json['tournamentName']);
  if (tournamentName != null) {
    getFilterMatchListNewData.tournamentName = tournamentName;
  }
  final bool? isSelect = jsonConvert.convert<bool>(json['isSelect']);
  if (isSelect != null) {
    getFilterMatchListNewData.isSelect = isSelect;
  }
  return getFilterMatchListNewData;
}

Map<String, dynamic> $GetFilterMatchListNewDataToJson(
    GetFilterMatchListNewData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['hotStatus'] = entity.hotStatus;
  data['id'] = entity.id;
  data['nameCode'] = entity.nameCode;
  data['nameText'] = entity.nameText;
  data['num'] = entity.num;
  data['picUrlthumb'] = entity.picUrlthumb;
  data['regionId'] = entity.regionId;
  data['spell'] = entity.spell;
  data['sportId'] = entity.sportId;
  data['tournamentId'] = entity.tournamentId;
  data['tournamentLevel'] = entity.tournamentLevel;
  data['tournamentName'] = entity.tournamentName;
  data['isSelect'] = entity.isSelect;
  return data;
}

extension GetFilterMatchListNewDataExtension on GetFilterMatchListNewData {
  GetFilterMatchListNewData copyWith({
    int? hotStatus,
    String? id,
    dynamic nameCode,
    String? nameText,
    int? num,
    String? picUrlthumb,
    String? regionId,
    String? spell,
    String? sportId,
    String? tournamentId,
    int? tournamentLevel,
    String? tournamentName,
    bool? isSelect,
    RenderGroupModel? parent,
  }) {
    return GetFilterMatchListNewData()
      ..hotStatus = hotStatus ?? this.hotStatus
      ..id = id ?? this.id
      ..nameCode = nameCode ?? this.nameCode
      ..nameText = nameText ?? this.nameText
      ..num = num ?? this.num
      ..picUrlthumb = picUrlthumb ?? this.picUrlthumb
      ..regionId = regionId ?? this.regionId
      ..spell = spell ?? this.spell
      ..sportId = sportId ?? this.sportId
      ..tournamentId = tournamentId ?? this.tournamentId
      ..tournamentLevel = tournamentLevel ?? this.tournamentLevel
      ..tournamentName = tournamentName ?? this.tournamentName
      ..isSelect = isSelect ?? this.isSelect
      ..parent = parent ?? this.parent;
  }
}