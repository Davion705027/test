import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/vr_history_dog_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/vr_history_dog_entity.g.dart';

@JsonSerializable()
class VrHistoryDogEntity {
	late String number;
	late int form;
	String? star;
	late String name;
	late List<int> forecast;

	VrHistoryDogEntity();

	factory VrHistoryDogEntity.fromJson(Map<String, dynamic> json) => $VrHistoryDogEntityFromJson(json);

	Map<String, dynamic> toJson() => $VrHistoryDogEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}