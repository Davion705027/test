import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/set_user_language_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/set_user_language_entity.g.dart';

@JsonSerializable()
class SetUserLanguageEntity {
	late String code;
	late SetUserLanguageData data;
	late String msg;
	late int ts;

	SetUserLanguageEntity();

	factory SetUserLanguageEntity.fromJson(Map<String, dynamic> json) => $SetUserLanguageEntityFromJson(json);

	Map<String, dynamic> toJson() => $SetUserLanguageEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class SetUserLanguageData {
	dynamic createTime;
	late String createUser;
	late String currencyCode;
	dynamic delFlag;
	dynamic disabled;
	dynamic esMarketLevel;
	dynamic financeTag;
	late String ipAddress;
	dynamic isTest;
	late String languageName;
	dynamic marketLevel;
	late String merchantCode;
	late String modifyTime;
	late String modifyUser;
	late String password;
	late String realName;
	late String remark;
	dynamic settleInAdvance;
	dynamic specialBettingLimitDelayTime;
	late String specialBettingLimitRemark;
	dynamic specialBettingLimitTime;
	dynamic specialBettingLimitType;
	late String uid;
	dynamic userBetPrefer;
	dynamic userLevel;
	late String userMarketPrefer;
	late String username;
	dynamic vipLevel;

	SetUserLanguageData();

	factory SetUserLanguageData.fromJson(Map<String, dynamic> json) => $SetUserLanguageDataFromJson(json);

	Map<String, dynamic> toJson() => $SetUserLanguageDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}