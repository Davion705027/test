import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/login_panda_entity.dart';

LoginPandaEntity $LoginPandaEntityFromJson(Map<String, dynamic> json) {
  final LoginPandaEntity loginPandaEntity = LoginPandaEntity();
  final bool? status = jsonConvert.convert<bool>(json['status']);
  if (status != null) {
    loginPandaEntity.status = status;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    loginPandaEntity.msg = msg;
  }
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    loginPandaEntity.code = code;
  }
  final LoginPandaData? data = jsonConvert.convert<LoginPandaData>(
      json['data']);
  if (data != null) {
    loginPandaEntity.data = data;
  }
  final int? serverTime = jsonConvert.convert<int>(json['serverTime']);
  if (serverTime != null) {
    loginPandaEntity.serverTime = serverTime;
  }
  return loginPandaEntity;
}

Map<String, dynamic> $LoginPandaEntityToJson(LoginPandaEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['msg'] = entity.msg;
  data['code'] = entity.code;
  data['data'] = entity.data.toJson();
  data['serverTime'] = entity.serverTime;
  return data;
}

extension LoginPandaEntityExtension on LoginPandaEntity {
  LoginPandaEntity copyWith({
    bool? status,
    String? msg,
    String? code,
    LoginPandaData? data,
    int? serverTime,
  }) {
    return LoginPandaEntity()
      ..status = status ?? this.status
      ..msg = msg ?? this.msg
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..serverTime = serverTime ?? this.serverTime;
  }
}

LoginPandaData $LoginPandaDataFromJson(Map<String, dynamic> json) {
  final LoginPandaData loginPandaData = LoginPandaData();
  final List<String>? loginUrlArr = (json['loginUrlArr'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<String>(e) as String)
      .toList();
  if (loginUrlArr != null) {
    loginPandaData.loginUrlArr = loginUrlArr;
  }
  final String? loginUrl = jsonConvert.convert<String>(json['loginUrl']);
  if (loginUrl != null) {
    loginPandaData.loginUrl = loginUrl;
  }
  final String? domain = jsonConvert.convert<String>(json['domain']);
  if (domain != null) {
    loginPandaData.domain = domain;
  }
  final String? token = jsonConvert.convert<String>(json['token']);
  if (token != null) {
    loginPandaData.token = token;
  }
  return loginPandaData;
}

Map<String, dynamic> $LoginPandaDataToJson(LoginPandaData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['loginUrlArr'] = entity.loginUrlArr;
  data['loginUrl'] = entity.loginUrl;
  data['domain'] = entity.domain;
  data['token'] = entity.token;
  return data;
}

extension LoginPandaDataExtension on LoginPandaData {
  LoginPandaData copyWith({
    List<String>? loginUrlArr,
    String? loginUrl,
    String? domain,
    String? token,
  }) {
    return LoginPandaData()
      ..loginUrlArr = loginUrlArr ?? this.loginUrlArr
      ..loginUrl = loginUrl ?? this.loginUrl
      ..domain = domain ?? this.domain
      ..token = token ?? this.token;
  }
}