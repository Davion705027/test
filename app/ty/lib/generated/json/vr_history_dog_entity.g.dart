import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_history_dog_entity.dart';

VrHistoryDogEntity $VrHistoryDogEntityFromJson(Map<String, dynamic> json) {
  final VrHistoryDogEntity vrHistoryDogEntity = VrHistoryDogEntity();
  final String? number = jsonConvert.convert<String>(json['number']);
  if (number != null) {
    vrHistoryDogEntity.number = number;
  }
  final int? form = jsonConvert.convert<int>(json['form']);
  if (form != null) {
    vrHistoryDogEntity.form = form;
  }
  final String? star = jsonConvert.convert<String>(json['star']);
  if (star != null) {
    vrHistoryDogEntity.star = star;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    vrHistoryDogEntity.name = name;
  }
  final List<int>? forecast = (json['forecast'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<int>(e) as int).toList();
  if (forecast != null) {
    vrHistoryDogEntity.forecast = forecast;
  }
  return vrHistoryDogEntity;
}

Map<String, dynamic> $VrHistoryDogEntityToJson(VrHistoryDogEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['number'] = entity.number;
  data['form'] = entity.form;
  data['star'] = entity.star;
  data['name'] = entity.name;
  data['forecast'] = entity.forecast;
  return data;
}

extension VrHistoryDogEntityExtension on VrHistoryDogEntity {
  VrHistoryDogEntity copyWith({
    String? number,
    int? form,
    String? star,
    String? name,
    List<int>? forecast,
  }) {
    return VrHistoryDogEntity()
      ..number = number ?? this.number
      ..form = form ?? this.form
      ..star = star ?? this.star
      ..name = name ?? this.name
      ..forecast = forecast ?? this.forecast;
  }
}